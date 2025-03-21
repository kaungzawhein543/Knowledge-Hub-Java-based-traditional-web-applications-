package knowledge_hub.models;

import java.io.Serializable;

public class UserResponseDTO implements Serializable {
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8306797353282737062L;
	private int id;
	private String name;
	private String email;
	private String password;
	private String dob;
	private String gender;
	private int status;
	private int roles_id;
	private String role_name;
	private String encodedProfile;
	
	public UserResponseDTO() {
		
	}

	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
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


	public int getRoles_id() {
		return roles_id;
	}


	public void setRoles_id(int roles_id) {
		this.roles_id = roles_id;
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

	public String getEncodedProfile() {
		return encodedProfile;
	}

	public void setEncodedProfile(String encodedProfile) {
		this.encodedProfile = encodedProfile;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public String getRole_name() {
		return role_name;
	}


	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	
}
