<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Random"%>
<%
    Random rnd = new Random();
    int listNum1 = rnd.nextInt(10);
    int listNum2 = 0;
    int listNum3 = 0;

    // Ensure listNum2 is unique from listNum1
    do {
        listNum2 = rnd.nextInt(10);
    } while (listNum1 == listNum2);

    // Ensure listNum3 is unique from listNum1 and listNum2
    do {
        listNum3 = rnd.nextInt(10);
    } while (listNum1 == listNum3 || listNum2 == listNum3);
%>
<html lang="ko">
<body>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="listNum3" value="<%=listNum3%>"></c:set>
<tiles:insertAttribute name="header"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/jquery.fullpage.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/common/jquery.swiper.css"/>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery.fullpage.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/common/jquery.swiper.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#homeup").click(function () {
            $("body,html").animate(
                {
                    scrollTop: 0,
                },
                800
            );
            return false;
        });

        // 팝업 관련 코드 START
        $(".close-btn").on("click", function () {
            var $this = $(this);
            var checkInput = $this
                .parent()
                .find('input[data-day="' + $this.data("day") + '"]');
            var popupId = checkInput.val();
            if (checkInput.prop("checked")) {
                var todayDate = new Date();
                todayDate = new Date(
                    parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000
                );
                if ($this.data("day") == 7) {
                    todayDate.setDate(todayDate.getDate() + 7);
                }
                document.cookie =
                    popupId +
                    "=no" +
                    "; path=/; expires=" +
                    todayDate.toGMTString() +
                    ";";
            }

            $("div#" + popupId).hide();
        });

        $("input[id*=pop]").on("click", function (e) {
            e.preventDefault();
            $(this).prop("checked", true);
            $(this).parent("div").next("a").data("day", $(this).data("day"));
            $(this).parent("div").next("a").click();
        });

        $("#popupLayer > div").each(function (i, v) {
            var result = "";
            var name = $(v).attr("id");
            var nameOfCookie = name + "=";
            var x = 0;
            while (x <= document.cookie.length) {
                var y = x + nameOfCookie.length;
                if (document.cookie.substring(x, y) == nameOfCookie) {
                    if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
                        endOfCookie = document.cookie.length;
                    result = unescape(document.cookie.substring(y, endOfCookie));
                }
                x = document.cookie.indexOf(" ", x) + 1;
                if (x == 0) break;
            }

            if (result != "no") {
                if (window.innerWidth < $(v).width()) {
                    $(v).css("width", "auto");
                }
                $(v).show();
            }
        });
        // 팝업 관련 코드 END

        $("div#holiday-wrap").load("calendar2.do");
        $("ul.bestBookUl").load("bestBook.do");
        $("div#recommendBook_list").load("recommendBook.do");

        $("#main-search-btn").on("click", function () {
            var searchType = $("#searchSelect option:selected").val();
            var searchText = $("#search_text_1").val();

            $("input#search_type").val(searchType);
            $("input#search_text_1").attr("name", searchType);
            $("input#search_text_1").val(searchText);
            $("#mainSearchForm").submit();
        });
    });
</script>
<div id="wrap">
    <c:if test="${fn:length(popupZoneTopList) > 0}">
        <div class="popup_top">
            <div class="popup">
                <div class="pop_contents">
                    <div class="topPopZone">
                        <homepageTag:popupZoneTop popupZoneList="${popupZoneTopList}"/>
                    </div>
                </div>
                <p class="close">
                    <input type="checkbox" name=""/> 오늘 하루 열지 않기
                    <a href="#" onclick="return false;">
                        <img src="/resources/common/img/close_popup_btn.png" alt="닫기"/>
                    </a>
                </p>
            </div>
        </div>
    </c:if>

    <tiles:insertAttribute name="top"/>
    <tiles:insertAttribute name="topMenu"/>

    <div class="popupWrap main-section">
        <div id="popupLayer">
            <homepageTag:popup popupList="${popupList}"/>
        </div>
    </div>

    <form name="mainSearchForm" id="mainSearchForm" method="get" action="/${homepage.context_path}/intro/search/index.do">
        <input type="hidden" name="menu_idx" id="menu_idx" value="9"/>
        <input type="hidden" name="booktype" id="booktype" value="BOOKANDNONBOOK"/>
        <input type="hidden" name="search_type" id="search_type" value=""/>
        <input type="hidden" name="title" id="search_text" value=""/>
        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
    </form>

    <div id="fullpage">
        <!-- main0 -->
        <div class="section" id="main0">
            <div class="main-visual">
                <div class="main0_title_wrapper">
                    <div>함께 자라는 지식의 숲</div>
                    <div>서변숲도서관</div>
                </div>
                <!-- 메인 검색 -->
                <div class="search-area" id="main_search">
                    <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
                        <input type="hidden" name="menu_idx" value="9"/>
                        <input type="hidden" name="booktype" value="BOOKANDNONBOOK"/>
                        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
                        <fieldset>
                            <legend class="blind">통합검색</legend>
                            <div class="search_box">
                                <div style="display: flex">
                                    <label for="searchSelect">
                                        <select id="searchSelect">
                                            <option value="title">서명</option>
                                            <option value="author">저자</option>
                                            <option value="publer">발행자</option>
                                            <option value="keyword">키워드</option>
                                        </select>
                                    </label>
                                    <div class="search_input_wrapper">
                                        <label for="search_text_1">
                                            <input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요."/>
                                        </label>
                                    </div>
                                </div>
                                <button id="main-search-btn">
                                    <img src="/resources/homepage/${homepage.context_path}/img/search-btn-w.png" alt="검색"/>
                                    <div>검색</div>
                                </button>
                            </div>
                        </fieldset>
                    </form>
                </div>
                <div class="main0_bottom_box">
                    <div id="holiday-wrap" class="holiday_area"></div>

                    <!-- 퀵메뉴 -->
                    <ul class="quick_menu_area">
                        <li>
                            <a href="/${homepage.context_path}/html.do?menu_idx=22">
                                <img src="/resources/homepage/${homepage.context_path}/img/quick1.png" alt=""/>
                                <div>자료이용안내</div>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/module/teach/index.do?menu_idx=40&searchCate1=17">
                                <img src="/resources/homepage/${homepage.context_path}/img/quick2.png" alt=""/>
                                <div>평생학습프로그램</div>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/module/teach/index.do?menu_idx=33&searchCate1=16">
                                <img src="/resources/homepage/${homepage.context_path}/img/quick3.png" alt=""/>
                                <div>문화행사</div>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/intro/search/hope/req.do?menu_idx=18">
                                <img src="/resources/homepage/${homepage.context_path}/img/quick4.png" alt=""/>
                                <div>희망도서신청</div>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/board/index.do?menu_idx=48&manage_idx=1287">
                                <img src="/resources/homepage/${homepage.context_path}/img/quick5.png" alt=""/>
                                <div>자주묻는질문</div>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/html.do?menu_idx=58">
                                <img src="/resources/homepage/${homepage.context_path}/img/quick6.png" alt=""/>
                                <div>찾아오시는길</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- main0 -->

        <!-- main1 -->
        <div class="section" id="main1">
            <div class="main1_wrapper">
                <div class="board_zone">
                    <div class="board_header">
                        <div class="board_title" id="board_title">NOTICE</div>
                        <div class="board_navigation">
                            <div class="board_navigation_menu board_navigation_menu_active">
                                공지사항
                            </div>
                            <div class="board_navigation_menu">행사안내</div>
                            <div>
                                <a id="more_link" href="/${homepage.context_path}/board/index.do?menu_idx=46&manage_idx=1283" style="width: 40px; height: 40px; display: block">
                                    <img src="/resources/homepage/${homepage.context_path}/img/black_plus.png" alt="더보기" style="width: 40px; height: 40px"/>
                                </a>
                            </div>
                        </div>
                    </div>
                    <ul class="board_content" id="notice_tab">
                        <c:forEach items="${noticeList}" var="i" varStatus="status">
                            <li>
                                <div class="board_content_title">
                                    <a href="/${homepage.context_path}/board/view.do?menu_idx=46&manage_idx=1283&board_idx=${i.board_idx}">
                                        <div class="board_content_title">${i.title}</div>
                                    </a>
                                </div>
                                <div class="board_content_update_date">
                                    <fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${fn:length(noticeList) < 1}">
                            <li>
                                <div class="board_content_title">
                                    <a href="">
                                        <div class="board_content_title">
                                            등록된 공지사항이 없습니다.
                                        </div>
                                    </a>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                    <ul class="board_content" id="event_tab" style="display: none">
                        <c:forEach items="${teachList}" var="i" varStatus="status">
                            <li>
                                <div class="board_content_title">
                                    <a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=32&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
                                        <div class="board_content_title">${i.teach_name}</div>
                                    </a>
                                </div>
                                <c:set var="teachDate" value="${fn:split(i.start_date, '-')}"></c:set>
                                <div class="board_content_update_date">${teachDate[0]}.${teachDate[1]}.${teachDate[2]}</div>
                            </li>
                        </c:forEach>
                        <c:if test="${fn:length(teachList) < 1}">
                            <li>
                                <div class="board_content_title">
                                    <a href="">
                                        <div class="board_content_title">
                                            등록된 게시글이 없습니다.
                                        </div>
                                    </a>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <div class="popup_zone">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <c:choose>
                                <c:when test="${fn:length(popupZoneList) > 0}">
                                    <c:forEach var="i" items="${popupZoneList}">
                                        <div class="swiper-slide">
                                            <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}" onerror="this.src='/resources/common/img/noImg2.png';"/>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- 팝업 예외 처리 -->
                                    <div class="swiper-slide">
                                        <img src="/resources/common/img/noImg2.png" alt=""/>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>

        <!-- main2 -->
        <div class="section" id="main3">
            <div class="gradient"></div>
            <div class="main2_wrapper">
                <div class="book_list_header">
                    <div class="book_list_title" id="book_title">LIBRARY BOOK</div>
                    <div class="book_list_navigation book_list_navigation_active" style="margin-bottom: 8px">추천도서</div>
                    <div class="book_list_navigation">신착도서</div>
                </div>
                <!-- 추천도서-->
                <div class="book_list_wrapper" id="recommendBook_list"></div>

                <!-- 신착도서-->
                <div class="book_list_wrapper" id="newBook_list" data-tab="tab2" style="display: none"></div>
            </div>
        </div>

        <div class="banner-box">
            <div class="main-section">
                <div class="main7_banner">
                    <div class="banner-wrap type4">
                        <div class="banner-t4">
                            <div class="control">
                                <a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/banner-prev.png" alt="이전"/><span class="blind">이전</span></a>
                                <a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/banner-next.png" alt="다음"/><span class="blind">다음</span></a>
                            </div>
                        </div>
                        <div class="banner-box4">
                            <homepageTag:banner bannerList="${bannerList}"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer -->
        <div class="section fp-auto-height footer_area" id="foot_section">
            <tiles:insertAttribute name="footer"/>
        </div>
    </div>
</div>

<script type="text/javascript">
    function fullPage() {
        var myFullpage = new fullpage("#fullpage", {
            anchors: ["firstPage", "secondPage", "3rdPage"],
            navigation: true,
            showActiveTooltip: true,
            menu: "#menu",
            responsiveWidth: 1025,
            afterLoad: function (origin, destination, direction) {
                var cur_page = destination.index + 1;
                if (destination.index == 0) {
                    $("#header").addClass("background-white");
                    $(".Gnb").css("border-bottom", "0");
                    $(".Gnb").css("background", "none");
                    $(".tnb").css("background", "none");
                } else if (destination.index == 1) {
                    $("#header").removeClass("background-white");
                    $(".Gnb").css("border-bottom", "1px solid #e6e6e6");
                    $(".Gnb").css("background", "#fff");
                    $(".tnb").css("background", "#fff");
                } else if (destination.index == 2) {
                    $("#header").removeClass("background-white");
                    $(".Gnb").css("border-bottom", "1px solid #e6e6e6");
                    $(".Gnb").css("background", "#fff");
                    $(".tnb").css("background", "#fff");
                } else if (destination.index == 3) {
                    $("#header").removeClass("background-white");
                    $(".Gnb").css("border-bottom", "1px solid #e6e6e6");
                    $(".Gnb").css("background", "#fff");
                    $(".tnb").css("background", "#fff");
                } else {
                    $("#header").removeClass("background-white");
                    $(".Gnb").css("border-bottom", "1px solid #e6e6e6");
                    $(".Gnb").css("background", "#fff");
                    $(".tnb").css("background", "#fff");
                }
            },
            afterResponsive: function (isResponsive) {
            },
        });
    }

    fullPage();

    // 모바일일 경우 fullpage 미사용
    if ($(window).width() < 1025) {
        if ($("#fullpage").hasClass("fp-destroyed")) {
        } else {
            fullpage_api.destroy("all");
        }
    } else {
        fullPage();
    }

    // 리사이즈 될때 모바일 화면에서 fullpage 미사용
    $(window).resize(function (e) {
        if ($(window).width() < 1025) {
            if ($("#fullpage").hasClass("fp-destroyed")) {
            } else {
                fullpage_api.destroy("all");
            }
        } else {
            fullPage();
        }
    });
</script>

<script>
    // 	공지사항, 행사안내 메뉴 액티브 처리
    $(".board_navigation_menu").each(function () {
        if ($(this).text().trim() === "공지사항") {
            $(this).addClass("board_navigation_menu_active");
            $("#notice_tab").show();
            $("#event_tab").hide();
            $("#board_title").text("NOTICE");
            $("#more_link").attr(
                "href",
                "/${homepage.context_path}/board/index.do?menu_idx=46&manage_idx=1283"
            );
        } else {
            $(this).removeClass("board_navigation_menu_active");
        }
    });

    // 공지사항, 행사안내 메뉴 클릭 이벤트
    $(".board_navigation_menu").click(function () {
        $(".board_navigation_menu").removeClass("board_navigation_menu_active");
        $(this).addClass("board_navigation_menu_active");

        // 클릭한 메뉴에 따라 콘텐츠 및 제목, 링크 표시/변경
        if ($(this).text().trim() === "공지사항") {
            $("#notice_tab").show();
            $("#event_tab").hide();
            $("#board_title").text("NOTICE");
            $("#more_link").attr(
                "href",
                "/${homepage.context_path}/board/index.do?menu_idx=46&manage_idx=1283"
            );
        } else if ($(this).text().trim() === "행사안내") {
            $("#notice_tab").hide();
            $("#event_tab").show();
            $("#board_title").text("EVENT");
            $("#more_link").attr(
                "href",
                "/${homepage.context_path}/module/teach/index.do?menu_idx=33&searchCate1=16"
            );
        }
    });

    // 팝업존 슬라이드
    var popupZoneSwiper = new Swiper(".popup_zone .swiper", {
        autoplay: {
            delay: 5000,
        },
        spaceBetween: 30, // 기본 spaceBetween 값
        slidesPerView: 1,
        loop: true,
        pagination: {
            el: ".popup_zone .swiper-pagination",
            type: "fraction",
        },
        navigation: {
            nextEl: ".popup_zone .swiper-button-next",
        },
        breakpoints: {
            767: {
                // 767px 이하
                spaceBetween: 0, // spaceBetween을 0으로 설정
            },
        },
    });

    // 	추천도서, 신착도서 메뉴 액티브 처리
    $(".book_list_navigation").each(function () {
        if ($(this).text().trim() === "추천도서") {
            $(this).addClass("book_list_navigation_active");
            $(".book_list_wrapper").show();
            $("#newBook_list").hide();
            $("#book_title").text("LIBRARY BOOK");
        } else {
            $(this).removeClass("book_list_navigation_active");
        }
    });
    let isLoading = false; // 로딩 상태

    $(".book_list_navigation").click(function () {
      if (isLoading) return; // 로딩 중이면 실행 중단

      // 로딩 상태 시작
      isLoading = true;

      // 메뉴 상태 초기화
      $(".book_list_navigation").removeClass("book_list_navigation_active");
      $(this).addClass("book_list_navigation_active");

      $("div#recommendBook_list .swiper-wrap-box, div#newBook_list .swiper-wrap-box").remove();

      // 로딩 이미지 및 감싸는 div 생성
      var loadingDiv = `
        <div id="loadingWrapper" style="text-align: center;">
            <img id="loadingImage" src="https://cdn.pixabay.com/animation/2023/08/11/21/18/21-18-05-265_512.gif"
                alt="로딩 중" style="width: 100px; height: 100px;">
        </div>`;
      $(".book_list_wrapper").hide(); // 기존 콘텐츠 숨김
      $("#recommendBook_list").after(loadingDiv);

      // 클릭한 메뉴에 따라 콘텐츠 표시/숨기기
      if ($(this).text().trim() === "추천도서") {
        $("#recommendBook_list").show();
        $("#book_title").text("LIBRARY BOOK");
        $("#recommendBook_list").load("recommendBook.do", function () {
          $("#loadingWrapper").remove(); // 로딩 div 제거
          isLoading = false; // 로딩 완료
        });
      } else if ($(this).text().trim() === "신착도서") {
        $("#newBook_list").show();
        $("#book_title").text("LIBRARY BOOK");
        $("#newBook_list").load("newBook.do", function () {
          $("#loadingWrapper").remove(); // 로딩 div 제거
          isLoading = false; // 로딩 완료
        });
      }
    });
	
	
	
</script>

</body>
</html>
