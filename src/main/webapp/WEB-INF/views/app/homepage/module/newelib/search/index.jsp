<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default_elib.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
var authorViewPage = 1;
var authorTotalCnt = '${countByAuthor}';
var publisherViewPage = 1;
var publisherTotalCnt = '${countByPublisher}';
var yearViewPage = 1;
var yearTotalCnt = '${countByDevice}';
var deviceViewPage = 1;
var deviceTotalCnt = '${countByDevice}';

$(function() {
	$('#do-search').on('click', function(e) {
		if ($('input#search_text2').val() == '') {
			alert('검색어를 입력해주세요');
			$('input#search_text2').focus();
			return false;
		}
		$('#book').submit();
		//doGetLoad('search.do', serializeCustom($('#book')));
	});
	
	//정렬, N개씩보기
	$('a#sort-btn').on('click', function() {
		$('button#do-search').click();
	});

	addOnClickListeners();

	<%-- 저자 더 보기 --%>
	$('a.moreAuthor').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table/author.do',
			data:'search_text=${tag:escapeJS(book.search_text)}' + '&rowCount=5&viewPage=' + (authorViewPage+1),
			type:'get',
			success:function(html) {
				$('a.moreAuthor').parent('p').prev('ul').append(html);
				authorViewPage++;
				if ((authorViewPage*5) > authorTotalCnt) {
					$('a.moreAuthor').hide();
				}
				addOnClickListeners();
			}
		});
	});

	<%-- 출판사 더 보기 --%>
	$('a.morePublisher').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table/publisher.do',
			data:'search_text=${tag:escapeJS(book.search_text)}' + '&rowCount=5&viewPage=' + (publisherViewPage+1),
			type:'get',
			success:function(html) {
				$('a.morePublisher').parent('p').prev('ul').append(html);
				publisherViewPage++;
				if ((publisherViewPage*5) > publisherTotalCnt) {
					$('a.morePublisher').hide();
				}
				addOnClickListeners();
			}
		});
	});

	<%-- 연도 더 보기 --%>
	$('a.moreYear').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table/year.do',
			data:'search_text=${tag:escapeJS(book.search_text)}' + '&rowCount=5&viewPage=' + (yearViewPage+1),
			type:'get',
			success:function(html) {
				$('a.moreYear').parent('p').prev('ul').append(html);
				yearViewPage++;
				if ((yearViewPage*5) > yearTotalCnt) {
					$('a.moreYear').hide();
				}
				addOnClickListeners();
			}
		});
	});

	<%-- 기기 더 보기 --%>
	$('a.moreDevice').on('click', function(e) {
		e.preventDefault();
		$.ajax({
			url:'table/device.do',
			data:'search_text=${tag:escapeJS(book.search_text)}' + '&rowCount=5&viewPage=' + (yearViewPage+1),
			type:'get',
			success:function(html) {
				$('a.moreDevice').parent('p').prev('ul').append(html);
				deviceViewPage++;
				if ((deviceViewPage*5) > deviceTotalCnt) {
					$('a.moreDevice').hide();
				}
				addOnClickListeners();
			}
		});
	});

	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('search_text','vk');
	});

	$('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox').prop('checked', $(this).prop('checked'));
	});

	$('#checkAllBook').change(function(e) {
		$('input.checkBook').prop('checked', $(this).prop('checked'));
	});

	$('li.li-group a.bi').on('click', function() {
		$(this).parent('li').toggleClass('active');
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

	$('select#rowCount').on('change', function() {
		$('#do-search').click();
	});

	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		$('#detail_book_idx').val($(this).data('book_idx'))
		$('#detail_type').val($(this).data('type'))
		$('form#detailForm').submit();
	});

	if ($('input#viewPage').val() != '1') {
		jQuery.ajaxSettings.traditional = true;
		var param = serializeObject($('#book'));
		var param2 = serializeObject($('#searchTableForm'));
		loadIndex('table');
	}
});

function loadIndex() {
	jQuery.ajaxSettings.traditional = true;
	$('input#viewPage').val('1');
	var param = serializeObject($('#book'));
	var param2 = serializeObject($('#searchTableForm'));
	$('div#search-results').load('table.do', $.extend(true, param, param2));
	$('body').scrollTop(0);
}

function addOnClickListeners() {
	$('a.doSearchType').on('click', function(e) {
		$('#viewPage').val(1);
		$('#type').val($(this).data('type'));
		$('#author_name').val('');
		$('#book_pubname').val('');
		$('#book_year').val('');
		$('#device').val('');
		loadIndex();
		e.preventDefault();
	});

	$('a.doSearchWriter').on('click', function(e) {
		$('#viewPage').val(1);
		$('#type').val('');
		$('#author_name').val($(this).data('author_name'));
		$('#book_pubname').val('');
		$('#book_year').val('');
		$('#device').val('');
		loadIndex();
		e.preventDefault();
	});

	$('a.doSearchPublisher').on('click', function(e) {
		$('#viewPage').val(1);
		$('#type').val('');
		$('#author_name').val('');
		$('#book_pubname').val($(this).data('book_pubname'));
		$('#book_year').val('');
		$('#device').val('');
		loadIndex();
		e.preventDefault();
	});

	$('a.doSearchYear').on('click', function(e) {
		$('#viewPage').val(1);
		$('#type').val('');
		$('#author_name').val('');
		$('#book_pubname').val('');
		$('#book_year').val($(this).data('book_year'));
		$('#device').val('');
		loadIndex();
		e.preventDefault();
	});

	$('a.doSearchDevice').on('click', function(e) {
		$('#viewPage').val(1);
		$('#type').val('');
		$('#author_name').val('');
		$('#book_pubname').val('');
		$('#book_year').val('');
		$('#device').val($(this).data('device'));
		loadIndex();
		e.preventDefault();
	});
}
</script>
<form:form modelAttribute="book" id="detailForm" action="../book/view.do" method="GET">
<form:hidden path="menu_idx" id="detail_menu_idx" value="${param.menu_idx}"/>
<form:hidden path="book_idx" id="detail_book_idx"/>
<form:hidden path="viewPage" id="detail_viewPage" value="${param.viewPage}"/>
<form:hidden path="search_text" id="detail_search_text" value="${param.search_text}"/>
<form:hidden path="search_type" id="detail_search_type" value="${param.search_type}"/>
<form:hidden path="type" id="detail_type" value="${param.type}"/>
<form:hidden path="author_name" id="detail_author_name" value="${param.author_name}"/>
<form:hidden path="book_pubname" id="detail_book_pubname" value="${param.book_pubname}"/>
<form:hidden path="book_year" id="detail_book_year" value="${param.book_year}"/>
<form:hidden path="rowCount" id="detail_rowCount" value="${param.rowCount}"/>
<input type="hidden" name="from_search" value="Y">
</form:form>

<form:form modelAttribute="book" action="index.do" method="GET">
	<form:hidden path="menu_idx"/>
	<form:hidden path="type"/>
	<form:hidden path="search_type"/>
	<form:hidden path="author_name"/>
	<form:hidden path="book_pubname"/>
	<form:hidden path="book_year"/>
	<form:hidden path="device"/>
	<form:hidden path="viewPage"/>
	<div class="search-wrap">
		<div class="search-form">
			<div class="box">
				<div class="b1">
					<form:input path="search_text" id="search_text2" type="text" class="text" placeholder="검색어를 입력하세요." onfocus="PopupVirtualKeyboard.attachInput(this)" cssStyle="ime-mode:active;"/>
				</div>
				<div class="b2">
					<button id="do-search"><i class="fa fa-search"></i><span class="blind">검색</span></button>
				</div>
			</div>
			<br/>
			<div id="autoFill">
			</div>
			<!-- <p style="height:auto">
			  <a id="vk-popup" class="btn" style="line-height:140%">
			    <i class="fa fa-keyboard-o" style="font-size:19px;color:#777"></i><span>외국어입력기</span>
			  </a>
			</p> -->
		</div>
		<br/>
		<div class="search-info" >
			<br/>
			검색결과 '<b class="og"><i id="book_search_text">${book.search_text}</i></b>'에 대한 <b id="book_viewPage">${book.viewPage}</b>/<span id="book_totalPageCount">${book.totalPageCount}</span>페이지, 총 <b id="book_totalDataCount">${book.totalDataCount}</b>건
		</div>
		<c:if test="${book.search_text ne null and book.search_text ne ''}">
		<c:if test="${bookListCnt < 1}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>
		<div class="smain">
			<div class="box">
				<div class="ws-toolbar">
<%--
					<div class="checkbox">
						<input type="hidden" name="" value="on"/>
						<input id="checkAllBook" name="" type="checkbox" value="Y"/>
						<label for="checkAllBook">전체</label>
					</div>
--%>
					<div class="control">
 						<!-- <a href="#" id="addMyLib" class="btn"><span>내보관함</span><i class="fa fa-plus"></i></a> -->
 						<form:select path="sortField" cssClass="selectmenu">
 							<form:option value="sort_title">제목</form:option>
 							<form:option value="sort_author">저자</form:option>
 							<form:option value="sort_publisher">발행처</form:option>
 						</form:select>
						<form:select path="sortType" cssClass="selectmenu">
							<form:option value="asc">오름차순</form:option>
							<form:option value="desc">내림차순</form:option>
						</form:select>
						<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:70px;">
							<form:option value="10" label="10건"></form:option>
							<form:option value="20" label="20건"></form:option>
							<form:option value="30" label="30건"></form:option>
							<form:option value="40" label="40건"></form:option>
							<form:option value="50" label="50건"></form:option>
						</form:select>
						<a href="#submit" id="sort-btn" class="btn">확인</a>
					</div>
				</div>
				<div id="search-results" class="search-results">
					<c:forEach items="${bookList}" var="i">
						<div class="row">
							<div class="thumb">
								<c:choose>
									<c:when test="${i.book_image eq ''}">
										<a href="#" data-book_idx="${i.book_idx}" data-type="${i.type}" class="goDetail noImg">
											<img src="/resources/common/img/noImg.gif" alt="noImage"/>
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
								</div>
							</div>
						</div>
					</c:forEach>
					<jsp:include page="/WEB-INF/views/app/cms/common/paging_search2.jsp" flush="false">
						<jsp:param name="formId" value="#book"/>
						<jsp:param name="pagingUrl" value="index.do"/>
					</jsp:include>
				</div>
			</div>
		</div>
		</c:if>
	</div>
</form:form>
<div id="vk"></div>
<form id="printForm" name="printForm" hidden="hidden">
	<input id="print_cmd_page" name="print_cmd_page" type="hidden" value="INDEX">
</form>
