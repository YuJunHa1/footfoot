<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<tr>
        <td>손흥민</td>
        <td>남자</td>
        <td>21</td>
        <td>잘부탁드립니다.</td>
        <td>
            <a href="approveApplication.do?user_id=${applicant.user_id}&team_id=${team_id}" 
               class="btn btn-success btn-sm">승인</a>
            <a href="rejectApplication.do?user_id=${applicant.user_id}" 
               class="btn btn-danger btn-sm">거부</a>
        </td>
    </tr>
<c:forEach var="applicant" items="${applicants}">
    <tr>
        <td>${applicant.user_name}</td>
        <td>${applicant.birthdate}</td>
        <td>${applicant.gender}</td>
        <td>${applicant.content}</td>
        <td>
            <a href="approveApplication.do?user_id=${applicant.user_id}&team_id=${team_id}" 
               class="btn btn-success btn-sm">승인</a>
            <a href="rejectApplication.do?user_id=${applicant.user_id}" 
               class="btn btn-danger btn-sm">거부</a>
        </td>
    </tr>
</c:forEach>