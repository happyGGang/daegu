<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$form = $('form#survey');
	$('tbody#board_tbody a').on('click', function(e) {
		e.preventDefault();
		$('input#survey_idx').val($(this).attr('keyValue'));
		$('input#popup_yn').val($(this).attr('keyValue2'));
		$('input#open_yn').val($(this).attr('keyValue3'));
		$('input#survey_open_yn').val($(this).attr('keyValue4'));

		if($('input#popup_yn').val() == 'Y') {
			window.open('/${homepage.context_path}/module/survey/edit.do?open_yn='+$(this).attr('keyValue3')+'&survey_idx='+$(this).attr('keyValue')+'&survey_open_yn='+$(this).attr('keyValue4')+'&homepage_id='+$('#homepage_id').val()+'&popup_yn='+$('input#popup_yn').val(), "설문지보기", "width=1024, height=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes");
		} else {
			doGetLoad('edit.do', $form.serialize());
		}
	});

	$('select#rowCount').on('change', function() {
		doGetLoad('index.do', $form.serialize());
	});
});
</script>

<form:form modelAttribute="survey" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="survey_idx"/>
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="popup_yn"/>
<form:hidden path="survey_open_yn"/>
<form:hidden path="open_yn"/>
<div class="wrapper-bbs">
	<div class="infodesk">
		<span class="bbs-result">총 게시물 : <b>${paging.totalDataCount}</b>건</span>
		<div class="button btn-group inline">
			<label for="rowCount"/>
			<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</form:select>
		</div>
	</div>
	<div class="table-wrap">
		<table class="bbs center" summary="설문조사">
			<caption></caption>
			<colgroup>
				<col width="10%">
				<col width="">
				<c:if test="${homepage.homepage_id eq 'h5'}">
					<col width="12%">
				</c:if>
				<col width="12%">
				<col width="12%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th class="important">설문명</th>
					<c:if test="${homepage.homepage_id eq 'h5'}">
						<th>응모자수</th>
					</c:if>
					<th class="important mmm2">시작일</th>
					<th class="important mmm2">종료일</th>
					<th class="mmm1">상태</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${surveyList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td class="important left">
						<a href="" keyValue="${i.survey_idx}" keyValue2="${i.popup_yn}" keyValue3="${i.open_yn }" keyValue4="${i.survey_open_yn }">
							<span>${i.survey_title}</span>
						</a>
					</td>
					<c:if test="${homepage.homepage_id eq 'h5'}">
						<td>${i.answer_count}</td>
					</c:if>
					<td class="important mmm2">${i.survey_start_date}</td>
					<td class="important mmm2">${i.survey_end_date}</td>
					<td class="num mmm1"${i.survey_open_yn eq 'Y' ? '' : 'style="color:red;"'}>${i.survey_open_yn eq 'Y' ? '진행중' : '마감'}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(surveyList) < 1}">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">등록된 설문조사가 없습니다.</td>
			</tr>
		</table>
		</c:if>
	</div>

	<form:hidden path="viewPage"/>
	<div id="board_paging" class="dataTables_paginate">
	<c:if test="${paging.firstPageNum > 0}">
		<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
	</c:if>
	<c:if test="${paging.prevPageNum > 0}">
		<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
	</c:if>
		<span>
	<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
	<c:choose>
	<c:when test="${i eq paging.viewPage}">
		<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
	</c:when>
	<c:otherwise>
		<a href="" class="paginate_button" keyValue="${i}">${i}</a>
	</c:otherwise>
	</c:choose>
	</c:forEach>
	<c:if test="${paging.nextPageNum > 0}">
		<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
	</c:if>
	<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
		<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
	</c:if>
		</span>
	</div>

	<div class="search txt-center mmm2" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<label for="search_type" class="blind">검색</label>
			<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
				<form:option value="survey_title">제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" />
			<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
		</fieldset>
	</div>

	<script type="text/javascript">
	$(document).ready(function() {
		$('div#board_paging a').on('click', function(e) {
			$('#viewPage').attr('value', $(this).attr('keyValue'));
			var param = serializeCustom($('form#survey'));
			doGetLoad('index.do', param);
			e.preventDefault();
		});

		$('button.btnSearch').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#survey'));
			doGetLoad('index.do', param);
		});

		$('input#search_text').keyup(function(e) {
			e.preventDefault();
			if(e.keyCode == 13) {
				$('#viewPage').attr('value', '1');
				var param = serializeCustom($('form#survey'));
				doGetLoad('index.do', param);
			}
		});
	});
	</script>
</div>
</form:form>
