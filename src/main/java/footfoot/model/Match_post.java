package footfoot.model;
import java.time.LocalDateTime;

public class Match_post extends Post{

	private int post_id;
	private String match_date;
	private String match_local;
	private String location;
	
	
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getMatch_date() {
		return match_date;
	}
	public void setMatch_date(String match_date) {
		this.match_date = match_date;
	}
	public String getMatch_local() {
		return match_local;
	}
	public void setMatch_local(String match_local) {
		this.match_local = match_local;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
}
