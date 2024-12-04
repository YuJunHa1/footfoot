<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>내 정보</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color: #eeeeee; text-align: center;">내 정보</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 20%;">이름</td>
                        <td colspan="2">${user.user_name}</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;">아이디</td>
                        <td colspan="2">${user.user_id}</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;">생년월일</td>
                        <td colspan="2">${user.birthdate}</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;">성별</td>
                        <td colspan="2">${user.gender}</td>
                    </tr>
                    <tr>
                        <td style="width: 20%;">소속 팀</td>
                        <td colspan="2">
                            <c:choose>
                                <c:when test="${team != null}">
                                    ${team.team_name}
                                </c:when>
                                <c:otherwise>
                                    소속 팀이 없습니다.
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%;">가입일자</td>
                        <td colspan="2">${user.created_at}</td>
                    </tr>
                </tbody>
            </table>
            <a href="updateMyInfo.do" class="btn btn-primary">내 정보 수정</a>
            <c:if test="${team != null}">
                <a href="teamView.do?team_id=${team.team_id}" class="btn btn-primary">팀 정보 보기</a>
            </c:if>
        </div>
    </div>
</body>
</html>