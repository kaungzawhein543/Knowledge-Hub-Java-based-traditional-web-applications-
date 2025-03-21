package knowledge_hub.models;

import java.io.Serializable;

public class Blogger_userDTO implements Serializable{
	
	
	private static final long serialVersionUID = -1879220964015888814L;
	private String name;
	private String email;
	private String address;
	private String education;
	private String ph_contact;
	private String personality;
	private int user_id;
	public Blogger_userDTO() {
		
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getPh_contact() {
		return ph_contact;
	}

	public void setPh_contact(String ph_contact) {
		this.ph_contact = ph_contact;
	}

	public String getPersonality() {
		return personality;
	}

	public void setPersonality(String personality) {
		this.personality = personality;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
}
