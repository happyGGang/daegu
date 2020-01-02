<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/cms/js/keyboard.css"/>
<script src="/resources/cms/js/vk_popup.js"></script>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#quickMenuListForm').submit();
	});
	
	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}		
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&quick_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if ( confirm('해당 이미지를 삭제 하시겠습니까?') ) {
			$('#hiddenForm #quick_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}	
		}
		e.preventDefault();
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#quickMenuListForm').submit();
		}
		
		e.preventDefault();
	});
	
	$('select#view_yn, select#rowCount').on('change', function(e) {
		$('#viewPage').val(1);
		$('#quickMenuListForm').submit();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="quickMenu" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="quick_idx"/>
</form:form>
<form:form id="quickMenuListForm"  modelAttribute="quickMenu" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${quickMenuListCount}건
		<form:select path="view_yn" class="selectmenu">
			<option value="">사용여부선택</option>
			<form:option value="Y">사용함</form:option>
			<form:option value="N">사용안함</form:option>
		</form:select>
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
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
			<col width="150">
			<col width="200" />
			<col width="" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
			<col width="100" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이콘</th>
				<th>메뉴명</th>
				<th>링크URL</th>
				<th>링크대상</th>
				<th>노출여부</th>
				<th>등록일</th>
				<th>출력순서</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${quickMenuList}">
				<tr>
					<td>${quickMenu.listRowNum - status.index}</td>
					<td>
						<div class="item">
							<a href="${i.link_url}" target="_blank"><img width="135" height="42" src="${getContextPath}/data/quickMenu/${quickMenu.homepage_id}/${i.server_file_name}" alt="${i.menu_name}"></a>							 
						</div>
					</td>
					<td>${i.menu_name}</td>
					<td>${i.link_url}</td>
					<td>${i.link_target eq 'BLANK' ? '새창' : '현재창'}</td>
					<td>${i.view_yn eq 'Y' ? '사용함' : '사용안함'}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>${i.print_seq}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.quick_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.quick_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${quickMenuListCount eq 0}">
				<tr>
					<td colspan="9">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#quickMenuListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="menu_name">메뉴명</form:option>
				<form:option value="link_use_yn">링크사용여부</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="퀵메뉴 정보"></div>