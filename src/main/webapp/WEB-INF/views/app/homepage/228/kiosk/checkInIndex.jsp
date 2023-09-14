<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"/>
<script type="text/javascript">
</script>

<div class="login-wrap">
	<div class="header">
		<h1>그린대로</h1>
	</div>
	<div class="contents">
		<div style="position:relative;width:100%;height:700px;text-align:center">
			<div class="contents">
				<a href="http://localhost/228/kiosk/checkIn.do">체크인</a>
				<a href="http://localhost/228/kiosk/checkOut.do">체크아웃</a>
			</div>
		</div>
	</div>
</div>

<%@ include file="/gukbo/kiosk/copyright.html" %>

<tiles:insertAttribute name="footer" />