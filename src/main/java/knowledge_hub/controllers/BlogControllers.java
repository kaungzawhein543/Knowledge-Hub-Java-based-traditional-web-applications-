package knowledge_hub.controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import knowledge_hub.models.BlogDTO;
import knowledge_hub.models.BlogResponseDTO;
import knowledge_hub.models.CommentsDTO;
import knowledge_hub.models.ReportsDTO;
import knowledge_hub.persistant.BlogRepository;
import knowledge_hub.persistant.Blogger_userRepository;
import knowledge_hub.persistant.OtherRepository;
import knowledge_hub.utils.ResultMessage;

@Controller
public class BlogControllers {
	
	private final BlogRepository blog_repo;
	private final OtherRepository other_repo;
	public BlogControllers(BlogRepository blog_repo,OtherRepository other_repo) {
		this.blog_repo = blog_repo;
		this.other_repo = other_repo;
	}
	
	@GetMapping("/blogs")
	public String allBlog(ModelMap model, HttpSession session, RedirectAttributes redirectAttributes) {
	    if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
	    List<BlogResponseDTO> blogs = blog_repo.randomBlogs();
	    model.addAttribute("randomBlogs",blog_repo.randomBlogs());
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
	    
	    model.addAttribute("mostViewedBlogs", blog_repo.MostViewsBlog());
	    model.addAttribute("categories", new OtherRepository().findAllCategories());
	    model.addAttribute("trendBloggers", new Blogger_userRepository().findPopularBloggers());
	    model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
	    return "blogs";
	}

	@GetMapping("/categories/{categoryid}")
	public String blogsByCategories(@PathVariable int categoryid,ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
		 if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		model.addAttribute("blogs", blog_repo.findBlogsByCategory(categoryid));
		model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
		model.addAttribute("categoryname",new OtherRepository().findCategoryNameById(categoryid));
		return "blogsByCategory";
	}
	@GetMapping("/detail")
	public String detail(@RequestParam int blogid,@RequestParam int userId,ModelMap model,RedirectAttributes redirectAttributes,HttpSession session) {
		 if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		BlogResponseDTO blog = blog_repo.FindBlogById(blogid, userId);
		model.addAttribute("blog",blog);
		model.addAttribute("blogid",blogid);
		if(blog_repo.CheckLikeOrUnLike(userId, blogid)) {
			model.addAttribute("react","Liked");
		}else {			
			model.addAttribute("react","unLiked");
		}
		
		if(blog_repo.CheckSaveOrUnsave(userId, blogid)) {
			model.addAttribute("save","Saved");
		}else {			
			model.addAttribute("save","Unsaved");
		}
		model.addAttribute("report",new ReportsDTO());
		model.addAttribute("comment",new CommentsDTO());
		model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
		return "blog_detail";
	}
	
	@GetMapping("/add_blog")
	public String addBlog(ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
	    String permission = blog_repo.findPermission((int)session.getAttribute("userId"));
	    if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
	    if(permission == null) {
	    	if((boolean)session.getAttribute("isAdmin") || (boolean)session.getAttribute("isSuper_Admin")) {	    		
	    		redirectAttributes.addFlashAttribute("message","You don't have permission to post blog");
	    		return "redirect:/admin_dashboard";
	    	}else {
	    		redirectAttributes.addFlashAttribute("message","You don't have permission to post blog");
	    		return "redirect:/blogs";
	    	}
	    }
	    if (permission.equals("approve")) {	
	        model.addAttribute("blogCode", blog_repo.findBlogLastCode());
	        model.addAttribute("categories",new OtherRepository().findAllCategories());
	        model.addAttribute("blog", new BlogDTO());
	        return "add_Blog";
	    }
	    return "blogs";
	}

	
	
	@PostMapping("/add_blog/{id}")
	public String addBlog(@ModelAttribute("blog") @PathVariable int id, @Validated BlogDTO blog, BindingResult bResult, ModelMap m, MultipartFile file, RedirectAttributes redirectAttributes,HttpSession session) {		
		 if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		if(blog_repo.findPermission(id) == null) {
			redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
	        return "redirect:/blogs";
		}
		if (!file.isEmpty()) {
	        try {
	            byte[] photoData = file.getBytes();
	            blog.setPhoto(photoData);
	        } catch (IOException e) {
	        }
	    }
		if(blog.getTitle().isEmpty() || blog.getContent().isEmpty() || blog.getCode().isEmpty() || blog.getContent().isEmpty()) {
			m.addAttribute("blog",blog);
			return "add_Blog";
		}
		 // Check for validation errors
	    if (bResult.hasErrors()) {
	        m.addAttribute("blog", blog);
	        return "add_Blog";
	    }
		ResultMessage rm = blog_repo.addBlog(blog, id);
		 if(rm.getResult()==0){
			m.addAttribute("message",rm.getMessage());
			m.addAttribute("blog",blog);
			return "add_Blog";
		}
		redirectAttributes.addFlashAttribute("message", rm.getMessage());
		return "redirect:/blogs";
	}
	
	
	@GetMapping("/edit_blog/{blogid}")
	public String editBlog(@PathVariable int blogid, ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
		 if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
	    BlogDTO blog = blog_repo.findBlogForEdit(blogid);
	    if(blog_repo.FindBlogById(blogid, (int)session.getAttribute("userId")).getUsers_id() != (int)session.getAttribute("userId")) {
	    	redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
	    	return "redirect:/login";	    	
	    }
	    String encodedContent = blog.getContent();
	    String encodedTitle = blog.getTitle();
	    String decodedContent = StringEscapeUtils.unescapeHtml4(encodedContent);
	    String decodedTitle  = StringEscapeUtils.unescapeHtml4(encodedTitle);
	    blog.setContent(decodedContent);
	    blog.setTitle(decodedTitle);
	    
	    model.addAttribute("blog", blog);
	    model.addAttribute("blogid", blogid);
	    model.addAttribute("categories", new OtherRepository().findAllCategories());
	    model.addAttribute("userStatus",new Blogger_userRepository().findBloggerStatus(session));
	    if (blog.getPhoto() != null && blog.getPhoto().length > 0) {
	        String encodedPhoto = Base64.getEncoder().encodeToString(blog.getPhoto());
	        session.setAttribute("encodedBlogPhoto", encodedPhoto);
	    }
	    
	    return "edit_Blog";
	}

	
	
	@PostMapping("/edit_blog/{id}")
	public String editBlog(@ModelAttribute("blog") @Validated BlogDTO blog , @PathVariable int id,BindingResult bResult,MultipartFile file, ModelMap m,HttpSession session,RedirectAttributes redirectAttributes) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
	 if(blog_repo.FindBlogById(id, (int)session.getAttribute("userId")).getUsers_id() != (int)session.getAttribute("userId")) {
	    	redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
	    	return "redirect:/blogs";	    	
	    }
		if (!file.isEmpty()) {
	        try {
	            byte[] photoData = file.getBytes();
	            blog.setPhoto(photoData);
	        } catch (IOException e) {
		        return "add_Blog";
	        }
	    }else {
	    	byte[] photoData = Base64.getDecoder().decode((String) session.getAttribute("encodedBlogPhoto"));
	    	blog.setPhoto(photoData);
	    	session.removeAttribute("encodedBlogPhoto"); 	
	    }
		if(blog.getTitle().isEmpty() || blog.getContent().isEmpty() || blog.getCode().isEmpty() || blog.getContent().isEmpty()) {
			m.addAttribute("blog",blog);
			return "add_blog";
		}
		if(bResult.hasErrors()) {
			m.addAttribute("blog",blog);
			return "edit_blog";
		}
		ResultMessage rm = new ResultMessage();
		try {
			String encodedContent = new String(blog.getContent().getBytes("ISO-8859-1"), "UTF-8");
			String encodedTitle = new String(blog.getTitle().getBytes("ISO-8859-1"), "UTF-8");
			blog.setContent(encodedContent);
			blog.setTitle(encodedTitle);

		         rm = blog_repo.editBlog(blog,id);
		        redirectAttributes.addFlashAttribute("message", rm.getMessage());
		}catch(UnsupportedEncodingException e){
			 e.printStackTrace();
		}
		if(rm.getResult()==0){
			m.addAttribute("blog",blog);
			return "edit_blog";
		}
		redirectAttributes.addFlashAttribute("message", rm.getMessage());
		return "redirect:/blogs";
		
	}
	
	@GetMapping("/delete_blog")
	public String deleteBlog(@RequestParam int blogid,@RequestParam String blogcode, ModelMap model, RedirectAttributes redirectAttributes,HttpSession session) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		if(blog_repo.FindBlogById(blogid, (int)session.getAttribute("userId")).getUsers_id() != (int)session.getAttribute("userId")) {
	    	redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
	    	return "redirect:/blogs";	    	
	    }
		ResultMessage rm = blog_repo.deleteBlog(blogid, blogcode);
		redirectAttributes.addFlashAttribute("message", rm.getMessage());
		return "redirect:/blogs";
	}
	
	@GetMapping("/save_blog")
	public String saveblog(@RequestParam int userid, @RequestParam int blogid,RedirectAttributes redirectAttributes,HttpSession session) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		ResultMessage rm;
		if(blog_repo.CheckSaveOrUnsave(userid, blogid)) {
			rm = blog_repo.UnSaveBlog(userid, blogid);
		}else {			
			rm = blog_repo.SaveBlog(userid, blogid);
		}
		redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/detail?userId="+userid+"&blogid="+blogid;
	}
	
	
	@GetMapping("/like_blog")
	public String likeeblog(@RequestParam int userid, @RequestParam int blogid,RedirectAttributes redirectAttributes,HttpSession session) {
		if (session.getAttribute("login") == null) {
	        redirectAttributes.addFlashAttribute("message", "Please Login First");
	        return "redirect:/login";
	    }
		ResultMessage rm;
		if(blog_repo.CheckLikeOrUnLike(userid, blogid)) {
			rm = blog_repo.UnLikeBlog(userid, blogid);
		}else {			
			rm = blog_repo.LikeBlog(userid, blogid);
		}
		redirectAttributes.addFlashAttribute("message",rm.getMessage());
		return "redirect:/detail?userId="+userid+"&blogid="+blogid;
	}
	
		@PostMapping("/post_comments")
		public String postcomments(@ModelAttribute("comment") CommentsDTO comment,RedirectAttributes redirectAttributes,HttpSession session) {
			if (session.getAttribute("login") == null) {
		        redirectAttributes.addFlashAttribute("message", "Please Login First");
		        return "redirect:/login";
		    }
			ResultMessage rm = new ResultMessage();
			 try {
			        String encodedContent = new String(comment.getContent().getBytes("ISO-8859-1"), "UTF-8");
			        comment.setContent(encodedContent);
			        rm = blog_repo.AddComment(comment,comment.getComment_user_id());
			        redirectAttributes.addFlashAttribute("message", rm.getMessage());
			    } catch (UnsupportedEncodingException e) {
			        e.printStackTrace();
			    }
			redirectAttributes.addFlashAttribute("message",rm.getMessage());
			return "redirect:/detail?blogid="+comment.getBlogs_id()+"&userId="+comment.getComment_user_id();
		}
		@GetMapping("/delete_comment")
		public String deletecomments(@RequestParam int commentid,@RequestParam int userid,@RequestParam int blogid,RedirectAttributes redirectAttributes,HttpSession session) {
			if (session.getAttribute("login") == null) {
		        redirectAttributes.addFlashAttribute("message", "Please Login First");
		        return "redirect:/login";
		    }
			if(blog_repo.findCommentById(commentid).getComment_user_id() != (int)session.getAttribute("userId")) {
				redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
				return "redirect:/blogs";				
			}
			ResultMessage rm = blog_repo.DeleteComment(commentid);
			redirectAttributes.addFlashAttribute("message",rm.getMessage());
			return "redirect:/detail?blogid="+blogid+"&userId="+userid;
		}

		@GetMapping("/edit_comment")
		public String editcomments(@RequestParam int commentid, @RequestParam int userid, @RequestParam int blogid, ModelMap model,HttpSession session,RedirectAttributes redirectAttributes) {
			if (session.getAttribute("login") == null) {
		        redirectAttributes.addFlashAttribute("message", "Please Login First");
		        return "redirect:/login";
		    }
			if(blog_repo.findCommentById(commentid).getComment_user_id() != (int)session.getAttribute("userId")) {
				redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
				return "redirect:/blogs";				
			}
		    BlogResponseDTO blog = blog_repo.FindBlogById(blogid, userid);
		    CommentsDTO editcomment = blog_repo.findCommentById(commentid);
		    
		    String encodedText = editcomment.getContent();
		    String decodedText = StringEscapeUtils.unescapeHtml4(encodedText);
		    editcomment.setContent(decodedText);
		    
		    model.addAttribute("editcomment", editcomment);
		    model.addAttribute("blog", blog);
		    model.addAttribute("blogid",blogid);
		    model.addAttribute("commentid", commentid);
		    return "edit_comment";
		}


		
		@PostMapping("/edit_comment")
		public String editComment(@RequestParam int commentid, @ModelAttribute("comment") CommentsDTO comment, RedirectAttributes redirectAttributes,HttpSession session) {
			if (session.getAttribute("login") == null) {
		        redirectAttributes.addFlashAttribute("message", "Please Login First");
		        return "redirect:/login";
		    }
			if(blog_repo.findCommentById(commentid).getComment_user_id() != (int)session.getAttribute("userId")) {
				redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
				return "redirect:/blogs";				
			}
		    try {
		        String encodedContent = new String(comment.getContent().getBytes("ISO-8859-1"), "UTF-8");
		        comment.setContent(encodedContent);
		        ResultMessage rm = blog_repo.EditComment(commentid, comment);
		        redirectAttributes.addFlashAttribute("message", rm.getMessage());
		    } catch (UnsupportedEncodingException e) {
		        // Handle encoding exception
		        e.printStackTrace();
		    }
		    return "redirect:/detail?blogid=" + comment.getBlogs_id() + "&userId=" + comment.getComment_user_id();
		}
		@PostMapping("/addreport")
		  public String add(@ModelAttribute("report") @Validated ReportsDTO report,@RequestParam int blogid, BindingResult bresult, ModelMap model,HttpSession session ,RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {
			if (session.getAttribute("login") == null) {
		        redirectAttributes.addFlashAttribute("message", "Please Login First");
		        return "redirect:/login";
		    }
		    ResultMessage  rm;
		    if(bresult.hasErrors()) {
		      model.addAttribute("report",report);
		      return "adminDashboard";
		    }else {
		    	String encodedContent = new String(report.getContent().getBytes("ISO-8859-1"), "UTF-8");
		    	report.setContent(encodedContent);
		       rm = other_repo.addReport(report);
		      if(rm.getResult() == 0) {
		        model.addAttribute("report",report);
		        model.addAttribute("errors",rm.getMessage());
		        return "adminDashboard";      }
		    }
		    redirectAttributes.addFlashAttribute("message",rm.getMessage() );
		    return "redirect:/detail?blogid=" + blogid+ "&userId=" + session.getAttribute("userId");
		  }

		  @GetMapping("/approveReport")
		  public String approveReport(@RequestParam int blogId,@RequestParam int reportId, HttpSession session,RedirectAttributes redirectAttributes) {
			  if (session.getAttribute("login") == null) {
			        redirectAttributes.addFlashAttribute("message", "Please Login First");
			        return "redirect:/login";
			    }
			  if(!(boolean)session.getAttribute("isAdmin") && !(boolean)session.getAttribute("isSuper_Admin")) {
			    	redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			    	return "redirect:/blogs";	    	
			    }
			 ResultMessage rm;
			 int userid = new BlogRepository().findBloggeruseridByBlogId(blogId);
			 rm = other_repo.addReportCount(blogId, userid);
			 if(rm.getResult() == 1) {
				 rm = other_repo.deleteReport(reportId);				 
			 }
		    redirectAttributes.addFlashAttribute("message",rm.getMessage() );
		    return "redirect:/admin_dashboard";
		  }
		  
		  @GetMapping("/rejectReport")
		  public String rejectReport(@RequestParam int reportid,RedirectAttributes redirectAttributes,HttpSession session) {
			  if (session.getAttribute("login") == null) {
			        redirectAttributes.addFlashAttribute("message", "Please Login First");
			        return "redirect:/login";
			    }
			  if(!(boolean)session.getAttribute("isAdmin") && !(boolean)session.getAttribute("isSuper_Admin")) {
			    	redirectAttributes.addFlashAttribute("message", "You don't have permission for that");
			    	return "redirect:/blogs";	    	
			    }
			  ResultMessage rm = other_repo.deleteReport(reportid);
			  redirectAttributes.addFlashAttribute("message",rm.getMessage() );
			    return "redirect:/admin_dashboard";
		  }
}	
