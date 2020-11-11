<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<script type="text/javascript">
$(function() {
	$('li#menu_${menuOne.parent_menu_idx }').addClass('active');
	$('li#menu_${menuOne.menu_idx}').addClass('active');
	var halbaeNode = $('li#menu_${menuOne.parent_menu_idx }').parent().parent()[0];
	if ( halbaeNode != null && halbaeNode.nodeName == 'LI' ) {
		$(halbaeNode).addClass('active');
	}

	if (location.href.indexOf('html.do?') > -1) {
// 		$('div#menuRatingDiv').load('/${homepage.context_path}/module/menuRating/index.do?menu_idx=${param.menu_idx}');
	}

	<c:choose>
		<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
			$('li#menu_4').remove();
			$('li#menu_5').remove();
			$('li#menu_6').remove();
			$('li#menu_7').remove();
			$('li#menu_8').remove();
		</c:when>
		<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
			$('li#menu_4').remove();
			$('li#menu_5').remove();
			$('li#menu_6').remove();
			$('li#menu_7').remove();
			$('li#menu_8').remove();
		</c:when>
		<c:otherwise>
			$('li#menu_95').remove();
			$('li#menu_96').remove();
		</c:otherwise>
	</c:choose>

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

			<div class="doc-info">
				<div class="doc-title">
					<c:if test="${menuOne.include_menu_name_yn eq 'Y'}">
					<h3>${menuOne.menu_name}</h3>
					</c:if>
					<ol>
						<li class="first"><img src="/resources/common/img/navi_home_icon.gif"></li>
						<homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}"/>
					</ol>

					<div class="shareArea">
						<ul>
							<li><a href="#" onclick="contentPrint();"><img src="/resources/common/img/sub-icon02.png" alt="현재페이지 인쇄"></a></li>
							<li><a href="#" class="shareBtn snsBtn"><img src="/resources/common/img/sub-icon01.png" alt="sns 바로가기"></a>

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
							<li class="last"><a href="" class="sub-qrcode" keyValue="true"><img src="/resources/common/img/sub-icon03.png" alt="qr코드 보기"></a></li>
						</ul>
					</div>

				</div>
				<div class="end"></div>
			</div>

		</div>

		<div class="section">
			<c:if test="${menuOne ne null}">
			<div class="lnb">
				<h2><b>${menuLeftList[0].menu_name}</b></h2>
				<homepageTag:leftMenu menuList="${menuLeftList}"/>
			</div>
			</c:if>
			<div class="content">
				<div class="doc">
					<div class="doc-head">
						<div class="doc-title">
							<c:if test="${menuOne.include_menu_name_yn eq 'Y'}">
							<h3>${menuOne.menu_name}</h3>
							</c:if>

							<!-- <div class="v-img" <c:if test="${not empty menuOne.menu_img}">style="background: url('/data/menu/${menuOne.homepage_id}/${menuOne.menu_img}') no-repeat 100% 0"</c:if>></div> -->
						</div>
					</div>
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

	<tiles:insertAttribute name="footer" />
</div>



