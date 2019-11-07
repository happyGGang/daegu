<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp"%>
<script type="text/javascript">
$(function() {
	$('a.prev').on('click', function(e) {
		if ( document.referrer.indexOf(location.host) != -1 ) {
			history.back();
		}
		e.preventDefault();
	});

	$('a.next').on('click', function(e) {
		history.forward();
		e.preventDefault();
	});

	$('img#symbol').error(function() {
		$(this).remove();
	});
});
</script>
<div id="wrap" class="subpage">
	<div id="bodyWrap">
		<div id="header">
			<h1>
				<div class="box">
					<a href="/intro/${homepage.context_path}/index.do">
						<img id="symbol" src="/resources/book/intro/img/logo/${homepage.context_path}.png" alt="심볼 마크"/>
						<strong>
						${homepage.homepage_name}
						</strong>
					</a>
				</div>
			</h1>
			<div class="tnb">
				<div class="box">
					<c:choose>
					<c:when test="${member.loginType eq 'HOMEPAGE' and member.login}">
					<a href="#" class="btn btn1">${member.member_name}님 환영합니다.</a>
					<a href="/intro/${homepage.context_path}/login/logout.do" class="btn btn1">로그아웃</a>
					</c:when>
					<c:otherwise>
					<a href="/intro/${homepage.context_path}/join/index.do" class="btn btn1">회원가입</a>
					<a href="/intro/${homepage.context_path}/login/index.do" class="btn btn1">로그인</a>
					</c:otherwise>
					</c:choose>
					<a href="/intro/${homepage.context_path}/index.do" class="home"><img src="/resources/book/intro/img/icon-home.png" alt="메인페이지로 이동합니다."/></a>
				</div>
			</div>
		</div>

		<div class="nav">
			<ul>
				<li><a href="/intro/${homepage.context_path}/search/index.do">
				<em><img src="/resources/book/intro/img/nav1.png" alt="소장자료검색"/></em>
				<span>소장자료검색</span></a></li>

<!-- 				<li><a href="/intro/search/newBook/index.do"> -->
<!-- 				<em><img src="/resources/book/intro/img/nav2.png" alt=""/></em> -->
<!-- 				<span>신착도서</span></a></li> -->

<!-- 				<li><a href="/intro/search/bestBook/index.do"> -->
<!-- 				<em><img src="/resources/book/intro/img/nav3.png" alt=""/></em> -->
<!-- 				<span>도서대출베스트</span></a></li> -->

				<li><a href="/intro/${homepage.context_path}/search/hope/index.do">
				<em><img src="/resources/book/intro/img/nav4.png" alt="희망도서신청내역"/></em>
				<span>희망도서신청내역</span></a></li>

				<li><a href="/intro/${homepage.context_path}/search/resve/index.do">
				<em><img src="/resources/book/intro/img/nav3.png" alt="도서예약확인"/></em>
				<span>도서예약확인</span></a></li>

				<li><a href="/intro/${homepage.context_path}/search/loan/index.do">
				<em><img src="/resources/book/intro/img/nav6.png" alt="도서대출확인"/></em>
				<span>도서대출확인</span></a></li>

<%-- 				<li><a href="/intro/${homepage.context_path}/module/facility/index.do"> --%>
<!-- 				<em><img src="/resources/book/intro/img/nav2.png" alt=""/></em> -->
<!-- 				<span>시설물이용신청</span></a></li> -->

				<%-- <li><a href="/intro/${homepage.context_path}/rfLogin/index.do">
				<em><img src="/resources/book/intro/img/nav5.png" alt="RFID회원증 로그인"/></em>
				<span>RFID회원증 로그인</span></a></li> --%>
			</ul>
		</div>

		<div id="footer" class="sub">
			<div class="doc-btn">
				<a href="" class="prev"><img src="/resources/book/intro/img/btn-prev.gif" alt="이전으로"/></a>
				<a href="" class="next"><img src="/resources/book/intro/img/btn-next.gif" alt="앞으로"/></a>
			</div>
		</div>

		<div id="container" class="wide">
			<div class="section">
				<c:if test="${introMenu ne null and introMenu ne '' }">
				<div class="doc-title">
					<h3>${introMenu}</h3>
				</div>
				</c:if>
			<tiles:insertAttribute name="body" />
			</div>
		</div>
	</div>

</div>



<%@ include file="footer.jsp"%>