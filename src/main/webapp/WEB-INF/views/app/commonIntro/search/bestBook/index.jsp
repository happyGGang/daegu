<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {
	$('#search-btn').on('click', function(e) {
		e.preventDefault();
		//$('#bestBookListForm').submit();
		doGetLoad('index.do', serializeCustom($('#bestBookListForm')));
	});
	
	/* $('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox').prop('checked', $(this).prop('checked'));
	}); */
	
	$('a.showSlide').on('click', function(e) {
		e.preventDefault();
		var bci = $(this).parents('div.bif').next('div.bci'); 
		var toggleState = $(bci).is(':hidden');
		if (toggleState) {
			$(bci).load('/intro/${homepage.context_path}/search/index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
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
		$('input#detailMenuIdx').val($('input#menu_idx').val());
		$('input#vImg').val($(this).attr('vImg'));
		
		$('input#isbn').val($(this).attr('isbn'));
		$('input#tid').val($(this).attr('tid'));
		var formData = serializeParameter(['vLoca', 'vCtrl', 'vImg', 'isbn', 'tid', 'menu_idx']);
		doGetLoad('/${homepage.context_path}/intro/search/detail.do', formData);
// 		$('form#detailForm').submit();
	});
	
	$('input#search_start_date').datepicker({
		maxDate: $('input#search_end_date').val(), 
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#search_end_date').datepicker({
		minDate: $('input#search_start_date').val(), 
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
});
</script>
<form:form modelAttribute="librarySearch" id="detailForm" action="/intro/search/detail.do" method="post">
	<form:hidden path="vLoca"/>
	<form:hidden path="vCtrl"/>
	<form:hidden path="tid"/>
	<form:hidden path="isbn"/>
	<form:hidden path="vImg"/>
	<form:hidden path="menu_idx" id="detailMenuIdx"/>
</form:form>
<form:form id="bestBookListForm" modelAttribute="librarySearch" action="bestBookList.do" method="GET">
	<form:hidden path="menu_idx"/>
	<div class="search-wrap">
		<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;" >
			조회 기간:<form:input path="search_start_date" cssClass="text ui-calendar" title="시작기간,입력예시 2017-01-01" /> ~ 
					<form:input path="search_end_date" cssClass="text ui-calendar" title="종료기간,입력예시 2017-12-31" /> 
			&nbsp;
			<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;padding:3px 0px 5px 4px;" title="페이지당 갯수 보기">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}" title="${i}개씩 보기">${i}개씩 보기</form:option>
			</c:forEach>
			</form:select>
			
			<a href="#" id="search-btn" class="btn btn1" title="조회" >조회</a>
		</div>
		<div class="smain">
			<div class="box">
				<div id="search-results" class="search-results wide">
					<c:forEach items="${bestBookList.dsLoanBestList}" var="i">
						<div class="row">
							<%-- <p class="admin"><input type="checkbox" class="checkBook" title="${i.TITLE} 선택" /></p> --%>
							<div class="thumb" tabindex="0">
								<c:if test="${i.COVER_SMALLURL eq ''}">
								<a vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail">
									<img src="/resources/homepage/geic/img/noimg2.png" alt="noImage"/>
									<span>등록된 이미지가<br/>없습니다.</span>
								</a>
								</c:if>
								<c:if test="${i.COVER_SMALLURL ne ''}">
								<a vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail"><img src="${i.COVER_SMALLURL}" alt="cover"/></a>
								</c:if>
							</div>
							<div class="box">
								<div class="item">
									<div class="bif">
										<a href="#" vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail">${i.TITLE}</a>
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