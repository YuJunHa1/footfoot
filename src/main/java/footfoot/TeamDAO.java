package footfoot;
import java.time.LocalDateTime;
import java.sql.*;
import java.util.ArrayList;

public class TeamDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public TeamDAO() {
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
	
	public int create(String team_name, String logo_url, String team_description, String team_level,
			String is_recruiting, String leader_id, int meeting_day, int recruit_position,String team_local) {
		String SQL = "INSERT INTO team (team_name, logo_url, team_description, team_level, is_recruiting, "
				+ "leader_id, meeting_day, recruit_position, team_local) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, team_name);
			pstmt.setString(2, logo_url);
			pstmt.setString(3, team_description);
			pstmt.setString(4, team_level);
			pstmt.setString(5, is_recruiting);
			pstmt.setString(6, leader_id);
			pstmt.setInt(7, meeting_day);
			pstmt.setInt(8, recruit_position);
			pstmt.setString(9, team_local);
			return pstmt.executeUpdate();
		}catch (SQLException e) {
            e.printStackTrace(); // 로그
            return -1; // DB 오류
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // DB 오류
        }
	}
	
	public int getNext() {
		String SQL = "select team_id from team order by team_id desc";
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
	
	public ArrayList<Team> getList(int pageNumber) {
		String SQL = "select * from team where team_id < ? order by team_id desc limit 10";
		ArrayList<Team> list = new ArrayList<Team>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()){
				Team team = new Team();
				team.setTeam_id(rs.getInt(1));
				team.setTeam_name(rs.getString(2));
				team.setLogo_url(rs.getString(3));
				team.setTeam_description(rs.getString(4));
				team.setTeam_level(rs.getString(5));
				team.setIs_recruiting(rs.getString(6));
				team.setLeader_id(rs.getString(7));
				team.setMeeting_day(rs.getInt(8));
				team.setRecruit_position(rs.getInt(9));
				team.setCreated_at(rs.getTimestamp(10).toLocalDateTime());
				team.setTeam_local(rs.getString(11));
				list.add(team);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from team where team_id < ?";
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
	
	public Team getTeam(int team_id) {
		String SQL = "select * from team where team_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, team_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Team team = new Team();
				team.setTeam_id(rs.getInt(1));
				team.setTeam_name(rs.getString(2));
				team.setLogo_url(rs.getString(3));
				team.setTeam_description(rs.getString(4));
				team.setTeam_level(rs.getString(5));
				team.setIs_recruiting(rs.getString(6));
				team.setLeader_id(rs.getString(7));
				team.setMeeting_day(rs.getInt(8));
				team.setRecruit_position(rs.getInt(9));
				team.setCreated_at(rs.getTimestamp(10).toLocalDateTime());
				team.setTeam_local(rs.getString(11));
				return team;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Team getTeam(String leader_id) {
		String SQL = "select * from team where leader_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, leader_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Team team = new Team();
				team.setTeam_id(rs.getInt(1));
				team.setTeam_name(rs.getString(2));
				team.setLogo_url(rs.getString(3));
				team.setTeam_description(rs.getString(4));
				team.setTeam_level(rs.getString(5));
				team.setIs_recruiting(rs.getString(6));
				team.setLeader_id(rs.getString(7));
				team.setMeeting_day(rs.getInt(8));
				team.setRecruit_position(rs.getInt(9));
				team.setCreated_at(rs.getTimestamp(10).toLocalDateTime());
				team.setTeam_local(rs.getString(11));
				return team;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(Team team) {
		String SQL = "update team set team_name = ?, logo_url = ?, team_description =?, team_level =?, is_recruiting =?, "
				+ "meeting_day =?, recruit_position =?, team_local =?  where team_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, team.getTeam_name());
			pstmt.setString(2, team.getLogo_url());
			pstmt.setString(3, team.getTeam_description());
			pstmt.setString(4, team.getTeam_level());
			pstmt.setString(5, team.getIs_recruiting());
			pstmt.setInt(6, team.getMeeting_day());
			pstmt.setInt(7, team.getRecruit_position());
			pstmt.setString(8, team.getTeam_local());
			pstmt.setInt(9, team.getTeam_id());
			return pstmt.executeUpdate();
		}catch (SQLException e) {
            e.printStackTrace(); // 로그
            return -1; // DB 오류
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // DB 오류
        }
		
	}
	
	public ArrayList<User> getMembers(int team_id) {
		String SQL = "select * from user where team_id = ?";
		ArrayList<User> members = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  team_id);
			rs = pstmt.executeQuery();
			while (rs.next()){
				User user = new User();
				user.setUser_id(rs.getString(1));
				user.setUser_name(rs.getString(2));
				user.setUser_password(rs.getString(3));
				user.setCreated_at(rs.getTimestamp(4).toLocalDateTime());
				user.setBirthdate(rs.getString(5));
				user.setGender(rs.getString(6));
				user.setTeam_id(rs.getInt(7));
				members.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return members;
	}
		
}
