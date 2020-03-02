<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	//검색하기
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('index.do', serializeCustom($('#librarySearch')));
	});

	//이미지 목록형
	$('.imgView').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('on');
		$('.listView').removeClass('on');
		$('.search-results .cont ul').removeClass();
		if($(this).hasClass('on')){
			$('.search-results .textType').css('display','none');
			$('.search-results .imageType').css('display','block');
		}
	});

	//텍스트 목록형
	$('.listView').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('on');
		$('.imgView').removeClass('on');
		$('.search-results .cont ul').removeClass();
		if($(this).hasClass('on')){
			$('.search-results .imageType').css('display','none');
			$('.search-results .textType').css('display','block');
		}
	});


});
</script>
<form:form modelAttribute="librarySearch" action="index.do" method="GET" onsubmit="return false;">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="subjectCode"/>

	<!-- contents-title-->
	<div id="contents-title">
		<h2>새로운 도서<span style="font-weight:300">를 찾고 싶으세요?</span></h2>
	</div>
	<!-- /contents-title-->

	<div class="search-wrap">

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

			<th><label for="search_date03">간편검색</label></th>
			<td class="search_left">
				<form:radiobutton path="search_type" value="1" title="1주전" label="1주전"/>
				<form:radiobutton path="search_type" value="2" title="1주전" label="2주전"/>
				<form:radiobutton path="search_type" value="3" title="1주전" label="1달전"/>
			</td>
			</tr>
			<tr>

			<th><label for="option01">자료실</label></th>
			<td class="search_left" colspan="3">
				<ul>
					<li style="margin-bottom: 5px;"><form:radiobutton path="shelfCode" value="ALL" label="전체"/></li>
					<c:forEach items="${shelfList}" var="i" varStatus="status">
					<c:choose>
					<c:when test="${homepage.context_path eq 'jungang'}">
						<c:if test="${i.CODE eq 'AD20' or i.CODE eq 'AD04' or i.CODE eq 'AD06' or i.CODE eq 'AD15' or i.CODE eq 'AD12' or i.CODE eq 'AD36'}">
					<li style="width: 33%; float: left;"><form:radiobutton path="shelfCode" value="${i.CODE}" label="${i.DESCRIPTION}"/></li>
						</c:if>
					</c:when>
					<c:when test="${homepage.context_path eq 'dongbu'}">
						<c:if test="${fn:indexOf(i.DESCRIPTION, '제적') < 0}">
					<li style="width: 33%; float: left;"><form:radiobutton path="shelfCode" value="${i.CODE}" label="${i.DESCRIPTION}"/></li>
						</c:if>
					</c:when>
					<c:otherwise>
					<li style="width: 33%; float: left;"><form:radiobutton path="shelfCode" value="${i.CODE}" label="${i.DESCRIPTION}"/></li>
					</c:otherwise>
					</c:choose>

					</c:forEach>

				</ul>
			</td>
			</tr>
			</tbody>
			</table>
			<div class="center" style="padding:0 0 50px 0">
				<a id="search-btn" class="btnNew btn-warning btn-xs mT1">검색</a>
			</div>
		</div>


		<div class="search-wrap">

			<div class="smain">
				<div class="box">
					<div style="overflow:hidden">
						<div class="bbs-result">* 검색결과 총 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건</div>

						<div class="mode">
							<ul>
								<li><a href="#;" class="btn-View imgView on">이미지형 표지형 설정</a></li>
								<li><a href="#;" class="btn-View listView">목록형 표지형 설정</a></li>
							</ul>
						</div>
					</div>
					<div id="search-results" class="search-results wide">
						<!-- 이미지형 -->
						<div class="imageType">
							<!-- 결과루프 -->
							<c:choose>
								<c:when test="${fn:length(newBookList) > 0}">
									<c:forEach items="${newBookList}" var="i">
									<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
									<div class="row">
										<div class="thumb">
										<c:choose>
										<c:when test="${empty i.aladin or empty i.aladin.cover}">
										<a href="${detailURL}">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
											<span>등록된 이미지가<br/>없습니다.</span>
										</a>
										</c:when>
										<c:otherwise>
										<a href="${detailURL}">
											<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
										</a>
										</c:otherwise>
										</c:choose>
										</div>
										<div class="box">
											<div class="item">
												<div class="bif">
													<a href="${detailURL}">
													<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span></a>
													<p>
													<font style="color:#5e5e5e">저자</font> : ${i.AUTHOR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">출판정보</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">등록번호</font> : ${i.REG_NO}<br/><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span><br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">자료실</font> : ${i.SHELF_LOC_NAME}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<!-- 대출가능 여부 [START] -->
													<c:choose>
														<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
															<c:choose>
																<c:when test="${i.RESERVATION_CNT > '0'}">
																	<span style="color:#ff0000">대출불가(예약도서)</span>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																			대출불가(열람제한도서)
																		</c:when>
																		<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																			귀중자료(관내열람만가능)
																		</c:when>
																		<c:otherwise>
																			대출가능
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																	<span style="color:#ff0000">대출불가(관외대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																	<span style="color:#ff0000">대출불가(관내대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																	<span style="color:#ff0000">대출불가(타관반납중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																	<span style="color:#ff0000">대출불가(타관대출중)</span>
																</c:when>
																<c:otherwise>
																	<span style="color:#ff0000">대출불가</span>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
													<!-- 대출가능 여부 [ END ] -->
													</p>
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
							<!-- 결과루프끝 -->
						</div>


						<!-- 텍스트형 -->
						<div class="textType" style="display:none">
							<!-- 결과루프 -->
							<c:choose>
								<c:when test="${fn:length(newBookList) > 0}">
									<c:forEach items="${newBookList}" var="i">
									<c:set var="detailURL" value="/${homepage.context_path}/intro/search/detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
									<div class="row">
										<div class="box">
											<div class="item">
												<div class="bif">
													<a href="${detailURL}" class="name goDetail">
													<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span></a>
													<p>
													<font style="color:#5e5e5e">저자</font> : ${i.AUTHOR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">출판정보</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">등록번호</font> : ${i.REG_NO}<br/><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span><br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">자료실</font> : ${i.SHELF_LOC_NAME}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<!-- 대출가능 여부 [START] -->
													<c:choose>
														<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
															<c:choose>
																<c:when test="${i.RESERVATION_CNT > '0'}">
																	<span style="color:#ff0000">대출불가(예약도서)</span>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																			대출불가(열람제한도서)
																		</c:when>
																		<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																			귀중자료(관내열람만가능)
																		</c:when>
																		<c:otherwise>
																			대출가능
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																	<span style="color:#ff0000">대출불가(관외대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																	<span style="color:#ff0000">대출불가(관내대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																	<span style="color:#ff0000">대출불가(타관반납중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																	<span style="color:#ff0000">대출불가(타관대출중)</span>
																</c:when>
																<c:otherwise>
																	<span style="color:#ff0000">대출불가</span>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
													<!-- 대출가능 여부 [ END ] -->
													</p>
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
							<!-- 결과루프끝 -->

						</div>

					</div>
				</div>
			</div>

		</div>



	</div>
</form:form>
