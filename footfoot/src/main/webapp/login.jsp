<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="text/html; initial-scale=1">
<title>footfoot</title>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center;">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="user_id" maxlength="20" required>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="user_password" maxlength="20" required>
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
				<div style="text-align: center; margin-top: 20px;">
					<a href="join.jsp">회원가입</a>
			</div>
		</div>
	</div>

</body>
</html>