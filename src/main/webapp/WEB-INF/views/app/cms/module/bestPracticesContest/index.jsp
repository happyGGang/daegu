<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bestPracticesContest').serialize());
	});
	
	$('a#dialog-add').on('click', function(e){
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#best_practices_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#bestPracticesContest')));
	});
	
	$('a.delete_btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('정말로 삭제하시겠습니까?\n\n삭제된 신청은 복구가 불가능합니다.')) {
			$('form#bestPracticesContest').attr('action', 'delete.do');
			$('#best_practices_idx').val($(this).data('key'));
			$('#editMode').val('DELETE');
			doAjaxPost($('form#bestPracticesContest'));
			location.reload();
		}
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#bestPracticesContest')));
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#bestPracticesContest').attr('action', 'excelDownload.do').submit();
		$('#bestPracticesContest').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#bestPracticesContest').attr('action', 'csvDownload.do').submit();
	});
	
});
</script>

<form:form modelAttribute="bestPracticesContest">
<form:hidden path="homepage_id"/>
<form:hidden path="best_practices_idx"/>
<form:hidden path="editMode"/>

	<div class="infodesk">
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
				<col width="5%" />
				<col width="15%"/>
				<col width=""/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>공모분야</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${bestPracticesContestList}">
					<tr>
						<td>${paging.listRowNum - status.index}</td>
						<td>
							<c:choose>
								<c:when test="${i.contest_field eq '1'}">개인 &#124; 소년부(초등~중등)</c:when>
								<c:when test="${i.contest_field eq '2'}">개인 &#124; 장년부(고등~일반)</c:when>
								<c:when test="${i.contest_field eq '3'}">단체 &#124; 소년부(초등~중등)</c:when>
								<c:otherwise>단체 &#124; 장년부(고등~일반)</c:otherwise>
							</c:choose>
						</td>
						<td class="left">
							<a href="#" class="view_btn" data-key="${i.best_practices_idx}">${i.title}</a>
						</td>
						<td>${i.user_name}</td>
						<td>
							<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" />
						</td>
						<td>${i.view_count}</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(bestPracticesContestList) < 1}">
					<tr>
						<td colspan="10">등록된 회원정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#bestPracticesContest"/>
		</jsp:include>
	
		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu">
					<form:option value="title">제목</form:option>
					<form:option value="contents">내용</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
			</fieldset>
		</div>
		
	</div>
	
</form:form>

<div id="dialog-1" class="dialog-common" title="독서릴레이 신청"></div>
