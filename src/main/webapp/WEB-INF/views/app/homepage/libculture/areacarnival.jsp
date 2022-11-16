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
    var _ingcultures;
    var _areacultures;


    var Cultures = function(){
      try {
        if( _ingcultures ) _ingcultures.destroySlider();
        if( _areacultures ) _areacultures.destroySlider();
      } catch (e) {
        // TODO: handle exception
      }

      if( _width <= 425 ){
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 1,
          slideWidth: 430
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 1,
          slideWidth: 430
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 1,
          slideWidth: 430
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 2,
          slideWidth: 430
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 2,
          slideWidth: 390
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 2,
          slideWidth: 430
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 3,
          slideWidth: 310
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 3,
          slideWidth: 340
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 3,
          slideWidth: 370
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 3,
          slideWidth: 400
        });

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
        _ingcultures = $('.ingSlideList ul').bxSlider({
          auto: true,
          pager: false,
          moveSlides:1,
          maxSlides: 3,
          slideWidth: 430
        });

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

    Cultures();

    $(window).on('resize', function(e){
      e.preventDefault();
      _width = $(window).width();

      Cultures();
    });

  });
</script>

<ul>
    <c:choose>
        <c:when test="${fn:length(festivalList) > 0}">
            <c:forEach var="i" items="${festivalList}">
                <li>
                    <h4>${i.imsi_v_2}</h4>
                    <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" class="border bgimg001" target="_blank">
                        <div class="imgae-box">
                            <c:choose>
                                <c:when test="${i.preview_img ne null}">
                                    <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="/resources/homepage/${homepage.context_path}/img/book_noimg.png" alt="등록된 이미지가 없습니다.  상세보기"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="txt-box">
                            <p class="txt-box-title">${i.title}</p>
                            <p class="txt-box-day">
                                <c:set var = "months" value = "${fn:replace(i.imsi_v_1, 'JAN', '1')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'FED', '2')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'MAR', '3')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'APR', '4')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'MAY', '5')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'JUN', '6')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'JUL', '7')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'AUG', '8')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'SEP', '9')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'OCT', '10')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'NOV', '11')}" />
                                <c:set var = "months" value = "${fn:replace(months, 'DEC', '12')}" />
                                ${months}월 중
                            </p>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li>행사축제 프로그램이 없습니다.</li>
        </c:otherwise>
    </c:choose>

</ul>