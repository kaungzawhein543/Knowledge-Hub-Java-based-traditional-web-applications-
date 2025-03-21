package knowledge_hub.models;

import java.io.Serializable;

public class roleDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -598858838874790884L;
	private String name;
	
	public roleDTO() {
		
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
