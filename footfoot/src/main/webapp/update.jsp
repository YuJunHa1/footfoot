<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="footfoot.Post" %>
<%@ page import="footfoot.PostDAO" %>
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
	if(user_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후에 이용하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
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
	if(!user_id.equals(post.getUser_id())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'post.jsp'");
		script.println("</script>");
	}
	%>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row" action="writeAction.jsp">
			<form method="post" action="updateAction.jsp">
				<input type="hidden" name="post_id" value="<%= post_id %>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;;">글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="100" value= "<%=post.getTitle() %>" required></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2048" style = "height: 350px;" required><%=post.getContent() %></textarea></td>
						</tr>
					</tbody>	
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
			<div>
                        <a href="matchWrite.jsp" class="btn btn-link">매치 초청</a>
                        <a href="mercenaryWrite.jsp" class="btn btn-link">용병 구인</a>
                    </div>

		</div>
		
	</div>
</body>
