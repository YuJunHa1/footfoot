<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="footfoot.PostDAO" %>
<%@ page import="footfoot.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="text/html; initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>footfoot</title>
</head>
<body>
	<%
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						PostDAO postDAO = new PostDAO();
						ArrayList<Post> list = postDAO.getList(pageNumber);
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						for (Post post : list) {
					%>
						<tr>
							<td><a href="view.jsp?post_id=<%=post.getPost_id()%>"><%=post.getTitle() %></a></td>
							<td><%=post.getUser_id() %></td>
							<td><%=post.getCreated_at().format(formatter) %></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div class="text-center">
				<%
					if (pageNumber != 1) {
				%>
					<a href="post.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success">이전</a>
				<%
					} 
					if (postDAO.nextPage(pageNumber + 1)) {
				%>
					<a href="post.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success">다음</a>
				<%
					}
				%>
			</div>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> 
		</div>
	</div>
</body>
</html>