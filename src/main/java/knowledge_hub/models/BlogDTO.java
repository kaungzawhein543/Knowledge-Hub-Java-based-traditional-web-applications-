package knowledge_hub.models;		

import java.io.Serializable;

public class BlogDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4612900065581466648L;
	
	private String code;
	private String title;
	private String content;
	private int categories_id;
	private byte[] photo;
	
	public BlogDTO() {
		
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCategories_id() {
		return categories_id;
	}

	public void setCategories_id(int categories_id) {
		this.categories_id = categories_id;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	
}
