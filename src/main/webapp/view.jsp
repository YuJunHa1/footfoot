<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "footfoot.Post" %>
<%@ page import = "footfoot.PostDAO" %>
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
	String user_id = null;
	if (session.getAttribute("user_id") != null){
		user_id = (String) session.getAttribute("user_id");
	}
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	int post_id = 0;
	if (request.getParameter("post_id") != null){
		post_id = Integer.parseInt(request.getParameter("post_id"));
	}
	if (post_id == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'post.jsp'");
		script.println("</script>");
	}
	
	Post post = new PostDAO().getPost(post_id);
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;;">글읽기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=post.getTitle() %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=post.getUser_id() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=post.getCreated_at().format(formatter) %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px;"><%=post.getContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
					</tbody>	
				</table>
				<a href="post.jsp" class="btn btn-primary">목록</a>
				<%
					if(user_id != null && user_id.equals(post.getUser_id())){
				%>
					<a href="update.jsp?post_id=<%=post_id %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?post_id=<%=post_id %>" class="btn btn-primary">삭제</a>
				<%	
					}
				%>
		</div>
		
	</div>
</body>
</html>