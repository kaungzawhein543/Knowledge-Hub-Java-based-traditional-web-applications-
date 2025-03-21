package knowledge_hub.models;

import java.io.Serializable;

public class roleResponseDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -598858838874790884L;
	private int id;
	private String name;
	
	public roleResponseDTO() {
		
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
	
}
