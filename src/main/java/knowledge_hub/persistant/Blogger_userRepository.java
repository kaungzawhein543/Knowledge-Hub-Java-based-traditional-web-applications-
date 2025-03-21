package knowledge_hub.persistant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import knowledge_hub.models.Blogger_userDTO;
import knowledge_hub.models.Blogger_userResponseDTO;
import knowledge_hub.utils.ResultMessage;

public class Blogger_userRepository {
		static Connection con = null;
		static {
			con = MyConnection.getConnection();
		}
		@Autowired
		ResultMessage rm;
	
	//Add BloggerInfo
	public ResultMessage addBloggerInfo(Blogger_userDTO blogeruser,int userid){
		String sql = "INSERT INTO blogger_users (name,email,address,education,ph_contact,users_id) VALUES(?,?,?,?,?,?);";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, blogeruser.getName());
			ps.setString(2, blogeruser.getEmail());
			ps.setString(3, blogeruser.getAddress());
			ps.setString(4, blogeruser.getEducation());
			ps.setString(5, blogeruser.getPh_contact());
			ps.setInt(6, userid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Register for blogger successfully");
			}else {
				rm.setMessage("Register for blogger failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add blogger info error"+e);
		}
		return rm;
	}
	
	
	//Edit BloggerInfo
	public ResultMessage editBloggerInfo(Blogger_userDTO blogeruser,int userid) {
		String sql = "UPDATE blogger_users SET name = ?,email = ?,address = ?,education = ?,ph_contact = ?,personality = ? user_id = ? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, blogeruser.getName());
			ps.setString(2, blogeruser.getEmail());
			ps.setString(3, blogeruser.getAddress());
			ps.setString(4, blogeruser.getEducation());
			ps.setString(5, blogeruser.getPh_contact());
			ps.setString(6, blogeruser.getPersonality());
			ps.setInt(7, userid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Edit Blogger info succesfully");
			}else {
				rm.setMessage("Edit Blogger info Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured!Edit blogger Info error"+e);
		}
		return rm;
	}
	
	
	//Delete BloggerInfo
	public ResultMessage deleteBloggerInfo(int bloggerid) {
		String sql = "DELETE FROM blogger_users WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bloggerid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Remove Blogger's permission info successfully");
			}else {
				rm.setMessage("Delete Blogger info Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Delete Blogger Info error"+e);
		}
		return rm;
	}
	
	
	//Find All BloggerInfo
	public List<Blogger_userResponseDTO> findAllBloggerInfo() {
		List<Blogger_userResponseDTO> bloggers = new ArrayList<>();
		String sql = "SElECT bu.*,u.roles_id FROM blogger_users bu INNER JOIN users u ON bu.users_id = u.id;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Blogger_userResponseDTO blogger = new Blogger_userResponseDTO();
				blogger.setId(rs.getInt("id"));
				blogger.setName(rs.getString("name"));
				blogger.setEmail(rs.getString("email"));
				blogger.setAddress(rs.getString("address"));
				blogger.setEducation(rs.getString("education"));
				blogger.setPh_contact(rs.getString("ph_contact"));
				blogger.setStatus(rs.getString("status"));
				blogger.setPersonality(rs.getString("personality"));
				blogger.setUser_id(rs.getInt("users_id"));
				blogger.setUser_role(rs.getInt("roles_id"));
				bloggers.add(blogger);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find All Bloggers info error"+e);
		}
		return bloggers;
	}
	
	
	//Find BloggerInfo Detail
	public Blogger_userResponseDTO findBloggerInfoDetail(int bloggerid) {
		Blogger_userResponseDTO bloggerInfo = new Blogger_userResponseDTO();
		String sql = "SELECT * FROM blogger_users WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, bloggerid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				bloggerInfo.setId(rs.getInt("id"));
				bloggerInfo.setName(rs.getString("name"));
				bloggerInfo.setEmail(rs.getString("email"));
				bloggerInfo.setAddress(rs.getString("address"));
				bloggerInfo.setEducation(rs.getString("education"));
				bloggerInfo.setPh_contact(rs.getString("ph_contact"));
				bloggerInfo.setStatus(rs.getString("status"));
				bloggerInfo.setPersonality(rs.getString("personality"));
				bloggerInfo.setUser_id(rs.getInt("users_id"));
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find blogger detail info error"+e);
		}
		return bloggerInfo;
	}
	
	
	//Approve Blogger
	public ResultMessage ApproveBlogger(int bloggerid) {
		String sql = "UPDATE blogger_users SET status = ? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "approve");
			ps.setInt(2, bloggerid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Approved blogger Successfully");
			}else {
				rm.setMessage("Approved blogger Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Approve blogger to user to error"+e);
		}
		return rm;
	}
	
	
	//Decline Blogger
	public ResultMessage DeclineBlogger(int bloggerid) {
		String sql = "UPDATE blogger_users SET status = ? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "declined");
			ps.setInt(2, bloggerid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Declined blogger Successfully");
			}else {
				rm.setMessage("Declined blogger Failed");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Decline blogger to user to error"+e);
		}
		return rm;
	}
	
	public List<Blogger_userResponseDTO> findPopularBloggers(){
		List<Blogger_userResponseDTO> bloggers = new ArrayList<>();
		String sql = "SELECT bu.id, bu.name,u.profile, COUNT(ulb.users_id) AS like_count,u.id AS users_id FROM knowledge_hub.blogger_users bu INNER JOIN knowledge_hub.blogs b ON bu.users_id = b.users_id LEFT JOIN knowledge_hub.users_like_blogs ulb ON b.id = ulb.blogs_id INNER JOIN users u ON bu.users_id = u.id GROUP BY bu.id, bu.name,u.profile,u.id ORDER BY like_count DESC LIMIT 10;";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Blogger_userResponseDTO blogger = new Blogger_userResponseDTO();
				blogger.setUser_id(rs.getInt("id"));
				blogger.setName(rs.getString("name"));
				byte[] bloggerProfileBytes = rs.getBytes("profile");
				if(bloggerProfileBytes != null && bloggerProfileBytes.length > 0) {
					String encodePhoto = Base64.getEncoder().encodeToString(bloggerProfileBytes);
					blogger.setEncodedProfile(encodePhoto);
				}
				blogger.setUser_id(rs.getInt("users_id"));
				blogger.setLikeCounts(rs.getInt("like_count"));
				bloggers.add(blogger);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.find all famous bloggers"+e);
		}
		return bloggers;
	}
	public String findBloggerStatus(HttpSession session) {
		String result = "";
		String sql = "SELECT status FROM blogger_users WHERE users_id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, (int)session.getAttribute("userId"));
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				String status = rs.getString("status");
				if(status != null) {
					if (status.equals("approve") || status.equals("decline") || status.equals("requested")) {
			            result = status;
			        }
				}
			}else {
				result = "No avaliable";
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find blogger status error happened.");
		}
		return result;
	}
}
