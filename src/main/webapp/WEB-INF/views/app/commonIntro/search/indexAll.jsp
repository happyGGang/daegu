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

	jQuery.ajaxSettings.traditional = true;

	$('div#cms_paging a').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', parseInt($(this).attr('keyValue')));
		doGetLoad('indexAll.do', $('form#librarySearch').serialize());
	});

	//검색하기
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('indexAll.do', $form.serialize());
	});

	//정렬, N개씩보기 : 접근성에 안맞아서 주석처리
	/*
	$('select#rowCount, select#sortType, select#sortField').on('change', function() {
		$('a#search-btn').click();
	});
	*/

	//정렬, N개씩보기
	$('a#sort-btn').on('click', function() {
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
		PopupVirtualKeyboard.toggle('title','vk');
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
// 	$('div#hotTrend').load('hotTrend.do');

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

	$('input#title').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#author').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#publer').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#keyword').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#search_start_date').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	$('input#search_end_date').on('keyup', function(e) {
		if (e.keyCode == 13 && $(this).val() != '') {
			$('a#search-btn').click();
		}
	});

	//검색초기화
	$('a#reset-btn').on('click', function(e) {
		e.preventDefault();
		location.href='/intro/${homepage.context_path}/search/indexAll.do';
		$('#title').focus();
	});

	<%--패싯검색--%>
	$('a.facetSearch').on('click', function(e) {
		e.preventDefault();
		var key = $(this).data('key');
		var code = $(this).data('code');
		if (key == 'LIB_GROUP') {
			$('input#facet_manage_code').val(code);
		} else if (key == 'AUTHOR_GROUP') {
			$('input#facet_author').val(code);
		} else if (key == 'PULISHER_GROUP') {
			$('input#facet_publisher').val(code);
		} else if (key == 'PUB_YEAR_GROUP') {
			$('input#facet_pub_year').val(code);
		} else if (key == 'SUBJECT_CODE') {
			$('input#facet_subject_code').val(code);
		} else if (key == 'MEDIA_GROUP') {
			$('input#facet_media_code').val(code);
		}
		$('a#search-btn').click();
	});

	//
	$('a#search_type').on('click', function(e) {
		e.preventDefault();
		var toggleState = $('.detail-search-form').is(':hidden');
		if (toggleState)
		{
			$('.detail-search-form').slideToggle();
		} else {
			$('.detail-search-form').slideToggle();
		}
	});

	//
	$('a#btn_search_target').on('click', function(e) {
		e.preventDefault();
		var toggleState = $('#libraryList').is(':hidden');
		if (toggleState)
		{
			$('#libraryList').slideToggle();
		} else {
			$('#libraryList').slideToggle();
		}
	});

	//
	$('a.gu-click').on('click', function(e) {
		e.preventDefault();
		bci = $(this).next('div');

		var state = $(bci).is(':hidden');
		if (state)
		{
			$(bci).show();
		} else {
			$(bci).hide();
		}
	});

	$('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox, div#mapWrap input:checkbox').prop('checked', $(this).prop('checked'));
	});

	$('.libSel-close-btn').on('click', function(e) {
		e.preventDefault();
		$(this).parents('.library-box-inmap').hide();
	});

	$('input.libCheck').on('click', function() {
		$('input.lib_'+$(this).val()).prop('checked', $(this).prop('checked'));
	});

	<c:if test="${librarySearch.totalDataCount > 0}">
	location.href = '#subSearchText';
	</c:if>

	<c:if test="${librarySearch.totalDataCount > 0}">
	$("#libraryList").hide();
	</c:if>

	$('a.facetSearch').on('click', function(e) {
		e.preventDefault();
		$('input[name=libraryCodes]').prop('checked', false);
		$('input[name=libraryCodes][value='+$(this).data('code')+']').prop('checked', true);
		$('input#viewPage').val('1');
		doGetLoad('indexAll.do', $('form#librarySearch').serialize());
	});
});

</script>

<!-- contents-title-->
<div id="contents-title"></div>
<!-- /contents-title-->

<form:form modelAttribute="librarySearch" action="indexAll.do" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>

<div class="search-wrap">

		<div class="search-form">

			<!-- 검색하기_일반 -->
			<div class="searchbox detail_search">
				<div class="section">

					<div class="title-box">
						<form:input path="title" class="text-area" placeholder="도서 제목을 입력하세요"/><a id="vk-popup" class="btnNew2 foreign-inp">다국어입력기</a>
					</div>

					<div class="main-menu">
						<div class="right">
							<ul>
								<li><a href="javascript:void(0);" class="onclick" id="search_type" class="btnNew2">상세검색</a></li>
							</ul>
						</div>
						<div class="clear"></div>
					</div>

					<div class="hide detail-search-form">
						<dl>
							<dt><label for="author" class="title">저자</label></dt>
							<dd><form:input path="author" class="text-area"/></dd>
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
							<dt><label for="search_start_date" class="title">발행년도</label></dt>
							<dd>
								<div class="box">
									<form:input path="search_start_date" class="text-area2" title="시작년도" numberOnly="true" maxlength="4" />
									<span style="width:8%;text-align:center;">~</span>
									<form:input path="search_end_date" class="text-area2" title="마지막년도" numberOnly="true" maxlength="4" />
								</div>
							</dd>
						</dl>

						<dl>
							<dt><label for="subjectCode" class="title">주제</label></dt>
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
							<dt><label for="booktype" class="title">자료형태</label></dt>
							<dd>
								<div class="" style="padding:3px 0 0 10px">
								<form:radiobutton path="booktype" value="BOOKANDNONBOOK" class="radiocheck" checked="checked"/><label for="booktype1" class="booktype">통합</label>
								<form:radiobutton path="booktype" value="BOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype2" class="booktype">도서</label>
								<form:radiobutton path="booktype" value="NONBOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype3" class="booktype">비도서</label>
								</div>
							</dd>
						</dl>
					</div>

					<div class="end"></div>
				</div>

				<div class="btn_w">
					<a id="search-btn" class="btnNew">검색하기</a>
					<a id="reset-btn" class="btnNew1">검색초기화</a>
					<a href="javascript:void(0);" id="btn_search_target" class="btnNew5">도서관선택</a>
				</div>


				<div id="libraryList" class="libraryList">
					<div>
						<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
					</div>
					<div>
						<ul>
							<c:forEach items="${homepageList}" var="i" varStatus="status">
							<c:if test="${i.homepage_id ne 'h30' and i.homepage_id ne 'h31' and i.homepage_id ne 'h32' and i.homepage_id ne 'h33' and i.homepage_id ne 'h34'}">
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_${i.manage_code}" value="${i.manage_code}" label="${i.homepage_name}" />
							</li>
							</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="end"></div>
				</div>

			</div>
			<!--// 검색하기_일반 -->
		</div>


		<br/>

		<c:if test="${librarySearch.totalDataCount eq 0}">
		<!-- 검색결과 0 이상일때 사라지면됨 -->

		<div class="before">
			<!--
			<div id="mapWrap">
				<div>
					<ul>
						<li style="left:445px; top:138px;" title="">
							<a href="#" class='gu-click'>동구</a>
							<div class="hide library-box-inmap">
								<div class="title">동구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AH" value="AH" label="동부도서관" /></span>
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AA" value="AA" label="대구2·28기념학생도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:325px; top:140px;" title="">
							<a href="#" class='gu-click'>북구</a>
							<div class="hide library-box-inmap">
								<div class="title">북구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AC" value="AC" label="북부도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:420px; top:285px;" title="">
							<a href="#" class='gu-click'>수성구</a>
							<div class="hide library-box-inmap">
								<div class="title">수성구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AE" value="AE" label="수성도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:335px; top:285px;" title="">
							<a href="#" class='gu-click'>남구</a>
							<div class="hide library-box-inmap">
								<div class="title">남구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AG" value="AG" label="남부도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:345px; top:240px;" title="">
							<a href="#" class='gu-click'>중구</a>
							<div class="hide library-box-inmap">
								<div class="title">중구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AD" value="AD" label="중앙도서관" /></span>
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AL" value="AL" label="2·28민주운동기념회관도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:290px; top:230px;" title="">
							<a href="#" class='gu-click'>서구</a>
							<div class="hide library-box-inmap">
								<div class="title">서구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AF" value="AF" label="서부도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:245px; top:290px;" title="">
							<a href="#" class='gu-click'>달서구</a>
							<div class="hide library-box-inmap">
								<div class="title">달서구 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AB" value="AB" label="두류도서관" /></span>
								</div>
							</div>
						</li>
						<li style="left:230px; top:430px;" title="">
							<a href="#" class='gu-click'>달성군</a>
							<div class="hide library-box-inmap">
								<div class="title">달성군 <a href="#" class="libSel-close-btn">X</a></div>
								<div class="libSel">
									<span class=""><form:checkbox path="libraryCodes" class="libCheck lib_AJ" value="AJ" label="달성도서관" /></span>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
			-->
			<div class="info-boxes" style="display:none;">
				<div class="section3">
					<div class="info-box-title">
						구군립도서관 검색을 위해서는 아래 안내에 따라 이용을 부탁드립니다.
					</div>
				</div>
				<div class="section4">
					<div class="etc-db">
						<span class="tt2">대구광역시 <br class="web-br"/>구군립도서관</span> <span class="tc2">아래는 구군립 도서관 목록입니다. 구군립 도서관 자료검색을 원하시면 <a href="#" target="_blank">'여기'</a>를 눌러 주세요<br/><p>안심도서관,신천도서관,서구어린이도서관,비산도서관,서구영어도서관,비원도서관,원고개도서관,대명어울림도서관,이천어울림도서관,구수산도서관,대현도서관,태전도서관,범어도서관,용학도서관,고산도서관,책숲길도서관,물망이도서관,파동도서관,무학도서관,도원도서관,달서어린이,성서도서관,본리도서관,달서가족문화도서관,달서영어도서관,달성군립도서관</p></span>
					</div>
				</div>
			</div>

		</div>
		<!-- 검색결과 0 이상일때 사라지면 됨 -->
		</c:if>

		<c:if test="${not empty paging and librarySearch.totalDataCount eq 0}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>

		<c:if test="${librarySearch.totalDataCount > 0}">

		<!--search_result-->
		<div id="search_result" class="search_result">
			<div class="result-count-library">
				<ul><!-- 검색결과 가운데 도서관별 결과갯수 패싯을 표현하는 부분 -->
					<c:forEach items="${facetGroup}" var="i" varStatus="status">
						<c:if test="${i.key eq 'LIB_GROUP'}">
							<c:forEach items="${i.value}" var="j" varStatus="statusj">
								<li>
									<a href="#" class="facetSearch" data-key="${i.key}" data-code="${j.CODE}">
										<c:set var="facetValue" value="${not empty j.NAME ? j.NAME : j.CODE}"></c:set>
										${facetValue}<span>(${j.COUNT})</span>
									</a>
								</li>
							</c:forEach>
						</c:if>
					</c:forEach>
				</ul>
			</div>


			<div class="search-info" >
				※ 검색결과 총 <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건이 검색되었습니다.
			</div>

			<div class="research-box">
				<select id="subSearchType" class="text-area01">
					<option value="title">서명</option>
					<option value="author">저자</option>
					<option value="publer">발행처</option>
					<option value="keyword">키워드</option>
				</select>
				<input id="subSearchText" placeholder="결과 내 재검색" class="text-area01" />
				<a href="#" id="subSearch" class="btn">결과 내 재검색</a>
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
							<form:select path="sortField" cssClass="text-area01">
								<form:option value="NONE">정렬없음</form:option>
								<form:option value="TITLE">제목</form:option>
								<form:option value="AUTHOR">저자</form:option>
								<form:option value="PUBLISHER">발행처</form:option>
								<form:option value="PUB_YEAR">발행년도</form:option>
							</form:select>
							<form:select path="sortType" cssClass="text-area01">
								<form:option value="ASC">오름차순</form:option>
								<form:option value="DESC">내림차순</form:option>
							</form:select>
							<form:select path="rowCount" cssClass="text-area01">
								<form:option value="10" label="10건"></form:option>
								<form:option value="20" label="20건"></form:option>
								<form:option value="30" label="30건"></form:option>
								<form:option value="40" label="40건"></form:option>
								<form:option value="50" label="50건"></form:option>
								<form:option value="100" label="100건"></form:option>
							</form:select>
							<a href="#sort" id="sort-btn" class="btn">정렬</a>
						</div>
					</div>

					<div id="search-results" class="search-results">
						<div class="imageType">
							<c:forEach items="${bookSearch}" var="i">
							<!-- 검색결과 루프 시작 -->
							<c:set var="detailURL" value="detail.do?&menu_idx=7&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}"></c:set>
							<div class="row">
								<p class="admin">
									<input name="print_param" type="checkbox" class="checkBook" value="${fn:escapeXml(i.ST_CODE)}_${fn:escapeXml(i.MANAGE_CODE)}"/>
								</p>
								<div class="thumb">
									<c:choose>
										<c:when test="${empty i.aladin or empty i.aladin.cover}">
											<a href="${detailURL}" class="noImg">
												<img src="/resources/common/img/noImg2.png" alt="${i.TITLE_INFO}"/>
												<span>등록된 이미지가<br/>없습니다.</span>
											</a>
										</c:when>
										<c:otherwise>
											<a href="${detailURL}">
												<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}"/>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="box">
									<div class="item">
										<div class="bif">

											<a href="${detailURL}">
											<c:if test="${i.MEDIA_CODE eq 'PR'}">[도서]</c:if>
											<c:if test="${i.MEDIA_CODE ne 'PR'}">[비도서]</c:if>
											<c:if test="${librarySearch.booktype eq 'SERIAL'}">[간행물]</c:if>
											<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span>
											</a>

											<p><font style="color:#5e5e5e;">저자</font> : ${i.AUTHOR}</p>
											<p><font style="color:#5e5e5e">발행처</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}</p>
											<p><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span> / <font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span></p>
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
																<span style="color:#ff0000">대출불가(관외대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																<span style="color:#ff0000">대출불가(관내대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																<span style="color:#ff0000">대출불가(타관반납중)(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																<span style="color:#ff0000">대출불가(타관대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:when>
															<c:otherwise>
																<span style="color:#ff0000">대출불가(예약 : ${i.RESERVATION_CNT}명)</span>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
											</p>
											<!--
											JU : 아동, MS : 중학생, AD : 성인, PU : 일반, ES : 초등, HS : 고등, SP : 특수, 기타 :
											-->
											<c:if test="${not empty i.APPENDIX_INFO}">
											<p><font style="color:#5e5e5e">부록여부</font> : ${i.APPENDIX_INFO[0].DESCRIPTION} (${i.APPENDIX_INFO[0].APPENDIX_CNT}개)</p>
											</c:if>
											<p>
											<font style="color:#5e5e5e">이용대상</font> :
														<c:choose>
															<c:when test="${i.USE_OBJECT_CODE eq 'JU'}">
																<span style="">아동</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'MS'}">
																<span style="">중학생</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'AD'}">
																<span style="">성인</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'PU'}">
																<span style="">일반</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'ES'}">
																<span style="">초등</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'HS'}">
																<span style="">고등</span>
															</c:when>
															<c:when test="${i.USE_OBJECT_CODE eq 'SP'}">
																<span style="">특수</span>
															</c:when>
															<c:otherwise>
																<span style="">기타</span>
															</c:otherwise>
														</c:choose>
											</p>
											<p><font style="color:#5e5e5e">매체구분</font> : <span style="">${i.MEDIA_NAME}</span></p>
											<!-- <p><font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span></p> -->
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
																<span style="color:#ff0000">대출불가(관외대출중)</span><br/>(예약 : ${i.RESERVATION_CNT}명)
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																<span style="color:#ff0000">대출불가(관내대출중)</span><br/>(예약 : ${i.RESERVATION_CNT}명)
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																<span style="color:#ff0000">대출불가(타관반납중)</span><br/>(예약 : ${i.RESERVATION_CNT}명)
															</c:when>
															<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																<span style="color:#ff0000">대출불가(타관대출중)</span><br/>(예약 : ${i.RESERVATION_CNT}명)
															</c:when>
															<c:otherwise>
																<span style="color:#ff0000">대출불가</span><br/>(예약 : ${i.RESERVATION_CNT}명)
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
							<div id="cms_paging" class="dataTables_paginate">
								<c:if test="${paging.firstPageNum > 0}">
									<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
								</c:if>
								<c:if test="${paging.prevPageNum > 0}">
									<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
								</c:if>
									<span>
								<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
								<c:choose>
								<c:when test="${i eq paging.viewPage}">
									<a id="${i}" href="" class="paginate_button current" keyValue="${i}">${i}</a>
								</c:when>
								<c:otherwise>
									<a id="${i}" href="" class="paginate_button" keyValue="${i}">${i}</a>
								</c:otherwise>
								</c:choose>
								</c:forEach>
								<c:if test="${paging.nextPageNum > 0}">
									<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
								</c:if>
								<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
									<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
								</c:if>
								</span>
							</div>
						</div>
					</div>
					<div style="padding-top:30px ;text-align:right">
						<a href="https://www.aladin.co.kr/home/welcome.aspx" target="_blank" style="color:#000">도서 DB 이미지 제공 : 알라딘 인터넷서점(www.aladin.co.kr)</a> <img src="/resources/common/img/aladin_01.png" alt="alandin" align="absmiddle"/>
					</div>
				</div>

				<div class="filter-section" style="display: none;">
					<div class="ws-filter" id="hotTrend" style="height:370px;">
						<h4>실시간 검색어 순위</h4>
						<div style="text-align: center;" >
							불러오는 중...
						</div>
					</div>
				</div>
			</div>

			<div class="rightCon" style="display: none;">
					<div class="limitSrch">
						<strong>제한검색</strong>
						<ul class="depth1">
							<c:forEach items="${facetGroup}" var="i" varStatus="status">
								<c:set var="facetName" value=""></c:set>
								<c:if test="${i.key eq 'AUTHOR_GROUP'}">
									<c:set var="facetName" value="저자별"></c:set>
								</c:if>
								<c:if test="${i.key eq 'PUB_YEAR_GROUP'}">
									<c:set var="facetName" value="년도별"></c:set>
								</c:if>
								<c:if test="${i.key eq 'SUBJECT_CODE'}">
									<c:set var="facetName" value="주제별"></c:set>
								</c:if>
								<c:if test="${i.key eq 'PULISHER_GROUP'}">
									<c:set var="facetName" value="출판사별"></c:set>
								</c:if>
								<c:if test="${i.key eq 'LIB_GROUP'}">
									<c:set var="facetName" value="도서관별"></c:set>
								</c:if>
								<c:if test="${i.key eq 'MEDIA_GROUP'}">
									<c:set var="facetName" value="매체별"></c:set>
								</c:if>
								<c:if test="${fn:length(i.value) > 0}">
							<li class="active" id="${i.key}"><a href="#;">${facetName}</a>
								<ul class="depth2">
									<c:forEach items="${i.value}" var="j" varStatus="statusj" begin="0" end="4" step="1">
										<li>
											<a href="#" class="facetSearch" data-key="${i.key}" data-code="${j.CODE}">
												<c:set var="facetValue" value="${not empty j.NAME ? j.NAME : j.CODE}"></c:set>
												${facetValue}<span>(${j.COUNT})</span>
											</a>
										</li>
									</c:forEach>
								</ul>
							</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
			</div>

		</div>

		</c:if>

	</div>

</form:form>



<div id="vk"></div>