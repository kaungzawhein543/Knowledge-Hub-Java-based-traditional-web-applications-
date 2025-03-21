package knowledge_hub.models;

import java.io.Serializable;

public class Blogger_userResponseDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7867187374130683868L;
	private int id;
	private String name;
	private String email;
	private String address;
	private String education;
	private String ph_contact;
	private int user_role;
	private String status;
	private String encodedProfile;
	private int likeCounts;
	private String personality;
	private int user_id;
	
	public Blogger_userResponseDTO() {
		
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEncodedProfile() {
		return encodedProfile;
	}

	public void setEncodedProfile(String encodedProfile) {
		this.encodedProfile = encodedProfile;
	}

	public int getLikeCounts() {
		return likeCounts;
	}

	public void setLikeCounts(int likeCounts) {
		this.likeCounts = likeCounts;
	}

	public int getUser_role() {
		return user_role;
	}

	public void setUser_role(int user_role) {
		this.user_role = user_role;
	}
	
}
