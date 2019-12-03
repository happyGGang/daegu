<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<tiles:insertAttribute name="header" />
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
		var checkInput = $this.parent().find('input');
		var popupId = checkInput.val();
		if (checkInput.prop('checked')) {
			var todayDate = new Date();
			todayDate = new Date(
					parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
			document.cookie = popupId + "=no"
					+ "; path=/; expires="
					+ todayDate.toGMTString() + ";"
		}

		$('div#' + popupId).hide();
	});

	//팝업 키보드로 닫기
	$('.close-btn').on('keydown', function(e) {
		if(e.keyCode==32){
			$('html, body').animate({scrollTop: 0 }, 'fast');  //spacebar 바로 인해 내려간 화면을 다시 올려줌
			var $this = $(this);
			var checkInput = $this.parent().find('input');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";"
			}
			$('div#' + popupId).hide();
		}
	});


	$('input[id*=pop]').on('click', function(e) {
		e.preventDefault();
		$(this).prop('checked', true);
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
<%--
	if(getCookie("1513776125246") != "=checked") {
		selfID = window.open("/resources/homepage/elib/elib_20171220.html","popup_48","width=412,height=420,top=200,left=150,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no");
		selfID.opener = self;
	}
--%>

	<%-- 팝업존 --%>
	if($('.popup-list ul li').length > 0) {
		$('.popup-list ul').bxSlider({
			auto: true,
			responsive: true,
			autoControls: true,
			pagerType:'short'
		});
	}

	$('.site-menu-link-title').on('click', function(){

		var boxText = $(this).next('dd');
		var toggleState = $(boxText).is(':hidden');
		if (toggleState)
		{
			$(boxText).slideToggle();
		} else {
			$(boxText).slideToggle();
		}
	});


});

function getCookie(name){
	 var nameOfCookie = name;
	 var x = 0;
	 while ( x <= document.cookie.length ) {
	 	var y = (x+nameOfCookie.length);
	    if ( document.cookie.substring( x, y ) == nameOfCookie ) {
	    	if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) endOfCookie = document.cookie.length;
	   		return unescape( document.cookie.substring( y, endOfCookie ) );
	    }
	 	x = document.cookie.indexOf( " ", x ) + 1;
	 	if ( x == 0 ) break;
	 }
	 return "";
}
</script>

<div id="wrap">

	<div id="header">
		<tiles:insertAttribute name="top" />
		<tiles:insertAttribute name="topMenu" />
	</div>

	<div class="popupWrap section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}"/>
		</div>
	</div>

	<div id="container" class="main container">

		<div class="section">
			<div class="search-box">
				<form id="mainSearchForm" method="POST" action="/${homepage.context_path}/module/elib/search/index.do">
					<input type="hidden" name="menu_idx" value="2">
					<fieldset>
						<legend class="blind">통합검색</legend>
						<div class="box">
							<div class="b1">
								<input type="text" class="text" name="search_text" id="search_text" placeholder="찾으시는 도서정보를 입력해주세요!"/>
							</div>
							<div class="b2">
								<button id="main-search-btn"><img src="/resources/homepage/${homepage.context_path}/img/search-btn.png" alt="검색"></button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>

		<div class="section">
			<div class="left-section">
				<div class="quick">
					<ul class='ico'>
						<li>
						<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=17&menu=CATEGORY&type=EBK&parent_id=1158" class="quick01">
							<div class="ebook-box">
								<h4>전자책</h4>
								<p>누구나 쉽고<Br/>간편하게 E-book</p>
							</div>
						</a>
						</li>
						<li>
						<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=30&menu=CATEGORY&type=WEB&parent_id=1136" class="quick02">
							<div class="audiobook-box">
								<h4>오디오북</h4>
								<p>귀로듣는<Br/>디지털컨텐츠<br/>오디오북!</p>
							</div>
						</a>
						</li>
						<li>
						<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=30&menu=CATEGORY&type=WEB&parent_id=1132" class="quick03">
							<div class="eearning-box">
								<h4>이러닝</h4>
								<p>온라인강좌 및<br/>온라인 동영상</p>
							</div>
						</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="right-section">
				<div class="quick">
					<ul>
						<li>
						<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=17&menu=CATEGORY&type=EBK&parent_id=1158" class="quick01">
							<div class="electronic-box">
								<h4>전자저널</h4>
								<p>온라인<Br/>정기 간행물</p>
							</div>
						</a>
						</li>
						<li>
						<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=30&menu=CATEGORY&type=WEB&parent_id=1136" class="quick02">
							<div class="webdb-box">
								<h4>웹DB</h4>
								<p>온라인 원문DB<Br/>구독 서비스</p>
							</div>
						</a>
						</li>
						<li>
						<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=30&menu=CATEGORY&type=WEB&parent_id=1132" class="quick03">
							<div class="busan-box">
								<h4>부산자료</h4>
								<p>부산지 보유의<Br/>다양한 전자자료</p>
							</div>
						</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="center-section">
				<div class="visual">
					<ul>
						<li><a href="#;"><img src="/resources/homepage/${homepage.context_path}/img/popzone01.png" alt="생활속의 스마트 도서관"></a></li>
						<!-- <li><a href="#;"><img src="/resources/homepage/${homepage.context_path}/img/popzone01.png" alt="내 손안의 작은도서관"></a></li> -->
					</ul>
				</div>

				<div class="warning">
					<ul>
						<li class="notice-section">
							<!-- notice -->
							<div class="notice">
								<div class="tit"><strong>도서관소식</strong></div>
								<div class="cont">
									<ul>
									<!--
										<c:forEach var="i" varStatus="status" items="${noticeList}" >
										<li>
											<a href="/${homepage.context_path}/board/view.do?menu_idx=30&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
												${i.title}
											</a>
										</li>
										</c:forEach>
									-->
										<li><a href="#;">전자책 모바일 대출반납 PUSH 알림.. </a></li>
										<li><a href="#;">2017년 책누리서비스 만족도 조사.. </a></li>
										<li><a href="#;">매월 마지막 주 수요일 문화가 있는 날..</a></li>
									</ul>
									<a href="/${homepage.context_path}/board/index.do?menu_idx=30&manage_idx=216" class="btn-link-more"><img src="/resources/homepage/${homepage.context_path}/img/more-btn01.png" alt="이용안내 더보기"></a>
								</div>
							</div>
						</li>
						<li class='use-section'>
							<a href="javascript:alert('준비중입니다.');">
								<div class="guide-box">
									<h4>전자도서관<br/><b>이용안내</b></h4>
									<p>전자도서관 이렇게 이용하세요!</p>
									<span class="more-btn">
										<img src="/resources/homepage/${homepage.context_path}/img/more-btn02.png" alt="이용안내 더보기">
									</span>
								</div>
							</a>
						</li>
					</ul>
				</div>

				<div class="quick-link">
					<h3>부산지역 전자도서관</h3>
					<ul>
						<li><a href="#;"><img src="/resources/homepage/${homepage.context_path}/img/icon06.png" alt="시민도서관"><br/>시민도서관</a></li>
						<li><a href="#;"><img src="/resources/homepage/${homepage.context_path}/img/icon07.png" alt="공공도서관"><br/>공공도서관</a></li>
						<li><a href="#;"><img src="/resources/homepage/${homepage.context_path}/img/icon08.png" alt="영어도서관"><br/>영어도서관</a></li>
					</ul>
				</div>
			</div>


			<div class="end"></div>
		</div>
		
		<div class="section web-view">

			<div class="new-book">
				<h3>새로 들어온 책</h3>
				<div>
					<ul>
						<li>
							<div class="normalnewbook">
								<h4 class="normal-ebook">일반전자책</h4>
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">미래공부</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책" class="newbook-ribon"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">빨강 머리 앤</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li>
							<div class="childnewbook">
								<h4 class="child-ebook">어린이전자책</h4>
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">소소여행</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">누구때문일까요</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li>
							<div class="normalaudionewbook">
								<h4 class="normal-audiobook">오디오북</h4>
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">100세 철학자의..</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">빨강 머리 앤</span></a>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>

			<div class="best-book">
				<h3>대출이 많은 책</h3>
				<div class="">
					<ul>
						<li>
							<div class="normalbestbook">
								<h4 class="normal-ebook">일반전자책</h4>
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">미래가 두려운 너에게</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">퇴근길 인문학 수업</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li>
							<div class="childbestbook">
								<h4 class="child-ebook">어린이전자책</h4>
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">아름다움의 진화</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">무례한 사람에게..</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li>
							<div class="normalaudiobestbook">
								<h4 class="normal-audiobook">오디오북</h4>
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">선량한 차별주의자</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">세가지 질문</span></a>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>

		</div>

		<div class="section mobile-view">

			<div class="new-book tabS">
				<h3>새로 들어온 책</h3>

				<ul class="tabMenuS">
					<li class="on"><a href="#tab1" data-link="/elib/board/index.do?menu_idx=31&manage_idx=415" class="normalebook">일반전자책</a></li>
					<li><a href="#tab2" data-link="/elib/board/index.do?menu_idx=32&manage_idx=416" class="childebook">어린이전자책</a></li>
					<li><a href="#tab3" data-link="/elib/board/index.do?menu_idx=32&manage_idx=416" class="normalaudiobook">오디오북</a></li>
				</ul>

				<div>
					<ul>
						<li class="con" data-tab="tab1">
							<div class="mnormalnewbook">
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">미래공부</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책" class="newbook-ribon"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">빨강 머리 앤</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li class="con hid" data-tab="tab2">
							<div class="mchildnewbook">
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">소소여행</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">누구때문일까요</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li class="con hid" data-tab="tab3">
							<div class="mnormalaudionewbook">
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">100세 철학자의..</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/newbook-ribon.png" alt="새로들어온책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">빨강 머리 앤</span></a>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>

			<div class="best-book tabA">
				<h3>대출이 많은 책</h3>

				<ul class="tabMenuA">
					<li class="on"><a href="#tabs1" data-link="/elib/board/index.do?menu_idx=31&manage_idx=415" class="normalebook">일반전자책</a></li>
					<li><a href="#tabs2" data-link="/elib/board/index.do?menu_idx=32&manage_idx=416" class="childebook">어린이전자책</a></li>
					<li><a href="#tabs3" data-link="/elib/board/index.do?menu_idx=32&manage_idx=416" class="normalaudiobook">오디오북</a></li>
				</ul>

				<div class="">
					<ul>
						<li class="con" data-tab="tabs1">
							<div class="mnormalbestbook">
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">미래가 두려운 너에게</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">퇴근길 인문학 수업</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li class="con hid" data-tab="tabs2">
							<div class="mchildbestbook">
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">아름다움의 진화</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">무례한 사람에게..</span></a>
									</li>
								</ul>
							</div>
						</li>
						<li class="con hid" data-tab="tabs3">
							<div class="mnormalaudiobestbook">
								<ul>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">선량한 차별주의자</span></a>
									</li>
									<li>
										<span class="ribon-img"><img src="/resources/homepage/${homepage.context_path}/img/bestbook-ribon.png" alt="대출이많은책"></span>
										<a href="#"><img src="/resources/homepage/${homepage.context_path}/img/book_cover.gif" alt=""><br/><span class="">세가지 질문</span></a>
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>

		</div>
	</div>

	<div id="footer">
		<tiles:insertAttribute name="footer" />
	</div>

</div>


<script>
$(function() {

	$('.normalnewbook ul').bxSlider({
		auto:false,
		maxSlides:2,
		slideWidth:148,
		slideMargin:15,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.childnewbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:148,
		slideMargin:15,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.normalaudionewbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:148,
		slideMargin:15,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.normalbestbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:148,
		slideMargin:15,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.childbestbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:148,
		slideMargin:15,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.normalaudiobestbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:148,
		slideMargin:15,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.mnormalnewbook ul').bxSlider({
		auto:false,
		maxSlides:2,
		slideWidth:140,
		slideMargin:13,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.mchildnewbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:140,
		slideMargin:13,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.mnormalaudionewbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:140,
		slideMargin:13,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.mnormalbestbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:140,
		slideMargin:13,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.mchildbestbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:140,
		slideMargin:13,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$('.mnormalaudiobestbook ul').bxSlider({
		auto:false,
		maxSlides : 2,
		slideWidth:140,
		slideMargin:13,
		moveSlides:1,
		pager:false,
		controls: true,
		autoControlsCombine:true});

	$(document).on('click', '.tabMenuS a', function(e){
		e.preventDefault();

		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tabS');
		var moreUrl = $(this).data('link');

		$(this).closest('.tabMenuS').find('li').removeClass('on');
		$(this).parent('li').addClass('on');

		$box.find('.con').hide();
		$box.find('[data-tab="'+target+'"]').show();
		$box.find('.more-more').attr('href', moreUrl);

	});

	$(document).on('click', '.tabMenuA a', function(e){
		e.preventDefault();

		var target = this.getAttribute('href').replace('#','');
		var $box = $(this).closest('.tabA');
		var moreUrl = $(this).data('link');

		$(this).closest('.tabMenuA').find('li').removeClass('on');
		$(this).parent('li').addClass('on');

		$box.find('.con').hide();
		$box.find('[data-tab="'+target+'"]').show();
		$box.find('.more-more').attr('href', moreUrl);

	});

	$('.hid').hide();

});
</script>

</body>
</html>
