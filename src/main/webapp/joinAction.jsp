<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="footfoot.User" scope="page"/>
<jsp:setProperty name="user" property="user_id"/>
<jsp:setProperty name="user" property="user_password"/>
<jsp:setProperty name="user" property="user_name"/>
<jsp:setProperty name="user" property="birthdate"/>
<jsp:setProperty name="user" property="gender"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footfoot</title>
</head>
<body>
	<%
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
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}		
		}	
	%>
</body>
</html>