<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="footfoot.Team" %>
<%@ page import="footfoot.TeamDAO" %>
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
	int team_id = 0;
	if(request.getParameter("team_id") != null){
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
	String team_name = team.getTeam_name();
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
			<form method="post" action="joinTeamAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;;"><%=team_name %> 가입신청</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><textarea class="form-control" placeholder="가입 메세지를 작성해 주세요." name="content" maxlength="682" style = "height: 350px;" required></textarea></td>
						</tr>
					</tbody>	
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="가입신청">
			</form>
		</div>
	</div>
</body>
</html>