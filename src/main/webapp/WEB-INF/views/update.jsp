<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="text/html; initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>글 수정</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-danger">${errorMsg}</div>
        </c:if>
        <form method="post" action="updateAction.do">
            <input type="hidden" name="post_id" value="${post.post_id}" />
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="2" style="background-color: #eeeeee; text-align: center;">글 수정</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="100" value="${post.title}" required>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style="height: 350px;" required>${post.content}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" class="btn btn-primary pull-right" value="수정">
        </form>
        <div>
            <a href="matchWrite.jsp" class="btn btn-link">매치 초청</a>
            <a href="mercenaryWrite.jsp" class="btn btn-link">용병 구인</a>
        </div>
    </div>
</body>
</html>