package knowledge_hub.models;

import java.io.Serializable;

import javax.validation.constraints.NotEmpty;

public class LoginDTO implements Serializable {
	
	
	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1288417610313560042L;
	@NotEmpty(message = "Email must not be empty")
	private String email;
	@NotEmpty(message = "Password must not be empty")
	private String password;
	
	public LoginDTO() {
		
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
}
