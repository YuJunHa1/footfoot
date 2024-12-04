package footfoot.controller;

import footfoot.DAO.TeamDAO;
import footfoot.model.Team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JoinTeamHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userId = (String) request.getSession().getAttribute("user_id");
        if (userId == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login";
        }

        String teamIdParam = request.getParameter("team_id");
        if (teamIdParam == null || teamIdParam.isEmpty()) {
            request.setAttribute("errorMsg", "유효하지 않은 팀입니다.");
            return "team";
        }

        int teamId = Integer.parseInt(teamIdParam);
        TeamDAO teamDAO = new TeamDAO();
        Team team = teamDAO.getTeam(teamId);

        if (team == null) {
            request.setAttribute("errorMsg", "유효하지 않은 팀입니다.");
            return "team";
        }

        request.setAttribute("team", team);
        return "joinTeam"; // joinTeam.jsp
    }
}