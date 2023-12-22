<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	if('${menuOne.satisfaction_yn}' == 'Y'){
 		$('div#menuRatingDiv').load('/${homepage.context_path}/module/menuSatisfaction/index.do?menu_idx=${param.menu_idx}');
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
			<div class="doc-info-bg">
			<div class="doc-info">

				<ol>
					<li class="first"><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/archive/img/navi_home_icon.png"></a></li>
					<homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}"/>
				</ol>

				<div class="end"></div>
			</div>
			</div>
		</div>

		<div class="sections">
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
							<h3>${menuOne.menu_name}</h3>
							<div class="shareArea">
								<ul>
									<li><a href="#" class="shareBtn snsBtn"><img src="/resources/homepage/archive/img/sub-icon01.png" alt="sns 바로가기"></a>

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
									<li class="last"><a href="#" onclick="contentPrint();"><img src="/resources/homepage/archive/img/sub-icon02.png" alt="현재페이지 인쇄"></a></li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
					</div>
					<div class="doc-body con${menuOne.menu_idx}" id="contentArea">
						<div class="body">
							<tiles:insertAttribute name="body" />
							<div id="menuRatingDiv"></div>
						</div>
					</div>
					<c:if test="${menuOne.manage_view_yn eq 'Y'}">	
						<c:if test="${menuOne.manager_dept1 ne null and menuOne.manager_dept1 ne '' and menuOne.manager_name1 ne null and menuOne.manager_name1 ne '' and menuOne.manager_phone1 ne null and menuOne.manager_phone1 ne ''
										or menuOne.manager_dept2 ne null and menuOne.manager_dept2 ne '' and menuOne.manager_name2 ne null and menuOne.manager_name2 ne '' and menuOne.manager_phone2 ne null and menuOne.manager_phone2 ne ''
										or menuOne.manager_dept3 ne null and menuOne.manager_dept3 ne '' and menuOne.manager_name3 ne null and menuOne.manager_name3 ne '' and menuOne.manager_phone3 ne null and menuOne.manager_phone3 ne ''
										or menuOne.manager_dept4 ne null and menuOne.manager_dept4 ne '' and menuOne.manager_name4 ne null and menuOne.manager_name4 ne '' and menuOne.manager_phone4 ne null and menuOne.manager_phone4 ne ''
										or menuOne.manager_dept5 ne null and menuOne.manager_dept5 ne '' and menuOne.manager_name5 ne null and menuOne.manager_name5 ne '' and menuOne.manager_phone5 ne null and menuOne.manager_phone5 ne ''}">						
							<div class="doc-admin">
								<c:if test="${menuOne.manager_dept1 ne null and menuOne.manager_dept1 ne '' and menuOne.manager_name1 ne null and menuOne.manager_name1 ne '' and menuOne.manager_phone1 ne null and menuOne.manager_phone1 ne ''}">
									<div class="manager-box">
									<c:if test="${menuOne.manager_dept1 ne null and menuOne.manager_dept1 ne ''}"><span><label style="letter-spacing:-1px;">담당부서</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_dept1}</em></span></c:if>
									<c:if test="${menuOne.manager_name1 ne null and menuOne.manager_name1 ne ''}"><span><label style="letter-spacing:-1px;">담당자</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_name1}</em></span></c:if>
									<c:if test="${menuOne.manager_phone1 ne null and menuOne.manager_phone1 ne ''}"><span><label style="letter-spacing:-1px;">전화번호</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_phone1}</em></span></c:if>
									<span><label style="letter-spacing:-1px;">최종수정일</label> 
										<em style="letter-spacing:-1px;">:
										<c:choose>
											<c:when test="${menuOne.modify_date eq null or menuOne.modify_date eq ''}">
												<fmt:formatDate value="${menuOne.add_date}" pattern="yyyy.MM.dd"/>												
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${menuOne.modify_date}" pattern="yyyy.MM.dd"/>
											</c:otherwise>
										</c:choose> 											
										</em>
									</span>
									</div>
								</c:if>
								<c:if test="${menuOne.manager_dept2 ne null and menuOne.manager_dept2 ne '' and menuOne.manager_name2 ne null and menuOne.manager_name2 ne '' and menuOne.manager_phone2 ne null and menuOne.manager_phone2 ne ''}">				
									<div class="manager-box">
									<c:if test="${menuOne.manager_dept2 ne null and menuOne.manager_dept2 ne ''}"><span><label style="letter-spacing:-1px;">담당부서</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_dept2}</em></span></c:if>
									<c:if test="${menuOne.manager_name2 ne null and menuOne.manager_name2 ne ''}"><span><label style="letter-spacing:-1px;">담당자</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_name2}</em></span></c:if>
									<c:if test="${menuOne.manager_phone2 ne null and menuOne.manager_phone2 ne ''}"><span><label style="letter-spacing:-1px;">전화번호</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_phone2}</em></span></c:if>
									<span><label style="letter-spacing:-1px;">최종수정일</label> 
										<em style="letter-spacing:-1px;">:
										<c:choose>
											<c:when test="${menuOne.modify_date eq null or menuOne.modify_date eq ''}">
												<fmt:formatDate value="${menuOne.add_date}" pattern="yyyy.MM.dd"/>												
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${menuOne.modify_date}" pattern="yyyy.MM.dd"/>
											</c:otherwise>
										</c:choose> 											
										</em>
									</span>
									</div>
								</c:if>
								<c:if test="${menuOne.manager_dept3 ne null and menuOne.manager_dept3 ne '' and menuOne.manager_name3 ne null and menuOne.manager_name3 ne '' and menuOne.manager_phone3 ne null and menuOne.manager_phone3 ne ''}">
									<div class="manager-box">
									<c:if test="${menuOne.manager_dept3 ne null and menuOne.manager_dept3 ne ''}"><span><label style="letter-spacing:-1px;">담당부서</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_dept3}</em></span></c:if>
									<c:if test="${menuOne.manager_name3 ne null and menuOne.manager_name3 ne ''}"><span><label style="letter-spacing:-1px;">담당자</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_name3}</em></span></c:if>
									<c:if test="${menuOne.manager_phone3 ne null and menuOne.manager_phone3 ne ''}"><span><label style="letter-spacing:-1px;">전화번호</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_phone3}</em></span></c:if>
									<span><label style="letter-spacing:-1px;">최종수정일</label> 
										<em style="letter-spacing:-1px;">:
										<c:choose>
											<c:when test="${menuOne.modify_date eq null or menuOne.modify_date eq ''}">
												<fmt:formatDate value="${menuOne.add_date}" pattern="yyyy.MM.dd"/>												
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${menuOne.modify_date}" pattern="yyyy.MM.dd"/>
											</c:otherwise>
										</c:choose> 											
										</em>
									</span>
									</div>
								</c:if>
								<c:if test="${menuOne.manager_dept4 ne null and menuOne.manager_dept4 ne '' and menuOne.manager_name4 ne null and menuOne.manager_name4 ne '' and menuOne.manager_phone4 ne null and menuOne.manager_phone4 ne ''}">
									<div class="manager-box">
									<c:if test="${menuOne.manager_dept4 ne null and menuOne.manager_dept4 ne ''}"><span><label style="letter-spacing:-1px;">담당부서</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_dept4}</em></span></c:if>
									<c:if test="${menuOne.manager_name4 ne null and menuOne.manager_name4 ne ''}"><span><label style="letter-spacing:-1px;">담당자</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_name4}</em></span></c:if>
									<c:if test="${menuOne.manager_phone4 ne null and menuOne.manager_phone4 ne ''}"><span><label style="letter-spacing:-1px;">전화번호</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_phone4}</em></span></c:if>
									<span><label style="letter-spacing:-1px;">최종수정일</label> 
										<em style="letter-spacing:-1px;">:
										<c:choose>
											<c:when test="${menuOne.modify_date eq null or menuOne.modify_date eq ''}">
												<fmt:formatDate value="${menuOne.add_date}" pattern="yyyy.MM.dd"/>												
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${menuOne.modify_date}" pattern="yyyy.MM.dd"/>
											</c:otherwise>
										</c:choose> 											
										</em>
									</span>
									</div>
								</c:if>
								<c:if test="${menuOne.manager_dept5 ne null and menuOne.manager_dept5 ne '' and menuOne.manager_name5 ne null and menuOne.manager_name5 ne '' and menuOne.manager_phone5 ne null and menuOne.manager_phone5 ne ''}">
									<div class="manager-box">
									<c:if test="${menuOne.manager_dept5 ne null and menuOne.manager_dept5 ne ''}"><span><label style="letter-spacing:-1px;">담당부서</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_dept5}</em></span></c:if>
									<c:if test="${menuOne.manager_name5 ne null and menuOne.manager_name5 ne ''}"><span><label style="letter-spacing:-1px;">담당자</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_name5}</em></span></c:if>
									<c:if test="${menuOne.manager_phone5 ne null and menuOne.manager_phone5 ne ''}"><span><label style="letter-spacing:-1px;">전화번호</label> <em style="letter-spacing:-1px;">: ${menuOne.manager_phone5}</em></span></c:if>
									<span><label style="letter-spacing:-1px;">최종수정일</label> 
										<em style="letter-spacing:-1px;">:
										<c:choose>
											<c:when test="${menuOne.modify_date eq null or menuOne.modify_date eq ''}">
												<fmt:formatDate value="${menuOne.add_date}" pattern="yyyy.MM.dd"/>												
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${menuOne.modify_date}" pattern="yyyy.MM.dd"/>
											</c:otherwise>
										</c:choose> 											
										</em>
									</span>
									</div>
								</c:if>	
							</div>
						</c:if>
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



