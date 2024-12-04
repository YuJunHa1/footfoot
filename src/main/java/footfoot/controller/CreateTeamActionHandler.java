package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.TeamDAO;
import footfoot.DAO.UserDAO;
import footfoot.model.Team;
import footfoot.model.User;

public class CreateTeamActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        String user_id = (String) request.getSession().getAttribute("user_id");
        if (user_id == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login";
        }
        

        // 팀 가입 여부 확인
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(user_id);
        if (user != null && user.getTeam_id() != 0) {
            request.setAttribute("errorMsg", "이미 팀에 가입되어 있습니다.");
            return "teamList";
        }

        // 요청 데이터 수집
        String teamName = request.getParameter("team_name");
        String logoUrl = request.getParameter("logo_url");
        String teamDescription = request.getParameter("team_description");
        String teamLevel = request.getParameter("team_level");
        String isRecruiting = request.getParameter("is_recruiting");
        String teamLocal = request.getParameter("team_local");

        // 비트 플래그 처리 (meeting_day, recruit_position)
        int meetingDayFlags = 0;
        String[] meetingDays = request.getParameterValues("meeting_day");
        if (meetingDays != null) {
            for (String day : meetingDays) {
                meetingDayFlags |= Integer.parseInt(day);
            }
        }

        int recruitPositionFlags = 0;
        String[] recruitPositions = request.getParameterValues("recruit_position");
        if (recruitPositions != null) {
            for (String position : recruitPositions) {
                recruitPositionFlags |= Integer.parseInt(position);
            }
        }

        // 팀 생성
        Team team = new Team();
        team.setTeam_name(teamName);
        team.setLogo_url(logoUrl);
        team.setTeam_description(teamDescription);
        team.setTeam_level(teamLevel);
        team.setIs_recruiting(isRecruiting);
        team.setTeam_local(teamLocal);
        team.setMeeting_day(meetingDayFlags);
        team.setRecruit_position(recruitPositionFlags);
        team.setLeader_id(user_id);

        TeamDAO teamDAO = new TeamDAO();
        int result = teamDAO.create(team);

        if (result == -1 || result == -2) {
        	request.setAttribute("errorMsg", "팀 생성에 실패했습니다.");
            return "createTeam";
        } else {
        	userDAO.joinTeam(result, user_id);
        	return "team"; // 성공 시 팀 목록으로 리디렉션
        }
    }
}