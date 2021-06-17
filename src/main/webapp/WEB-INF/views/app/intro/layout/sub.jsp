<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp"%>

<div id="wrap" class="subpage">
	<div id="bodyWrap">

		<!-- 탑링크 -->
		<div id="top">
			<c:choose>
			<c:when test="${context_path eq 'daegu'}">
			<div id="header">
				<div class="gnb">
					<h1>
						<div class="box">
							<a href="/intro/${context_path}/index.do">
								<img id="symbol" src="/resources/book/intro/img/logo/${context_path}_logo.png" alt="${homepage.homepage_name} 심볼 마크"/>
							</a>
						</div>
					</h1>
				</div>
			</div>
			</c:when>
			<c:otherwise>
			<div id="lnb_hm" style="right:0px;">
				<div class="layout">
					<ul class="siteLink">
						<li class="card" style="${isMobile ? '':'display:none'}"><a href="/intro/${context_path}/login/mobileCard.do">모바일회원증</a></li>
						<c:choose>
						<c:when test="${not empty sessionScope.member and sessionScope.member.login}">
						<li class="login"><a href="/intro/${context_path}/login/logout.do">로그아웃</a></li>
						<li class="join"><a href="/intro/${context_path}/join/passCheck.do">정보수정</a></li>
						</c:when>
						<c:otherwise>
						<li class="login"><a href="/intro/${context_path}/login/index.do">로그인</a></li>
						<li class="join"><a href="/intro/${context_path}/join/index.do">신규회원가입</a></li>
						<li class="integration"><a href="/intro/${context_path}/join/integration.do">통합인증센터</a></li>
						</c:otherwise>
						</c:choose>
						<!-- <c:choose>
						<c:when test="${context_path eq 'beomeo'}">
						<li class="gohomepage"><a href="http://library.suseong.kr/beomeo/" target="_blank">홈페이지로이동</a></li>
						</c:when>
						<c:when test="${context_path eq 'yonghak'}">
						<li class="gohomepage"><a href="http://library.suseong.kr/yonghak/" target="_blank">홈페이지로이동</a></li>
						</c:when>
						<c:when test="${context_path eq 'gosan'}">
						<li class="gohomepage"><a href="http://library.suseong.kr/gosan/main/index.htm" target="_blank">홈페이지로이동</a></li>
						</c:when>
						<c:otherwise>
						</c:otherwise>
						</c:choose> -->
					</ul>
				</div>
			</div>

			<div id="header">
				<div class="gnb">
					<h1>
						<div class="box">
							<a href="/intro/${context_path}/index.do">
								<img id="symbol" src="/resources/book/intro/img/logo/${context_path}_logo.png" alt="${homepage.homepage_name} 심볼 마크"/>
							</a>
						</div>
					</h1>
				</div>
			</div>

			<div class="nav">
				<div class="web-view-menu">
				<ul>
					<li>
						<a href="/intro/${context_path}/search/index.do">
							<em><img src="/resources/common/img/nav1.png" alt="소장자료검색"/></em>
							<span>소장자료검색</span>
							<div>Book Search</div>
						</a>
					</li>
					<li>
						<a href="/intro/${context_path}/search/newBook/index.do">
							<em><img src="/resources/common/img/nav2.png" alt=""/></em>
							<span>신착도서</span>
							<div>New Book</div>
						</a>
					</li>
					<li>
						<a href="/intro/${context_path}/search/bestBook/index.do">
							<em><img src="/resources/common/img/nav3.png" alt=""/></em>
							<span>도서대출베스트</span>
							<div>Book Best</div>
						</a>
					</li>

					<c:choose>
						<c:when test="${context_path eq 'dssmalllib'}">
					<li>
						<a href="#" onclick="alert('2020년 도서구입 예산소진으로 희망도서신청을 중단합니다. \n\r그 동안 이용해 주셔서 감사합니다.')">
							<em><img src="/resources/common/img/nav4.png" alt="희망도서신청내역"/></em>
							<span>희망도서신청</span>
							<div>Book Application</div>
						</a>
					</li>
						</c:when>
						<c:otherwise>
					<li>
						<a href="/intro/${context_path}/search/hope/req.do">
							<em><img src="/resources/common/img/nav4.png" alt="희망도서신청내역"/></em>
							<span>희망도서신청</span>
							<div>Book Application</div>
						</a>
					</li>
						</c:otherwise>
					</c:choose>

					<li>
						<a href="/intro/${context_path}/search/loan/index.do">
							<em><img src="/resources/common/img/nav5.png" alt="나의도서관"/></em>
							<span>나의도서관</span>
							<div>My Library</div>
						</a>
					</li>

				</ul>
				</div>

				<div class="mobile-view-menu">

					<div class="rsv-info"><p class="ico">메뉴를 좌우로 밀어서 확인하세요</p></div>

					<ul>
						<li>
							<a href="/intro/${context_path}/search/index.do">
								<em><img src="/resources/common/img/nav1.png" alt="소장자료검색"/></em>
								<span>소장자료검색</span>
								<div>Book Search</div>
							</a>
						</li>
						<li>
							<a href="/intro/${context_path}/search/newBook/index.do">
								<em><img src="/resources/common/img/nav2.png" alt=""/></em>
								<span>신착도서</span>
								<div>New Book</div>
							</a>
						</li>
						<li>
							<a href="/intro/${context_path}/search/bestBook/index.do">
								<em><img src="/resources/common/img/nav3.png" alt=""/></em>
								<span>도서대출베스트</span>
								<div>Book Best</div>
							</a>
						</li>

						<c:choose>
							<c:when test="${context_path eq 'dssmalllib'}">
						<li>
							<a href="#" onclick="alert('예산소진으로 희망도서신청을 중단합니다.')">
								<em><img src="/resources/common/img/nav4.png" alt="희망도서신청내역"/></em>
								<span>희망도서신청</span>
								<div>Book Application</div>
							</a>
						</li>
							</c:when>
							<c:otherwise>
						<li>
							<a href="/intro/${context_path}/search/hope/req.do">
								<em><img src="/resources/common/img/nav4.png" alt="희망도서신청내역"/></em>
								<span>희망도서신청</span>
								<div>Book Application</div>
							</a>
						</li>
							</c:otherwise>
						</c:choose>

						<li>
							<a href="/intro/${context_path}/search/loan/index.do">
								<em><img src="/resources/common/img/nav5.png" alt="나의도서관"/></em>
								<span>나의도서관</span>
								<div>My Library</div>
							</a>
						</li>

					</ul>
					<!-- 상단메뉴 영역 [ END ] -->

				</div>
			</div>
			</c:otherwise>
			</c:choose>
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