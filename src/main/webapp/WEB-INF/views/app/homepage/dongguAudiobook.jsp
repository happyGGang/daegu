<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 컨텐츠 삽입시작 -->

<div class="doc-body">
	<div class="move_box move_box_img05">
		<h5>오디오북</h5>
		<p>협력형 온라인 지식정보서비스</p>
		<c:choose>
		  <c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">

			<c:choose>
			  <c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null or sessionScope.member.user_no eq 'null'}"> <a href="javascript:alert('정회원만 이용가능합니다.');" class="move_btn" title="바로가기">바로가기</a> </c:when>
			  <c:otherwise> <div class="move_btn" title="바로가기(새창열림)"><a href="/${homepage.context_path}/html/dongguAudiobookOpen.do" target="_blank">바로가기</a></div> </c:otherwise>
			</c:choose>

		  </c:when>
		  <c:otherwise> 
		  <div class="move_btn" onclick="alert('로그인후 이용가능합니다.'); location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=103&before_url=/${homepage.context_path}/html/dongguAudiobook.do?menu_idx=103';" id="go-audiobook" title="바로가기(새창열림)">바로가기</div> </c:otherwise>
		</c:choose>
	</div>
	<div class="move_txt">
		<p></p>
	</div>
</div>

<!-- 컨텐츠 삽입끝 -->


