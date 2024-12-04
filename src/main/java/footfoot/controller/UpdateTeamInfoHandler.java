package footfoot.controller;

import footfoot.DAO.TeamDAO;
import footfoot.model.Team;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class UpdateTeamInfoHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int teamId = Integer.parseInt(request.getParameter("team_id"));
        TeamDAO teamDAO = new TeamDAO();
        Team team = teamDAO.getTeam(teamId);

        if (team == null) {
            request.setAttribute("errorMsg", "유효하지 않은 팀입니다.");
            return "error.jsp";
        }

        // 활동 지역 리스트 준비
        List<String> locals = Arrays.asList(
            "서울특별시", "부산광역시", "대구광역시", "인천광역시", 
            "광주광역시", "대전광역시", "울산광역시", "세종특별자치시",
            "경기도", "강원도", "충청북도", "충청남도", "전라북도", 
            "전라남도", "경상북도", "경상남도", "제주특별자치도"
        );

        // 팀 수준과 모집 상태
        List<String> teamLevels = Arrays.asList("상", "중상", "중", "중하", "하");
        List<String> statuses = Arrays.asList("모집중", "모집완료");

        // 모임 요일 리스트
        List<Map<String, Object>> days = new ArrayList<>();
        String[] daysNames = {"월", "화", "수", "목", "금", "토", "일"};
        int[] daysFlags = {1, 2, 4, 8, 16, 32, 64};
        for (int i = 0; i < daysNames.length; i++) {
            Map<String, Object> day = new HashMap<>();
            day.put("name", daysNames[i]);
            day.put("flag", daysFlags[i]);
            day.put("checked", (team.getMeeting_day() & daysFlags[i]) != 0);
            days.add(day);
        }

        // 모집 포지션 리스트
        List<Map<String, Object>> positions = new ArrayList<>();
        String[] positionsNames = {"LW", "ST", "RW", "CAM", "LM", "CM", "RM", "CDM", "LB", "CB", "RB", "GK"};
        int[] positionsFlags = {2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1};
        for (int i = 0; i < positionsNames.length; i++) {
            Map<String, Object> position = new HashMap<>();
            position.put("name", positionsNames[i]);
            position.put("flag", positionsFlags[i]);
            position.put("checked", (team.getRecruit_position() & positionsFlags[i]) != 0);
            positions.add(position);
        }

        // JSP로 데이터 전달
        request.setAttribute("team", team);
        request.setAttribute("locals", locals);
        request.setAttribute("teamLevels", teamLevels);
        request.setAttribute("statuses", statuses);
        request.setAttribute("days", days);
        request.setAttribute("positions", positions);

        return "updateTeamInfo";
    }
}