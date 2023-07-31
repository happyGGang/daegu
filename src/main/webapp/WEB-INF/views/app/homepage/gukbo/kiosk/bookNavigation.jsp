<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!-- 메뉴 -->
<div class="bookIndexNav">
	<ul class="navbox">
		<li>
			<!-- <a href="/${homepage.context_path}/kiosk/bookKeywordIndex.do" class="smart-btn"> -->
			<a href="/${homepage.context_path}/kiosk/gukboBookKeywordIndex.do" class="smart-btn">
				<div class="outer">
					<div class="inner">
						<span class="kor-txt">능동형 도서추천</span>
						<span class="eng-txt">active type Book recommendation</span>
					</div>
				</div>						
			</a>
		</li>
		<li>
			<a href="/${homepage.context_path}/kiosk/librarianPickBookIndex.do" class="librarian-btn">
				<div class="outer">
					<div class="inner">
						<span class="kor-txt">맞춤형 도서추천</span>
						<span class="eng-txt">Customized book recommendation</span>
					</div>
				</div>
			</a>
		</li>
		<li>
			<a href="/${homepage.context_path}/kiosk/bookIndex.do">
				<div class="outer">
					<div class="inner">
						<div class="">
							<img src='/resources/common/img/kiosk/home-icon.png' alt=''/>
						</div>
						HOME
					</div>
				</div>						
			</a>
		</li>
		<li>
			<c:choose>
			<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
			<a href="/${homepage.context_path}/intro/login/kioskLogout.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do">
				<div class="outer">
					<div class="inner">
						<div class="">
							<img src='/resources/common/img/kiosk/login-icon.png' alt=''/>
						</div>
						로그아웃
					</div>
				</div>
			</a>
			</c:when>
			<c:otherwise>
			<a href="/${homepage.context_path}/kiosk/login.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do">
				<div class="outer">
					<div class="inner">
						<div class="">
							<img src='/resources/common/img/kiosk/login-icon.png' alt=''/>
						</div>
						로그인
					</div>
				</div>
			</a>
			</c:otherwise>
			</c:choose>
		</li>
	</ul>
</div>

<c:choose>
<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 2)
	{
		location.href = "/${homepage.context_path}/intro/login/kioskLogout.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do";
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
</c:when>
<c:otherwise>
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 2)
	{
		location.href = "/${homepage.context_path}/kiosk/bookIndex.do";
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