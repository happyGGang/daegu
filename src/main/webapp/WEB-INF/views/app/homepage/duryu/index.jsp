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
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/reset.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/common.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/footer.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/header.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/total-popup.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/slick.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/common/slick-theme.css"/>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-face.css"/>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/ungveloper/web-fonts/GmarketSans/font-family.css"/>
<script src="/resources/homepage/duryu/plugin/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullPage.js/4.0.17/fullpage.js"></script>
<script src="/resources/homepage/duryu/js/common/common.js"></script>
<script src="/resources/homepage/duryu/js/common/fullpage.js"></script>
<script src="/resources/homepage/duryu/plugin/slick.min.js"></script>

<!-- 메인 -->
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section1.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section2.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section3.css"/>
<link rel="stylesheet" href="/resources/homepage/duryu/css/index/section4.css"/>
<script src="/resources/homepage/duryu/js/index/section1.js"></script>
<script src="/resources/homepage/duryu/js/index/section2.js"></script>
<script src="/resources/homepage/duryu/js/index/section4.js"></script>

<c:set var="listNums" value="<%=listNums%>"/>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
    $(function () {
        $('div.calendar').load('calendar3.do');
        $('div#holiday-area').load('calendar2.do');

      // 팝업 관련 코드 START
      $('.close-btn').on('click', function() {
        let $this = $(this);
        let checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
        let popupId = checkInput.val();
        if (checkInput.prop('checked')) {
          let todayDate = new Date();
          todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
          if($this.data('day') == 7) {
            todayDate.setDate(todayDate.getDate() + 7);
          }
          document.cookie = popupId + "=no" + "; path=/; expires=" + todayDate.toGMTString() + ";";
        }

        $('div#' + popupId).hide();
      });

      $('input[id*=pop]').on('click', function(e) {
        e.preventDefault();
        $(this).prop('checked', true);
        $(this).parent('div').next('a').data('day', $(this).data('day'));
        $(this).parent('div').next('a').click();
      });

      $('#popupLayer > div').each(function(i, v) {
        let result = '';
        let name = $(v).attr('id');
        let nameOfCookie = name + "=";
        let x = 0;
        while (x <= document.cookie.length) {
          var y = (x + nameOfCookie.length);
          if (document.cookie.substring(x, y) == nameOfCookie) {
            if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
              endOfCookie = document.cookie.length;
            result = unescape(document.cookie
            .substring(y, endOfCookie));
          }
          x = document.cookie.indexOf(" ", x) + 1;
          if (x == 0)
            break;
        }

        if (result != 'no') {
          if  (window.innerWidth < $(v).width() ) {
            $(v).css('width', 'auto');
          }
          $(v).show();
        }
      });
      // 팝업 관련 코드 END


        $('.tab1').html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

        $('div.tab1').load('newBook.do', function () {

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

    <div class="popupWrap section">
        <div id="popupLayer">
            <homepageTag:popup popupList="${popupList}" />
        </div>
    </div>

    <!-- 통합팝업 -->
    <c:if test="${not empty popupFullList}">
        <div class="total-popup-overlay"></div>
        <div class="total_popup_area" id="total_popup_area">
            <div class="total-popup-controller">
                <div class="total-popup-controller-btn popup-today-close">
                    <div>오늘 하루 열지 않기</div>
                    <img src="/resources/homepage/duryu/img/common/total-popup-close.svg" alt="">
                </div>
                <div class="total-popup-controller-btn popup-close">
                    <div>창 닫기</div>
                    <img src="/resources/homepage/duryu/img/common/total-popup-close.svg" alt="">
                </div>
            </div>

            <div class="total-popup-content">
                <div class="total-popup-title">POPUP LIST</div>
                <div class="total-popup-slide-wrapper">
                    <img class="total-popup-slide-prev" src="/resources/homepage/duryu/img/common/total-popup-left-arrow.svg" alt="">
                    <div class="total-popup-slide">
                        <c:forEach items="${popupFullList}" var="i" varStatus="status">
                            <div class="total-popup-slide-item">
                                <c:choose>
                                    <c:when test="${not empty i.server_file_name}">
                                        <img src="${pageContext.request.contextPath}/data/popup/${i.homepage_id}/${i.server_file_name}" alt="${i.alt_text}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/homepage/duryu/img/common/dummy.png" alt="${i.alt_text}">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty i.link_type and i.link_type ne 'NONE'}">
                                    <a href="${i.link_url}"> ${i.link_type eq 'APPLY' ? '신청하기' : '자세히보기'} </a>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                    <img class="total-popup-slide-next" src="/resources/homepage/duryu/img/common/total-popup-right-arrow.svg" alt="">
                </div>
            </div>
        </div>
    </c:if>

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
                    <div><span>전통</span>과 함께<br><span>미래</span>를 열어가는 곳</div>
                    <div>두류도서관입니다</div>
                </div>
                <!-- 검색 -->
                <div class="search-bar-wrapper">
                    <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
                        <input type="hidden" name="menu_idx" value="13">
                        <input type="hidden" name="booktype" value="BOOKANDNONBOOK">
                        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
                        <input name="title" id="book-search" type="text" placeholder="찾으시는 도서 정보를 입력하세요"/>

                        <button class="book-search-btn" id="main-search-btn">
                            <img src="/resources/homepage/duryu/img/main/search.svg" alt=""/>
                        </button>
                    </form>
                </div>
                <!-- 퀵메누 -->
                <div class="quick-menu">
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
            </div>
            <!-- 휴관일 & 공지사항 -->
            <div class="main-bottom-area">
                <div class="holiday-area" id="holiday-area"></div>
                <div class="notice-slide-wrapper">
                    <img src="/resources/homepage/duryu/img/main/notice-slide-pause.svg" alt="">
                    <div class="notice-slide">
                        <c:if test="${not empty newsList}">
                            <c:forEach items="${newsList}" var="i">
                                <div>
                                    <c:out value="${i.news_name}" default="제목 없음" />
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
                        <a href="https://library.daegu.go.kr/duryu/board/index.do?menu_idx=36&manage_idx=132">
                            <img src="/resources/homepage/duryu/img/notice/more.svg" alt="">
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
                                                    <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}" />
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${i.link_url}">
                                                    <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}" />
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="popup-slide-item">
                                    <img src="/resources/homepage/duryu/img/common/dummy.png" alt="" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="popup-control">
                        <div class="popup-prev">
                            <img src="/resources/homepage/duryu/img/notice/popup-prev.svg" alt=""/>
                        </div>
                        <div class="popup-pagination"></div>
                        <div class="popup-play-and-pause">
                            <img src="/resources/homepage/duryu/img/notice/pause.svg" alt=""/>
                        </div>
                        <div class="popup-next">
                            <img src="/resources/homepage/duryu/img/notice/popup-next.svg" alt=""/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 섹션3 -->
        <div class="section-wrapper" data-anchor="section3">
            <div class="wrapper">
                <div class="course-board">
                    <div class="course-board-header">
                        <div class="course-board-title">강좌 및 행사</div>
                        <a href="https://library.daegu.go.kr/duryu/module/calendarManage/index.do?menu_idx=63">
                            <img src="/resources/homepage/duryu/img/culture/more.svg" alt="">
                        </a>
                    </div>
                    <div class="course-list">
                        <c:if test="${fn:length(teachList) < 1}">
                            <div class="course-no-data">등록된 강좌 및 행사가 없습니다.</div>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${teachList}" begin='0' end='4'>
                            <a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" class="course-list-item">
                                <div class="course-list-item-title">${i.teach_name}</div>
                                <div class="course-list-item-date">
                                    <div><span>강좌기간</span>${i.start_date} ~ ${i.end_date}</div>
                                    <div><span>접수기간</span>${i.start_join_date} ~ ${i.start_join_date}</div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="calendar"></div>
            </div>
        </div>
        <!-- 섹션4 -->
        <div class="section-wrapper" data-anchor="section4">
            <div class="wrapper">
                <a id="tab-link" href="https://library.daegu.go.kr/duryu/intro/search/newBook/index.do?menu_idx=14">
                    <img src="/resources/homepage/duryu/img/book/more.svg" alt="">
                </a>
                <div class="book-tab-wrapper">
                    <div class="tab-button active-tab" data-target="tab1">신착도서</div>
                    <div class="tab-button" data-target="tab2">추천도서</div>
                </div>
                <div class="tab-content tab1"></div>
                <div class="tab-content tab2" style="display: none;">
                    <c:if test="${fn:length(recommendBookList) < 1}">
                        <div class="book-nodata">등록된 추천도서가 없습니다.</div>
                    </c:if>
                    <div class="tab-list">
                        <c:forEach var="i" varStatus="status" items="${recommendBookList}">
                            <div class="tab-list-item">
                                <a href="/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                    <c:choose>
                                        <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                            <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/homepage/duryu/img/common/dummy.png';" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=41&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/homepage/duryu/img/common/dummy.png';" />
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                                <div class="title">${i.title}</div>
                            </div>
                        </c:forEach>
                    </div>
                    <c:if test="${fn:length(recommendBookList) >= 1}">
                        <div class="book-controller">
                            <img class="book-slide-prev" src="/resources/homepage/duryu/img/book/arrow-left.svg" alt="">
                            <img class="book-slide-next" src="/resources/homepage/duryu/img/book/arrow-right.svg" alt="">
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- footer -->
        <div class="footer section-wrapper fp-auto-height" data-anchor="section5">
            <!-- banner -->
            <div class="banner-area">
                <div class="banner-slide-controller">
                    <img class="banner-prev" src="/resources/homepage/duryu/img/common/banner-prev.svg" alt=""/>
                    <img class="banner-next" src="/resources/homepage/duryu/img/common/banner-next.svg" alt=""/>
                    <img class="banner-play-and-pause" src="/resources/homepage/duryu/img/common/banner-pause.svg" alt="">
                    <img onclick="window.location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=93';" src="/resources/homepage/duryu/img/common/banner-more.svg" alt="">
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