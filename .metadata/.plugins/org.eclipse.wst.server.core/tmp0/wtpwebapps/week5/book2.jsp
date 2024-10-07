<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="book" class="week5.Book"></jsp:useBean>
<jsp:setProperty property="*" name="book"/>
<h3>도서 등록 결과</h3>
	<table border="1" cellpadding="3">
		<tr>
			<td>코드</td>
			<td>제목</td>
			<td>저자</td>
			<td>출판일자</td>
		</tr>
		<tr>
			<td><%=book.getCode() %></td>
			<td><%=book.getTitle() %></td>
			<td><%=book.getWriter() %></td>
			<td>2024-09-26</td>
		</tr>
	</table>

</body>
</html>