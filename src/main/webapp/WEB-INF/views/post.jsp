<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="text/html; initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>게시판</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color: #eeeeee; text-align: center;">제목</th>
                        <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                        <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="post" items="${postList}">
                        <tr>
                            <td>
                                <a href="view.do?post_id=${post.post_id}">${post.title}</a>
                            </td>
                            <td>${post.user_id}</td>
                            <td>${post.formattedDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="text-center">
                <c:if test="${pageNumber > 1}">
                    <a href="post.do?pageNumber=${pageNumber - 1}" class="btn btn-success">이전</a>
                </c:if>
                <c:if test="${hasNextPage}">
                    <a href="post.do?pageNumber=${pageNumber + 1}" class="btn btn-success">다음</a>
                </c:if>
            </div>
            <a href="write.do" class="btn btn-primary pull-right">글쓰기</a>
        </div>
    </div>
</body>
</html>