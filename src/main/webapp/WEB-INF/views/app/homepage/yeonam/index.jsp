<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.salip.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.swiper.css"/>
<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.swiper.min.js"></script>

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

	<div class="popupWrap main-section4">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main0-wrap">
				<div class="main0-top">
					<div class="main-section4">

						<div class="main0-top-left">
							<div class="main0-txt">
								<p class='gray-txt'>Daegu Private Public Yeonam Library</p>
								<p class='txt'><b>연암도서관</b>이<br/>나를 성장시키고, 세상을 바꾼다.</p>
							</div>
							<!-- main_search -->
							<div class="search-area" id="main_search">
								<form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
								<input type="hidden" name="menu_idx" value="9">
								<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
								<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
								<fieldset>
									<legend class="blind">통합검색</legend>
									<div class="main-box">
										<div class="box1">
											<div class="box2">
												<label for="search_text_1" class="blind">통합자료검색</label>
												<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
											</div>
										</div>
										<button id="main-search-btn">검색하기</button>
									</div>
								</fieldset>
								</form>
							</div>
							<!-- //Main_search -->
						</div>
						
						<div class="main0-top-right">
							<img src="/resources/homepage/${homepage.context_path}/img/main0-visual-img.png" alt="">
						</div>

					</div>
				</div>
				<div class="main0-bottom">
					<div class="main-section3">
						<div class="quick-menu">
							<ul>
								<li class="quick01">
									<a href="/bukgs/html.do?menu_idx=15" class="q01">
										<span>희망도서신청</span>
									</a>
								</li>
								<li class="quick02">
									<a href="/bukgs/html.do?menu_idx=92" class="q02">
										<span>상호대차서비스</span>
									</a>
								</li>
								<li class="quick03">
									<a href="/bukgs/module/teach/index.do?menu_idx=32" class="q03">
										<span>독서문화행사</span>
									</a>
								</li>
								<li class="quick04">
									<a href="/bukgs/intro/search/loan/history.do?menu_idx=53" class="q04">
										<span>대출정보조회</span>
									</a>
								</li>
								<li class="quick05">
									<a href="/bukgs/html.do?menu_idx=91" class="q05">
										<span>스마트도서관</span>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='main-section4'>

				<div class="book-box web-view">
					<div id="main-slide" class="main-floor1">
						<div class="book-box-title">
							<h4>신착도서</h4>
							<a href="#" class="more-btn">추천도서 더보기 +</a>
						</div>
						<div class="swiper-container gallery-top-main">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>열두 달 한뼘 텃밭</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235852">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6120438%3Ftimestamp%3D20220803213121" alt="열두 달 한뼘 텃밭" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>단위가 사라졌다</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235851">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5748509%3Ftimestamp%3D20210722150203" alt="단위가 사라졌다" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>우리가 여기 먼저 살았다</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235850">
											<img src="/data/board/769/235850/" alt="우리가 여기 먼저 살았다" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>곰들은 어디로 갔을까?</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235849">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5735773%3Ftimestamp%3D20210615143309" alt="곰들은 어디로 갔을까?" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>행운을 찾아서</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235848">
											<img src="http://bimage.interpark.com/goods_image/2/1/1/4/264022114s.jpg" alt="행운을 찾아서" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>단정한 반복이 나를 살릴 거야</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235847">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6127328%3Ftimestamp%3D20220819170818" alt="단정한 반복이 나를 살릴 거야" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>어른의 어휘 공부</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235846">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6100598%3Ftimestamp%3D20220728214904" alt="어른의 어휘 공부" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>우리에게도 예쁜 것들이 있다</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235845">
											<img src="/data/board/769/235845/" alt="우리에게도 예쁜 것들이 있다" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>시골마을 오래된 건축 뜯어보기</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235844">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5983126%3Ftimestamp%3D20220410163434" alt="시골마을 오래된 건축 뜯어보기" />
												</a>
										</div>
									</div>
								</div>
								<div class="swiper-slide">
									<div class="main-slide1-con">
										<div class="text">
											<h4>박상미의 가족 상담소</h4>
										</div>
										<div class="photo">
											<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235843">
											<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6117396%3Ftimestamp%3D20220804175110" alt="박상미의 가족 상담소" />
												</a>
										</div>
									</div>
								</div>
								</div>
						</div>
						<div class="swiper-container gallery-thumbs-main">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6120438%3Ftimestamp%3D20220803213121" alt="열두 달 한뼘 텃밭"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5748509%3Ftimestamp%3D20210722150203" alt="단위가 사라졌다"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="/data/board/769/235850/" alt="우리가 여기 먼저 살았다"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5735773%3Ftimestamp%3D20210615143309" alt="곰들은 어디로 갔을까?"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="http://bimage.interpark.com/goods_image/2/1/1/4/264022114s.jpg" alt="행운을 찾아서"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6127328%3Ftimestamp%3D20220819170818" alt="단정한 반복이 나를 살릴 거야"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6100598%3Ftimestamp%3D20220728214904" alt="어른의 어휘 공부"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="/data/board/769/235845/" alt="우리에게도 예쁜 것들이 있다"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5983126%3Ftimestamp%3D20220410163434" alt="시골마을 오래된 건축 뜯어보기"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
								<div class="swiper-slide">
									<span>
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6117396%3Ftimestamp%3D20220804175110" alt="박상미의 가족 상담소"onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
									</span>
								</div>
							</div>
						</div>
						<!-- Add Arrows -->
						<a href="#none" class="swiper-button-next" id="focusA"></a>
						<a href="#none" class="swiper-button-prev"></a>

						<!--등록된 도서 없을 경우-->
						</div>

					<script>
						var galleryThumbsMain = new Swiper('.gallery-thumbs-main', {
							spaceBetween: 5,
							slidesPerView: 7,
							loop: true,
							touchRatio: 0.2,
							slideToClickedSlide: true,
							freeMode: true,
							loopedSlides: 7, //looped slides should be the same
							watchSlidesVisibility: true,
							watchSlidesProgress: true,
						});
						var galleryTopMain = new Swiper('.gallery-top-main', {
							spaceBetween: 7,
							effect: 'fade',
							loop:true,
							autoplay: {
								delay: 3000,
								disableOnInteraction: false,
							},
							loopedSlides: 7, //looped slides should be the same
							navigation: {
								nextEl: '.swiper-button-next',
								prevEl: '.swiper-button-prev',
							},
							 pagination: {
								el: '.swiper-pagination',
								clickable: true,
							},
							on: {
								autoplayStop: function() {
									this.$el.find(".ups-icon-videoplay").addClass('stop-status');
								},
								autoplayStart: function() {
									this.$el.find(".ups-icon-videoplay").removeClass('stop-status');
								},
							},
						});
						galleryTopMain.$el.find(".ups-icon-videoplay").on('click', function() {
							if (galleryTopMain.autoplay.running) {
								galleryTopMain.autoplay.stop();
							} else {
								galleryTopMain.autoplay.start();
							}
						});
						galleryTopMain.controller.control = galleryThumbsMain; 
						galleryThumbsMain.controller.control = galleryTopMain;
					</script>
				</div>

				<div class="book-box mobile-view">
					<h3>권장도서</h3>
					<a href="/${homepage.context_path}/board/index.do?menu_idx=13&manage_idx=769" class="big_txt_more more02">더보기</a>

					<div class="cont bookPickList">
						<a href="#" class="bx-prev">이전</a>
						<ul>
							
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235852">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6120438%3Ftimestamp%3D20220803213121" alt="열두 달 한뼘 텃밭" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">열두 달 한뼘 텃밭</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235851">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5748509%3Ftimestamp%3D20210722150203" alt="단위가 사라졌다" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">단위가 사라졌다</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235850">
									<div class="thumbnails">
										<img src="/data/board/769/235850/" alt="우리가 여기 먼저 살았다" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
											</div>
									<h3 class="book-title">우리가 여기 먼저 살았다</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235849">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5735773%3Ftimestamp%3D20210615143309" alt="곰들은 어디로 갔을까?" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">곰들은 어디로 갔을까?</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235848">
									<div class="thumbnails">
										<img src="http://bimage.interpark.com/goods_image/2/1/1/4/264022114s.jpg" alt="행운을 찾아서" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">행운을 찾아서</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235847">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6127328%3Ftimestamp%3D20220819170818" alt="단정한 반복이 나를 살릴 거야" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">단정한 반복이 나를 살릴 거야</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235846">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6100598%3Ftimestamp%3D20220728214904" alt="어른의 어휘 공부" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">어른의 어휘 공부</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235845">
									<div class="thumbnails">
										<img src="/data/board/769/235845/" alt="우리에게도 예쁜 것들이 있다" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'" />
											</div>
									<h3 class="book-title">우리에게도 예쁜 것들이 있다</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235844">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5983126%3Ftimestamp%3D20220410163434" alt="시골마을 오래된 건축 뜯어보기" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">시골마을 오래된 건축 뜯어보기</h3>
								</a>
							</li>
							<li>
								<a href="/${homepage.context_path}/board/view.do?menu_idx=13&manage_idx=769&board_idx=235843">
									<div class="thumbnails">
										<img src="https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F6117396%3Ftimestamp%3D20220804175110" alt="박상미의 가족 상담소" onError="this.src='/resources/homepage/${homepage.context_path}/img/book_noimg.png'"/>
											</div>
									<h3 class="book-title">박상미의 가족 상담소</h3>
								</a>
							</li>
							</ul>
						<a href="#next" class="bx-next">다음</a>
						</div>
				</div>

				<div class="culture-box">
					<ul>
						<li>
							<a href="">
								<span class="culture-tit">[초등4-6] 독서토론이 즐거워</span>
								<span class="culture-cot">
									<p>강좌기간 <b>2022-05-13 ~ 2022-05-20</b></p>
									<p>접수기간 <b>2022-04-20 ~ 2022-05-10</b></p>
								</span>
							</a>
						</li>
						<li>
							<a href="">
								<span class="culture-tit">[초등4-6] 독서토론이 즐거워</span>
								<span class="culture-cot">
									<p>강좌기간 <b>2022-05-13 ~ 2022-05-20</b></p>
									<p>접수기간 <b>2022-04-20 ~ 2022-05-10</b></p>
								</span>
							</a>
						</li>
					</ul>
				</div>
				<div class="culture-more-box"><a href="#">문화행사 더보기 +</a></div>
			</div>

			<div class="banner-box">
				<div class="main-section3">
					<div class="banner-wrap type5">
						<div class="banner-t5">
							<h3>배너모음</h3>
							<div class="control">
								<a class="prev" href="#prev"><img src="/resources/common/img/banner-prev-btn.png" alt="이전" /><span class="blind">이전</span></a>
								<a class="next" href="#next"><img src="/resources/common/img/banner-next-btn.png" alt="다음" /><span class="blind">다음</span></a>
								<a class="stop active" href="#stop"><img src="/resources/common/img/banner-stop-btn.png" alt="정지" /><span class="blind">정지</span></a>
								<a class="play" href="#play"><img src="/resources/common/img/banner-start-btn.png" alt="시작" /><span class="blind">시작</span></a>
							</div>
						</div>
						<div class="banner-box5">
							<homepageTag:banner bannerList="${bannerList}"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //main1 -->

		<!-- footer_section -->
		<div class="section fp-auto-height footer_area" id="foot_section">
			<tiles:insertAttribute name="footer" />
		</div>
		<!-- //footer_section -->


	</div>

</div>


</body>
</html>


<script type="text/javascript">
function fullPage() {
	var myFullpage = new fullpage('#fullpage', {
		anchors: ['firstPage', 'secondPage', '3rdPage'],
		navigation:true,
		showActiveTooltip: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				//$('#header').addClass("background-white");
				//$('.Gnb').css('border-bottom','0');
				//$('.Gnb').css('background','none');
				//$('.tnb').css('background','none');
			}  else if( destination.index == 1 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}	else if( destination.index == 2 ) {				
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}  else if( destination.index == 3 ) {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			} else {
				//$('#header').removeClass("background-white");
				//$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				//$('.Gnb').css('background','#fff');
				//$('.tnb').css('background','#fff');
			}
		},
		afterResponsive: function(isResponsive){}
	});
};

fullPage();

// 모바일일 경우 fullpage 미사용
if ( $(window).width() < 1025 ) {
	if ($('#fullpage').hasClass('fp-destroyed')){
	} else {
		fullpage_api.destroy('all');
	}
} else {
	fullPage();
};

// 리사이즈 될때 모바일 화면에서 fullpage 미사용
$( window ).resize( function(e) {
	if ( $(window).width() < 1025 ) {
		if ($('#fullpage').hasClass('fp-destroyed')){
		} else {
			fullpage_api.destroy('all');
		}
	} else {
		fullPage();
	};
});
</script>

