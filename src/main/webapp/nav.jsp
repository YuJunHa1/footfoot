<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="footfoot.UserDAO" %>
<%@ page import="footfoot.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="text/html; initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>footfoot</title>
</head>
<body>
	<%
		String user_id = null;
	if (session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	
	String user_name = null;
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUser(user_id);
    if (user != null) {
        user_name = user.getUser_name();
    }
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="main.jsp">Foot Foot</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="team.jsp">팀</a></li>
				<li><a href="match.jsp">매치</a></li>
				<li><a href="mercenary.jsp">용병</a></li>
				<li><a href="post.jsp">자유 게시판</a></li>
			</ul>
			<%
				if(user_id == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">로그인</a></li>
			</ul>
			<%
				} else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="navbar-text"> <%= user_name %>님, 반갑습니다!</li>
				<li><a href="myInfo.jsp">내 정보</a></li>
				<li><a href="logoutAction.jsp">로그아웃</a></li>	
			</ul>
			<%
				}
			%>
			
		</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>