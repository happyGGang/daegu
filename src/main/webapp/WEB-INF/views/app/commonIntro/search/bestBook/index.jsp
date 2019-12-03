<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('index.do', serializeCustom($('#librarySearch')));
	});

});
</script>
<form:form modelAttribute="librarySearch" action="index.do" method="GET">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>

	<!-- contents-title-->
	<div id="contents-title">
		<h2>베스트 대출 도서<span style="font-weight:300">를 찾고 싶으세요?</span></h2>
	</div>
	<!-- /contents-title-->

	<div class="search-wrap">

		<!-- 신규 베스트대출  -->
		<div id="search_detail">
			<table class="table_gray" summary="구분,자료형태,자료실,발행년도,본문언어,요약문언어 선택 항목에 관한 테이블입니다.">
			<caption>검색항목</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col style="width:35%">
			</colgroup>
			<tbody>
			<tr>

			<th><label for="option01">서지형태</label></th>
			<td class="search_left">
				<form:radiobutton path="booktype" value="0" title="도서" label="도서"/>
				<form:radiobutton path="booktype" value="1" title="간행물" label="간행물"/>
				<form:radiobutton path="booktype" value="2" title="비도서" label="비도서"/>
			</td>

			</tr>

			</tbody>
			</table>

			<div class="center" style="padding:0 0 50px 0">
				<a href="#" id="search-btn" class="btnNew btn-warning btn-xs mT1">검색</a>
			</div>
		</div>

		<div class="search-wrap">
			<div id="search_result" class="search_result">

				<!-- list [START] -->
				<div id="search-results" class="search-results">
					<div class="imageType">
						<!-- 루프 시작 -->
						<c:choose>
							<c:when test="${fn:length(bestBookList) > 0}">
								<c:forEach items="${bestBookList}" var="i">
								<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
								<div class="row">
									<div class="thumb">
										<c:choose>
										<c:when test="${empty i.IMAGE}">
											<a href="${detailURL}">
												<img src="/resources/homepage/common/img/noImg2.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
												<span>등록된 이미지가<br/>없습니다.</span>
											</a>
										</c:when>
										<c:otherwise>
										<a href="${detailURL}">
											<img src="${i.IMAGE}" alt="${i.VOL_TITLE} 상세보기"/>
										</a>
										</c:otherwise>
										</c:choose>
									</div>
									<div class="box">
										<div class="item">
											<div class="bif">
												<a href="${detailURL}"><span style='color:#e84e0e;font-weight:600'>${i.TITLE}</span></a>
												<p><font style="color:#5e5e5e;">저자</font> : ${i.AUTHOR}</p>
												<p><font style="color:#5e5e5e">출판사</font> : ${i.PUBLISHER}</p>
												<p><font style="color:#5e5e5e">출판년도</font> : ${i.PUB_YEAR}</p>
												<p><font style="color:#5e5e5e">소장처</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span></p>
												<p><font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}<p>
												<p><font style="color:#5e5e5e">자료실위치</font> : ${i.SHELF_LOC_NAME}<p>
												<p><font style="color:#5e5e5e">대출횟수</font> : ${i.CNT}<p>
											</div>
										</div>
									</div>
								</div>
								</c:forEach>
								<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
							</c:when>
							<c:otherwise>
								<br/>
								<h3> 조회된 도서가 없습니다. </h3>
								<br/>
							</c:otherwise>
						</c:choose>
						<!-- 루프 끝 -->
					</div>
				</div>
				<!-- list [ END ] -->
			</div>
		</div>

	</div>
</form:form>
