<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header"/>

<div class="green-main-wrap">
	<div class="title-box">
		<h2>
			<span>${checkInOut.checkinout_notice_name}</span>
		</h2>
	</div>
	<div class="img-box"><img src="/resources/common/img/kiosk/green_people_bg_02.png" alt="그린대로 사람"></div>
	<div class="name-bar">
		<p>Memorial Library for 2.28 Students' Movement</p>
	</div>
</div>

<tiles:insertAttribute name="footer" />