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

					<div class="shareArea">
						<ul>
							<li><a href="#" onclick="contentPrint();"><img src="/resources/common/img/sub-icon02.png" alt="현재페이지 인쇄"></a></li>
							<li><a href="#" class="shareBtn snsBtn"><img src="/resources/common/img/sub-icon01.png" alt="sns 바로가기"></a>

									<div id="share_layer">
										<div class="shareAllBtns" >
											<ul class="shareBox">
												<li><a href="" class="sub-facebook" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/common/img/sns_facebook_btn.png" alt="${homepage.homepage_name} 페이스북 바로가기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>
												<li><a href="" class="sub-twitter" keyValue1="${homepage.homepage_id}" keyValue2="${menuOne.menu_idx}" keyValue3="${menuOne.menu_name}" keyValue4="${homepage.homepage_name}"><img src="/resources/common/img/sns_twitter_btn.png" alt="${homepage.homepage_name} 트위터로 공유하기" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"></a></li>
												<li><a href="#" id="closeshareBox" class="close shareIconArea" title="닫기" ><img src="/resources/common/img/sns-close.png" alt="sns-close" class="shareIcon" style="padding-left:3px;padding-right:3px;margin:0"/></a></li>
											</ul>
										</div>
									</div>

							</li>
							<li class="last"><a href="" class="sub-qrcode" keyValue="true"><img src="/resources/common/img/sub-icon03.png" alt="qr코드 보기"></a></li>
						</ul>
					</div>