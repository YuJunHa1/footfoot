<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ import java.util.Date %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3>결과화면</h3>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	//입력된 데이터를 파일로 저장 => 파일명 필요!
	//날짜 || 시간 정보를 이용해서 파일명 결정
	Date date = new Date();
	Long time = date.getTime();
	String filename = time + ".txt";
	
	//저장되는 실제 경로명 지정
	String filePath = application.getRealPath("/WEB-INF/board/"+filename);
	
	FileWriter writer = new FileWriter(filePath);
	
	try{
		String str="title : " + title + "\n";
		str += "user : " + name + "\n";
		str += "content : <br>" + content;
		writer.write(str);
	}catch(IOException e){
		out.println("파일에 데이터를 저장할 수 없습니다.");
	}finally{
		writer.close();
	}
	
%>
<br><br>
<form action="boardResult.jsp" method="post">
	<input type="hidden" name="filename" value="<%=filename %>">
	<input type="submit" value="내용보기">
</form>
</body>
</html>