<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/cms/js/keyboard.css"/>

<script type="text/javascript">
$(function() {

	$('a#dialog-add').on('click', function(e) {

		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&terms_idx='+$(this).attr("keyValue"), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a#dialog-view').on('click', function(e) {
		$('#dialog-2').load('view.do?terms_idx='+$(this).attr("keyValue"), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		e.preventDefault();
	});

	$('a#delete-btn').on('click', function(e) {
		if ( confirm('해당 이미지를 삭제 하시겠습니까?') ) {
			$('#terms_idx').val($(this).attr('keyValue'));

			$('#termsListForm').attr("action", 'delete.do');

			if(doAjaxPost($('#termsListForm'))) {
				location.reload();
				$('#termsListForm').attr("action", 'index.do');
			}
		}
		e.preventDefault();
	});

});
</script>
<form:form id="termsListForm"  modelAttribute="terms" action="index.do" >
<form:hidden path="terms_idx"/>
<form:hidden path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${termsListCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>

	<!-- 이용약관 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="200" />
			<col width="" />
			<col width="150" />
			<col width="150" />
			<col width="200" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>약관분류</th>
				<th>제목</th>
				<th>필수여부</th>
				<th>사용여부</th>
				<th>등록일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${termsList}">
				<tr>
					<td>${i.terms_idx}</td>
					<td>${i.terms_type_name}</td>
					<td><a href="" id="dialog-view" keyValue="${i.terms_idx}">${i.title}</a></td>
					<td>${i.required_yn eq 'Y' ? '필수' : '선택'}</td>
					<td>${i.use_yn eq 'Y' ? '사용' : '미사용'}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/> </td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.terms_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.terms_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${termsListCount eq 0}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#termsListForm"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="TITLE">제목</form:option>
				<form:option value="CONTENTS">내용</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="약관 정보"></div>
<div id="dialog-2" class="dialog-common" title="약관 상세정보"></div>