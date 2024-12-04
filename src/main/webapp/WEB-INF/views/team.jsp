<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="text/html; initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>팀 목록</title>
</head>
<body>
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
                    <c:forEach var="team" items="${teamList}">
                        <tr>
                            <td>
                                <a href="teamView.do?team_id=${team.team_id}">${team.team_name}</a>
                            </td>
                            <td>${team.team_level}</td>
                            <td>${team.team_local}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${team.is_recruiting}">
                                        모집 중
                                    </c:when>
                                    <c:otherwise>
                                        모집 완료
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <a href="createTeam.do" class="btn btn-primary pull-right">팀 생성</a>
        </div>
    </div>
</body>
</html>