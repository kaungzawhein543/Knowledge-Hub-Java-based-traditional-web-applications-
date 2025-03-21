package knowledge_hub.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import knowledge_hub.models.FeedbackDTO;

@Controller
public class HomeControllers {
	@GetMapping("/")
	public String header(ModelMap model) {
		model.addAttribute("feedback",new FeedbackDTO());
		return "header";
	}
	@GetMapping("/terms")
	public String terms() {
		return "terms";
	}
}
