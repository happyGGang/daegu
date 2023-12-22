<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#archiveListForm').submit();

		e.preventDefault();
	});

	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD' , function( response, status, xhr ) {
			$('#dialog-1').dialog('open')
		});

		e.preventDefault();
	});

	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&large_code=' + $(this).attr('keyValue1') + '&mid_code=' + $(this).attr('keyValue2') + '&small_code=' + $(this).attr('keyValue3') + '&book_idx=' + $(this).attr('keyValue4'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete-btn').on('click', function(e) {
		if (confirm("해당 자료를 삭제 하시겠습니까?")) {
			$('#hiddenForm #large_code').val($(this).attr('keyValue1'));
			$('#hiddenForm #mid_code').val($(this).attr('keyValue2'));
			$('#hiddenForm #small_code').val($(this).attr('keyValue3'));
			$('#hiddenForm #book_idx').val($(this).attr('keyValue4'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});

	$('a#excelDownload').on('click', function(e) {
		$('#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});

	$('select#large_code').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});

	$('select#producer_name').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});

	$('select#original_owner').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});
	
	$('select#region').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});
	
	$('select#person').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});
	
	$('select#type').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});
	
	$('select#data_type').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});
	
	$('select#era').on('change', function() {
		$('#archiveListForm option.default').prop('selected', true);
		$('#archiveListForm #search_text').val('');
		$('#archiveListForm #viewPage').val(1);
		$('#archiveListForm').submit();
	});

	$('#archiveListForm select#small_code option.all').show();

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#hiddenForm').attr('action', 'csvDownload.do').submit();
	});
	
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#archiveListForm').serialize());
	});

});

function showTitle(title) {
	alert('제목 : ' + title);
}
</script>
<form:form id="hiddenForm" modelAttribute="archive" action="save.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="book_idx"/>
	<form:hidden path="large_code"/>
</form:form>

<form:form id="archiveListForm"  modelAttribute="archive" action="index.do" method="get">

	<div class="infodesk">
		검색 결과 : 총 ${archiveCnt}건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">25개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
		1차 카테고리 :
		<form:select path="large_code" class="selectmenu">
			<form:option class="all" value="--" label="전체" />
			<form:options itemValue="large_code" itemLabel="code_name" items="${largeCategoryList}"/>
		</form:select>
		생산자명 :
		<form:select path="producer_name" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${producerNameList}"/>
		</form:select>
		원본소장처 :
		<form:select path="original_owner" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${originalOwnerList}"/>
		</form:select>
		지역 :
		<form:select path="region" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${regionList}"/>
		</form:select>
		인물 :
		<form:select path="person" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${personList}"/>
		</form:select>
		<br/>
		유형 :
		<form:select path="type" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${typeList}"/>
		</form:select>
		형태 :
		<form:select path="data_type" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${dataTypeList}"/>
		</form:select>
		시대 :
		<form:select path="era" class="selectmenu">
			<form:option class="all" value="" label="전체" />
			<form:options itemValue="code_id" itemLabel="code_name" items="${eraList}"/>
		</form:select>
<!-- 			<span>2차 카테고리 : -->
<%-- 				<form:select path="mid_code"> --%>
<%-- 					<form:option class="all" value="--" label="전체" /> --%>
<%-- 					<form:options itemValue="mid_code" itemLabel="code_name" items="${midCategoryList}"/> --%>
<%-- 				</form:select> --%>
<!-- 			</span> -->
<!-- 			<span>3차 카테고리 : -->
<%-- 				<form:select path="small_code" > --%>
<%-- 					<form:option class="all" value="--" label="전체" /> --%>
<%-- 					<form:options itemValue="small_code" itemLabel="code_name" items="${smallCategoryList}"/> --%>
<%-- 				</form:select> --%>
<!-- 			</span> -->
		<div class="button">
			<span>
			<c:if test="${authC}">
				<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
			</span>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="70" />
			<col width="130" />
			<col width="130"/>
			<col width="130"/>
			<col width="" />
			<col width="100" />
			<col width="130" />
			<col width="100" />
			<col width="160" />
			<col width="100" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>관리번호</th>
				<th>관련번호</th>
				<th>제목</th>
				<th>생산연도</th>
				<th>생산자명</th>
				<th>유형</th>
				<th>원본소장처</th>
				<th>형태</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${archiveList}">
				<tr>
					<td>${archive.listRowNum - status.index}</td>
					<td>${i.large_code_name}</td>
					<td>${i.manage_num}</td>
					<td>${i.related_number}</td>
					<c:choose>
						<c:when test="${fn:length(i.title) > 16}">
							<td><a href="javascript:void(0);" id="title" onclick="showTitle('${i.title}');">${fn:substring(i.title,0,15)}..</a></td>
						</c:when>
						<c:otherwise>
							<td>${i.title}</td>
						</c:otherwise>
					</c:choose>
					<td>${i.product_year}</td>
					<td>${i.producer_name}</td>
					<td>${i.type}</td>
					<td>${i.original_owner}</td>
					<td>${i.data_type}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" keyValue1="${i.large_code}" keyValue2="${i.mid_code}" keyValue3="${i.small_code}" keyValue4="${i.book_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue1="${i.large_code}" keyValue2="${i.mid_code}" keyValue3="${i.small_code}" keyValue4="${i.book_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${archiveListCount eq 0}">
				<tr>
					<td colspan="12">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#archiveListForm"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option class="default" value="">선택</form:option>
				<form:option value="manage_num">관리번호</form:option>
				<form:option value="related_number">관련번호</form:option>
				<form:option value="producer_name">생산자명</form:option>
				<form:option value="type">유형</form:option>
				<form:option value="title">제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</fieldset>

	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="아카이브 정보"></div>