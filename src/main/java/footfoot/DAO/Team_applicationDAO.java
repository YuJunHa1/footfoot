package footfoot.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Team_applicationDAO {
	private Connection conn;
	private ResultSet rs;
	
	public Team_applicationDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/footfoot";
			String dbID = "root";
			String dbPassword = "wnsgk7575";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int application(int team_id, String user_id, String content) {
		String SQL = "INSERT INTO team_application (team_id, user_id, content) VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, team_id);
			pstmt.setString(2, user_id);
			pstmt.setString(3, content);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
            e.printStackTrace(); // 로그
            return -1; // DB 오류
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // DB 오류
        }
		
	}
}
