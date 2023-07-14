<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/common/default.css"  />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/default.css"  />
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script>
$(function(){
	$(".navbox li a").on('click',function(){
		$(".nav li a").removeClass('on');
		$(this).addClass('on');
	});
});
</script>

<div class="nav">
	<ul class="navbox">
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/boardIndex.do"><span class="kor-txt">공지사항</span><span class="eng-txt">NOTICE</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/info.do"><span class="kor-txt">도서관이용안내</span><span class="eng-txt">library information</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/recommandBoardIndex.do"><span class="kor-txt">도서정보</span><span class="eng-txt">Book information</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/teachIndex.do"><span class="kor-txt">문화강좌</span><span class="eng-txt">Cultural Lecture</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/index.html"><span class="kor-txt">통합모니터링</span><span class="eng-txt">Monitor  System</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/index2.html"><span class="kor-txt">시설물예약</span><span class="eng-txt">Facility  Reserve System</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/index3.html"><span class="kor-txt">희망도서바로대출</span><span class="eng-txt">Baro HopeBook System</span></a></li>
	</ul>
</div>