package knowledge_hub.controllers;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import knowledge_hub.models.BlogResponseDTO;
import knowledge_hub.persistant.BlogRepository;
import knowledge_hub.utils.ResultMessage;

@RestController
public class LikeRest {
    
	@Autowired
	BlogRepository blog_repo;
	
	@Autowired
	ResultMessage rm;
	
    @GetMapping(value = "/like-blog", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BlogResponseDTO> LikeBlog(@RequestParam int userid, @RequestParam int blogid,ModelMap model,HttpSession session){
		if(blog_repo.CheckLikeOrUnLike(userid, blogid)) {
			rm = blog_repo.UnLikeBlog(userid, blogid);
		}else {			
			rm = blog_repo.LikeBlog(userid, blogid);
		}
    	BlogResponseDTO blog = blog_repo.FindBlogById(blogid, userid);
		if(blog_repo.CheckLikeOrUnLike(userid, blogid)) {
			blog.setCheck_like("Liked");
		}else {			
			blog.setCheck_like("unLiked");
		}
		
		if(blog_repo.CheckSaveOrUnsave(userid, blogid)) {
			blog.setCheck_save("Saved");
		}else {			
			blog.setCheck_save("Unsaved");
		}
    	
		return ResponseEntity.ok(blog);
    }
    @GetMapping(value = "/save-blog", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BlogResponseDTO> SaveBlog(@RequestParam int userid, @RequestParam int blogid,ModelMap model,HttpSession session){
    	if(blog_repo.CheckSaveOrUnsave(userid, blogid)) {
    		rm = blog_repo.UnSaveBlog(userid, blogid);
    	}else {
    		rm = blog_repo.SaveBlog(userid, blogid);
    	}
    	BlogResponseDTO blog = blog_repo.FindBlogById(blogid, userid);
		if(blog_repo.CheckLikeOrUnLike(userid, blogid)) {
			blog.setCheck_like("Liked");
		}else {			
			blog.setCheck_like("unLiked");
		}
		
		if(blog_repo.CheckSaveOrUnsave(userid, blogid)) {
			blog.setCheck_save("Saved");
		}else {			
			blog.setCheck_save("Unsaved");
		}
		
		return ResponseEntity.ok(blog);
    }
    @GetMapping(value= "/updateblog", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<BlogResponseDTO>> updateBlog(HttpSession session){
    	List<BlogResponseDTO> blogs = blog_repo.randomBlogs();
	    for(BlogResponseDTO blog : blogs) {
	    	if(blog_repo.CheckSaveOrUnsave((int)session.getAttribute("userId"), blog.getId())) {
				blog.setCheck_save("Saved");
			}else {			
				blog.setCheck_save("Unsaved");
			}
	    	if(blog_repo.CheckLikeOrUnLike((int)session.getAttribute("userId"), blog.getId())) {
	    		blog.setCheck_like("Liked");
	    	}else {			
	    		blog.setCheck_like("Unliked");
	    	}
	    }
	    return ResponseEntity.ok(blogs);
    }
}
