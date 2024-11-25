<%@page import="footfoot.User"%>
<%@page import="footfoot.TeamDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="footfoot.PostDAO" %>
<%@ page import="footfoot.Post" %>
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
		int team_id = 0;
		if (request.getParameter("team_id") != null){
			team_id = Integer.parseInt(request.getParameter("team_id"));
		}
		if(team_id == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 팀입니다.')");
			script.println("location.href = main.jsp'");
			script.println("</script>");
		}
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;;">이름</th>
						<th style="background-color: #eeeeee; text-align: center;;">나이</th>
						<th style="background-color: #eeeeee; text-align: center;;">성별</th>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;;">수정</th>
					</tr>
				</thead>
				<tbody>
					<%
						TeamDAO teamDAO = new TeamDAO();
						ArrayList<User> members = teamDAO.getMembers(team_id);
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						for (User member : members) {
					%>
						<tr>
							<td><%=member.getUser_name() %></td>
							<td><%=member.getBirthdate() %></td>
							<td><%=member.getGender() %></td>
							<td colspan="2">
							<a onclick="return confirm('<%=member.getUser_name() %> 님을 리더로 지정하시겠습니까?')" href="deleteAction.jsp?post_id" class="btn btn-primary">리더 위임</a>
							<a onclick="return confirm('<%=member.getUser_name() %> 님을 팀에서 추방하시겠습니까?')" href="deleteAction.jsp" class="btn btn-primary">추방</a>
							</td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
				<!-- 가입 신청 목록 버튼 -->
				<a href="#" class="btn btn-primary" data-toggle="modal" data-target="#joinRequestModal" onclick="loadApplicant(<%=team_id %>)">가입 신청 목록</a>
				
				<!-- 모달 -->
				<div id="joinRequestModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				    <div class="modal-dialog modal-lg" role="document">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">&times;</span>
				                </button>
				                <h4 class="modal-title" id="myModalLabel">가입 신청 목록</h4>
				            </div>
				            <div class="modal-body">
				                <table class="table table-striped">
				                    <thead>
				                        <tr>
				                            <th>이름</th>
				                            <th>나이</th>
				                            <th>성별</th>
				                            <th>지원 메세지</th>
				                            <th>승인</th>
				                        </tr>
				                    </thead>
				                    <tbody id="applicantList">
				                        <!-- 가입 신청 목록 데이터가 여기에 로드됨 -->
				                    </tbody>
				                </table>
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				            </div>
				        </div>
				    </div>
				</div>
				
				<script>
				    function loadApplicant(team_id) {
				        $.ajax({
				            url: 'getApplicant.jsp', // 가입 신청 데이터를 가져오는 JSP 파일
				            type: 'GET',
				            data: { team_id: team_id },
				            success: function(data) {
				                // 데이터 로드 성공 시, 모달에 데이터 삽입
				                $('#applicantList').html(data);
				            },
				            error: function() {
				                alert('가입 신청 목록을 불러오는데 실패했습니다.');
				            }
				        });
				    }
				</script>
		</div>
	</div>
</body>
</html>