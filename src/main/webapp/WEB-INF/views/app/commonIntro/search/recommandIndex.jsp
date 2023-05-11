<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<script type="text/javascript">
</script>
<form:form id="librarySearchForm" modelAttribute="librarySearch" action="recommandIndex.do" method="get">
<form:hidden path="menu_idx"/>
<c:choose>
	<c:when test="${homepage.context_path eq 'seobu' and empty librarySearch.shelfCode}">
		<form:hidden path="shelfCode" value="AF37"/>
		<form:hidden path="booktype" value="BOOKANDNONBOOK"/>
	</c:when>
	<c:otherwise>
		<form:hidden path="shelfCode"/>
		<form:hidden path="booktype"/>
	</c:otherwise>
</c:choose>

	<div class="serial-wrap">
		<div class="smain">
			<div class="box">
				<div class="search-results">
					<c:forEach items="${bookSearch}" var="i">
					<c:set var="detailURL" value="recommandDetail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${fn:escapeXml(i.ST_CODE)}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}&bookkey=${i.BOOK_KEY}"></c:set>
					<div class="row">
						<div class="thumb">
							<c:choose>
								<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
									<a href="${detailURL}" class="noImg">
										<img src="/resources/homepage/libculture/img/book_noimg.png" alt="${i.TITLE_INFO}" onError="src='/resources/homepage/libculture/img/book_noimg.png';"/>
									</a>
								</c:when>
								<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
									<a href="${detailURL}">
										<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}" onError="src='/resources/common/img/noimg-gall.png';"/>
									</a>
								</c:when>
								<c:otherwise>
									<a href="${detailURL}">
										<img src="${i.imageUrl}" alt="${i.TITLE_INFO}" onError="src='/resources/common/img/noimg-gall.png';"/>
									</a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="box">
							<div class="item">
								<div class="bif">
									<a href="${detailURL}" class="name">
										${i.TITLE_INFO}
									</a>
									<ul class="con2">
										<li>저자 : ${fn:substring(i.AUTHOR, 0, 20)}<c:if test="${fn:length(i.AUTHOR) > 20}">...</c:if></li>
										<li>출판사 : ${fn:substring(i.PUBLISHER, 0, 20)}<c:if test="${fn:length(i.PUBLISHER) > 20}">...</c:if></li>
										<li>출판년도 : ${i.PUB_YEAR}</li>
										<li>소장자료실 : ${i.SHELF_LOC_NAME}</li>
										<li>청구기호 : ${i.CALL_NO}</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					</c:forEach>
					<c:if test="${fn:length(bookSearch) < 1}">
					<div class="nodata">
						<i class="fa fa-frown-o"></i>
						<p>등록된 데이터가 없습니다.</p>
					</div>
					</c:if>
	
				</div>
				<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
					<jsp:param name="formId" value="#librarySearchForm"/>
					<jsp:param name="pagingUrl" value="recommandIndex.do"/>
				</jsp:include>	
			</div>
		</div>
	</div>
</form:form>