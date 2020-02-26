<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	$('div#board_paging a').on('click', function(e) {
		$('#viewPage').attr('value', $(this).attr('keyValue'));
		var param = serializeCustom($('form#accessHistory'));
		doGetLoad('index.do', param);
		e.preventDefault();
	});

	$('a#board_btn_search').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#accessHistory'));
		doGetLoad('index.do', param);
	});

	$('input#search_text_board').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#accessHistory'));
			doGetLoad('index.do', param);
		}
	});
});

</script>


<style>

.book-wr {background:url('/resources/homepage/dgportal/img/book_pttr.gif') repeat;padding:3px;}
.book-wr .book-box {position:relative;background:#fdfdfd;padding: 30px 30px 35px 30px;min-height: 230px;}
.book-wr .book-box .book-thum {position:absolute;top:30px;left:30px;width:340px;height:auto;}
.book-wr .book-box .book-thum .img {display:block;position:relative;width: 180px;height: 228px;padding-bottom: 0;overflow:hidden;box-shadow:10px 10px 0px #eee;}
.book-wr .book-box .book-thum .img img {position: relative;top:0;left:0;width: 180px;height: 228px;}
.book-wr .book-box .book-cont {position:relative;margin-left: 220px;}
.book-wr .book-box .book-cont .byear {font-size: 1.125em;line-height:1;color: #ed145b;padding-top: 0;padding-left: 0;}
.book-wr .book-box .book-cont .btit {font-size: 1.375em;line-height:1;color:#222;font-weight: bold;padding-top: 10px;padding-left: 0;}
.book-wr .book-box .book-cont .stit {font-size:20px;line-height:1;margin-top:30px;margin-bottom:5px;}
.book-wr .book-box .book-cont .stit span {display:inline-block;vertical-align:top;border-top:2px solid #005baa;color:#005baa;padding-top:7px;}
.book-wr .book-box .book-cont .bname {margin-top: 10px;}
.book-wr .book-box .book-cont .btxt {margin-top:20px}

.book-wr .book-box .book-thum2 {position:absolute;top:30px;left:30px;width: 280px;height:auto;}
.book-wr .book-box .book-thum2 .img {display:block;position:relative;width: 100%;height: 375px;padding-bottom: 0;overflow:hidden;box-shadow:10px 10px 0px #eee;}
.book-wr .book-box .book-thum2 .img img {position: relative;top:0;left:0;width: 280px;height: 375px;}
.book-wr .book-box .book-cont2 {position:relative;margin-left: 320px;}
.book-wr .book-box .book-cont2 .byear {font-size: 1.375em;line-height:1;color: #000;padding-bottom: 20px;padding-top:0;padding-left: 0;}
.book-wr .book-box .book-cont2 .btit {font-size: 1.375em;line-height:1;color:#222;font-weight: bold;padding-top: 5px;padding-left: 0;}
.book-wr .book-box .book-cont2 .stit {font-size:20px;line-height:1;margin-top:30px;margin-bottom:5px;}
.book-wr .book-box .book-cont2 .stit span {display:inline-block;vertical-align:top;border-top:2px solid #005baa;color:#005baa;padding-top:7px;}
.book-wr .book-box .book-cont2 .bname {margin-top:20px}
.book-wr .book-box .book-cont2 .btxt {margin-top:20px}

@media only screen and (max-width:1199px){
	.book-wr .book-box {padding-left:25px;padding-right:25px;}
	.book-wr .book-box .book-thum {left:25px;}
	.book-wr .book-box .book-thum2 {left:25px;}
}
@media only screen and (max-width:999px){
	.book-wr .book-box {padding-bottom:55px;}
	.book-wr .book-box .book-thum {position:static;top:auto;left:auto;float:left;margin-right:30px;width:38%;margin-bottom:0;}
	.book-wr .book-box .book-cont {margin-left:0;}
	.book-wr .book-box .book-cont .btit {font-size:25px}
	.book-wr .book-box .book-cont .stit {margin-top:35px}

	.book-wr .book-box .book-thum2 {position:static;top:auto;left:auto;float:left;margin-right:30px;width:38%;margin-bottom:0;}
	 .book-wr .book-box .book-cont2 {margin-left:0;}
}
@media only screen and (max-width:899px){
	.book-wr .book-box {padding:30px 20px 55px;}
	.book-wr .book-box .book-thum {width:28%;margin-bottom:10px;}
	.book-wr .book-box .book-thum .img {box-shadow:7px 7px 0 #eee;}
	.book-wr .book-box .book-thum {float:none;width:auto;max-width: 180px;min-height: 228px;margin:0 auto 20px;}

    .book-wr .book-box .book-thum2 {width:28%;margin-bottom:10px;}
	.book-wr .book-box .book-thum2 .img {box-shadow:7px 7px 0 #eee;height: 228px;}
	.book-wr .book-box .book-thum2 {float:none;width:auto;max-width: 180px;min-height: 228px;margin:0 auto 20px;}

	.book-wr .book-box .book-cont {text-align:center;}
	.book-wr .book-box .book-cont:nth-child(2) {min-height:auto;}
	.book-wr .book-box .book-cont .btit, .book-wr .book-box .book-cont .btn-home {display:inline-block;vertical-align:middle;margin-bottom:10px;}
	.book-wr .book-box .book-cont .btit {margin-top:-4px;margin-right:10px;}
	.book-wr .book-box .book-cont .stit {text-align:left;margin-top:20px;}
	.book-wr .book-box .book-cont .btxt, .book-wr .book-box .book-cont p {margin-top:5px;text-align:left;}
	.book-wr .book-box .book-cont .bname {margin-top:5px;text-align:left;}
	.book-wr .book-box .book-cont .c-txt {text-align:left;}
	.book-wr .book-box .book-thum2 .img img {height: 228px;}

}
@media only screen and (max-width:649px){
	.book-wr .book-box {padding-left:10px;padding-right:10px;padding-top: 20px;}
	.book-wr .book-box .book-cont .btit {font-size:22px;padding-top:10px;}
	.book-wr .book-box .book-cont .stit {font-size:17px;margin-bottom:10px}
	.book-wr .book-box .book-cont .btxt, .book-wr .book-box .book-cont p {margin-top:5px;text-align:left;}
	.book-wr .book-box .book-cont .c-txt {line-height:22px;font-size:14px;}
}
@media only screen and (max-width:599px){
	.book-wr .book-box .book-thum .gradu-info {margin-bottom:5px}
	.book-wr .book-box .book-cont .btit {margin-right:5px;font-size:20px}
}
@media only screen and (max-width:499px){
	.book-wr .book-box {padding-bottom: 20px;}
}
h3.byear { background: none;}
</style>

<c:forEach items="${boyList}" var="i" varStatus="status">
<div class="book-wr mg20t">
    <div class="book-box">
      <div class="book-thum"><span class="img"> <img alt="" src="${i.book_img_url}"> </span> </div>
      <div class="book-cont">
        <h3 class="byear">${i.selection_year}년 선정도서</h3>
        <p class="btit">${i.book_name}</p>
        <p class="bname">저자명 : ${i.book_name}｜출판사 : ${i.book_publisher}｜출판년도 : ${i.book_year}</p>
        <p class="btxt">
        	<c:set value="${fn:replace(i.book_content, crlf, '<br/>')}" var="content"></c:set>
			${content}
        </p>
      </div>
    </div>
  </div>
</c:forEach>