<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript" src="/resources/common/js/jquery.cookie.js"></script>
<script type="text/javascript">
$(function() {
	$('input#member_pw_tmp').val('');
	$('.save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input#member_id_tmp').val() == '') {
			$('input#member_id_tmp').focus();
			alert('아이디를 입력해주세요.');
			return false;
		}

		if($('input#member_pw_tmp').val() == '') {
			$('input#member_pw_tmp').focus();
			alert('비밀번호를 입력해주세요.');
			return false;
		}

		$('form#member').attr('onsubmit', '');
		$('input#member_id').val(encrypt($('input#member_id_tmp').val().trim()));
		$('input#member_pw').val(encrypt($('input#member_pw_tmp').val()));
		
 		$('form#member').submit();
	});

});
</script>
<div class="login-wrap">
	<div class="header">
		<h1>국채보상운동기념도서관</h1>
		<p>The National Debt Compensation Movement Memorial Library</p>
	</div>
	<div class="contents">

		<div class="title-sec">
			MEMBER LOGIN
		</div>
		<form:form modelAttribute="member" action="/intro/${homepage.context_path}/login/loginProc.do" onsubmit="return false;">
			<form:hidden path="member_pw" cssStyle="display:none;" />
			<form:hidden path="member_id"/>
			<form:hidden path="before_url"/>
			<div class="id-sec">
				<input type="text" id="member_id_tmp" name="" placeholder="ID">
			</div>
			<div class="pwssword-sec">
				<input type="password" id="member_pw_tmp" name="" placeholder="PASSWORD">
			</div>
			<div class="login-btn-sec">
				<button type="submit" class="button save-btn">LOGIN</button>
			</div>
			<div class="rf-login-btn-sec">
				<a href="/${homepage.context_path}/kiosk/rfidLogin.do?before_url=${param.before_url}" class="button">회원증 RFID 로그인</a>
			</div>
		</form:form>
	</div>
</div>

<c:choose>
	<c:when test="${param.before_url eq '/gukbo/kiosk/librarianPickBookIndex.do' || param.before_url eq '/gukbo/kiosk/bookIndex.do'}">
		<!-- 메뉴 -->
		<div class="bookIndexNav">
			<ul class="navbox">
				<li>
					<a href="/${homepage.context_path}/kiosk/bookKeywordIndex.do" class="smart-btn">
						<div class="outer">
							<div class="inner">
								<span class="kor-txt">능동형 도서추천</span>
								<span class="eng-txt">active type Book recommendation</span>
							</div>
						</div>						
					</a>
				</li>
				<li>
					<a href="/${homepage.context_path}/kiosk/librarianPickBookIndex.do" class="librarian-btn">
						<div class="outer">
							<div class="inner">
								<span class="kor-txt">맞춤형 도서추천</span>
								<span class="eng-txt">Customized book recommendation</span>
							</div>
						</div>
					</a>
				</li>
				<li>
					<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<a href="/${homepage.context_path}/intro/login/kioskLogout.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do">
						<div class="outer">
							<div class="inner">
								<div class="">
									<img src='/resources/common/img/kiosk/login-icon.png' alt=''/>
								</div>
								로그아웃
							</div>
						</div>
					</a>
					</c:when>
					<c:otherwise>
					<a href="/${homepage.context_path}/kiosk/login.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do">
						<div class="outer">
							<div class="inner">
								<div class="">
									<img src='/resources/common/img/kiosk/login-icon.png' alt=''/>
								</div>
								로그인
							</div>
						</div>
					</a>
					</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</div>
	</c:when>
	<c:otherwise>
		<%@ include file="/gukbo/kiosk/nav.html" %>
	</c:otherwise>
</c:choose>

<tiles:insertAttribute name="footer" />