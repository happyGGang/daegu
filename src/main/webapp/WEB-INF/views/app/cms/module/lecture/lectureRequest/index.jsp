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
		let search_course_id = $('#search_course_id').val();
		$('#dialog-1').load('edit.do?editMode=ADD&search_course_id='+search_course_id, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});

	// 수정 버튼
	$('a.modify_btn').on('click', function(e){
		e.preventDefault();
		let request_id = $(this).data('key');
		$('#dialog-2').load('edit.do?editMode=UPDATE&request_id='+request_id, function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	// 검색 버튼
	$('button.search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#lectureRequest')));
	});

	// 보이는 개수 변경
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureRequest').serialize());
	});

	// 과정 select 변경
	$('select#search_course_id').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#lectureRequest').serialize());
	});

	// 과정 select 변경
	/*$('select#search_course_id').on('change', function() {
		let course_id = $(this).val();
		$.ajax({
			type:"post",
			url:`/cms/module/lecture/lectureRequest/lectureInfoList.do`,
			data: JSON.stringify({"course_id":course_id}),
			contentType:"application/json; charset=utf-8",
			dataType:"json",
		}).done(res=>{
			let lectureInfos = res.data;
			let lectureInfoList = JSON.parse(lectureInfos);
			$('#search_lecture_id').empty();
			$('#select2-search_lecture_id-container').val("");
			$('#select2-search_lecture_id-container').text("전체");
			$('#search_lecture_id').append(selectItem('', '전체'));
			lectureInfoList.forEach(lectureInfo => {
				$('#search_lecture_id').append(selectItem(lectureInfo.lecture_id, lectureInfo.lecture_title));
			})
		}).fail(error=>{
			alert(error);
		})
	});*/

	// 삭제 버튼
	$('a.delete_btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('정말로 취소하시겠습니까?')) {
			$('form#lectureRequest').attr('action', 'delete.do');
			$('#request_id').val($(this).data('key'));
			$('#editMode').val('DELETE');
			doAjaxPost($('form#lectureRequest'));
			location.reload();
		}
	});

	// 신청자명 클릭
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#request_id').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#lectureRequest')));
	});

});

/**
 * select obtion item
 * */
function selectItem(lecture_id, lecture_title) {
	let item = `<option value="`+lecture_id+`">`+lecture_title+`</option>`
	return item;
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
	.search-text-box {
		display: inline;
		margin-left: 50px;
	}
</style>

<form:form modelAttribute="lectureRequest">
<form:hidden path="homepage_id"/>
<form:hidden path="request_id"/>
<form:hidden path="editMode"/>

	<div class="infodesk">

		<div class="search">
			<fieldset>
				<div class="search-row">
					<div class="search-title">과정선택</div>
					<div class="search-item">
						<form:select path="search_course_id" cssClass="selectmenu" cssStyle="width: 80%">
							<c:forEach var="i" varStatus="status" items="${courseInfoList}">
								<form:option value="${i.course_id}">${i.course_title} ${i.use_yn eq "N" ? '(미사용)' : ''}</form:option>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="search-row">
					<div class="search-title">강좌선택</div>
					<div class="search-item">
						<form:select path="search_lecture_id" cssClass="selectmenu" cssStyle="width: 80%">
							<form:option value="">전체</form:option>
							<c:forEach var="i" varStatus="status" items="${lectureInfoList}">
								<form:option value="${i.lecture_id}">${i.lecture_title}</form:option>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="search-row-bottom">
					<div class="search-title">접수방법</div>
					<div class="search-item">
						<form:select path="search_request_type" cssClass="selectmenu">
							<form:option value="">전체</form:option>
							<form:option value="온라인">온라인</form:option>
							<form:option value="오프라인">오프라인</form:option>
						</form:select>
					</div>
					<div class="search-title">취소여부</div>
					<div class="search-item">
						<form:select path="search_cancel_yn" cssClass="selectmenu">
							<form:option value="N">N</form:option>
							<form:option value="Y">Y</form:option>
						</form:select>
					</div>
					<div class="search-text-box">
						<form:select path="search_type" cssClass="selectmenu">
							<form:option value="request_name">신청자명</form:option>
							<form:option value="phone_number">휴대전화</form:option>
						</form:select>
						<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
						<button class="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
					</div>
				</div>
			</fieldset>
		</div>

		검색 결과 : 총 ${lectureRequestCount}건

		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>

		<div class="button">
			<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>오프라인 등록</span></a>
		</div>
	</div>
	<div>
		<table class="type1 center">
			<colgroup>
				<col width="5%" />  <%--순번--%>
				<col width="15%" /> <%--신청강좌--%>
				<col width="10%" /> <%--신청자 id--%>
				<col width="10%" /> <%--신청자이름--%>
				<col width="10%" /> <%--생년월일--%>
				<col width="15%" /> <%--휴대전화 / 이메일--%>
				<col width=7%" /> <%--예약상태--%>
				<col width="7%" /> <%--접수방법--%>
				<col width="8%" /> <%--등록일--%>
				<col width="5%" /> <%--취소여부--%>
				<col width="" /> <%--관리--%>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>신청강좌</th>
					<th>신청자ID</th>
					<th>신청자이름</th>
					<th>생년월일(성별)</th>
					<th>휴대전화 /<br> 이메일</th>
					<th>예약상태</th>
					<th>접수방법</th>
					<th>등록일</th>
					<th>취소여부</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${lectureRequestList}">
				<tr>
					<td>${i.reverse_rownum}</td>
					<td>${i.lecture_title}</td>
					<td><a href="#" class="view_btn" data-key="${i.request_id}">${i.add_id}</a></td>
					<td><a href="#" class="view_btn" data-key="${i.request_id}">${i.request_name}</a></td>
					<td>${i.birthday}(${i.gender eq '0' ? '남' : '여'})</td>
					<td>${i.phone_number}<br>${i.email}</td>
					<td>${i.request_status}</td>
					<td>${i.request_type}</td>
					<fmt:formatDate var="formatRegDate" value="${i.add_date}" pattern="yyyy-MM-dd"/>
					<td>${formatRegDate}</td>
					<td>${i.cancel_yn}</td>
					<td>
						<a href="#" class="btn modify_btn" data-key="${i.request_id}">신청수정</a>
						<a href="#" class="btn delete_btn" data-key="${i.request_id}">신청취소</a>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(lectureRequestList) < 1}">
					<tr>
						<td colspan="11">등록된 신청정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#lectureInfo"/>
		</jsp:include>
	</div>

</form:form>

<div id="dialog-1" class="dialog-common" title="수강 신청"></div>
<div id="dialog-2" class="dialog-common" title="수강 신청 수정"></div>
