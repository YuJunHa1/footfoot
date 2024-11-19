<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.Team_application" %>
<%@ page import="footfoot.Team_applicationDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footfoot</title>
</head>
<body>
	<%
		int team_id = Integer.parseInt(request.getParameter("team_id"));
		String content = request.getParameter("content");
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String) session.getAttribute("user_id");
		}
		if (user_id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후에 이용하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		Team_applicationDAO taDAO = new Team_applicationDAO();
		int result = taDAO.application(team_id, user_id, content);
		if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('가입신청이 완료되었습니다.')");
			script.println("location.href = 'team.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>