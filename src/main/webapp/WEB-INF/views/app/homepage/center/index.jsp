<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />

<script type="text/javascript">
    $(document).ready(function() {
        $('.board_index li').click(function() {
            $('.board_index li').removeClass('index_active');

            $(this).addClass('index_active');

            $('.noticeList, .eventList, .teachList').hide();

            let selected = $(this).attr('id');

            $('.' + selected).show();

            const boardMore = document.querySelector('.board_more');

            switch (this.id) {
                case 'noticeList':
                    boardMore.setAttribute('onclick', 'noticeDetail()');
                    break;
                case 'eventList':
                    boardMore.setAttribute('onclick', 'eventDetail()');
                    break;
                case 'teachList':
                    boardMore.setAttribute('onclick', 'teachDetail()');
                    break;
                default:
                    boardMore.removeAttribute('onclick');
            }
        });

        $('.book_information_menu_list li').click(function() {
            $('.book_information_menu_list li').removeClass('menu_active');

            $(this).addClass('menu_active');

            $('.librarian, .bestBook, .newBook').hide();

            let selected = $(this).attr('id');

            $('.' + selected).show();

            const bookMore = document.querySelector('.book_more');

            switch (this.id) {
                case 'librarian':
                    bookMore.setAttribute('onclick', 'librarianDetail()');
                    break;
                case 'bestBook':
                    bookMore.setAttribute('onclick', 'bestBookDetail()');
                    break;
                case 'newBook':
                    bookMore.setAttribute('onclick', 'newBookDetail()');
                    break;
                default:
                    bookMore.removeAttribute('onclick');
            }
        });
    });

    function noticeDetail() {
        location.href='/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=1274';
    }

    function eventDetail() {
        location.href='/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36';
    }

    function teachDetail() {
        location.href='/${homepage.context_path}/module/teach/index.do?menu_idx=34';
    }

    function librarianDetail() {
        location.href='/${homepage.context_path}/board/index.do?menu_idx=16&manage_idx=1272';
    }

    function bestBookDetail() {
        location.href='/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=13';
    }

    function newBookDetail() {
        location.href='/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=31';
    }

    $(function() {
        $('.close-btn').on('click', function() {
            var $this = $(this);
            var checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
            var popupId = checkInput.val();
            if (checkInput.prop('checked')) {
                var todayDate = new Date();
                todayDate = new Date(
                    parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
                if($this.data('day') == 7) {
                    todayDate.setDate(todayDate.getDate() + 7);
                }
                document.cookie = popupId + "=no"
                    + "; path=/; expires="
                    + todayDate.toGMTString() + ";";
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
            var result = '';
            var name = $(v).attr('id');
            var nameOfCookie = name + "=";
            var x = 0;
            while (x <= document.cookie.length) {
                var y = (x + nameOfCookie.length);
                if (document.cookie.substring(x, y) == nameOfCookie) {
                    if ((endOfCookie = document.cookie
                        .indexOf(";", y)) == -1)
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

        $('div#holiday-box').load('calendar2.do');
        $('div#calendar-box').load('calendar3.do');

        $('#main-search-btn').on('click', function() {
            if( $('input#searchInput').val() == '' ) {
                alert('검색어를 입력하세요.');
                $('input#searchInput').focus();
                return false;
            }
            $('#mainSearchForm').submit();
        });
    });
</script>

<div id="fullpage">
    <section class="section" id="section1">
        <div class="main_cation">시간과 공간을 넘어 새로운 상상력을 이어가는 곳</div>
        <div class="main_title" aria-label="대구혁신도시복합센터도서관"></div>

        <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
            <input type="hidden" name="menu_idx" value="13">
            <input type="hidden" name="booktype" value="BOOKANDNONBOOK">
            <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

            <div class="search_area">
                <label for="searchSelect">
                    <select id="searchSelect" name="search_type">
                        <option value="title">서명</option>
                        <option value="author">저자</option>
                        <option value="publer">발행자</option>
                        <option value="keyword">키워드</option>
                    </select>
                </label>
                <label for="searchInput" class="searchInput">
                    <input type="text" id="searchInput" name="title" placeholder="검색어를 입력해주세요" />
                </label>
                <div class="search_btn" id="main-search-btn">
                    <img src="/resources/homepage/center/img/search.svg" alt="" />
                </div>
            </div>
        </form>

        <ul class="quick_menu">
            <li onclick="location.href='/${homepage.context_path}/intro/search/loan/history.do?menu_idx=75'">
                <img src="/resources/homepage/center/img/short1.gif" alt="" />
                <div>대출조회</div>
            </li>
            <li onclick="location.href='/${homepage.context_path}/intro/search/hope/req.do?menu_idx=19'">
                <img src="/resources/homepage/center/img/short2.gif" alt="" />
                <div>희망도서</div>
            </li>
            <li onclick="location.href='/${homepage.context_path}/module/teach/index.do?searchCate1=16&menu_idx=32'">
                <img src="/resources/homepage/center/img/short3.gif" alt="" />
                <div>행사신청</div>
            </li>
            <li onclick="location.href='/${homepage.context_path}/module/teach/index.do?searchCate1=17&menu_idx=34'">
                <img src="/resources/homepage/center/img/short4.gif" alt="" />
                <div>강좌신청</div>
            </li>
            <li onclick="location.href='/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36'">
                <img src="/resources/homepage/center/img/short5.gif" alt="" />
                <div>도서관일정</div>
            </li>
            <li onclick="location.href='/${homepage.context_path}/html.do?menu_idx=49'">
                <img src="/resources/homepage/center/img/short6.gif" alt="" />
                <div>수영강습안내</div>
            </li>
        </ul>

        <div class="pagination">
            <div class="indicator active_indicator"></div>
            <div class="indicator"></div>
            <div class="indicator"></div>
        </div>
        <div class="information_area">
            <div class="left_area" id="holiday-box">

            </div>
            <div class="right_area">
                <img src="/resources/homepage/center/img/stop.svg" alt="정지버튼" class="notice_autoplay" role="button" />
                <div class="swiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${newsList}" var="i" varStatus="status">
                            <div class="swiper-slide" onclick="location.href='${i.link_url}'">${i.news_name}</div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <div class="scroll">
            <div>SCROLL</div>
            <img src="/resources/homepage/center/img/scroll.svg" alt="" />
        </div>
    </section>

    <section class="section" id="section2">
        <div class="row_wrapper">
            <div class="board">
                <div class="board_title">Notice & Event lecture</div>
                <div class="board_index_wrapper">
                    <ul class="board_index">
                        <li id="noticeList">공지사항</li>
                        <li id="eventList">행사신청</li>
                        <li id="teachList">수강신청</li>
                    </ul>
                    <div class="board_more"></div>
                </div>
                <div class="noticeList">
                    <ul class="board_list">
                        <!-- TODO noticeListTopNotice, noticeList null처리-->
                        <c:if test="${fn:length(noticeList) < 1}">
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/new.svg" alt="" />
                                    <div>등록된 공지사항이 없습니다.</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div></div>
                                    <div></div>
                                </div>
                            </li>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" begin='0' end='1'>
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/fix_new.svg" alt="" />
                                    <div>${i.title}</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
                                    <div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
                                </div>
                            </li>
                        </c:forEach>
                        <c:forEach var="i" varStatus="status" items="${noticeList}" begin='0' end='2'>
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/new.svg" alt="" />
                                    <div>${i.title}</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
                                    <div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="eventList" style="display:none;">
                    <ul class="board_list">
                        <!-- TODO noticeListTopNotice, noticeList null처리-->
                        <c:if test="${fn:length(noticeList) < 1}">
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/new.svg" alt="" />
                                    <div>등록된 행사가 없습니다.</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div></div>
                                    <div></div>
                                </div>
                            </li>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${noticeListTopNotice}" begin='0' end='1'>
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/fix_new.svg" alt="" />
                                    <div>${i.title}</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
                                    <div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
                                </div>
                            </li>
                        </c:forEach>
                        <c:forEach var="i" varStatus="status" items="${noticeList}" begin='0' end='2'>
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/new.svg" alt="" />
                                    <div>${i.title}</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div><fmt:formatDate value="${i.add_date}" pattern="dd"/></div>
                                    <div><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM"/></div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="teachList" style="display:none;">
                    <ul class="board_list">
                        <!-- TODO teachList null처리-->
                        <c:if test="${fn:length(teachList) < 1}">
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/new.svg" alt="" />
                                    <div>등록된 강좌가 없습니다.</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div></div>
                                    <div></div>
                                </div>
                            </li>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${teachList}" begin='0' end='4'>
                            <li class="board_list_item">
                                <div class="board_list_item_title">
                                    <img src="/resources/homepage/center/img/new.svg" alt="" />
                                    <div>${i.teach_name}</div>
                                </div>
                                <div class="board_list_item_date">
                                    <div>${fn:substring(i.start_date,8,10)}</div>
                                    <div>${fn:substring(i.start_date,0,4)}.${fn:substring(i.start_date,5,7)}</div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="popup">
                <div class="popup_en">POPUPZONE</div>
                <div class="popup_kr">팝업존</div>
                <div class="popup_swiper">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <c:choose>
                                <c:when test="${fn:length(popupZoneList) > 0}">
                                    <c:forEach var="i" items="${popupZoneList}">
                                        <div class="swiper-slide">
                                            <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.popup_zone_name}" />
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="swiper-slide">
                                        <!-- TODO 팝업존 no data 처리 -->
                                        <img src="/resources/homepage/center/img/dummy.svg" alt="" />
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="swiper-pagination"></div>
                    <div class="swiper_action_wrapper">
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                        <img src="/resources/homepage/center/img/popup_stop.svg" alt="정지버튼" class="popup_autoplay" role="button" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section" id="section3">
        <div class="book_information_title">BOOK INFORMATION</div>
        <div class="book_information_menu">
            <ul class="book_information_menu_list">
                <li class="book_information_item" id="librarian">사서추천도서</li>
                <li class="book_information_item" id="bestBook">대출베스트</li>
                <li class="book_information_item" id="newBook">신착도서</li>
            </ul>
            <img class="book_more" src="/resources/homepage/center/img/plus.svg" alt="더보기" />
        </div>

        <div class="librarian">
            <div class="swiper_wrapper">
                <div class="book_information_swiper">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <!-- TODO 사서추천도서 no data 처리 -->
                            <c:if test="${fn:length(bookList1) < 1}">
                                <div class="swiper-slide">
                                    <div>
                                        <div class="book_title"></div>
                                        <div class="book_writer"></div>
                                        <div class="book_year"></div>
                                    </div>
                                    <img src="/resources/common/img/noimg-gall.png" alt="" />
                                </div>
                            </c:if>
                            <c:forEach var="i" varStatus="status" items="${bookList1}">
                                <div class="swiper-slide">
                                    <div>
                                        <div class="book_title">${i.title}</div>
                                        <div class="book_writer">${i.imsi_v_3}</div>
                                        <div class="book_year">${i.imsi_v_4}ㆍ${i.imsi_v_2}</div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${i.preview_img ne null}">
                                            <c:choose>
                                                <c:when test="${fn:contains(i.preview_img, 'http')}">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                            <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="swiper_action_wrapper">
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                        <img src="/resources/homepage/center/img/book_information_stop.svg" alt="정지버튼" class="book_autoplay" role="button" />
                        <div class="progress_container">
                            <div class="progress"></div>
                        </div>
                    </div>
                </div>
                <div class="book_list swiper">
                    <div class="swiper-wrapper">
                        <!-- TODO 사서추천도서 no data 처리 -->
                        <c:if test="${fn:length(bookList1) < 1}">
                            <div class="swiper-slide">
                                <img src="/resources/common/img/noimg-gall.png" alt="" />
                            </div>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${bookList1}">
                            <div class="swiper-slide">
                                <c:choose>
                                    <c:when test="${i.preview_img ne null}">
                                        <c:choose>
                                            <c:when test="${fn:contains(i.preview_img, 'http')}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                        <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="bestBook" style="display:none;">
            <div class="swiper_wrapper">
                <div class="book_information_swiper">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <c:if test="${fn:length(bestBookList) < 1}">
                                <!-- TODO 인기도서 no data 처리 -->
                                <div>
                                    <div class="book_title"></div>
                                    <div class="book_writer"></div>
                                    <div class="book_year"></div>
                                </div>
                                <img src="/resources/common/img/noImg2.png" alt="등록된 인기도서가 없습니다."/>
                            </c:if>
                            <c:forEach var="i" varStatus="status" items="${bestBookList}">
                                <div class="swiper-slide">
                                    <div>
                                        <div class="book_title">${i.TITLE}</div>
                                        <div class="book_writer">${i.AUTHOR}</div>
                                        <div class="book_year">${i.PUBLISHER}ㆍ${i.PUBLISH_YEAR}</div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
                                            <img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
                                        </c:when>
                                        <c:when test="${not empty i.aladin or not empty i.aladin.cover}">
                                            <img src="${i.aladin.cover}" alt="${i.TITLE} 상세보기"/>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${i.imageUrl}" alt="${i.TITLE} 상세보기"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="swiper_action_wrapper">
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                        <img src="/resources/homepage/center/img/book_information_stop.svg" alt="정지버튼" class="book_autoplay" role="button" />
                        <div class="progress_container">
                            <div class="progress"></div>
                        </div>
                    </div>
                </div>
                <div class="book_list swiper">
                    <div class="swiper-wrapper">
                        <c:if test="${fn:length(bestBookList) < 1}">
                            <div class="swiper-slide">
                                <img src="/resources/common/img/noImg2.png" alt="등록된 인기도서가 없습니다."/>
                            </div>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${bestBookList}">
                            <div class="swiper-slide">
                                <c:choose>
                                    <c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
                                        <img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
                                    </c:when>
                                    <c:when test="${not empty i.aladin or not empty i.aladin.cover}">
                                        <img src="${i.aladin.cover}" alt="${i.TITLE} 상세보기"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${i.imageUrl}" alt="${i.TITLE} 상세보기"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <div class="newBook" style="display:none;">
            <div class="swiper_wrapper">
                <div class="book_information_swiper">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <c:if test="${fn:length(newBookList) < 1}">
                                <!-- TODO null처리 -->
                                <div>
                                    <div class="book_title"></div>
                                    <div class="book_writer"></div>
                                    <div class="book_year"></div>
                                </div>
                                <img src="/resources/common/img/noImg2.png" alt="등록된 신착도서가 없습니다."/>
                            </c:if>
                            <c:forEach var="i" varStatus="status" items="${newBookList}">
                                <div class="swiper-slide">
                                    <div>
                                        <div class="book_title">${i.TITLE_INFO}</div>
                                        <div class="book_writer">${i.AUTHOR}</div>
                                        <div class="book_year">${i.PUBLISHER}ㆍ${i.PUBLISH_YEAR}</div>
                                    </div>
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
                            </c:forEach>
                        </div>
                    </div>
                    <div class="swiper_action_wrapper">
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                        <img src="/resources/homepage/center/img/book_information_stop.svg" alt="정지버튼" class="book_autoplay" role="button" />
                        <div class="progress_container">
                            <div class="progress"></div>
                        </div>
                    </div>
                </div>
                <div class="book_list swiper">
                    <div class="swiper-wrapper">
                        <!-- TODO null처리 -->
                        <c:if test="${fn:length(newBookList) < 1}">
                            <div class="swiper-slide">
                                <img src="/resources/common/img/noImg2.png" alt="등록된 신착도서가 없습니다."/>
                            </div>
                        </c:if>
                        <c:forEach var="i" varStatus="status" items="${newBookList}">
                            <div class="swiper-slide">
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
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="section" id="section4">
        <div class="wrapper">
            <div class="schedule_wrapper" id="calendar-box">

            </div>
            <ul class="link_list">
                <!-- TODO 링크 없는부분 메뉴 추가필요-->
                <li>
                    <div class="link_text">
                        <div>스마트한 독서생활이 시작되는 곳</div>
                        <div>스마트도서관</div>
                    </div>
                    <img src="/resources/homepage/center/img/link_arrow.svg" alt="" />
                </li>
                <li onclick="location.href='https://books.nl.go.kr/PU/contents/P20202000000.do'">
                    <div class="link_text">
                        <div>협력형 온라인 지식정보서비스</div>
                        <div>책이음</div>
                    </div>
                    <img src="/resources/homepage/center/img/link_arrow.svg" alt="" />
                </li>
                <li onclick="location.href='https://library.daegu.go.kr/elib/index.do'">
                    <div class="link_text">
                        <div>장애인 무료 택배 서비스</div>
                        <div>대구전자도서관</div>
                    </div>
                    <img src="/resources/homepage/center/img/link_arrow.svg" alt="" />
                </li>
                <li onclick="location.href='https://books.nl.go.kr/PU/contents/P10206000000.do'">
                    <div class="link_text">
                        <div>국가상호대차 서비스</div>
                        <div>책바다</div>
                    </div>
                    <img src="/resources/homepage/center/img/link_arrow.svg" alt="" />
                </li>
                <li>
                    <div class="link_text">
                        <div>협력형 온라인 지식정보서비스</div>
                        <div>사서에게물어보세요</div>
                    </div>
                    <img src="/resources/homepage/center/img/link_arrow.svg" alt="" />
                </li>
            </ul>
        </div>
    </section>

    <div class="section fp-auto-height">
        <div class="badge_swiper">
            <div class="badge_action">
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
                <img src="/resources/homepage/center/img/more.svg" alt="더보기" class="more" role="button" />
                <img src="/resources/homepage/center/img/popup_stop.svg" alt="정지버튼" class="badge_autoplay" role="button" />
            </div>

            <div class="swiper">
                <div class="swiper-wrapper">
                    <c:forEach var="i" varStatus="status" items="${bannerList}">
                        <div class="swiper-slide">
                            <img src="/data/banner/${i.homepage_id}/${i.server_file_name}" alt="${i.banner_name}"/>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

<tiles:insertAttribute name="footer" />