package footfoot.controller;

import footfoot.DAO.TeamDAO;
import footfoot.DAO.UserDAO;
import footfoot.model.Team;
import footfoot.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import java.util.ArrayList;

public class TeamViewHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 팀 ID 가져오기
        int team_id = 0;
        if (request.getParameter("team_id") != null) {
            try {
                team_id = Integer.parseInt(request.getParameter("team_id"));
            } catch (NumberFormatException e) {
                request.setAttribute("errorMsg", "유효하지 않은 팀 정보입니다.");
                return "team";
            }
        }
        
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");
        User user = new UserDAO().getUser(user_id);
        

        // TeamDAO를 이용하여 팀 정보 가져오기
        TeamDAO teamDAO = new TeamDAO();
        Team team = teamDAO.getTeam(team_id);
        if (team == null) {
            request.setAttribute("errorMsg", "해당 팀이 존재하지 않습니다.");
            return "team";
        }

        // 멤버 목록 가져오기
        ArrayList<User> members = teamDAO.getMembers(team_id);

        // 모임 요일 처리 (비트 플래그)
        int[] dayNum = {1, 2, 4, 8, 16, 32, 64};
        String[] dayName = {"월", "화", "수", "목", "금", "토", "일"};
        StringBuilder meetingDaysBuilder = new StringBuilder();
        for (int i = 0; i < dayNum.length; i++) {
            if ((team.getMeeting_day() & dayNum[i]) != 0) {
                if (meetingDaysBuilder.length() > 0) {
                    meetingDaysBuilder.append(", ");
                }
                meetingDaysBuilder.append(dayName[i]);
            }
        }

        // 모집 포지션 처리 (비트 플래그)
        int recruit_position = team.getRecruit_position();
        int[] positionNum = {2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1};
        String[] positionName = {"LW", "ST", "RW", "CAM", "LM", "CM", "RM", "CDM", "LB", "CB", "RB", "GK"};
        StringBuilder recruitPositionsBuilder = new StringBuilder();
        for (int i = 0; i < positionNum.length; i++) {
            if ((recruit_position & positionNum[i]) != 0) {
                if (recruitPositionsBuilder.length() > 0) {
                    recruitPositionsBuilder.append(", ");
                }
                recruitPositionsBuilder.append(positionName[i]);
            }
        }

        // JSP에 전달할 속성 설정
        request.setAttribute("team", team);
        request.setAttribute("members", members);
        request.setAttribute("meetingDays", meetingDaysBuilder.toString());
        request.setAttribute("recruitPositions", recruitPositionsBuilder.toString());
        request.setAttribute("user", user);

        return "teamView"; // teamView.jsp로 포워딩
    }
}