<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date date = new Date();
	String strDate = sdf.format(date);
%>

<jsp:useBean id="member" class="week5.MemberInfo" ></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<jsp:setProperty property="pw" name="member" value="<%=member.getId() %>"/>
<jsp:setProperty property="registerDate" name="member" value="<%=strDate %>"

<h3>회원가입결과</h3>

<table border="1" cellpadding="3">
		<tr>
			<td>아이디</td>
			<td>
			`<jsp:getProperty property="id" name="member"/>
			</td>
		</tr>
		<tr>
			<td>암호</td>
			<td><jsp:getProperty property="pw" name="member"/></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><jsp:getProperty property="name" name="member"/></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="회원가입"></td>
		</tr>
	</table>
</table>
</body>
</html>