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
	<div class="section">
		<div class="left-util">
			<ul>
				<li><a href="/${homepage.context_path}/intro/login/index.do?menu_idx=121">부산시도서관</a></li>
				<li><a href="/${homepage.context_path}/intro/join/index.do?menu_idx=120">부산시포털</a></li>
			</ul>
		</div>

		<div class="right-util">
			<ul>
				<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
				<li>
					<a href="#" id="memberInfoBtn">${sessionScope.member.member_name}님</a>
				</li>
				<li>
					<a href="/${homepage.context_path}/intro/login/logout.do">로그아웃</a>
				</li>
				<li>
					<a href="/${homepage.context_path}/module/myDashBoard/index.do?menu_idx=73">MY Library</a>
				</li>
				</c:when>
				<c:when test="${sessionScope.member.loginType eq 'CMS' and sessionScope.member.login}">
				<li>
					<a href="/${homepage.context_path}/intro/login/logout.do">관리자 로그아웃</a>
				</li>
				</c:when>
				<c:otherwise>
				<li>
					<a href="/${homepage.context_path}/intro/login/index.do?menu_idx=43">로그인</a>
				</li>
				<li>
					<a href="/${homepage.context_path}/intro/join/index.do?menu_idx=42">회원가입</a>
				</li>
				</c:otherwise>
				</c:choose>
				<li>
					<a href="javascript:alert('준비중입니다.');">뷰어프로그램 <img src="/resources/homepage/${homepage.context_path}/img/download_icon.png" alt="뷰어 다운로드"></a>
				</li>
			</ul>
		</div>
	</div>
</div>


