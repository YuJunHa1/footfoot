<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="text/html; initial-scale=1">
<title>footfoot</title>
<script>
    function togglePositions() {
        const isRecruiting = document.querySelector('input[name="is_recruiting"]:checked').value;
        const positionsDiv = document.getElementById('positions');
        console.log("togglePositions 함수 호출됨. is_recruiting 값:", isRecruiting);
        if (isRecruiting == '모집완료') {
            positionsDiv.style.display = 'block';
        } else {
            positionsDiv.style.display = 'none';
        }
    }
</script>
</head>
<body>
	<jsp:include page="nav.jsp" />
	<div class="container">
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="createAction.jsp">
					<h3 style="text-align: center;">팀 생성</h3>
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="팀 명" name="team_name" maxlength="15" required>
					</div>
					
					<div class="form-group">
    					<textarea class="form-control" placeholder="팀 소개" name="team_description" maxlength="682" style="height: 200px;" required></textarea>
					</div>
					<div class="form-group">
                        <select class="form-control" name="team_local" required>
                            <option value="" disabled selected>활동 지역 선택</option>
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
                    </div>
					
					<div class="form-group">
					    <label style="display: block; text-align: center;">팀 로고 업로드</label>
					    <input type="file" class="form-control" id="logo_url" name="logo_url" accept="image/*" required>
					</div>
					
					<div class="form-group" style="text-align: center;">
						<label>팀 수준</label><br>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary">
								<input type="radio" name="team_level" autocomplete="off" value="상">상
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="team_level" autocomplete="off" value="중상">중상
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="team_level" autocomplete="off" value="중">중
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="team_level" autocomplete="off" value="중하">중하
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="team_level" autocomplete="off" value="하">하
							</label>
						</div>
					</div>
					
					<div class="form-group text-center">
					    <label>모임 요일 (다중 선택 가능)</label><br>
					    <div class="btn-group" data-toggle="buttons">
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="1"> 월
					        </label>
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="2"> 화
					        </label>
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="4"> 수
					        </label>
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="8"> 목
					        </label>
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="16"> 금
					        </label>
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="32"> 토
					        </label>
					        <label class="btn btn-default">
					            <input type="checkbox" name="meeting_day" value="64"> 일
					        </label>
					    </div>
					 </div>
					    
				    <div class="form-group" style="text-align: center;">
				    <label>팀원 모집 여부</label><br>
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary" onclick="togglePositions()">
								<input type="radio" name="is_recruiting" autocomplete="off" value="모집중">모집중
							</label>
							<label class="btn btn-primary active" onclick="togglePositions()">
								<input type="radio" name="is_recruiting" autocomplete="off" value="모집완료" checked>모집완료
							</label>
						</div>
					</div>
					<div class="form-group" id="positions" style="display: none;">
					    <div class="btn-group" data-toggle="buttons" style="display: block; text-align: center;">
					    	<label>모집 포지션 선택</label><br>
					        <div>
					            <strong>FW</strong><br>
					            <label class="btn btn-default">
					                <input type="checkbox" name="recruit_position" value="2048"> LW
					            </label>
					            <label class="btn btn-default">
					                <input type="checkbox" name="recruit_position" value="1024"> ST
					            </label>
					            <label class="btn btn-default">
					                <input type="checkbox" name="recruit_position" value="512"> RW
					            </label>
					        </div>
					        <br>
					        <div>
					            <strong>MF</strong><br>
					            <label class="btn btn-default">
					                <input type="checkbox" name="recruit_position" value="256"> CAM
					            </label>
					            <br>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="128"> LM
					            </label>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="64"> CM
					            </label>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="32"> RM
					            </label>
					            <br>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="16"> CDM
					            </label>
					        </div>
					        <br>
					        <!-- Defense (DF) Positions -->
					        <div>
					            <strong>DF</strong><br>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="8"> LB
					            </label>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="4"> CB
					            </label>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="2"> RB
					            </label>
					        </div>
					        <br>
					        <div>
					            <strong>GK</strong><br>
					            <label class="btn btn-default">
					                <input type="checkbox" name="position" value="1"> GK
					            </label>
					        </div>
					    </div>
					</div>
										
					<input type="submit" class="btn btn-primary form-control" value="팀 생성">
				</form>
			</div>
		</div>
	</div>

</body>
</html>