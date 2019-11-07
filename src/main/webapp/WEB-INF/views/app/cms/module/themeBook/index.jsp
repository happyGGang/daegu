<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	
	$('a.dialog-add').on('click', function(e) {
		e.preventDefault();
		
		if($('#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			return false;
		}
		
		if($('#manage_idx').val() == null) {
			alert('선택된 테마도서 게시판이 없습니다.');
			return false;
		}
		
		if($('#category1').val() == null) {
			alert('선택된 카테고리가 없습니다. ');
			return false;
		}
		
		$('input#yearmonth').val($(this).attr('keyValue'));
		var formData = 'edit.do?' + serializeParameter(['manage_idx', 'homepage_id', 'editMode', 'yearmonth', 'category1']);
		$('#dialog-1').load(formData, function( response, status, xhr ) {
			$('#dialog-1').dialog({
				width: 600,
				height: 300
			});	
			$('#dialog-1').dialog('open');
		});
	});
	
	
	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('input#yearmonth').val($(this).attr('keyValue'));
		$('input#editMode').val('MODIFY');
		var formData = 'edit.do?' + serializeParameter(['manage_idx', 'homepage_id', 'editMode', 'yearmonth', 'category1']);
		$('#dialog-1').load(formData, function( response, status, xhr ) {
			$('#dialog-1').dialog({
				width: 600,
				height: 300
			});
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.deleteBtn').on('click', function(e) {
		e.preventDefault();
		if (confirm('삭제하시겠습니까?')) {
			$('input#_yearmonth').val($(this).attr('keyValue'));
			if(doAjaxPost($('#deleteForm'))) {
				location.reload();
			}
			
		}
	});
	
	$('a#delete-btn').on('click', function(e) {
		if (confirm("해당 아이디를 블랙리스트 목록에서 삭제하시겠습니까?")) {
			$('form#blackListForm').attr('action', 'save.do');
			$('input#editMode').val('DELETE');
			
			if(doAjaxPost($('#blackListForm'))) {
				location.reload();
			}
		}
	});
	
	$('select#homepage_id').on('change', function(e) {
		e.preventDefault();
		if($(this).val() != '') {
			$('#manage_idx').val('');
			$('#yearmonth').val('');
			$('#themeBook').submit();
		}
	});
	
	$('select#searchYear').on('change', function(e) {
		e.preventDefault();
		if($(this).val() != '') {
			$('#themeBook').submit();
		}
	});
	
	$('select#manage_idx').on('change', function(e) {
		e.preventDefault();
		if($(this).val() != '') {
			$('#themeBook').submit();
		}
	});
	
	$('select#category1').on('change', function(e) {
		e.preventDefault();
		if($(this).val() != '') {
			$('#themeBook').submit();
		}
	});
	
	
	<c:if test="${param.manage_idx eq null and fn:length(boardManageList) > 0}">
	$('#themeBook').submit();
	</c:if>
	
	<c:if test="${themeBook.homepage_id ne null and param.manage_idx eq null and fn:length(boardManageList) < 1}">
	alert('테마도서 게시판이 존재하지 않습니다.');
	</c:if>
	
	<c:if test="${themeBook.homepage_id ne null and param.manage_idx ne null and fn:length(category1List) < 1}">
	alert('테마도서 게시판의 카테고리가 존재하지 않습니다. 카테고리 설정 후 재시도 해주세요.');
	</c:if>
	
});
</script>

<form:form modelAttribute="themeBook" id="deleteForm" method="post" action="/cms/module/themeBook/save.do" onsubmit="return false;">
<form:hidden id="_homepage_id" path="homepage_id"/>
<form:hidden id="_manage_idx" path="manage_idx"/>
<form:hidden id="_yearmonth" path="yearmonth"/>
<form:hidden id="_category1" path="category1"/>
<form:hidden id="_editMode" path="editMode" value="DELETE"/>
</form:form>

<form:form modelAttribute="themeBook" action="index.do">
	<form:hidden path="editMode" />
	<form:hidden path="yearmonth" />
	<c:if test="${!member.admin}">
		<form:hidden path="homepage_id"/>
	</c:if>
	
	<c:if test="${member.admin}">
		<div class="search">
			<fieldset>
				<label class="blind">검색</label>				
				<form:select class="selectmenu-search" style="width:300px" path="homepage_id">
					<form:option value="" label="홈페이지를 선택하세요." />
					<form:options itemValue="homepage_id" itemLabel="homepage_name" items="${homepageList}"/>
				</form:select> 
			</fieldset>
		</div>
	</c:if>
	<div class="search">
		<fieldset>
			테마도서 게시판 : 
			<label class="blind">게시판</label>								
			<form:select class="selectmenu-search" style="width:200px" path="manage_idx" items="${boardManageList}" itemLabel="board_name" itemValue="manage_idx">						
			</form:select>
			카테고리 : 
			<label class="blind">카테고리</label>								
			<form:select class="selectmenu-search" style="width:200px" path="category1" >		
				<form:option value="" label="--선택--" />
				<form:options items="${category1List}" itemValue="code_id" itemLabel="code_name"/>				
			</form:select>
			년도 : 
			<label class="blind">년도</label>								
			<form:select class="selectmenu-search" style="width:200px" path="searchYear">						
				<c:forEach var="i" varStatus="status" items="${yearList}">
					<option value="${i}"<c:if test="${i eq themeBook.searchYear}"> selected="selected"</c:if>>${i}</option>
				</c:forEach>
			</form:select>
		</fieldset>
	</div>

	<table class="type1 center">
		<colgroup>
			<col width="10%" />
			<col  />
			<col width="15%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th>년월</th>
				<th>주제</th>	
				<th>비고</th>	
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" begin="1" end="12" step="1">
				<c:if test="${status.count < 10 }">
				<c:set value="${themeBook.searchYear}-0${status.count}" var="yearmonth"></c:set>
				</c:if>
				<c:if test="${status.count > 9 }">
				<c:set value="${themeBook.searchYear}-${status.count}" var="yearmonth"></c:set>
				</c:if>
			<tr>
				<td class="num">${yearmonth}</td>
				<td>${themeBookList[status.index-1].subject}</td>
				<td>${themeBookList[status.index-1].remark}</td>
				<td>
					<c:choose>
						<c:when test="${themeBookList[status.index-1].subject eq null}">
						<c:if test="${authC}">
					<a href="" class="btn dialog-add" keyValue="${yearmonth}">등록</a>
						</c:if>
						</c:when>
						<c:otherwise>
						<c:if test="${authU}">
					<a href="#" class="btn dialog-modify" keyValue="${yearmonth}">수정</a>
						</c:if>
						<c:if test="${authD}">
					<a href="#" class="btn deleteBtn" keyValue="${yearmonth}">삭제</a>
						</c:if>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
<div class="ui-state-highlight">
	'테마도서' 유형으로 지정된 게시판만 조회됩니다.
</div>	
<div id="dialog-1" class="dialog-common" title="테마도서 주제"></div>
