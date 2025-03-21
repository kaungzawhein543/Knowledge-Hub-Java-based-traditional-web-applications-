package knowledge_hub.controllers;

import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import knowledge_hub.models.EmailRequestDTO;
import knowledge_hub.persistant.UserRepository;
import services.EmailService;

@Controller
public class SendEmailController {

	private final EmailService emailService;
	public SendEmailController(EmailService emailService){
		this.emailService = emailService;
	}
	
@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
public String sendEmail(@RequestParam("email") String email, HttpSession session, RedirectAttributes redirectAttributes) {
    String otp = generateOTP();
    session.setAttribute("otp", otp);
    String name = new UserRepository().checkEmailAndGetName(email);
    if (name == null) {
        redirectAttributes.addFlashAttribute("message", "*Your email does not exist");
        return "redirect:/forgetpassword";
    }
    session.setMaxInactiveInterval(180);
    String to = email;
    String subject = "Password Reset for Knowledge Hub";
    String body = buildEmailBody(name, otp);

    try {
        emailService.sendEmail(to, subject, body);
        session.setAttribute("email", email);
        return "redirect:/otpverifier";
    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("message", "Failed to send password reset email. Please try again later.");
        return "redirect:/forgetpassword";
    }
}

private String generateOTP() {
    // Generate a secure random OTP
    SecureRandom random = new SecureRandom();
    int otpValue = 100000 + random.nextInt(900000);
    return String.valueOf(otpValue);
}

private String buildEmailBody(String name, String otp) {
    // Construct the HTML email body using a template engine (e.g., Thymeleaf, FreeMarker)
    // Sample implementation using plain HTML
    return "<html>"
            + "<head>"
            + "<style>"
            + "body {"
            + "    font-family: Arial, sans-serif;"
            + "    font-size: 14px;"
            + "    color: #333;"
            + "    line-height: 1.6;"
            + "}"
            + "p {"
            + "    margin-bottom: 10px;"
            + "}"
            + "</style>"
            + "</head>"
            + "<body>"
            + "<p>Dear " + name + ",</p>"
            + "<p>We've received a request to reset the password for your Knowledge Hub account. To complete this process, please use the following One-Time Password (OTP):</p>"
            + "<p style='background-color: #f7f7f7; padding: 10px;'>OTP: " + otp + "</p>"
            + "<p>Please enter this OTP within 3 minutes to reset your password securely.</p>"
            + "<p>If you didn't request this password reset or if you have any concerns about the security of your account, please reach out to our support team immediately at 09770554551.</p>"
            + "<p>Thank you for keeping your account secure.</p>"
            + "<p>Best regards,<br>Fb - <strong>Kaung Zaw Hein</strong><br>Kaung Zaw Hein<br><a href='mailto:kzheindev789@gmail.com'>kzheindev789@gmail.com</a></p>"
            + "</body>"
            + "</html>";
}
    @GetMapping("/otpverifier")
    public String otpverfier(HttpSession session,RedirectAttributes redirectAttributes) {
    	if(session.getAttribute("otp") == null) {
    		redirectAttributes.addFlashAttribute("message","Canceled Change Password");
    		return "redirect:/login"; 
    	}
    	return "otpverifier";
    }
    
    @PostMapping("/otpverifier")
    public String otpverify(@RequestParam("otp") String otp,HttpSession session,RedirectAttributes redirectAttributes,ModelMap model) {
    	if(session.getAttribute("otp") == null) {
    		redirectAttributes.addFlashAttribute("message","Otp verfiy time is out");
    		model.addAttribute("email",new EmailRequestDTO());
    		return "redirect:/login";
    	}else {
    		String sessionOTP = (String) session.getAttribute("otp");
    		if(sessionOTP.equals(otp)) {
    			return "redirect:/changepassword";
    		}else {
    			redirectAttributes.addFlashAttribute("message","*Wrong Otp code");
    			return "redirect:/otpverifier";
    		}
    	}
    }
}
