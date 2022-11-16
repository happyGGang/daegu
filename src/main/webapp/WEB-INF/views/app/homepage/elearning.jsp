<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="cyber_bgbox bgbox">
	<div class="lf-txt">
	  <p><span class="tt">모바일 학습서비스</span><br>
		<span class="btit">사이버학습관</span></p>
		<br>


			<ul class="btns_wrap_tac">
				<li>
				
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원만 이용가능합니다.');" class="btn_link04"  title="사이버학습관 바로가기(새창열림)"  target="_blank"><span>사이버학습관 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn_link04" id="go-cyber" title="사이버학습관 바로가기(새창열림)"  target="_blank"><span>사이버학습관 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${sessionScope.member.loginType eq 'PRIVATEHOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원만 이용가능합니다.');" class="btn_link04"  title="사이버학습관 바로가기(새창열림)"  target="_blank"><span>사이버학습관 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn_link04" id="go-cyber" title="사이버학습관 바로가기(새창열림)"  target="_blank"><span>사이버학습관 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="javascript:alert('로그인후 이용가능합니다.');" class="btn_link04"  title="사이버 학습관 바로가기(새창열림)" ><span>사이버학습관 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>

				</li>
			</ul>


	</div>
</div>
<br>
<h3 class="contTit_line">사이버학습관</h3>
<ul class="con">
	<li>어학/취업/직무/인문 등 다양한 분야의 동영상 강의 제공</li>
	<li>해당 페이지에서 원하는 강좌 선택 후 학습</li>
	<li>어학(영어/중국어), 인문교육(문화/예술, 인문, 역사), 취업, 직무, 어린이 교양 등</li>
	<li>모바일에서도 PC와 동일하게 수강 가능</li>
</ul>


<script>
	$(function() {

		$('#go-cyber').attr("href", "https://elib.daegu.go.kr:9053/php_lcms/loginok.php?user_id=${sessionScope.member.member_id}&user_name=${sessionScope.member.member_name}");

	});
</script>
