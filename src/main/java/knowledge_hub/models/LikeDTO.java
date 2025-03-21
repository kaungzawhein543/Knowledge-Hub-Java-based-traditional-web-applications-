package knowledge_hub.models;

import java.io.Serializable;

public class LikeDTO implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1440238755321737350L;
	private int likeCount;
	private String likeOrNot;
	
	public LikeDTO() {
		
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public String getLikeOrNot() {
		return likeOrNot;
	}

	public void setLikeOrNot(String likeOrNot) {
		this.likeOrNot = likeOrNot;
	}
	
}
