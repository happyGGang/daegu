<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#lectureRequestView').serialize());
	});
	
});
</script>

<form:form modelAttribute="lectureRequest" id="lectureRequestView" >
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>강좌고유번호</th>
				<td>${lectureRequest.lecture_id}</td>
			</tr>
			<tr>
				<th>강좌 제목</th>
				<td>${lectureRequest.lecture_title}</td>
			</tr>
			<tr>
				<th>신청자명</th>
				<td>${lectureRequest.request_name}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${lectureRequest.birthday}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${lectureRequest.gender}</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td>${lectureRequest.phone_number}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${lectureRequest.email}</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>${lectureRequest.zip_code}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${lectureRequest.address1}<br>${lectureRequest.address2}</td>
			</tr>
			<tr>
				<th>예약상태</th>
				<td>${lectureRequest.request_status}</td>
			</tr>
			<tr>
				<th>접수방법</th>
				<td>${lectureRequest.request_type}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<fmt:formatDate var="formatRegDate" value="${lectureRequest.add_date}" pattern="yyyy-MM-dd"/>
				<td>${formatRegDate}</td>
			</tr>
			<tr>
				<th>등록 아이디</th>
				<td>${lectureRequest.add_id}</td>
			</tr>
			<tr>
				<th>등록 아이피</th>
				<td>${lectureRequest.add_ip}</td>
			</tr>
			<tr>
				<th>취소여부</th>
				<td>${lectureRequest.cancel_yn}</td>
			</tr>
			<tr>
				<th>취소일</th>
				<fmt:formatDate var="formatCancelDate" value="${lectureRequest.cancel_date}" pattern="yyyy-MM-dd"/>
				<td>${formatCancelDate}</td>
			</tr>
			<tr>
				<th>취소 아이디</th>
				<td>${lectureRequest.cancel_id}</td>
			</tr>
			<tr>
				<th>취소 아이피</th>
				<td>${lectureRequest.cancel_ip}</td>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

