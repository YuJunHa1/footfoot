<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.PostDAO"%>
<%@ page import="footfoot.Post"%>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
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
	if(user_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후에 이용하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	int post_id = 0;
	if (request.getParameter("post_id") != null){
		post_id = Integer.parseInt(request.getParameter("post_id"));
	}
	if (post_id == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'post.jsp'");
		script.println("</script>");
	}
	Post post = new PostDAO().getPost(post_id);
	if(!user_id.equals(post.getUser_id())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'post.jsp'");
		script.println("</script>");
	}else{
		PostDAO postDAO = new PostDAO();
		int result = postDAO.update(post_id, request.getParameter("title"), request.getParameter("content"));
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패했습니다.')");
			script.println("location.href = history.back()");
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