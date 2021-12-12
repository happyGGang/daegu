<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:choose>
	<c:when test="${param.type == 'EBK'}">
		<c:set var="type_name" value="전자책이"/>
	</c:when>
	<c:when test="${param.type == 'ADO'}">
		<c:set var="type_name" value="오디오북이"/>
	</c:when>
	<c:when test="${param.type == 'WEB'}">
		<c:set var="type_name" value="온라인강좌가"/>
	</c:when>
	<c:otherwise>
		<c:set var="type_name" value="전자책이"/>
	</c:otherwise>
</c:choose>
<script>
	$(document).ready(function() {

		$('a.book_link').on('click', function(e) {
			e.preventDefault();
			$('#book_idx').val($(this).data('book_idx'));
			$('#menu_idx').val('15');
			$('#menu').val('BEST');
			$('#type').val('EBK');
			$('form#bookListForm').prop('action', '/elib/module/elib/book/view.do');
			$('form#bookListForm').submit();
			$('form#bookListForm').prop('action', 'index.do');
		});

	});
</script>

<form:form id="bookListForm" modelAttribute="book" action="index.do" method="GET" autocomplete="off">
	<form:hidden path="menu_idx"/>
	<form:hidden path="menu"/>
	<form:hidden path="type"/>
	<form:hidden path="sortField"/>
	<form:hidden path="sortType"/>
	<form:hidden path="parent_id"/>
	<form:hidden path="cate_id"/>
	<form:hidden path="com_code"/>
	<form:hidden path="book_idx"/>
	<form:hidden path="device"/>
	<form:hidden path="library_code"/>
	<div class="elib_top">
		<!-- 전자책 총 권수, 검색 조건 시작-->
		<div class="sub001">
			<div class="lsort">
				<c:choose>
					<c:when test="${book.menu == 'CATEGORY'}">
						<span>${category.cate_name}</span> 분류에
					</c:when>
					<c:when test="${book.menu == 'PROVIDER'}">
						<span>${book.comp_name}</span> 분류에
					</c:when>
				</c:choose>
				<span><fmt:formatNumber value="${bookListCnt}" pattern="#,###" /></span> 종의 ${type_name} 있습니다.
			</div>
			<div style="clear:both"></div>
		</div>
	</div>
	<ul class="bbs_webzine elib">
		<c:forEach items="${bookList}" var="i" varStatus="status">
			<li class="elib">
				<div class="thumb">
					<a href="#" class="book_link" data-book_idx="${i.book_idx}" style="background:url(/resources/board/img/lock-bg.gif) no-repeat center center">
						<c:if test="${not empty i.book_image}">
							<img src="${i.book_image}" alt="${i.book_name}" onError="this.src='/resources/common/img/noImg2.png'" />
						</c:if>
						<c:if test="${empty i.book_image}">
							<img src="/resources/common/img/noImg.gif" alt="noImage"/>
						</c:if>
					</a>
				</div>
				<div class="list-body">
					<div class="flexbox">
						<a href="#" class="book_link" data-book_idx="${i.book_idx}">
							<b>${fn:escapeXml(i.book_name)}</b>
						</a>
						<div class="info">
							<span>${fn:escapeXml(i.book_pubname)}</span>
							<span class="txt-bar">&nbsp;</span>
							<span>${fn:escapeXml(i.author_name)}</span>
							<span class="txt-bar">&nbsp;</span>
							<span>${fn:escapeXml(i.book_pubdt)}</span>
						</div>
						<c:set var="body" value="${i.book_info}"/>
						<%
							try {
								String body = (String)pageContext.getAttribute("body");
								if(body != null) {
									body = body.replaceAll("<[^>]*>", " ");
								}
								pageContext.setAttribute("body", body);
							} catch (Exception e) {

							}
						%>
						<c:if test="${fn:length(body) > 200}">
							<c:set var="body" value="${fn:substring(body, 0, 200)}..."/>
						</c:if>
						<span class="snipet">${fn:escapeXml(body)}</span>
					</div>
					<div class="meta">
						<label>소속도서관:</label>
						<span>${fn:escapeXml(i.library_name)}</span>
						<span class="txt-bar">&nbsp;</span>
						<label>공급사:</label>
						<span>${fn:escapeXml(i.comp_name)}</span>
						<c:if test="${i.type == 'EBK' or (i.type == 'ADO' and (i.com_code == 'FXLI' or i.com_code == 'KYOB' or i.com_code == 'ALAD'))}">
							<span class="txt-bar">&nbsp;</span>
							<span>대출 가능 여부: ${fn:escapeXml(i.status)}</span>
							<span class="txt-bar">&nbsp;</span>
							<span>대출 : ${fn:escapeXml(i.book_lend)}/${i.max_lend > 0 ? i.max_lend : bookConfig.book_max_lend}<%-- / ${fn:escapeXml(i.max_lend)}--%></span>
							<span class="txt-bar">&nbsp;</span>
							<span>예약 : ${fn:escapeXml(i.book_reserve)}/${bookConfig.book_max_reserve}</span>
							<c:if test="${i.book_reserve > 0}">
							</c:if>
						</c:if>
					</div>
				</div>
			</li>
		</c:forEach>
	</ul>
</form:form>
