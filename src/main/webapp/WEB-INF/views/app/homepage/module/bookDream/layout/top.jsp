<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
$(function() {
	var currUrl = location.href;
	if (currUrl.indexOf('mypage.do', 0) > 0) {
		$('li#li5').addClass('on');
	}
	if (currUrl.indexOf('info.do', 0) > 0) {
		$('li#li1').addClass('on');
	}
	if (currUrl.indexOf('requestForm.do', 0) > 0) {
		$('li#li2').addClass('on');
	}
	if (currUrl.indexOf('requestList.do', 0) > 0) {
		$('li#li3').addClass('on');
	}
	if (currUrl.indexOf('/board/', 0) > 0) {
		$('li#li4').addClass('on');
	}
});
</script>
<div id="container">
	<div id="header">
		<h1><a href="/${homepage.context_path}/module/bookDream/index.do"><img src="/resources/homepage/bookdream/img/logo.png" alt="${homepage.homepage_name}"/></a></h1>
		<p class="member_title"></p>
		<div id="navi">
			<ul>
				<li id="li1"><a href="/${homepage.context_path}/module/bookDream/info.do">새책드림안내</a></li>
				<li id="li2"><a href="/${homepage.context_path}/module/bookDream/requestForm.do">신청하기</a></li>
				<li id="li3"><a href="/${homepage.context_path}/module/bookDream/requestList.do">신청내역</a></li>
				<li id="li4"><a href="/${homepage.context_path}/board/index.do?manage_idx=524&module=bookDream">이용후기</a></li>
				<li id="li5"><a href="/${homepage.context_path}/module/bookDream/mypage.do">마이페이지</a></li>
			</ul>
		</div>
	</div>
	<div id="body">
		<div id="content1">