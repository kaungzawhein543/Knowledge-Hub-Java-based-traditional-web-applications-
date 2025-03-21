package knowledge_hub.models;

import java.io.Serializable;

public class CategoryResponseDTO implements Serializable{
	

	private static final long serialVersionUID = -6994374699446136973L;
	private int id;
	private String name;
	
	public CategoryResponseDTO() {
		
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
