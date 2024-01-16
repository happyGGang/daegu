<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(event) {
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		event.preventDefault();
	});
	
	$('a#dialog-modify').on('click', function(event) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&access_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		event.preventDefault();
	});
	
	$('a#delete').on('click', function(event) {
		if(confirm('해당 접근가능 IP 설정을 삭제 하시겠습니까?')) {
			$('input#editMode_index').val('DELETE');
			$('input#access_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#accessIp_index'))) {
				location.reload();
			}	
		}
		
		event.preventDefault();
	}); 
});	
</script>
<form:form id="accessIp_index" modelAttribute="accessIp" action="save.do" method="post" onsubmit="return false;">
<form:hidden id="editMode_index" path="editMode"/>
<form:hidden id="access_idx" path="access_idx"/>
</form:form>
<div class="infodesk">
	검색 결과 : ${fn:length(accessIpList)}건
	<div class="button btn-group inline">
		<c:if test="${authC}">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>접근IP 추가</span></a>
		</c:if>
	</div>
</div>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="40"/>
			<col/>
			<col/>
			<col/>
			<col/>
			<col/>
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>IP</th>
				<th>허용여부</th>
				<th>설명</th>
				<th>등록일</th>
				<th>등록ID</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(accessIpList) < 1}">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${accessIpList}">
			<tr>
				<td class="num">${status.count}</td>
				<td>${i.access_ip}</td>
				<td>${i.use_yn}</td>
				<td>${i.remark}</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
				<td>${i.add_id}</td>
				<td>
					<c:if test="${authU}">
						<a href="" class="btn" id="dialog-modify" keyValue="${i.access_idx}">수정</a>
					</c:if>
					<c:if test="${authD}">
						<a href="" class="btn" id="delete" keyValue="${i.access_idx}">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>

<div class="ui-state-highlight">
	<em>* 접근 가능 IP를 모두 삭제하면 접근이 불가능하니 삭제에 유의해 주십시오.</em>
</div>

<div id="dialog-1" class="dialog-common" title="접근가능 IP등록/수정">
</div>