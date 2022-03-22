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
			KRpia 전자저널 서비스 제공합니다.</p>
			<ul class="btns_wrap_tac">
			<li>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="https://www.krpia.co.kr" class="btn_link02"  title="KRpia 전자저널 바로가기(새창열림)"><span>KRpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<script type="text/javascript" src="http://www.krpia.co.kr/js/krpia_outconn.js"></script>
								<a href="javascript:krpia_open('6498');" class="btn_link02"  title="KRpia 전자저널 바로가기(새창열림)"><span>KRpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="https://www.krpia.co.kr" class="btn_link02"  title="KRpia 전자저널 바로가기(새창열림)"><span>KRpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>
			</li>
			</ul>
		</div>
	</div>
</div>

<ul class="con">
	<li><strong>관내 이용 방법 :</strong> KRpia 전자저널 바로가기 클릭하면 자동 인증되어 원문 검색 및 열람 가능</li>
	<li><strong>관외 이용 방법</strong>
		<ul class="con2">
			<li>① 도서관 내부에서 KRpia 전자저널 바로가기 클릭</li>
			<li>② 기관인증 된 상태로 개인 로그인 시 관외 이용 승인</li>
			<li>③ 관외에서 www.krpia.co.kr 접속하여 개인계정으로 로그인 후 열람 가능<br />* 1회 인증 시 90일 관외 이용 가능</li>
		</ul>
	</li>
</ul>