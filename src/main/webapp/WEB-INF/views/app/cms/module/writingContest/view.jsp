<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#writingContestView').serialize());
	});
	
});
</script>

<form:form modelAttribute="writingContest" id="writingContestView" >
<form:hidden path="homepage_id"/>
<form:hidden path="writing_idx"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>참가분야</th>
				<td>
					<c:choose>
						<c:when test="${getWritingContest.participation_field eq '0'}">소년부(초등~중등)</c:when>
						<c:when test="${getWritingContest.participation_field eq '1'}">장년부(고등~일반)</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>종류</th>
				<td>
					<c:choose>
						<c:when test="${getWritingContest.writing_type eq '0'}">운문</c:when>
						<c:when test="${getWritingContest.writing_type eq '1'}">산문</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>성명</th>
				<td>${getWritingContest.user_name}</td>
			</tr>
			<tr>
				<th>학교명</th>
				<td>${getWritingContest.school_name}</td>
			</tr>
			<tr>
				<th>학년</th>
				<td>${getWritingContest.school_year}학년</td>
			</tr>
			<tr>
				<th>휴대폰(본인)</th>
				<td>${getWritingContest.user_phone}</td>
			</tr>
			<tr>
				<th>휴대폰(보호자)</th>
				<td>${getWritingContest.protector_phone}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${getWritingContest.user_email}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(${getWritingContest.postcode}) ${getWritingContest.address_base} ${getWritingContest.address_detailed} </td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<c:choose>
						<c:when test="${getWritingContest.approval_status eq '0'}">신청</c:when>
						<c:when test="${getWritingContest.approval_status eq '1'}">승인</c:when>
						<c:when test="${getWritingContest.approval_status eq '2'}">취소</c:when>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

