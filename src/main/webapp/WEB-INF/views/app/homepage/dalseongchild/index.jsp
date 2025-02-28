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
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
  $(function () {
    $('#homeup').click(function () {
      $('body,html').animate({
        scrollTop: 0
      }, 800);
      return false;
    });

    // 팝업 관련 코드 START
    $('.close-btn').on('click', function () {
      var $this = $(this);
      var checkInput = $this.parent().find('input[data-day="' + $this.data('day') + '"]');
      var popupId = checkInput.val();
      if (checkInput.prop('checked')) {
        var todayDate = new Date();
        todayDate = new Date( parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
        if ($this.data('day') == 7) {
          todayDate.setDate(todayDate.getDate() + 7);
        }
        document.cookie = popupId + "=no"
            + "; path=/; expires="
            + todayDate.toGMTString() + ";";
      }

      $('div#' + popupId).hide();
    });

    $('input[id*=pop]').on('click', function (e) {
      e.preventDefault();
      $(this).prop('checked', true);
      $(this).parent('div').next('a').data('day', $(this).data('day'));
      $(this).parent('div').next('a').click();
    });

    $('#popupLayer > div').each(function (i, v) {
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

    $('#main-search-btn').on('click', function () {
      if ($('input#search_text_1').val() == '') {
        alert('검색어를 입력하세요.');
        $('input#search_text_1').focus();
        return false;
      }
      $('#mainSearchForm').submit();
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
                <p class="close"><input type="checkbox" name=""/> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/common/img/close_popup_btn.png" alt="닫기"/></a></p>
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

    <div id="fullpage">
        <!-- main0 -->
        <div class="section" id="main0">
            <div class="swiper_main">
                <div class="main-slide1"></div>
                <div class="main-slide2"></div>
            </div>
            <div class="main-visual">
                <div class="main_txtarea">
                    <span>미래를 품고 꿈꾸는 공간</span>
                    <h1>달성어린이숲도서관</h1>
                </div>
                <!-- main_search -->
                <div class="search-area" id="main_search">
                    <form id="mainSearchForm" action="/bukgs/intro/search/index.do">
                        <input type="hidden" name="menu_idx" value="9"/>
                        <input type="hidden" name="booktype" value="BOOKANDNONBOOK"/>
                        <input type="hidden" name="_csrf" value="1fb5d19a-e79f-40b9-b9a7-330460effb42"/>
                        <fieldset>
                            <legend class="blind">통합검색</legend>
                            <div class="main-box">
                                <select id="search_type" name="search_type" class="search_type">
                                    <option value="L_TITLE">도서명</option>
                                    <option value="L_AUTHOR">저자</option>
                                    <option value="L_PUBLISHER">발행처</option>
                                    <option value="L_KEYWORD">키워드</option>
                                </select>
                                <div class="box1">
                                    <div class="box2">
                                        <label for="search_text_1" class="blind">통합자료검색</label>
                                        <input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode: active"/>
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
                            <a href="#this" class="q01">
                                <span><img src="/resources/homepage/dalseongchild/img/common/q01.svg" alt="자료이용안내"/>자료이용안내</span>
                            </a>
                        </li>
                        <li>
                            <a href="#this" class="q02">
                                <span><img src="/resources/homepage/dalseongchild/img/common/q02.svg" alt="평생학습프로그램"/>평생학습프로그램</span>
                            </a>
                        </li>
                        <li>
                            <a href="#this" class="q03">
                                <span><img src="/resources/homepage/dalseongchild/img/common/q03.svg" alt="문화행사신청"/>문화행사신청</span>
                            </a>
                        </li>
                        <li>
                            <a href="#this" class="q04">
                                <span><img src="/resources/homepage/dalseongchild/img/common/q05.svg" alt="희망도서신청"/>희망도서신청</span>
                            </a>
                        </li>
                        <li>
                            <a href="#this" class="q05">
                                <span><img src="/resources/homepage/dalseongchild/img/common/q06.svg" alt="자주묻는질문"/>자주묻는질문</span>
                            </a>
                        </li>
                        <li>
                            <a href="#this" class="q06" target="_blank">
                                <span><img src="/resources/homepage/dalseongchild/img/common/q07.svg" alt="찾아오시는길"/>찾아오시는길</span>
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
                                    <c:if test="${fn:length(popupZoneList) > 1}">
                                        <img src="/resources/homepage/dalseongchild/img/common/stop.svg" alt="정지버튼" class="popup_autoplay" role="button"/>
                                    </c:if>
                                    <div class="swiper-button-next"></div>
                                </div>
                            </div>
                        </div>
                        <div class="swiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <img src="/resources/homepage/dalseongchild/img/common/Rectangle6.png" alt="${i.popup_zone_name}"/>
                                </div>
                                <div class="swiper-slide">
                                    <img src="/resources/homepage/dalseongchild/img/common/Rectangle6.png" alt="${i.popup_zone_name}"/>
                                </div>
                                <div class="swiper-slide">
                                    <img src="/resources/homepage/dalseongchild/img/common/Rectangle6.png" alt="${i.popup_zone_name}"/>
                                </div>

                                <!-- 팝업 예외 처리 -->
                                <!-- <div class="swiper-slide">
                                            <img src="/resources/common/img/noImg2.png" alt="" />
                                        </div>-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="notice-box tabS">
                    <ul class="tabMenuS">
                        <li class="on"><a href="#tab1" data-link="/bukgs/board/index.do?menu_idx=35&manage_idx=699" class="t-tabs">공지사항</a></li>
                        <li><a href="#tab2" data-link="/bukgs/module/teach/index.do?menu_idx=32" class="t-tabs">프로그램접수</a></li>
                        <a href="/bukgs/board/index.do?menu_idx=35&manage_idx=699" class="btn-more2 more-more">더보기</a>
                    </ul>

                    <div class="news con" data-tab="tab1">
                        <div class="box">
                            <ul>
                                <li class="important">
                                    <a href="/bukgs/board/view.do?menu_idx=35&manage_idx=699&board_idx=525227">
                                        <span class="time"><b>29</b> <em>2024.11</em></span>
                                        <em>[채용] (재)행복북구문화재단 도서관운영본부 기간제 근로자 채용 공고</em>
                                    </a>
                                </li>

                                <li class="important">
                                    <a href="/bukgs/board/view.do?menu_idx=35&manage_idx=699&board_idx=525226">
                                        <span class="time"><b>29</b> <em>2024.11</em></span>
                                        <em>[채용] (재)행복북구문화재단 구수산도서관 개관시간 연장지원 사업 기간제 근로자 채용 공고</em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/board/view.do?menu_idx=35&manage_idx=699&board_idx=525097">
                                        <span class="time"><b>29</b> <em>2024.11</em></span>
                                        <em>[안내] 구수산도서관 12월 영화상영 안내</em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/board/view.do?menu_idx=35&manage_idx=699&board_idx=525084">
                                        <span class="time"><b>28</b> <em>2024.11</em></span>
                                        <em>[안내] 2024년 &lt음악이 흐르는 도서관&gt 음악적 재능나눔형 프로그램 봉사자 모집</em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/board/view.do?menu_idx=35&manage_idx=699&board_idx=525030">
                                        <span class="time"><b>28</b> <em>2024.11</em></span>
                                        <em>[안내] 2024년 구수산도서관 &lt12월 연말 행사&gt 안내</em>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="news con" data-tab="tab2" style="display: none">
                        <div class="box">
                            <ul>
                                <li>
                                    <a href="/bukgs/module/teach/detail.do?menu_idx=95&searchCate1=16&group_idx=174&category_idx=0&teach_idx=21461&homepage_id=h46">
                                        <span class="time"><b>21</b> <em>2024.11</em></span>
                                        <em>
                                            <가족과 함께 해피 크리스마스>
                                        </em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/module/teach/detail.do?menu_idx=95&searchCate1=16&group_idx=174&category_idx=0&teach_idx=21462&homepage_id=h46">
                                        <span class="time"><b>26</b> <em>2024.11</em></span>
                                        <em>
                                            <김재인 철학자와의 만남>
                                        </em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/module/teach/detail.do?menu_idx=95&searchCate1=16&group_idx=174&category_idx=0&teach_idx=21463&homepage_id=h46">
                                        <span class="time"><b>28</b> <em>2024.11</em></span>
                                        <em>
                                            <명지쌤의 행복 Talk 콘서트>
                                        </em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/module/teach/detail.do?menu_idx=95&searchCate1=16&group_idx=173&category_idx=0&teach_idx=21215&homepage_id=h46">
                                        <span class="time"><b>26</b> <em>2024.11</em></span>
                                        <em>명지현과 함께하는 심리 상담소</em>
                                    </a>
                                </li>

                                <li>
                                    <a href="/bukgs/module/teach/detail.do?menu_idx=95&searchCate1=29&group_idx=132&category_idx=0&teach_idx=16145&homepage_id=h46">
                                        <span class="time"><b>29</b> <em>2024.11</em></span>
                                        <em>Winter Season Theme</em>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="holiday-box">
                <div class="main-box">
                    <div class="h_img_box"><img src="/resources/homepage/dalseongchild/img/common/holy_day.svg" alt="휴관일"/></div>
                    <div class="title">
                        <p class="holy_txt">우리 도서관 <span class="holy_bold">12월 휴관일</span>을 확인하세요!</p>
                    </div>
                    <div id="holiday-box" class="holiday-section"><span>1</span><span>2</span></div>
                </div>
            </div>
        </div>
        <!-- //main1 -->

        <!-- main3 -->
        <div class="section" id="main3">
            <div class="main-section wid1450">
                <div class="book-box tabS">
                    <ul class="tabMenuS">
                        <li class="on"><a href="#tab1" class="t-tabs" data-link="/bukgs/board/index.do?menu_idx=85&manage_idx=697">추천도서</a></li>
                        <li><a href="#tab2" class="t-tabs" data-link="/bukgs/intro/search/newBook/index.do?menu_idx=10">신착도서</a></li>
                    </ul>
                    <a href="/bukgs/board/index.do?menu_idx=85&manage_idx=697" class="btn-more2 more-more">더보기</a>

                    <div class="box con" data-tab="tab1">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 1"/></a>
                                    <div class="hover-text">Book 1</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 2"/></a>
                                    <div class="hover-text">Book 2</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 3"/></a>
                                    <div class="hover-text">Book 3</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 4"/></a>
                                    <div class="hover-text">Book 4</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 5"/></a>
                                    <div class="hover-text">Book 5</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 6"/></a>
                                    <div class="hover-text">Book 6</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 7"/></a>
                                    <div class="hover-text">Book 7</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 8"/></a>
                                    <div class="hover-text">Book 8</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="box con" data-tab="tab2" style="display: none">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 1"/></a>
                                    <div class="hover-text">Book 1</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 2"/></a>
                                    <div class="hover-text">Book 2</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 3"/></a>
                                    <div class="hover-text">Book 3</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 4"/></a>
                                    <div class="hover-text">Book 4</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 5"/></a>
                                    <div class="hover-text">Book 5</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 6"/></a>
                                    <div class="hover-text">Book 6</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 7"/></a>
                                    <div class="hover-text">Book 7</div>
                                </div>
                                <div class="swiper-slide">
                                    <a href="#this"><img src="/resources/homepage/dalseongchild/img/common/book_noimg.png" alt="Book 8"/></a>
                                    <div class="hover-text">Book 8</div>
                                </div>
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
                                    <a class="prev" href="#prev"><img src="/resources/homepage/dalseongchild/img/common/left.svg" alt="이전"/><span class="blind">이전</span></a>
                                    <a class="next" href="#next"><img src="/resources/homepage/dalseongchild/img/common/right.svg" alt="다음"/><span class="blind">다음</span></a>
                                </div>
                            </div>
                            <div class="banner-box4">
                                <ul class="banner-roll">
                                    <li>
										<span>
											<a href="http://www.daegu.go.kr/index.do" target="_blank">
												<img src="/resources/homepage/dalseongchild/img/common/Rectangle11.png" alt="대구시청"/>
											</a>
										</span>
                                    </li>
                                    <li>
										<span>
											<a href="https://www.buk.daegu.kr/index.do" target="_blank">
												<img src="/resources/homepage/dalseongchild/img/common/Rectangle12.png" alt="북구청"/>
											</a>
										</span>
                                    </li>
                                    <li>
                                        <span>
                                            <a href="http://library.daegu.go.kr/dgportal/index.do" target="_blank">
                                                <img src="/resources/homepage/dalseongchild/img/common/Rectangle13.png" alt="대구지역공공도서관통합검색"/>
                                            </a>
                                        </span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.nanet.go.kr/main.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle14.png" alt="국회도서관"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.nl.go.kr" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle15.png" alt="국립중앙도서관"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.nlcy.go.kr/NLCY/main/index.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle16.png" alt="국립어린이청소년도서관"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.moe.go.kr/main.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle11.png" alt="교육부"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.mcst.go.kr/kor/main.jsp" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle12.png" alt="문화체육관광부"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://books.nl.go.kr" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle13.png" alt="책이음서비스"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://books.nl.go.kr" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle14.png" alt="책바다"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://cn.nld.go.kr/index.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle15.png" alt="책나래"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.nl.go.kr/NL/contents/N30502000000.do" target="_blank">
														<img src="/resources/homepage/dalseongchild/img/common/Rectangle16.png" alt="사서에게물어보세요"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.keris.or.kr/main/main.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle11.png" alt="한국교육학술정보원"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.data.go.kr/index.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle12.png" alt="공공데이터포털"/></a
                                                    ></span>
                                    </li>
                                    <li>
												<span>
													<a href="https://www.nl.go.kr/kolisnet/index.do" target="_blank"> <img src="/resources/homepage/dalseongchild/img/common/Rectangle13.png" alt="코리스넷"/></a
                                                    ></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- //main3 -->

        <div class="section fp-auto-height footer_area" id="foot_section">
            <tiles:insertAttribute name="footer" />
        </div>

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
      afterLoad: function (origin, destination, direction) {
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
      afterResponsive: function (isResponsive) {
      },
    });
  }

  fullPage();

  // 모바일일 경우 fullpage 미사용
  if ($(window).width() < 1025) {
    if ($('#fullpage').hasClass('fp-destroyed')) {
    } else {
      fullpage_api.destroy('all');
    }
  } else {
    fullPage();
  }

  // 리사이즈 될때 모바일 화면에서 fullpage 미사용
  $(window).resize(function (e) {
    if ($(window).width() < 1025) {
      if ($('#fullpage').hasClass('fp-destroyed')) {
      } else {
        fullpage_api.destroy('all');
      }
    } else {
      fullPage();
    }
  });
</script>
<script>
  var mySwiper = new Swiper('.mySwiper', {
    spaceBetween: 30,
    centeredSlides: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
    },
    effect: 'fade',
    loop: true,
    pagination: {
      el: '.swiper-pagination',
      type: 'fraction',
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
  });
  $('.start').on('click', function () {
    mySwiper.autoplay.start();
    return false;
  });
  $('.stop').on('click', function () {
    mySwiper.autoplay.stop();
    return false;
  });
</script>
