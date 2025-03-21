package knowledge_hub.models;

import java.io.Serializable;

public class EmailRequestDTO implements Serializable
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 6819793502973263812L;
	private String email;
    
    public EmailRequestDTO() {
    	
    }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
    
}
	