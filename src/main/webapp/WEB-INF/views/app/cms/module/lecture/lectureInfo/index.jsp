<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

$(function() {

	// 등록 버튼
	$('a#dialog-add').on('click', function(e){
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	// 추첨 버튼
	/*$('a.dialog-raffle').on('click', function(e){
		e.preventDefault();
		let dataArr = $(this).data('key').split(",");
		let lecture_id = dataArr[0];
		let request_count = parseInt(dataArr[1]);

		if(request_count > 0) {
			if(!confirm("이미 추첨을 진행했던 강좌입니다.\n다시 추첨하시면 이전 추첨 기록은 사라집니다." +
					"\n정말 추첨하시겠습니까?")) return;
		}

		$('#dialog-3').load('raffle.do?lecture_id='+lecture_id, function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});*/

	// 신청자 버튼
	$('a.dialog_applicant').on('click', function(e){
		e.preventDefault();
		let dataArr = $(this).data('key').split(",");
		let lecture_id = dataArr[0];
		let applicant_type = dataArr[1];

		$('#dialog-4').load('applicant.do?lecture_id='+lecture_id+'&applicant_type='+applicant_type, function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
	});

	// 검색 결과 개수 변경
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

	// 과정선택 select 변경
	$('select#searching_course_id').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

	// 모집상태 select 변경
	$('select#searching_reservation').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

	// 교육상태 select 변경
	$('select#searching_edu_status').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

	// 접수방법 select 변경
	$('select#searching_request_type').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

	// 접수기간 시작 select 변경
	$('#start_period').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

	// 접수기간 종료 select 변경
	$('#end_period').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureInfo').serialize());
	});

});

	// 검색 초기화
	function searchReset() {
		$('#viewPage').val(1);
		$('#searching_course_id').val("");
		$('#searching_reservation').val("0");
		$('#searching_edu_status').val("0");
		$('#searching_request_type').val("");
		$('#start_period').val("");
		$('#end_period').val("");
		$('#search_text').val("");
		doGetLoad('index.do', serializeCustom($('form#lectureInfo')));
	}

	// 추첨 버튼
	function btnRaffle(obj) {

		let dataArr = $(obj).data('key').split(",");
		let lecture_id = dataArr[0];
		let request_count = parseInt(dataArr[1]);

		if(request_count > 0) {
			alert("이미 추첨을 진행했던 강좌이기때문에 더 이상 추첨을 할 수 없습니다.");
			return;
		}

		if(!confirm("추첨을 진행합니다.\n추첨은 단 한번만 할 수 있고 되돌릴 수 없습니다.\n정말 계속 진행하시겠습니까?")) return;

		let jsonData = {
			'lecture_id' : lecture_id,
			'editMode' : 'UPDATE'
		}

		$.ajax({
			type : "post",
			url : "../lectureRequest/saveRaffle.do",
			data : jsonData,
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			dataType : "json"
		}).done(res => {
			if(res.valid) {
				alert(res.message);
				location.reload();
			} else {
				if (res.message != null && res.message != "") {
					alert(res.message);
				} else {
					alert(res.result);
				}
			}
		}).fail(error => {
			console.log(error);
			alert("진행중 문제가 생겼습니다.\n같은 오류가 반복되면 관리자에게 문의하세요.");
		});
	}

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
<form:hidden path="viewPage"/>

	<div class="infodesk">

		<div class="search">
			<fieldset>
				<div class="search-row">
					<div class="search-title">과정선택</div>
					<div class="search-item">
						<form:select path="searching_course_id" cssClass="selectmenu" cssStyle="width: 80%">
							<c:forEach var="i" varStatus="status" items="${courseInfoList}">
								<form:option value="${i.course_id}">${i.use_yn eq "N" ? '(미사용) ' : ''}${i.course_title}</form:option>
								<c:if test="${i.course_id eq lectureInfo.searching_course_id}">
									<c:set var="course_title" value="${i.course_title}"/>
								</c:if>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="search-row">
					<div class="search-title">모집상태</div>
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
						<form:input path="search_text" cssClass="text" cssStyle="width: 70%"/>
					</div>
					<div class="search-item">
						<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
						<button type="button" id="reset_btn" onclick="searchReset()"><i class="fa fa-search"></i><span>초기화</span></button>
					</div>
				</div>
			</fieldset>
		</div>

		<h2 style="display: inline">${course_title}</h2>
		검색 결과 : 총 ${paging.totalDataCount}건

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
				<col width="7%" /> <%--대기자모집인원--%>
				<col width="7%" /> <%--오프라인 모집인원--%>
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
					<th>대기자<br>모집인원</th>
					<th>오프라인<br>모집인원</th>
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
					<td>
						${i.request_type}
						<c:if test="${i.request_type eq '추첨제' and i.lecture_status1 eq '모집마감'}">
							<a href="#" class="btn dialog-raffle" onclick="btnRaffle(this)" data-key="${i.lecture_id},${i.online_request_count}">추첨</a>
						</c:if>
					</td>
					<td>
						${i.request_start_date} ~ ${i.request_end_date}
						<br>
						${i.edu_start_date} ~ ${i.edu_end_date}
					</td>
					<td>
						${i.online_request_count} / ${i.online_person_count}<br>
						<a href="#" class="btn dialog_applicant" data-key="${i.lecture_id},온라인">신청자</a>
					</td>
					<td>
						${i.wait_request_count} / ${i.wait_person_count}<br>
						<a href="#" class="btn dialog_applicant" data-key="${i.lecture_id},대기">신청자</a>
					</td>
					<td>
						${i.offline_request_count} / ${i.offline_person_count}<br>
						<a href="#" class="btn dialog_applicant" data-key="${i.lecture_id},오프라인">신청자</a>
					</td>
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
						<td colspan="11">등록된 강좌가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#lectureInfo"/>
		</jsp:include>
	</div>
	<br>
	<div class="ui-state-highlight">
		<em>※ 추첨제의 강좌는 모집이 마감되고 추첨할 수 있습니다.</em>
	</div>

</form:form>

<div id="dialog-1" class="dialog-common" title="강좌 등록"></div>
<div id="dialog-2" class="dialog-common" title="강좌 수정"></div>
<div id="dialog-3" class="dialog-common" title="신청자 추첨"></div>
<div id="dialog-4" class="dialog-common" title="모집인원"></div>
