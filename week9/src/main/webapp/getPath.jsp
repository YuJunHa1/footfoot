<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h3>application 기본 객체</h3>

<%
	//URL경로명 return
	String contPath = application.getContextPath();
	//실제 경로명 가져오기
	String realPath = application.getRealPath("/");
%>
//  /week9의 의미 => wabapp 폴더를 가르킨다.
웹 어플리케이션(프로젝트)의 URL 경로명 = <%=contPath %>
<br><br>
웹 어플리케이션(프로젝트)의 실제 URL 경로명 = <%=realPath %>

</body>
</html>