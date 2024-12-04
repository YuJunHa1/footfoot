package footfoot.DAO;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;

import footfoot.model.Match_post;
import footfoot.model.Post;

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
	            return -1;
	        }

	        // 생성된 post_id
	        int postId;
	        try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                postId = generatedKeys.getInt(1);
	            } else {
	                throw new SQLException("Creating post failed, no ID obtained.");
	            }
	        }

	        // match 타입인 경우
	        if (post.getPost_type().equals("match")) {
	            post.setPost_id(postId);
	            writeMatchPostDetails(post);
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

	private void writeMatchPostDetails(Post post) throws SQLException {
		Match_post match_post = (Match_post)post;
	    String matchDate = match_post.getMatch_date();
	    if (matchDate == null || matchDate.isEmpty()) {
	        throw new SQLException("Match date is null or empty. Cannot parse to LocalDateTime.");
	    }

	    try {
	        // 문자열이 LocalDateTime 형식에 맞는지 확인하고, 유효한 날짜로 변환
	    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	        LocalDateTime dateTime = LocalDateTime.parse(matchDate, formatter);
	        String matchSQL = "INSERT INTO match_post (post_id, match_date, match_local, location) VALUES (?, ?, ?, ?)";
	        try (PreparedStatement pstmt = conn.prepareStatement(matchSQL)) {
	            pstmt.setInt(1, match_post.getPost_id());
	            pstmt.setTimestamp(2, Timestamp.valueOf(dateTime));
	            pstmt.setString(3, match_post.getMatch_local());
	            pstmt.setString(4, match_post.getLocation());

	            pstmt.executeUpdate();
	        }
	    } catch (DateTimeParseException e) {
	        // 잘못된 날짜 형식이 들어올 경우 처리
	        throw new SQLException("Failed to parse match date: " + matchDate, e);
	    }
	}
	
	
	
	public ArrayList<Post> getList(int pageNumber, String post_type) {
	    String SQL = "select * from post where post_id < ? and deleted = 0 and post_type=? order by post_id desc limit 10";
	    ArrayList<Post> list = new ArrayList<>();
	    try {
	        if (conn == null) {
	            System.out.println("Database connection is null.");
	            return list;
	        }

	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
	        pstmt.setString(2, post_type);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Post post = new Post();
	            post.setPost_id(rs.getInt(1));
	            post.setUser_id(rs.getString(2));
	            post.setPost_type(rs.getString(3));
	            post.setTitle(rs.getString(4));
	            post.setContent(rs.getString(5));
	            post.setViews(rs.getInt(6));

	            Timestamp createdAt = rs.getTimestamp(7);
	            post.setCreated_at(createdAt != null ? createdAt.toLocalDateTime() : null);

	            Timestamp updatedAt = rs.getTimestamp(8);
	            post.setUpdated_at(updatedAt != null ? updatedAt.toLocalDateTime() : null);

	            post.setDeleted(rs.getInt(9));

	            if ("match".equals(post_type)) {
	                Match_post match_post = (Match_post) downCasting(post);
	                loadMatchPostDetails(match_post);
	                list.add(match_post);
	            } else {
	                list.add(post);
	            }
	        }
	    } catch (Exception e) {
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
	                Match_post match_post = (Match_post)downCasting(post); // 다운캐스팅
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
	        match_post.setMatch_date(rs.getTimestamp("match_date").toLocalDateTime().toString());
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
	
	private Post downCasting(Post post) throws SQLException {
	    if ("match".equals(post.getPost_type())) {
	        Match_post match_post = new Match_post();

	        // 공통 속성 복사
	        match_post.setPost_id(post.getPost_id());
	        match_post.setUser_id(post.getUser_id());
	        match_post.setPost_type(post.getPost_type());
	        match_post.setTitle(post.getTitle());
	        match_post.setContent(post.getContent());
	        match_post.setViews(post.getViews());
	        match_post.setCreated_at(post.getCreated_at());
	        match_post.setUpdated_at(post.getUpdated_at());
	        match_post.setDeleted(post.getDeleted());

	        // 추가 정보 로드
	        loadMatchPostDetails(match_post);

	        return match_post;
	    }

	    // 기본적으로 Post 객체 반환
	    return post;
	}
	
}
