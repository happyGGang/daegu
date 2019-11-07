<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {
	$('a#search-btn').on('click', function(e) {
		//$('#newBookListForm').submit();
		$('input#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#newBookListForm')));
	});

	$('input#search_text').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			doGetLoad('index.do', serializeCustom($('#newBookListForm')));
		}
	});

	$('div#board_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', parseInt($(this).attr('keyValue')));
		doGetLoad('index.do', serializeCustom($('#newBookListForm')));
	});

	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		doGetLoad('index.do', serializeCustom($('#newBookListForm')));
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

	$('a#excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('NEWBOOK');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/excelDownload.do');
		$('#excelDownForm').submit();
	});
	
	$('a#csv-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm #excel_type').val('NEWBOOK');
		$('#excelDownForm').attr('action', '/${homepage.context_path}/intro/search/csvDownload.do');
		$('#excelDownForm').submit();
	});
});
</script>
<form:form id="excelDownForm" modelAttribute="librarySearch" action="/${homepage.context_path}/intro/search/excelDownload.do" method="get">
<c:if test="${homepage.context_path eq 'gbelib'}">
<form:select path="vLoca" id="vLocaNewBook2" cssClass="selectmenu" cssStyle="display:none;" title="도서관선택">
	<form:option value="" label="전체" />
	<c:forEach var="i" varStatus="status" items="${libraryList.data}">
	<c:if test="${i.lib_manage_code ne '00347034'}">
	<form:option value="${i.lib_manage_code}" label="${i.lib_name}" />
	</c:if>
	</c:forEach>
</form:select>
</c:if>
<form:hidden path="search_start_date" id="search_start_datetmp"/>
<form:hidden path="search_end_date" id="search_end_datetmp"/>
<form:hidden path="excel_type"/>
</form:form>
<form:form modelAttribute="librarySearch" id="detailForm" action="/${homepage.context_path}/intro/search/detail.do" method="post">
	<form:hidden path="vLoca"/>
	<form:hidden path="vCtrl"/>
	<form:hidden path="tid"/>
	<form:hidden path="isbn"/>
	<form:hidden path="vImg"/>
	<form:hidden path="menu_idx" id="detailMenuIdx"/>
</form:form>
<form:form id="newBookListForm" modelAttribute="librarySearch" action="index.do" method="GET" onsubmit="return false;">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<div class="search-wrap">
		<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;" >
			<c:if test="${homepage.context_path eq 'gbelib'}">
			도서관 :
			<form:select path="vLoca" id="vLocaNewBook" cssClass="selectmenu" cssStyle="width: 200px;" title="도서관 선택">
				<form:option value="" label="전체" />
				<c:forEach var="i" varStatus="status" items="${libraryList.data}">
				<c:if test="${i.lib_manage_code ne '00347034'}">
				<form:option value="${i.lib_manage_code}" label="${i.lib_name}" />
				</c:if>
				</c:forEach>
			</form:select>
			</c:if>
			&nbsp;
			조회 기간:<form:input path="search_start_date" cssClass="text ui-calendar" placeholder="2018-01-01" title="조회할 시작 날짜 선택"/><label for="search_start_date" class="blind">시작일</label> ~
					<form:input path="search_end_date" cssClass="text ui-calendar" placeholder="2018-01-07" title="조회할 끝 날짜 선택"/><label for="search_end_date" class="blind">종료일</label>
			<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px; padding:3px 0px 5px 4px;" title="보기 개수 선택">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</form:select>
			<a href="#" id="search-btn" class="btn btn1">조회<i class="fas fa-search"></i></a>
		</div>

		<div class="smain">
			<div class="box">
				<div style="text-align: right;">
					<span class="bbs-result">검색결과 총 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
					<a href="#" id="excel-btn" class="btn btn2"><i class="fa fa-file-excel-o" aria-hidden="true"></i>엑셀저장</a>
					<a href="#" id="csv-btn" class="btn btn2"><i class="fa fa-file-excel-o" aria-hidden="true"></i>CSV저장</a>
				</div>
				<div id="search-results" class="search-results wide">
					<c:choose>
						<c:when test="${fn:length(newBookList.dsNewBookList) > 0}">
							<c:forEach items="${newBookList.dsNewBookList}" var="i">
								<div class="row">
									<p class="admin">
<!-- 										<input type="checkbox" class="checkBook"/> -->
									</p>
									<div class="thumb" tabindex="0">
										<c:if test="${i.COVER_SMALLURL eq ''}">
										<a vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail" title="${i.TITLE} 새창으로 열립니다.">
											<img src="/resources/homepage/geic/img/noimg2.png" alt="noImage"/>
											<span>등록된 이미지가<br/>없습니다.</span>
										</a>
										</c:if>
										<c:if test="${i.COVER_SMALLURL ne ''}">
										<a vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail" title="${i.TITLE} 새창으로 열립니다."><img src="${i.COVER_SMALLURL}" alt="${i.TITLE} "/></a>
										</c:if>
									</div>
									<div class="box">
										<div class="item">
											<div class="bif">
												<a href="#" vLoca="${i.LOCA}" vCtrl="${i.CTRLNO}" vImg="${i.COVER_SMALLURL}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail" title="${i.TITLE} 새창으로 열립니다.">${i.TITLE}</a>
												<p>${i.AUTHOR}</p>
												<p>${i.PUBLER} ${i.PUBLER_YEAR}</p>
												<p>${i.LOCA_NAME}</p>
												<div class="stat">
													<a href="#" class="showSlide" vLoca="" vCtrl="${i.CTRLNO}" title="${i.TITLE} 이용가능여부 확인"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
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
								<a href="" class="paginate_button current" keyValue="${i}" title="${i}페이지">${i}</a>
							</c:when>
							<c:otherwise>
								<a href="" class="paginate_button" keyValue="${i}" title="${i}페이지">${i}</a>
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

					<div class="search txt-center mmm2" style="margin-top:25px; display: none;"><!-- 하단 정렬 시 margin-top 입력 -->
						<fieldset>
							<label class="blind" for="search_type">검색</label>
							<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
								<form:option value="TITLE">서명</form:option>
								<form:option value="AUTHOR">저자</form:option>
								<form:option value="PUBLER">출판사</form:option>
								<form:option value="PUBLER_YEAR">출판년도</form:option>
							</form:select>
							<form:input path="search_text" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" />
							<label for="search_text" class="blind">검색어를 입력하세요</label>
							<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
						</fieldset>
					</div>
				</div>
			</div>
		</div>
	</div>
</form:form>
<div id="vk"></div>