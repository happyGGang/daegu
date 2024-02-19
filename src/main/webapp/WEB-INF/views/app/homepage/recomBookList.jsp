<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
.contestBox{clear:both;overflow:hidden;width:100%;}
.contestBox .box{float:left;width:33.3%;text-align:center;margin-bottom:60px;}
.contestBox .box .contest_thum{position:relative;display:inline-block;width:205px;height:280px;top:0;font-size:0;line-height:0;transition:all 0.2s ease;-webkit-transition:all 0.2s ease;}
.contestBox .box .contest_thum img{width:205px;height:280px;}

.contestBox .box .titleBox {display: flex;margin:4px 0 10px 0;width:100%;justify-content: center;align-items: center;}
.contestBox .box .titleBox .contest_num{display:inline-block;width:90px;height:30px;line-height:30px;letter-spacing:0;font-size:14px;border:1px solid #6556e9;color:#6556e9;border-radius:20px;}
.contestBox .box .titleBox .contest_tit{font-size:14px;color:#666;margin-left: 10px;}
.contestBox .box .btnBox .contest_btn{display:inline-block;color:#fff;padding:10px 0; font-weight:normal;font-size:14px;line-height:normal;vertical-align:middle;text-align:center;cursor:pointer;border:0;letter-spacing:-0.05em;background-color:#0738a8;margin-bottom: 5px;width: 100px;}

.contestBox .box a:hover .contest_thum{top:-4px;box-shadow:0px 20px 30px 0px rgba(0,13,56,0.2);transition:all 0.2s ease;-webkit-transition:all 0.2s ease;}
.contestBox .box a:hover .titleBox .contest_tit{text-decoration:underline;}
.contestBox .box a:hover .btnBox .contest_btn{background:#cfd4de;color:#fff;cursor:pointer;}

@media all and (max-width:1000px){
	.contestBox {width: 125%;}
}
@media all and (max-width:850px){
	.box{height:auto;}
	.contestBox .box{width:50%;}
	.contestBox .box .btnBox .contest_btn{bottom:-30px;}
}
@media all and (max-width:768px){
	.contestBox {width: 100%;}
	.contestBox .box .btnBox .contest_btn{bottom:20px;}
}
@media all and (max-width:480px){
	.contestBox .box .contest_thum{width:130px; height: 180px;}
	.contestBox .box .titleBox .contest_num{font-size:13px;}
	.contestBox .box .titleBox .contest_tit{line-height:22px;font-size:13px;}
	.contestBox .box .btnBox .contest_btn{font-size:13px;padding:8px 0;width: 130px;}
}
@media all and (max-width:450px){
	.contestBox .box .titleBox{display: block;}
	.contestBox .box .titleBox .contest_tit{margin: 5px 0 -4px 0px;}
}
</style>
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