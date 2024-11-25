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
	
	public int write(Post post) {
	    String SQL = "INSERT INTO post (user_id, post_type, title, content) VALUES (?, ?, ?, ?)";
	    try (PreparedStatement pstmt = conn.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
	        pstmt.setString(1, post.getUser_id());
	        pstmt.setString(2, post.getPost_type());
	        pstmt.setString(3, post.getTitle());
	        pstmt.setString(4, post.getContent());

	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected == 0) {
	            return -1; // INSERT 실패
	        }

	        // 생성된 post_id 가져오기
	        int postId;
	        try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                postId = generatedKeys.getInt(1);
	            } else {
	                throw new SQLException("Creating post failed, no ID obtained.");
	            }
	        }

	        // match 타입이면
	        if (post.getPost_type().equals("match") && post instanceof Match_post) {
	            Match_post matchPost = (Match_post) post; // 다운캐스팅
	            matchPost.setPost_id(postId);
	            writeMatchPostDetails(matchPost);
	        }

	        return postId; // 성공적으로 생성된 post_id 반환
	    } catch (SQLException e) {
	        e.printStackTrace(); // 로그
	        return -1; // DB 오류
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1; // 기타 오류
	    }
	}

	private void writeMatchPostDetails(Match_post matchPost) throws SQLException {
	    String matchSQL = "INSERT INTO match_post (post_id, match_date, match_local, location) VALUES (?, ?, ?, ?)";
	    try (PreparedStatement pstmt = conn.prepareStatement(matchSQL)) {
	        pstmt.setInt(1, matchPost.getPost_id());
	        pstmt.setTimestamp(2, Timestamp.valueOf(matchPost.getMatch_date()));
	        pstmt.setString(3, matchPost.getMatch_local());
	        pstmt.setString(4, matchPost.getLocation());

	        pstmt.executeUpdate();
	    }
	}
	
	
	
	public ArrayList<Post> getList(int pageNumber, String post_type) {
		String SQL = "select * from post where post_id < ? and deleted = 0 and post_type=? order by post_id desc limit 10";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			pstmt.setString(2, post_type);
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
				if (post_type.equals("match")) {
	                // Match_post에 추가적인 데이터 로드
	                Match_post match_post = (Match_post) post; // 다운캐스팅
	                loadMatchPostDetails(match_post);
	                list.add(match_post);
	            }//else if(post_type.equals("용병"))
				else {
					list.add(post);
				}
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
				
				if (rs.getString(3).equals("match")) {
	                // Match_post에 추가적인 데이터 로드
	                Match_post match_post = (Match_post) post; // 다운캐스팅
	                loadMatchPostDetails(match_post);
	                return match_post;
	            }
				
				//if (post_type.equals("mercenary")) {
	                // Match_post에 추가적인 데이터 로드
	            //    Match_post matchPost = (Match_post) post; // 다운캐스팅
	            //    loadMatchPostDetails(matchPost);
	            //    return matchPost;
	            //}
				return post;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private void loadMatchPostDetails(Match_post match_post) throws SQLException {
	    String matchSQL = "SELECT match_date, match_local, location FROM match_post WHERE post_id=?";
	    PreparedStatement pstmt = conn.prepareStatement(matchSQL);
	    pstmt.setInt(1, match_post.getPost_id());
	    ResultSet rs = pstmt.executeQuery();

	    if (rs.next()) {
	        match_post.setMatch_date(rs.getTimestamp("match_date").toLocalDateTime());
	        match_post.setMatch_local(rs.getString("match_local"));
	        match_post.setLocation(rs.getString("location"));
	    }
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
