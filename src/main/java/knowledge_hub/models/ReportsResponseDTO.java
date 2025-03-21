package knowledge_hub.models;

import java.io.Serializable;

public class ReportsResponseDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4779792183382531937L;
	private int id;
	private String blog_code;
	private int blog_id;
	private String blogger_name;
	private String content;
	
	public ReportsResponseDTO() {
		
	}
	
	
	public int getBlog_id() {
		return blog_id;
	}


	public void setBlog_id(int blog_id) {
		this.blog_id = blog_id;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getBlog_code() {
		return blog_code;
	}

	public void setBlog_code(String blog_code) {
		this.blog_code = blog_code;
	}

	public String getBlogger_name() {
		return blogger_name;
	}

	public void setBlogger_name(String blogger_name) {
		this.blogger_name = blogger_name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
