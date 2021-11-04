<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>

<div class="audian_bgbox bgbox">
	<div class="lf-txt2">
	  <p><span class="tt">오디언소리</span><br>
		<span class="btit">오디오북서비스</span></p>
		<br>


			<ul class="btns_wrap_tac">
				<li>
				
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원만 이용가능합니다.');" class="btn_link05"  title="오디언소리 바로가기(새창열림)"><span>오디언소리 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<a href="http://aspservice.audien.com/inticube/mall/245d07133fb8b6983f98122003__${sessionScope.member.member_id}" class="btn_link05" title="오디언소리 바로가기(새창열림)"  target="_blank"><span>오디언소리 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="javascript:alert('로그인후 이용가능합니다.');" class="btn_link05"  title="오디언소리 바로가기(새창열림)"><span>오디언소리 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>

				</li>
			</ul>


	</div>
</div>

