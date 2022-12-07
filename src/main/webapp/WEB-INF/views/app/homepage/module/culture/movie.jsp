<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>

<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub-form-reset.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub_libculture.css"/>

<script type="text/javascript">
	$(function() {
		$(window).resize(function() {
			$('.bbs_gallery_portal img').height($('.bbs_gallery_portal img').width() * 1.414);
		}).trigger('resize');

		$('div#board_paging a').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', $(this).attr('keyValue'));
			var param = serializeCustom($('form#board'));
			doGetLoad('movie.do', param);
		});

		$('a#board_btn_search').on('click', function(e) {
			e.preventDefault();
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#board'));
			doGetLoad('movie.do', param);
		});

		$('input#search_text_board').keyup(function(e) {
			e.preventDefault();
			if(e.keyCode == 13)
			{
				$('#viewPage').attr('value', '1');
				var param = serializeCustom($('form#board'));
				doGetLoad('movie.do', param);
			}
		});

		$('#search_homepage').on('change',function(e){
			e.preventDefault();
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#board'));
			doGetLoad('movie.do', param);
		});
	});
</script>

<style>
	input[type="text"]{width:auto;font-family:'SCoreDream';font-size:19px;}
	input[type="text"]::placeholder{font-family:'SCoreDream';font-size:19px;}
	
	@media screen and (max-width: 1024px) { 
		input[type="text"]{font-size:15px;}
		input[type="text"]::placeholder{font-size:15px;}
	}
</style>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="movie.do" method="get" onsubmit="return false;">
<input type="hidden" id ="homepage_id" value ="${homepage.homepage_id}"/>
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />

<div class="search-form showNot01">

	<form:select path="search_homepage" cssClass="search-form__select new_select_box nsb2">
		<form:option value="">전체</form:option>
		<form:option value="h1">228기념학생도서관</form:option>
		<form:option value="h5">동부도서관</form:option>
		<form:option value="h3">남부도서관</form:option>
		<form:option value="h7">북부도서관</form:option>
		<form:option value="h9">수성도서관</form:option>
		<form:option value="h4">달성도서관</form:option>
		<form:option value="h6">두류도서관</form:option>
		<!-- <form:option value="h36">이천어울림도서관</form:option> -->
		<form:option value="h35">대명어울림도서관</form:option>
		<form:option value="h46">구수산도서관</form:option>
		<form:option value="h47">대현도서관</form:option>
		<form:option value="h48">태전도서관</form:option>
		<form:option value="h74">중구영어도서관</form:option>
		<form:option value="h51">용학도서관</form:option>
		<form:option value="h37">달서구통합도서관</form:option>
		<!-- <form:option value="h72">도원도서관</form:option>
		<form:option value="h67">성서도서관</form:option>
		<form:option value="h68">본리도서관</form:option>
		<form:option value="h69">달서가족문화도서관</form:option>
		<form:option value="h66">달서어린이도서관</form:option>
		<form:option value="h70">달서영어도서관</form:option> -->
		<form:option value="h44">달성군립도서관</form:option>

		<%--c:forEach var="i" items="${homepageList}"--%>
			<%--form:option value="${i.homepage_id}">${i.homepage_name}</form:option--%>
		<%--/c:forEach--%>
	</form:select>

	<form:select path="search_type" cssClass="search-form__select new_select_box left2 nsb2">
		<form:option value="title+content">제목+내용</form:option>
		<form:option value="title">제목</form:option>
		<form:option value="content">내용</form:option>
	</form:select>

	<form:input path="search_text" id="search_text_board" cssClass="text new_text02 search-form__input2" accesskey="s" title="검색어" placeholder="검색어를 입력하세요" />
	<a href="#" class="search-form__button top2" id="board_btn_search"><img src="/resources/homepage/${homepage.context_path}/img/sub_srch_ico.png"></a>
</div>

<div class="result-count">
	검색 결과 총 <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건
</div>

<div class="result-list">
	<c:if test="${fn:length(boardList) < 1}">
		검색된 영화상영정보가 없습니다.
	</c:if>
	<c:forEach var="i" varStatus="status" items="${boardList}">
	<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
	<div class="product product--stretch">
		<div class="product__header">
			<div class="product__thumnail__2">
				<a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" keyValue="${i.board_idx}">
					<c:choose>
						<c:when test="${i.preview_img ne null}">
							<c:choose>
								<c:when test="${fn:contains(i.preview_img, 'http')}">
									<img src="${i.preview_img}" alt="${i.title}" onError="src='/resources/homepage/${homepage.context_path}/img/noimg_horizaltal.png';"/>
								</c:when>
								<c:otherwise>
									<img class="previewImg" src="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}" onError="src='/resources/homepage/${homepage.context_path}/img/noimg_horizaltal.png';" alt="${i.title}"/>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<img src="/resources/homepage/${homepage.context_path}/img/noimg_horizaltal.png" alt="${i.title}">
						</c:otherwise>
					</c:choose>
				</a>
			</div>
			<div class="product__filters">
				<span class="product__filter product__filter-topic">${i.title}</span>
			</div>
		</div>
		<dl class="product__info">
			<dt class="bullet__text--arrow"><b>기관명</b></dt>
			<dd class="lib-cate">${i.homepage_name}</dd>

			<dt class="bullet__text--arrow"><b>상영일</b></dt>
			<dd>
				${i.imsi_v_1}-${i.imsi_v_2}
				<c:if test="${i.imsi_v_3 ne '' and i.imsi_v_4 ne ''}">
					<fmt:formatNumber var="imsi_v_3" minIntegerDigits="2" value="${i.imsi_v_3}" type="number"/>
					<fmt:formatNumber var="imsi_v_4" minIntegerDigits="2" value="${i.imsi_v_4}" type="number"/>
					${imsi_v_3}:${imsi_v_4}
				</c:if>
			</dd>
			<c:if test="${i.imsi_v_13 ne null and i.imsi_v_13 ne '0'}">
			<dt class="bullet__text--arrow"><b>상영시간</b></dt>
			<dd>
				${i.imsi_v_13}(분)
			</dd>
			</c:if>
		</dl>
		<div class="product__buttons">
			<a href="/${i.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" keyValue="${i.board_idx}" target="_blank" class="product__button product__button--ticket">정보상세보기</a>
		</div>
	</div>
	</c:forEach>

</div>

<form:hidden path="viewPage"/>

<div id="board_paging" class="dataTables_paginate">
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



