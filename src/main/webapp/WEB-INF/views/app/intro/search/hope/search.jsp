<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag"	uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.ResourceBundle" %>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<style>
.serial-wrap ul.con2{padding: 0px 0 2px;}
.bif b {color:#ffa651;}
</style>
<%!
	public final String API_KEY = ResourceBundle.getBundle("api").getString("kakao.api.key");
%>
<script>
$(document).ready(function() {

	$('button#do-search').on('click', async function (e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		$('input#searchManageCode').val($('select#manageCode option:selected').val());

		await fetchKakaoApiData();

		await doAjaxLoad('div#searchBox', 'searchKakao.do', $('form#searchForm').serialize())
		.done(function(response) {
		})
		.fail(function() {
			alert('검색 내용이 없습니다');
		})
		.always(function() {
		});
	});

	$('input#search_text_kakao').on('keyup', function(e) {
		if (e.keyCode == '13') {
			$('button#do-search').click();
		}
	});
});

async function fetchKakaoApiData() {
	var query = $('#search_text_kakao').val();
	var page = $('#viewPage').val();
	var url = 'https://dapi.kakao.com/v3/search/book?query=' + query + '&page=' + page;
	var jsonData = [];

	// 데이터 요청
	try {
		const response = await fetch(url, {
			method: 'GET', // *GET, POST, PUT, DELETE 등
			mode: 'cors', // no-cors, *cors, same-origin
			cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
			credentials: 'same-origin', // include, *same-origin, omit
			headers: {
				'Content-Type': 'application/json; charset=UTF-8', // Java의 헤더와 동일
				'Accept-Charset': 'UTF-8',
				// 'Content-Type': 'application/x-www-form-urlencoded',
				'Authorization': <%= API_KEY%>
			},
			redirect: 'follow', // manual, *follow, error
			referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
		});

		if (!response.ok) {
			throw new Error('Kakao API 요청 실패: ' + response.statusText);
		}

		const data = await response.json();

		// 결과 데이터 처리
		data.documents.forEach(doc => {
			let jsonString = "{" +
					'"authors":' + JSON.stringify(doc.authors.join(', ')) + ',' + // 배열 처리
					'"contents":' + JSON.stringify(doc.contents) + ',' +
					'"datetime":' + JSON.stringify(doc.datetime) + ',' +
					'"isbn":' + JSON.stringify(doc.isbn) + ',' +
					'"price":' + JSON.stringify(doc.price) + ',' +
					'"publisher":' + JSON.stringify(doc.publisher) + ',' +
					'"sale_price":' + JSON.stringify(doc.sale_price) + ',' +
					'"status":' + JSON.stringify(doc.status) + ',' +
					'"thumbnail":' + JSON.stringify(doc.thumbnail) + ',' +
					'"title":' + JSON.stringify(doc.title) + ',' +
					'"translators":' + JSON.stringify(doc.translators.join(', ')) + ',' + // 배열 처리
					'"url":' + JSON.stringify(doc.url) +
					"}";
			jsonData.push(jsonString.replaceAll(',', '^^^^')); // 쉼표 변환
			console.log(jsonString);
		});



		// DOM 업데이트
		$('#totalDataCount').val(data.meta.pageable_count);
		$('#jsonData').val(jsonData);
	} catch (error) {
		console.error('fetchKakaoApiData 오류:', error);
		alert('데이터를 불러오는 중 문제가 발생했습니다.');
	}
}


function doAjaxLoad(target, url, data) {
	return $.ajax({
		url: url,
		type: 'POST',
		data: data,
		success: function(response) {
			$(target).html(response);
		},
		error: function(xhr, status, error) {
			// alert('검색 내용이 없습니다');
		}
	});
}
</script>
<form:form modelAttribute="librarySearch" id="searchForm" action="searchKakao.do" onsubmit="return false;">
<form:hidden path="isbn"/>
<form:hidden id="searchManageCode" path="manageCode"/>
<form:hidden path="viewPage"/>
<form:hidden path="jsonData" id="jsonData"/>
<form:hidden path="totalDataCount" id="totalDataCount"/>
	<div class="search-form" style="padding-bottom: 20px;">
		<div class="box">
			<div class="b1">
				<form:input path="search_text" id="search_text_kakao" type="text" class="text" placeholder="검색어를 입력하세요." cssStyle="ime-mode:active;"/>
			</div>
			<div class="b2">
				<button id="do-search"><i class="fa fa-search"></i><span class="blind">검색</span></button>
			</div>
		</div>
	</div>
</form:form>
	<c:if test="${fn:length(kakaoResult) < 1 and not empty librarySearch.search_text}">
		<div class="search_result nodata">검색된 도서가 없습니다.</div>
	</c:if>
	<c:if test="${fn:length(kakaoResult) > 0 and not empty librarySearch.search_text}">
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
					<c:forEach items="${kakaoResult}" var="i" varStatus="status">
					<div class="row">
						<div class="thumb">
							<c:choose>
							<c:when test="${empty i.thumbnail }">
								<img src="/resources/common/img/noimg-gall.png" alt="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}" alt="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}">
							</c:when>
							<c:otherwise>
								<img src="${i.thumbnail}" alt="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}" title="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}">
							</c:otherwise>
							</c:choose>
						</div>
						<div class="box">
							<div class="item">
								<div class="bif">
									<a href="#" class="name" target="_blank" style="cursor: default;" onclick="return false;" alt="${fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', ''))}" title="${fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', ''))}">${fn:substring(fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')), 0, 30)}<c:if test="${fn:length(fn:escapeXml(fn:replace(fn:replace(i.title, '</b>', ''), '<b>', ''))) > 30}">...</c:if></a>
									<ul class="con2">
										<li>저자 : ${fn:substring(i.authors, 0, 20)}<c:if test="${fn:length(i.author) > 20}">...</c:if></li>
										<li>발행처 : ${fn:substring(i.publisher, 0, 20)}<c:if test="${fn:length(i.publisher) > 20}">...</c:if></li>
										<li>출판일 : ${fn:substring(i.datetime, 0, 10)}</li>
										<c:choose>
											<c:when test="${i.isbn13 ne null}">
												<li>ISBN : ${i.isbn13 } </li>
											</c:when>
											<c:when test="${i.isbn20 ne null}">
												<li>ISBN : ${i.isbn20 } </li>
											</c:when>
										</c:choose>
										<li>가격 : ${i.price}</li>
										<c:choose>
											<c:when test="${not empty i.already13 and i.already13}">
										<li class="button">
											<c:choose>
												<c:when test="${fn:contains(i.errorMessage, '파손 등의 이유로 이용이 불가능한 도서 입니다.')}">
													<span class="no" style="color: red;" title="${i.errorMessage}">도서관에 소장중인 자료입니다.</span>
												</c:when>
												<c:otherwise>
													<span class="no" style="color: red;" title="${i.errorMessage}">${i.errorMessage}</span>
												</c:otherwise>
											</c:choose>
										</li>
											</c:when>
											<c:when test="${not empty i.already20 and i.already20}">
										<li class="button">
											<c:choose>
												<c:when test="${fn:contains(i.errorMessage, '파손 등의 이유로 이용이 불가능한 도서 입니다.')}">
													<span class="no" style="color: red;" title="${i.errorMessage}">도서관에 소장중인 자료입니다.</span>
												</c:when>
												<c:otherwise>
													<span class="no" style="color: red;" title="${i.errorMessage}">${i.errorMessage}</span>
												</c:otherwise>
											</c:choose>
										</li>
											</c:when>
											<c:otherwise>
										<li class="button" style="background: none;">
											<a class="btn btn1 request" index="${status.index}" href="#">선택하기</a>
											<c:choose>
												<c:when test="${i.isbn13 ne null}">
													<span data="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}//${fn:replace(fn:replace(i.authors, '[', ''), ']', '')}//${i.publisher}//${fn:substring(i.datetime,0,4)}//${i.isbn13}//${i.price}"></span>
												</c:when>
												<c:when test="${i.isbn20 ne null}">
													<span data="${fn:replace(fn:replace(i.title, '</b>', ''), '<b>', '')}//${fn:replace(fn:replace(i.authors, '[', ''), ']', '')}//${i.publisher}//${fn:substring(i.datetime,0,4)}//${i.isbn20}//${i.price}"></span>
												</c:when>
											</c:choose>											
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

		$('div#board_paging a').on('click', async function(e) {
			e.preventDefault();
			$('input#viewPage').val($(this).attr('keyValue'));
			await fetchKakaoApiData();
			await doAjaxLoad('div#searchBox', 'searchKakao.do', $('form#searchForm').serialize())
			.done(function (response) {
			})
			.fail(function () {
				alert('검색 내용이 없습니다');
			})
			.always(function () {
				$('#loading').hide();
			});
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
