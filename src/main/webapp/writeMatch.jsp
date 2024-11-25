<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="text/html; initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>footfoot</title>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="row">
			<form method="post" action="writeMatchAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;;">매치 글쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="3"><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="30" required></td>
						</tr>
						<tr>
							<td>
		                        <select class="form-control" name="match_local" required>
		                            <option value="" disabled selected>경기 지역 선택</option>
		                            <option value="서울특별시">서울특별시</option>
		                            <option value="부산광역시">부산광역시</option>
		                            <option value="대구광역시">대구광역시</option>
		                            <option value="인천광역시">인천광역시</option>
		                            <option value="광주광역시">광주광역시</option>
		                            <option value="대전광역시">대전광역시</option>
		                            <option value="울산광역시">울산광역시</option>
		                            <option value="세종특별자치시">세종특별자치시</option>
		                            <option value="경기도">경기도</option>
		                            <option value="강원도">강원도</option>
		                            <option value="충청북도">충청북도</option>
		                            <option value="충청남도">충청남도</option>
		                            <option value="전라북도">전라북도</option>
		                            <option value="전라남도">전라남도</option>
		                            <option value="경상북도">경상북도</option>
		                            <option value="경상남도">경상남도</option>
		                            <option value="제주특별자치도">제주특별자치도</option>
		                        </select>
                        	</td>
                        	<td><input type="date" class="form-control" placeholder="경기 날짜" name="match_date" required></td>
                        	<td><input type="text" class="form-control" placeholder="경기장 상세 주소" name="location" maxlength="80" required></td>
						</tr>
						<tr>
							<td colspan="3"><textarea class="form-control" placeholder="글 내용" name="content" maxlength="682" style = "height: 350px;" required></textarea></td>
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
</html>