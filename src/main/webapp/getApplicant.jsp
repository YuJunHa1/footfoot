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
    // ���� Ȯ�� �޽���
    function confirmApprove(url) {
        if (confirm("������ ������ �Ͻðڽ��ϱ�?")) {
            location.href = url; // ���� URL�� �̵�
        }
    }

    // �ź� Ȯ�� �޽���
    function confirmReject(url) {
        if (confirm("������ �źθ� �Ͻðڽ��ϱ�?")) {
            location.href = url; // �ź� URL�� �̵�
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
            <!-- ���� ��ư -->
            <a href="#" onclick="confirmApprove('approveAction.jsp?user_id=<%= user.getUser_id() %>&team_id=<%=team_id %>')" 
               class="btn btn-success btn-sm">����</a>
            
            <!-- �ź� ��ư -->
            <a href="#" onclick="confirmReject('rejectAction.jsp?user_id=<%= user.getUser_id() %>')" 
               class="btn btn-danger btn-sm">�ź�</a>
        </td>
    </tr>
<%
    }
%>
</body>
</html>
