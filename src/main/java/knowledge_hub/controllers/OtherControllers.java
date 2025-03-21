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

import knowledge_hub.models.CategoryDTO;
import knowledge_hub.persistant.Blogger_userRepository;
import knowledge_hub.persistant.OtherRepository;
import knowledge_hub.utils.ResultMessage;

@Controller
public class OtherControllers {
	
	private final OtherRepository other_repo;
	public OtherControllers(OtherRepository other_repo) {
		this.other_repo = other_repo;
	}
	  
	  
	  @PostMapping("/addcategory")
	  public String add(@ModelAttribute("category") @Validated CategoryDTO category,BindingResult bresult, ModelMap model,HttpSession session ,RedirectAttributes redirectAttributes) {
	    ResultMessage  rm;
	    if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null && session.getAttribute("isSuper_Admin") == null ) {
			if(session.getAttribute("login") == null) {
				redirectAttributes.addFlashAttribute("message", "Please Login First");
				return "redirect:/";
			}
			
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			return "redirect:/blogs";
		}
	    if(category.getName() == null || category.getName().isEmpty()) {
	    	redirectAttributes.addFlashAttribute("message","Category Add Failed");
	    	return "redirect:/admin_dashboard";
	    }
	    if(bresult.hasErrors()) {
	      model.addAttribute("category",category);
	      return "adminDashboard";
	    }else {
	       rm = other_repo.addCategory(category);
	      if(rm.getResult() == 0) {
	        model.addAttribute("category",category);
	        model.addAttribute("errors",rm.getMessage());
	        return "admin_dashboard";      }
	    }
	    redirectAttributes.addFlashAttribute("message",rm.getMessage() );
	    return "redirect:/admin_dashboard";
	  }
	  @GetMapping("/editCategory/{categoryid}")
	  public String edit(@PathVariable int categoryid,ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
		  if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null && session.getAttribute("isSuper_Admin") == null ) {
				if(session.getAttribute("login") == null) {
					redirectAttributes.addFlashAttribute("message", "Please Login First");
					return "redirect:/";
				}
				
				redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
				return "redirect:/blogs";
			}
		  model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
		  model.addAttribute("category",other_repo.findCategoryById(categoryid));
		  model.addAttribute("categoryid",categoryid);
		  return "edit_category";
	  }
	  @PostMapping("/editCategory")
	  public String edit(@ModelAttribute("category") @Validated CategoryDTO category,@RequestParam int categoryid, BindingResult bResult,ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
		  if(session.getAttribute("login") == null  || session.getAttribute("isAdmin") == null && session.getAttribute("isSuper_Admin") == null ) {
				if(session.getAttribute("login") == null) {
					redirectAttributes.addFlashAttribute("message", "Please Login First");
					return "redirect:/";
				}
				
				redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
				return "redirect:/blogs";
			}
		if(category.getName() == null || category.getName().isEmpty() ) {
			redirectAttributes.addFlashAttribute("message","Please fill inputs");
			return "redirect:/edit_category";
		}
	    if(bResult.hasErrors()) {
	      model.addAttribute("category",category);
	      return "redirect:/edit_category";
	    }else {
	      ResultMessage rm = other_repo.editCategory(category, categoryid);
	      if(rm.getResult()==0) {
	        redirectAttributes.addFlashAttribute("message",rm.getMessage());
	        redirectAttributes.addFlashAttribute("category",category);
	        return "redirect:/admin_dashboard";
	      }
	      redirectAttributes.addFlashAttribute("message", rm.getMessage());
	      return "redirect:/admin_dashboard";
	    }
	  }
	  
}
