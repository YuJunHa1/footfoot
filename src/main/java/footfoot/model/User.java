package footfoot.model;
import java.time.LocalDateTime;

public class User {

		private String user_id;
		private String user_name;
		private String user_password;
		private java.time.LocalDateTime created_at;
		private String birthdate;
		private String gender;
		private int team_id;
		
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getUser_password() {
			return user_password;
		}
		public void setUser_password(String user_password) {
			this.user_password = user_password;
		}
		public String getUser_name() {
			return user_name;
		}
		public void setUser_name(String user_name) {
			this.user_name = user_name;
		}
		public String getBirthdate() {
			return birthdate;
		}
		
		public void setBirthdate(String birthdate) {
	        this.birthdate = birthdate;
	    }
		
		public String getGender() {
			return gender;
		}
		public void setGender(String gender) {
			this.gender = gender;
		}
		public java.time.LocalDateTime getCreated_at() {
			return created_at;
		}
		public void setCreated_at(java.time.LocalDateTime created_at) {
			this.created_at = created_at;
		}
		public int getTeam_id() {
			return team_id;
		}
		public void setTeam_id(int team_id) {
			this.team_id = team_id;
		}
		
		
		
}
