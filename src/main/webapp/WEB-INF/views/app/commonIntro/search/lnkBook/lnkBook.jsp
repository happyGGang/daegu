<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/book/intro/js/common.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/geiclib/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/board/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/common.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {
	$('#search-btn').on('click', function(e) {
		//$('#lnkBookListForm').submit();
		$('input#viewPage').val(1);
		doGetLoad('lnkBook.do', serializeCustom($('#lnkBookListForm')));
	});
	
	$('input#search_text').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			doGetLoad('lnkBook.do', serializeCustom($('#lnkBookListForm')));
		}
	});
	
	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', parseInt($(this).attr('keyValue')));
		doGetLoad('lnkBook.do', serializeCustom($('#lnkBookListForm')));
	});
	
	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		doGetLoad('lnkBook.do', serializeCustom($('#lnkBookListForm')));
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
	
	$('a.selectBook').on('click', function(e) {
		e.preventDefault();
		window.opener.getIlusData($(this).attr('keyValue'));
		window.close();
	});
});
</script>
<form:form modelAttribute="librarySearch" id="detailForm" action="/${homepage.context_path}/intro/search/detail.do" method="post">
	<form:hidden path="vLoca"/>
	<form:hidden path="vCtrl"/>
	<form:hidden path="tid"/>
	<form:hidden path="isbn"/>
	<form:hidden path="vImg"/>
	<form:hidden path="menu_idx" id="detailMenuIdx"/>
</form:form>
<form:form id="lnkBookListForm" modelAttribute="librarySearch" action="lnkBook.do" method="GET" onsubmit="return false;">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="searchType"/>
	<div class="search-wrap">
		
		<div class="smain">
			<div class="box">
				<div id="search-results" class="search-results wide">
					<c:choose>
						<c:when test="${fn:length(lnkBookList.dsLibraryList) > 0}">
							<c:forEach items="${lnkBookList.dsLibraryList}" var="i">
								<div class="row">
									<p class="admin">
<!-- 										<input type="checkbox" class="checkBook"/> -->
									</p>
									<div class="thumb">
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
												<a vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail">${i.TITLE}</a>
												<p>${i.AUTHOR}</p>
												<p>${i.PUBLER} ${i.PUBLER_YEAR}</p>
												<p>${i.LOCA_NAME}</p>
												<div class="stat">
													<a href="#" class="selectBook" keyValue="${i.TITLE}///${i.PUBLER_YEAR}///${i.AUTHOR}///${i.PUBLER}///${i.ISBN}///${i.CALL_NO}///${i.COVER_SMALLURL}///${i.CTRLNO}"><span>선택하기</span><i class="fa fa-sort-down"></i></a>
<%-- 													<a href="#" class="showSlide" vLoca="" vCtrl="${i.CTRLNO}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a> --%>
													<span><b>${i.SUB_LOCAL_NAME}</b> [${i.CALL_NO}]</span>
												</div>
											</div>
											<div class="bci" style="display: none;">
												<!-- ajax_area -->
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
							<div id="board_paging" class="dataTables_paginate">
							<c:if test="${librarySearch.firstPageNum > 0}">
								<a href="" class="paginate_button previous" keyValue="${librarySearch.firstPageNum}">처음</a>
							</c:if>
							<c:if test="${librarySearch.prevPageNum > 0}">
								<a href="" class="paginate_button previous" keyValue="${librarySearch.prevPageNum}">이전</a>
							</c:if>	
								<span>
							<c:forEach var="i" varStatus="status" begin="${librarySearch.startPageNum}" end="${librarySearch.endPageNum}">
							<c:choose>
							<c:when test="${i eq librarySearch.viewPage}">	
								<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
							</c:when>
							<c:otherwise>
								<a href="" class="paginate_button" keyValue="${i}">${i}</a>
							</c:otherwise>
							</c:choose>
							</c:forEach>
							<c:if test="${librarySearch.nextPageNum > 0}">
								<a href="" class="paginate_button next" keyValue="${librarySearch.nextPageNum}">다음</a>
							</c:if>
							<c:if test="${librarySearch.totalPageCount ne librarySearch.lastPageNum}">
								<a href="" class="paginate_button next" keyValue="${librarySearch.totalPageCount}">맨끝</a>
							</c:if>
								</span>
							</div>	
						</c:when>
						<c:otherwise>
							<br/><br/>
							<h3> 조회된 도서가 없습니다. </h3>
						</c:otherwise>
					</c:choose>
						
					<div class="search txt-center mmm2" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
						<fieldset>
							<label class="blind" for="search_type">검색</label>				
							<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
								<form:option value="TITLE">서명</form:option>
								<form:option value="AUTHOR">저자</form:option>
								<form:option value="PUBLER">출판사</form:option>
								<form:option value="PUBLER_YEAR">출판년도</form:option>
							</form:select>
							<form:input path="search_text" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" />
							<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
	</div>
</form:form>
<div id="vk"></div>