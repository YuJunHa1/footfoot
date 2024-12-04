package footfoot.controller;

import footfoot.DAO.TeamDAO;
import footfoot.model.Team_application;
import footfoot.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class ApplicantListHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String teamIdParam = request.getParameter("team_id");

        if (teamIdParam == null || teamIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        int teamId = Integer.parseInt(teamIdParam);

        TeamDAO teamDAO = new TeamDAO();
        List<Team_application> applicants = teamDAO.getApplicant(teamId);

        request.setAttribute("applicants", applicants);
        return "applicantList"; // applicantList.jsp
    }
}