<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#bookStoreListForm')));

		e.preventDefault();
	});
	
	
	$('a#dialog-add').on('click', function(e) {		
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&bookstore_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if(confirm("해당 신청내역을 삭제하시겠습니까?")) {
			$('#hiddenForm #bookstore_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}	
		}
		e.preventDefault();
		
	});
	
	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(bookStoreList)}' > 0) {
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		e.preventDefault();
	});
	
});
</script>
<form:form id="hiddenForm" modelAttribute="bookStore" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="bookstore_idx"/>
</form:form>
<form:form id="bookStoreListForm"  modelAttribute="bookStore" action="index.do" >
	<div class="infodesk">
		검색 결과 : 총 ${bookStoreListCount}건
		<div class="button">			
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>			
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="200"/>
			<col width="130"/>
			<col width=""/>
			<col width="200"/>
			<col width="200"/>
			<col width="200"/>
			<col width="100"/>
			
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>대출번호</th>	
				<th>대출자명</th>
				<th>제목</th>	
				<th>등록번호</th>
				<th>청구기호</th>	
				<th>신청일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(bookStoreList) < 1}">
				<tr style="height:100%">
					<td colspan="9" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${bookStoreList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>${i.loan_seq }</td>
					<td>${i.loan_name }</td>
					<td>${i.title }</td>
					<td>${i.regist_num }</td>
					<td>${i.claim_sign }</td>
					<td>${i.add_date }</td>
					<td>
						<a href="" class="btn" id="dialog-modify" keyValue="${i.bookstore_idx}">수정</a>
						<a href="" class="btn" id="delete-btn" keyValue="${i.bookstore_idx}">삭제</a>
					</td>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookStoreListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" class="selectmenu">
				<form:option value="loan_name">대출자명</form:option>
				<form:option value="title">제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="신청자정보"></div>