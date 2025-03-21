package knowledge_hub.models;

import java.io.Serializable;

import javax.validation.constraints.NotEmpty;

public class UserRequestDTO implements Serializable{
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4044840561477738643L;
	@NotEmpty(message = "Username must not be empty")
	private String name;
	@NotEmpty(message = "Email must not be empty")
	private String email;
	@NotEmpty(message = "Password must not be empty")
	private String password;
	@NotEmpty(message = "Date Of Birth must not be empty")
	private String dob;
	@NotEmpty(message = "Gender must not be empty")
	private String gender;
	private int status;
	public UserRequestDTO() {
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	
}
