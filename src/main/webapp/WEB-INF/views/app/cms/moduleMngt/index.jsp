<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#moduleMngtListForm').submit();
	});


	$('a#dialog-add').on('click', function(e) {
		var module_type = $('select#module_type option:selected').val();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val()+'&module_type='+module_type, function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&module_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 모듈을 삭제 하시겠습니까?') ) {
			$('#hiddenForm #module_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});

	$('a.dialog-terms').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('moduleTerms.do?module_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	<%--권한설정--%>
	$('a.dialog-auth').on('click', function(e) {
		e.preventDefault();
		$('#dialog-3').load('editAuth.do?module_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
	});

	$('select#rowCount, select#module_type').change(function(e) {
		$('#viewPage').val(1);
		$('#moduleMngtListForm').submit();
	});

});
</script>
<form:form id="hiddenForm" modelAttribute="moduleMngt" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="module_idx"/>
</form:form>

<form:form id="moduleMngtListForm"  modelAttribute="moduleMngt" action="index.do" >
	<div class="infodesk">
		검색 결과 : 총 ${moduleMngtListCount}건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="${moduleMngtListCount}">전체 보기</form:option>
		</form:select>
		구분 :
		<form:select path="module_type" class="selectmenu" style="width:100px;">
			<form:option value="CMS" label="CMS" />
			<form:option value="SITE" label="SITE" />
		</form:select>
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="80" />
			<col width="200" />
			<col width="" />
			<col width="" />
			<c:if test="${moduleMngt.module_type eq 'SITE'}">
			<col width="300" />
			</c:if>
			<c:if test="${moduleMngt.module_type ne 'SITE'}">
			<col width="200" />
			</c:if>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>구분</th>
				<th>모듈명</th>
				<th>모듈설명</th>
				<th>링크URL</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${moduleMngtList}">
				<tr>
					<td>${paging.listRowNum - status.index}</td>
					<td>${i.module_type}</td>
					<td>${i.module_name}</td>
					<td>${i.remark}</td>
					<td>${i.link_url}</td>
					<td>
						<c:if test="${moduleMngt.module_type eq 'SITE'}">
						<a href="" class="btn btn1 dialog-terms" keyValue="${i.module_idx}">약관설정</a>
						</c:if>
<%-- 						<a href="" class="btn btn2 dialog-auth" keyValue="${i.module_idx}">권한설정</a> --%>
						<c:if test="${authU}">
						<a href="" class="btn dialog-modify" keyValue="${i.module_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
						<a href="" class="btn delete-btn" keyValue="${i.module_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${moduleMngtListCount eq 0}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#moduleMngtListForm"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="MODULE_NAME">모듈명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="모듈 정보"></div>
<div id="dialog-2" class="dialog-common" title="모듈 약관 리스트"></div>
<div id="dialog-3" class="dialog-common" title="모듈 권한정보"></div>