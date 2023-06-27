<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
$(function(){
	var _width = $(window).width();
	var _bookListTop;
	var _bookListBottom;

		var Books = function(){
			try {
				if( _bookListTop ) _bookListTop.destroySlider();
				if( _bookListBottom ) _bookListBottom.destroySlider();
			} catch (e) {
				// TODO: handle exception
			}

			if( _width <= 380 ){
				_bookListTop = $('.bookListTop ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 1,
					slideWidth: 190,
					slideMargin: 0
				});

				_bookListBottom = $('.bookListBottom ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 1,
					slideWidth: 190,
					slideMargin: 0
				});
			}
			else if( _width <= 550 && _width > 380 ){
				_bookListTop = $('.bookListTop ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 2,
					slideWidth: 190,
					slideMargin: 0
				});

				_bookListBottom = $('.bookListBottom ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 2,
					slideWidth: 190,
					slideMargin: 0
				});
			}
			else if( _width <= 768 && _width > 550 ){
				_bookListTop = $('.bookListTop ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 3,
					slideWidth: 190,
					slideMargin: 10
				});

				_bookListBottom = $('.bookListBottom ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 3,
					slideWidth: 190,
					slideMargin: 10
				});
			}
			else if( _width <= 1024 && _width > 768 ){
				_bookListTop = $('.bookListTop ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 4,
					slideWidth: 190,
					slideMargin: 20
				});

				_bookListBottom = $('.bookListBottom ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 4,
					slideWidth: 190,
					slideMargin: 20
				});
			}
			else if( _width <= 1600 && _width > 1024 ){
				_bookListTop = $('.bookListTop ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 4,
					slideWidth: 190,
					slideMargin: 10
				});

				_bookListBottom = $('.bookListBottom ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 4,
					slideWidth: 190,
					slideMargin: 20
				});
			}
			else {
				_bookListTop = $('.bookListTop ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 5,
					slideWidth: 250,
					slideMargin: 30
				});

				_bookListBottom = $('.bookListBottom ul').bxSlider({
					auto: true,
					autoHover: true,
					speed: 500,
					pager: false,
					moveSlides:1,
					maxSlides: 5,
					slideWidth: 250,
					slideMargin: 30
				});
			}
		};
		Books();
		$(window).on('resize', function(){
			_width = $(window).width();
			Books();
		});
});
</script>

<ul>
	<c:forEach items="${newBookList}" var="i" varStatus="status">
		<li>
			<a href="/${homepage.context_path}/intro/search/detail.do?menu_idx=13&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO" >
				<div class="img-boxs">
				<c:choose>
					<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
						<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
					</c:when>
					<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
						<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
					</c:when>
					<c:otherwise>
						<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
					</c:otherwise>
				</c:choose>
				</div>
				<div class="txt-box">
					<h3>${i.TITLE_INFO}</h3>
				</div>
			</a>
		</li>
	</c:forEach>
</ul>


