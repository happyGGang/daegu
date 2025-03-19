<%@ page language="java" pageEncoding="utf-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%>

<div class="swiper-wrap-box">
  <div class="top_swiper">
    <div class="swiper">
      <diV class="swiper-wrapper">
        <c:forEach
          items="${newBookList}"
          var="i"
          varStatus="status"
          begin="0"
          end="5"
        >
          <div class="swiper-slide">
            <div
              class="book_thumbnail"
              onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=9&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO'"
            >
              <div>
                ${fn:length(i.TITLE_INFO) > 11 ? fn:substring(i.TITLE_INFO, 0,
                12) : i.TITLE_INFO}<c:if test="${fn:length(i.TITLE_INFO) > 11 }"
                  >...</c:if
                >
              </div>
              <img
                class="book_thumbnail_arrow"
                src="/resources/homepage/${homepage.context_path}/img/book_thumbnail_arrow.png"
                alt="${i.title}"
              />
            </div>
            <img
              class="book_img"
              src="${i.i.aladin.cover}"
              alt="${i.TITLE_INFO}"
              onerror="this.src='/resources/common/img/noImg2.png';"
            />
          </div>
        </c:forEach>
      </diV>
    </div>
    <div class="swiper-pagination"></div>
    <div class="book_list_more">
      <a
        href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=10"
      >
        <img
          class="book_thumbnail_arrow"
          src="/resources/homepage/${homepage.context_path}/img/black_plus.png"
          alt=""
        />
      </a>
    </div>
  </div>

  <div class="bottom_swiper">
    <div class="swiper">
      <diV class="swiper-wrapper">
        <c:forEach
          items="${newBookList}"
          var="i"
          varStatus="status"
          begin="6"
          end="11"
        >
          <div class="swiper-slide">
            <div
              class="book_thumbnail"
              onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=9&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO'"
            >
              <div>${i.TITLE_INFO}</div>
              <img
                class="book_thumbnail_arrow"
                src="/resources/homepage/${homepage.context_path}/img/book_thumbnail_arrow.png"
                alt=""
              />
            </div>
            <img
              class="book_img"
              src="${i.i.aladin.cover}"
              alt="${i.TITLE_INFO}"
              onerror="this.src='/resources/common/img/noImg2.png';"
            />
          </div>
        </c:forEach>
      </diV>
    </div>
  </div>
</div>

<script>
$(document).ready(function () {
  var topSwiper = new Swiper(".top_swiper .swiper", {
    spaceBetween: 35,
    slidesPerView: 3,
    slidesPerGroup: 3,
    loop: true,
    pagination: {
      el: ".top_swiper .swiper-pagination",
    },
    breakpoints: {
      0: { spaceBetween: 2 },
      479: { spaceBetween: 4 },
      768: { spaceBetween: 35 },
    },
  });

  var bottomZoneSwiper = new Swiper(".bottom_swiper .swiper", {
    spaceBetween: 35,
    slidesPerView: 3,
    slidesPerGroup: 3,
    loop: true,
    breakpoints: {
      0: { spaceBetween: 2 },
      479: { spaceBetween: 4 },
      768: { spaceBetween: 35 },
    },
  });

  topSwiper.on("slideChange", function () {
    bottomZoneSwiper.slideToLoop(topSwiper.realIndex); // 동기화
  });

  bottomZoneSwiper.on("slideChange", function () {
    topSwiper.slideToLoop(bottomZoneSwiper.realIndex); // 동기화
  });

  $(window).resize(function () {
    topSwiper.update();
    bottomZoneSwiper.update();
  });
});
</script>
