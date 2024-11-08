<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	//1.통신을 위한 JDBC 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");

	//2. 데이터베이스 연결을 위한 정보 저장
	String jdbcURL = "jdbc:mysql://localhost:3306/jspdb_b";
	String dbUser = "root";
	String dbPass = "wnsgk7575";
	
	//3. 데이터베이스 커넥션 생성
	Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);
%>
</body>
</html>