package knowledge_hub.persistant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired; 

import knowledge_hub.models.BlogDTO;
import knowledge_hub.models.BlogResponseDTO;
import knowledge_hub.models.CommentsDTO;
import knowledge_hub.models.CommentsResponseDTO;
import knowledge_hub.utils.ResultMessage;

public class BlogRepository {
	static Connection con = null;
	static {
		con = MyConnection.getConnection();
	}
	@Autowired
	ResultMessage rm;
	
	//For Post the Blog
	public ResultMessage addBlog(BlogDTO blog,int userid) {
		String sql = "INSERT INTO blogs(code,title,content,categories_id,photo,users_id) VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, blog.getCode());
			ps.setString(2, blog.getTitle());
			ps.setString(3, blog.getContent());
			ps.setInt(4, blog.getCategories_id());
			ps.setBytes(5, blog.getPhoto());
			ps.setInt(6, userid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Add Blog Successfully");
			}
			else {
				rm.setMessage("Add Blog Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add new blog error!"+e);
		}
		return rm;
	}
	
	//For Edit the Blog
	public ResultMessage editBlog(BlogDTO blog,int blogid) {
		String sql = "UPDATE blogs SET title = ?,content = ?,categories_id = ?,photo =? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, blog.getTitle());
			ps.setString(2, blog.getContent());
			ps.setInt(3, blog.getCategories_id());
			ps.setBytes(4, blog.getPhoto());
			ps.setInt(5, blogid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Edit Blog Successfully");
			}else {
				rm.setMessage("Edit Blog Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured."+e);
		}
		return rm;
	}
	
	//For Delete the Blog
	public ResultMessage deleteBlog(int blogid,String code) {
		String sql = "DELETE FROM users_like_blogs WHERE blogs_id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, blogid);
	        ps.executeUpdate();
	        
	        
			sql = "DELETE FROM users_save_blogs WHERE blogs_id = ?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			ps.executeUpdate();
			
			sql = "DELETE FROM comments  WHERE blogs_id = ?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			ps.executeUpdate();
			
			
			sql = "DELETE FROM blogs WHERE id = ?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			rm.setResult(ps.executeUpdate());
					if(rm.getResult()==1) { // နောက်ဆုံးအနေနဲ့ Blog tableကိုဖျက်မယ်
						//ဖျက်ချင်တဲ့ table တွေကိုဖျက်ပြီးရင်သူ့အောက်က Blog တွေကိုသူ့codeနေရာအစားထိုးအောင်စီမံမယ်
						 
				        sql = "SELECT code FROM blogs WHERE code > ? ORDER BY code"; //ဖျက်လိုက်တဲ့ blog ရဲ့ code ထက်ကြီးတဲ့codeတွေကို select နဲ့ယူ
				        ps = con.prepareStatement(sql);
				        ps.setString(1, code);
				        ResultSet rs = ps.executeQuery();
				        while(rs.next()) { //selectနဲ့ယူပီးလို့ရှိလို့ရှိရင်
				        	 String nextCode = rs.getString("code"); //code ကိုလှမ်းယူမယ်
				            int nextCodeint = Integer.parseInt(nextCode.substring(3)); // ယူထားတဲ့ Code ကို၃ခုမြောက်ကစယူပီးတော့ int ပြောင်းပီး variable တစ်ခုထဲထည့်
				            nextCodeint--; // 1 လျော့မယ်
				            String stringCode = String.format("#BL%d", nextCodeint); //ပီးရင် intကုတ်ကိုကိုယ်လိုချင်တဲ့ပုံစံနဲ့ Format ပြောင်းပီး variable တစ်ခုထဲထည့်မယ်
				            
				            
				            //ကိုယ်လိုချင်တာပြောင်းထားတဲ့ကုတ်ကို blogs မှာပြင်လိုက်မယ်
				            sql = "UPDATE blogs SET code = ? WHERE code = ?";
				            ps = con.prepareStatement(sql);
				            ps.setString(1, stringCode);
				            ps.setString(2, nextCode);
				            ps.executeUpdate();
				            
				        }
						rm.setMessage("DELETE blog Successfully");
					}else {
						rm.setMessage("DELETE Blog failed");
					}
		}catch(SQLException e) {
			System.out.println("SQl Exception occured.Delete Blog error!"+e);
		}
		return rm;
	}
	
	//For Find the Last Blog code
	public String findBlogLastCode() {
		String sql = "SELECT code FROM blogs ORDER BY code DESC LIMIT 1;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				 String lastCodeString = rs.getString("code");
	            int lastCodeNumericPart = Integer.parseInt(lastCodeString.substring(3));
	            lastCodeNumericPart++;
	            return String.format("#BL%d", lastCodeNumericPart);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find Blog Last Id error");
		}
		return "#BL1";
	}
	
	
	// For Save The Blog
	public ResultMessage SaveBlog(int userid,int blogid) {
		String sql = "INSERT INTO users_save_blogs(users_id,blogs_id) VALUES(?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setInt(2, blogid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Save Blog Successfully");
			}else {
				rm.setMessage("Save Blog Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Excepiton occured.Save Blog Error!"+e);
		}
		return rm;
	}
	
	//For Unsave The Blog
	public ResultMessage UnSaveBlog(int userid,int blogid) {
		String sql = "DELETE FROM users_save_blogs WHERE blogs_id = ? AND users_id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			ps.setInt(2, userid);			
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Unsave Blog Successfully");
			}else {
				rm.setMessage("Unsave Blog Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Unsave Blog Error!"+e);
		}
		return rm;
	}
	
	//For Check Save Or Unsave the Blog
	public boolean CheckSaveOrUnsave(int userid,int blogid) {
		String sql = "SELECT * FROM users_save_blogs WHERE users_id = ? AND blogs_id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setInt(2, blogid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return true;//Trueဆိုရင်saveထားတာရှိတယ်။Unsaveလုပ်ရမယ်
			}

		}catch(SQLException e) {
			
		}
		return false;//Falseဆိုရင်saveထားတာမရှိဘူး။Saveရမယ်။
	}
//	if(blog_repo.checksaveorunsave(userid,blogid)){
//		
//	}else {
//		
//	}
	
	//For Like the Blog
	public ResultMessage LikeBlog(int userid,int blogid) {
		String sql = "INSERT INTO users_like_blogs(users_id,blogs_id) VALUES(?,?);";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setInt(2, blogid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Liked Blog");
			}else {
				rm.setMessage("Like Blog Error");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Like Blog Error."+e);
		}
		return rm;
	}
	
	//For UnLike The Blog
	public ResultMessage UnLikeBlog(int userid,int blogid) {
		String sql = "DELETE FROM users_like_blogs WHERE users_id = ? AND blogs_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setInt(2, blogid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("UnLiked Blog");
			}else {
				rm.setMessage("UnLike Blog Error");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Unlike Blog Error.!"+e);
		}
		return rm;
	}
	
	//For CheckUnlike The Blog
	public boolean CheckLikeOrUnLike(int userid,int blogid) {
		String sql = "SELECT * FROM users_like_blogs WHERE users_id = ? AND blogs_id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setInt(2, blogid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Check Like or Unlike error!"+e);
		}
		return false;
	}
	
	
	//For Add the Comment
	public ResultMessage AddComment(CommentsDTO comment,int userid) {
		String sql = "INSERT INTO comments(comment_content,comment_user_name,comment_user_id,blogs_id) VALUES(?,?,?,?)";
		UserRepository user_repo = new UserRepository();
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, comment.getContent());
			String username = user_repo.findUserNameById(userid);
			ps.setString(2, username);
			ps.setInt(3, userid);
			ps.setInt(4, comment.getBlogs_id());
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Add Comment Successfully");
			}else {
				rm.setMessage("Add Comment Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add Comment Error!"+e);
		}
		return rm;
	}
	
	
	//For Edit the Comment
	public ResultMessage EditComment(int commentid,CommentsDTO comment) {
		String sql = "UPDATE comments SET comment_content = ? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, comment.getContent());
			ps.setInt(2, commentid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Edit Comment Successfully");
			}
			else {
				rm.setMessage("Edit Comment Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Edit Comment Error!"+e);
		}
		return rm;
	}
	
	//Find comment by id
	public CommentsDTO findCommentById(int commentid) {
		String sql = "SELECT * FROM comments WHERE id = ?";
		CommentsDTO comment = new CommentsDTO();
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, commentid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				comment.setBlogs_id(rs.getInt("blogs_id"));
				comment.setComment_user_id(rs.getInt("comment_user_id"));
				comment.setComment_user_name(rs.getString("comment_user_name"));
				comment.setContent(rs.getString("comment_content"));
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find Comment by id error"+e);
		}
		return comment;
	}
	
	//For Delete The Comment
	public ResultMessage DeleteComment(int commentid) {
		String sql = "DELETE FROM comments WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, commentid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Delete Comment Successfully");
			}else {
				rm.setMessage("Delete Comment Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Delete Comment Error!"+e);
		}
		return rm;
	}
	
	
	//For View the Detail about Blog
	public BlogResponseDTO FindBlogById(int blogid,int userid/* Login ဝင်ထားတဲ့သူရဲuserid */ ) {
		BlogResponseDTO blog = new BlogResponseDTO();
		String sql = "SELECT b.id, b.code,b.title,b.views,b.content,b.created_at,c.name AS category_name,b.categories_id,b.photo,b.users_id,u.name AS users_name,u.profile AS user_profile FROM categories c INNER JOIN blogs b ON c.id = b.categories_id INNER JOIN users u ON b.users_id = u.id WHERE b.id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				blog.setId(rs.getInt("id"));
				blog.setCode(rs.getString("code"));
				blog.setTitle(rs.getString("title"));
				blog.setContent(rs.getString("content"));
				
				//Show blogs when it post
				LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();
				String timeago = getTimeAgo(createdAt);
				blog.setCreatedAt(timeago);
				
				//Store blogs view
				if(storeUserView(blogid, userid)) {//Check user view already exist or not( 1 user 1 view)
					int currentViews = rs.getInt("views");
					int newViews = currentViews+1;
					updateView(blogid,newViews);
				}
				blog.setViews(rs.getInt("views"));
				blog.setCategories_name(rs.getString("category_name"));
				blog.setCategories_id(rs.getInt("categories_id"));
				byte[] photoImageBytes = rs.getBytes("photo");
	            if (photoImageBytes != null && photoImageBytes.length > 0) {
	                // Encode profile image byte array to base64 string
	                String encodedPhoto = Base64.getEncoder().encodeToString(photoImageBytes);
	                // Set the base64-encoded profile image string in UserResponseDTO
	                blog.setEncodedPhoto(encodedPhoto);
	            }
	            
	            byte[] userPhotoImageBytes = rs.getBytes("user_profile");
	            if (userPhotoImageBytes != null) {
	                String encodedUserProfile = Base64.getEncoder().encodeToString(userPhotoImageBytes);
	                blog.setEncodeProfile(encodedUserProfile);
	            }
	            
				blog.setUsers_id(rs.getInt("users_id"));
				blog.setUsername(rs.getString("users_name"));
				
				//Count likes from blog
				sql = "SELECT COUNT(*) counts FROM users_like_blogs WHERE blogs_id = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, blogid);
				rs = ps.executeQuery();
				if(rs.next()) {  //Likes ရှိမရှိစစ်မယ် 
					blog.setLikes_counts(rs.getInt("counts")); //Likesတွေ၁ခု (သို့) ၁ခုထက်ပိုရှိရင် countအရေအတွက်ယူမယ်
				}else {
					blog.setLikes_counts(0); // Likesတွေမရှိဘူးဆို0လို့ထားလိုက်မယ်
				}
				
				//Count comments from blog
				sql = "SELECT COUNT(*) counts FROM comments WHERE blogs_id = ?;";
				ps= con.prepareStatement(sql);
				ps.setInt(1, blogid);
				rs = ps.executeQuery();
				if(rs.next()) {//Comments ရှိမရှိစစ်မယ် 
					blog.setComments_counts(rs.getInt("counts")); //Comments တွေ၁ခု (သို့) ၁ခုထက်ပိုရှိရင် countအရေအတွက်ယူမယ်
				}else {
					blog.setComments_counts(0); // Comments တွေမရှိဘူးဆို0လို့ထားလိုက်မယ်
				}
				
				//Find comments form blog
				sql = "SELECT * FROM comments WHERE blogs_id = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, blogid);
				rs = ps.executeQuery();
				List<CommentsResponseDTO> comments = new ArrayList<>();
				while(rs.next()) {
					CommentsResponseDTO comment = new CommentsResponseDTO();
					comment.setId(rs.getInt("id"));
					comment.setContent(rs.getString("comment_content"));
					comment.setComment_user_id(rs.getInt("comment_user_id"));
					comment.setComment_user_name(rs.getString("comment_user_name"));
					comment.setBlogs_id(rs.getInt("blogs_id"));
					
					comments.add(comment);
				}
				blog.setComments(comments);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find BLog By Id Error!:"+e);
		}
		return blog;
	}
	
	
	//For update or increase the views of blog
	private void updateView(int blogId,int views) { //View တွေကိုupdateလုပ်ပေးတဲ့method 
		String sql = "UPDATE blogs SET views = ? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, views);
			ps.setInt(2, blogId);
			ps.executeUpdate();
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.update view error!"+e);
		}
	}
	
	
	//For show the what time user created the blog
	private String getTimeAgo(LocalDateTime createdAt) { //Userဖတ်လို့ရအောင်DBထဲကTIMESTAMPကိုပြောင်းပေးတဲ့method
		LocalDateTime currentTime = LocalDateTime.now();
		Duration duration = Duration.between(createdAt, currentTime);
		long seconds = duration.getSeconds();
		long minutes = duration.toMinutes();
		long hours = duration.toHours();
		long days = duration.toDays();
		
		if(seconds < 60) {
			return seconds + " seconds ago";
		}else if(minutes < 60) {
			return minutes + " minutes ago";
		}else if(hours < 24) {
			return hours + " hours ago";
		}else if(days < 7) {
			return days + " days ago";
		}else {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, uuu",Locale.ENGLISH);
			return createdAt.format(formatter);
		}
	}
	
	
	//For store who views the blogs and validate for 1 user 1 view
	private boolean storeUserView(int blogid,int userid) { //ဘယ်userကဝင်ကြည့်ပီးပီလဲstoreလုပ်တဲ့method
		String sql = "SELECT * FROM users_views WHERE blog_id = ? AND user_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			ps.setInt(2, userid);
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) {
				sql = "INSERT INTO users_views (blog_id,user_id) VALUES(?,?)";
				ps = con.prepareStatement(sql);
				ps.setInt(1, blogid);
				ps.setInt(2, userid);
				ps.executeUpdate();
				return true;
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Stor User View error!"+e);
		}
		return false;
	}
	
	// For Find the user posted blogs
	public List<BlogResponseDTO> findpostBlogs(int userid){ //usersတစ်ယောက်ရဲ့တင်ထားတဲ့blogsတွေကိုရှာတဲ့Method
		List<BlogResponseDTO> blogs = new ArrayList<>();
		String sql = "SELECT b.id, b.code,b.title,b.content,b.created_at,c.name AS category_name,b.categories_id,b.views, b.photo,b.users_id,u.name AS users_name FROM categories c INNER JOIN blogs b ON c.id = b.categories_id INNER JOIN users u ON b.users_id = u.id WHERE b.users_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BlogResponseDTO blog = new BlogResponseDTO();
				blog.setId(rs.getInt("id"));
				blog.setCode(rs.getString("code"));
				blog.setTitle(rs.getString("title"));
				blog.setContent(rs.getString("content"));
				
				//Show blogs when it post
				LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();
				String timeago = getTimeAgo(createdAt);
				blog.setCreatedAt(timeago);
				
				blog.setCategories_name("category_name");
				blog.setCategories_id(rs.getInt("categories_id"));
				byte[] blogPhotoImageBytes = rs.getBytes("photo");
	            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
	                // Encode profile image byte array to base64 string
	                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
	                // Set the base64-encoded profile image string in UserResponseDTO
	                blog.setEncodedPhoto(encodedBlogPhoto);
	            }
				blog.setViews(rs.getInt("views"));
				blog.setUsers_id(rs.getInt("users_id"));
				blog.setUsername(rs.getString("users_name"));
				blogs.add(blog);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.find post blogs error"+e);
		}
		return blogs;
	}
	
	
	//For Find the user like blogs
	public List<BlogResponseDTO> findLikeBlogsByuserid(int userid){
		List<BlogResponseDTO> blogs = new ArrayList<>();
		String sql = "SELECT b.id,b.code, b.title, b.content, b.created_at, c.name AS category_name,b.categories_id, b.photo, u.id AS user_id, u.name AS user_name FROM blogs b INNER JOIN categories c ON b.categories_id = c.id INNER JOIN users_like_blogs ub ON b.id = ub.blogs_id INNER JOIN users u ON ub.users_id = u.id WHERE ub.users_id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BlogResponseDTO blog = new BlogResponseDTO();
				blog.setId(rs.getInt("id"));	
				blog.setCode(rs.getString("code"));
				blog.setTitle(rs.getString("title"));
				
				blog.setContent(rs.getString("content"));
				//Show blogs when it post
				LocalDateTime createAt = rs.getTimestamp("created_at").toLocalDateTime();
				String timeago = getTimeAgo(createAt);
				blog.setCreatedAt(timeago);
				
				blog.setCategories_name(rs.getString("category_name"));
				blog.setCategories_id(rs.getInt("categories_id"));
				byte[] blogPhotoImageBytes = rs.getBytes("photo");
	            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
	                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
	                blog.setEncodedPhoto(encodedBlogPhoto);
	            }
				blog.setUsers_id(rs.getInt("user_id"));
				blog.setUsername(rs.getString("user_name"));
				
				blogs.add(blog);
			}
		}catch(SQLException e) {
			System.out.println("SQl Exception occured.Find Like Blogs error occured."+e);
		}
		return blogs;
	}
	
	//For Find the user saved blogs by userid
	public List<BlogResponseDTO> findsaveBlogsbyUserid(int userid){ //User တစ်ယောက်ဆေ့ထားတဲ့blogတွေကိုရှာထားတဲ့method
		List<BlogResponseDTO> blogs = new ArrayList<>();
		String sql = "SELECT b.id,b.code, b.title, b.content, b.created_at, c.name AS category_name,b.categories_id, b.photo, u.id AS user_id, u.name AS user_name FROM blogs b INNER JOIN categories c ON b.categories_id = c.id INNER JOIN users_save_blogs ub ON b.id = ub.blogs_id INNER JOIN users u ON ub.users_id = u.id WHERE ub.users_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BlogResponseDTO blog = new BlogResponseDTO();
				blog.setId(rs.getInt("id"));
				blog.setCode(rs.getString("code"));
				blog.setTitle(rs.getString("title"));
				
				blog.setContent(rs.getString("content"));
				LocalDateTime createAt = rs.getTimestamp("created_at").toLocalDateTime();
				String timeago = getTimeAgo(createAt);
				blog.setCreatedAt(timeago);
				
				blog.setCategories_name(rs.getString("category_name"));
				blog.setCategories_id(rs.getInt("categories_id"));
				byte[] blogPhotoImageBytes = rs.getBytes("photo");
	            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
	                // Encode profile image byte array to base64 string
	                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
	                // Set the base64-encoded profile image string in UserResponseDTO
	                blog.setEncodedPhoto(encodedBlogPhoto);
	            }
				blog.setUsers_id(rs.getInt("user_id"));
				blog.setUsername(rs.getString("user_name"));
				
				blogs.add(blog);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.find save blogs error"+e);
		}
		return blogs;
	}
	
	//For Find the user saved blogs by blogid
		public List<BlogResponseDTO> findsaveBlogsByBlogid(int blogid){ //User တစ်ယောက်ဆေ့ထားတဲ့blogတွေကိုရှာထားတဲ့method
			List<BlogResponseDTO> blogs = new ArrayList<>();
			String sql = "SELECT b.id,b.code, b.title, b.content, b.created_at, c.name AS category_name,b.categories_id, b.photo, u.id AS user_id, u.name AS user_name FROM blogs b INNER JOIN categories c ON b.categories_id = c.id INNER JOIN users_save_blogs ub ON b.id = ub.blogs_id INNER JOIN users u ON ub.users_id = u.id WHERE ub.blogs_id = 1";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, blogid);
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					BlogResponseDTO blog = new BlogResponseDTO();
					blog.setId(rs.getInt("id"));	
					blog.setCode(rs.getString("code"));
					blog.setTitle(rs.getString("title"));
					
					//Show blogs when it post
					LocalDateTime createAt = rs.getTimestamp("created_at").toLocalDateTime();
					String timeago = getTimeAgo(createAt);
					blog.setCreatedAt(timeago);
					
					blog.setCategories_name(rs.getString("category_name"));
					blog.setCategories_id(rs.getInt("categories_id"));
					byte[] blogPhotoImageBytes = rs.getBytes("profile");
		            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
		                // Encode profile image byte array to base64 string
		                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
		                // Set the base64-encoded profile image string in UserResponseDTO
		                blog.setEncodedPhoto(encodedBlogPhoto);
		            }
					blog.setUsers_id(rs.getInt("user_id"));
					blog.setUsername(rs.getString("user_name"));
					
					blogs.add(blog);
				}
			}catch(SQLException e) {
				System.out.println("SQL Exception occured.find save blogs error"+e);
			}
			return blogs;
		}
	
	
	//For Find random blogs (not finished)
	public List<BlogResponseDTO> randomBlogs(){ //home pageမှာဖစ်ဖစ်ဘယ်မှာဖစ်ဖစ်blogတွေကိုrandomထုတ်ပေးသောmethod ဘယ်categoryကဘယ်ဟာဆိုပီးမခွဲပဲအကုန်randomပြပေး
		List<BlogResponseDTO> blogs = new ArrayList<>();
		String sql = "SELECT b.id,b.code,b.title,b.content,b.created_at,b.views, c.name AS category_name,b.categories_id,b.photo,b.users_id,u.name AS user_name,u.profile AS user_profile FROM categories c INNER JOIN blogs b ON c.id = b.categories_id INNER JOIN users u ON b.users_id = u.id ORDER BY RAND();";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BlogResponseDTO blog = new BlogResponseDTO();
				blog.setId(rs.getInt("id"));
				blog.setCode(rs.getString("code"));
				blog.setTitle(rs.getString("title"));
				blog.setContent(rs.getString("content"));
				
				LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();
				String timeago = getTimeAgo(createdAt);
				blog.setCreatedAt(timeago);
				
				blog.setViews(rs.getInt("views"));
				blog.setCategories_name(rs.getString("category_name"));
				blog.setCategories_id(rs.getInt("categories_id"));
				byte[] blogPhotoImageBytes = rs.getBytes("photo");
	            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
	                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
	                blog.setEncodedPhoto(encodedBlogPhoto);
	            }
	            
	            byte[] userPhotoImageBytes = rs.getBytes("user_profile");
	            if (userPhotoImageBytes != null) {
	                String encodedUserProfile = Base64.getEncoder().encodeToString(userPhotoImageBytes);
	                blog.setEncodeProfile(encodedUserProfile);
	            }
	            String commentsCountQuery = "SELECT COUNT(*) counts FROM comments WHERE blogs_id = ?";
                try (PreparedStatement commentPs = con.prepareStatement(commentsCountQuery)) {
                    commentPs.setInt(1, blog.getId());
                    try (ResultSet commentRs = commentPs.executeQuery()) {
                        if (commentRs.next()) {
                            blog.setComments_counts(commentRs.getInt("counts"));
                        } else {
                            blog.setComments_counts(0);
                        }
                    }
             }
                String likesCountQuery = "SELECT COUNT(*) counts FROM users_like_blogs WHERE blogs_id = ?";
                try (PreparedStatement likePs = con.prepareStatement(likesCountQuery)) {
                	likePs.setInt(1, blog.getId());
                	try (ResultSet likeRs = likePs.executeQuery()) {
                		if (likeRs.next()) {
                			blog.setLikes_counts(likeRs.getInt("counts"));
                		} else {
                			blog.setLikes_counts(0);
                		}
                	}
                }
				blog.setUsers_id(rs.getInt("users_id"));
				blog.setUsername(rs.getString("user_name"));
				
				blogs.add(blog);
			}
			
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find random blogs error"+e);
		}
		return blogs;
	}
	
	
	//For Find the most views blogs
	public List<BlogResponseDTO> MostViewsBlog(){ //View အများဆုံးBlog 3ခုကိုယူသောmethod
		List<BlogResponseDTO> blogs = new ArrayList<>();
		String sql = "SELECT b.id,b.code,b.title,b.created_at,b.views, c.name AS category_name,b.photo,b.users_id,u.name AS user_name FROM categories c INNER JOIN blogs b ON c.id = b.categories_id INNER JOIN users u ON b.users_id = u.id ORDER BY views DESC LIMIT 3;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BlogResponseDTO blog = new BlogResponseDTO();
				blog.setId(rs.getInt("id"));
				blog.setCode(rs.getString("code"));
				blog.setTitle(rs.getString("title"));
				blog.setViews(rs.getInt("views"));
				blog.setCategories_name(rs.getString("category_name"));
				byte[] blogPhotoImageBytes = rs.getBytes("photo");
	            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
	                // Encode profile image byte array to base64 string
	                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
	                // Set the base64-encoded profile image string in UserResponseDTO
	                blog.setEncodedPhoto(encodedBlogPhoto);
	            }
				blog.setUsers_id(rs.getInt("users_id"));
				blog.setUsername(rs.getString("user_name"));
				
				blogs.add(blog);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find most views blogs error"+e);
		}
		return blogs;
	}
	
	//For Find the code by ID
	public int findidbyCode(String code){
		String sql = "SELECT id FROM blogs WHERE code = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, code);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getInt("id");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find Id By code Error"+e);
		}
		return 0;
	}
	
	//For Find the permissions
		public String findPermission(int userid) {
			String sql = "SELECT status FROM blogger_users WHERE users_id = ?;";
			String permission = "";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, userid);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {
					permission = rs.getString("status");
				}else {
					return null;
				}
			}catch(SQLException e) {
				System.out.println("SQL Exception occured.Find Permission By User id"+e);
			}
			return permission;
		}
	//For findBlogforedit
		public BlogDTO findBlogForEdit(int blogid) {
			String sql = "SELECT * FROM blogs WHERE id = ?";
			BlogDTO blog = new BlogDTO();
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, blogid);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {
					blog.setCode(rs.getString("code"));
					blog.setTitle(rs.getString("title"));
					blog.setContent(rs.getString("content"));
					blog.setCategories_id(rs.getInt("categories_id"));
					blog.setPhoto(rs.getBytes("photo"));
				}
			}catch(SQLException e) {
				System.out.println("SQL Exception occured.Find Blog for edit error!"+e);
			}
			return blog;
		}
		public List<BlogResponseDTO> findBlogsByCategory(int categoryId){
			List<BlogResponseDTO> blogs = new ArrayList<>();
			String sql = "SELECT b.*,u.name AS user_name,c.name AS category_name FROM  blogs b LEFT JOIN categories c ON b.categories_id = c.id INNER JOIN users u ON b.users_id = u.id WHERE categories_id = ?;";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, categoryId);
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					BlogResponseDTO blog = new BlogResponseDTO();
					blog.setId(rs.getInt("id"));
					blog.setCode(rs.getString("code"));
					blog.setTitle(rs.getString("title"));
					blog.setContent(rs.getString("content"));
					
					LocalDateTime createdAt = rs.getTimestamp("created_at").toLocalDateTime();
					String timeago = getTimeAgo(createdAt);
					blog.setCreatedAt(timeago);
					
					blog.setViews(rs.getInt("views"));
					blog.setCategories_name(rs.getString("category_name"));
					blog.setCategories_id(rs.getInt("categories_id"));
					byte[] blogPhotoImageBytes = rs.getBytes("photo");
		            if (blogPhotoImageBytes != null && blogPhotoImageBytes.length > 0) {
		                String encodedBlogPhoto = Base64.getEncoder().encodeToString(blogPhotoImageBytes);
		                blog.setEncodedPhoto(encodedBlogPhoto);
		            }
		            blog.setViews(rs.getInt("views"));
					blog.setUsers_id(rs.getInt("users_id"));
					blog.setUsername(rs.getString("user_name"));
					blog.setCategories_name(rs.getString("category_name"));
					
					blogs.add(blog);
				}
			}catch(SQLException e) {
				System.out.println("SQL Exception occured.Find Blog By Categories error!"+e);
			}
			return blogs;
		}
		
		public int findBloggeruseridByBlogId(int blogid) {
			int userid =0;
			String sql = "SELECT users_id FROM blogs WHERE id = ? ";
			try {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, blogid);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {
					userid = rs.getInt("users_id");
				}
			}catch (SQLException e) {
				System.out.println("SQL Exception Occured.Find Blogger_userid by Blog Code Error"+e);
			}
			return userid;
		}
}
