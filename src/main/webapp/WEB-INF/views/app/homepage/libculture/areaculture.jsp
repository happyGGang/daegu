<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script>
  $(function(){

	var _width = $(window).width();
	var __width = $(window).width();
	var _areacultures;


	var areaCultures = function(){
	  try {
		if( _areacultures ) _areacultures.destroySlider();
	  } catch (e) {
		// TODO: handle exception
	  }

	  if( _width <= 425 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 1,
		  slideWidth: 180,
		  slideMargin: 0
		});
	  }
	  else if( _width <= 550 && _width > 425 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 1,
		  slideWidth: 180,
		  slideMargin: 0
		});
	  }
	  else if( _width <= 768 && _width > 550 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 2,
		  slideWidth: 200,
		  slideMargin: 10
		});
	  }
	  else if( _width <= 1024 && _width > 768 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 2,
		  slideWidth: 220,
		  slideMargin: 10
		});
	  }
	  else if( _width <= 1140 && _width > 1024 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 3,
		  slideWidth: 240,
		  slideMargin: 20
		});
	  }
	  else if( _width <= 1260 && _width > 1140 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 3,
		  slideWidth: 240,
		  slideMargin: 40
		});
	  }
	  else if( _width <= 1330 && _width > 1260 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 3,
		  slideWidth: 240,
		  slideMargin: 60
		});
	  }
	  else if( _width <= 1450 && _width > 1330 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 3,
		  slideWidth: 240,
		  slideMargin: 60
		});
	  }
	  else if( _width <= 1540 && _width > 1450 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 4,
		  slideWidth: 240,
		  slideMargin: 60
		});
	  }
	  else if( _width <= 1620 && _width > 1540 ){
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 4,
		  slideWidth: 240,
		  slideMargin: 80
		});
	  }
	  else
	  {
		_areacultures = $('.areaCultureSlideList ul').bxSlider({
		  auto: true,
		  pager: false,
		  moveSlides:1,
		  maxSlides: 5,
		  slideWidth: 240,
		  slideMargin: 100
		});
	  }
	};

	areaCultures();

	$(window).on('resize', function(e){
		e.preventDefault();
		_width = $(window).width();
		areaCultures();
	});

  });
</script>

<ul>
  <c:choose>
	<c:when test="${fn:length(areaCultureList) > 0}">
	  <c:forEach var="i" items="${areaCultureList}">
		<li class="areaculture">
		  <h4>${i.areaname}</h4>
		  <a href="#" class="border bgimg001" target="_blank">
			<div class="imgae-box">
			  <c:choose>
				<c:when test="${i.img_url ne null}">
				  <img src="${i.img_url}" alt="${i.name}" title="${i.name}" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" />
				</c:when>
				<c:otherwise>
				  <img src="/resources/homepage/${homepage.context_path}/img/book_noimg.png" alt="등록된 이미지가 없습니다.  상세보기"/>
				</c:otherwise>
			  </c:choose>
			</div>
			<div class="txt-box">
			  <p class="txt-box-title">${i.name}</p>
			  <p class="txt-box-day">

			  </p>
			</div>
		  </a>
		</li>
	  </c:forEach>
	</c:when>
	<c:otherwise>
	  <li>등록된 문화공간이 없습니다.</li>
	</c:otherwise>
  </c:choose>

</ul>