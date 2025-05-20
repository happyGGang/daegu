<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Random" %>
<%
    Random rnd = new Random();
    int[] listNums = new int[10];
    for (int i = 0; i < 10; i++) {
        int num;
        boolean unique;
        do {
            unique = true;
            num = rnd.nextInt(10);
            for (int j = 0; j < i; j++) {
                if (listNums[j] == num) {
                    unique = false;
                    break;
                }
            }
        } while (!unique);
        listNums[i] = num;
    }
%>
<!-- 공통 -->
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/reset.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/common.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/footer.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/header.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/total-popup.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/slick.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/common/slick-theme.css"/>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-face.css"/>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-family.css"/>
<script src="/resources/homepage/seobu/plugin/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.js"></script>
<script src="/resources/homepage/seobu/js/common/common.js"></script>
<script src="/resources/homepage/seobu/js/common/fullpage.js"></script>
<script src="/resources/homepage/seobu/plugin/slick.min.js"></script>

<!-- 메인 -->
<link rel="stylesheet" href="/resources/homepage/seobu/css/index/section1.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/index/section2.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/index/section3.css"/>
<link rel="stylesheet" href="/resources/homepage/seobu/css/index/section4.css"/>
<script src="/resources/homepage/seobu/js/index/section1.js"></script>
<script src="/resources/homepage/seobu/js/index/section2.js"></script>
<script src="/resources/homepage/seobu/js/index/section3.js"></script>
<script src="/resources/homepage/seobu/js/index/section4.js"></script>

<c:set var="listNums" value="<%=listNums%>"/>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
  $(function () {
    $('div#holiday-area').load('calendar2.do');
    $('div#total_popup_area').load('popupAll.do');

    $('div.tab3').html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

    $('div.tab3').load('newBook.do', function () {

      const $bookSlide = $('.tab-list');
      if ($bookSlide.length && !$bookSlide.hasClass('slick-initialized')) {
        $bookSlide.slick({
          slidesToShow: 5,
          slidesToScroll: 1,
          autoplay: false,
          arrows: false,
          dots: false,
          variableWidth: true,
          responsive: [
            {
              breakpoint: 1260,
              settings: {
                slidesToShow: 4,
                variableWidth: true,
              },
            },
            {
              breakpoint: 865,
              settings: {
                slidesToShow: 3,
                variableWidth: true,
              },
            },
          ],
        });
      }

      $('.book-slide-prev, .book-slide-next').off('click').on('click', function () {
        if ($bookSlide.hasClass('slick-initialized')) {
          $bookSlide.slick($(this).hasClass('book-slide-prev') ? 'slickPrev' : 'slickNext');
        }
      });
    });

    $('#main-search-btn').on('click', function () {
      if ($('input#book-search').val() == '') {
        alert('검색어를 입력하세요.');
        $('input#book-search').focus();
        return false;
      }
      $('#main-search-btn').submit();
    });
  });
</script>

<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
<div id="wrap" class="main_container">
    <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>

    <tiles:insertAttribute name="top"/>
    <tiles:insertAttribute name="topMenu"/>

    <!-- 통합팝업 -->
    <div class="total-popup-overlay"></div>
    <div class="total_popup_area" id="total_popup_area"></div>

    <div id="fullpage">
        <!-- 섹션1 -->
        <div class="section-wrapper" data-anchor="section1">
            <div class="main-bg-slide">
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div class="wrapper">
                <div class="slogan">
                    <div>당신의 <span>꿈</span>과<br><span>행복</span>이 함께하는 곳</div>
                    <div>서부도서관입니다</div>
                </div>
                <!-- 검색 -->
                <div class="search-bar-wrapper">
                    <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
                        <input type="hidden" name="menu_idx" value="13">
                        <input type="hidden" name="booktype" value="BOOKANDNONBOOK">
                        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
                        <input name="title" id="book-search" type="text" placeholder="찾으시는 도서 정보를 입력하세요"/>

                        <button class="book-search-btn" id="main-search-btn">
                            <img src="/resources/homepage/seobu/img/main/search.svg" alt=""/>
                        </button>
                    </form>
                </div>
                <!-- 퀵메누 -->
                <div class="quick-menu">
                    <img class="quick-menu-slide-prev" src="/resources/homepage/seobu/img/main/quick-menu-left-arrow.svg" alt="">
                    <div class="quick-menu-slide">
                        <c:forEach var="i" varStatus="status" items="${quickMenuList}">
                            <c:if test="${i.link_target eq 'BLANK' }">
                                <a class="quick-menu-item" href="${i.link_url}" target="_blank">
                                    <img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}.${i.file_extension}" alt="${i.menu_name}">
                                    <div>${i.menu_name}</div>
                                </a>
                            </c:if>
                            <c:if test="${i.link_target ne 'BLANK' }">
                                <a class="quick-menu-item" href="${i.link_url}" target="_blank">
                                    <img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}.${i.file_extension}" alt="${i.menu_name}">
                                    <div>${i.menu_name}</div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                    <img class="quick-menu-slide-next" src="/resources/homepage/seobu/img/main/quick-menu-right-arrow.svg" alt="">
                </div>
            </div>
            <!-- 휴관일 & 공지사항 -->
            <div class="main-bottom-area">
                <div class="holiday-area" id="holiday-area"></div>
                <div class="notice-slide-wrapper">
                    <img src="/resources/homepage/seobu/img/main/notice-slide-pause.svg" alt="">
                    <div class="notice-slide">
                        <c:if test="${not empty newsList}">
                            <c:forEach items="${newsList}" var="i">
                                <div>
                                    <c:out value="${i.news_name}" default="제목 없음"/>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty newsList}">
                            <div>등록된 알림이 없습니다.</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <!-- 섹션2 -->
        <div class="section-wrapper" data-anchor="section2">
            <div class="wrapper">
                <div class="notice-board">
                    <div class="notice-board-header">
                        <div class="notice-board-title">공지사항</div>
                        <a href="https://library.daegu.go.kr/seobu/board/index.do?menu_idx=36&manage_idx=161">
                            <img src="/resources/homepage/seobu/img/notice/more.svg" alt="">
                        </a>
                    </div>
                    <div class="notice-list">
                        <c:forEach var="i" varStatus="status" items="${noticeList}">
                            <a class="notice-list-item" href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                <div class="notice-list-item-date">
                                    <div><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></div>
                                    <div><fmt:formatDate value="${i.add_date}" pattern="yyyy"/></div>
                                </div>
                                <div class="notice-list-item-title">${i.title}</div>
                            </a>
                        </c:forEach>
                        <c:if test="${fn:length(noticeList) < 1}">
                            <div class="notice-no-data">등록된 공지사항이 없습니다.</div>
                        </c:if>
                    </div>
                </div>

                <div class="popup-slide-wrapper">
                    <div class="popup-slide">
                        <c:choose>
                            <c:when test="${fn:length(popupZoneList) > 0}">
                                <c:forEach var="i" items="${popupZoneList}">
                                    <div class="popup-slide-item">
                                        <c:choose>
                                            <c:when test="${i.link_target eq 'BLANK'}">
                                                <a href="${i.link_url}" target="_blank">
                                                    <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}"/>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${i.link_url}">
                                                    <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}"/>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="popup-slide-item">
                                    <img src="/resources/homepage/seobu/img/common/dummy.png" alt=""/>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="popup-control">
                        <div class="popup-prev">
                            <img src="/resources/homepage/seobu/img/notice/popup-prev.svg" alt=""/>
                        </div>
                        <div class="popup-pagination"></div>
                        <div class="popup-play-and-pause">
                            <img src="/resources/homepage/seobu/img/notice/pause.svg" alt=""/>
                        </div>
                        <div class="popup-next">
                            <img src="/resources/homepage/seobu/img/notice/popup-next.svg" alt=""/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 섹션3 -->
        <div class="section-wrapper" data-anchor="section3">
            <div class="wrapper">
                <div class="course-list-header">
                    <div class="course-list-header-title">문화강좌 및 행사</div>
                    <a href="https://library.daegu.go.kr/seobu/module/teach/index.do?menu_idx=30" class="go-to-course">
                        <div>더보기</div>
                        <img src="/resources/homepage/seobu/img/culture/more.svg" alt="">
                    </a>
                </div>
                <div class="course-list">
                    <c:if test="${fn:length(teachList) < 1}">
                        <div class="course-no-data">등록된 강좌 및 행사가 없습니다.</div>
                    </c:if>
                    <c:if test="${fn:length(teachList) >= 1}">
                        <img class="img1" src="/resources/homepage/seobu/img/culture/img1.svg" alt="">
                        <img class="img2" src="/resources/homepage/seobu/img/culture/img2.svg" alt="">
                        <c:forEach var="i" varStatus="status" items="${teachList}" begin='0' end='3'>
                            <a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}"
                               class="course-list-item">
                                <div class="course-list-item-title">
                                    <div>${i.teach_name}</div>
                                </div>
                                <div class="course-list-item-date">
                                    <div><span>강좌기간</span>${i.start_date} ~ ${i.end_date}</div>
                                    <div><span>접수기간</span>${i.start_join_date} ~ ${i.start_join_date}</div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="event-area">
                <div class="event-area-wrapper">
                    <div class="event-area-header">
                        <div>이달의 행사일을 확인해보세요</div>
                        <a href="https://library.daegu.go.kr/seobu/module/calendarManage/index.do?menu_idx=63">
                            <div>더보기</div>
                            <img src="/resources/homepage/seobu/img/culture/more-black.svg" alt="">
                        </a>
                    </div>
                    <div class="event-slide-wrapper">
                        <img class="event-slide-prev" src="/resources/homepage/seobu/img/culture/event-left-arrow.svg" alt="">
                        <div class="event-slide">
                            <div class="event-slide-item">01</div>
                            <div class="event-slide-item">02</div>
                            <div class="event-slide-item">03</div>
                            <div class="event-slide-item">04</div>
                            <div class="event-slide-item">05</div>
                            <div class="event-slide-item">06</div>
                            <div class="event-slide-item">07</div>
                        </div>
                        <img class="event-slide-next" src="/resources/homepage/seobu/img/culture/event-right-arrow.svg" alt="">
                    </div>
                </div>
            </div>
        </div>
        <!-- 섹션4 -->
        <div class="section-wrapper" data-anchor="section4">
            <div class="wrapper">
                <a id="tab-link" href="https://library.daegu.go.kr/seobu/intro/search/newBook/index.do?menu_idx=14">
                    <img src="/resources/homepage/seobu/img/book/more.svg" alt="">
                </a>
                <div class="book-tab-wrapper">
                    <div class="tab-button active-tab" data-target="tab1">북큐레이션</div>
                    <div class="tab-button" data-target="tab2">대출베스트</div>
                    <div class="tab-button" data-target="tab3">신착도서</div>
                </div>
                <div class="tab-content tab1">
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <img class="book-slide-prev" src="/resources/homepage/seobu/img/book/arrow-left.svg" alt="">
                    </c:if>
                    <c:if test="${fn:length(recommendBookList) < 1}">
                        <div class="book-nodata">등록된 북큐레이션이 없습니다.</div>
                    </c:if>
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <div class="tab-list">
                            <c:forEach var="i" varStatus="status" items="${recommendBookList}">
                                <div class="tab-list-item">
                                    <a href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                        <c:choose>
                                            <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}"
                                                     onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'"
                                                     onerror="this.src='/resources/homepage/seobu/img/common/dummy.png';"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${i.preview_img}" alt="${i.title}" title="${i.title}"
                                                     onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'"
                                                     onerror="this.src='/resources/homepage/seobu/img/common/dummy.png';"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <div class="title">${i.title}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <img class="book-slide-next" src="/resources/homepage/seobu/img/book/arrow-right.svg" alt="">
                    </c:if>
                </div>
                <div class="tab-content tab2" style="display: none;">
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <img class="book-slide-prev" src="/resources/homepage/seobu/img/book/arrow-left.svg" alt="">
                    </c:if>
                    <c:if test="${fn:length(recommendBookList) < 1}">
                        <div class="book-nodata">등록된 대출베스트가 없습니다.</div>
                    </c:if>
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <div class="tab-list">
                            <c:forEach var="i" varStatus="status" items="${recommendBookList}">
                                <div class="tab-list-item">
                                    <a href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                        <c:choose>
                                            <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}"
                                                     onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'"
                                                     onerror="this.src='/resources/homepage/seobu/img/common/dummy.png';"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${i.preview_img}" alt="${i.title}" title="${i.title}"
                                                     onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'"
                                                     onerror="this.src='/resources/homepage/seobu/img/common/dummy.png';"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <div class="title">${i.title}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <img class="book-slide-next" src="/resources/homepage/seobu/img/book/arrow-right.svg" alt="">
                    </c:if>
                </div>
                <div class="tab-content tab3" style="display: none;"></div>
            </div>
        </div>

        <!-- footer -->
        <div class="footer section-wrapper fp-auto-height" data-anchor="section5">
            <!-- banner -->
            <div class="banner-area">
                <div class="banner-slide-controller">
                    <img class="banner-prev" src="/resources/homepage/seobu/img/common/banner-prev.svg" alt=""/>
                    <img class="banner-next" src="/resources/homepage/seobu/img/common/banner-next.svg" alt=""/>
                    <img class="banner-play-and-pause" src="/resources/homepage/seobu/img/common/banner-pause.svg" alt="">
                    <img onclick="window.location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=93';" src="/resources/homepage/seobu/img/common/banner-more.svg" alt="">
                </div>
                <homepageTag:newBanner bannerList="${bannerList}"/>
            </div>

            <tiles:insertAttribute name="footer"/>
        </div>
    </div>

    <!-- indicator -->
    <div id="fullpage-indicator">
        <div data-menuanchor="section1"></div>
        <div data-menuanchor="section2"></div>
        <div data-menuanchor="section3"></div>
        <div data-menuanchor="section4"></div>
        <div data-menuanchor="section5"></div>
    </div>
</div>
</body>