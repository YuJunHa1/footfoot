<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>내 정보 수정</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="updateMyInfoAction.do">
                    <h3 style="text-align: center;">내 정보 수정하기</h3>

                    <!-- 에러 메시지 -->
                    <c:if test="${not empty errorMsg}">
                        <div class="alert alert-danger">${errorMsg}</div>
                    </c:if>
                    <c:if test="${not empty successMsg}">
                        <div class="alert alert-success">${successMsg}</div>
                    </c:if>

                    <!-- 사용자 정보 입력 -->
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="이름" name="user_name" maxlength="20" value="${user.user_name}" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="아이디" name="user_id" maxlength="20" value="${user.user_id}" readonly required>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="비밀번호" name="user_password" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="비밀번호 확인" name="user_password2" maxlength="20" required>
                    </div>
                    <div class="form-group">
                        <input type="date" class="form-control" placeholder="생년월일" name="birthdate" value="${user.birthdate}" readonly required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="성별" name="gender" maxlength="20" value="${user.gender}" readonly required>
                    </div>
                    <input type="submit" class="btn btn-primary form-control" value="변경하기">
                </form>
            </div>
        </div>
    </div>
</body>
</html>