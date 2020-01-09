<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {

	var $form = $('form#librarySearch');

	//검색하기
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('index.do', $form.serialize());
	});

	//정렬, N개씩보기
	$('select#rowCount, select#sortType, select#sortField').on('change', function() {
		$('a#search-btn').click();
	});

	//소장정보 펼치기/접기
	$('a.showSlide').on('click', function(e) {
		e.preventDefault();

		var bci = $(this).parents('div.box').next('div.bci');
		var toggleState = $(bci).is(':hidden');
		if (toggleState)
		{
			$(this).css('background','#758194');
			$(this).text('소장정보');
			$(bci).slideToggle();
		} else {
			$(this).css('background','#a5856d');
			$(this).text('소장정보');
			$(bci).slideToggle();
		}
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

	//외국어 입력기
	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('search_text','vk');
	});

	//전체 선택
	$('#checkAllBook').change(function(e) {
		$('input.checkBook').prop('checked', $(this).prop('checked'));
	});

	$('a#addMyLib').on('click', function(e) {
		e.preventDefault();
		var len = $('input.checkBook:checked').length;
		if (len < 1) {
			alert('선택된 책이 없습니다.');
			return false;
		}
		//TODO
		alert('준비중입니다');
		//내 보관함 이동.
	});

	//인기검색어
	$('div#hotTrend').load('hotTrend.do');

	//청구기호 인쇄
	$('a.btn_print').on('click', function(e) {
		e.preventDefault();
		var url = $(this).data('param').replace('detail', 'print');

		window.open(url, '_blank', 'toolbar=yes,scrollbars=yes,resizable=yes,top=100,left=100,width=700,height=500');
	});

	//결과 내 재검색
	$('a#subSearch').on('click', function(e) {
		e.preventDefault();
		var type = $('select#subSearchType').val();
		var beforeText = $('input#'+type).val();
		var newText = (beforeText == '') ? newText = $('input#subSearchText').val() : $('input#'+type).val()+ ' ' +$('input#subSearchText').val();
		$('input#'+type).val(newText);
		$('a#search-btn').click();
	});

	//결과 내 재검색
	$('input#subSearchText').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#subSearch').click();
		}
	});

});
</script>
<form:form modelAttribute="librarySearch" id="detailForm" action="detail.do" method="post" >
	<form:hidden path="menu_idx"/>
	<form:hidden path="isbn"/>
	<form:hidden path="regNo"/>
	<form:hidden path="manageCode"/>
</form:form>

<form:form modelAttribute="librarySearch" action="index.do" method="get">
	<form:hidden path="menu_idx"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="separateShelfCode"/>

	<!-- contents-title-->
	<div id="contents-title">
		<h2>어떤 도서<span style="font-weight:300">를 찾고 싶으세요?</span></h2>
	</div>
	<!-- /contents-title-->

	<div class="search-wrap">

		<div class="search-form">

			<!-- 검색하기_일반 -->
			<div class="searchbox detail_search" id="div_detail">
				<div class="section">
					<dl>
						<dt>도서관</dt>
						<dd>
							<form:select path="manageCode">
								<form:option value="ALL">전체 도서관</form:option>
								<form:option value="${homepage.manage_code}">${homepage.homepage_name}</form:option>
							</form:select>
						</dd>
					</dl>
					<dl>
						<dt><label for="title" class="title">제목</label></dt>
						<dd><form:input path="title" class="text-area"/></dd>
					</dl>

					<dl>
						<dt><label for="author" class="title">저자</label></dt>
						<dd><form:input path="author" class="text-area"/></dd>
					</dl>
					<dl>
						<dt>주제</dt>
						<dd>
							<form:select path="subjectCode">
								<form:option value="">전체</form:option>
								<form:option value="0">총류</form:option>
								<form:option value="1">철학</form:option>
								<form:option value="2">종교</form:option>
								<form:option value="3">사회과학</form:option>
								<form:option value="4">순수과학</form:option>
								<form:option value="5">기술과학</form:option>
								<form:option value="6">예술</form:option>
								<form:option value="7">언어</form:option>
								<form:option value="8">문학</form:option>
								<form:option value="9">역사</form:option>
							</form:select>
						</dd>
					</dl>

					<dl>
						<dt><label for="publer" class="title">발행처</label></dt>
						<dd><form:input path="publer" class="text-area"/></dd>
					</dl>
					<dl>
						<dt><label for="keyword" class="title">키워드</label></dt>
						<dd><form:input path="keyword" class="text-area"/></dd>
					</dl>

					<dl>
						<dt>발행년도</dt>
						<dd>
							<div class="box">
								<form:input path="search_start_date" title="시작년도" numberOnly="true" maxlength="4" />
								<span style="width:6%;text-align:center;">~</span>
								<form:input path="search_end_date" title="마지막년도" numberOnly="true" maxlength="4" />
							</div>
						</dd>
					</dl>

					<dl>
						<dt>자료형태</dt>
						<dd>
							<div class="" style="padding:3px 0 0 10px">
							<form:radiobutton path="booktype" value="BOOK" class="radiocheck" checked="checked"/><label for="booktype1" class="booktype">도서</label>
							<form:radiobutton path="booktype" value="NONBOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype2" class="booktype">비도서</label>
							<form:radiobutton path="booktype" value="SERIAL" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype3" class="booktype">간행물</label>
							</div>
						</dd>
					</dl>

				</div>
				<p class="btn_w">
					<a id="search-btn" class="btnNew btn-warning btn-xs mT1">검색</a>
					<a id="vk-popup" class="btnNew2">다국어입력기</a>
				</p>
			</div>
			<!--// 검색하기_일반 -->

			<br/>
			<div id="autoFill">
			</div>
		</div>

		<br/>

		<c:if test="${not empty paging and librarySearch.totalDataCount eq 0}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>

		<c:if test="${librarySearch.totalDataCount > 0}">

		<!--search_result-->
		<div id="search_result" class="search_result">

			<div class="search-info" >
				검색결과 총 <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건이 검색되었습니다.
			</div>

			<div>
				<select id="subSearchType">
					<option value="title">서명</option>
					<option value="author">저자</option>
					<option value="publer">발행처</option>
					<option value="keyword">키워드</option>
				</select>
				<input id="subSearchText" placeholder="결과 내 재검색">
				<a href="#" id="subSearch">결과 내 재검색</a>
			</div>

			<div class="search-condition">

				<div class="mode">
					<ul>
						<li><a href="#;" class="btn-View imgView on">이미지형 표지형 설정</a></li>
						<li><a href="#;" class="btn-View listView">목록형 표지형 설정</a></li>
					</ul>
				</div>

			</div>

			<div class="smain">
				<div class="box">
					<div class="ws-toolbar">
						<div class="checkBoxAll">
							<input type="hidden" name="" value="on"/>
							<input id="checkAllBook" name="" type="checkbox" value="Y"/>
							<label for="checkAllBook">전체</label>
						</div>

						<div class="control">
							<form:select path="sortField">
								<form:option value="NONE">정렬없음</form:option>
								<form:option value="TITLE">제목</form:option>
								<form:option value="AUTHOR">저자</form:option>
								<form:option value="PUBLISHER">발행처</form:option>
								<form:option value="PUB_YEAR">발행년도</form:option>
							</form:select>
							<form:select path="sortType">
								<form:option value="ASC">오름차순</form:option>
								<form:option value="DESC">내림차순</form:option>
							</form:select>
							<form:select path="rowCount">
								<form:option value="10" label="10건"></form:option>
								<form:option value="20" label="20건"></form:option>
								<form:option value="30" label="30건"></form:option>
								<form:option value="40" label="40건"></form:option>
								<form:option value="50" label="50건"></form:option>
								<form:option value="100" label="100건"></form:option>
							</form:select>

						</div>
					</div>

					<div id="search-results" class="search-results">
						<div class="imageType">
							<c:forEach items="${bookSearch}" var="i">
							<!-- 검색결과 루프 시작 -->
							<c:set var="detailURL" value="detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${fn:escapeXml(i.ST_CODE)}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype)}"></c:set>
							<div class="row">
								<p class="admin">
									<input name="print_param" type="checkbox" class="checkBook" value="${fn:escapeXml(i.ST_CODE)}_${fn:escapeXml(i.MANAGE_CODE)}"/>
								</p>
								<div class="thumb">
									<c:choose>
										<c:when test="${i.IMAGE eq '' or fn:contains(i.IMAGE, 'noimg')}">
											<a href="${detailURL}" class="noImg">
												<img src="/resources/common/img/noImg2.png" alt="${i.TITLE_INFO}"/>
												<span>등록된 이미지가<br/>없습니다.</span>
											</a>
										</c:when>
										<c:otherwise>
											<a href="${detailURL}">
												<img src="${i.IMAGE}" alt="${i.TITLE_INFO}"/>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="box">
									<div class="item">
										<div class="bif">

											<a href="${detailURL}">
											<c:if test="${librarySearch.booktype eq 'BOOK'}">[도서]</c:if>
											<c:if test="${librarySearch.booktype eq 'NONBOOK'}">[비도서]</c:if>
											<c:if test="${librarySearch.booktype eq 'SERIAL'}">[간행물]</c:if>
											<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span>
											</a>

											<p><font style="color:#5e5e5e;">저자</font> : ${i.AUTHOR}</p>
											<p><font style="color:#5e5e5e">발행처</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}</p>
											<p><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span></p>
											<p><font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}</p>
											<p><font style="color:#5e5e5e">대출가능여부</font> :
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
											<p><font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span></p>
											<div class="stat">
												<a href="#showSlide" class="showSlide"><span>소장정보</span></a>
											</div>
										</div>
									</div>
								</div>
								<div class="bci" style="display:none;">
									<table summary="도서 상태 및 등록 정보" style="text-align:center" class="statusBox">
										<caption>도서 상태 및 등록 정보</caption>
										<colgroup>
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
												<th>소장<br class="mBr"/>위치</th>
												<th>등록<br class="mBr"/>번호</th>
												<th>대출가능<br class="mBr"/>여부</th>
												<th>반납<br class="mBr"/>예정일</th>
												<th>자료위치<br class="mBr"/>인쇄</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${i.SHELF_LOC_NAME}</td>
												<td>${i.REG_NO}</td>
												<td>
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
												</td>
												<td>
													${i.RETURN_PLAN_DATE}
												</td>
												<td>
													<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2">자료위치<br/>인쇄</a>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							</c:forEach>
							<!-- 검색결과루프 끝 -->
							<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
						</div>

						<div class="textType" style="display:none">
							<!-- 검색결과 루프 시작 -->
							<c:forEach items="${bookSearch}" var="i">
							<c:set var="detailURL" value="detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${fn:escapeXml(i.ST_CODE)}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype)}"></c:set>
							<div class="row">
								<div class="box">
									<div class="item">
										<div class="bif">

										<input name="print_param" type="checkbox" class="checkBook" value="${fn:escapeXml(i.ST_CODE)}_${fn:escapeXml(i.MANAGE_CODE)}"/>

											<a href="${detailURL}" class="name">
												<c:if test="${librarySearch.booktype eq 'BOOK'}">[도서]</c:if>
												<c:if test="${librarySearch.booktype eq 'NONBOOK'}">[비도서]</c:if>
												<c:if test="${librarySearch.booktype eq 'SERIAL'}">[간행물]</c:if>
												<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span>
											</a>
											<p>
												<font style="color:#5e5e5e;">저자</font> : ${fn:escapeXml(i.AUTHOR)}
												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">발행처</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">매체구분</font> : ${i.MEDIA_NAME}

												<br/>
												<font style="color:#5e5e5e">소장도서관 </font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span>

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span>

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>

												<font style="color:#5e5e5e">대출가능여부</font> :
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

											<div class="stat">
												<a href="#showSlide" class="showSlide" ><span>소장정보</span></a>
											</div>
										</div>
									</div>
								</div>
								<div class="bci" style="display:none;">
									<table summary="도서 상태 및 등록 정보" style="text-align:center" class="statusBox">
										<caption>도서 상태 및 등록 정보</caption>
										<colgroup>
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
												<th>소장<br class="mBr"/>위치</th>
												<th>등록<br class="mBr"/>번호</th>
												<th>대출가능<br class="mBr"/>여부</th>
												<th>반납<br class="mBr"/>예정일</th>
												<th>자료위치<br class="mBr"/>인쇄</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${i.SHELF_LOC_NAME}</td>
												<td>${i.REG_NO}</td>
												<td>
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
												</td>
												<td>
													${i.RETURN_PLAN_DATE}
												</td>
												<td>
													<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2">자료위치<br/>인쇄</a>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							</c:forEach>
							<!-- 검색결과루프 끝 -->
							<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
						</div>
					</div>
				</div>

				<div class="filter-section">
					<div class="ws-filter" id="hotTrend" style="height:370px;">
						<h4>실시간 검색어 순위</h4>
						<div style="text-align: center;" >
							불러오는 중...
						</div>
					</div>
				</div>

			</div>

		</div>

		</c:if>
	</div>
</form:form>
<div id="vk"></div>

