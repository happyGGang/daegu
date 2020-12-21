<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag"	uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<style>
.serial-wrap .search-results .row .item a.name{font-weight:800;font-size:140%;display:inline-block;zoom:1;*display:inline;padding: 0px 0;}
.serial-wrap ul.con2{padding: 0px 0 2px;}
.bif b {color:#ffa651;}
</style>
<script>
$(document).ready(function() {

	$('button#do-search').on('click', function(e) {
		e.preventDefault();
		$('input#hopeSearchManageCode').val($('#manageCode').val());
		doAjaxLoad('div#searchBox', 'search.do', $('form#searchForm').serialize());
	});

	$('input#search_text_naver').on('keyup', function(e) {
		if (e.keyCode == '13') {
			$('button#do-search').click();
		}
	});
});
</script>
<form:form modelAttribute="librarySearch" id="searchForm" action="search.do" onsubmit="return false;">
<form:hidden path="isbn"/>
<form:hidden path="viewPage"/>
<form:hidden path="manageCode" id="hopeSearchManageCode"/>
	<div class="search-form" style="padding-bottom: 20px;">
		<div class="box">
			<div class="b1">
				<form:input path="search_text" id="search_text_naver" type="text" class="text" placeholder="검색어를 입력하세요." cssStyle="ime-mode:active;"/>
			</div>
			<div class="b2">
				<button id="do-search"><i class="fa fa-search"></i><span class="blind">검색</span></button>
			</div>
		</div>
	</div>
</form:form>
		<c:if test="${naverResult.totalCount < 1 and not empty librarySearch.search_text}">
	<div class="search_result nodata">검색된 도서가 없습니다.</div>
		</c:if>
		<c:if test="${naverResult.totalCount > 0 and not empty librarySearch.search_text}">
	<p class="search_result">
		<span class="red fb">"${librarySearch.search_text}"</span>에 대한 <span class="fb"><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </span>개의
		검색 결과입니다.
	</p>
		</c:if>
		<c:if test="${not empty librarySearch.search_text}">
	<div class="serial-wrap">
		<div class="smain">
			<div class="box">
				<div class="search-results">
					<c:forEach items="${naverResult.list}" var="i" varStatus="status">
					<div class="row">
						<div class="thumb">
							<c:choose>
							<c:when test="${empty i.image }">
								<img src="/resources/common/img/noimg-gall.png" alt="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}" alt="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}">
							</c:when>
							<c:otherwise>
								<img src="${i.image}" alt="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}" title="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}">
							</c:otherwise>
							</c:choose>
						</div>
						<div class="box">
							<div class="item">
								<div class="bif">
									<a href="#" class="name" target="_blank" style="cursor: default;" onclick="return false;" alt="${fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', ''))}" title="${fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', ''))}">${fn:substring(fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')), 0, 30)}<c:if test="${fn:length(fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', ''))) > 30}">...</c:if></a>
									<ul class="con2">
										<li>저자 : ${fn:substring(i.author, 0, 20)}<c:if test="${fn:length(i.author) > 20}">...</c:if></li>
										<li>발행처 : ${fn:substring(i.publisher, 0, 20)}<c:if test="${fn:length(i.publisher) > 20}">...</c:if></li>
										<li>출판일 : ${i.pubdate}</li>
										<li>ISBN : ${i.isbn13}</li>
										<li>가격 : ${i.price}</li>
										<c:choose>
											<c:when test="${not empty i.already13 and i.already13}">
										<li class="button">
											<span class="no" style="color: red;">소장도서(신청불가)</span>
										</li>
											</c:when>
											<c:otherwise>
										<li class="button" style="background: none;">
											<a class="btn btn1 request" index="${status.index}" href="#">선택하기</a>
											<span data="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}//${i.author}//${i.publisher}//${fn:substring(i.pubdate,0,4)}//${i.isbn13}//${i.price}"></span>
										</li>
											</c:otherwise>
										</c:choose>
									</ul>
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
				</div>

				<div id="board_paging" class="dataTables_paginate" style="padding-bottom: 25px;">
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
				<c:if test="${paging.nextPageNum > 0 and paging.nextPageNum < 100}">
					<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
				</c:if>
				<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
					<a href="" class="paginate_button next" keyValue="${100}">맨끝</a>
				</c:if>
					</span>
				</div>
			</div>
		</div>
	</div>
		</c:if>

<script>
	$(function() {
		$('div.images li').on('hover', function() {
			var no = $(this).attr('item_no');
			$('.item-list .item').hide();
			$('.item-list .item-' + no).show();
			$('.item-list .images li').css('border-clor', '#fff');
			$(this).css('border-color', '#ddd');
		}).css({
			'border-clor' : '#fff',
			'float' : 'left'
		});
		$('.item-list .images li').eq(0).mouseover();

		$('div#board_paging a').on('click', function(e) {
			e.preventDefault();
			$('input#viewPage').val($(this).attr('keyValue'));
			doAjaxLoad('div#searchBox', 'search.do', $('form#searchForm').serialize());
		});

		$('a.request').on('click', function(e) {
			e.preventDefault();
			var data = $(this).next('span').attr('data').split('//');
			$('input#title').val(data[0].replace(/(<([^>]+)>)/ig,""));
			$('input#author').val(data[1].replace(/(<([^>]+)>)/ig,""));
			$('input#publer').val(data[2].replace(/(<([^>]+)>)/ig,""));
			$('input#publer_year').val(data[3].replace(/(<([^>]+)>)/ig,""));
			$('input#isbn').val(data[4].replace(/(<([^>]+)>)/ig,""));
			$('input#price').val(data[5].replace(/(<([^>]+)>)/ig,""));
			$('input#user_remark').focus();
		});
		$(window).resize(function() {
			$('.search-results img').height($('img#refImg').width() * 0.6);
		}).trigger('resize');
	});
</script>
