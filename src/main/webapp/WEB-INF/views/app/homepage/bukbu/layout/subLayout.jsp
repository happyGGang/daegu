<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
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
		$('div#menuRatingDiv').load('/${homepage.context_path}/module/menuRating/index.do?menu_idx=${param.menu_idx}');
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
						<li class="first"><a href="/${homepage.context_path}/index.do"><i class="fa fa-home"></i></a></li>
						<homepageTag:docInfo oneMenu="${menuOne}" menuList="${menuLeftList}"/>
					</ol>
					<jsp:include page="/WEB-INF/views/app/homepage/common/snsShareBox.jsp" flush="false" />
					<div class="end"></div>
				</div>
			</div>
		</div>

		<div class="section">
			<c:if test="${menuOne ne null}">
			<div class="lnb">
				<h2 style="margin-top:-159px;"><b>${menuLeftList[0].menu_name}</b></h2>
				<homepageTag:leftMenu menuList="${menuLeftList}"/>
			</div>
			</c:if>
			<div class="content">
				<div class="doc">
					<div class="doc-head">
						<div class="doc-title">
							<h3>${menuOne.menu_name}</h3>
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

		<div id="quick-slide" style="margin-top:220px;">
			<h4><img src="/resources/homepage/${homepage.context_path}/img/quick-title.png" alt="퀵메뉴"/></h4>
			<ul>
				<li><a href="#"><span class="txt">디지털 정보코너<Br/>좌석예약</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=26"><span class="txt">희망도서신청</span></a></li>
				<li><a href="#"><span class="txt">도서예약</span></a></li>
				<li><a href="/${homepage.context_path}/board/index.do?menu_idx=60&manage_idx=157"><span class="txt">영화상영일정</span></a></li>
				<li><a href="/${homepage.context_path}/module/teach/index.do?menu_idx=30"><span class="txt">수강신청</span></a></li>
				<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=16"><span class="txt">대출현황</span></a></li>
				<li><a href="/${homepage.context_path}/html.do?menu_idx=104"><span class="txt">이용안내</span></a></li>
				<!--<li><a href="/${homepage.context_path}/html.do?menu_idx=48"><span class="txt">책바다신청</span></a></li>-->
				<li><a href="/${homepage.context_path}/board/index.do?menu_idx=65&manage_idx=148"><span class="txt">묻고답하기</span></a></li>
				<li><a href="/${homepage.context_path}/board/index.do?menu_idx=36&manage_idx=1"><span class="txt">공지사항</span></a></li>
				<!--<li><a href="/${homepage.context_path}"><span class="txt">업무추진비<Br/>집행내역</span></a></li>
				<li><a href="/${homepage.context_path}/bukbu/html.do?menu_idx=78"><span class="txt">행정정보공개</span></a></li>-->
			</ul>
		</div>
	</div>

</div>

<tiles:insertAttribute name="footer" />