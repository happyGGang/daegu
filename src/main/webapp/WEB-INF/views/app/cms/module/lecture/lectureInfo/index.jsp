<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

$(function() {

	$('a#dialog-add').on('click', function(e){
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureList').serialize());
	});

	// 삭제 버튼
	$('a.delete_btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('정말로 삭제하시겠습니까?\n\n삭제된 신청은 복구가 불가능합니다.')) {
			$('form#lectureInfo').attr('action', 'delete.do');
			$('#lecture_id').val($(this).data('key'));
			$('#editMode').val('DELETE');
			doAjaxPost($('form#lectureInfo'));
			location.reload();
		}
	});

	// 수정 버튼
	$('a.modify_btn').on('click', function(e){
		e.preventDefault();
		let lecture_id = $(this).data('key');
		$('#dialog-2').load('edit.do?editMode=UPDATE&lecture_id='+lecture_id, function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	// 강좌명 클릭
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#lecture_id').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#lectureInfo')));
	});

	// 보이는 개수 변경
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

	// 검색 접수기간 시작일
	$('input#start_period').datepicker({
		maxDate: $('input#end_period').val(),
		onClose: function(selectedDate){
			$('input#end_period').datepicker('option', 'minDate', selectedDate);
		}
	});

	// 검색 접수기간 종료일
	$('input#end_period').datepicker({
		minDate: $('input#start_period').val(),
		onClose: function(selectedDate){
			$('input#start_period').datepicker('option', 'maxDate', selectedDate);
		}
	});

	// 검색 버튼
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#lectureInfo')));
	});

});
</script>

<style>
	.search {
		padding: 0;

	}
	.search-row {
		border-bottom: #DDDDDD solid 1px;
		padding: 10px;
	}
	.search-row-bottom {
		border-bottom: none;
		padding: 10px;
	}
	.search-item {
		display: inline;
	}
	.search-title {
		display: inline-block;
		text-align: center;
		width: 10%;
	}
</style>

<form:form modelAttribute="lectureInfo">
<form:hidden path="homepage_id"/>
<form:hidden path="lecture_id"/>
<form:hidden path="editMode"/>

	<div class="infodesk">

		<div class="search">
			<fieldset>
				<div class="search-row">
					<div class="search-title">과정선택</div>
					<div class="search-item">
						<form:select path="searching_course_id" cssClass="selectmenu" cssStyle="width: 80%">
							<c:forEach var="i" varStatus="status" items="${courseInfoList}">
								<form:option value="${i.course_id}">${i.course_title} ${i.use_yn eq "N" ? '(미사용)' : ''}</form:option>
								<c:if test="${i.course_id eq lectureInfo.searching_course_id}">
									<c:set var="course_title" value="${i.course_title}"/>
								</c:if>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="search-row">
					<div class="search-title">예약상태</div>
					<div class="search-item">
						<form:select path="searching_reservation" cssClass="selectmenu">
							<form:option value="0">전체</form:option>
							<form:option value="1">모집대기</form:option>
							<form:option value="2">모집중</form:option>
							<form:option value="3">모집마감</form:option>
						</form:select>
					</div>
					<div class="search-title">교육상태</div>
					<div class="search-item">
						<form:select path="searching_edu_status" cssClass="selectmenu">
							<form:option value="0">전체</form:option>
							<form:option value="1">교육대기</form:option>
							<form:option value="2">교육중</form:option>
							<form:option value="3">교육마감</form:option>
						</form:select>
					</div>
					<div class="search-title">접수방법</div>
					<div class="search-item">
						<form:select path="searching_request_type" cssClass="selectmenu">
							<form:option value="">전체</form:option>
							<form:option value="선착순">선착순</form:option>
							<form:option value="추첨제">추첨제</form:option>
						</form:select>
					</div>
					<div class="search-title">접수기간</div>
					<div class="search-item">
						<form:input path="start_period" cssClass="text ui-calendar" readonly="true"/>
						~
						<form:input path="end_period" cssClass="text ui-calendar" readonly="true"/>
					</div>
				</div>
				<div class="search-row-bottom">
					<div class="search-title">강좌명</div>
					<div class="search-item">
						<form:input path="search_text" cssClass="text" cssStyle="width: 75%"/>
					</div>
					<div class="search-item">
						<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
					</div>
				</div>
			</fieldset>
		</div>

		<h2 style="display: inline">${course_title}</h2>
		검색 결과 : 총 ${lectureInfoCount}건
		
		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		
		<div class="button">
			<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	<div>
		<table class="type1 center">
			<colgroup>
				<col width="5%" />  <%--순번--%>
				<col width="15%" /> <%--강좌명--%>
				<col width="6%" /> <%--접수방법--%>
				<col width="17%" /> <%--접수기간 / 교육기간--%>
				<col width="7%" /> <%--온라인 모집인원--%>
				<col width="7%" /> <%--오프라인 모집인원--%>
				<col width="7%" /> <%--대기자모집인원--%>
				<col width="10%" /> <%--교육장--%>
				<col width="10%" /> <%--강사명--%>
				<col width="10%" /> <%--등록일--%>
				<col width="" /> <%--관리--%>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>강좌명</th>
					<th>접수<br>방법</th>
					<th>접수기간 /<br>교육기간</th>
					<th>온라인<br>모집인원</th>
					<th>오프라인<br>모집인원</th>
					<th>대기자<br>모집인원</th>
					<th>교육장</th>
					<th>강사명</th>
					<th>등록일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${lectureInfoList}">
				<tr>
					<td>${i.reverse_rownum}</td>
					<td><a href="#" class="view_btn" data-key="${i.lecture_id}">${i.lecture_title}</a></td>
					<td>${i.request_type}</td>
					<td>
						${i.request_start_date} ~ ${i.request_end_date}
						<br>
						${i.edu_start_date} ~ ${i.edu_end_date}
					</td>
					<td>0 / ${i.online_person_count}</td>
					<td>0 / ${i.offline_person_count}</td>
					<td>0 / ${i.wait_person_count}</td>
					<td>${i.edu_school}</td>
					<td>${i.teacher_name}</td>
					<fmt:formatDate var="formatRegDate" value="${i.add_date}" pattern="yyyy-MM-dd"/>
					<td>${formatRegDate}</td>
					<td>
						<a href="#" class="btn modify_btn" data-key="${i.lecture_id}">수정</a>
						<a href="#" class="btn delete_btn" data-key="${i.lecture_id}">삭제</a>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(lectureInfoList) < 1}">
					<tr>
						<td colspan="11">등록된 회원정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#lectureInfo"/>
		</jsp:include>
	</div>

</form:form>

<div id="dialog-1" class="dialog-common" title="강좌 등록"></div>
<div id="dialog-2" class="dialog-common" title="강좌 수정"></div>
