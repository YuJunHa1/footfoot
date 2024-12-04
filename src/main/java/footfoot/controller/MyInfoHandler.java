package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.TeamDAO;
import footfoot.DAO.UserDAO;
import footfoot.model.Team;
import footfoot.model.User;

public class MyInfoHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String userId = (String) request.getSession().getAttribute("user_id");

        if (userId == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login";
        }

        // User 정보 가져오기
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userId);

        if (user == null) {
            request.setAttribute("errorMsg", "유효하지 않은 사용자입니다.");
            return "error";
        }

        // 소속 팀 정보 가져오기
        TeamDAO teamDAO = new TeamDAO();
        Team team = null;
        if (user.getTeam_id() != 0) {
            team = teamDAO.getTeam(user.getTeam_id());
        }

        request.setAttribute("user", user);
        request.setAttribute("team", team);

        return "myInfo"; // myInfo.jsp로 포워딩
    }
}