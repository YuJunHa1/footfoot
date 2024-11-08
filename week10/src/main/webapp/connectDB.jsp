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
<h3>데이터베이스 연결</h3>

<%
	//1.통신을 위한 JDBC 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");

	//2. 데이터베이스 연결을 위한 정보 저장
	String jdbcURL = "jdbc:mysql://localhost:3306/jspdb_b";
	String dbUser = "root";
	String dbPass = "wnsgk7575";
	
	//3. 데이터베이스 커넥션 생성
	Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);
	
	//4. 쿼리 실행을 위한 sql 문장, Statement 객체 생성
	String sql = "select * from emp";
	Statement stat = conn.createStatement();
	
	//5. 쿼리문을 실행해서 ResultSet에 저장
	ResultSet rs = stat.executeQuery(sql);
	
	//6. 쿼리 실행 결과 출력
	if (rs != null)
		out.println("DB연결 성공");
	else
		out.println("DB연결 실패");
	
	rs.close();
	stat.close();
	conn.close();
%>
</body>
</html>