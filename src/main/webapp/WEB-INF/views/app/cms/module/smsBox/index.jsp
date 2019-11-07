<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#smsBoxListForm')));

		e.preventDefault();
	});
	
	$('a#dialog-add').on('click', function(e) {		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&box_idx=' + $(this).attr('keyValue')+'&homepage_id='+$('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if(confirm("해당내용을 삭제하시겠습니까?")) {
			$('#hiddenForm #box_idx').val($(this).attr('keyValue'));
			
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}	
		}
		e.preventDefault();
		
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#smsBoxListForm').submit();
		}
		
		e.preventDefault();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="smsBox" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="box_idx"/>
</form:form>
<form:form id="smsBoxListForm"  modelAttribute="smsBox" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총  ${smsBoxCnt}건
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
			<col width="150"/>
			<col width=""/>
			<col width="100"/>
			<col width="200"/>
			<col width="200"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>	
				<th>내용</th>	
				<th>사용유무</th>
				<th>등록일</th>					
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(smsBoxList) < 1}">
				<tr style="height:100%">
					<td colspan="6" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${smsBoxList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>${i.title}</td>
					<td>${i.contents}</td>
					<td>${i.use_yn}</td>
					<td>${i.add_date }</td>
					<td>
						<c:if test="${authU}">
						<a href="" class="btn" id="dialog-modify" keyValue="${i.box_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
						<a href="" class="btn" id="delete-btn" keyValue="${i.box_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>			
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#smsBoxListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" class="selectmenu">
				<form:option value="title">제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="문자함 내용"></div>