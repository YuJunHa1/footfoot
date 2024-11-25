<%@page import="footfoot.Team_application"%>
<%@page import="java.util.ArrayList"%>
<%@page import="footfoot.TeamDAO"%>
<%@page import="footfoot.Team"%>
<%@page import="footfoot.UserDAO"%>
<%@page import="footfoot.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
    // 승인 확인 메시지
    function confirmApprove(url) {
        if (confirm("정말로 승인을 하시겠습니까?")) {
            location.href = url; // 승인 URL로 이동
        }
    }

    // 거부 확인 메시지
    function confirmReject(url) {
        if (confirm("정말로 거부를 하시겠습니까?")) {
            location.href = url; // 거부 URL로 이동
        }
    }
</script>
</head>
<body>
<%
    int team_id = Integer.parseInt(request.getParameter("team_id"));
    ArrayList<Team_application> applicants = new TeamDAO().getApplicant(team_id);

    for (Team_application applicant : applicants) {
        User user = new UserDAO().getUser(applicant.getUser_id());
%>
    <tr>
        <td><%= user.getUser_name() %></td>
        <td><%= user.getBirthdate() %></td>
        <td><%= user.getGender() %></td>
        <td><%= applicant.getContent() %></td>
        <td>
            <!-- 승인 버튼 -->
            <a href="#" onclick="confirmApprove('approveAction.jsp?user_id=<%= user.getUser_id() %>&team_id=<%=team_id %>')" 
               class="btn btn-success btn-sm">승인</a>
            
            <!-- 거부 버튼 -->
            <a href="#" onclick="confirmReject('rejectAction.jsp?user_id=<%= user.getUser_id() %>')" 
               class="btn btn-danger btn-sm">거부</a>
        </td>
    </tr>
<%
    }
%>
</body>
</html>
