<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
#tabCon1 .box{height:360px;}

.contestBox .box{position:relative;width:20%;}
.contestBox .box .contest_tit{font-size:14px;color:#666;padding:8px 0;}

.contestBox{clear:both:overflow:hidden;width:100%;}
.contestBox .box{float:left;width:33.3%;text-align:center;margin-bottom:60px;}
.contestBox .box .contest_thum{position:relative;display:inline-block;width:170px;height:240px;top:0;font-size:0;line-height:0;transition:all 0.2s ease;-webkit-transition:all 0.2s ease;}
.contestBox .box .contest_thum img{width:170px;height:240px;}
.contestBox .box .contest_num{margin-top:10px;display:inline-block;width:170px;height:30px;line-height:30px;letter-spacing:0;font-size:14px;border:1px solid #6556e9;color:#6556e9;border-radius:20px;}
.contestBox .box .contest_btn{display:inline-block;color:#fff;padding:10px 0; font-weight:normal;font-size:14px;line-height:normal;vertical-align:middle;text-align:center;cursor:pointer;border:0;letter-spacing:-0.05em;background-color:#0738a8;margin-bottom: 5px;width: 170px;}
.contestBox .box a:hover .contest_thum{top:-4px;box-shadow:0px 20px 30px 0px rgba(0,13,56,0.2);transition:all 0.2s ease;-webkit-transition:all 0.2s ease;}
.contestBox .box a:hover .contest_tit{text-decoration:underline;}
.contestBox .box a:hover .contest_btn{background:#cfd4de;color:#fff;}

@media all and (max-width:1000px){
	.contestBox {width: 125%;}
}
@media all and (max-width:768px){
	.contestBox {width: 100%;}
	.contestBox .box .contest_btn{bottom:20px;}
}
@media all and (max-width:640px){
	.box{height:auto;}
	.contestBox .box{width:50%;}
	.contestBox .box .contest_btn{bottom:-30px;}
}
@media all and (max-width:480px){
	.contestBox .box .contest_thum{width:130px; height: 180px;}
	.contestBox .box .contest_num{width:130px;font-size:13px;}
	.contestBox .box .contest_tit{line-height:22px;font-size:13px;}
	.contestBox .box .contest_btn{font-size:13px;padding:8px 0;width: 130px;}
}
</style>
<script>
$(function() {
	<c:choose>
	<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
	$('.view_pdf').on('click', function(e) {
		e.preventDefault();
		var link = $(this).attr('data-keyValue');
		window.open(link, '_blank','fullscreen=yes');
	});
	</c:when>
	<c:otherwise>
	$('.view_pdf').on('click', function(e) {
		e.preventDefault();
		alert('로그인후 이용바랍니다.'); 
		location.href="/228/intro/login/index.do?menu_idx=4&before_url=/228/html/recomBookList.do?menu_idx=259";
	});
	</c:otherwise>
	</c:choose>
});
</script>
<div class="contestBox">
<!-- -->
<div class="box"> 
	<a href="#" onclick="open_magazine('/resources/common/pdf/bookList_03.pdf');">
		<p class="contest_thum"><img src="/data/menuResources/h1/259/1707785301607.jpg" alt="3집 표지"></p>
		<p class="contest_num">목록 3집</p>
		<p class="contest_tit">
			발행년 : 2023
		</p>
	</a>
	<span class="contest_btn view_pdf" data-keyValue="/resources/common/pdf/bookList_03.pdf" style="cursor:pointer;">PDF로 바로보기</span>
</div>

<div class="box">
	<a href="#" onclick="open_magazine('/resources/common/pdf/bookList_02.pdf');">
		<p class="contest_thum"><img src="/data/menuResources/h1/259/1707785296412.jpg" alt="2집 표지"></p>
		<p class="contest_num">목록 2집</p>
		<p class="contest_tit">
		발행년 : 2022
		</p>
	</a>
	<span class="contest_btn view_pdf" data-keyValue="/resources/common/pdf/bookList_02.pdf" style="cursor:pointer;">PDF로 바로보기</span>
</div>

<div class="box">
	<a href="#" onclick="open_magazine('/resources/common/pdf/bookList_01.pdf');">
		<p class="contest_thum"><img src="/data/menuResources/h1/259/1707785291060.jpg" alt="1집 표지"></p>
		<p class="contest_num">목록 1집</p>
		<p class="contest_tit">
			발행년 : 2021
		</p>
	</a>
	<span class="contest_btn view_pdf" data-keyValue="/resources/common/pdf/bookList_01.pdf" style="cursor:pointer;">PDF로 바로보기</span>
</div>
<!-- -->