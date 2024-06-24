<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<script type="text/javascript">
</script>
<div id="wrap">
	<div class="main-wrap">
		<div class="header">
			<h1>인포셋 ICT 스마트 도서관</h1>
			<p>INFOSET ICT Library</p>
		</div>
		<div class="contents">
			<div class="">
				<ul>
					<li><a href="https://lib.daegu.go.kr/portalHerbMonitorY/gukbo/library" class="main-button-01"><span class="">통합모니터링</span></a></li>
					<li><a href="https://lib.daegu.go.kr/kioskY/gukbo/room" class="main-button-02"><span class="">열람실좌석예약</span></a></li>
					<li><a href="https://lib.daegu.go.kr/kioskY/gukbo/facility" class="main-button-03"><span class="">시설물예약</span></a></li>
					<li><a href="" class="main-button-04"><span class="">희망도서바로대출</span></a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<tiles:insertAttribute name="footer" />