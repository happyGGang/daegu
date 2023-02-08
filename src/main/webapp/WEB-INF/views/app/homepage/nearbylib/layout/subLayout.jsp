<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub.css"/>
<script type="text/javascript" src="/resources/homepage/libculture/js/sub.js"></script>
<script type="text/javascript">
$(function() {
	$('#homeup, .homeup').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});

	$('#homeup-mobile').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});

	$('li#menu_${menuOne.parent_menu_idx }').addClass('active');
	$('li#menu_${menuOne.menu_idx}').addClass('active');
	var halbaeNode = $('li#menu_${menuOne.parent_menu_idx }').parent().parent()[0];
	if ( halbaeNode != null && halbaeNode.nodeName == 'LI' ) {
		$(halbaeNode).addClass('active');
	}

	if (location.href.indexOf('html.do?') > -1) {
		//$('div#menuRatingDiv').load('/${homepage.context_path}/module/menuRating/index.do?menu_idx=${param.menu_idx}');
	}

	$('a.shareBtn').on('click', function(e) {

		if($('div#share_layer').css('display') == 'none') {
			$('div#share_layer').show();
			e.preventDefault();
		} else {
			$('div#share_layer').hide();
			e.preventDefault();
		}

	});

	$('a#closeshareBox').on('click', function(e) {
		e.preventDefault();
		$('div#share_layer').hide();
	});

	$(window).scroll(function(){
		if($(this).scrollTop() > 0 ) {
			$('div#share_layer').hide();
		}
	});

});

</script>

<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div id="container" class="subpage">

		<div class="sub-visual">
			<div class="doc-name">
				<h3>${menuOne.menu_name}</h3>
			</div>

			<!-- 
			<div class="doc-info-bg">
				<div class="doc-info">
					<ol>
						<li class="first"><a href="/${homepage.context_path}/index.do"><i class="fa fa-home"></i></a></li>
						<homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}"/>
					</ol>
					<div class="shareArea">
						<ul>
							<li><a href="#" onclick="contentPrint();"><img src="/resources/homepage/${homepage.context_path}/img/sub-icon02.png" alt="현재페이지 인쇄"></a></li>
							<li><a href="#" class="shareBtn snsBtn"><img src="/resources/homepage/${homepage.context_path}/img/sub-icon01.png" alt="sns 바로가기"></a>

									<div id="share_layer">
										<div class="shareAllBtns" >
											<ul class="shareBox">
												<li><a href="" class="sub-facebook" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/common/img/sns_facebook_btn.png" alt="${homepage.homepage_name} 페이스북 바로가기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>

												<li><a href="" class="sub-twitter" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/common/img/sns_twitter_btn.png" alt="${homepage.homepage_name} 트위터로 공유하기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>

												<li class="last"><a href="" class="sub-kakao" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/common/img/sns_kakaostory_btn.png" alt="${homepage.homepage_name} 카카오스토리 바로가기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>

												<li><a href="#" id="closeshareBox" class="close shareIconArea" title="닫기" ><img src="/resources/common/img/sns-close.png" alt="sns-close" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"/></a></li>
											</ul>
										</div>
									</div>

							</li>
							<li class="last"><a href="" class="sub-qrcode" keyValue="true"><img src="/resources/homepage/${homepage.context_path}/img/sub-icon03.png" alt="qr코드 보기"></a></li>
						</ul>
					</div>
					<div class="end"></div>
				</div>
			</div> 
			-->

			<div class="quick_wrap" id="contents">
				<div class="container">

					<ul class="snb_link">
						<li class="home">
							<a class="icon_home" href="/nearbylib/index.do" title="홈 화면 이동"></a>
						</li>
						<homepageTag:docInfoTopTag oneMenu="${menuOne}" menuList="${menuLeftList}"/>
						<%--<li class="">
							<a href="javascript:void(0);" class="de_menu1">자료연구</a>
							<ul class="L2_Items">
							<li><a href="">행사</a></li>
							<li><a href="">전시</a></li>
							<li><a href="">교육</a></li>
							</ul>
						</li>
						<li class="de_2items">
							<a href="javascript:void(0);" class="de_menu2">문화유산이야기</a>
							<ul class="L2_Items">
							<li><a href="">도서</a></li>
							<li><a href="https://uci.k-heritage.tv/" target="_blank" title="새창">문화유산콘텐츠 검색</a></li>
							</ul>
						</li>--%>
					</ul>
					<div class="sub_rtop">
						<ul class="etc_area">
							<li class="share_box">
								<a href="javascript:void(0);" class="a_btn" title="공유하기"><img src="/resources/homepage/nearbylib/img/sub-icon01.png" class="img35" alt="sns공유하기"></a>
								<ul class="snb_sns">
									<li>
										<a href="javascript:void(0);"  class="share_facebook sub-facebook" target="_blank" title="페이스북 공유하기 새창">
											<img src="https://www.chf.or.kr/_static/chf1/img/sub/sh_facebook.png" alt="Facebook">
											<span class="hide">페이스북으로 공유</span>
										</a>
									</li>
									<li>
										<a href="javascript:void(0);" class="share_twitter sub-twitter" target="_blank" title="트위터 공유하기 새창">
											<img src="https://www.chf.or.kr/_static/chf1/img/sub/sh_twitter.png" alt="Twitter">
											<span class="hide">트위터 공유하기</span>
										</a>
									</li>
									<li>
										<a href="javascript:void(0);" class="share_kakao sub-kakao" target="_blank" title="카카오 공유하기 새창">
											<img src="https://www.chf.or.kr/_static/chf1/img/sub/sh_kakao.png" alt="Kakao">
											<span class="hide">카카오 공유하기</span>
										</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="javascript:void(0);" onclick="javascript:window.print();" title="새창 열림">
									<img src="/resources/homepage/nearbylib/img/sub-icon02.png" class="img35" alt="프린트출력하기">
								</a>
							</li>
							<li>
								<a href="javascript:void(0);" class="qr_cord sub-qrcode" title="QR코드" keyValue="true" ><img src="/resources/homepage/nearbylib/img/sub-icon03.png" class="img35" alt="QR코드"></a>
								<div class="qrBox">
									<a href="javascript:void(0);" class="qrBoxClose" title="QR 코드 닫기">X</a>
									<div id="qrcodeView">

									</div>
									<p>모바일로 QR코드를 스캔하면<br>이 페이지로 바로접속할 수 있습니다.</p>
								</div>
							</li>
						</ul>
					</div><!-- // sub_rtop -->
				</div>
			</div>
		</div>

		<div class="wide-1400-sections">
			<div class="content">
				<div class="doc">
					<div class="doc-body con${menuOne.menu_idx}" id="contentArea">
						<div class="body">

							<tiles:insertAttribute name="body" />

						</div>
					</div>
					<c:if test="${not empty menuOne.manager_dept and not empty menuOne.manager_name and not empty menuOne.manager_phone}">
					<div class="doc-admin">
						<c:if test="${menuOne.manager_dept ne null and menuOne.manager_dept ne ''}"><span><label>담당부서</label> <em>: ${menuOne.manager_dept}</em></span></c:if>
						<c:if test="${menuOne.manager_name ne null and menuOne.manager_name ne ''}"><span><label>담당자</label> <em>: ${menuOne.manager_name}</em></span></c:if>
						<c:if test="${menuOne.manager_phone ne null and menuOne.manager_phone ne ''}"><span><label>전화번호</label> <em>: ${menuOne.manager_phone}</em></span></c:if>
					</div>
					</c:if>
				</div>
			</div>
		</div>

		<div class="end"></div>
	</div>

	<div id="foot_section">
		<tiles:insertAttribute name="footer" />
	</div>

</div>
</body>
</html>