<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="summaryDesc">
	<div class="innerBox">
		<div class="img txt_b02"></div>
		<div class="desc">
			<h3>DBpia 전자저널</h3>
			<p>두류도서관에서는 지역민의 활발한 학습활동과 연구활동 지원을 위하여<br>
			국내간행물 학술분야 2천여종, 전문잡지 50여 종, 학술논문 230여만편 등을 제공하는<br>
			DBpia 전자저널 서비스 제공합니다.</p>
			<ul class="btns_wrap_tac">
			<li>
				<a href="https://www.dbpia.co.kr/" class="btn_link02" title="DBpia 전자저널 바로가기(새창열림)" target="_blank"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
			</li>
			<!-- <li>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원(대출회원) 전용입니다.');" class="btn_link02"  title="DBpia 전자저널 바로가기(새창열림)"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<script type="text/javascript" src="https://www.dbpia.co.kr/js/dbpia_outConn.js"></script>
								<a href="javascript:dbpia_open('1856');" class="btn_link02"  title="DBpia 전자저널 바로가기(새창열림)"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="alert('로그인후 이용가능합니다.'); location.href='http://library.daegu.go.kr/duryu/intro/login/index.do?menu_idx=4&before_url=/duryu/html/dbpia.do?menu_idx=144';" class="btn_link02"  title="DBpia 전자저널 바로가기(새창열림)"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>
			</li> -->
			</ul>
		</div>
	</div>
</div>

<ul class="con">
	<li><strong>관내 이용 방법 :</strong> DBpia 전자저널 바로가기 클릭하면 자동 인증되어 원문 검색 및 열람 가능</li>
	<li><strong>관외 이용 방법</strong>
		<ul class="con2">
			<li>① 도서관 내부에서 DBpia 전자저널 바로가기 클릭</li>
			<li>② 기관인증 된 상태로 개인 로그인 시 관외 이용 승인</li>
			<li>③ 관외에서 www.dbpia.co.kr 접속하여 개인계정으로 로그인 후 열람 가능<br />* 1회 인증 시 90일 관외 이용 가능</li>
		</ul>
	</li>
</ul>