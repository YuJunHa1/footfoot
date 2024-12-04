<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>팀 멤버 관리</title>
</head>
<body>
    <jsp:include page="nav.jsp" />
    <div class="container">
        <div class="row">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>이름</th>
                        <th>생년월일</th>
                        <th>성별</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="member" items="${members}">
                        <tr>
                            <td>${member.user_name}</td>
                            <td>${member.birthdate}</td>
                            <td>${member.gender}</td>
                            <td>
                                <a href="assignLeader.do?user_id=${member.user_id}&team_id=${teamId}" 
                                   class="btn btn-primary btn-sm">리더 위임</a>
                                <a href="expelMember.do?user_id=${member.user_id}&team_id=${teamId}" 
                                   class="btn btn-danger btn-sm">추방</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- 가입 신청 목록 버튼 -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#joinRequestModal">
                가입 신청 목록
            </button>

            <!-- 가입 신청 모달 -->
            <div id="joinRequestModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title">가입 신청 목록</h5>
                        </div>
                        <div class="modal-body">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>이름</th>
                                        <th>생년월일</th>
                                        <th>성별</th>
                                        <th>메시지</th>
                                        <th>승인/거부</th>
                                    </tr>
                                </thead>
                                <tbody id="applicantList"></tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function loadApplicant(teamId) {
            $.ajax({
                url: 'applicantList.do',
                type: 'GET',
                data: { team_id: teamId },
                success: function(data) {
                    $('#applicantList').html(data);
                },
                error: function() {
                    alert('가입 신청 목록을 불러오는데 실패했습니다.');
                }
            });
        }
    </script>
</body>
</html>