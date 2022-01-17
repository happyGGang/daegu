<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="summaryDesc">
	<div class="innerBox">
		<div class="img txt_b02"></div>
		<div class="desc">
			<h3>KRpia 전자저널</h3>
			<p>228민주도서관에서는 지역민의 활발한 학습활동과 연구활동 지원을 위하여<br>
			국내간행물 학술분야 2천여종, 전문잡지 50여 종, 학술논문 230여만편 등을 제공하는<br>
			KRpia 전자저널 서비스 제공합니다.<br><br>228민주도서관 홈페이지 로그인한 후 아래의 바로가기 클릭 해주세요.</p>
			<ul class="btns_wrap_tac">
			<li>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원(대출회원) 전용입니다.');" class="btn_link02"  title="KRpia 전자저널 바로가기(새창열림)"><span>KRpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<script type="text/javascript" src="http://www.krpia.co.kr/js/krpia_outconn.js"></script>
								<a href="javascript:krpia_open('6498');" class="btn_link02"  title="KRpia 전자저널 바로가기(새창열림)"><span>KRpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="alert('로그인후 이용가능합니다.'); location.href='http://library.daegu.go.kr/228lib/intro/login/index.do?menu_idx=4&before_url=/228lib/html/228krpia.do?menu_idx=122';" class="btn_link02"  title="KRpia 전자저널 바로가기(새창열림)"><span>KRpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>
			</li>
			</ul>
		</div>
	</div>
</div>

