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
	int team_id = 0;
	if(request.getParameter("team_id") != null)
		team_id = Integer.parseInt(request.getParameter("team_id"));
	if(team_id == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('team id가 0')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	
	String user_id = null;
	if(request.getParameter("user_id") != null)
		user_id = request.getParameter("team_id");
	if(user_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('user_id가 null')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	System.out.println("Team ID: " + team_id + ", User ID: " + user_id);
	
	int result = new TeamDAO().approve(user_id, team_id);
	if(result == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('성공')");
		script.println("location.href = 'history.back()'");
		script.println("</script>");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('실패')");
		script.println("location.href = 'history.back()'");
		script.println("</script>");
	}
	
		
	%>
</body>
</html>