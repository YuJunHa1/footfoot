<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>팀 정보 수정</title>
    <script>
        function togglePositions() {
            const isRecruiting = document.querySelector('input[name="is_recruiting"]:checked').value;
            const positionsDiv = document.getElementById('positions');
            positionsDiv.style.display = isRecruiting === '모집중' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="col-lg-3"></div>
        <div class="col-lg-6">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="updateTeamInfoAction.do" enctype="multipart/form-data">
                    <h3 style="text-align: center;">팀 정보 수정</h3>

                    <input type="hidden" name="team_id" value="${team.team_id}" />

                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="팀 명" name="team_name" maxlength="15" value="${team.team_name}" required>
                    </div>

                    <div class="form-group">
                        <textarea class="form-control" placeholder="팀 소개" name="team_description" maxlength="682" style="height: 200px;" required>${team.team_description}</textarea>
                    </div>

                    <div class="form-group">
                        <select class="form-control" name="team_local" required>
                            <option value="" disabled>활동 지역 선택</option>
                            <c:forEach var="local" items="${locals}">
                                <option value="${local}" ${local == team.team_local ? "selected" : ""}>${local}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- 팀 로고 -->
                    <div class="form-group text-center">
                        <label>새 팀 로고 업로드</label>
                        <input type="file" class="form-control" name="logo_url" accept="image/*">
                    </div>

					<div class="form-group text-center">
                        <label>팀 수준</label><br>
                        <div class="btn-group" data-toggle="buttons">
                        <c:forEach var="level" items="${teamLevels}">
                            <label class="btn btn-primary ${level == team.team_level ? 'active' : ''}">
                                <input type="radio" name="team_level" value="${level}" autocomplete="off" ${level == team.team_level ? 'checked' : ''}>${level}
                            </label>
                        </c:forEach>
                        </div>
                    </div>
                    
                    <div class="form-group text-center">
                        <label>모임 요일 (다중 선택 가능)</label><br>
                        <div class="btn-group" data-toggle="buttons">
                        <c:forEach var="day" items="${days}">
                            <label class="btn btn-default ${day.checked ? 'active' : ''}">
                                <input type="checkbox" name="meeting_day" value="${day.flag}" ${day.checked ? 'checked' : ''}>
                                ${day.name}
                            </label>
                        </c:forEach>
                        </div>
                    </div>

                    <!-- 팀원 모집 여부 -->
                    <div class="form-group text-center">
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

                    <!-- 모집 포지션 -->
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

                    <input type="submit" class="btn btn-primary form-control" value="팀 정보 수정">
                </form>
            </div>
        </div>
    </div>
</body>
</html>

