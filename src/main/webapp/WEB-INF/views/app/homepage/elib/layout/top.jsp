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
	<div class="section" >
		<div class="util">
			<ul>
				<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<li>
						<b style="font-weight:200;font-size:15px;color:#facb00">${sessionScope.member.member_name}님</b>
					</li>
					<li>
						<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
					</li>
					<!--li>
						<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=73">MY Library</a>
					</li-->
				</c:when>
				<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
					<li>
						<a href="/${homepage.context_path}/intro/login/logout.do">관리자 로그아웃</a>
					</li>
				</c:when>
				<c:otherwise>
					<li>
						<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=43" title="로그인">LOGIN</a>
					</li>
					<li>
						<a href="http://library.daegu.go.kr/dgportal/intro/join/index.do?menu_idx=42" title="대구통합도서관 회원가입 바로가기(새창열림)" target="_blank">JOIN</a>
					</li>
				</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>


