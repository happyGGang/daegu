<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('#dialog_layer.dialog-search').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-search").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 650
	});
	
	$('a.btn_select').on('click', function(e) {
		e.preventDefault();
		$('#nearbyLibPenaltyEdit #penalty_member_id').val($(this).attr('keyValue'));
		$('#nearbyLibPenaltyEdit #homepage_id').val($(this).attr('keyValue2'));
		$('#nearbyLibPenaltyEdit #manage_code').val($(this).attr('keyValue3'));
		$('#nearbyLibPenaltyEdit #penalty_date').val($(this).attr('keyValue4'));
		$('#dialog-search').dialog('destroy');
	});
	
	$('#search-btn').on('click', function(e) {
		$('#dept #viewPage_ajax').val(1);
		$('#dialog-search').load('/cms/module/nearbyLib/nearbyLibPenalty/searchMember.do?'+$('#nearbyLib').serialize());
	});
	
	$('div#cms_paging a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('#nearbyLib').serialize();
		$('#dialog-teacher').load('/cms/module/nearbyLib/nearbyLibPenalty/searchMember.do?' + param);
		e.preventDefault();
	});
});
</script>
<form:form modelAttribute="nearbyLib" id="nearbyLib" action="searchMember.do" method="get" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<form:select path="search_type" class="selectmenu">
				<form:option value="device_code">장비코드</form:option>
				<form:option value="book_name">도서명</form:option>
				<form:option value="ctrl_no">등록번호</form:option>
				<form:option value="call_no">청구기호</form:option>
				<form:option value="member_id">아이디</form:option>
				<form:option value="member_id">회원명</form:option>
			</form:select>		
			<form:input path="search_text" class="text" />
			<button id="search-btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>

	<table class="type2 center">
		<colgroup>
	       	<col width="100" />
	       	<col width="*"/>
	       	<col width="*"/>
	       	<col width="100"/>
	     	</colgroup>
	     	<thead>
	     		<tr>
	     			<th>회원ID</th>
	     			<th>회원명</th>
	     			<th>등록번호</th>
	     			<th>도서명</th>
	     			<th>신청날짜</th>
	     			<th>기능</th>
	     		</tr>
	     	</thead>
	     	<tbody>
	     		<c:if test="${empty nearbyLibList}">
	     			<tr>
	     				<td colspan="6">검색결과가 없습니다.</td>
	     			</tr>
	     		</c:if>
	     		<c:forEach items="${nearbyLibList}" var="i">
		      		<tr>
		      			<td>${i.member_id}</td>
		      			<td>${i.member_name}</td>
						<td>${i.reg_no}</td>
						<td>${i.book_name}</td>
						<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /><br/><fmt:formatDate value="${i.add_date}" pattern="HH:mm" /></td>
						<td><a class="btn btn_select" keyValue="${i.member_id}" keyValue2="${i.homepage_id}" keyValue3="${i.manage_code}" keyValue4="<fmt:formatDate value="${i.add_date}" pattern="yyyy/MM/dd HH:mm:ss" />">선택</a></td>
					</tr>
		    	</c:forEach>
		</tbody>
	</table>

	<form:hidden id="viewPage_ajax" path="viewPage"/>
	<div id="cms_paging" class="dataTables_paginate">
		<c:if test="${paging.firstPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
		</c:if>	
		<span>
			<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
				<c:choose>
					<c:when test="${i eq paging.viewPage}">	
						<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="" class="paginate_button" keyValue="${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nextPageNum > 0}">
				<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
			</c:if>
			<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
				<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
			</c:if>
		</span>
	</div>
</form:form>