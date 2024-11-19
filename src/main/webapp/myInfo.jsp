<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "footfoot.Team" %>
<%@ page import = "footfoot.TeamDAO" %>
<%@ page import = "footfoot.User" %>
<%@ page import = "footfoot.UserDAO" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
	User user = new UserDAO().getUser(user_id);
	int team_id = user.getTeam_id();
	String team_name = null;
	if(team_id != 0){
		team_name = new TeamDAO().getTeam(team_id).getTeam_name();
		
	}
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;;">내 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">이름</td>
							<td colspan="2"><%=user.getUser_name() %></td>
						</tr>
						<tr>
							<td style="width: 20%;">아이디</td>
							<td colspan="2"><%=user.getUser_id() %></td>
						</tr>
						<tr>
							<td style="width: 20%;">생년월일</td>
							<td colspan="2"><%=user.getBirthdate() %></td>
						</tr>
						<tr>
							<td style="width: 20%;">성별</td>
							<td colspan="2"><%=user.getGender() %></td>
						</tr>
						<tr>
							<td style="width: 20%;">소속 팀</td>
							<td colspan="2"><%=team_id==0 ? "소속 팀이 없습니다." : team_name %></td>
						</tr>
						<tr>
							<td style="width: 20%;">가입일자</td>
							<td colspan="2"><%=user.getCreated_at() %></td>
						</tr>
					</tbody>	
				</table>
				<a href="updateMyInfo.jsp" class="btn btn-primary">내 정보 수정</a>
				<%
					if(team_id!=0){
				%>
					<a href="teamView.jsp?team_id=<%=team_id %>" class="btn btn-primary">팀 정보 보기</a>
				<%	
					}
				%>
		</div>
		
	</div>
</body>
</html>