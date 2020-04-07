<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
// 	$('div.search-info').html("검색결과 '<b class=\"og\"><i>${book.search_text}</i></b>'에 대한 <b>${book.viewPage}</b>/${book.totalPageCount}페이지, 총 <b>${book.totalDataCount}</b>건");
	$('#book_search_text').text('${book.search_text}');
	$('#book_viewPage').text('${book.viewPage}');
	$('#book_totalPageCount').text('${book.totalPageCount}');
	$('#book_totalDataCount').text('${book.totalDataCount}');

	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		$('#detail_book_idx').val($(this).data('book_idx'))
		$('#detail_type').val($(this).data('type'))
		$('form#detailForm').submit();
	});
});
</script>

<form:form id="searchTableForm" modelAttribute="book" method="GET">
<c:forEach items="${bookList}" var="i">
	<div class="row">
		<div class="thumb">
			<c:choose>
				<c:when test="${i.book_image eq ''}">
					<a href="#" data-book_idx="${i.book_idx}" data-type="${i.type}" class="goDetail noImg">
						<img src="/resources/common/img/noImg.gif" alt="noImage" />
					</a>
				</c:when>
				<c:otherwise>
					<a href="#" data-book_idx="${i.book_idx}" data-type="${i.type}" class="goDetail">
						<img src="${i.book_image}" alt="${i.book_name}" onerror="this.src='/resources/homepage/dgportal/img/book_noimg.png'"/>
					</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="box">
			<div class="item">
				<div class="bif">
					<c:set var="replaceStr" value="<span style='color:#ffa651'>${book.search_text}</span>"/>
					<a href="#" data-book_idx="${i.book_idx}" data-type="${i.type}" class="name goDetail">${fn:replace(i.book_name, book.search_text, replaceStr)}</a>
					<p>${fn:replace(i.author_name, book.search_text, replaceStr)}</p>
					<p>${fn:replace(i.book_pubname, book.search_text, replaceStr)}, ${i.book_pubdt}</p>
					<p>${i.library_name}</p>
					<br/>
					<p>대출 가능 여부: ${fn:escapeXml(i.status)}<span class="txt-bar">&nbsp;</span>대출 : ${fn:escapeXml(i.book_lend)}<span class="txt-bar">&nbsp;</span>예약 : ${i.book_reserve}</p>
				</div>
				<div class="bci" style="display: none;">
					<!-- ajax_area -->
				</div>
			</div>
		</div>
	</div>
</c:forEach>
<jsp:include page="/WEB-INF/views/app/cms/common/paging_search2.jsp" flush="false">
	<jsp:param name="formId" value="#book"/>
	<jsp:param name="pagingUrl" value="index.do"/>
</jsp:include>
</form:form>
