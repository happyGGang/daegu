<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<div class="nav">
	<ul class="navbox tab6">
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/boardIndex.do"><span class="kor-txt">공지사항</span><span class="eng-txt">NOTICE</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/info.do"><span class="kor-txt">도서관이용안내</span><span class="eng-txt">library information</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/recommandBoardIndex.do"><span class="kor-txt">도서정보</span><span class="eng-txt">Book information</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/teachIndex.do"><span class="kor-txt">문화강좌</span><span class="eng-txt">Cultural Lecture</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/info02.do"><span class="kor-txt">통합모니터링</span><span class="eng-txt">Monitor  System</span></a></li>
		<li><a href="https://library.daegu.go.kr/gukbo/kiosk/info03.do"><span class="kor-txt">시설물예약</span><span class="eng-txt">Facility  Reserve System</span></a></li>
	</ul>
</div>
<c:choose>
<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 1) 
	{
		location.href = "/${homepage.context_path}/intro/login/kioskLogout.do?before_url=/${homepage.context_path}/kiosk/boardIndex.do";
    }
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });
});
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 1)
	{
		location.href = "/${homepage.context_path}/kiosk/boardIndex.do";
    }
	console.log(idleTime);
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });
});
</script>
</c:otherwise>
</c:choose>