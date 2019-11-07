<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#categoryLayer').load('category.do', serializeCustom($('#categoryListForm')));
	});
	
	
	$('a.dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
			return false;
		}
		if ( $('#categoryListForm #group_idx').val() == 0 ) {
			alert('중분류을 선택해주세요.');	
			return false;
		}
		else {
			$('#dialog-2').load('edit.do?editMode=ADD&'+serializeCustom($('#categoryListForm')), function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			});
		}
		
		e.preventDefault();
	});
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-2').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&group_idx=' + $(this).attr('keyValue2') + '&category_idx=' + $(this).attr('keyValue3') + '&large_category_idx=' + $('select#large_category_idx').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		if ( confirm('해당 소분류를 삭제 하시겠습니까?') ) {
			$('#hiddenCategoryForm #homepage_id').val($(this).attr('keyValue1'));
			$('#hiddenCategoryForm #group_idx').val($(this).attr('keyValue2'));
			$('#hiddenCategoryForm #category_idx').val($(this).attr('keyValue3'));
			if(doAjaxPost($('#hiddenCategoryForm'))) {
				$('a.group_' + $(this).attr('keyValue2')).click();
			}
		}
	});
	
	$('select#teach_type').on('change', function() {
		doGetLoad('index.do', $('form#categoryListForm').serialize());
	});
});
</script>

<c:if test="${auth.editMode eq 'FIRST'}">
<div class="mask"></div>
</c:if>
<form:form id="hiddenCategoryForm" modelAttribute="category" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="large_category_idx"/>
<form:hidden path="group_idx"/>
<form:hidden path="category_idx"/>
</form:form>
<form:form id="categoryListForm"  modelAttribute="category" action="category.do" onsubmit="return false;" >
<form:hidden path="large_category_idx"/>
<form:hidden path="group_idx"/>
<form:hidden path="homepage_id"/>
	<h3>소분류정보<c:if test="${not empty categoryGroupOne}"> (${categoryGroupOne.group_name})</c:if></h3>
	<div class="group-menu-header">
		검색 결과 : 총 ${categoryListCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left dialog-add" ><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="" />
			<col width="150" />
			<col width="100" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>소분류명</th>
				<th>신청제한단위</th>
				<th>신청제한수</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${categoryList}">
				<tr>
					<td>${category.listRowNum - status.index}</td>
					<td>${i.category_name}</td>
					<td>
						<c:if test="${i.req_limit_yn eq 'Y'}">
						<c:choose>
						<c:when test="${i.req_limit_type eq '1'}">
						1년
						</c:when>
						<c:when test="${i.req_limit_type eq '6'}">
						6개월
						</c:when>
						<c:when test="${i.req_limit_type eq '3'}">
						3개월
						</c:when>
						</c:choose>
						</c:if>
					</td>
					<td>${i.req_limit_count}</td>
<%-- 					<td>${i.print_seq}</td> --%>
<%-- 					<td>${i.use_yn}</td> --%>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${categoryListCount eq 0}">
				<tr>
					<td colspan="5">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging_ajax.jsp" flush="false">
		<jsp:param name="formId" value="#categoryListForm"/>
		<jsp:param name="layerId" value="#categoryLayer"/>
		<jsp:param name="pagingUrl" value="category.do"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="CATEGORY_NAME">소분류명</form:option>
				<%-- <form:option value="USE_YN">사용여부</form:option> --%>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-2" class="dialog-common" title="소분류 정보"></div>