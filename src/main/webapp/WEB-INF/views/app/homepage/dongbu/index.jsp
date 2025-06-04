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

<script src="/resources/homepage/dongbu/plugin/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/resources/homepage/dongbu/css/index/section1.css"/>
<link rel="stylesheet" href="/resources/homepage/dongbu/css/index/section2.css"/>
<link rel="stylesheet" href="/resources/homepage/dongbu/css/index/section3.css"/>
<link rel="stylesheet" href="/resources/homepage/dongbu/css/index/section4.css"/>
<script src="/resources/homepage/dongbu/js/index/section1.js"></script>
<script src="/resources/homepage/dongbu/js/index/section2.js"></script>
<script src="/resources/homepage/dongbu/js/index/section3.js"></script>
<script src="/resources/homepage/dongbu/js/index/section4.js"></script>

<c:set var="listNums" value="<%=listNums%>"/>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
    $(function () {
        $('div#holiday-area').load('calendar2.do');
        $('div#event-area').load('calendar3.do');
        $('div#total_popup_area').load('popupAll.do');
        loadTabContent('div.tab1', 'newBook.do');
        loadTabContent('div.tab2', 'bestBook.do');

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
<!--    <div class="total-popup-overlay"></div>-->
<!--    <div class="total_popup_area" id="total_popup_area"></div>-->

    <div id="fullpage">
        <!-- 섹션1 -->
        <div class="section-wrapper" data-anchor="section1">
            <div class="main-bg-slide">
                <div></div>
            </div>
            <div class="wrapper">
                <div class="slogan">
                    <div><span>미래</span>를 보는 눈,<br><span>희망</span>을 키우는 곳</div>
                    <div>대구광역시립동부도서관</div>
                </div>
                <!-- 검색 -->
                <div class="search-bar-wrapper">
                    <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
                        <input type="hidden" name="menu_idx" value="13">
                        <input type="hidden" name="booktype" value="BOOKANDNONBOOK">
                        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
                        <input name="title" id="book-search" type="text" placeholder="찾으시는 도서 정보를 입력하세요"/>

                        <button class="book-search-btn" id="main-search-btn">
                            <img src="/resources/homepage/dongbu/img/main/search.svg" alt=""/>
                        </button>
                    </form>
                </div>
                <!-- 퀵메뉴 -->
                <div class="quick-menu">
                    <img class="quick-menu-slide-prev" src="/resources/homepage/dongbu/img/main/quick-menu-left-arrow.svg" alt="">
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
                    <img class="quick-menu-slide-next" src="/resources/homepage/dongbu/img/main/quick-menu-right-arrow.svg" alt="">
                </div>
            </div>
            <!-- 휴관일 & 공지사항 -->
            <div class="main-bottom-area">
                <div class="holiday-area" id="holiday-area"></div>
            </div>
        </div>
        <!-- 섹션2 -->
        <div class="section-wrapper" data-anchor="section2">
            <div class="wrapper">
                <div class="notice-board">
                    <div class="notice-board-header">
                        <div class="notice-board-title">공지사항</div>
                        <div class="notice-board-title">강좌·행사안내</div>
                        <a href="https://library.daegu.go.kr/dongbu/board/index.do?menu_idx=36&manage_idx=161">
                            <img src="/resources/homepage/dongbu/img/notice/more.svg" alt="">
                        </a>
                    </div>
                    <div class="notice-list">
                        <c:forEach var="i" varStatus="status" items="${noticeList}" begin='0' end='5'>
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

                    <div class="event-list" style="display: none">
                        <c:forEach var="i" varStatus="status" items="${boardList1}" begin='0' end='5'>
                            <a class="event-list-item" href="/${homepage.context_path}/board/view.do?menu_idx=170&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                <div class="event-list-item-date">
                                    <div><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></div>
                                    <div><fmt:formatDate value="${i.add_date}" pattern="yyyy"/></div>
                                </div>
                                <div class="event-list-item-title">${i.title}</div>
                            </a>
                        </c:forEach>
                        <c:if test="${fn:length(boardList1) < 1}">
                            <div class="event-no-data">등록된 강좌·행사안내가 없습니다.</div>
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
                                    <img src="/resources/homepage/dongbu/img/common/dummy.png" alt=""/>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="popup-control">
                        <div class="popup-prev">
                            <img src="/resources/homepage/dongbu/img/notice/popup-prev.svg" alt=""/>
                        </div>
                        <div class="popup-pagination"></div>
                        <div class="popup-play-and-pause">
                            <img src="/resources/homepage/dongbu/img/notice/pause.svg" alt=""/>
                        </div>
                        <div class="popup-next">
                            <img src="/resources/homepage/dongbu/img/notice/popup-next.svg" alt=""/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 섹션3 -->
        <div class="section-wrapper" data-anchor="section3">
            <div class="wrapper">
                <div class="box">
                    <div class="box-header">
                        <div class="box-title">도서관일정</div>
                        <div class="box-action">
                            <a href="https://library.daegu.go.kr/dongbu/module/calendarManage/index.do?menu_idx=63">
                                <img src="/resources/homepage/dongbu/img/culture/more.svg" alt="">
                            </a>
                        </div>
                    </div>
                    <div id="event-area"></div>
                </div>
                <div class="box">
                    <div class="box-header">
                        <div class="box-title">강좌 및 행사</div>
                        <div class="box-action">
                            <img class="course-slide-prev"
                                    src="/resources/homepage/dongbu/img/culture/slide-left-arrow.svg" alt="">
                            <img class="course-slide-next"
                                    src="/resources/homepage/dongbu/img/culture/slide-right-arrow.svg" alt="">
                            <a href="https://library.daegu.go.kr/dongbu/board/index.do?menu_idx=170&manage_idx=474">
                                <img src="/resources/homepage/dongbu/img/culture/more.svg" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="course-slide">
                        <c:if test="${fn:length(teachList) < 1}">
                            <div class="course-slide-item">
                                <img src="/resources/homepage/dongbu/img/culture/course.svg" alt="">
                                <div class="course-title">등록된 강좌가 없습니다.</div>
                            </div>
                        </c:if>
                        <c:if test="${fn:length(teachList) >= 1}">
                            <c:forEach var="i" varStatus="status" items="${teachList}">
                                <a class="course-slide-item" href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
                                    <img src="/resources/homepage/dongbu/img/culture/course.svg" alt="">
                                    <div class="course-title">${i.teach_name}</div>
                                    <div class="course-description">
                                        ${i.teach_desc}
                                    </div>
                                    <div class="course-date">
                                        <div>강좌기간<span>${i.start_date} ~ ${i.end_date}</span></div>
                                        <div>접수기간<span>${i.start_join_date} ~ ${i.start_join_date}</span></div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:if>
					</div>
				</div>
				<div class="box">
					<div class="box-header">
						<div class="box-title">이달의 영화 상영</div>
						<div class="box-action">
							<img class="movie-slide-prev"
								 src="/resources/homepage/dongbu/img/culture/slide-left-arrow.svg" alt="">
							<img class="movie-slide-next"
								 src="/resources/homepage/dongbu/img/culture/slide-right-arrow.svg" alt="">
							<a href="https://library.daegu.go.kr/dongbu/module/calendarManage/index.do?menu_idx=63">
								<img src="/resources/homepage/dongbu/img/culture/more.svg" alt="">
							</a>
						</div>
					</div>
					<div class="movie-slide">
                        <c:if test="${fn:length(movieList) < 1}">
                            <div class="movie-slide-item">
                                <div class="movie-title">등록된 영화가 없습니다.</div>
                            </div>
                        </c:if>
                        <c:if test="${fn:length(movieList) >= 1}">
                            <c:forEach var="i" varStatus="status" items="${movieList}" >
                                <a class="movie-slide-item" href="/${homepage.context_path}/board/view.do?menu_idx=60&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                    <c:choose>
                                        <c:when test="${i.preview_img ne null}">
                                            <c:choose>
                                                <c:when test="${fn:contains(i.preview_img, 'http')}">
                                                    <img src="${i.preview_img}" alt="${i.title}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/resources/homepage/dongbu/img/common/dummy.png" alt="${i.title}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="movie-title">${i.title}</div>
                                    <div class="movie-detail">
                                        <c:if test="${i.imsi_v_1 ne '' and i.imsi_v_2 ne ''}">
                                            <div>날짜<span>${fn:replace(i.imsi_v_1, '-', '-')}-${i.imsi_v_2}</span></div>
                                        </c:if>
                                        <c:if test="${i.imsi_v_3 ne null and i.imsi_v_4 ne null}">
                                            <div>시간<span>${i.imsi_v_3}:${fn:length(i.imsi_v_4) == 1 ? '0' : ''}${i.imsi_v_4}</span></div>
                                        </c:if>
                                        <c:if test="${i.imsi_v_6 ne null and i.imsi_v_6 ne '0'}">
                                            <div>장소<span>${i.imsi_v_6}</span></div>
                                        </c:if>
                                        <c:if test="${i.imsi_v_9 ne null and i.imsi_v_9 ne '0'}">
                                            <div>장르<span>${fn:substring(i.imsi_v_9, 0, 15)}</span></div>
                                        </c:if>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:if>
					</div>
				</div>
            </div>
        </div>
        <!-- 섹션4 -->
        <div class="section-wrapper" data-anchor="section4">
            <div class="wrapper">
                <div class="tab-header-wrapper">
                    <div class="book-tab-wrapper">
                        <div class="tab-button active-tab" data-target="tab1">신착도서</div>
                        <div class="tab-button" data-target="tab2">대출베스트</div>
                        <div class="tab-button" data-target="tab3">사서&북큐레이션</div>
                    </div>

                    <a id="tab-link" href="/dongbu/intro/search/newBook/index.do?menu_idx=14">
                        <div>신착도서 더보기</div>
                        <img src="/resources/homepage/dongbu/img/book/more.svg" alt="">
                    </a>
                </div>


                <div class="tab-content tab1"></div>
                <div class="tab-content tab2" style="display: none;"></div>
                <div class="tab-content tab3" style="display: none;">
                    <c:choose>
                        <c:when test="${fn:length(curationList) > 0}">
                            <div class="main-book-slide slider-for">
                                <c:set var="loopCount" value="${fn:length(newBookList) > 10 ? 10 : fn:length(newBookList)}"/>
                                <c:forEach var="i" begin="0" end="${loopCount - 1}">
                                    <div class="main-book-slide-item">
                                        <a href="/${homepage.context_path}/board/view.do?menu_idx=138&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                            <c:choose>
                                                <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                    <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="book-slide-wrapper">
                                <img class="book-slide-prev" src="/resources/homepage/dongbu/img/book/arrow-left.svg" alt="이전" />
                                <div class="book-slide slider-nav">
                                    <c:forEach var="i" items="${curationList}">
                                        <div class="book-slide-item">
                                            <a href="/${homepage.context_path}/board/view.do?menu_idx=138&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                        <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                                <img class="book-slide-next" src="/resources/homepage/dongbu/img/book/arrow-right.svg" alt="다음" />
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="book-nodata">등록된 북큐레이션이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- footer -->
        <div class="footer section-wrapper fp-auto-height" data-anchor="section5">
            <!-- banner -->
            <div class="banner-area">
                <div class="banner-slide-controller">
                    <img class="banner-prev" src="/resources/homepage/dongbu/img/common/banner-prev.svg" alt=""/>
                    <img class="banner-next" src="/resources/homepage/dongbu/img/common/banner-next.svg" alt=""/>
                    <img class="banner-play-and-pause" src="/resources/homepage/dongbu/img/common/banner-pause.svg" alt="">
                    <img onclick="window.location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=93';" src="/resources/homepage/dongbu/img/common/banner-more.svg" alt="">
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