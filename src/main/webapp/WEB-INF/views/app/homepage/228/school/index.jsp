<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />

<link rel="stylesheet" type="text/css" href="/resources/homepage/228/css/main_school.css"/>

<script type="text/javascript">
	$(function() {
		$('#homeup').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});

		// 팝업 관련 코드 START
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
		// 팝업 관련 코드 END


		$('div.cal-box').load('calendar3.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
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

	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="container" class="main">

		<div class="main1">
			<div class="section">
				<div class="main-visual">
					<div class="title-box">
						<h2>
							<span>학교도서관,<b class="green">지혜</b>를 담고 <b class="blue">생각</b>을 키우고 <b class="red">꿈</b>을 펼치다!</span>
							<span class="second-line">학교도서관집중지원센터</span>
						</h2>
					</div>
					<div class="main1box1">
						<!-- Main_search -->
						<div class="search-box">
							<form id="mainSearchForm" action="/${homepage.context_path}/module/bookPackage/index.do">
								<input type="hidden" name="menu_idx" value="138">
								<input type="hidden" name="search_type" value="book_package_subject">
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<label for="search_text_1" class="blind">통합자료검색</label>
											<input name="search_text" id="search_text_1" type="text" class="text" placeholder="책꾸러미 서명을 입력하세요." style="ime-mode:active;"/>
										</div>
										<button id="main-search-btn">검색</button>
									</div>
								</fieldset>
							</form>
						</div>
						<!-- //Main_search -->	
						<div class="quick-btn-box">
							<div class="btn-box">
								<a href="/${homepage.context_path}/module/supportMember/index.do?menu_idx=175"><span class="txt">학교(기관)로그인</span></a>
								<span class="icon"></span>
							</div>
						</div>
					</div>
					<div class="main1box2">
						<div class="quickmenu">
							<div class="main-box">
								<div class="qmenu-box">
									<ul>
									<li class="qm1">
									<a href="/${homepage.context_path}/html.do?menu_idx=135" ><span>센터소개</span></a>
									</li>
									<li class="qm2">
									<a href="/${homepage.context_path}/html.do?menu_idx=113" ><span>책꾸러미</span></a>
									</li>
									<li class="qm3">
									<a href="/${homepage.context_path}/html.do?menu_idx=143" ><span>원화꾸러미</span></a>
									</li>
									<li class="qm4">
									<a href="/${homepage.context_path}/html/recomBookList.do?menu_idx=259" ><span>학생 추천도서 목록</span></a>
									</li>
									<li class="qm5">
									<a href="/${homepage.context_path}/module/libraryCheck/index.do?menu_idx=148" ><span>장서점검기</span></a>
									</li>
									<li class="qm6">
									<a href="/${homepage.context_path}/board/index.do?menu_idx=150&manage_idx=225" ><span>학교도서관 업무지원</span></a>
									</li>
									<li class="qm7">
									<a href="/${homepage.context_path}/board/index.do?menu_idx=154&manage_idx=224" ><span>참고자료</span></a>
									</li>
									<!-- <li class="qm8">
									<a href="/${homepage.context_path}/module/supportMember/index.do?menu_idx=175" target="_blank"><span>강사인력풀</span></a>
									</li> -->
									
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="main2">
			<div class="section">
				<div class="main2box">
					<div class="main2box1">
						<div class="notice-box">
							<h2 class="title">공지사항</h2>
							<div class="list" id="notice-list">
								<ul>
									<c:forEach var="i" varStatus="status" items="${noticeList}" begin="0" end="2">
										<c:choose>
											<c:when test="${status.first}">
												<li>
													<a href="/${homepage.context_path}/board/view.do?menu_idx=136&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" title="게시글 자세히 보기">
														<div class="date"><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/><p><fmt:formatDate value="${i.add_date}" pattern="yyyy"/></p></div>
														<div class="con">
															<h3>${i.title}</h3>
															<span>${fn:substring(fn:trim(i.content_summary), 0, 25)}<c:if test="${fn:length(i.content_summary) > 26}">...</c:if></span>
														</div>
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li>
													<a href="/${homepage.context_path}/board/view.do?menu_idx=136&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}" title="게시글 자세히 보기">
														${i.title}
													</a>
													<span><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></span>
												</li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${fn:length(noticeList) < 1}">
										<div>등록된 공지사항이 없습니다.</div>
									</c:if>
								</ul>
							</div>
							<div class="more-btn" id="board-more-btn">
								<a href="/${homepage.context_path}/board/index.do?menu_idx=136&manage_idx=210" title="공지사항 더보기">
									<img src="/resources/homepage/${homepage.context_path}/img/notice_more.png" alt="공지사항 더보기 이미지" title="공지사항 더보기 이미지">
								</a>
							</div>
						</div>
					</div>

					<div class="main2box2">
						<h2 class="title">팝업존</h2>
						<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/newpopup.png" alt="등록된 팝업이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
						</div>	
					</div>

				</div>	 
			</div>
		</div>
	</div>


<tiles:insertAttribute name="footer" />