package footfoot;

import java.sql.*;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String user_id, String user_password) {
		String SQL = "select user_password from user where user_id=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(user_password)) {
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 불일치
			}
			return -1; // 아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //DB 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO user (user_id, user_password, user_name, birthdate, gender) VALUES (?, ?, ?, ?, ?)";
	    try {
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, user.getUser_id());
	        pstmt.setString(2, user.getUser_password());
	        pstmt.setString(3, user.getUser_name());
	        pstmt.setDate(4, java.sql.Date.valueOf(user.getBirthdate())); 
	        pstmt.setString(5, user.getGender());
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // DB 오류
	}
	
	public User getUser(String user_id) {
		String SQL = "select * from user where user_id =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUser_id(rs.getString(1));
				user.setUser_name(rs.getString(2));
				user.setUser_password(rs.getString(3));
				user.setCreated_at(rs.getTimestamp(4).toLocalDateTime());
				user.setBirthdate(rs.getString(5).toString());
				user.setGender(rs.getString(6));
				user.setTeam_id(rs.getInt(7));
				return user;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int joinTeam(int team_id, String user_id) {
		String SQL = "update user set team_id = ? where user_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, team_id);
			pstmt.setString(2, user_id);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
            e.printStackTrace(); // 로그
            return -1; // DB 오류
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // DB 오류
        }
		
	}
	
	public int update(User user) {
		String SQL = "update user set user_name = ?, user_password = ? where user_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUser_name());
			pstmt.setString(2, user.getUser_password());
			pstmt.setString(3, user.getUser_id());
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
