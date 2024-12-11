<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/common/css/dghopebook.css"/>


<%!
	private static int getRandomNumberInRange(int min, int max) {
		if (min >= max) {
			throw new IllegalArgumentException("max must be greater than min");
		}
	
		return (int)(Math.random() * ((max - min) + 1)) + min;
	}
%>
<%
	String member_id = "";
	kr.co.whalesoft.app.cms.member.Member member = (kr.co.whalesoft.app.cms.member.Member) session.getAttribute("member");
	if(member != null) {
		member_id = member.getMember_id();
	}
	
	int key = getRandomNumberInRange(1, 9999);
	String keyStr = org.apache.commons.lang.StringUtils.leftPad(String.valueOf(key), 4, "0");
	StringBuilder sb = new StringBuilder();
	
	sb.append("_cu");
	sb.append(keyStr);
	sb.append(member_id);
	sb.append("cni_");

	String token = org.apache.commons.codec.digest.DigestUtils.md5Hex(sb.toString());
	String tok = sb.toString();
%>


<script>
$(document).ready(function () {
	$('.hopeBook').attr('href','https://las.daegu.go.kr/baro/homepage/baroloanssologin.do?userid=${member.member_id}&token=<%=token%>&key=<%=keyStr%>');
});
</script>

<div class="hopeBook_box">
	<p class="txt1"><span>희망도서 바로대출</span> 서비스란?</p>
	<p class="txt2">내가 신청한 희망도서를 <br />협약된 지역서점에서 바로 대출하는 서비스 입니다.
    <c:if test="${homepage.context_path eq 'dalseong'}">
    <br><br>※ 2025년 1월2일 오전 9시부터 신청 가능
  </c:if></p>
  
	<div class="move">
		<c:choose>
			<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">

				<c:choose>
					<c:when test="${ sessionScope.member.member_class ne '0' }">
						<a href="#none" onclick="alert('정회원만 사용가능한 서비스 입니다.')" class="ebook_links newWin"><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><!--<span class="ico arr"></span><i class="fa fa-external-link"></i>--></a>
					</c:when>
					<c:otherwise>
						<a href="#" id="btn_ebook" title="새창열림" class="ebook_links newWin hopeBook" target="_blank"><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span></a>
					</c:otherwise>
				</c:choose>

			</c:when>
			<c:otherwise>
				<a href="#none" onclick="alert('로그인후 이용바랍니다.');location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${param.menu_idx}&before_url=/${homepage.context_path}/html/hopeBook.do?menu_idx=${param.menu_idx}';" class="ebook_links" /><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><!--<span class="ico arr"></span><i class="fa fa-external-link"></i>--></a> 
			</c:otherwise>
		</c:choose>
	</div>
</div>