<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.User"%>
<%@ page import="footfoot.UserDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<jsp:useBean id="user" class="footfoot.User" scope="request" />
<jsp:setProperty name="user" property="*" />
<html>
<head>
<meta charset="UTF-8">
<title>footfoot</title>
</head>
<body>
	<%
	String user_id = null;
	if (session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	
	String user_password = request.getParameter("user_password");
	String user_password2 = request.getParameter("user_password2");
	if(!user_password.equals(user_password2)){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.update(user);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정이 완료되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}		
	}
	%>
</body>
</html>