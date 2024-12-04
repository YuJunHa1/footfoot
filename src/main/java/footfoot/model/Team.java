package footfoot.model;

public class Team {

	private int team_id;
	private String team_name;
	private String logo_url;
	private String team_description;
	private String team_level;
	private String is_recruiting;
	private String leader_id;
	private int meeting_day;
	private int recruit_position;
	private java.time.LocalDateTime created_at;
	private String team_local;
	
	public int getTeam_id() {
		return team_id;
	}
	public void setTeam_id(int team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getLogo_url() {
		return logo_url;
	}
	public void setLogo_url(String logo_url) {
		this.logo_url = logo_url;
	}
	public String getTeam_description() {
		return team_description;
	}
	public void setTeam_description(String team_description) {
		this.team_description = team_description;
	}
	public String getTeam_level() {
		return team_level;
	}
	public void setTeam_level(String team_level) {
		this.team_level = team_level;
	}
	public String getIs_recruiting() {
		return is_recruiting;
	}
	public void setIs_recruiting(String is_recruiting) {
		this.is_recruiting = is_recruiting;
	}
	public String getLeader_id() {
		return leader_id;
	}
	public void setLeader_id(String leader_id) {
		this.leader_id = leader_id;
	}
	public int getMeeting_day() {
		return meeting_day;
	}
	public void setMeeting_day(int meeting_day) {
		this.meeting_day = meeting_day;
	}
	public int getRecruit_position() {
		return recruit_position;
	}
	public void setRecruit_position(int recruit_position) {
		this.recruit_position = recruit_position;
	}
	public java.time.LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(java.time.LocalDateTime created_at) {
		this.created_at = created_at;
	}
	public String getTeam_local() {
		return team_local;
	}
	public void setTeam_local(String team_local) {
		this.team_local = team_local;
	}
	
	
}
