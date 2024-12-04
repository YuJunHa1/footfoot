<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>팀 정보</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="row">
            <table class="table table-striped text-center" style="border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color: #eeeeee; text-align: center;">팀 정보</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 20%;">팀 명</td>
                        <td colspan="2">${team.team_name}</td>
                    </tr>
                    <tr>
                        <td>팀 장</td>
                        <td colspan="2">${team.leader_id}</td>
                    </tr>
                    <tr>
                        <td>팀 수준</td>
                        <td colspan="2">${team.team_level}</td>
                    </tr>
                    <tr>
                        <td>모임 요일</td>
                        <td colspan="2">${meetingDays}</td>
                    </tr>
                    <tr>
                        <td>활동 지역</td>
                        <td colspan="2">${team.team_local}</td>
                    </tr>
                    <tr>
                        <td>팀 소개</td>
                        <td colspan="2" style="min-height: 200px; word-wrap: break-word; white-space: pre-wrap;">
                            ${team.team_description}
                        </td>
                    </tr>
                    <tr>
                        <td>멤버</td>
                        <td colspan="2">
                            <c:forEach var="member" items="${members}">
                                <c:out value="${member.user_name}"/><br />
                            </c:forEach>
                        </td>
                    </tr>
                    <c:if test="${not empty recruitPositions}">
                        <tr>
                            <td>모집중인 포지션</td>
                            <td colspan="2">${recruitPositions}</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <a href="team.do" class="btn btn-primary">목록</a>
            <c:if test="${user != null && user.team_id == 0}">
                <a href="joinTeam.do?team_id=${team.team_id}" class="btn btn-primary">가입신청</a>
            </c:if>
            <c:if test="${user != null && user.user_id == team.leader_id}">
                <a href="updateTeamInfo.do?team_id=${team.team_id}" class="btn btn-primary">팀 정보 수정</a>
                <a href="teamMembers.do?team_id=${team.team_id}" class="btn btn-primary">멤버 관리</a>
            </c:if>
        </div>
    </div>
</body>
</html>