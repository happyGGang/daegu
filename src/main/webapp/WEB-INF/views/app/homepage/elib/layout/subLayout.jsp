<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/homepage/elib/css/sub_default.css"/>
<c:choose>
<c:when test="${param.type == 'EBK'}">
<c:set var="label"				value="전자책"/>
<c:set var="menu_idx_new"       value="14"/>
<c:set var="menu_idx_best"      value="15"/>
<c:set var="menu_idx_recommend" value="16"/>
<c:set var="menu_idx_category"  value="17"/>
<c:set var="menu_idx_provider"  value="14"/>
<c:set var="menu_idx_device"    value="49"/>
</c:when>
<c:when test="${param.type == 'ADO'}">
<c:set var="label"				value="오디오북"/>
<c:set var="menu_idx_new"       value="19"/>
<c:set var="menu_idx_best"      value="20"/>
<c:set var="menu_idx_recommend" value="21"/>
<c:set var="menu_idx_category"  value="22"/>
<c:set var="menu_idx_provider"  value="97"/>
<c:set var="menu_idx_device"    value="50"/>
</c:when>
<c:when test="${param.type == 'WEB'}">
<c:set var="label"				value="강좌"/>
<c:set var="menu_idx_new"       value="27"/>
<c:set var="menu_idx_best"      value="28"/>
<c:set var="menu_idx_category" value="30"/>
<c:set var="menu_idx_provider" value="51"/>
</c:when>
</c:choose>
<script type="text/javascript">
$(function() {
	$('li#menu_${menuOne.parent_menu_idx }').addClass('active');
	$('li#menu_${menuOne.menu_idx}').addClass('active');
	var halbaeNode = $('li#menu_${menuOne.parent_menu_idx }').parent().parent()[0];
	if ( halbaeNode != null && halbaeNode.nodeName == 'LI' ) {
		$(halbaeNode).addClass('active');
	}

	$('a.elib-left-menu').on('click', function(e) {
		e.preventDefault();
		var url = '/${homepage.context_path}/module/elib/book/index.do';
		var formData = 'menu_idx=' + $(this).data('menu_idx') + '&menu=' + $(this).data('menu') + '&type=${fn:escapeXml(param.type)}&' + $(this).data('key');
		doGetLoad(url, formData);
	});

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

	$('#homeup').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});

	if (location.href.indexOf('html.do?') > -1) {
// 		$('div#menuRatingDiv').load('/${homepage.context_path}/module/menuRating/index.do?menu_idx=${param.menu_idx}');
	}

	$('.Gnb .gnb-menu > li.menu7').remove();

	$('#footer .address .info a').css('color','#3c3c3c')
});
</script>

<div id="wrap" style="background:#fff;">

	<div id="subheader">
		<tiles:insertAttribute name="top" />
		<tiles:insertAttribute name="topMenu" />

		<div class="sub-search">

			<div class="sectionxs">
				<h1>
					<span class="line"></span>
					${menuOne.menu_name}
				</h1>
			</div>

		</div>

		<div class="qmenu sublink">
			<div style="overflow:hidden;">
				<ul data-call="bxslider" data-breaks="[{screen:0, slides:4},{screen:340, slides:4},{screen:450, slides:5},{screen:600, slides:5},{screen:767, slides:5},{screen:1000, slides:8}]">
					<li><a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=14&amp;menu=NEW&amp;type=EBK"><img src="/resources/homepage/elib/img/icon001.png" alt="소장형전자책 바로가기"><br/>소장형전자책</a></li>
					<li><a href="/${homepage.context_path}/html/gudok.do?menu_idx=93"><img src="/resources/homepage/elib/img/icon010.png" alt="구독형전자책 바로가기"><br/>구독형전자책</a></li>
					<li><a href="/${homepage.context_path}/module/elib/book/index.do?menu_idx=19&menu=NEW&type=ADO"><img src="/resources/homepage/elib/img/icon002.png" alt=""><br/>오디오북</a></li>
					<li><a href="/${homepage.context_path}/html/elearning.do?menu_idx=99"><img src="/resources/homepage/elib/img/icon003.png" alt="E-러닝 바로가기"><br/>E-러닝</a></li>
					<li><a href="/${homepage.context_path}/html.do?menu_idx=24"><img src="/resources/homepage/elib/img/icon004.png" alt="웹DB 바로가기"><br/>웹DB</a></li>
					<li><a href="/${homepage.context_path}/intro/login/mobileCard.do?menu_idx=81"><img src="/resources/homepage/elib/img/icon006.png" alt="모바일회원증 바로가기"><br/>모바일회원증</a></li>
					<li><a href="/${homepage.context_path}/html.do?menu_idx=31"><img src="/resources/homepage/elib/img/icon007.png" alt="이용안내 바로가기"><br/>이용안내</a></li>
					<li><a href="/${homepage.context_path}/module/elib/lending/index.do?menu_idx=39&menu=LENDING"><img src="/resources/homepage/elib/img/icon008.png" alt="나의도서관 바로가기"><br/>나의도서관</a></li>
				</ul>
			</div>
		</div>

	</div>

	<div id="sub-container" class="sub container">
		<div class="doc-info">
			<div class="section page-navigation">
				<ol>
					<li class="first">
						<a href="/${homepage.context_path}/index.do">
							<img src="/resources/homepage/elib/img/home-loc.png" alt="HOME">
						</a>
					</li>
					<homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}"/>
				</ol>

				<jsp:include page="/WEB-INF/views/app/homepage/${homepage.context_path}/snsShareBox.jsp" flush="false" />
				<div class="end"></div>
			</div>
		</div>

		<div class="section">
			<c:if test="${menuOne ne null}">
			<div class="lnb">
				<h2><b>${fn:escapeXml(menuLeftList[0].menu_name)}</b></h2>
				<c:choose>
				<c:when test="${param.type == 'EBK' || param.type == 'ADO' || param.type == 'WEB'}">
				<ul class="SubMenu">
					<li id="menu_${menu_idx_new}"<c:if test="${param.menu_idx == menu_idx_new}"> class="active"</c:if>><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_new}&menu=NEW&type=${fn:escapeXml(param.type)}"><span>신착${label}</span></a></li>
					<c:choose>
					<c:when test="${param.type == 'EBK'}">
					<li id="menu_${menu_idx_best}"<c:if test="${param.menu_idx == menu_idx_best}"> class="active"</c:if>><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_best}&menu=BEST&type=${fn:escapeXml(param.type)}"><span>인기${label}</span></a></li>
					</c:when>
					<c:otherwise>
					<li id="menu_${menu_idx_best}"<c:if test="${param.menu_idx == menu_idx_best}"> class="active"</c:if>><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_best}&menu=RECOMMEND&type=${fn:escapeXml(param.type)}"><span>인기${label}</span></a></li>
					</c:otherwise>
					</c:choose>
					<!-- <li id="menu_${menu_idx_recommend}"<c:if test="${param.menu_idx == menu_idx_recommend}"> class="active"</c:if>><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_recommend}&menu=RECOMMEND&type=${fn:escapeXml(param.type)}"><span>좋아요순</span></a></li> -->
				</ul>
					<ul class="SubMenu">
						<c:if test="${not empty categoryMenuList}">
							<li id="menu_${menu_idx_category}"><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_category}&menu=CATEGORY&type=${fn:escapeXml(param.type)}">주제별</a>
								<ul class="SubMenu" style="display: block;">
									<c:forEach items="${categoryMenuList}" var="i" varStatus="status">
										<li style="line-height: 0%;"<c:if test="${param.parent_id == i.cate_id}"> class="active"</c:if>>
											<br/>
											<a href="#" class="elib-left-menu" style="padding:20px 30px;" data-key="parent_id=${i.cate_id}" data-menu_idx="${menu_idx_category}" data-menu="CATEGORY">
												<span${fn:length(i.cate_name) >= 10 ? ' style="font-size: 12px;"' : ''}>${i.cate_name}</span>
												<span style="color: #aaa; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span>
											</a><br/>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:if>
						<c:if test="${not empty compMenuList}">
							<li id="menu_${menu_idx_provider}"><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_provider}&menu=PROVIDER&type=${fn:escapeXml(param.type)}">유통사별</a>
								<ul class="SubMenu" style="display: block;">
									<c:forEach items="${compMenuList}" var="i" varStatus="status">
										<c:if test="${i.com_code ne 'ARTN'}">
											<li style="line-height: 0%;"<c:if test="${param.com_code == i.com_code}"> class="active"</c:if>>
												<br/>
												<a href="#" class="elib-left-menu" style="padding:20px 30px;" data-key="com_code=${i.com_code}" data-menu_idx="${menu_idx_provider}" data-menu="PROVIDER">
													<span>${i.comp_name}</span>
													<span style="color: #aaa; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span>
												</a><br/>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:if>
						<!--
				<c:if test="${not empty deviceMenuList}">
				<li id="menu_${menu_idx_device}"><a href="/elib/module/elib/book/index.do?menu_idx=${menu_idx_device}&menu=DEVICE&type=${fn:escapeXml(param.type)}"><span>지원기기별</span></a>
					<ul class="SubMenu" style="display: block;">
						<c:forEach items="${deviceMenuList}" var="i" varStatus="status">
						<li style="line-height: 0%;"<c:if test="${param.device == i.device}"> class="active"</c:if>>
						<br/>
						<a href="#" class="elib-left-menu" style="padding:20px 30px;" data-key="device=${i.device}" data-menu_idx="${menu_idx_device}" data-menu="DEVICE">
							<span>${i.label}</span>
							<p style="color: #aaa; font-weight: normal; font-size: 12px; margin-top: 10px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</p>
						</a><br/>
						</li>
						</c:forEach>
					</ul>
				</li>
				</c:if>
				-->
				<c:if test="${param.type == 'EBK'}">
				<li class="2Depth menu_94"><a href="/elib/board/index.do?menu_idx=94&manage_idx=944" ><span>북큐레이션</span></a></li>
				<li class="2Depth menu_93"><a href="/elib/html/kyobogudok.do?menu_idx=93" ><span>구독형전자책</span></a></li></ul></li>
				</c:if>
				<c:if test="${param.type == 'ADO'}">
				<!-- <li id="menu_86"><a href="/elib/module/elib/asp/contents/audio.do?menu_idx=86" ><span>오디언소리</span></a></li> -->
				</c:if>
			</ul>
				</c:when>
				<c:otherwise>
				<homepageTag:leftMenu menuList="${menuLeftList}"/>
				</c:otherwise>
				</c:choose>
			</div>
			</c:if>
			<div class="content">

				<div class="doc">
					<div class="doc-head">
						<!--div class="doc-title">
							<h3>${menuOne.menu_name}</h3>
						</div-->
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

			<div class="end"></div>
		</div>
	</div>


	<div id="footer" style="border-top:1px solid #ebebeb;">
		<tiles:insertAttribute name="footer" />
	</div>

</div>
