<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {
	$('#search-btn').on('click', function(e) {
		e.preventDefault();
		//$('#bestBookListForm').submit();
		doGetLoad('bestBookList.do', serializeCustom($('#bestBookListForm')));
	});
	
	/* $('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox').prop('checked', $(this).prop('checked'));
	}); */
	
	$('a.showSlide').on('click', function(e) {
		e.preventDefault();
		var bci = $(this).parents('div.bif').next('div.bci'); 
		var toggleState = $(bci).is(':hidden');
		if (toggleState) {
			$(bci).load('/intro/search/index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
				$(bci).slideToggle();	
			});
		} else {
			$(bci).slideToggle();
		}
	});
	
	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		$('input#vLoca').val($(this).attr('vLoca'));
		$('input#vCtrl').val($(this).attr('vCtrl'));
		$('form#detailForm').submit();
	});
});
</script>
<form:form modelAttribute="librarySearch" id="detailForm" action="/intro/search/detail.do" method="post">
	<form:hidden path="vLoca"/>
	<form:hidden path="vCtrl"/>
</form:form>
<form:form id="bestBookListForm" modelAttribute="librarySearch" action="bestBookList.do" method="GET">
	<form:hidden path="menu_idx"/>
	<div class="search-wrap">
		<!-- <a id="search-btn" class="btn btn1">조회</a> -->
		<%-- <div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;" >
			<div>
			<form:checkbox id="checkAll" path="libraryCodes" label="전체" value="ALL" />
			</div>
			<div>
				<ul>
			<c:forEach items="${libraryList.data}" var="i">
					<li style="display: inline-block; margin-right: 5px;">
				<c:choose>
					<c:when test="${fn:indexOf(librarySearch.libraryCodes, i.lib_manage_code)!= -1 or fn:indexOf(librarySearch.libraryCodes, 'ALL') != -1}">
						<form:checkbox id="lib_${i.lib_manage_code}" path="libraryCodes" label="${i.lib_name}" value="${i.lib_manage_code}" checked="checked"/>
					</c:when>
					<c:otherwise>
						<form:checkbox id="lib_${i.lib_manage_code}" path="libraryCodes" label="${i.lib_name}" value="${i.lib_manage_code}" />
					</c:otherwise>
				</c:choose>
					</li>
			</c:forEach>
				</ul>
			</div>
		</div> --%>
		<div class="smain">
			<div class="box">
				<div id="search-results" class="search-results">
					<c:forEach items="${bestBookList.dsNewBookList}" var="i">
						<div class="row">
							<p class="admin"><input type="checkbox" class="checkBook"/></p>
							<div class="thumb">
								<a vLoca="" vCtrl="${i.CTRLNO}" class="goDetail"><img src="${i.COVER_SMALLURL}" alt="인기도서 입니다."/></a>
							</div>
							<div class="box">
								<div class="item">
									<div class="bif">
										<a class="name goDetail" vLoca="" vCtrl="${i.CTRLNO}">${i.TITLE}</a>
										<p>${i.AUTHOR}</p>
										<p>${i.PUBLER} ${i.PUBLER_YEAR}</p>
										<p>${i.LOCA_NAME}</p>
										<div class="stat">
											<a href="#" class="showSlide" vLoca="" vCtrl="${i.CTRLNO}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
											<span><b>${i.SUB_LOCAL_NAME}</b> [${i.CALL_NO}]</span>
											<c:if test="${not empty i.marc_url}">
											<a href="${i.marc_url}" class="btn" target="_blank" style="margin-left: 10px;"><span>전자책 바로보기</span></a>
											</c:if>
										</div>
									</div>
									<div class="bci" style="display: none;">
										<!-- ajax_area -->
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				
					<%-- <jsp:include page="/WEB-INF/views/app/cms/common/paging_search.jsp" flush="false" /> --%>
				</div>
			</div>
		</div>
	</div>
</form:form>
<div id="vk"></div>