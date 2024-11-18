package footfoot;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class PostDAO {
	private Connection conn;
	private ResultSet rs;
	
	public PostDAO() {
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
	
	public int getNext() {
		String SQL = "select post_id from post order by post_id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB오류
	}
	
	public int write(String user_id, String post_type, String title, String content) {
		String SQL = "INSERT INTO post (user_id, post_type, title, content) VALUES (?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_id);
			pstmt.setString(2, post_type);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
            e.printStackTrace(); // 로그
            return -1; // DB 오류
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // DB 오류
        }
		
	}
	
	public ArrayList<Post> getList(int pageNumber) {
		String SQL = "select * from post where post_id < ? and deleted = 0 order by post_id desc limit 10";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()){
				Post post = new Post();
				post.setPost_id(rs.getInt(1));
				post.setUser_id(rs.getString(2));
				post.setPost_type(rs.getString(3));
				post.setTitle(rs.getString(4));
				post.setContent(rs.getString(5));
				post.setViews(rs.getInt(6));
				post.setCreated_at(rs.getTimestamp(7).toLocalDateTime());
	            post.setUpdated_at(rs.getTimestamp(8).toLocalDateTime());
				post.setDeleted(rs.getInt(9));
				list.add(post);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from post where post_id < ? and deleted = 0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Post getPost(int post_id) {
		String SQL = "select * from post where post_id =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, post_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Post post = new Post();
				post.setPost_id(rs.getInt(1));
				post.setUser_id(rs.getString(2));
				post.setPost_type(rs.getString(3));
				post.setTitle(rs.getString(4));
				post.setContent(rs.getString(5));
				post.setViews(rs.getInt(6));
				post.setCreated_at(rs.getTimestamp(7).toLocalDateTime());
	            post.setUpdated_at(rs.getTimestamp(8).toLocalDateTime());
				post.setDeleted(rs.getInt(9));
				return post;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int post_id, String title, String contnet) {
		String SQL = "update post set title = ?, content = ? where post_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, contnet);
			pstmt.setInt(3, post_id);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
            e.printStackTrace(); // 로그
            return -1; // DB 오류
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // DB 오류
        }
		
	}
	
	public int delete(int post_id) {
		String SQL = "update post set deleted = 1 where post_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, post_id);
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
