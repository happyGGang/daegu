<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="layout/header.jsp"%>

<div id="container">
	<div id="header">
		<h1><a href="/book/"><img src="/resources/homepage/bookdream/img/logo.png" alt="경상북도교육청 안동도서관 새 책 드림 서비스"/></a></h1>
		<p class="member_title"></p>
		<div id="navi">
			<ul>
				<li><a href="?menu_idx=1">새책드림안내</a></li>
				<li><a href="?menu_idx=2">신청하기</a></li>
				<li><a href="?menu_idx=3">신청내역</a></li>
				<li><a href="?menu_idx=4">이용후기</a></li>
				<li><a href="?menu_idx=5">마이페이지</a></li>
			</ul>
		</div>
	</div>
	<div id="body">
		<div id="content">
			<div id="main">

				<%
				String req = "";
				if (request.getParameter("menu_idx") == null || request.getParameter("menu_idx") == "") {
					req = "main";
				} else {
					req = "content/"+request.getParameter("menu_idx");
				}
				String inc = req+".jsp";
				%>
				<jsp:include page="<%=inc%>" flush="false" />

			</div>
		</div>
	</div>
	<div id="footer">
		<img src="/resources/homepage/bookdream/img/copy_logo.png" alt="경상북도교육청 안동도서관"/>
		<div id="foot_info">
			<address><strong>경상북도교육청 안동도서관</strong> : 054)840-8414 <strong class="pdl12">용상분관</strong> : 054)821-5491 <strong class="pdl12">풍산분관</strong> : 054)858-7603</address>
			<cite>Copyright © 2015 ANDONG LIBRARY. All rights reserved.</cite>
		</div>
	</div>
</div>

</body>
</html>