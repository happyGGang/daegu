<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}
		
		e.preventDefault();
	});
	
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue') + '&popup_idx=' + $(this).attr('keyValue1'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete').on('click', function(e) {
		if(confirm('선택된 팝업을 삭제 하시겠습니까?')) {
			$('input#homepage_id_1').val($(this).attr('keyValue'));
			$('input#popup_idx_1').val($(this).attr('keyValue1'));
			
			$.ajax({
				url : 'delete.do',
				async : false,
				data : serializeObject($('#popup_1')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
					else {
						if ( data.message != null ) {
							alert(data.message);
						}
						else {
							alert(data.result);	
						}
					}
				}
			});
		}
		
		e.preventDefault();
	}); 
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#popup_1').attr('action', 'index.do');
			doGetLoad('index.do', serializeCustom($('#popup_1')));
		}
		
		e.preventDefault();
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#popup_1')));
	});
});	
</script> 
<form:form id="popup_1" modelAttribute="popup" method="POST" action="save.do" onsubmit="return false;">
<form:hidden id="editMode_1" path="editMode"/>
<form:hidden id="popup_idx_1" path="popup_idx"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>

<div id="editDisable" class="disableBox">
	<c:if test="${popup.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div class="infodesk">
		검색 결과 : ${paging.totalDataCount}건, 홈페이지 ID : ${popup.homepage_id}
		<div class="button btn-group inline">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>팝업등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="40">순번</th>
				<th width="">팝업명</th>
				<th width="100">팝업타입</th>
				<th width="50">사용여부</th>
				<th width="300">게시일</th>
				<th width="120">등록일</th>
				<th width="100">기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(popupList) < 1}">
			<tr>
				<td colspan="7" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${popupList}">
			<tr>
				<td width="40">${popup.listRowNum - status.index}</td>
				<td class="left" width="">${i.popup_name}</td>
				<td width="100">${i.popup_type}</td>
				<td width="50">${i.use_yn}</td>
				<td width="300">${i.start_date} ~ ${i.end_date}</td>
				<td width="120"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
				<td width="120">
					<c:if test="${authU}">
						<a href="" class="btn" id="dialog-modify" keyValue="${i.homepage_id}" keyValue1="${i.popup_idx}">수정</a>
					</c:if>
					<c:if test="${authD}">
						<a href="" class="btn" id="delete" keyValue="${i.homepage_id}" keyValue1="${i.popup_idx}">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#popup_1"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="POPUP_NAME">팝업명</form:option>
				<form:option value="POPUP_TYPE">팝업타입</form:option>
				<form:option value="USE_YN">사용여부</form:option>
				<form:option value="START_DATE">시작일</form:option>
				<form:option value="END_DATE">종료일</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="팝업 정보">
</div>