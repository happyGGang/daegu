<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp"%>

<script type="text/javascript">
$(function() {

	$('img#symbol').error(function() {
		$(this).remove();
	});

});
</script>
<div id="wrap" class="subpage">
	<div id="bodyWrap">

		<!-- 탑링크 -->
		<div id="top">
			<div id="lnb_hm" style="right:0px;">
				<div class="layout">
					<ul class="siteLink">
						<li class="card" style="${isMobile ? '':'display:none'}"><a href="/intro/${homepage.context_path}/login/mobileCard.do">모바일회원증</a></li>
						<c:choose>
						<c:when test="${sessionScope.member.login}">
						<li class="login"><a href="/intro/${homepage.context_path}/login/logout.do">로그아웃</a></li>
						<li class="join"><a href="/intro/${homepage.context_path}/join/passCheck.do">정보수정</a></li>
						</c:when>
						<c:otherwise>
						<li class="login"><a href="/intro/${homepage.context_path}/login/index.do">로그인</a></li>
						<li class="join"><a href="/intro/${homepage.context_path}/join/index.do">신규회원가입</a></li>
						<li class="integration"><a href="/intro/${homepage.context_path}/join/integration.do">통합인증센터</a></li>
						</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>

			<div id="header">
				<div class="gnb">
					<h1>
						<div class="box">
							<a href="/intro/${homepage.context_path}/index.do">
								<img id="symbol" src="/resources/book/intro/img/logo/${homepage.context_path}_logo.png" alt="${homepage.homepage_name} 심볼 마크"/>
							</a>
						</div>
					</h1>
				</div>
				<!-- <div class="tnb">
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
				</div> -->
			</div>

			<div class="nav">
			<!--
				<ul>
					<li><a href="/intro/${homepage.context_path}/search/index.do">
					<em><img src="/resources/book/intro/img/nav1.png" alt="소장자료검색"/></em>
					<span>소장자료검색</span></a></li>

					<li><a href="/intro/search/newBook/index.do">
					<em><img src="/resources/book/intro/img/nav2.png" alt=""/></em>
	 				<span>신착도서</span></a></li>

	 				<li><a href="/intro/search/bestBook/index.do">
					<em><img src="/resources/book/intro/img/nav3.png" alt=""/></em>
	 				<span>도서대출베스트</span></a></li>

					<li><a href="/intro/${homepage.context_path}/search/hope/index.do">
					<em><img src="/resources/book/intro/img/nav4.png" alt="희망도서신청내역"/></em>
					<span>희망도서신청내역</span></a></li>

					<li><a href="/intro/${homepage.context_path}/search/resve/index.do">
					<em><img src="/resources/book/intro/img/nav3.png" alt="도서예약확인"/></em>
					<span>도서예약확인</span></a></li>

					<li><a href="/intro/${homepage.context_path}/search/loan/index.do">
					<em><img src="/resources/book/intro/img/nav6.png" alt="도서대출확인"/></em>
					<span>도서대출확인</span></a></li>
			-->
					<div class="web-view-menu">
					<ul>
						<li>
							<a href="/intro/${homepage.context_path}/search/index.do">
								<em><img src="/resources/common/img/nav1.png" alt="소장자료검색"/></em>
								<span>소장자료검색</span>
								<div>Book Search</div>
							</a>
						</li>
						<li>
							<a href="/intro/${homepage.context_path}/search/newBook/index.do">
								<em><img src="/resources/common/img/nav2.png" alt=""/></em>
								<span>신착도서</span>
								<div>New Book</div>
							</a>
						</li>
						<li>
							<a href="/intro/${homepage.context_path}/search/bestBook/index.do">
								<em><img src="/resources/common/img/nav3.png" alt=""/></em>
								<span>도서대출베스트</span>
								<div>Book Best</div>
							</a>
						</li>
						<li>
							<a href="/intro/${homepage.context_path}/search/hope/req.do">
								<em><img src="/resources/common/img/nav4.png" alt="희망도서신청내역"/></em>
								<span>희망도서신청</span>
								<div>Book Application</div>
							</a>
						</li>
						<li>
							<a href="/intro/${homepage.context_path}/search/loan/index.do">
								<em><img src="/resources/common/img/nav5.png" alt="마이라이브러리"/></em>
								<span>마이라이브러리</span>
								<div>My Library</div>
							</a>
						</li>

					</ul>
					</div>

					<div class="mobile-view-menu">

						<div class="rsv-info"><p class="ico">메뉴를 좌우로 밀어서 확인하세요</p></div>

						<ul>
							<li>
								<a href="#">
									<em><img src="/resources/common/img/nav1.png" alt="소장자료검색"/></em>
									<span>소장자료검색</span>
									<div>Book Search</div>
								</a>
							</li>
							<li>
								<a href="">
									<em><img src="/resources/common/img/nav2.png" alt=""/></em>
									<span>신착도서</span>
									<div>New Book</div>
								</a>
							</li>
							<li>
								<a href="">
									<em><img src="/resources/common/img/nav3.png" alt=""/></em>
									<span>도서대출베스트</span>
									<div>Book Best</div>
								</a>
							</li>
							<li>
								<a href="#">
									<em><img src="/resources/common/img/nav4.png" alt="희망도서신청내역"/></em>
									<span>희망도서신청</span>
									<div>Book Application</div>
								</a>
							</li><!-- 향후 goMenu('N' -> goMenu('Y'로 변경영역 -->
							<li>
								<a href="">
									<em><img src="/resources/common/img/nav5.png" alt="마이라이브러리"/></em>
									<span>마이라이브러리</span>
									<div>My Library</div>
								</a>
							</li><!-- 향후 goMenu('N' -> goMenu('Y'로 변경영역 -->

						</ul>
						<!-- 상단메뉴 영역 [ END ] -->

					</div>


				</ul>
			</div>
		</div>

		<!-- <div id="footer" class="sub">
			<div class="doc-btn">
				<a href="" class="prev"><img src="/resources/book/intro/img/btn-prev.gif" alt="이전으로"/></a>
				<a href="" class="next"><img src="/resources/book/intro/img/btn-next.gif" alt="앞으로"/></a>
			</div>
		</div> -->

		<div id="container" class="wide">
			<tiles:insertAttribute name="body" />
		</div>
	</div>

</div>

<%@ include file="footer.jsp"%>