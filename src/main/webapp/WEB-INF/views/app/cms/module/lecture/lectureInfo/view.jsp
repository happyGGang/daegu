<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#lectureInfoView').serialize());
	});
	
});
</script>

<form:form modelAttribute="lectureInfo" id="lectureInfoView" >
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="viewPage"/>
<form:hidden path="searching_course_id"/>
<form:hidden path="searching_reservation"/>
<form:hidden path="searching_edu_status"/>
<form:hidden path="searching_request_type"/>
<form:hidden path="start_period"/>
<form:hidden path="end_period"/>
<form:hidden path="search_text"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>과정고유번호</th>
				<td>${lectureInfo.course_id}</td>
			</tr>
			<tr>
				<th>강좌고유번호</th>
				<td>${lectureInfo.lecture_id}</td>
			</tr>
			<tr>
				<th>강좌명</th>
				<td>${lectureInfo.lecture_title}</td>
			</tr>
			<tr>
				<th>접수기간</th>
				<td>${lectureInfo.request_start_date} ~ ${lectureInfo.request_end_date}</td>
			</tr>
			<tr>
				<th>교육기간</th>
				<td>${lectureInfo.edu_start_date} ~ ${lectureInfo.edu_end_date}</td>
			</tr>
			<tr>
				<th>교육요일</th>
				<td>
					${fn:contains(lectureInfo.day_week, '1')?'월':''}
					${fn:contains(lectureInfo.day_week, '2')?'화':''}
					${fn:contains(lectureInfo.day_week, '3')?'수':''}
					${fn:contains(lectureInfo.day_week, '4')?'목':''}
					${fn:contains(lectureInfo.day_week, '5')?'금':''}
					${fn:contains(lectureInfo.day_week, '6')?'토':''}
					${fn:contains(lectureInfo.day_week, '7')?'일':''}
				</td>
			</tr>
			<tr>
				<th>교육시간</th>
				<td>${lectureInfo.edu_start_time} ~ ${lectureInfo.edu_end_time}</td>
			</tr>
			<tr>
				<th>온라인 모집인원</th>
				<td>${lectureInfo.online_person_count} 명</td>
			</tr>
			<tr>
				<th>대기 모집인원</th>
				<td>${lectureInfo.wait_person_count} 명</td>
			</tr>
			<tr>
				<th>오프라인 모집인원</th>
				<td>${lectureInfo.offline_person_count} 명</td>
			</tr>
			<tr>
				<th>접수방법</th>
				<td>${lectureInfo.request_type}</td>
			</tr>
			<tr>
				<th>담당자명</th>
				<td>${lectureInfo.supporter_name}</td>
			</tr>
			<tr>
				<th>담당자 연락처</th>
				<td>${lectureInfo.supporter_tel}</td>
			</tr>
			<tr>
				<th>강사명</th>
				<td>${lectureInfo.teacher_name}</td>
			</tr>
			<tr>
				<th>강사 연락처</th>
				<td>${lectureInfo.teacher_tel}</td>
			</tr>
			<tr>
				<th>교육장</th>
				<td>${lectureInfo.edu_school}</td>
			</tr>
			<tr>
				<th>교육장 주소</th>
				<td>${lectureInfo.edu_address_1}</td>
			</tr>
			<tr>
				<th>교육장 상세주소</th>
				<td>${lectureInfo.edu_address_2}</td>
			</tr>
			<tr>
				<th>교육소개</th>
				<td>${lectureInfo.lecture_content}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<fmt:formatDate var="formatRegDate" value="${lectureInfo.add_date}" pattern="yyyy-MM-dd hh:mm:ss"/>
				<td>${formatRegDate}</td>
			</tr>
			<tr>
				<th>등록ID</th>
				<td>${lectureInfo.add_id}</td>
			</tr>
			<tr>
				<th>등록IP</th>
				<td>${lectureInfo.add_ip}</td>
			</tr>
			<tr>
				<th>강사ID</th>
				<td>${lectureInfo.teacher_id}</td>
			</tr>
			<tr>
				<th>교육장 부속</th>
				<td>${lectureInfo.edu_second_school}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><a href="/cms/module/lecture/lectureInfo/download/${file.homepage_id}/${file.file_server_name}.do">${file.file_original_name}</a></td>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

