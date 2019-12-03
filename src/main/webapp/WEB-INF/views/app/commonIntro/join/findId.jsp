<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
	<c:when test="${not empty certMember and not empty certMember.USER_ID}">
	회원님의 ID는 ${certMember.USER_ID}입니다.
	</c:when>

	<c:otherwise>
	등록된 회원이 아닙니다.
	</c:otherwise>
</c:choose>

<div class="idpwSection" style="text-align:center;">
	<c:if test="${empty certMember or empty certMember.USER_ID}">
	<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=5" class="btn btn01">신규회원가입</a>
	</c:if>
	<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=4" class="btn btn01">로그인</a>
	<a href="/${homepage.context_path}/intro/join/findPwForm.do?menu_idx=7" class="btn btn02">비밀번호찾기</a>
</div>

<%
request.getSession().invalidate();
%>