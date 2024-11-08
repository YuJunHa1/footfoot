<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3>게시판 내용</h3>
<%
	String filename = request.getParameter("filename");

	String real = application.getRealPath("/WEB-INT/board/" + filename);
	
	BufferedReader br = new BufferedReader(new FileReader(real))l
			
	while(true){
		String str = br.readLine();
		
		if (str == null)
			break;
		
		out.println(str + "<br>");
	}
	br.close();
%>
</body>
</html>