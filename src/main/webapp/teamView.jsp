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
	int team_id = 0;
	if (request.getParameter("team_id") != null){
		team_id = Integer.parseInt(request.getParameter("team_id"));
	}
	if (team_id == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 팀입니다.')");
		script.println("location.href = 'team.jsp'");
		script.println("</script>");
	}
	
	Team team = new TeamDAO().getTeam(team_id);
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;;">팀 정보</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">팀 명</td>
							<td colspan="2"><%=team.getTeam_name() %></td>
						</tr>
						<tr>
							<td style="width: 20%;">팀 장</td>
							<td colspan="2"><%=team.getLeader_id() %></td>
						</tr>
						<tr>
							<td>팀 수준</td>
							<td colspan="2"><%=team.getTeam_level() %></td>
						</tr>
						<%
						int[] dayNum = {1, 2, 4, 8, 16, 32, 64};
						String[] dayName = {"월", "화", "수", "목", "금", "토", "일"};
						StringBuilder sb = new StringBuilder();
						for (int i = 0; i < dayNum.length; i++) {
							if ((team.getMeeting_day() & dayNum[i]) != 0) {
				            	if (sb.length() > 0) {
				                	sb.append(", ");
				            	}
				            	sb.append(dayName[i]);
							}
						}
						%>
						<tr>
							<td>모임 요일</td>
							<td colspan="2"><%=sb.toString() %></td>
						</tr>
						<tr>
							<td>활동 지역</td>
							<td colspan="2"><%=team.getTeam_local() %></td>
						</tr>
						<tr>
							<td>팀 소개</td>
							<td colspan="2" style="min-height: 200px; word-wrap: break-word; word-break: break-all; white-space: pre-wrap;"><%=team.getTeam_description().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<%
						int recruit_position = team.getRecruit_position();
					    if(team.getIs_recruiting().equals("모집중") && recruit_position != 0){
							int[] positionNum = {2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1};
							String[] positionName = {"LW", "ST", "RW", "CAM", "LM", "CM", "RM", "CDM", "LB", "CB", "RB", "GK"};
							StringBuilder sb2 = new StringBuilder();
							for (int i = 0; i < positionNum.length; i++) {
								if ((recruit_position & positionNum[i]) != 0) {
					            	if (sb2.length() > 0) {
					                	sb2.append(", ");
					            	}
					            	sb2.append(positionName[i]);
					        	 }
							}
						%>
						<tr>
							<td>모집중인 포지션</td>
							<td colspan="2"><%=sb2.toString() %></td>
						</tr>
						<%
							}
						%>
					</tbody>	
				</table>
				<a href="team.jsp" class="btn btn-primary">목록</a>
				<%
					User user = new UserDAO().getUser(user_id);
					if(user != null && user.getTeam_id() == 0){
				%>
					<a href="joinTeam.jsp?team_id=<%=team_id %>" class="btn btn-primary">가입신청</a>
				<%	
					}
				%>
				
				<%
					if(user != null && user.getUser_id().equals(team.getLeader_id())){
				%>
					<a href="updateTeamInfo.jsp?team_id=<%=team_id %>" class="btn btn-primary">팀 정보 수정</a>
					<a href="updateTeamInfo.jsp?team_id=<%=team_id %>" class="btn btn-primary">멤버 관리</a>
				<%	
					}
				%>
		</div>
		
	</div>
</body>
</html>