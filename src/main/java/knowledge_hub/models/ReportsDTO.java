package knowledge_hub.models;

import java.io.Serializable;

public class ReportsDTO implements Serializable{
	

	private static final long serialVersionUID = 4201388193527738371L;
	private String blog_code;
	private String blogger_name;
	private String content;
	
	public ReportsDTO() {
		
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
