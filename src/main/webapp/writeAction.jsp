<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.PostDAO"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="post" class="footfoot.Post" scope="page"/>
<jsp:setProperty name="post" property="title" />
<jsp:setProperty name="post" property="content" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footfoot</title>
</head>
<body>
	<%
	String user_id = null;
	String post_type = "free";
	if(session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	if (user_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후에 이용하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} else{
		PostDAO postDAO = new PostDAO();
		int result = postDAO.write(user_id, post_type, post.getTitle(), post.getContent());
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert(글쓰기에 실패했습니다.)");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'post.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>