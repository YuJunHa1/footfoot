<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="footfoot.TeamDAO" %>
<%@ page import="footfoot.Team" %>
<%@ page import="java.util.ArrayList" %>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">팀 명</th>
						<th style="background-color: #eeeeee; text-align: center;">팀 수준</th>
						<th style="background-color: #eeeeee; text-align: center;">지역</th>
						<th style="background-color: #eeeeee; text-align: center;">모집 여부</th>
					</tr>
				</thead>
				<tbody>
					<%
						TeamDAO teamDAO = new TeamDAO();
						ArrayList<Team> list = teamDAO.getList(pageNumber);
						for (Team team : list) {
					%>
						<tr>
							<td><a href="teamView.jsp?team_id=<%=team.getTeam_id()%>"><%=team.getTeam_name() %></a></td>
							<td><%=team.getTeam_level()%></td>
							<td><%= team.getTeam_local()%></td>
							<td><%=team.getIs_recruiting()%></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<a href="createTeam.jsp" class="btn btn-primary pull-right">팀 생성</a> 
		</div>
	</div>
</body>
</html>