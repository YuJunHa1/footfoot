<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>게시글 보기</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="row">
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger">${errorMsg}</div>
            </c:if>
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color: #eeeeee; text-align: center;">글읽기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 20%;">글 제목</td>
                        <td colspan="2">${post.title}</td>
                    </tr>
                    <tr>
                        <td>작성자</td>
                        <td colspan="2">${post.user_id}</td>
                    </tr>
                    <tr>
                        <td>작성일자</td>
                        <td colspan="2">${formattedDate}</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td colspan="2" style="min-height: 200px;">
                            <c:out value="${post.content}" escapeXml="true" />
                            <!-- 개행 처리 -->
                            <br><br>
                        </td>
                    </tr>
                </tbody>
            </table>
            <a href="post.do" class="btn btn-primary">목록</a>
            <c:if test="${user_id == post.user_id}">
                <a href="update.do?post_id=${post.post_id}" class="btn btn-primary">수정</a>
                <a href="delete.do?post_id=${post.post_id}" onclick="return confirm('정말로 삭제하시겠습니까?')" class="btn btn-primary">삭제</a>
            </c:if>
        </div>
    </div>
</body>
</html>