<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper-bundle.min.css" />
<style>
.swiper {width:100%;height:100%;}
.swiper-container {width:880px;height:auto;margin-left:auto;margin-right:auto;padding-bottom:50px;}
.swiper-slide {display:inline-block;text-align:left;}
.swiper-slide {position:relative;display:inline-block;text-align:center;font-size:18px;width:120px;margin:0 auto 40px;vertical-align:top;}
.swiper-slide div {vertical-align:top;}
.swiper-slide div.thumb-image a img {width:120px;height:170px;box-shadow:5px 5px 15px rgba(0,0,0,0.2);}
.swiper-slide div.thumb-image {display:block;width:120px;}
.swiper-slide div.thumb-image a {display:block;}
.swiper-slide div.cont {position:relative;width:120px;margin:0;text-align:left;}
.swiper-slide div.cont p.tit {font-size:18px;color:#000;letter-spacing: -0.05em;line-height:125%;text-align:left;margin-top: 10px;}
.swiper-slide img {display:block;width:120px;height:170px;object-fit:cover;box-shadow: 10px 10px 20px rgba(0,0,0,0.2);}
.swiper-container-horizontal > .swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction {bottom:0;}
.swiper-pagination-bullet-active {opacity:1;background:#fff;}
</style>
<script>
$(function() {

	<c:choose>
	<c:when test="${detail.SHELF_LOCATION_IMG_URL ne null && detail.SHELF_LOCATION_IMG_URL ne ''}">
	$('#print-btn-toggle').on('click', function(e) {
		e.preventDefault();
		$('#print-box').css('height','480px');
		$('#print-contents-box').css('height','480px');
		$('#print-box').css('top','-480px');
		clearTimeout(submenuTimeout);
		submenuTimeout = setTimeout(function() {
			$('#print-contents-box').show();
		}, 500);
	});
	</c:when>
	<c:otherwise>
	$('#print-btn-toggle').on('click', function(e) {
		e.preventDefault();
		//alert('등록된 서가위치 이미지가 없습니다.');
		$.alert("등록된 서가위치 이미지가 없습니다.",{title:'국채보상운동기념도서관',confirmButton:'확인'});
	});
	</c:otherwise>
	</c:choose>

	$('#close-print-box').on('click', function(k) {
		k.preventDefault();
		$('#print-box').css('height','0');
		$('#print-contents-box').css('height','0');
		$('#print-box').css('top','0');
		clearTimeout(submenuTimeout);
		submenuTimeout = setTimeout(function() {
			$('#print-contents-box').hide();
		}, 0);
	});

	$('a#btn_print').on('click', function(e) {
		e.preventDefault();
		//var url = $(this).data('param').replace('detail', 'print');
		var popup = window.open('print.do?imgurl=${detail.SHELF_LOCATION_IMG_URL}&lockey=${detail.SHELF_LOCATION_KEY}&locname=${detail.SHELF_LOC_NAME}&bookname=${librarianPickBook.book_name}&author=${librarianPickBook.author}&callno=${detail.CALL_NO}&regno=${detail.REG_NO}', '_blank', 'toolbar=yes,scrollbars=yes,resizable=yes,top=100,left=100,width=450,height=600');
		popup.focus();
	});

});
</script>

<div class="userrecommandbookdetail-wrap">
	<div class="header">
		<h1>도서정보</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="img-sec">
			<img src="${bookKeyword.bookimgUrl}" alt="${bookKeyword.book_name}">
			<c:if test="${detail.REG_NO ne null && detail.REG_NO ne ''}">
			<c:if test="${detail.WORKING_STATUS eq 'BOL112N'}">
			<span class="status-box">
				대출가능
			</span>
			</c:if>
			<c:if test="${detail.WORKING_STATUS ne 'BOL112N'}">
			<span class="status-box red">
				대출불가
			</span>
			</c:if>
			</c:if>
		</div>
		<div class="title-sec">
			${bookKeyword.book_name}
		</div>
		<div class="bookinfo-sec">
			<ul>
				<li><span class="">저자명</span> ${bookKeyword.author}</li>
				<li><span class="">소장위치</span> ${detail.SHELF_LOC_NAME}</li>
				<li><span class="">출판사</span> ${detail.PUBLISHER}</li>
				<li><span class="">청구기호</span> ${detail.CALL_NO}</li>
				<li><span class="">ISBN</span> ${bookKeyword.isbn}</li>
				<li><span class="">등록번호</span> ${detail.REG_NO}</li>
			</ul>
		</div>
		<div class="print-sec">
			<div class="relative">
				<div id="print-box" class="print-box">
					<div id="print-contents-box" class="print-contents-box" style="display:none;">
						<div class="print-image-box">
							<img src="${detail.SHELF_LOCATION_IMG_URL}" alt="${detail.SHELF_LOCATION_KEY}" class="W480 H480"/>
						</div>
						<div class="print-btn-box">
							<div class="outer">
								<div class="inner">
									<!-- <div class="">
										<a href="#btn_print" id="btn_print" class="btn-print-box">인쇄</a>	
									</div> -->
									<div class="">
										<a href="#close-box" id="close-print-box" class="close-print-box">확인</a>
									</div>									
								</div>
							</div>
						</div>
						<div class="end"></div>
					</div>
				</div>
				<div class="print-btn">
					<a href="#" id="print-btn-toggle">국채보상운동기념도서관 소장도서 <strong>서가위치보기</strong></a>
				</div>
			</div>
		</div>
		<div class="etcinfo-sec">
			<div class="inner-scroll">
				${kakaoResult}
			</div>
		</div>


		<div class="detail-bookbest-list">
			<h2>인기대출도서</h2>
			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
					<!-- 루프시작 -->
					<c:forEach items="${bestBookList}" var="i" varStatus="status">
						<div class="swiper-slide">
							<div class="thumb-image">
								<a href="/${homepage.context_path}/kiosk/librarianPickBookView.do?book_name=${i.TITLE}&isbn=${i.ISBN}&regNo=${i.REG_NO}&author=${i.AUTHOR}&bookimgUrl=${empty i.imageUrl ? '/resources/common/img/noImg2.png' : i.imageUrl}">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/gukbo_noimg.png" alt="등록된 이미지가 없습니다.  상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<img src="${i.aladin.cover}" alt="${i.TITLE} 상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
										</c:when>
										<c:otherwise>
											<img src="${i.imageUrl}" alt="${i.TITLE} 상세보기" onError="this.src='/resources/common/img/gukbo_noimg.png'"/>
										</c:otherwise>
									</c:choose>
								</a>
							</div>
							<div class="cont">
								<p class="tit" style="font-size:16px;">
									${fn:substring(i.TITLE, 0, 13)}<c:if test="${fn:length(i.TITLE) > 13}">...</c:if>
								</p>
							</div>
						</div>
					</c:forEach>
					<!-- 루프끝 -->
				</div>
				<!-- <div class="swiper-scrollbar"></div> -->
				<div class="swiper-pagination"></div>
				<!-- <div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div> -->
			</div>
			<script src="/resources/common/js/kiosk/swiper-bundle.min.js"></script>
			<script>
				var swiper = new Swiper(".mySwiper", {
					loop: true,
					spaceBetween: 10,
					slidesPerView: 5,
					freeMode: true,
					watchSlidesProgress: true,
					scrollbar: {
						el: '.swiper-scrollbar',
						draggable: true,
					},
					pagination: {
						el: ".swiper-pagination",
						clickable: true,
					},
				});
			</script>
		</div>

		<div class="backbutton-sec">
			<a href="javascript:history.back(-1);">< 이전</a>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/app/homepage/gukbo/kiosk/bookNavigation.jsp" flush="false" />

<tiles:insertAttribute name="footer" />