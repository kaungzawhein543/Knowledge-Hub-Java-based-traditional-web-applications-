package knowledge_hub.models;

import java.io.Serializable;

public class CommentsResponseDTO implements Serializable{
	
	
	
	private static final long serialVersionUID = -4567689321681454752L;
	private int id;
	private String content;
	private String comment_user_name;
	private int comment_user_id;
	private int blogs_id;
	
	public CommentsResponseDTO() {
		
	}


	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}



	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getComment_user_name() {
		return comment_user_name;
	}

	public void setComment_user_name(String comment_user_name) {
		this.comment_user_name = comment_user_name;
	}

	public int getComment_user_id() {
		return comment_user_id;
	}

	public void setComment_user_id(int comment_user_id) {
		this.comment_user_id = comment_user_id;
	}

	public int getBlogs_id() {
		return blogs_id;
	}

	public void setBlogs_id(int blogs_id) {
		this.blogs_id = blogs_id;
	}
}
