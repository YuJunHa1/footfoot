package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import footfoot.DAO.TeamDAO;
import footfoot.model.Team;

public class TeamHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 페이지 번호 가져오기
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }

        // 팀 목록 가져오기
        TeamDAO teamDAO = new TeamDAO();
        ArrayList<Team> list = teamDAO.getList(pageNumber);

        // Request 속성에 데이터 설정
        request.setAttribute("teamList", list);
        request.setAttribute("pageNumber", pageNumber);

        return "team"; // team.jsp로 포워딩
    }
}