<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('a#modify_btn').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('MODIFY');
		doGetLoad('edit.do', $('form#relayLectureView').serialize());
	});

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#relayLectureView').serialize());
	});
	
});
</script>

<form:form modelAttribute="relayLecture" id="relayLectureView" >
<form:hidden path="homepage_id"/>
<form:hidden path="lecture_idx"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>행사명</th>
				<td>${getRelayLecture.event_name}</td>
			</tr>
			<tr>
				<th>행사일자</th>
				<td>${getRelayLecture.event_start_date} ~ ${getRelayLecture.event_end_date}</td>
			</tr>
			<tr>
				<th>행사장소</th>
				<td>${getRelayLecture.event_place}</td>
			</tr>
			<tr>
				<th>행사시간</th>
				<td>${getRelayLecture.event_start_time} ~ ${getRelayLecture.event_end_time}</td>
			</tr>
			<tr>
				<th>신청 가능 기간</th>
				<td>${getRelayLecture.apply_start_date} ${getRelayLecture.apply_start_time} ~ ${getRelayLecture.apply_end_date} ${getRelayLecture.apply_end_time} </td>
			</tr>
			<tr>
				<th>모집인원</th>
				<td>${getRelayLecture.recruitment_number}명</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${getRelayLecture.conrtents}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<c:if test="${getRelayLecture.server_file_name eq NULL}">
					<td>선택된 파일이 없습니다.</td>
				</c:if>
				<c:if test="${getRelayLecture.server_file_name ne NULL}">
					<td>
						<div>
							<img src="${getContextPath}/data/relayLecture/${relayLecture.homepage_id}/${getRelayLecture.server_file_name}" alt="${getRelayLecture.event_name}">
						</div>
					</td>
				</c:if>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="modify_btn" class="btn btn1">수정하기</a>
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

