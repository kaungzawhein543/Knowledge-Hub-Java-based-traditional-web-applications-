package knowledge_hub.persistant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {
	static Connection con = null;
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/knowledge_hub","root","root");
		}catch(ClassNotFoundException e) {
			System.out.println("Class Not Found Exception occured;"+e);
		}catch(SQLException e) {
			System.out.println("SQL Exception occured;"+e);
		}
		return con;
	}
}
