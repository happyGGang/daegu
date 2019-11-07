<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<div id="wrap" class="section">
	<nav id="menu"></nav>

	<div id="header">
		<div class="logo">
			<h1><a href="">경상북도교육청<br />공공도서관<br /><strong>디자인센터</strong></a></h1>
			<p>든든한 미래,시민과 미래를 함께합니다.</p>
		</div>
		<div class="mmode m-menu">
			<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
		</div>
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="g-menu">
				<!-- menu S -->
				<ul class="gnb-menu">
					<c:if test="${member.admin}">
					<li class="List"><a href="/dms/board/index.do?manage_idx=592&board_idx=0&menu_idx=1"><span>관리자이미지소스관리</span></a></li>
					</c:if>
				</ul>
				<!-- menu E -->
			</div>
		</div>
		<div class="call">
			<span>HELP DESK</span>
			<p>053-810-9860~3</p>
			<em>평일  :  09: 00 ~ 18 : 00<br /></em>
		</div>
		<tiles:insertAttribute name="footer" />
	</div>
	<div class="lnb_s" style="width:0px">
	</div>
	<div class="tnb_bg" style="width:0px">
	</div>
	<div id="container" style="background-color:#fff;height:2000px">
		<div class="container">
			<div class="tnb">
				<a href="/dms/index.do">처음으로</a>
				<span class="txt-bar"></span>
				<a href="/dms/login/logout.do">로그아웃</a>
				<span class="txt-bar"></span>
				<!-- <a href="">홈페이지바로가기</a> -->
			</div>

			<div class="subpage">

				<div class="content">
					<div class="doc">
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

</div>

<tiles:insertAttribute name="footer" />

</body>
</html>