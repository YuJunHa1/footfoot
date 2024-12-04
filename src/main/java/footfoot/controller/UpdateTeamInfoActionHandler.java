package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.TeamDAO;
import footfoot.model.Team;

public class UpdateTeamInfoActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        String userId = (String) request.getSession().getAttribute("user_id");
        if (userId == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login"; // 로그인 페이지로 이동
        }

        // 요청 데이터 수집
        int teamId = Integer.parseInt(request.getParameter("team_id"));
        String teamName = request.getParameter("team_name");
        String teamDescription = request.getParameter("team_description");
        String teamLocal = request.getParameter("team_local");
        String teamLevel = request.getParameter("team_level");
        String isRecruiting = request.getParameter("is_recruiting");

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

        // 팀 정보 업데이트
        Team team = new Team();
        team.setTeam_id(teamId);
        team.setTeam_name(teamName);
        team.setTeam_description(teamDescription);
        team.setTeam_local(teamLocal);
        team.setTeam_level(teamLevel);
        team.setIs_recruiting(isRecruiting);
        team.setMeeting_day(meetingDayFlags);
        team.setRecruit_position(recruitPositionFlags);

        TeamDAO teamDAO = new TeamDAO();
        int result = teamDAO.update(team);

        if (result == -1) {
            request.setAttribute("errorMsg", "팀 정보 수정에 실패했습니다.");
            return "updateTeamInfo"; // 수정 페이지로 이동
        }

        request.setAttribute("successMsg", "팀 정보가 성공적으로 수정되었습니다.");
        return "teamView"; // 팀 상세 페이지로 이동
    }
}