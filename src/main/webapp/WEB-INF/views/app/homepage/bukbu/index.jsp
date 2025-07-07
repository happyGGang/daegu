<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
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

<!-- 메인 -->
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/common/reset.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section1.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section2.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section3.css"/>
<link rel="stylesheet" href="/resources/homepage/${homepage.context_path}/css/index/section4.css"/>
<script src="/resources/homepage/${homepage.context_path}/plugin/jquery-3.7.1.min.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section1.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section2.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section3.js"></script>
<script src="/resources/homepage/${homepage.context_path}/js/index/section4.js"></script>

<c:set var="listNums" value="<%=listNums%>"/>
<tiles:insertAttribute name="header"/>

<script type="text/javascript">
  $(function () {
    $('div#holiday-area').load('calendar2.do');

    // 팝업 관련 코드 START
    $('.close-btn').on('click', function () {
      let $this = $(this);
      let checkInput = $this.parent().find('input[data-day="' + $this.data('day') + '"]');
      let popupId = checkInput.val();
      if (checkInput.prop('checked')) {
        let todayDate = new Date();
        todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
        if ($this.data('day') == 7) {
          todayDate.setDate(todayDate.getDate() + 7);
        }
        document.cookie = popupId + "=no" + "; path=/; expires=" + todayDate.toGMTString() + ";";
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
        if (window.innerWidth < $(v).width()) {
          $(v).css('width', 'auto');
        }
        $(v).show();
      }
    });
    // 팝업 관련 코드 END

      function initializeSection(selector, url) {
          $(selector).html('<div class="book-loading-wrapper"><div class="book-loading"></div></div>');

          $(selector).load(url, function (response, status) {
              if (status === 'error') {
                  return;
              }

              const $slide = $(selector).find('.section3-slide');
              if ($slide.length && !$slide.hasClass('slick-initialized')) {
                  $slide.slick({
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

              $(selector).find('.section3-slide-prev, .section3-slide-next').off('click').on('click', function () {
                  if ($slide.hasClass('slick-initialized')) {
                      $slide.slick($(this).hasClass('section3-slide-prev') ? 'slickPrev' : 'slickNext');
                  }
              });
          });
      }

      initializeSection('.section3-content4', 'newBook.do');
      initializeSection('.section3-content5', 'bestBook.do');
      initializeSection('.section3-content6', 'curriculumBook.do');

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
            <homepageTag:popup popupList="${popupList}"/>
        </div>
    </div>

    <!-- 통합팝업 -->
    <c:if test="${not empty popupFullList}">
        <div class="total-popup-overlay"></div>
        <div class="total_popup_area" id="total_popup_area">
            <div class="total-popup-controller">
                <div class="total-popup-controller-btn popup-today-close">
                    <div>오늘 하루 열지 않기</div>
                    <img src="/resources/homepage/${homepage.context_path}/img/common/total-popup-close.svg" alt="">
                </div>
                <div class="total-popup-controller-btn popup-close">
                    <div>창 닫기</div>
                    <img src="/resources/homepage/${homepage.context_path}/img/common/total-popup-close.svg" alt="">
                </div>
            </div>

            <div class="total-popup-content">
                <div class="total-popup-title">POPUP LIST</div>
                <div class="total-popup-slide-wrapper">
                    <img class="total-popup-slide-prev" src="/resources/homepage/${homepage.context_path}/img/common/total-popup-left-arrow.svg" alt="">
                    <div class="total-popup-slide">
                        <c:forEach items="${popupFullList}" var="i" varStatus="status">
                            <div class="total-popup-slide-item">
                                <c:choose>
                                    <c:when test="${not empty i.server_file_name}">
                                        <img src="${pageContext.request.contextPath}/data/popup/${i.homepage_id}/${i.server_file_name}" alt="${i.alt_text}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png" alt="${i.alt_text}">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty i.link_type and i.link_type ne 'NONE'}">
                                    <a href="${i.link_url}"> ${i.link_type eq 'APPLY' ? '신청하기' : '자세히보기'} </a>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                    <img class="total-popup-slide-next" src="/resources/homepage/${homepage.context_path}/img/common/total-popup-right-arrow.svg" alt="">
                </div>
            </div>
        </div>
    </c:if>

    <div id="fullpage">
        <!-- 섹션1 -->
        <div class="section-wrapper" data-anchor="section1">
            <div class="main-bg-slide slider-for">
                <c:forEach var="i" items="${popupZoneList}">
                    <div class="" style="background-image: url('/data/popupZone/${i.homepage_id}/${i.server_file_name}');"></div>
                </c:forEach>
            </div>
            <div class="wrapper">
                <div class="search-bar-wrapper">
                    <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
                        <input type="hidden" name="_csrf" value="d09d3db2-6fbd-477b-b232-5f589c4e40b9">
                        <label for="search_type" class="search_type">
                            <select id="search_type" name="search_type">
                                <option value="title">서명</option>
                                <option value="author">저자</option>
                                <option value="publer">발행자</option>
                                <option value="keyword">키워드</option>
                            </select>
                        </label>
                        <input type="hidden" name="menu_idx" value="13">
                        <input type="hidden" name="booktype" value="BOOKANDNONBOOK">
                        <input name="title" id="search_text_1" type="text" placeholder="검색어를 입력해주세요.">
                        <button id="main-search-btn">
                            <span>자료검색</span>
                            <img src="/resources/homepage/${homepage.context_path}/img/main/search.svg" alt="">
                        </button>
                    </form>

                    <a class="kakao" href="https://pf.kakao.com/_xhxiyDxj">
						<img src="/resources/homepage/${homepage.context_path}/img/common/kakaotalk-color.svg" alt="">
					</a>
                    <a href="https://www.instagram.com/lib${homepage.context_path}/">
						<img src="/resources/homepage/${homepage.context_path}/img/common/instagram-color.svg" alt="">
					</a>
                </div>

                <div class="main-popup-wrapper">
                    <img class="main-popup-prev" src="/resources/homepage/${homepage.context_path}/img/main/main-popup-prev.svg" alt="">
                    <img class="main-popup-next" src="/resources/homepage/${homepage.context_path}/img/main/main-popup-next.svg" alt="">
                    <div class="popup-pagination"></div>
                    <div class="main-popup slider-nav">
                        <c:forEach var="i" items="${popupZoneList}">
                            <div class="main-popup-item">
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
                    </div>
                </div>
            </div>
            <div class="main-bottom-area">
                <div class="main-bottom-area-wrapper">
                    <div class="quick-menu">
                        <c:forEach var="i" varStatus="status" items="${quickMenuList}">
                            <c:if test="${i.link_target eq 'BLANK' }">
                                <a class="quick-menu-item" href="${i.link_url}" target="_blank">
                                    <img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}.${i.file_extension}" alt="${i.menu_name}">
                                    <div>${i.menu_name}</div>
                                </a>
                            </c:if>
                            <c:if test="${i.link_target ne 'BLANK' }">
                                <a class="quick-menu-item" href="${i.link_url}">
                                    <img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}.${i.file_extension}" alt="${i.menu_name}">
                                    <div>${i.menu_name}</div>
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="holiday-notice-wrapper">
                        <div class="holiday-area" id="holiday-area"></div>
                        <div class="notice-slide-wrapper">
                            <img src="/resources/homepage/bukbu/img/main/notice-slide-pause.svg" alt="">
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
            </div>
        </div>
        <!-- 섹션2 -->
        <div class="section-wrapper" data-anchor="section2">
            <div class="wrapper">
                <div class="section2-header">
                    <div class="section2-title">
                        <div class="section2-title-text">도서관 소식</div>
                        <div class="section2-tab">
                            <div class="section2-tab-active" data-target="1" data-link="/${homepage.context_path}/board/index.do?menu_idx=124&manage_idx=146">행사프로그램</div>
                            <div data-target="2" data-link="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1">공지사항</div>
                            <div data-target="3" data-link="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=157">가족영화</div>
                        </div>
                    </div>

                    <div class="section2-action-wrapper">
                        <img class="section2-slide-prev" src="/resources/homepage/${homepage.context_path}/img/notice/left-arrow.svg" alt="">
                        <img class="section2-slide-next" src="/resources/homepage/${homepage.context_path}/img/notice/right-arrow.svg" alt="">
                        <a href="/${homepage.context_path}/board/index.do?menu_idx=124&manage_idx=146" class="tab-link">
                            <img src="/resources/homepage/${homepage.context_path}/img/notice/more.svg" alt="">
                        </a>
                    </div>
                </div>

                <div class="section2-content1">
					<c:choose>
						<c:when test="${fn:length(teachGuideList) > 0}">
							<div class="section2-slide">
								<c:forEach var="i" varStatus="status" items="${teachGuideList}">
									<div class="section2-slide-item">
										<div class="section2-slide-item-top">
											<div class="section2-slide-item-top-header">
												<div>행사프로그램</div>
												<div>
													<fmt:formatDate value="${i.add_date}" pattern="MM"/><span> <fmt:formatDate value="${i.add_date}" pattern="dd"/></span>
												</div>
											</div>
											<div class="section2-slide-item-title">${i.title}</div>
										</div>
										<div class="section2-slide-item-bottom">
											<div>${i.content_summary}</div>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=124&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												더보기
											</a>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div class="event-no-data">등록된 행사프로그램이 없습니다.</div>
						</c:otherwise>
					</c:choose>
                </div>
                <div class="section2-content2" style="display: none;">
					<c:choose>
						<c:when test="${fn:length(noticeList) > 0}">
							<div class="section2-slide">
								<c:forEach var="i" varStatus="status" items="${noticeList}">
									<div class="section2-slide-item">
										<div class="section2-slide-item-top">
											<div class="section2-slide-item-top-header">
												<div>공지사항</div>
												<div>
													<fmt:formatDate value="${i.add_date}" pattern="MM"/><span> <fmt:formatDate value="${i.add_date}" pattern="dd"/></span>
												</div>
											</div>
											<div class="section2-slide-item-title">${i.title}</div>
										</div>
										<div class="section2-slide-item-bottom">
											<div>${i.content_summary}</div>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=36&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												더보기
											</a>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div class="event-no-data">등록된 공지사항이 없습니다.</div>
						</c:otherwise>
					</c:choose>
                </div>

                <div class="section2-content3" style="display: none;">
					<c:choose>
						<c:when test="${fn:length(movieList) > 0}">
							<div class="section2-slide">
								<c:forEach var="i" varStatus="status" items="${movieList}">
									<div class="section2-slide-item">
                                        <div class="movie-content">
                                            <c:choose>
                                                <c:when test="${i.preview_img ne null}">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(i.preview_img, 'http')}">
                                                            <img class="movie-thumbnail" src="${i.preview_img}" alt="${i.title}"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img class="movie-thumbnail" src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="movie-thumbnail" src="/resources/homepage/nambu/img/common/dummy.png" alt="${i.title}">
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="movie-detail">
                                                <div class="movie-title">${i.title}</div>

                                                <div class="movie-info">
                                                    <t:movieField label="날짜" condition="${not empty i.imsi_v_1 and not empty i.imsi_v_2}" value="${fn:replace(i.imsi_v_1,'-','.')}.${i.imsi_v_2}" />
                                                    <t:movieField label="시간" condition="${not empty i.imsi_v_3 and not empty i.imsi_v_4}" value="${i.imsi_v_3}:${(fn:length(i.imsi_v_4)==1?'0':'')}${i.imsi_v_4}" />
                                                    <t:movieField label="장소" condition="${not empty i.imsi_v_6 and i.imsi_v_6 != '0'}" value="${i.imsi_v_6}" />
                                                    <t:movieField label="장르" condition="${not empty i.imsi_v_9 and i.imsi_v_9 != '0'}" value="${fn:substring(i.imsi_v_9,0,6)}" />
                                                    <t:movieField label="등급" condition="${not empty i.imsi_v_12 and i.imsi_v_12 != '0'}" value="${i.imsi_v_12}" />
                                                </div>

                                                <a class="go-to-movie" href="/${homepage.context_path}/board/view.do?menu_idx=60&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                                    더보기
                                                </a>
                                            </div>
                                        </div>
									</div>
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<div class="event-no-data">등록된 영화가 없습니다.</div>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
        </div>
        <!-- 섹션3 -->
        <div class="section-wrapper" data-anchor="section3">
            <div class="wrapper">
                <div class="section3-top">
                    <div class="section3-title">도서서비스</div>
                    <div class="section3-wrapper">
                        <div class="section3-header">
                            <div class="section3-tab">
                                <div class="section3-tab-active"
                                     data-target="4" data-link="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14">신착도서
                                </div>
                                <div data-target="5" data-link="/${homepage.context_path}/intro/search/bestBook/index.do?menu_idx=15">대출베스트</div>
                                <div data-target="6" data-link="/${homepage.context_path}/intro/search/index.do?menu_idx=120&booktype=BOOK&separateShelfCode=ABH#search_result">교과연계도서</div>
                                <div data-target="7" data-link="/${homepage.context_path}/board/index.do?menu_idx=165&manage_idx=921">북큐레이션</div>
                            </div>

                            <div class="section3-action-wrapper">
                                <img class="section3-slide-prev" src="/resources/homepage/${homepage.context_path}/img/notice/left-arrow.svg" alt="">
                                <img class="section3-slide-next" src="/resources/homepage/${homepage.context_path}/img/notice/right-arrow.svg" alt="">
                                <a href="" class="tab-link2">
                                    <img src="/resources/homepage/${homepage.context_path}/img/notice/more.svg" alt="">
                                </a>
                            </div>
                        </div>

                        <div class="section3-content4"></div>
                        <div class="section3-content5" style="display: none;">

                        </div>
                        <div class="section3-content6" style="display: none;">

                        </div>
                        <div class="section3-content7" style="display: none;">
                            <c:choose>
                                <c:when test="${fn:length(curationList) > 0}">
                                    <div class="section3-slide">
                                        <c:forEach var="i" items="${curationList}">
                                            <div class="section3-slide-item">
                                                <a href="/${homepage.context_path}/board/view.do?menu_idx=165&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(i.preview_img, 'noimg')}">
                                                            <img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                                <div class="section3-slide-title">${i.title}</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="book-nodata">등록된 큐레이션이 없습니다.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="section3-bottom">
                    <a href="/${homepage.context_path}/html.do?menu_idx=48">
                        <img src="/resources/homepage/${homepage.context_path}/img/book/icon1.svg" alt="">
                        <div class="link-name">
                            <div>책바다</div>
                            <div>
                                전국도서관 소장자료<br>
                                공유·공동 활용
                            </div>
                        </div>
                    </a>
                    <a href="/${homepage.context_path}/html.do?menu_idx=49">
                        <img src="/resources/homepage/${homepage.context_path}/img/book/icon2.svg" alt="">
                        <div class="link-name">
                            <div>책나래</div>
                            <div>
                                장애인을 위한 도서관 자료<br>
                                무료 택배 서비스
                            </div>
                        </div>
                    </a>
                    <a href="/${homepage.context_path}/html.do?menu_idx=110">
                        <img src="/resources/homepage/${homepage.context_path}/img/book/icon3.svg" alt="">
                        <div class="link-name">
                            <div>경북대상호대차</div>
                            <div>
                                경북대학교 도서관 자료<br>
                                상호 대출 서비스
                            </div>
                        </div>
                    </a>
                    <a href="/${homepage.context_path}/html.do?menu_idx=50	">
                        <img src="/resources/homepage/${homepage.context_path}/img/book/icon4.svg" alt="">
                        <div class="link-name">
                            <div>사서에게 물어보세요</div>
                            <div>
                                협력형 온라인 지식 정보 <br>서비스
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <!-- 섹션4 -->
        <div class="section-wrapper" data-anchor="section4">
            <div class="section4-slide">
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>어린이자료실</div>
                                <div>영유아 및 어린이 자료, 학년별 교과연계자료 등을 비치하고 있습니다.</div>
                            </div>
                            <div class="index">01</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                            <img onclick="window.location.href='/${homepage.context_path}/html.do?menu_idx=117'" src="/resources/homepage/${homepage.context_path}/img/place/more.svg" alt="">
                        </div>
                    </div>
                </div>
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>종합자료실</div>
                                <div>전 주제분야(총류~역사)의 일반도서, 큰글자도서 등을 소장하고 있습니다.</div>
                            </div>
                            <div class="index">02</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                            <img onclick="window.location.href='/${homepage.context_path}/html.do?menu_idx=116'" src="/resources/homepage/${homepage.context_path}/img/place/more.svg" alt="">
                        </div>
                    </div>
                </div>
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>청소년북아지트</div>
                                <div>청소년북아지트는 청소년 전용 공간입니다.
                                    (중학생 1~3학년, 연나이 13~15세)</div>
                            </div>
                            <div class="index">03</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                            <img onclick="window.location.href='/${homepage.context_path}/html.do?menu_idx=210'" src="/resources/homepage/${homepage.context_path}/img/place/more.svg" alt="">
                        </div>
                    </div>
                </div>
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>북마루</div>
                                <div>다목적실</div>
                            </div>
                            <div class="index">04</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>북담</div>
                                <div>이용자 휴게실</div>
                            </div>
                            <div class="index">05</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>시청각실</div>
                                <div></div>
                            </div>
                            <div class="index">06</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section4-slide-item">
                    <div class="content-title">공간소개</div>
                    <div class="section4-slide-item-content">
                        <div class="section4-slide-item-content-top">
                            <div class="place-name">
                                <div>카페</div>
                                <div></div>
                            </div>
                            <div class="index">07</div>
                        </div>
                        <div class="section4-slide-item-content-bottom">
                            <div class="slide-controller">
                                <img class="section4-slide-prev" src="/resources/homepage/${homepage.context_path}/img/place/arrow-left.svg" alt="">
                                <img class="section4-slide-next" src="/resources/homepage/${homepage.context_path}/img/place/arrow-right.svg" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section4-pagination">
                <div class="section4-pagination-item">
                    <div>01</div>
                    <div>어린이자료실</div>
                </div>
                <div class="section4-pagination-item">
                    <div>02</div>
                    <div>종합자료실</div>
                </div>
                <div class="section4-pagination-item">
                    <div>03</div>
                    <div>청소년북아지트</div>
                </div>
                <div class="section4-pagination-item">
                    <div>04</div>
                    <div>북마루</div>
                </div>
                <div class="section4-pagination-item">
                    <div>05</div>
                    <div>북담</div>
                </div>
                <div class="section4-pagination-item">
                    <div>06</div>
                    <div>시청각실</div>
                </div>
                <div class="section4-pagination-item">
                    <div>07</div>
                    <div>카페</div>
                </div>
            </div>
        </div>

        <!-- footer -->
        <div class="footer section-wrapper fp-auto-height" data-anchor="section5">
            <!-- banner -->
            <div class="banner-area">
                <div class="banner-slide-controller">
                    <img class="banner-prev" src="/resources/homepage/${homepage.context_path}/img/common/banner-prev.svg" alt=""/>
                    <img class="banner-next" src="/resources/homepage/${homepage.context_path}/img/common/banner-next.svg" alt=""/>
                    <img class="banner-play-and-pause" src="/resources/homepage/${homepage.context_path}/img/common/banner-pause.svg" alt="">
                    <img onclick="window.location.href='/${homepage.context_path}/bannermap/index.do?menu_idx=93';" src="/resources/homepage/${homepage.context_path}/img/common/banner-more.svg" alt="">
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