<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	
	<%--검색--%>
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#member_index').serialize());
	});
	
	<%--사용자등록--%>
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	<%--사용자수정--%>
	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	<%--사용자삭제--%>
	$('a.delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('해당 사용자(' + $(this).attr('keyValue') + ')를 정보를 삭제 하시겠습니까?')) {
			$('input#editMode_index').val('DELETE');
			$('input#member_id_index').val($(this).attr('keyValue'));
			if(doAjaxPost($('#member_index'))) {
				location.reload();
			}	
		}
	});

	<%--그룹설정--%>
	$('a.grouping').on('click', function(e) {
		e.preventDefault();
		$('#dialog-3').load('grouping_ajax.do?member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});
	
	<%--10개씩보기--%>
	$('select#rowCount').change(function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#member_index').serialize());
	});
});	
</script>
<form:form id="member_index" modelAttribute="member" action="save.do" method="post" onsubmit="return false;">
<div class="infodesk">
	검색 결과 : ${memberListCount}건 
	<form:select path="rowCount" class="selectmenu" style="width:100px;">
		<form:option value="10">10개씩 보기</form:option>
		<form:option value="20">20개씩 보기</form:option>
		<form:option value="30">30개씩 보기</form:option>
		<form:option value="50">50개씩 보기</form:option>
		<form:option value="${memberListCount}">전체 보기</form:option>
	</form:select>
	<div class="button btn-group inline">
		<a href="" class="btn btn5 left" id="dialog-add" ><i class="fa fa-plus"></i><span> 사용자 등록</span></a>	
	</div>
</div>


<form:hidden id="member_id_index" path="member_id"/>
<form:hidden id="editMode_index" path="editMode"/>
<form:hidden path="search_auth"/>
<form:hidden path="search_auth_name"/>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="50">순번</th>
				<th width="150">사용자ID</th>
				<th width="150">사용자명</th>
				<th width="150">전화번호</th>
				<th width="130">사용자 구분</th>
				<th width="130">사용자 타입</th>
				<th width="130">등록일자</th>
				<th width="">기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(memberList) < 1}">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${memberList}">
			<tr>
				<td width="50">${paging.listRowNum - status.index}</td>
				<td width="150" class="left">${i.member_id}</td>
				<td width="150">${i.member_name}</td>
				<td width="150">${i.phone}</td>
				<td width="130">${i.auth_name_list}</td>
				<td width="130">${i.link_member_yn eq 'Y' ? '일루스 연결회원':''}</td>
				<td width="130"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/> </td>
				<td width="">
					<a href="#" class="btn dialog-modify" id="dialog-modify-${i.member_id}" keyValue="${i.member_id}">수정</a>
					<a href="#" class="btn delete" keyValue="${i.member_id}">삭제</a>
					<a href="#" class="btn btn3 grouping" keyValue="${i.member_id}">그룹설정</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#member_index"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="MEMBER_ID">사용자ID</form:option>
				<form:option value="MEMBER_NAME">사용자명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="사용자 정보">
</div>
<div id="dialog-2" class="dialog-common" title="">
</div>
<div id="dialog-3" class="dialog-common" title="그룹설정">
</div>