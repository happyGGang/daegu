<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	
});

</script>

<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<link rel="stylesheet" type="text/css" href="/resources/homepage/app/css/sub_layout.css"/>

<div class="subpage_title">
	<h4>희망도서신청</h4>
</div>

<div class="mylibrary-btn-section">
	<ul>
		<li><a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=5"><img src="/resources/homepage/app/img/mylib01.png" alt=""><br/>대출중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=11"><img src="/resources/homepage/app/img/mylib02.png" alt=""><br/>대출이력</a></li>
		<li><a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=12"><img src="/resources/homepage/app/img/mylib03.png" alt=""><br/>예약중도서</a></li>
		<li><a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=13"><img src="/resources/homepage/app/img/mylib04.png" alt=""><br/>희망도서신청내역</a></li>
		<li><a href="/${homepage.context_path}/intro/search/hope/index.do?menu_idx=14" class="on"><img src="/resources/homepage/app/img/mylib05.png" alt=""><br/>희망도서신청</a></li>
	</ul>
</div>


<div style="padding:10px;box-sizing:border-box">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
${html.html}
<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>

<div class="center" style="padding:10px 0 20px 0">
	<a href="/${homepage.context_path}/intro/search/hope/search.do?menu_idx=${menuOne.menu_idx}&editMode=NOAJAX" id="goReqHope" class="btn btn1" title="희망도서 신청하기">희망도서 신청하기</a>
	<a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=${hopeHistoryMenuIdx}" id="goReqHopeList" class="btn btn1" title="희망도서신청내역">희망도서내역</a>
</div>