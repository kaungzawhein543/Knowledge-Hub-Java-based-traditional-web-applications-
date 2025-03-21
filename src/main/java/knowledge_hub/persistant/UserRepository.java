package knowledge_hub.persistant;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;


import knowledge_hub.models.LoginDTO;
import knowledge_hub.models.UserRequestDTO;
import knowledge_hub.models.UserResponseDTO;
import knowledge_hub.utils.ResultMessage;

public class UserRepository {
	
	static Connection con = null;
	static {
		con = MyConnection.getConnection();
	}
	
	private final PasswordEncoder passwordEncoder;
    public UserRepository() {
        this.passwordEncoder = new BCryptPasswordEncoder();
    }
    @Autowired
    ResultMessage rm;
    
    
    //For Login
	public ResultMessage login(LoginDTO user,HttpSession session) {
		ResultMessage rm = new ResultMessage();
		String sql = "SELECT * FROM users WHERE email = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				if(rs.getInt("status")==1) {
					rm.setResult(0);
					rm.setMessage("Your acccout is suspended");
					return rm;
				}else if(passwordEncoder.matches(user.getPassword(), rs.getString("password"))) {
					sql = "SELECT u.id,u.name,u.email,r.role_name FROM users u LEFT JOIN roles r ON u.roles_id = r.id WHERE u.email = ?";
					ps = con.prepareStatement(sql);
					ps.setString(1, user.getEmail());
					rs = ps.executeQuery();
					if(rs.next()) {
						rm.setResult(1);
						rm.setMessage("Login Successfully");
						session.setAttribute("login", true);
	                    session.setAttribute("isAdmin", "Admin".equals(rs.getString("role_name")));
	                    session.setAttribute("isSuper_Admin", "Super_Admin".equals(rs.getString("role_name")));
						session.setAttribute("role_name", rs.getString("role_name"));
						session.setAttribute("userId", rs.getInt("id"));
						session.setAttribute("username", rs.getString("name"));
						session.setAttribute("useremail", rs.getString("email"));
					}
				}else {
					rm.setResult(0);
					rm.setMessage("Invalid Password");
				}
			}else {
				rm.setResult(0);
				rm.setMessage("We didn't found that account");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Login Error !"+e);
		}
		return rm;
	}
	
	//For Register And Add User
	public ResultMessage register(UserRequestDTO user) {
		String sql = "SELECT * FROM users WHERE email = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				rm.setResult(0);
				rm.setMessage("Your email is already exist");
				return rm;
			}else {
				sql = "INSERT INTO users(name,email,password,dob,gender) VALUES(?,?,?,?,?)";
				ps = con.prepareStatement(sql);
				ps.setString(1, user.getName());
				ps.setString(2, user.getEmail());
				user.setPassword(passwordEncoder.encode(user.getPassword()));
				ps.setString(3, user.getPassword());
				ps.setString(4, user.getDob());
				ps.setString(5, user.getGender());
				rm.setResult(ps.executeUpdate());
				if(rm.getResult()==1){
					rm.setMessage("Register successfully");
				}else {
					rm.setMessage("Failed to registered User");
				}
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Register error !"+e);
		}
		return rm;
	}


	
	//For Find the  All Users
	public List<UserResponseDTO> findAllUsers(){
		List<UserResponseDTO> users = new ArrayList<>();
		String sql = "SELECT u.*,r.role_name FROM users u LEFT JOIN roles r ON u.roles_id = r.id WHERE r.role_name LIKE '%user%';";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				UserResponseDTO user = new UserResponseDTO();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, uuu",Locale.ENGLISH);
				String dobString = rs.getString("dob");
				LocalDate dob = LocalDate.parse(dobString);
				String formattedDob = dob.format(formatter);
				user.setDob(formattedDob);
				user.setGender(rs.getString("gender"));
				user.setStatus(rs.getInt("status"));
				user.setRole_name(rs.getString("role_name"));
				users.add(user);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find All users Error !");
		}
		return users;
	}
	
	//For find User By id
	public UserResponseDTO findUserById(int userid) {
		UserResponseDTO user = new UserResponseDTO();
		String sql = "SELECT u.*,r.role_name FROM users u LEFT JOIN roles r ON u.roles_id = r.id WHERE u.id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setDob(rs.getString("dob"));
				user.setGender(rs.getString("gender"));
				user.setStatus(rs.getInt("status"));
				user.setRole_name(rs.getString("role_name"));
				byte[] profileImageBytes = rs.getBytes("profile");
	            if (profileImageBytes != null && profileImageBytes.length > 0) {
	                String encodedProfile = Base64.getEncoder().encodeToString(profileImageBytes);
	                user.setEncodedProfile(encodedProfile);
	            }			
	         }else {
				return null;
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find user By Id By Error:"+e);
		}
		return user;
	}
	
	
	//For Upload the profile image
	public ResultMessage uploadProfile(MultipartFile image,int userid) {
		String sql = "UPDATE  users SET profile = ? WHERE id = ?";
	    try (PreparedStatement ps = con.prepareStatement(sql)) {
			byte[] imagedata = image.getBytes();
			ps.setBytes(1, imagedata);
			ps.setInt(2, userid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Photo upload successfully");
			}else {
				rm.setMessage("Photo upload failed!Something is wrong.");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Upload photo error ! "+e);
		}catch(IOException e) {
			System.out.println("IO Exception occured.Error is "+e);
		}
	    return rm;
	}
	
	
	//For Delete the profile image
	public ResultMessage deleteProfile(int userid) {
		String sql = "UPDATE users SET profile = null WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Delete Profile successfully");
			}else {
				rm.setMessage("Delete Photo error");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Delete photo error"+e);
		}
		return rm;
	}
	
	
	//For change status(Active or ban)
	public ResultMessage changeStatus(int status,int userid) {
		String sql = "Update users SET status = ? WHERE id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			if(status == 0 ) {
				ps.setInt(1, 1);
				rm.setMessage("Ban user account Successfully");
			}else {
				ps.setInt(1, 0);
				rm.setMessage("Active user account Successfully");
			}
			ps.setInt(2, userid);
			rm.setResult(ps.executeUpdate());
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Change status error"+e);
		}
		return rm;
	}
	
	
	//For add New Admin
	public ResultMessage addAdmin(UserRequestDTO user) {
		String sql = "INSERT INTO users(name,email,password,dob,gender,roles_id) VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			user.setPassword(passwordEncoder.encode(user.getPassword()));
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getDob());
			ps.setString(5, user.getGender());
			ps.setInt(6, 2);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult()==1) {
				rm.setMessage("Admin add Successfully");
			}else {
				rm.setMessage("Admin add Failed!");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Add admin error "+e);
		}
		return rm;
	}

    	
	//For Find The All Admins
	public List<UserResponseDTO> findAllAdmins(){
		List<UserResponseDTO> admins = new ArrayList<>();
		String sql = "SELECT u.*,r.role_name FROM users u LEFT JOIN roles r ON u.roles_id = r.id WHERE r.role_name LIKE 'Admin%';";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				UserResponseDTO admin = new UserResponseDTO();
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, uuu",Locale.ENGLISH);
				String dobString = rs.getString("dob");
				LocalDate dob = LocalDate.parse(dobString);
				String formattedDob = dob.format(formatter);
				admin.setDob(formattedDob);
				admin.setGender(rs.getString("gender"));
				admin.setStatus(rs.getInt("status"));
				admin.setRole_name(rs.getString("role_name"));
				
				admins.add(admin);
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find All Admins Error!"+e);
		}
		return admins;
	}
	
	
	//For Find Admin By Id
	public UserResponseDTO findAdminById(int adminid) {
		UserResponseDTO admin = new UserResponseDTO();
		String sql = "SELECT * FROM users WHERE id = ? ";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, adminid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setDob(rs.getString("dob"));
				admin.setGender(rs.getString("gender"));
				admin.setStatus(rs.getInt("status"));
			}else {
				return null;
			}
			if(rm.getResult()==1) {
				rm.setMessage("Find Admin succesfully.");
			}else {
				rm.setMessage("Find Admin failed.");
				
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Find Admin By Id error!"+e);
		}
		return admin;
	}
	
	//For Find Username By Id
	public String findUserNameById(int userid) {
		String sql = "SELECT name FROM users WHERE id = ?";
		String name = "";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, userid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}else {
				return null;
			}
		}catch(SQLException e) {
			System.out.println("SQl Exception occured.Find User Name By id"+e);
		}
		return name;
	}
	
	//For change password
	public ResultMessage changePassword(String email,String pw) {
		String sql = "SELECT password  FROM users WHERE email = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				if(passwordEncoder.matches(pw, rs.getString("password"))){
					rm.setResult(0);
					rm.setMessage("*You can't set your old password");
					return rm;
				}
			}
			
			sql = "UPDATE users SET password = ? WHERE email = ?";
			pw = passwordEncoder.encode(pw);
			ps.setString(1, pw);
			ps.setString(2, email);
			rm.setResult(ps.executeUpdate());
			if(rm.getResult() == 0	){
				rm.setMessage("Change password failed");
			}else {
				rm.setMessage("Change password successfull");
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Change password error"+e);
		}
		return rm;
	}
	
	//For check email and get name
	public String checkEmailAndGetName(String email) {
		String name = "";
		String sql = "SELECT name FROM users WHERE email = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				name = rs.getString("name");
			}else {
				return null;
			}
		}catch(SQLException e) {
			System.out.println("SQL Exception occured.Check Email and get name error"+e);
		}
		return name;
	}
	
	
}
