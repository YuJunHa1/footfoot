<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="text/html; initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>footfoot</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="row">
            <!-- 에러 메시지가 있을 때만 표시 -->
            <c:if test="${errorMsg != null && errorMsg != ''}">
                <div class="alert alert-danger" role="alert" style="text-align: center;">
                    ${errorMsg}
                </div>
            </c:if>

            <form method="post" action="writeAction.do">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                        <tr>
                            <th colspan="2" style="background-color: #eeeeee; text-align: center;;">글쓰기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="30" required></td>
                        </tr>
                        <tr>
                            <td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="682" style="height: 350px;" required></textarea></td>
                        </tr>
                    </tbody>    
                </table>
                <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
            </form>
        </div>
    </div>
</body>
</html>