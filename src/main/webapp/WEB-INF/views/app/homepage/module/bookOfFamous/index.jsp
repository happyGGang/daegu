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


<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<c:forEach items="${boyList}" var="i" varStatus="status">
<div class="book-wr mg20t">
	<div class="book-box">
		<div class="book-thum">
			<span class="img"><img alt="${i.book_name}" src="${i.book_img_url}"></span>
		</div>
		<div class="book-cont">
        <h3 class="byear">${i.famous_name} 명사의 선정도서</h3>
        <p class="btit">${i.book_name}</p>
        <p class="bname">선정년도 : ${i.selection_year}｜저자명 : ${i.book_author}｜출판사 : ${i.book_publisher}｜출판년도 : ${i.book_year}</p>
        <p class="btxt">
        	<c:set value="${fn:replace(i.book_content, crlf, '<br/>')}" var="content"></c:set>
			${content}
        </p>
		</div>
	</div>
</div>
</c:forEach>