package knowledge_hub.models;

import java.io.Serializable;

public class CategoryDTO  implements Serializable{
	

	private static final long serialVersionUID = 5641613659701453061L;
	private String name;
	
	public CategoryDTO() {
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
