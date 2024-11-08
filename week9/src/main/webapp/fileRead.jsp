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
	String path = "test.txt";
	BufferedReader br = new BufferedReader(path);
	
	while(true){
		String str = br.readLine();
		
		if (str==null)
			break;
		
		out.println(str);
	}
	br.close();

%>
</body>
</html>