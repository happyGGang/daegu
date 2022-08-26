<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/homepage/${homepage.context_path}/css/sub.css"/>
<script type="text/javascript">
$(function() {
	$('#homeup').click(function () {
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


	$('#header').addClass("background-white");
	$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
	$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
	$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
	$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
	$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');


	$('.Gnb, .tnb').on('mouseenter', function(){
		$('#header').removeClass("background-white");
		$('.Gnb').css('border-bottom','1px solid #e6e6e6');
		$('.Gnb').css('background','#fff');
		$('.tnb').css('background','#fff');
		$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
		$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
		$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
		$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
	});

	$('.Gnb, .tnb').on('mouseleave', function(){
		$('#header').addClass("background-white");
		$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
		$('.Gnb').css('background','none');
		$('.tnb').css('background','none');
		$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
		$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
		$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
		$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
	});

	$(window).on('resize', function(e){
		e.preventDefault();
		var ___width = $(window).width();

		if( ___width > 1024 )
		{

		}
		else if( ___width <= 1024 )
		{

		}
	});
});
</script>

<c:if test="${param.menu_idx eq '8'}">
<script type="text/javascript">
function booksearchsubmit(title)
{
	$('input#search_text_2').val(title);
	$('form#bookSearchForm').submit();
}
</script>

<form id="bookSearchForm" action="/dgportal/intro/search/indexAll.do" target="_blank">
<input type="hidden" name="menu_idx" value="7">
<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
<input type="hidden" name="libraryCodes" class="libCheck lib_AA" value="AA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AL" value="AL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AG" value="AG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AJ" value="AJ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AH" value="AH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AB" value="AB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AC" value="AC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AF" value="AF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AE" value="AE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AD" value="AD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_CA" value="CA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_CB" value="CB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BL" value="BL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BQ" value="BQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BP" value="BP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BM" value="BM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BN" value="BN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BT" value="BT"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BS" value="BS"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BA" value="BA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BB" value="BB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BC" value="BC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FS" value="FS"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BD" value="BD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BE" value="BE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BF" value="BF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BG" value="BG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BH" value="BH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BJ" value="BJ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BK" value="BK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BU" value="BU"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BV" value="BV"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BW" value="BW"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BX" value="BX"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BY" value="BY"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BZ" value="BZ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BR" value="BR"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GR" value="GR"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GS" value="GS"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HJ" value="HJ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FK" value="FK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GT" value="GT"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FP" value="FP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FL" value="FL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GU" value="GU"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GV" value="GV"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GW" value="GW"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GX" value="GX"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GY" value="GY"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FM" value="FM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HK" value="HK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HM" value="HM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HN" value="HN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HP" value="HP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HQ" value="HQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GQ" value="GQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FU" value="FU"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FZ" value="FZ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FH" value="FH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FT" value="FT"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HC" value="HC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FE" value="FE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GL" value="GL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GM" value="GM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GN" value="GN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GP" value="GP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HB" value="HB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HD" value="HD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HE" value="HE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FF" value="FF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FQ" value="FQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FY" value="FY"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GG" value="GG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HA" value="HA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HF" value="HF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FV" value="FV"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FG" value="FG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FA" value="FA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FB" value="FB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FC" value="FC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FD" value="FD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FX" value="FX"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GK" value="GK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AK" value="AK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GA" value="GA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GB" value="GB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HG" value="HG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GD" value="GD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GF" value="GF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GH" value="GH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FR" value="FR"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GE" value="GE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GC" value="GC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FN" value="FN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FJ" value="FJ"/>
<input type="hidden" name="title" id="search_text_2" value="" />
</form>
</c:if>

<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div id="container" class="subpage">

		<div class="sub-visual">
			<div class="doc-name">
				<div class="" style="height:2px;width:3%;margin:0 auto;background:#fff;"></div>
				<h3>${menuOne.menu_name}</h3>
			</div>

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
		</div>

		<div class="sections">
			<c:if test="${menuOne ne null}">
			<div class="lnb">
				<!-- <h2><b>${menuLeftList[0].menu_name}</b></h2> -->
				<homepageTag:leftMenu menuList="${menuLeftList}"/>
			</div>
			</c:if>
			<div class="content">
				<div class="doc">
					<div class="doc-body con${menuOne.menu_idx}" id="contentArea">
						<div class="body">
							<tiles:insertAttribute name="body" />
							<div id="menuRatingDiv"></div>
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

		<div class="home-up web-view">
			<img src="/resources/homepage/dgportal/img/m-top.png" alt="위로" id="homeup">
		</div>

		<div class="home-up mobile-view">
			<img src="/resources/homepage/dgportal/img/m-top.png" alt="위로" id="homeup-mobile">
		</div>
	</div>

</div>



