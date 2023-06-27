<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="header">
	<nav id="menu"></nav>

	<div class="tnb">
		<div class="util-left">
			<ul>
				<li><a href="https://library.daegu.go.kr/dgportal/index.do" target="_blank">대구통합도서관</a></li>
				<li><a href="https://library.daegu.go.kr/elib/index.do" target="_blank">대구전자도서관</a></li>
			</ul>
		</div>
		<div class="util-right">
			<ul>
			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<li><a href="#" id="memberInfoBtn">${sessionScope.member.member_name}님</a></li>
					<li><a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a></li>
					<li><a href="/${homepage.context_path}/intro/join/modifyCheck.do?menu_idx=95" class='tnb-box-1'>정보수정</a></li>
				</c:when>
				<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
					<li><a href="#">관리자 로그인 중</a></li>
					<li><a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4">통합허브시스템 로그인</a></li>
					<li><a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5">회원가입</a></li>
					<li><a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=8" class='tnb-box-1'>통합회원인증</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
