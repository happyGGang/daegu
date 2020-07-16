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
				document.cookie = popupId + "=no" + "; path=/; expires=" + todayDate.toGMTString() + ";"
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
	$('.Gnb .gnb-menu > li.menu7').remove();

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

		<div class="sectionx">
			<div class="mainTitle">
				<div class="title">
					<span>손 끝에서 시작되는</span>
					<strong>가장 스마트한 생활</strong>
					<p>The Smartest Life Starting<Br/>at the End of the Hand</p>
				</div>
			</div>

			<div class="quickMenu">
				<ul>
					<li class="quick-1">
					<a href="/${homepage.context_path}/module/elib/asp/contents/elearning.do?menu_idx=27" title="인기강좌 바로가기" class="quick01">
						<div>
							<h4>인기강좌</h4>
							<p>맞춤형 e-러닝 학습</p>
						</div>
					</a>
					</li>
					<li class="quick-2">
					<a href="/${homepage.context_path}/html.do?menu_idx=24" title="학술DB 홈페이지 바로가기" class="quick02">
						<div>
							<h4>학술DB</h4>
							<p>국내학술지 원문 데이터</p>
						</div>
					</a>
					</li>
					<li class="quick-3">
					<a href="/${homepage.context_path}/html.do?menu_idx=25" title="클래식감상 홈페이지 바로가기(새창열림)" class="quick03">
						<div>
							<h4>클래식감상</h4>
							<p>아름다운 음악 이야기</p>
						</div>
					</a>
					</li>
					<li class="quick-4">
					<a href="/${homepage.context_path}/module/elib/search/index.do?menu_idx=80" title="전자자료검색 바로가기" class="quick04">
						<div>
							<h4>전자자료검색</h4>
							<p>전자자료 통합검색</p>
						</div>
					</a>
					</li>
					<li class="quick-5">
					<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=14&menu=NEW&type=EBK" title="신간 E-BOOK 바로가기" class="quick05">
						<div>
							<h4>신간 E-BOOK</h4>
							<p>신간전자자료</p>
						</div>
					</a>
					</li>
					<li class="quick-6">
					<a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=15&menu=BEST&type=EBK" title="지금 E-BOOK 바로가기" class="quick06">
						<div>
							<h4>지금 E-BOOK</h4>
							<p>베스트전자자료</p>
						</div>
					</a>
					</li>
					<li class="quick-7">
					<a href="/${homepage.context_path}/html.do?menu_idx=31" title="전자도서관 이용안내 바로가기" class="quick07">
						<div>
							<h4 style="color:#000;">전자도서관</h4>
							<p style="color:#000;">이렇게 이용하세요</p>
						</div>
					</a>
					</li>
					<li class="quick-8">
					<a href="/${homepage.context_path}/html.do?menu_idx=85" title="스마트도서관 바로가기"class="quick08">
						<div class="fq">
							<h4>스마트<Br/>도서관</h4>
						</div>
					</a>
					</li>
				</ul>
			</div>
		</div>

		<div class="section">

			<!-- notice -->
			<div class="notice">
				<div class="tit"><strong>NOTICE</strong></div>
				<div class="con">
					<ul>
						<c:forEach var="i" varStatus="status" items="${noticeList}" >
						<fmt:formatDate value="${i.add_date}" pattern="yyyy.MM" var="noticeDate"/>
						<fmt:formatDate value="${i.add_date}" pattern="dd" var="noticeDay"/>
						<li>
							<a href="/${homepage.context_path}/board/view.do?menu_idx=72&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}">
								<span class="day"><b>${noticeDay}</b><br/>${noticeDate}</span>
								<span class="cont">
									<div class="notice-title">
										<span class="notice-alarm">공지</span> <span>${i.title}</span>
									</div>
									<div class="notice-contents">
										${fn:substring(fn:trim(i.content_summary), 0, 50)}...
									</div>
								</span>
								<span class="ico"></span>
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="more-btn center pd30t pd30b">
					<a href="/${homepage.context_path}/board/index.do?menu_idx=72&manage_idx=284"><img src="/resources/homepage/${homepage.context_path}/img/notice-more.png" alt="공지사항 더보기"></a>
				</div>
			</div>

		</div>

	</div>

	<div class="visual-two">
		대구 시민의 스마트한 독서생활이 시작되는 곳
	</div>


	<div id="footer">
		<tiles:insertAttribute name="footer" />
	</div>
</div>


</body>
</html>


