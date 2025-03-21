package knowledge_hub.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import knowledge_hub.models.Blogger_userDTO;
import knowledge_hub.models.Blogger_userResponseDTO;
import knowledge_hub.persistant.Blogger_userRepository;
import knowledge_hub.persistant.UserRepository;
import knowledge_hub.utils.ResultMessage;

@Controller
public class BloggerControllers {
	

	private final Blogger_userRepository bloggerUser_repo;

	public BloggerControllers(Blogger_userRepository bloggerUser_repo) {
		this.bloggerUser_repo = bloggerUser_repo;
	}
	
	
	@GetMapping("/uploadform")
	public String blogger(@ModelAttribute("blogger") Blogger_userDTO blogger,ModelMap m,HttpSession session,RedirectAttributes redirectattributes){
		if(session.getAttribute("login") == null) {
			redirectattributes.addFlashAttribute("message","Please Log In First");
			return "redirect:/";
		}
		Blogger_userDTO bloggerr = blogger;
		if(bloggerr == null) {
			bloggerr = new Blogger_userDTO();
		}
	    m.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
		m.addAttribute("blogger", bloggerr);
		return "bloggerregister";
	}
	@PostMapping("/add_blogger")
	public String add_blogger(@ModelAttribute("blogger") @Validated Blogger_userDTO blogger, BindingResult bResult, ModelMap m,RedirectAttributes redirectAttributes,HttpSession session) {
		UserRepository user_repo = new UserRepository();
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		if(blogger.getName().isEmpty() || blogger.getEmail().isEmpty() || blogger.getAddress().isEmpty() || blogger.getEducation().isEmpty() || blogger.getPh_contact().isEmpty()) {
			redirectAttributes.addFlashAttribute("message","Please fill the form");
			redirectAttributes.addFlashAttribute("blogger",blogger);
			return "redirect:/uploadform";
		}
	    if(bResult.hasErrors()) {
	    	redirectAttributes.addFlashAttribute("message", "AddingBloggerInfo Error Occurred");
	        redirectAttributes.addFlashAttribute("blogger",blogger);
	        return "redirect:/uploadform";
	    }
	    if(user_repo.checkEmailAndGetName(blogger.getEmail()) == null) {
	    	redirectAttributes.addFlashAttribute("error","*Your email is not even exist in user");
	    	redirectAttributes.addFlashAttribute("blogger",blogger);
	    	return "redirect:/uploadform";
	    }else {
	        ResultMessage rm = bloggerUser_repo.addBloggerInfo(blogger,(int)session.getAttribute("userId"));
	        if (rm.getResult() == 0) {
	        	redirectAttributes.addFlashAttribute("message", rm.getMessage());
	        	redirectAttributes.addFlashAttribute("blogger",blogger);
	            return "redirect:/uploadform";
	        }
	        redirectAttributes.addFlashAttribute("message", rm.getMessage());
	        return "redirect:/blogs";
	    }
	}
	
	@GetMapping("/edit_blogger/{bloggerid}")
	public String edit_blogger(@PathVariable int bloggerid,ModelMap m,HttpSession session,RedirectAttributes redirectAttributes) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		m.addAttribute("blogger",bloggerUser_repo.findBloggerInfoDetail(bloggerid));
		return"edit_blogger";
	}
	@PostMapping("/edit_blogger/{userid}")
	public String edit_blogger(@PathVariable int userid,@ModelAttribute("blogger") @Validated Blogger_userDTO blogger, BindingResult bResult, ModelMap m,RedirectAttributes redirectAttributes,HttpSession session) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		if(blogger.getName().isEmpty() || blogger.getEmail().isEmpty() || blogger.getAddress().isEmpty() || blogger.getEducation().isEmpty() || blogger.getPh_contact().isEmpty()) {
			m.addAttribute("message","Please fill the form");
			m.addAttribute("blogger",blogger);
			return "edit_blogger";
		}
	    if(bResult.hasErrors()) {
	        m.addAttribute("message", "EditingBloggerInfo Error Occurred");
	        m.addAttribute("blogger",blogger);
	        return "edit_blogger";
	    } else {
	        ResultMessage rm = bloggerUser_repo.editBloggerInfo(blogger,userid);
	        if (rm.getResult() == 0) {
	            m.addAttribute("message", rm.getMessage());
	            m.addAttribute("blogger",blogger);
	            return "edit_blogger";
	        }
	        redirectAttributes.addFlashAttribute("message", rm.getMessage());
	        return "redirect:/admin_dashboard";
	    }
	}
	//Approve Blogger
    @GetMapping("/approve_blogger")
    public String approveBlogger(@RequestParam int user_id, RedirectAttributes redirectAttributes, HttpSession session) {
    	if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
        ResultMessage rm = bloggerUser_repo.ApproveBlogger(user_id);
        redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/admin_dashboard";
    }
    
    //Decline Blogger
    @GetMapping("/decline_blogger")
    public String declineBlogger(@RequestParam int bloggerid, RedirectAttributes redirectAttributes, HttpSession session) {
    	if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
        ResultMessage rm = bloggerUser_repo.deleteBloggerInfo(bloggerid);
        rm.setMessage("Reject user request Successfully");
        redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/admin_dashboard";
    }
    
    //Delete Blogger Info
    @GetMapping("/delete_blogger/{id}")
	public String delete(@PathVariable int id,HttpSession session,RedirectAttributes redirectAttributes) {
    	if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		ResultMessage rm = bloggerUser_repo.deleteBloggerInfo(id);
		redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/admin_dashboard";
	}
    
    @GetMapping("/detail_blogger")
    public String bloggerdetail(@RequestParam int bloggerid,@RequestParam int bloggerRole, ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
    	Blogger_userRepository blog_repo = new Blogger_userRepository();
    	Blogger_userResponseDTO  blogger =  blog_repo.findBloggerInfoDetail(bloggerid);
    	if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
    	if(session.getAttribute("login") != null) {
    		if(session.getAttribute("isAdmin") != null || session.getAttribute("isSuper_admin") != null) {
    			if(bloggerRole == 2) {
        			if(session.getAttribute("isSuper_Admin") == null) {
        				return "redirect:/admin_dashboard";
        			}else {
        				model.addAttribute("blogger",blogger);
        				model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
        				return "blogger_detail";
        			}
        		}else if(bloggerRole == 3) {
	        			model.addAttribute("blogger",blogger);
	        			model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
        				return "blogger_detail";
        		}
    		}
    	}
    	return "redirect:/";
    }
}
