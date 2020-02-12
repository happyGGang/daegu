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
.sview h4{font-size:130%;font-weight:bold;padding:10px 0}
.sview .sinfo{margin:15px 0;background: #fffef9;overflow:hidden;padding: 25px 40px;border: 1.5px solid #f6f7e5;}
@media all and (max-width:1000px){
	.sview .sinfo{padding-left:5%;padding-right:5%}
}
@media all and (max-width:767px){
	.sview .sinfo{padding-left:3%;padding-right:3%}
}
.sview .sinfo .thumb img{border:1px solid #d5d5d5}
.sview .sinfo .thumb{float:left;width:20%;font-size:0;line-height:0}
.sview .sinfo .info{float:left;width:100%;margin-right: -20%;}
.sview .sinfo .info ul{margin: -1% 20% 1% 4%;}
.sview .sinfo .info ul li{padding: 5px 0px;line-height:110%;}
.sview b.title{font-size:135%;font-weight:800;line-height: 160%;}
.sview .sinfo .info ul li.ibtn{border:0;text-align:right;padding:15px 0 0}
.sview .sinfo .info ul li.ibtn a i{margin:0 0 0 5px}

.sview .sbtn{text-align:center;padding:30px 0 20px}
.sview .sbtn .btn{padding:7px 2%}
.sview .sbtn .btn i{font-size:130%}
.sview .sbtn .btn1{background:#fe6d02;border-color:#fe6d02}
.sview .sbtn .btn2{background:#666;border-color:#666}
</style>

<c:set var="b_idx" value="${fn:length(boyList) - 1}"></c:set>
<c:set var="selected" value="deactive"></c:set>
<div class="tabmenu tab1">
	<ul>
		<c:forEach items="${boyList}" var="i" varStatus="status">
		<c:if test="${fn:escapeXml(i.selection_year) eq fn:escapeXml(param.selection_year)}">
		<c:set var="b_idx" value="${status.index}"></c:set>
		<c:set var="selected" value="active"></c:set>
		</c:if>

		<li class="${selected}">
			<a href="/${homepage.context_path}/module/bookOfYear/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&selection_year=${fn:escapeXml(i.selection_year)}">
			${i.selection_year}년
			</a>
		</li>

		<c:set var="selected" value="deactive"></c:set>

		</c:forEach>
	</ul>
</div>

<c:set var="book" value="${boyList[b_idx]}"></c:set>
<div class="search-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<img src="${book.book_img_url}" alt="${book.book_name}">
			</div>
			<div class="info">
				<ul>
					<li>
						<b>${book.book_name}</b>
					</li>
					<li>저자 : ${book.book_author}</li>
					<li>출판사 : ${book.book_publisher}</li>
					<li>출판년도 : ${book.book_year}</li>
				</ul>
			</div>
		</div>
		<div>
			<c:set value="${fn:replace(book.book_content, crlf, '<br/>')}" var="content"></c:set>
			${content}
		</div>
	</div>
</div>
