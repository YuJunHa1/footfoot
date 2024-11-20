<%@page import="footfoot.User"%>
<%@page import="footfoot.UserDAO"%>
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
	<%
	String user_id = null;
	if (session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	User user = new UserDAO().getUser(user_id);
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="updateMyInfoAction.jsp">
					<h3 style="text-align: center;">내 정보 수정하기</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="user_name" maxlength="20"value= " <%=user.getUser_name() %>" required>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="user_id" maxlength="20"value= " <%=user.getUser_id() %>" readonly required>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="user_password" maxlength="20" value= "<%=user.getUser_password() %>" required>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호 확인" name="user_password2" maxlength="20" value= "<%=user.getUser_password() %>" required>
					</div>
					<div class="form-group">
    					<input type="date" class="form-control" placeholder="생년월일" name="birthdate" value= "<%=user.getBirthdate() %>" readonly required>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="성별" name="gender" maxlength="20" value= " <%=user.getGender() %>" readonly required>
					</div>
					<input type="submit" class="btn btn-primary form-control" value="변경하기">
				</form>
			</div>
		</div>
	</div>

</body>
</html>