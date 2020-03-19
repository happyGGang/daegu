<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	$('a.shareBtn').on('click', function(e) {
		if($('div#share_layer').css('display') == 'none') {
			$('div#share_layer').show();
			$('div.shareAllBtn').show();
			e.preventDefault();
		} else {
			$('div#share_layer').hide();
			$('div.shareAllBtn').hide();
			e.preventDefault();
		}
	});
	$('a#closeshareBox').on('click', function(e) {
		$('a.shareBtn').focus();
		$('div#share_layer').hide();
	});

	$(window).scroll(function(){
		if($(this).scrollTop() > 0 ) {
			$('div#share_layer').hide();
		}
	});
});
</script>


<ul>
	<c:if test="${member.loginType eq 'CMS' and member.login}">
		<!-- <li class="modify"><a href="/cms/menu/${homepage.context_path}/htmlEdit.do?menu_idx=${menuOne.menu_idx}">본문내용 수정</a></li> -->
	</c:if>
	<li class="print"><a href="#" class="noBox" title="새창열림"  onclick="contentPrint(); return false;"><img src="/resources/homepage/${homepage.context_path}/img/print.png" alt="페이지 내용 인쇄" ></a></li>
	<li style="position:relative" class="sns"><a href="" class="noBox shareBtn snsBtn"><img src="/resources/homepage/${homepage.context_path}/img/sns.png" alt="SNS 공유 목록" class="shareBtn"/></a>
		<div id="shareBtnArea">
			<div class="inbox" id="share_layer" style="display:none;">
				<div class="shareAllBtns" >
					<ul class="shareBox">
						<li><a href="#" class="sub-kakao shareIconArea"    title="새창열림"  keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/homepage/${homepage.context_path}/img/sns_kakaostory_btn.png"  alt="카카오스토리 공유" class="shareIcon"/></a></li>     
						<li><a href="#" class="sub-facebook shareIconArea" title="새창열림"  keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/homepage/${homepage.context_path}/img/sns_facebook_btn.png" alt="페이스북 공유" class="shareIcon"/></a></li>
						<li><a href="#" class="sub-twitter shareIconArea"  title="새창열림"  keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/homepage/${homepage.context_path}/img/sns_twitter_btn.png" alt="트위터 공유" class="shareIcon"/></a></li>
						<li><a href="#" id="closeshareBox" class="close shareIconArea" title="닫기" ><img src="/resources/homepage/${homepage.context_path}/img/sns-close.png" alt="sns-close" class="shareIcon"/></a></li>   
					</ul>
				</div>
			</div>
		</div>
	</li>
	<li class="cord"><a href="" class="sub-qrcode noBox" keyValue="true"><img src="/resources/homepage/${homepage.context_path}/img/qr.png" alt="${homepage.homepage_name}"></a></li>
</ul>
