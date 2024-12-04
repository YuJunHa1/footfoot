<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="footfoot.DAO.UserDAO"%>
<%@ page import="footfoot.model.User"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="text/html; initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>footfoot</title>
</head>
<body>
	
    <nav class="navbar navbar-default">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.do">Foot Foot</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="team.do">팀</a></li>
                <li><a href="match.do">매치</a></li>
                <li><a href="mercenary.do">용병</a></li>
                <li><a href="post.do">자유 게시판</a></li>
            </ul>
            <!-- 로그인 여부 확인 -->
            <c:if test="${empty user_id}">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="login.do">로그인</a></li>
                </ul>
            </c:if>
            <c:if test="${not empty user_id}">
                <ul class="nav navbar-nav navbar-right">
                    <li class="navbar-text"><c:out value="${sessionScope.user_name}" />님, 반갑습니다!</li>
                    <li><a href="myInfo.do">내 정보</a></li>
                    <li><a href="logoutAction.do">로그아웃</a></li>    
                </ul>
            </c:if>
        </div>
    </nav>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>