<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h3>server info</h3>
<%=application.getServerInfo() %>
<h3>servlet version info</h3>
<%=application.getMajorVersion() %>.<%=application.getMinorVersion() %>
<h3>JSP version info</h3>
<%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>
</body>
</html>