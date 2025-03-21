package knowledge_hub.utils;

import java.io.Serializable;

public class ResultMessage implements Serializable{
	
	

	private static final long serialVersionUID = -6919360730818078159L;
	private int result;
	private String message;
	
	public ResultMessage() {
		
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
