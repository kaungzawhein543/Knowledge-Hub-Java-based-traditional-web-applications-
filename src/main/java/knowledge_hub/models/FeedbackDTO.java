package knowledge_hub.models;

import java.io.Serializable;

public class FeedbackDTO implements Serializable{
	
	

	private static final long serialVersionUID = 5149330607716791816L;
	private String content;
	
	public FeedbackDTO() {
		
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	
}
