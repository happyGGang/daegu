<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
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
        <c:when test="${area.msgBody.totalCount == 1}">
            <li>
                <h4>${area.msgBody.perforList.place}</h4>
                <a href="/gosan/module/teach/detail.do?homepage_id=h52&group_idx=9&teach_idx=9769&menu_idx=129&category_idx=0&large_category_idx=16" class="border bgimg001" target="_blank">
                    <div class="imgae-box">
                        <img src="${area.msgBody.perforList.thumbnail}" alt="" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" />
                    </div>
                    <div class="txt-box">
                        <p class="txt-box-title">${area.msgBody.perforList.title}</p>
                        <p class="txt-box-day">${area.msgBody.perforList.startDate} ~ ${area.msgBody.perforList.endDate}</p>
                    </div>
                </a>
            </li>
        </c:when>
        <c:when test="${area.msgBody.totalCount > 1}">
            <c:forEach var="i" items="${area.msgBody.perforList}">
                <li>
                    <h4>${i.place}</h4>
                    <a href="/gosan/module/teach/detail.do?homepage_id=h52&group_idx=9&teach_idx=9769&menu_idx=129&category_idx=0&large_category_idx=16" class="border bgimg001" target="_blank">
                        <div class="imgae-box">
                            <img src="${i.thumbnail}" alt="" onError="src='/resources/homepage/${homepage.context_path}/img/book_noimg.png';" />
                        </div>
                        <div class="txt-box">
                            <p class="txt-box-title">${i.title}</p>
                            <p class="txt-box-day">${i.startDate} ~ ${i.endDate}</p>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li>공연전시 프로그램이 없습니다.</li>
        </c:otherwise>
    </c:choose>

</ul>