<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#donateBookListForm').submit();
	});
	
	
	$('a#dialog-add').on('click', function(e) {
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&donate_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		$('#hiddenForm #donate_idx').val($(this).attr('keyValue'));
		if(doAjaxPost($('#hiddenForm'))) {
			location.reload();
		}
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(donateBookList)}' > 0) {
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(donateBookList)}' > 0) {
			$('#hiddenForm').attr('action', 'csvDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		e.preventDefault();
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#donateBookListForm').submit();
		}
		
		e.preventDefault();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="donateBook" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="donate_idx"/>
</form:form>
<form:form id="donateBookListForm"  modelAttribute="donateBook" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${donateBookListCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="100"/>
			<col width="150"/>
			<col width="150"/>
			<col width=""/>
			<col width="100"/>
			<col width="200"/>
			<col width="100"/>
			<col width="100"/>
			
		</colgroup>
		<thead>
			<tr>
				<th>기증년월</th>
				<th>기증자명</th>	
				<th>전화번호</th>
				<th>휴대전화번호</th>	
				<th>기증도서정보</th>
				<th>기증권수</th>	
				<th>기증방법</th>
				<th>기증처리동의</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(donateBookList) < 1}">
				<tr style="height:100%">
					<td colspan="9" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${donateBookList}">
				<tr>
					<td>${i.donate_year}-${i.donate_month}</td>
					<td>${i.name}</td>
					<td>${i.phone}</td>
					<td>${i.cell_phone}</td>
					<td>${i.donate_book}</td>
					<td>${i.donate_count}</td>
					<td>${i.donate_method}</td>
					<td>${i.donate_yn}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.donate_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.donate_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${teachListCount eq 0}">
				<tr>
					<td colspan="8">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#donateBookListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" class="selectmenu">
				<form:option value="name">기증자명</form:option>
				<form:option value="donate_yn">동의여부</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="기증도서정보"></div>