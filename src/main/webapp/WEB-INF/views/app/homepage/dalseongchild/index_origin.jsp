<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Random" %>
<%
    Random rnd = new Random();
    int listNum1 = rnd.nextInt(10);
    int listNum2 = 0;
    int listNum3 = 0;
    do {
        listNum2 = rnd.nextInt(10);
    } while (listNum1 == listNum2);
    do {
        listNum3 = rnd.nextInt(10);
    } while (listNum1 == listNum3 || listNum2 == listNum3);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="listNum3" value="<%=listNum3%>"></c:set>
<tiles:insertAttribute name="header" />

<script type="text/javascript">
    $(function() {
        $('#homeup').click(function() {
            $('body,html').animate({
                scrollTop: 0
            }, 800);
            return false;
        });

        // 팝업 관련 코드 START
        $('.close-btn').on('click', function() {
            var $this = $(this);
            var checkInput = $this.parent().find('input[data-day="' + $this.data('day') + '"]');
            var popupId = checkInput.val();
            if (checkInput.prop('checked')) {
                var todayDate = new Date();
                todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
                if ($this.data('day') == 7) {
                    todayDate.setDate(todayDate.getDate() + 7);
                }
                document.cookie = popupId + "=no" +
                    "; path=/; expires=" +
                    todayDate.toGMTString() + ";";
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
                    if ((endOfCookie = document.cookie.indexOf(";", y)) == -1)
                        endOfCookie = document.cookie.length;
                    result = unescape(document.cookie.substring(y, endOfCookie));
                }
                x = document.cookie.indexOf(" ", x) + 1;
                if (x == 0)
                    break;
            }

            if (result != 'no') {
                if (window.innerWidth < $(v).width()) {
                    $(v).css('width', 'auto');
                }
                $(v).show();
            }
        });
        // 팝업 관련 코드 END

        $('div#calendar-box').load('calendar3.do');
        $('div#holiday-box').load('calendar5.do?homepage_id=${fn:escapeXml(homepage.homepage_id)}');
        $('ul.book_photo').eq(1).load('newBook.do');
        $('ul.bestBookUl').load('bestBook.do');

        $('#main-search-btn').on('click', function() {
            if ($('input#searchInput').val() == '') {
                alert('검색어를 입력하세요.');
                $('input#searchInput').focus();
                return false;
            }
            var searchType = $('#searchSelect option:selected').val();
            var searchText = $('#searchInput').val();

            $('input#search_type').val(searchType);
            $('input#search_text_1').attr('name',searchType);
            $('input#search_text_1').val(searchText);
            $('#mainSearchForm').submit();
        });

        //신착도서
        $('div.swiper-wrapper').eq(2).load('newBook.do');


        $('a.newWin').on('click', function() {
            window.open($(this).attr('href'), '_blank');
        });

    });

</script>
<div id="wrap" style="overflow: hidden;">
    <c:if test="${fn:length(popupZoneTopList) > 0}">
        <div class="popup_top">
            <div class="popup">
                <div class="pop_contents">
                    <div class="topPopZone">
                        <homepageTag:popupZoneTop popupZoneList="${popupZoneTopList}" />
                    </div>
                </div>
                <p class="close"><input type="checkbox" name="" /> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/common/img/close_popup_btn.png" alt="닫기" /></a></p>
            </div>
        </div>
    </c:if>

    <tiles:insertAttribute name="top" />
    <tiles:insertAttribute name="topMenu" />

    <div class="popupWrap main-section">
        <div id="popupLayer">
            <homepageTag:popup popupList="${popupList}" />
        </div>
    </div>

    <div id="fullpage">
        <!-- main0 -->
        <div class="section" id="main0">
            <div class="swiper_main">
                <div class="main-slide1">
                    <div class="img_wrapper"><img src="/resources/homepage/${homepage.context_path}/img/common/ob_01.png" alt="" /><img src="/resources/homepage/${homepage.context_path}/img/common/ob_01_02.png" alt="" /></div>
                </div>
                <div class="main-slide2">
                    <div class="img_wrapper_02"><img src="/resources/homepage/${homepage.context_path}/img/common/ob_02_02.png" alt="" /><img src="/resources/homepage/${homepage.context_path}/img/common/ob_02.png" alt="" /></div>
                </div>
            </div>
            <div class="main-visual">
                <div class="main_txtarea">
                    <span>미래를 품고 꿈꾸는 공간</span>
                    <h1>달성어린이숲도서관</h1>
                </div>
                <!-- main_search -->
                <div class="search-area" id="main_search">
                    <form id="mainSearchForm" method="get" action="/${homepage.context_path}/intro/search/index.do">
                        <input type="hidden" name="menu_idx" id="menu_idx" value="7" />
                        <input type="hidden" name="booktype" id="booktype" value="BOOKANDNONBOOK" />
                        <input type="hidden" name="search_type" id="search_type" value="">
                        <input type="hidden" name="title" id="search_text_1" value="">
                        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
                        <fieldset>
                            <legend class="blind">통합검색</legend>
                            <div class="main-box">
                                <select id="searchSelect" name="search_type" class="search_type">
                                    <option value="title">서명</option>
                                    <option value="author">저자</option>
                                    <option value="publer">발행자</option>
                                    <option value="keyword">키워드</option>
                                </select>
                                <div class="box1">
                                    <div class="box2">
                                        <label for="searchInput" class="blind">통합자료검색</label>
                                        <input id="searchInput" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode: active" />
                                    </div>
                                </div>
                                <button id="main-search-btn">검색하기</button>
                            </div>
                        </fieldset>
                    </form>
                </div>
                <!-- //Main_search -->
                <div class="mIcon">
                    <ul>
                        <li>
                            <a href="/${homepage.context_path}/html.do?menu_idx=19" class="q01">
                                <span><img src="/resources/homepage/${homepage.context_path}/img/common/q01.png" alt="자료이용안내" />자료이용안내</span>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/html.do?menu_idx=29" class="q02">
                                <span><img src="/resources/homepage/${homepage.context_path}/img/common/q02.png" alt="평생학습프로그램" />평생학습프로그램</span>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/module/teach/index.do?menu_idx=26&searchCate1=16" class="q03">
                                <span><img src="/resources/homepage/${homepage.context_path}/img/common/q03.png" alt="문화행사신청" />문화행사신청</span>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/intro/search/hope/req.do?menu_idx=15" class="q04">
                                <span><img src="/resources/homepage/${homepage.context_path}/img/common/q04.png" alt="희망도서신청" />희망도서신청</span>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=1264" class="q05">
                                <span><img src="/resources/homepage/${homepage.context_path}/img/common/q05.png" alt="자주묻는질문" />자주묻는질문</span>
                            </a>
                        </li>
                        <li>
                            <a href="/${homepage.context_path}/html.do?menu_idx=50" class="q06" target="_blank">
                                <span><img src="/resources/homepage/${homepage.context_path}/img/common/q06.png" alt="찾아오시는길" />찾아오시는길</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="main_scroll">
                    <div class="main_scroll_wp_white">scroll down</div>
                </div>
            </div>
        </div>
        <!-- //main0 -->

        <!-- section1 -->
        <div class="section" id="main1">
            <div class="main-section">
                <div class="popup">
                    <div class="popup_swiper">
                        <div class="title_wrap">
                            <div class="tit_wrapper">
                                <div class="popup_kr">팝업존</div>
                            </div>
                            <div class="pop_wrapper">
                                <div class="swiper-pagination"></div>
                                <div class="swiper_action_wrapper">
                                    <div class="swiper-button-prev"></div>

                                    <img src="/resources/homepage/${homepage.context_path}/img/common/stop.svg" alt="정지 버튼" class="popup_autoplay stop" role="button" />

                                    <div class="swiper-button-next"></div>
                                </div>
                            </div>
                        </div>
                        <div class="swiper mySwiper">
                            <div class="swiper-wrapper">
                                <c:choose>
                                    <c:when test="${fn:length(popupZoneList) > 0}">
                                        <c:forEach var="i" items="${popupZoneList}">
                                            <div class="swiper-slide">
                                                <a href="${i.link_url}" target="_blank">
                                                    <img src="/data/popupZone/${i.homepage_id}/${i.server_file_name}" alt="${i.alt_text}" />
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="swiper-slide">
                                            <img src="/resources/common/img/noImg2.png" alt="" />
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="notice-box tabS">
                    <ul class="tabMenuS">
                        <li class="on"><a href="#tab1" data-link="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=1263" class="t-tabs">공지사항</a></li>
                        <li><a href="#tab2" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=26&searchCate1=16" class="t-tabs">프로그램접수</a></li>
                        <a href="/${homepage.context_path}/board/index.do?menu_idx=32&manage_idx=1263" class="btn-more2 more-more">더보기</a>
                    </ul>

                    <div class="news con" data-tab="tab1">
                        <div class="box">
                            <ul>
                                <c:if test="${fn:length(noticeList) < 1 && fn:length(noticeListTopNotice) < 1}">
                                    <li class="board_list_item">
                                        <div class="board_list_item_title">
                                            <div>등록된 공지사항이 없습니다.</div>
                                        </div>
                                        <div class="board_list_item_date">
                                            <div></div>
                                            <div></div>
                                        </div>
                                    </li>
                                </c:if>



                                <c:forEach items="${noticeListTopNotice}" var="i" varStatus="status" begin='0' end='1'>
                                    <li class="important">
                                        <a href="/${homepage.context_path}/board/view.do?menu_idx=32&manage_idx=1263&board_idx=${i.board_idx}">
                                            <span class="time"><b><fmt:formatDate value="${i.add_date}" pattern="dd" /></b> <em><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM" /></em></span>
                                            <em class="notice_txt">${i.title}</em>
                                        </a>
                                    </li>
                                </c:forEach>
                                <c:forEach items="${noticeList}" var="i" varStatus="status" begin='0' end='2'>
                                    <li>
                                        <a href="/${homepage.context_path}/board/view.do?menu_idx=32&manage_idx=1263&board_idx=${i.board_idx}">
                                            <span class="time"><b><fmt:formatDate value="${i.add_date}" pattern="dd" /></b> <em><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM" /></em></span>
                                            <em class="notice_txt">${i.title}</em>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <div class="news con" data-tab="tab2" style="display: none">
                        <div class="box">
                            <ul>
                                <c:if test="${fn:length(teachList) < 1}">
                                    <li class="board_list_item">
                                        <div class="board_list_item_title">
                                            <div>등록된 행사가 없습니다.</div>
                                        </div>
                                        <div class="board_list_item_date">
                                            <div></div>
                                            <div></div>
                                        </div>
                                    </li>
                                </c:if>
                                <c:forEach var="i" varStatus="status" items="${teachList}" begin='0' end='4'>
                                    <li>
                                        <a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=26&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}">
                                            <c:set var="teachDate" value="${fn:split(i.start_date, '-')}"></c:set>
                                            <span class="time"><b>${teachDate[2]}</b> <em>${teachDate[0]}.${teachDate[1]}</em></span>
                                            <em class="notice_txt">${i.teach_name}</em>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="holiday-box">
                <div class="main-box" id="holiday-box">

                </div>
            </div>
        </div>
        <!-- //main1 -->

        <!-- main3 -->
        <div class="section" id="main3">
            <div class="main-section wid1450">
                <div class="book-box tabS">
                    <ul class="tabMenuS">
                        <li class="on"><a href="#tab1" class="t-tabs" data-link="/${homepage.context_path}/board/index.do?menu_idx=85&manage_idx=697">추천도서</a></li>
                        <li><a href="#tab2" class="t-tabs" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=9">신착도서</a></li>
                        <a href="/${homepage.context_path}/board/index.do?menu_idx=12&manage_idx=1270" class="btn-more2 more-more" id="moreLink">더보기</a>
                    </ul>

                    <div class="box con" data-tab="tab1">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <c:if test="${fn:length(bookList) < 1}">
                                    <li>등록된 데이터가 없습니다.</li>
                                </c:if>

                                <c:forEach items="${bookList}" var="i" varStatus="status">
                                    <div class="swiper-slide" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" style="cursor:pointer;">
                                        <c:choose>
                                            <c:when test="${i.preview_img ne null}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(i.preview_img, 'http')}">
                                                        <img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/book_noimg.png'"/>
                                                    </c:when>
                                                    <c:when test="${fn:contains(i.preview_img, 'noImg2')}">
                                                        <img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/book_noimg.png'"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/book_noimg.png'"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="hover-text">${i.title}</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <div class="box con" data-tab="tab2" style="display: none">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">

<%--                                <div class="swiper-slide">--%>
<%--                                    <a href="#this"><img src="/resources/homepage/${homepage.context_path}/img/common/book_noimg.png" alt="Book 1" /></a>--%>
<%--                                    <div class="hover-text">Book 1</div>--%>
<%--                                </div>--%>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="end"></div>

            <div class="banner-box">
                <div class="main-section">
                    <div class="main7_banner">
                        <div class="banner-wrap type4">
                            <div class="banner-t4">
                                <div class="control">
                                    <a class="prev" href="#prev"><img src="/resources/homepage/${homepage.context_path}/img/common/left.svg" alt="이전" /><span class="blind">이전</span></a>
                                    <a class="next" href="#next"><img src="/resources/homepage/${homepage.context_path}/img/common/right.svg" alt="다음" /><span class="blind">다음</span></a>
                                </div>
                            </div>
                            <div class="banner-box4">
                                <homepageTag:banner bannerList="${bannerList}"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section fp-auto-height footer_area" id="foot_section">
                <tiles:insertAttribute name="footer" />
            </div>
        </div>
        <!-- //main3 -->



    </div>
</div>

</body>

</html>


<script type="text/javascript">
    function fullPage() {
        var myFullpage = new fullpage('#fullpage', {
            anchors: ['firstPage', 'secondPage', '3rdPage'],
            navigation: true,
            showActiveTooltip: true,
            menu: '#menu',
            responsiveWidth: 1025,
            afterLoad: function(origin, destination, direction) {
                var cur_page = destination.index + 1;
                if (destination.index == 0) {
                    $('#header').addClass('background-white');
                    $('.Gnb').css('border-bottom', '0');
                    $('.Gnb').css('background', 'none');
                    $('.tnb').css('background', 'none');
                } else if (destination.index == 1) {
                    $('#header').removeClass('background-white');
                    $('.Gnb').css('border-bottom', '1px solid #e6e6e6');
                    $('.Gnb').css('background', '#fff');
                    $('.tnb').css('background', '#fff');
                } else if (destination.index == 2) {
                    $('#header').removeClass('background-white');
                    $('.Gnb').css('border-bottom', '1px solid #e6e6e6');
                    $('.Gnb').css('background', '#fff');
                    $('.tnb').css('background', '#fff');
                } else if (destination.index == 3) {
                    $('#header').removeClass('background-white');
                    $('.Gnb').css('border-bottom', '1px solid #e6e6e6');
                    $('.Gnb').css('background', '#fff');
                    $('.tnb').css('background', '#fff');
                } else {
                    $('#header').removeClass('background-white');
                    $('.Gnb').css('border-bottom', '1px solid #e6e6e6');
                    $('.Gnb').css('background', '#fff');
                    $('.tnb').css('background', '#fff');
                }
            },
            afterResponsive: function(isResponsive) {},
        });
    }

    fullPage();

    // 모바일일 경우 fullpage 미사용
    if ($(window).width() < 1025) {
        if ($('#fullpage').hasClass('fp-destroyed')) {} else {
            fullpage_api.destroy('all');
        }
    } else {
        fullPage();
    }

    // 리사이즈 될때 모바일 화면에서 fullpage 미사용
    $(window).resize(function(e) {
        if ($(window).width() < 1025) {
            if ($('#fullpage').hasClass('fp-destroyed')) {} else {
                fullpage_api.destroy('all');
            }
        } else {
            fullPage();
        }
    });

</script>
<script>
    $(document).ready(function() {
        if ($('.mySwiper').length === 0) return; // Swiper 요소가 없으면 실행하지 않음

        var mySwiper = new Swiper('.mySwiper', {
            spaceBetween: 30,
            centeredSlides: true,
            autoplay: {
                delay: 7000, // ✅ 자동 재생 간격 (7초)
                disableOnInteraction: false,
            },
            loop: true,
            speed: 1000, // ✅ 부드러운 전환 (1초)
            slidesPerView: 1, // ✅ 한 번에 하나의 슬라이드만 보이도록 설정
            pagination: {
                el: '.swiper-pagination',
                type: 'fraction',
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });

        console.log("🚀 Swiper 초기화 완료:", mySwiper); // Swiper 초기화 확인

        let isPlaying = true;

        $('.popup_autoplay').on('click', function() {
            console.log(`🎬 현재 자동재생 상태: ${isPlaying ? 'ON' : 'OFF'}`);

            if (isPlaying) {
                mySwiper.autoplay.stop();
                console.log('🔴 자동재생 멈춤');

                $(this).attr('src', '/resources/homepage/${homepage.context_path}/img/common/start.svg')
                    .attr('alt', '재생 버튼')
                    .removeClass('stop')
                    .addClass('start');
            } else {
                mySwiper.autoplay.start();
                console.log('🟢 자동재생 시작');

                $(this).attr('src', '/resources/homepage/${homepage.context_path}/img/common/stop.svg')
                    .attr('alt', '정지 버튼')
                    .removeClass('start')
                    .addClass('stop');
            }

            isPlaying = !isPlaying; // 상태 반전
        });
    });

    $(document).ready(function() {
        $('.swiper_main').slick({
            autoplay: true,
            autoplaySpeed: 7000,
            speed: 1500,
            arrows: false,
            dots: false,
            infinite: true,
            fade: true,
            cssEase: 'linear'
        });
    });

    var pageMain = (function() {
        var init, bindEvent;

        init = function() {
            bindEvent();
        };

        bindEvent = function() {
            // TAB
            $(document).on('click', '.tabMenuS a.t-tabs', function() {
                var target = this.getAttribute('href').replace('#', '');
                var $box = $(this).closest('.tabS');
                var moreUrl = $(this).data('link');

                $(this).closest('.tabMenuS').find('li').removeClass('on');
                $(this).parent('li').addClass('on');

                $box.find('.con').hide();
                $box.find('[data-tab="' + target + '"]').show();
                $box.find('.more-more').attr('href', moreUrl);
            });
        };

        return {
            init: init,
        };
    })();

    $(function() {
        // 팝업존(중앙도서관)
        if ($('.popZone ul').length > 0) {
            $('.popZone ul').bxSlider({
                mode: 'fade',
                auto: true,
                pager: true,
                controls: false,
                autoControls: false,
            });
        }

        // 전광판(중앙도서관)
        $('.panelZone ul').bxSlider({
            mode: 'vertical',
            pager: false,
            controls: false,
            pagerType: 'short',
            auto: true,
            autoControls: true,
            autoControlsCombine: true,
        });

        $('.movieContent ul').bxSlider({
            auto: true,
            pager: true,
            controls: false,
            autoControls: false,
        });
    });



    window.onload = function() {
        var swiper = new Swiper('#main3 .swiper-container', {
            slidesPerView: 6,
            spaceBetween: 32,
            autoplay: {
                delay: 3000,
            },
            loop: false,
            breakpoints: {
                1025: {
                    slidesPerView: 6,
                    spaceBetween: 32,
                },
                1024: {
                    slidesPerView: 6,
                    spaceBetween: 16,
                },
                820: {
                    slidesPerView: 6,
                    spaceBetween: 8,
                },
                768: {
                    slidesPerView: 3,
                    grid: {
                        rows: 2,
                        fill: 'row',
                    },
                    spaceBetween: 22,
                },
                480: {
                    slidesPerView: 3,
                    grid: {
                        rows: 2,
                        fill: 'row',
                    },
                    spaceBetween: 16,
                },
                320: {
                    slidesPerView: 3,
                    grid: {
                        rows: 2,
                        fill: 'row',
                    },
                    spaceBetween: 10,
                },
            },
        });
    };

</script>
