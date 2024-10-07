<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="member" class="week5.MemberInfo" scope="request"/>
<jsp:getProperty property="name" name="member"/>
( <jsp:getProperty property="id" name="member"/> ) 회원님, 안녕하세요!
<br><br>
당신의 이메일은, <jsp:getProperty property="email" name="member"/>
</body>
</html>