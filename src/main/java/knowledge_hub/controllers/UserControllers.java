package knowledge_hub.controllers;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import knowledge_hub.models.CategoryDTO;
import knowledge_hub.models.LoginDTO;
import knowledge_hub.models.ReportsResponseDTO;
import knowledge_hub.models.UserRequestDTO;
import knowledge_hub.persistant.BlogRepository;
import knowledge_hub.persistant.Blogger_userRepository;
import knowledge_hub.persistant.OtherRepository;
import knowledge_hub.persistant.UserRepository;
import knowledge_hub.utils.ResultMessage;

@Controller
public class UserControllers {
	 
	private final UserRepository user_repo;

	public UserControllers(UserRepository user_repo) {
		this.user_repo = user_repo;
	}
	
	
	@GetMapping("/login") 
	public String login(@ModelAttribute("user") LoginDTO user , ModelMap m) {
		LoginDTO userr = user;
		if(userr == null) {
			userr = new LoginDTO();
		}
		m.addAttribute("user", userr);
		return "login";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute("user") @Validated LoginDTO user,BindingResult bResult,ModelMap m, HttpSession session,RedirectAttributes redirectAttributes) {
		if(user == null || user.getEmail() == ""|| user.getPassword() == "") {
			redirectAttributes.addFlashAttribute("message","Fill form's inputs");
			redirectAttributes.addFlashAttribute("user",user);
			return "redirect:/login";
		}
		if(bResult.hasErrors()) {
			redirectAttributes.addFlashAttribute("user",user);
			return "redirect:/login";
		}
		else {
			ResultMessage rm = user_repo.login(user, session);
			if(rm.getResult()== 0) {
				redirectAttributes.addFlashAttribute("user",user);
				redirectAttributes.addFlashAttribute("message",rm.getMessage());
				return "redirect:/login";
			}else {
				redirectAttributes.addFlashAttribute("message","Login Successfully");
				if((boolean)session.getAttribute("isSuper_Admin") || (boolean)session.getAttribute("isAdmin")) {
					redirectAttributes.addFlashAttribute("message",rm.getMessage());
					return "redirect:/admin_dashboard";
				}
				redirectAttributes.addFlashAttribute("message",rm.getMessage());
				return "redirect:/";
			}
		}
		
	}
	@GetMapping("/register")
	public String register(@ModelAttribute("user") UserRequestDTO user,ModelMap m) {
		m.addAttribute("user",new UserRequestDTO());
		return "register";
	}
	@PostMapping("/register")
	public String register(@ModelAttribute("user") @Validated UserRequestDTO user, BindingResult bResult, ModelMap m,RedirectAttributes redirectAttributes) {
		String password = user.getPassword();
		if(user.getName().isEmpty() || user.getEmail().isEmpty()|| user.getPassword().isEmpty()|| user.getDob().isEmpty()|| user.getGender()=="") {
			redirectAttributes.addFlashAttribute("error","Please fill the form"); 
			redirectAttributes.addFlashAttribute("user",user);
			redirectAttributes.addFlashAttribute("password",password);
			return "redirect:/register";
		}else if(user.getPassword().length() <8) {
			redirectAttributes.addFlashAttribute("message","Password must atleast 8 charactors.");
			redirectAttributes.addFlashAttribute("user",user);
			redirectAttributes.addFlashAttribute("password",password);
			return "redirect:/register";
		}
	    if(bResult.hasErrors()) {
	    	redirectAttributes.addFlashAttribute("message", "Register Error Occurred");
	    	redirectAttributes.addFlashAttribute("user",user);
	    	redirectAttributes.addFlashAttribute("password",password);
	        return "redirect:/register";
	    } else {
	        ResultMessage rm = user_repo.register(user);
	        if (rm.getResult() == 0) {
	        	redirectAttributes.addFlashAttribute("message", rm.getMessage());
	        	redirectAttributes.addFlashAttribute("user",user);
	        	redirectAttributes.addFlashAttribute("password",password);
	            return "redirect:/register";
	        }
	        redirectAttributes.addFlashAttribute("message", rm.getMessage());
	        return "redirect:/login";
	    }
	}
	
	@GetMapping("/admin_dashboard")
	public String users(HttpSession session,ModelMap m,RedirectAttributes redirectAttributes) {
		if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null &&  session.getAttribute("isSuper_Admin") == null ) {
			if(session.getAttribute("login") == null) {
				return "redirect:/";
			}
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/";
		}
		List<ReportsResponseDTO> reports = new OtherRepository().findAllReports();
		for(ReportsResponseDTO report : reports) {
			report.setBlog_id(new BlogRepository().findidbyCode(report.getBlog_code()));
		}
		m.addAttribute("category",new CategoryDTO());
		m.addAttribute("admin",new UserRequestDTO());
		m.addAttribute("bloggers",new Blogger_userRepository().findAllBloggerInfo());
		m.addAttribute("users",user_repo.findAllUsers());
		m.addAttribute("admins",user_repo.findAllAdmins());
		m.addAttribute("categories",new OtherRepository().findAllCategories());
		m.addAttribute("reports",reports);
	    m.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
		m.addAttribute("feedbacks",new OtherRepository().findAllFeedbacks());
		return "admin_dashbord";
	}
	
	@GetMapping("/add_Admin")
	public String add_Admin(HttpSession session,ModelMap model,RedirectAttributes redirectAttributes) {
		if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null && session.getAttribute("isSuper_Admin") == null ) {
			if(session.getAttribute("login") == null) {
				redirectAttributes.addFlashAttribute("message", "Please Login First");
				return "redirect:/";
			}
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/blogs";
		}
		model.addAttribute("admin",new UserRequestDTO());
		return "add_Admin";
	}
	@PostMapping("/add_Admin")
	public String add_Admin(@ModelAttribute("admin") @Validated UserRequestDTO admin, BindingResult bResult, ModelMap m,HttpSession session,RedirectAttributes redirectAttributes) {
		if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null && session.getAttribute("isSuper_Admin") == null ) {
			if(session.getAttribute("login") == null) {
				redirectAttributes.addFlashAttribute("message", "Please Login First");
				return "redirect:/";
			}
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/blogs";
		}
		String password = admin.getPassword();
		if(admin.getName().isEmpty() || admin.getEmail().isEmpty()|| admin.getPassword().isEmpty()|| admin.getDob().isEmpty()|| admin.getGender()=="") {
			m.addAttribute("error","Please fill the form");
			m.addAttribute("admin",admin);
			m.addAttribute("password",password);
			return "add_Admin";
		}
	    if(bResult.hasErrors()) {
	        m.addAttribute("message", "Register Error Occurred");
	        m.addAttribute("admin",admin);
	        m.addAttribute("password",password);
	        return "add_Admin";
	    }else if(Integer.parseInt(admin.getDob().split("-")[0]) > Calendar.getInstance().get(Calendar.YEAR) -18 ){
	    	m.addAttribute("message","Admin must be 18 years old");
	    	return"admin_dashboard";
	    }else {
	        ResultMessage rm = user_repo.addAdmin(admin);
	        if (rm.getResult() == 0) {
	            m.addAttribute("message", rm.getMessage());
	            m.addAttribute("admin",admin);
	            m.addAttribute("password",password);
	            return "add_Admin";
	        }
	        m.addAttribute("message", rm.getMessage());
	        return "redirect:/admin_dashboard";
	    }
	}
	
	@GetMapping("/user_detail/{id}")
	public String userdetail(@PathVariable int id,ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		model.addAttribute("user",user_repo.findUserById(id));
		model.addAttribute("postblogs",new BlogRepository().findpostBlogs(id));
		model.addAttribute("savedblogs",new BlogRepository().findsaveBlogsbyUserid(id));
		model.addAttribute("likedblogs",new BlogRepository().findLikeBlogsByuserid(id));
	    model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));

		return "user_profile";
	}
	@PostMapping("/user_detail/{id}")
	public String uploadProfile(@PathVariable int id, @RequestParam("file") MultipartFile file, ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) throws IOException {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		if((int)session.getAttribute("userId") != id) {
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/blogs";
		}
		if(file.isEmpty()) {			
			redirectAttributes.addFlashAttribute("message","Photo is empty");
			return "redirect:/user_detail/"+id;
		}
	    ResultMessage rm = user_repo.uploadProfile(file, id);
	    redirectAttributes.addFlashAttribute("message",rm.getMessage());
	    return "redirect:/user_detail/" + id;
	}
	@GetMapping("/user_detail/delete_photo/{id}")
	public String deleteProfile(@PathVariable int id,ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		if((int)session.getAttribute("userId") != id) {
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/blogs";
		}
		ResultMessage rm = user_repo.deleteProfile(id);
		redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/user_detail/"+id;
	}
	@GetMapping("logout")
	public String logout(HttpSession session,RedirectAttributes redirectAttributes) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		session.removeAttribute("login");
		session.removeAttribute("isAdmin");
		session.removeAttribute("isSuper_Admin");
		session.removeAttribute("role_name");
		session.removeAttribute("userId");
		session.removeAttribute("username");
		session.removeAttribute("useremails");
		redirectAttributes.addFlashAttribute("message","Logout Successfully");
		return "redirect:/";
	}
	
	@GetMapping("/changestatus")
	public String changestatus(HttpSession session,@RequestParam  int id,@RequestParam int status,RedirectAttributes redirectAttributes) {
		if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null && session.getAttribute("isSuper_Admin") == null ) {
			if(session.getAttribute("login") == null) {
				redirectAttributes.addFlashAttribute("message", "Please Login First");
				return "redirect:/";
			}
			
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/blogs";
		}
		ResultMessage rm = user_repo.changeStatus(status,id);
		redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/admin_dashboard";
	}
	@GetMapping("/forgetpassword")
	public String forgetpw(ModelMap model) {
		return "otpsender";
	}
	@GetMapping("/changepassword")
	public String changepw(HttpSession session) {
		session.removeAttribute("otp");
		session.removeAttribute("expirationTime");
		return "changepassword";
	}
	
	@PostMapping("/changepassword")
	public String changepw(HttpSession session,@RequestParam("pw") String pw,@RequestParam("cfpw") String cfpw, RedirectAttributes redirectAttributes) {
		String email = (String)session.getAttribute("email");
		if(pw.isEmpty() || pw == null) {
			redirectAttributes.addFlashAttribute("pw",pw);
			redirectAttributes.addFlashAttribute("cfpw",cfpw);
			redirectAttributes.addFlashAttribute("message","*Please fill the input");
			return "redirect:/changepassword";
		}else if(pw.length() < 8) {
			redirectAttributes.addFlashAttribute("pw",pw);
			redirectAttributes.addFlashAttribute("cfpw",cfpw);
			redirectAttributes.addFlashAttribute("message","*Password must be atleast 8");
			return "redirect:/changepassword";
		}
		
		ResultMessage rm = user_repo.changePassword(email,pw);
		if(rm.getResult() == 0) {
			redirectAttributes.addFlashAttribute("message",rm.getMessage());
			redirectAttributes.addFlashAttribute("pw",pw);
			redirectAttributes.addFlashAttribute("cfpw",cfpw);
			return "redirect:/changepassword";
		}else {
			redirectAttributes.addFlashAttribute("message",rm.getMessage());
			return "redirect:/login";
		}
	}
}
