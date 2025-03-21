package knowledge_hub.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import knowledge_hub.models.FeedbackDTO;
import knowledge_hub.persistant.OtherRepository;
import knowledge_hub.utils.ResultMessage;

@Controller
public class FeedBackControllers {
	
	private final OtherRepository feedback_repo;

	
	public FeedBackControllers(OtherRepository feedback_repo) {
		this.feedback_repo = feedback_repo;
	}
	
	@PostMapping("/addfeedback")
	public String addfeedback(@ModelAttribute("feedback")@Validated FeedbackDTO feedback,ModelMap m,RedirectAttributes redirectAtrribute) {
		if(feedback.getContent().isEmpty()) {
			redirectAtrribute.addFlashAttribute("message","Feedback send failed");
			return "redirect:/#feedback";
		}
			ResultMessage rm = feedback_repo.addFeedBack(feedback);
			 if(rm.getResult()==0){
				redirectAtrribute.addFlashAttribute("message",rm.getMessage());
				m.addAttribute("feedback",feedback);
				return "/#feedback";
			}
			
	    redirectAtrribute.addFlashAttribute("message",rm.getMessage());
		return "redirect:/";
	}
	
		

}