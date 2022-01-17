<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('a#save_btn').on('click', function(e) {
		e.preventDefault();
		if(doAjaxPost($('#relayLectureApplyEdit'))) {
			location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
		}
	});
	
	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
});
</script>

<form:form modelAttribute="relayLectureApply" id="relayLectureApplyEdit" action="save.do" >
<form:hidden path="menu_idx"/>
<form:hidden path="lecture_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th class="center" colspan="4">${getRelayLecture.event_name}</th>
			</tr>
			<tr>
				<th>행사일자</th>
				<td>${getRelayLecture.event_start_date} ~ ${getRelayLecture.event_end_date}</td>
				<th>행사시간</th>
				<td>${getRelayLecture.event_start_time} ~ ${getRelayLecture.event_end_time}</td>
			</tr>
			<tr>
				<th>행사장소</th>
				<td>${getRelayLecture.event_place}</td>
				<th>모집인원</th>
				<td>${getRelayLecture.recruitment_number}명</td>
			</tr>
			<tr>
				<th>신청 가능 기간</th>
				<td colspan="3">${getRelayLecture.apply_start_date} ${getRelayLecture.apply_start_time} ~ ${getRelayLecture.apply_end_date} ${getRelayLecture.apply_end_time} </td>
			</tr>
		</tbody>
	</table>

	<div class="wrapper-bbs">
		<p><b style="color: red;">(*)</b>표시항목은 필수입력항목입니다.</p>
		<table class="bbs-edit" summary="릴레이강연 행사 신청">
			<caption>릴레이강연 행사 신청</caption>
			<colgroup>
				<col width="20%">
				<col width="">
			</colgroup>
			<tbody id="board_tbody">
				<tr>
					<th>이름<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="applicant_name" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>성별<b style="color: red;">(*)</b></th>
					<td>
						<form:select path="applicant_sex">
							<form:option value="">선택</form:option>
							<form:option value="M">남</form:option>
							<form:option value="W">여</form:option>
						</form:select>
					</td>
				</tr>
				<tr>
					<th>연령대<b style="color: red;">(*)</b></th>
					<td>
						<form:radiobutton path="applicant_age" value="0" label="영유아(0~7세)" /><br/>
						<form:radiobutton path="applicant_age" value="1" label="초등학생(8~13세)" /><br/>
						<form:radiobutton path="applicant_age" value="2" label="청소년(14~19세)" /><br/>
						<form:radiobutton path="applicant_age" value="3" label="20대(20~29세)" /><br/>
						<form:radiobutton path="applicant_age" value="4" label="30대(30~39세)" /><br/>
						<form:radiobutton path="applicant_age" value="5" label="40대(40~49세)" /><br/>
						<form:radiobutton path="applicant_age" value="6" label="50대(50~59세)" /><br/>
						<form:radiobutton path="applicant_age" value="7" label="60대이상" />
					</td>
				</tr>
				<tr>
					<th>휴대폰<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="applicant_phone" cssClass="text" />
						<span>※ 입력 예)010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>소속</th>
					<td>
						<form:input path="applicant_belong" cssClass="text" />
						<span>※ 입력 예) 수성구청 OO과</span>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="button bbs-btn center">
			<a href="#" id="save_btn" class="btn btn1">신청하기</a>
			<a href="#" id="cancle_btn" class="btn">취소</a>
		</div>
	</div>
</form:form>

