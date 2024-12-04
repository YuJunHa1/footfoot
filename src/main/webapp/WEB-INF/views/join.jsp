<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="text/html; initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>회원가입</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="joinAction.do">
                    <h3 style="text-align: center;">회원가입</h3>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="아이디" name="user_id" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="비밀번호" name="user_password" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="비밀번호 확인" name="user_password2" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="사용자 이름" name="user_name" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control" name="birthdate" required>
                    </div>
                    <div class="form-group" style="text-align: center;">
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary active">
                                <input type="radio" name="gender" value="남자" checked>남자
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="gender" value="여자">여자
                            </label>
                        </div>
                    </div>
                    <input type="submit" class="btn btn-primary form-control" value="회원가입">
                </form>
                <div style="color: red; text-align: center; margin-top: 10px;">
                    <c:if test="${not empty errorMsg}">
                        ${errorMsg}
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>