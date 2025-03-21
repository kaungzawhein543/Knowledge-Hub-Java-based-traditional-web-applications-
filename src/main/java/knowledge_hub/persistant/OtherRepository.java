package knowledge_hub.persistant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import knowledge_hub.models.CategoryDTO;
import knowledge_hub.models.CategoryResponseDTO;
import knowledge_hub.models.FeedbackDTO;
import knowledge_hub.models.ReportsDTO;
import knowledge_hub.models.ReportsResponseDTO;

import knowledge_hub.utils.ResultMessage;

public class OtherRepository {
	static Connection con = null;
	static {
		con = MyConnection.getConnection();
	}
	@Autowired
	ResultMessage rm;
	
	//For Category
	//For Add New Category
	public ResultMessage addCategory(CategoryDTO category) {
		String sql = "INSERT INTO categories(name) VALUES(?);";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, category.getName());
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Add Category Successfully");
			}else {
				rm.setMessage("Add Category Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add Category Error :"+e);
		}
		return rm;
	}
	
	//For Edit Category
	public ResultMessage editCategory(CategoryDTO category,int categoryid) {
		String sql = "UPDATE categories SET name = ? WHERE id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, category.getName());
			ps.setInt(2, categoryid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Edit Category Successfully");
			}else {
				rm.setMessage("Edit Category Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception Occured.Edit Category errror."+e);
		}
		return rm;
	}
	
	//For find category by id
	public CategoryDTO findCategoryById(int categoryid) {
		CategoryDTO category = new CategoryDTO();
		String sql = "SELECT name FROM categories WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, categoryid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				category.setName(rs.getString("Name"));
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find Category By Id error"+e);
		}
		return category;
	}
	
	//For Delete Category
	public ResultMessage deleteCategory(int categoryid) {
		String sql = "DELETE FROM categories WHERE id = ?;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, categoryid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Delete Category Successfully");
			}else {
				rm.setMessage("Delete Category Error");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Delete Category error."+e);
		}
		return rm;
	}
	
	//For Find All Category
	public List<CategoryResponseDTO> findAllCategories(){
		String sql = "SELECT * FROM categories;";
		List<CategoryResponseDTO> categories = new ArrayList<>();
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CategoryResponseDTO category = new CategoryResponseDTO();
				category.setId(rs.getInt("id"));
				category.setName(rs.getString("name"));
				
				categories.add(category);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find All Categories error"+e);
		}
		return categories;
	}
	
	//Report CRUD
	//For Add Report
	public ResultMessage addReport(ReportsDTO report) {
		String sql = "INSERT INTO reports(blog_code,blogger_name,content) VALUES(?,?,?);";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, report.getBlog_code());
			ps.setString(2, report.getBlogger_name());
			ps.setString(3, report.getContent());
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Report Successfully");
			}else {
				rm.setMessage("Report Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add Report Error."+e);
		}
		return rm;
	}
	
	//For Delete Report
	public ResultMessage deleteReport(int reportid) {
		String sql = "DELETE FROm reports WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, reportid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Delete Report Successfully");
			}else {
				rm.setMessage("Delete Report Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Delete Report error."+e);
		}
		return rm;
	}
	
	//For Find All Blogs
	public List<ReportsResponseDTO> findAllReports(){
		List<ReportsResponseDTO> reports = new ArrayList<>();
		String sql = "SELECT * FROM reports ORDER BY id DESC;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ReportsResponseDTO report = new ReportsResponseDTO();
				report.setId(rs.getInt("id"));
				report.setBlog_code(rs.getString("blog_code"));
				report.setBlogger_name(rs.getString("blogger_name"));
				report.setContent(rs.getString("content"));
				reports.add(report);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find All Reports error."+e);
		}
		return reports;
	}
	
	//For increase the report count reported blog
	public ResultMessage addReportCount(int blogid,int userid) {
		int rp_counts = 0 ;
		String sql = "SELECT rp_counts FROM blogs WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, blogid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				rp_counts = rs.getInt("rp_counts");
				rp_counts+=1;
			}
			if(rp_counts == 3) {
				sql = "DELETE FROM users_like_blogs WHERE blogs_id = ?;";
				ps = con.prepareStatement(sql);
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
				 if(rm.getResult() != 1) {
					 rm.setMessage("Report verify Failed");
					 return rm;
				 }
				 
				 sql = "UPDATE users SET status = ? WHERE id = ?";
				 ps  = con.prepareStatement(sql);
				 ps.setInt(1, 1);
				 ps.setInt(2, userid);
				 rm.setResult(ps.executeUpdate());
				 if(rm.getResult() != 1) {
					 rm.setMessage("Report verify Failed");
					 return rm;
				 }
			}else {
				sql = "UPDATE blogs SET rp_counts = ? WHERE id = ?";
				PreparedStatement pss = con.prepareStatement(sql);
				pss.setInt(1, rp_counts);
				pss.setInt(2, blogid);
				rm.setResult(pss.executeUpdate());
				if(rm.getResult()==1) {
					rm.setMessage("Report verify Successfully");
				}else {
					rm.setMessage("Report verify Failed");
				}
			}
			
			
		}catch(SQLException e) {
			System.out.println("SQL Excepion occured.Report Verify error"+e);
		}
		return rm;
	}
	
	//For Add Feedbacks
	public ResultMessage addFeedBack(FeedbackDTO feedback) {
		String sql = "INSERT INTO feedbacks (content) VALUES(?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, feedback.getContent());
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Feedback sent successfully");
			}else {
				rm.setMessage("Send Feedback Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add Feed back error"+e);
		}
		return rm;
	}
	
	//For Find All Feed backs
	public List<FeedbackDTO> findAllFeedbacks(){
		List<FeedbackDTO> feedbacks = new ArrayList<>();
		String sql = "SELECT * FROM feedbacks";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				FeedbackDTO feedback = new FeedbackDTO();
				feedback.setContent(rs.getString("content"));
				feedbacks.add(feedback);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find All FeedBacks error");
		}
		return feedbacks;
	}
	
	//Find Category name by id
	public String findCategoryNameById(int categoryid) {
		String name = "";
		String sql = "SELECT name FROM categories WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, categoryid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find Category name by id error"+e);
		}
		return name;
	}
}
