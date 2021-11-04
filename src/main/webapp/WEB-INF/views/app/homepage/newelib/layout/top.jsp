<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	$('#main-search-btn').on('click', function(e) {
		e.preventDefault();
		if( $('input#search_text').val() == '' ) {
			alert('검색어를 입력하세요.');
			$('input#search_text').focus();
			return false;
		} else {
			$('#mainSearchForm').submit();
		}
	});

});
</script>


<nav id="menu"></nav>

<div class="tnb">
	<div class="" >
		<h1 class='web-logo'><a href="/${homepage.context_path}/index.do"><img src="/resources/homepage/elib/img/elib_logo.png" alt="대구광역시전자도서관"/></a></h1>

		<div class="util">
			<ul>
				<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<li>
						<b style="font-weight:200;font-size:15px;color:#facb00;vertical-align:middle;">${sessionScope.member.member_name}님</b>
					</li>
					<li>
						<a href="/${homepage.context_path}/intro/login/logout.do"><img src="/resources/homepage/elib/img/logout_icon.png" alt="로그아웃" /></a>
					</li>
					<!--li>
						<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=73">MY Library</a>
					</li-->
				</c:when>
				<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
					<li>
						<b style="font-weight:200;font-size:15px;color:#facb00;vertical-align:middle;">${sessionScope.member.member_name}님</b>
					</li>
					<li>
						<a href="/${homepage.context_path}/intro/login/logout.do"><img src="/resources/homepage/elib/img/logout_icon.png" alt="로그아웃" /></a>
					</li>
				</c:when>
				<c:otherwise>
					<li>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=38" title="로그인"><img src="/resources/homepage/elib/img/login_icon.png" alt="로그인" /></a>
					</li>
					<li>
						<a href="http://library.daegu.go.kr/dgportal/intro/join/index.do?menu_idx=42" title="대구통합도서관 회원가입 바로가기(새창열림)" target="_blank"><img src="/resources/homepage/elib/img/join_icon.png" alt="회원가입"></a>
					</li>
				</c:otherwise>
				</c:choose>
					<li>
						<a href="/${homepage.context_path}/sitemap/index.do?menu_idx=42"><img src="/resources/homepage/elib/img/sitemap_icon.png" alt="사이트맵"></a>
					</li>
			</ul>
		</div>
	</div>
</div>


