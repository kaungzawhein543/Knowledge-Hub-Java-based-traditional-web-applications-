package knowledge_hub.models;

import java.io.Serializable;
import java.util.List;

public class BlogResponseDTO implements Serializable{
	
	

	private static final long serialVersionUID = -3802874551324146433L;
	private int id;
	private String code;
	private String title;
	private String content;
	private int categories_id;
	private String categories_name;
	private String encodedPhoto;
	private String encodeProfile;
	private String createdAt;
	private int users_id;
	private int views;
	private String username;
	private int  likes_counts;
	private String check_like;
	private String check_save;
	private int comments_counts;
	private List<CommentsResponseDTO> comments;
	
	public BlogResponseDTO() {
		
	}
	
	public String getCheck_save() {
		return check_save;
	}

	public void setCheck_save(String check_save) {
		this.check_save = check_save;
	}

	public String getCheck_like() {
		return check_like;
	}

	public void setCheck_like(String check_like) {
		this.check_like = check_like;
	}

	public String getEncodeProfile() {
		return encodeProfile;
	}

	public void setEncodeProfile(String encodeProfile) {
		this.encodeProfile = encodeProfile;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
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
	
	public String getCategories_name() {
		return categories_name;
	}


	public void setCategories_name(String categories_name) {
		this.categories_name = categories_name;
	}


	public int getCategories_id() {
		return categories_id;
	}

	public void setCategories_id(int categories_id) {
		this.categories_id = categories_id;
	}
	

	public String getEncodedPhoto() {
		return encodedPhoto;
	}


	public void setEncodedPhoto(String encodedPhoto) {
		this.encodedPhoto = encodedPhoto;
	}


	public int getLikes_counts() {
		return likes_counts;
	}

	public void setLikes_counts(int likes_counts) {
		this.likes_counts = likes_counts;
	}

	
	public int getComments_counts() {
		return comments_counts;
	}

	public void setComments_counts(int comments_counts) {
		this.comments_counts = comments_counts;
	}

	public List<CommentsResponseDTO> getComments() {
		return comments;
	}

	public void setComments(List<CommentsResponseDTO> comments) {
		this.comments = comments;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public int getUsers_id() {
		return users_id;
	}

	public void setUsers_id(int users_id) {
		this.users_id = users_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}


	public int getViews() {
		return views;
	}


	public void setViews(int views) {
		this.views = views;
	}
	
	
}
