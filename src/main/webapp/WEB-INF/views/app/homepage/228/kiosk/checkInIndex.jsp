<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header"/>

<div class="checkin-wrap">
	<div class="header">
		<img src="https://library.daegu.go.kr/resources/common/img/kiosk/checkin-logo.png" alt=""/>
	</div>
	<div class="contents">
		<div class="checkbtnarea">
			<div class='checkbtn2'><a href="/${homepage.context_path}/kiosk/checkIn.do">체크인</a></div>
			<div class='checkbtn3'><a href="/${homepage.context_path}/kiosk/checkOut.do">체크아웃</a></div>
		</div>
		<div class="commentarea">
			초5~중3 또는 해당 연령대만 입장 가능합니다.
		</div>
	</div>
	<div class="footer">
		Memorial Library for 2.28 Students' Movement
	</div>
</div>

<tiles:insertAttribute name="footer" />