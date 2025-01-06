<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="swiper-wrap-box">
    <div class="top_swiper">
        <div class="swiper">
            <diV class="swiper-wrapper">
                <c:forEach items="${bookList1}" var="i" varStatus="status">
                    <div class="swiper-slide">
                        <div class="book_thumbnail" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'">
                            <div>${i.title}</div>
                            <img class="book_thumbnail_arrow" src="/resources/homepage/${homepage.context_path}/img/book_thumbnail_arrow.png" alt="${i.title}"/>
                        </div>
                        <img class="book_img" src="${i.preview_img}" alt="${i.title}" onerror="this.src='/resources/common/img/noImg2.png';"/>
                    </div>
                </c:forEach>
            </diV>
        </div>
        <div class="swiper-pagination"></div>
        <div class="book_list_more">
            <a href="/${homepage.context_path}/board/index.do?menu_idx=14&manage_idx=1284">
                <img class="book_thumbnail_arrow" src="/resources/homepage/${homepage.context_path}/img/black_plus.png" alt=""/>
            </a>
        </div>
    </div>

    <div class="bottom_swiper">
        <div class="swiper">
            <div class="swiper-wrapper">
                <c:forEach items="${bookList2}" var="i" varStatus="status">
                    <div class="swiper-slide">
                        <div class="book_thumbnail" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'">
                            <div>${i.title}</div>
                            <img class="book_thumbnail_arrow" src="/resources/homepage/${homepage.context_path}/img/book_thumbnail_arrow.png" alt=""/>
                        </div>
                        <img class="book_img" src="${i.preview_img}" alt="${i.title}" onerror="this.src='/resources/common/img/noImg2.png';"/>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // 추천, 신착도서 상단 슬라이더
        var topSwiper = new Swiper(".top_swiper .swiper", {
            spaceBetween: 35,
            slidesPerView: 3,
            slidesPerGroup: 3,
            loop: true,
            pagination: {
                el: ".top_swiper .swiper-pagination",
            },
            autoplay: {
                delay: 5000,
            },
            breakpoints: {
                768: {
                    // 768px 이상
                    spaceBetween: 35, // spaceBetween 값을 명시적으로 설정
                },
                767: {
                    // 767px 이하
                    spaceBetween: 14,
                },
            },
        });

        var bottomZoneSwiper = new Swiper(".bottom_swiper .swiper", {
            spaceBetween: 35,
            slidesPerView: 3,
            slidesPerGroup: 3,
            loop: true,
            autoplay: {
                delay: 5000,
            },
            breakpoints: {
                768: {
                    // 768px 이상
                    spaceBetween: 35, // spaceBetween 값을 명시적으로 설정
                },
                767: {
                    // 767px 이하
                    spaceBetween: 14,
                },
            },
        });

        // 슬라이더 동기화
        topSwiper.on("slideChange", function () {
            bottomZoneSwiper.slideToLoop(topSwiper.realIndex); // 동기화
        });

        bottomZoneSwiper.on("slideChange", function () {
            topSwiper.slideToLoop(bottomZoneSwiper.realIndex); // 동기화
        });
    });
</script>
