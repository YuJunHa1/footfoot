<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.UserDAO"%>
<%@ page import="footfoot.User"%>
<%@ page import="footfoot.TeamDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="team" class="footfoot.Team" scope="page"/>
<jsp:setProperty name="team" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footfoot</title>
</head>
<body>
	<%
	String[] meeting_days = request.getParameterValues("meeting_day");
    int meeting_day = 0;
    if (meeting_days != null) {
        for (String day : meeting_days) {
            meeting_day += Integer.parseInt(day);
        }
    }
    team.setMeeting_day(meeting_day);
    
    String[] recruit_positions = request.getParameterValues("recruit_position");
    int recruit_position = 0;
    if (recruit_positions != null) {
        for (String position : recruit_positions) {
        	recruit_position += Integer.parseInt(position);
        }
    }
    team.setRecruit_position(recruit_position);
    
	String user_id = null;
	String leader_id = null;
	if(session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
		leader_id = user_id;
	}
	if (user_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후에 이용하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} 
	
	int team_id = 0;
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUser(user_id);
    if (user != null) {
        team_id = user.getTeam_id();
    }
    if (team_id != 0){
    	PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 팀에 가입되어있습니다.')");
		script.println("location.href = 'team.jsp'");
		script.println("</script>");
    }else{
		TeamDAO teamDAO = new TeamDAO();
		int result = teamDAO.create(team.getTeam_name(), team.getLogo_url(), 
				team.getTeam_description(), team.getTeam_level(), 
				team.getIs_recruiting(), leader_id, team.getMeeting_day(), 
				team.getRecruit_position(), team.getTeam_local());
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert(팀 생성에 실패했습니다.)");
			script.println("history.back()");
			script.println("</script>");
		}else{
			team_id = teamDAO.getTeam(leader_id).getTeam_id();
			userDAO.joinTeam(team_id, user_id);
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'team.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>