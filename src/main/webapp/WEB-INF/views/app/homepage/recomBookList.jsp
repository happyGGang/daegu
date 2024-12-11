<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<link rel="stylesheet" type="text/css" href="/resources/common/css/recombooklist.css">

<script>
$(function() {
	$('.view_pdf').on('click', function(e) {
		e.preventDefault();
		var link = $(this).attr('data-keyValue');
		window.open(link, '_blank','fullscreen=yes');
	});

	<c:choose>
	<c:when test="${not empty sessionScope.loginSupport and sessionScope.loginSupport.login}">
	$('.view_pdf2').on('click', function(e) {
		e.preventDefault();
		var link = $(this).attr('data-keyValue');
		window.open(link, '_blank','fullscreen=yes');
	});
	</c:when>
	<c:otherwise>
	$('.view_pdf2').on('click', function(e) {
		e.preventDefault();
		alert('학교 도서관 회원 로그인후 이용바랍니다.'); 
		location.href="/228/module/supportMember/index.do?menu_idx=175&before_url=/228/html/recomBookList.do?menu_idx=259";
	});
	</c:otherwise>
	</c:choose>
});
</script>
<div class="contestBox">
	<div class="box">
		<a href="#" onclick="open_magazine('/resources/common/pdf/bookList_03.pdf');">
			<p class="contest_thum"><img src="/data/menuResources/h1/259/1707785301607.jpg" alt="3집 표지"></p>
			<div class="titleBox">
				<p class="contest_num">목록 3집</p>
				<p class="contest_tit">발행년 : 2023</p>
			</div>
		</a>
		<div class="btnBox">
			<span class="contest_btn view_pdf" data-keyvalue="/resources/common/pdf/bookList_03.pdf">도서 목록</span>
			<span class="contest_btn view_pdf2" <c:if test="${not empty sessionScope.loginSupport and sessionScope.loginSupport.login}">data-keyvalue='/resources/common/pdf/bookList_all_03.pdf'</c:if>>전문 (PDF)</span>
		</div>
	</div>

	<div class="box">
		<a href="#" onclick="open_magazine('/resources/common/pdf/bookList_02.pdf');">
			<p class="contest_thum"><img src="/data/menuResources/h1/259/1707785296412.jpg" alt="2집 표지"></p>
			<div class="titleBox">
				<p class="contest_num">목록 2집</p>
				<p class="contest_tit">발행년 : 2022</p>
			</div>
			</p>
		</a>
		<div class="btnBox">
			<span class="contest_btn view_pdf" data-keyvalue="/resources/common/pdf/bookList_02.pdf">도서 목록</span>
			<span class="contest_btn view_pdf2" <c:if test="${not empty sessionScope.loginSupport and sessionScope.loginSupport.login}">data-keyvalue='/resources/common/pdf/bookList_all_02.pdf'</c:if>>전문 (PDF)</span>
		</div>
	</div>

	<div class="box">
		<a href="#" onclick="open_magazine('/resources/common/pdf/bookList_01.pdf');">
			<p class="contest_thum"><img src="/data/menuResources/h1/259/1707785291060.jpg" alt="1집 표지"></p>
			<div class="titleBox">
				<p class="contest_num">목록 1집</p>
				<p class="contest_tit">발행년 : 2021</p>
			</div>
		</a>
		<div class="btnBox">
			<span class="contest_btn view_pdf" data-keyvalue="/resources/common/pdf/bookList_01.pdf">도서 목록</span>
			<span class="contest_btn view_pdf2" <c:if test="${not empty sessionScope.loginSupport and sessionScope.loginSupport.login}">data-keyvalue='/resources/common/pdf/bookList_all_01.pdf'</c:if>>전문 (PDF)</span>
		</div>
	</div>
</div>