package footfoot.controller;

import footfoot.DAO.Team_applicationDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class JoinTeamActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
        String userId = (String) request.getSession().getAttribute("user_id");
        if (userId == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login";
        }

        String teamIdParam = request.getParameter("team_id");
        String content = request.getParameter("content");

        if (teamIdParam == null || content == null || content.isEmpty()) {
            request.setAttribute("errorMsg", "필수 정보가 누락되었습니다.");
            return "joinTeam";
        }

        int teamId = Integer.parseInt(teamIdParam);
        Team_applicationDAO applicationDAO = new Team_applicationDAO();
        int result = applicationDAO.application(teamId, userId, content);

        if (result == -1) {
            request.setAttribute("errorMsg", "데이터베이스 오류가 발생했습니다.");
            return "joinTeam";
        }

        request.setAttribute("successMsg", "가입신청이 완료되었습니다.");
        return "team"; // team.jsp
    }
}