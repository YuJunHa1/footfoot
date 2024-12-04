package footfoot.controller;

import footfoot.DAO.TeamDAO;
import footfoot.model.Team;
import footfoot.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class TeamMembersHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String teamIdParam = request.getParameter("team_id");

        if (teamIdParam == null || teamIdParam.isEmpty()) {
            request.setAttribute("errorMsg", "유효하지 않은 팀입니다.");
            return "main";
        }

        int teamId = Integer.parseInt(teamIdParam);

        TeamDAO teamDAO = new TeamDAO();
        List<User> members = teamDAO.getMembers(teamId);

        if (members == null) {
            request.setAttribute("errorMsg", "멤버를 불러오는데 실패했습니다.");
            return "main";
        }

        request.setAttribute("teamId", teamId);
        request.setAttribute("members", members);
        return "teamMembers"; // teamMembers.jsp
    }
}