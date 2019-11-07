<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<script>
$(document).ready(function() {
	$('.Gnb li li ul').show();
});
</script>
<div id="wrap" class="section">
	
	<nav id="menu"></nav>

	<div id="header">
		<div class="logo">
			<h1><a href="/pms/board/index.do?menu_idx=1&manage_idx=563&category_idx=001">프로젝트 <b>관리사이트</b></a></h1>
<!-- 			<p>축적된 노하우, 온라인과 오프라인 전략</p> -->
<!-- 			<p>e-business의 모든것!</p> -->
		</div>
		<div class="mmode m-menu">
			<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
		</div>
		<div class="call" style="padding-top: 10px; padding-bottom: 10px;">
			<span><a href="#" onclick="javascript:parent.location.href='/cms/index.do'; return false;" style="color: #fff;" >[CMS 바로가기]</a></span>
		</div>
		<div class="Gnb">
			<div class="g-menu">					
				<homepageTag:menuList menuList="${menuTreeList}" startDeps="1" subTagClass="${fn:split('active, , , ',',')}" activeMenu="${menuOne.menu_idx}"/>
			</div>
		</div>
		<div class="call">
			<span>HELP DESK</span>
			<p>053-810-9923</p>
			<em>토/일 제외 평일 18:00 까지<br/><br/></em>
			<em>주중 연락처<br/></em>
			<em>자료관리시스템  :  070-7829-5500<br/></em>
			<em>홈페이지  :  053-422-4728<br/></em>
			<em>디자인 :  053-956-8235<br/></em>
			<em>좌석예약시스템 :  010-3154-4562<br/></em>
			<br/>
			<em>주말 긴급연락처<br/></em>
			<em>자료관리시스템  :  070-7829-5500<br/></em>
			<em>홈페이지  :  010-8506-9542<br/></em>
			<em>디자인 :  053-956-8235<br/></em>
			<em>좌석예약시스템 :   010-3154-4562<br/></em>
		</div>
		<tiles:insertAttribute name="footer" />
	</div>

	<div id="container">
		<div class="container">
			<div class="tnb">
				<a href="/pms/index.do">처음으로</a>
				<span class="txt-bar"></span>
				<a href="/pms/login/logout.do">로그아웃</a>
			</div>
			<div class="container_box">

				<div class="subpage">
					<div class="content">
						<div class="doc">
							<div class="doc-head">
								<div class="doc-title">
									<h3>${menuOne.menu_name }</h3>
								</div>
							</div>
							<div class="doc-body" id="contentArea">
								<div class="body">
									<!-- 본문 s -->
									<tiles:insertAttribute name="body" />
									<!-- 본문 e -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<tiles:insertAttribute name="footer" />
	</div>
</div>

</body>
</html>