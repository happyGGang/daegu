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
		
        $('div#holiday-area').load('calendar2.do');
        $('div#event-area').load('calendar3.do');
        loadTabContent('div.tab2', 'bestBook.do');
        loadTabContent('div.tab3', 'newBook.do');

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
						<input type="hidden" name="menu_idx" value="13">
						<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}"/>
						<input name="title" id="book-search" type="text" placeholder="찾으시는 도서 정보를 입력하세요"/>
						
						<button class="book-search-btn" id="main-search-btn">
							<img src="/resources/homepage/${homepage.context_path}/img/main/search.svg" alt=""/>
						</button>
					</form>
				</div>
				<div class="main-popup-wrapper">
					<img class="main-popup-prev" src="/resources/homepage/${homepage.context_path}/img/main/main-popup-prev.svg" alt="">
					<img class="main-popup-next" src="/resources/homepage/${homepage.context_path}/img/main/main-popup-next.svg" alt="">
					
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
					
					<div class="main-popup-pagination">
						<c:forEach var="i" items="${popupZoneList}">
							<div class="main-popup-pagination-item"><span>${i.popup_zone_name}</span></div>
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
								<a class="quick-menu-item" href="${i.link_url}" target="_blank">
									<img src="/data/quickMenu/${homepage.homepage_id}/${i.server_file_name}.${i.file_extension}" alt="${i.menu_name}">
									<div>${i.menu_name}</div>
								</a>
							</c:if>
						</c:forEach>
					</div>
					<div id="holiday-area"></div>
				</div>
			</div>
        </div>
        <!-- 섹션2 -->
        <div class="section-wrapper" data-anchor="section2">
            <div class="wrapper">
                <div class="notice-board">
                    <div class="notice-board-header">
                        <div class="notice-board-title">공지사항</div>
                        <a href="https://library.daegu.go.kr/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=161">
                            <img src="/resources/homepage/${homepage.context_path}/img/notice/more.svg" alt="">
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
                            <c:when test="${fn:length(galleryList) > 0}">
                                <c:forEach var="i" items="${galleryList}">
                                    <div class="popup-slide-item">
                                        <a href="/${homepage.context_path}/board/view.do?menu_idx=143&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" target="_blank">
                                            <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}"  alt="${i.title}" title="${i.title}" onError="this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="popup-slide-item">
                                    <img src="/resources/homepage/${homepage.context_path}/img/common/dummy.png" alt=""/>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="popup-control">
                        <div class="popup-prev">
                            <img src="/resources/homepage/${homepage.context_path}/img/notice/popup-prev.svg" alt=""/>
                        </div>
                        <div class="popup-pagination"></div>
                        <div class="popup-play-and-pause">
                            <img src="/resources/homepage/${homepage.context_path}/img/notice/pause.svg" alt=""/>
                        </div>
                        <div class="popup-next">
                            <img src="/resources/homepage/${homepage.context_path}/img/notice/popup-next.svg" alt=""/>
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
                    <a href="https://library.daegu.go.kr/${homepage.context_path}/module/teach/index.do?menu_idx=30" class="go-to-course">
                        <div>더보기</div>
                        <img src="/resources/homepage/${homepage.context_path}/img/culture/more.svg" alt="">
                    </a>
                </div>
                <div class="course-list">
                    <c:choose>
                        <c:when test="${fn:length(teachList) > 0}">
                            <img class="img1" src="/resources/homepage/${homepage.context_path}/img/culture/img1.svg" alt="">
                            <img class="img2" src="/resources/homepage/${homepage.context_path}/img/culture/img2.svg" alt="">
                            <c:forEach var="i" varStatus="status" items="${teachList}" begin='0' end='3'>
                                <a href="/${homepage.context_path}/module/teach/detail.do?menu_idx=30&homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&category_idx=${i.category_idx}&teach_idx=${i.teach_idx}&searchCate1=${i.large_category_idx}" class="course-list-item">
                                    <div class="course-list-item-title">
                                        <div>${i.teach_name}</div>
                                    </div>
                                    <div class="course-list-item-date">
                                        <div><span>강좌기간</span>${i.start_date} ~ ${i.end_date}</div>
                                        <div><span>접수기간</span>${i.start_join_date} ~ ${i.start_join_date}</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="course-no-data">등록된 강좌 및 행사가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="event-area" id="event-area"></div>
        </div>
        <!-- 섹션4 -->
        <div class="section-wrapper" data-anchor="section4">
            <div class="wrapper">
                <a id="tab-link" href="/${homepage.context_path}/intro/search/newBook/index.do?menu_idx=14">
                    <img src="/resources/homepage/${homepage.context_path}/img/book/more.svg" alt="">
                </a>
                <div class="book-tab-wrapper">
                    <div class="tab-button active-tab" data-target="tab1">북큐레이션</div>
                    <div class="tab-button" data-target="tab2">대출베스트</div>
                    <div class="tab-button" data-target="tab3">신착도서</div>
                </div>

                <div class="tab-content tab1">
                    <c:choose>
                        <c:when test="${fn:length(curationList) > 0}">
                            <img class="book-slide-prev" src="/resources/homepage/${homepage.context_path}/img/book/arrow-left.svg" alt="이전" />
                            <!-- 북 큐레이션 리스트 -->
                            <div class="tab-list">
                                <c:forEach var="i" items="${curationList}">
                                    <div class="tab-list-item">
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
                                        <div class="title">${i.title}</div>
                                    </div>
                                </c:forEach>
                            </div>
                            <img class="book-slide-next" src="/resources/homepage/${homepage.context_path}/img/book/arrow-right.svg" alt="다음" />
                        </c:when>

                        <c:otherwise>
                            <div class="book-nodata">등록된 북큐레이션이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="tab-content tab2" style="display: none;"></div>
                <div class="tab-content tab3" style="display: none;"></div>
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