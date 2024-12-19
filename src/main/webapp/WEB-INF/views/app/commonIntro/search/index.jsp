<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String todays = sf.format(now);
%>
<c:set var="now" value="<%=todays %>" />
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>
<script type="text/javascript">
$(function() {

	var $form = $('form#librarySearch');

	// 상호대차 신청
	$('a.sangho').on('click', function (e) {
		console.log($(this).attr('isbn'));
		e.preventDefault();
		$('form#sanghoReqForm input[name=isbn]').val($(this).attr('isbn'));
		$('form#sanghoReqForm input[name=manageCode]').val($(this).attr('manageCode'));
		$('form#sanghoReqForm input[name=regNo]').val($(this).attr('regNo'));
		$('form#sanghoReqForm').submit();
	});

	//예약신청
	$('a.resve-req').on('click', function (e) {
		e.preventDefault();
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}
		$('#resveReqForm #editMode').val('ADD');
		$('#resveReqForm #bookkey').val($(this).attr('bookkey'));
		$('#resveReqForm #booktype').val($(this).attr('booktype'));
		$('#resveReqForm #manageCode').val($(this).attr('managecode'));

		if (doAjaxPost($('#resveReqForm'))) {
			window.location.reload();
		}
	});

	//무인예약대출(비대면)
	$('a.untactBook-req').on('click', function(e) {
		e.preventDefault();
		$('form#untactBookReqForm input[name=isbn]').val($(this).attr('isbn'));
		$('form#untactBookReqForm input[name=manageCode]').val($(this).attr('manageCode'));
		$('form#untactBookReqForm input[name=regNo]').val($(this).attr('regNo'));
		$('form#untactBookReqForm input[name=bookkey]').val($(this).attr('bookkey'));
		$('form#untactBookReqForm').submit();
	});

	//무인대출예약 신청(지하철)
	$('a#unmanned-req').on('click', function(e) {
		e.preventDefault();
		$('form#unmannedReqForm input[name=bookkey]').val($(this).attr('bookkey'));
		$('form#unmannedReqForm input[name=isbn]').val($(this).attr('isbn'));
		$('form#unmannedReqForm input[name=manageCode]').val($(this).attr('manageCode'));
		$('form#unmannedReqForm input[name=regNo]').val($(this).attr('regNo'));
		$('form#unmannedReqForm').submit();
	});

	$('a#service-noreq').on('click', function(e) {
		e.preventDefault();
		alert('비대면인증 회원은 서비스 이용이 불가능 하며 전자도서관만 이용가능 합니다.');
		return;
	});

	//내집앞도서관
	$('a.neighborhoodLibrary-req').on('click',function(e){
		e.preventDefault();
		$('form#neighborhoodLibrary input[name=book_key]').val($(this).attr('bookkey'));
		$('form#neighborhoodLibrary input[name=booktype]').val($(this).attr('booktype'));
		$('form#neighborhoodLibrary input[name=book_isbn]').val($(this).attr('isbn'));
		$('form#neighborhoodLibrary input[name=manage_code]').val($(this).attr('manageCode'));
		$('form#neighborhoodLibrary input[name=reg_no]').val($(this).attr('regNo'));
		$('form#neighborhoodLibrary input[name=title_info]').val($(this).attr('title_info'));
		$('form#neighborhoodLibrary input[name=lib_name]').val($(this).attr('lib_name'));
		$('form#neighborhoodLibrary input[name=call_no]').val($(this).attr('call_no'));
		$('form#neighborhoodLibrary input[name=author]').val($(this).attr('author'));
		$('form#neighborhoodLibrary input[name=shelf_loc_name]').val($(this).attr('shelf_loc_name'));
		$('form#neighborhoodLibrary').submit();
	});

	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		$('input#reSearchTitle').val('');
		$('input#reSearchAuthor').val('');
		$('input#reSearchPubler').val('');
		$('input#reSearchKeyword').val('');
		doGetLoad('index.do', $form.serialize());
	});
	
	$('a.subject-submit').on('click', function(e) {
		e.preventDefault();
		var scode = $(this).attr('href');
		$('input#subjectCode').val(scode.replace('#',''));
		$('input#viewPage').val('1');
		doGetLoad('index.do', $form.serialize());
	});
	
	$('a.separate-shelf-code-submit').on('click', function(e) {
		e.preventDefault();
		var scode = $(this).attr('href');
		$('input#separateShelfCode').val(scode.replace('#',''));
		$('input#viewPage').val('1');
		doGetLoad('index.do', $form.serialize());
	});

	//정렬, N개씩보기 : 접근성에 안맞아서 주석처리
	/*
	$('select#rowCount, select#sortType, select#sortField').on('change', function() {
		$('a#search-btn').click();
	});
	*/

	//정렬, N개씩보기
	$('a#sort-btn').on('click', function() {
		doGetLoad('index.do', $form.serialize());
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
		$('.admin > input.checkBook').prop('checked', $(this).prop('checked'));
	});

	//전체 선택
	$('#checkAll').change(function(e) {
		$('div#libraryList input:checkbox').prop('checked', $(this).prop('checked'));
	});

	if ('${fn:escapeXml(homepage.context_path)}' == 'junggu') {
		if('${librarySearch.title}' == ''){
			$('#checkAll').click();
		}
	}

	$('a#addMyLib').on('click', function(e) {
		e.preventDefault();
		var len = $('input.checkBook:checked').length;
		if (len < 1) {
			alert('선택된 도서가 없습니다.');
			return false;
		}

		var checkList = $('#librarySearch input[name="print_param"]:checked').clone();

		$(checkList).each(function() {
			$(this).val($(this).val().replace(/,/gi,';;;;;'));
		});

		$('#storageReqBatchForm').append(checkList);
		$('#storageReqBatchForm input[type=checkbox]').attr('name', 'strList');
		window.open("", "myStoragePopup", "width=400, height=400");
		$('#storageReqBatchForm').submit();
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
		
		if(beforeText == '' || beforeText == null){
			var newText = $('input#subSearchText').val();
		} else {
			var newText = (beforeText == '') ? $('input#subSearchText').val() : $('input#'+type).val()+ ' ' +$('input#subSearchText').val();
		}
		
// 		$('input#'+type).val(newText);
		
		if(type == 'title') {
			$('input#reSearchTitle').val(newText);
		} else if(type == 'author') {
			$('input#reSearchAuthor').val(newText);
		} else if(type == 'publer') {
			$('input#reSearchPubler').val(newText);
		} else if(type == 'keyword') {
			$('input#reSearchKeyword').val(newText);
		}
		
// 		$('a#search-btn').click();
		doGetLoad('index.do', $form.serialize());
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

	$('input#isbn').on('keyup', function(e) {
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
		location.href='/${homepage.context_path}/intro/search/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
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

	location.href = '#search_result';

	$('a#addStorage').on('click', function(e) {
		e.preventDefault();
		var len = $('input.checkBook:checked').length;
		if (len < 1) {
			alert('선택된 도서가 없습니다.');
			return false;
		}
		var checkList = $('#librarySearch input[name="print_param"]:checked').clone();
		(checkList).each(function() {
			$(this).val($(this).val().replace(/,/gi,';;;;;'));
		});
		$('#storageReqForm').append(checkList);
		$('#storageReqForm input[type=checkbox]').attr('name', 'strList');
		window.open("", "myStoragePopup", "width=400, height=400");
		$('form#storageReqForm').submit();
		checkList.remove();

		//내 보관함 이동.
	});

	$('input[name=booktype]').on('click', function() {
		if ($(this).val() == 'NONBOOK') {
			$('dl#nonBookMedia').show();
			$('input#title').attr('placeholder', '비도서 제목을 입력하세요');
		} else {
			$('dl#nonBookMedia').hide();
			$('select#media_code').val('');
			$('input#title').attr('placeholder', '도서 제목을 입력하세요');
		}
	});

	if ('${fn:escapeXml(param.booktype)}' == 'NONBOOK') {
		$('input#title').attr('placeholder', '비도서 제목을 입력하세요');
	}


	<c:if test="${empty librarySearch.title and empty librarySearch.libraryCodes}">
	//$('#checkAll').click();context_path eq 'kids' || context_path eq 'seongseo' || context_path eq 'bolli' || context_path eq 'family' 
		<c:choose>
			<c:when test="${homepage.context_path eq 'donggu'}">
			$('div#libraryList input:checkbox').prop('checked',false);
			$('div#libraryList input:checkbox.lib_CA').prop('checked',true);
			$('div#libraryList input:checkbox.lib_CB').prop('checked',true);
			</c:when>
		</c:choose>
	</c:if>
});

function resveReq(bookkey, booktype, editMode) {
	<c:choose>
	<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'HOMEPAGE'}">
	if(confirm('예약 신청 하시겠습니까?')) {
		var ajaxData = {
				'bookkey' : bookkey,
				'booktype' : booktype,
				'editMode' : editMode
		};
		
		$.ajax({
			type: "POST",
			url: 'resve/save.do',
			data: ajaxData,
			success:  function(response) {
				if(response.valid) {
					alert(response.message);
					location.reload();
				} else {
					alert(response.message);
				}
			},error: function() {
				alert('예약 신청에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
	</c:when>
	<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'PRIVATEHOMEPAGE'}">
	if(confirm('예약 신청 하시겠습니까?')) {
		var ajaxData = {
				'bookkey' : bookkey,
				'booktype' : booktype,
				'editMode' : editMode
		};
		
		$.ajax({
			type: "POST",
			url: 'resve/save.do',
			data: ajaxData,
			success:  function(response) {
				if(response.valid) {
					alert(response.message);
					location.reload();
				} else {
					alert(response.message);
				}
			},error: function() {
				alert('예약 신청에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
	</c:when>
	<c:otherwise>
	alert('로그인 후 이용 가능합니다.');
	location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&before_url='+encodeURIComponent(location.href);
	</c:otherwise>
	</c:choose>
}

function searchIndex() {
	$('input#viewPage').val('1');
	$('input#reSearchTitle').val('');
	$('input#reSearchAuthor').val('');
	$('input#reSearchPubler').val('');
	$('input#reSearchKeyword').val('');

	<c:if test="${homepage.context_path eq 'nearbylib'}">
		if (isFromFridayToSunday()) {
			alert('지금은 내 집 앞 도서관 서비스 예약가능 시간이 아닙니다.\n\n<내 집 앞 도서관 서비스 예약가능 시간>\n\n* 월요일 09:00 ~ 토요일 08:59 \n\n더 자세한 내용은 이용안내를 참고해주시기 바랍니다.\n\n확인을 누르시면 도서검색결과 화면으로 이동합니다. ');
		}
	</c:if>
	
	doGetLoad('index.do', $('form#librarySearch').serialize());
}

function isFromFridayToSunday() {
	var now = new Date();
	var nowDayOfWeek = now.getDay();
	var nowDay = now.getDate();
	var nowMonth = now.getMonth();
	var nowYear = now.getYear();
	nowYear += (nowYear < 2000) ? 1900 : 0;

	var weekStartDate = new Date(nowYear, nowMonth, nowDay + (6 - nowDayOfWeek), 9);
	var weekEndDate = new Date(nowYear, nowMonth, nowDay + (8 - nowDayOfWeek), 9);
	console.log(weekStartDate);
	console.log(weekEndDate);
	return weekStartDate <= now && weekEndDate > now;
}
</script>
<!-- <a href="#" onclick="isFromFridayToSunday()" style="color:#fff;">.</a> -->
<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/viewStorage.do" method="post" target="myStoragePopup" style="display: none;">
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<input type="hidden" id="editMode" name="editMode" value="ADD">
<input type="hidden" id="item_name" name="item_name" value="${detail.TITLE_INFO}">
<input type="hidden" id="author" name="author" value="${detail.AUTHOR}">
<input type="hidden" id="publer" name="publer" value="${detail.PUBLISHER}">
<input type="hidden" id="loca" name="loca" value="${detail.MANAGE_CODE}">
<input type="hidden" id="ctrl_no" name="ctrl_no" value="${detail.ST_CODE}">
<input type="hidden" id="img_url" name="img_url" value="${detail.IMAGE}">
</form>

<form id="sanghoReqForm" action="sangho/form.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="isbn" value="${fn:escapeXml(param.isbn)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form:form id="resveReqForm" modelAttribute="librarySearch" action="resve/save.do">
	<input type="hidden" id="manageCode" name="manageCode">
	<form:hidden path="editMode"/>
	<form:hidden path="bookkey"/>
	<form:hidden path="booktype"/>
	<form:hidden path="menu_idx"/>
</form:form>

<form id="untactBookReqForm" action="/${homepage.context_path}/module/untactBook/form.do" method="post">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
	<input type="hidden" name="shelf_loc_name" value="${fn:escapeXml(detail.SHELF_LOC_NAME)}">
	<input type="hidden" name="call_no" value="${fn:escapeXml(detail.CALL_NO)}"/>
</form>

<form id="unmannedReqForm" action="unmanned/form.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
	<input type="hidden" name="shelf_loc_name" value="${fn:escapeXml(detail.SHELF_LOC_NAME)}">
	<input type="hidden" name="book_name" value="${fn:escapeXml(detail.TITLE_INFO)}">
</form>

<form id="neighborhoodLibrary" action="neighborhoodLibrary/edit.do" method="post">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}"/>
	<input type="hidden" id="book_isbn" name="book_isbn" value="${param.isbn}"/>
	<input type="hidden" id="reg_no" name="reg_no" value="${detail.REG_NO}"/>
	<input type="hidden" id="shelf_loc_name" name="shelf_loc_name" value="${detail.SHELF_LOC_NAME}"/>
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${fn:escapeXml(param.regNo)}"/>
	<input type="hidden" id="return_plan_date" name="return_plan_date" value="${detail.RETURN_PLAN_DATE}"/>
	<input type="hidden" id="call_no" name="call_no" value="${fn:escapeXml(detail.CALL_NO)}"/>
	<input type="hidden" id="img_url" name="img_url" value="${fn:escapeXml(detail.imageUrl)}"/>
	<input type="hidden" id="manage_code" name="manage_code" value="${detail.MANAGE_CODE}"/>
	<input type="hidden" id="lib_name" name="lib_name" value="${detail.LIB_NAME}"/>
	<input type="hidden" id="publer" name="publer" value="${fn:escapeXml(param.booktype)}"/>
	<input type="hidden" id="publisher" name="publisher" value="${detail.PUBLISHER}"/>
	<input type="hidden" id="pub_year" name="pub_year" value="${detail.PUB_YEAR}"/>
	<input type="hidden" id="media_name" name="media_name" value="${detail.MEDIA_NAME}"/>
	<input type="hidden" id="media_code" name="media_code" value="${detail.MEDIA_CODE}"/>
	<input type="hidden" id="price" name="price" value="${detail.PRICE}"/>
	<input type="hidden" id="title_info" name="title_info" value="${detail.TITLE_INFO}"/>
	<input type="hidden" id="author" name="author" value="${detail.AUTHOR}"/>
	<input type="hidden" id="page" name="page" value="${detail.PAGE }"/>
	<input type="hidden" id="book_size" name="book_size" value="${detail.BOOK_SIZE }">
	<input type="hidden" id="book_key" name="book_key" value="${fn:escapeXml(detail.BOOK_KEY)}"/>
	<input type="hidden" id="class_no" name="class_no" value="${detail.CLASS_NO}"/>
	<input type="hidden" id="booktype" name="booktype" value="${fn:escapeXml(param.booktype)}"/>
	<input type="hidden" id="appendix_info" name="appendix_info" value="${detail.APPENDIX_INFO}"/>
</form>

<form:form modelAttribute="librarySearch" action="index.do" method="get">
	<form:hidden path="menu_idx"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="separateShelfCode"/>
	<c:if test="${homepage.context_path eq 'bukgs' and param.menu_idx eq '83'}">
	<form:hidden path="shelfCode"/>
	</c:if>
	<c:if test="${homepage.context_path eq 'dongbu'}">
		<form:hidden path="shelfCodes" value ="AH64"/>
	</c:if>
	
	<form:hidden path="facet_manage_code"/>
	<form:hidden path="facet_author"/>
	<form:hidden path="facet_publisher"/>
	<form:hidden path="facet_pub_year"/>
	<form:hidden path="facet_subject_code"/>
	<form:hidden path="facet_media_code"/>
	<form:hidden path="reSearchTitle"/>
	<form:hidden path="reSearchAuthor"/>
	<form:hidden path="reSearchPubler"/>
	<form:hidden path="reSearchKeyword"/>

	<!-- contents-title-->
	<div id="contents-title">
		<!-- <h2>어떤 도서<span style="font-weight:300">를 찾고 싶으세요?</span></h2> -->
	</div>
	<!-- /contents-title-->

	<div class="search-wrap">

		<c:choose>
			<c:when test="${homepage.context_path eq 'donggu'}">
				<c:choose>
					<c:when test="${param.menu_idx eq '11'}">
						<form:hidden path="subjectCode"/>
						<input id="booktype" name="booktype" type="hidden" value="BOOKANDNONBOOK"/>
						<a id="search-btn" class="btnNew4" style="display:none;">검색하기</a>

						<h3>일반 주제</h3>
						<div class="divSubjectMenu">
							<table cellpadding="0" cellspacing="0" border="1" class="subjectTable">
								<caption class="dpn">주제분류 리스트</caption>
								 <colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<tbody>
								<tr>
									<td><a href="#0" class="subject-submit"><span class="subject0">총류</span></a></td>
									<td><a href="#1" class="subject-submit"><span class="subject1">철학</span></a></td>
									<td><a href="#2" class="subject-submit"><span class="subject2">종교</span></a></td>
									<td><a href="#3" class="subject-submit"><span class="subject3">사회과학</span></a></td>
									<td><a href="#4" class="subject-submit"><span class="subject4">자연과학</span></a></td>
								</tr>
								<tr>
									<td><a href="#5" class="subject-submit"><span class="subject5">기술과학</span></a></td>
									<td><a href="#6" class="subject-submit"><span class="subject6">예술</span></a></td>
									<td><a href="#7" class="subject-submit"><span class="subject7">언어</span></a></td>
									<td><a href="#8" class="subject-submit"><span class="subject8">문학</span></a></td>
									<td><a href="#9" class="subject-submit"><span class="subject9">역사</span></a></td>
								</tr>
								</tbody>
							</table>
						</div>
						<br>
						<h3>특성화 주제</h3>
						<div class="divSubjectMenu">
							<table cellpadding="0" cellspacing="0" border="1" class="subjectTable">
								<caption class="dpn">특성화주제</caption>
								<tbody>
								<tr>
									<td><a href="#CFH" class="separate-shelf-code-submit"><span class="subject10">큰글자책</span></a></td>
									<td><a href="#CFK" class="separate-shelf-code-submit"><span class="subject11">치매</span></a></td>
									<td><a href="#CFM" class="separate-shelf-code-submit"><span class="subject12">향토</span></a></td>
								</tr>
								</tbody>
							</table>
						</div>
					</c:when>
					<c:otherwise>
						<div class="search-form">

							<!-- 검색하기_일반 -->
							<div class="searchbox detail_search" id="div_detail">
								<div class="section">

									<div class="title-box">
										<form:input path="title" class="text-area" placeholder="도서 제목을 입력하세요" onkeyup="if(window.event.keyCode==13){searchIndex();}"/>
									</div>
									<div class="vk-btn">

									</div>
									<div id="libraryList" class="libraryList">
										<div>
											<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
										</div>
										<div>
											<ul>
												<li>
													<form:checkbox path="libraryCodes" value="CA" class="libCheck lib_CA" label="안심도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="CB" class="libCheck lib_CB" label="신천도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GR" class="libCheck lib_GA" label="신암2동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GS" class="libCheck lib_GB" label="신암3동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="HJ" class="libCheck lib_GC" label="신암5동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="FK" class="libCheck lib_GD" label="신천3동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GT" class="libCheck lib_GE" label="효목1동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="FP" class="libCheck lib_GF" label="효목2동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="FL" class="libCheck lib_GH" label="도평동 작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GU" class="libCheck lib_FJ" label="불로어울림작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GV" class="libCheck lib_FN" label="지저동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GW" class="libCheck lib_HG" label="동촌역사작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GX" class="libCheck lib_GX" label="방촌동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="GY" class="libCheck lib_GY" label="해안동작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="FM" class="libCheck lib_FM" label="반야월역사작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="HK" class="libCheck lib_HK" label="늘푸른작은도서관"/>
												</li>
												<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
												<%-- <li>
													<form:checkbox path="libraryCodes" value="HL" class="libCheck lib_HL" label="초록우산작은도서관"/>
												</li> --%>
												<li>
													<form:checkbox path="libraryCodes" value="HM" class="libCheck lib_HM" label="꿈날자문고작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="HN" class="libCheck lib_HN" label="행복작은도서관"/>
												</li>
												<li>
													<form:checkbox path="libraryCodes" value="HP" class="libCheck lib_HP" label="율하5주민작은도서관"/>
												</li>
												<!--<li>
													<form:checkbox path="libraryCodes" value="HQ" class="libCheck lib_HQ" label="방촌어린이작은도서관"/>
												</li>-->
											</ul>
										</div>
										<div class="end"></div>
									</div>
									<div class="vk-btn">

									</div>
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
										<dt>자료형태</dt>
										<dd>
											<div class="" style="padding:10px 0 0 0;">
											<form:radiobutton path="booktype" value="BOOKANDNONBOOK" class="radiocheck" checked="checked"/><label for="booktype1" class="booktype">통합</label>
											<form:radiobutton path="booktype" value="BOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype2" class="booktype">도서</label>
											<form:radiobutton path="booktype" value="NONBOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype3" class="booktype">비도서</label>
											<%--<form:radiobutton path="booktype" value="SERIAL" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype4" class="booktype">간행물</label> --%>
											</div>
										</dd>
									</dl>
									
									<!-- 동구도서관 자료실구분 시작 -->
									<c:if test="${fn:length(shelfCodeList) > 0}">
									<dl>
										<dt><label for="keyword" class="title">자료실구분</label></dt>
										<dd>
											<form:select path="shelfCode">
												<form:option value="">전체</form:option>
												<c:forEach items="${shelfCodeList}" var="i" varStatus="status">
													<c:if test="${i.CODE eq 'CA01' or
																	i.CODE eq 'CA02' or
																	i.CODE eq 'CA03' or
																	i.CODE eq 'CA04' or
																	i.CODE eq 'CA06' or
																	i.CODE eq 'CA08' or
																	i.CODE eq 'CA10' or
																	i.CODE eq 'CA18' or
																	i.CODE eq 'CB01' or
																	i.CODE eq 'CB02' or
																	i.CODE eq 'CB03' or
																	i.CODE eq 'CB04' or
																	i.CODE eq 'CB08' or
																	i.CODE eq 'CB10' or
																	i.CODE eq 'CB12' or
																	i.CODE eq 'CB16'
																	}">
													<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
													</c:if>
												</c:forEach>
											</form:select>
										</dd>
									</dl>
									</c:if>

									<div class="end"></div>
								</div>
								<p class="btn_w">
									<a id="search-btn" class="btnNew4">검색하기</a>
									<a id="vk-popup" class="btnNew2">다국어입력기</a>
									<a id="reset-btn" class="btnNew2">검색초기화</a>
								</p>
							</div>
							<!--// 검색하기_일반 -->

							<br/>
							<div id="autoFill">
							</div>
						</div>
					</c:otherwise>
				</c:choose>

			</c:when>
			<c:otherwise>

				<c:if test="${homepage.context_path eq '228' && param.menu_idx eq '203'}">
				<div  class="tabmenu">
					<ul>
						<li class="active"><a href="/228/intro/search/index.do?menu_idx=203&&shelfCode=AA55&booktype=BOOKANDNONBOOK#search_result">인물도서목록</a> </li>
						<li><a href="/228/html.do?menu_idx=204">인물소개</a> </li>
					</ul>
				</div>
				</c:if>

				<div class="search-form">

					<!-- 검색하기_일반 -->
					<div class="searchbox detail_search" id="div_detail">
						<div class="section">

							<div class="title-box">
								<form:input path="title" class="text-area" placeholder="도서 제목을 입력하세요" onkeyup="if(window.event.keyCode==13){searchIndex();}"/>
							</div>

							<div class="vk-btn">

							</div>

						<c:choose>
						<c:when test="${homepage.context_path eq 'dalseonglib'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="BR" class="libCheck lib_BR" label="달성군립도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GA" class="libCheck lib_GA" label="화원읍작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GB" class="libCheck lib_GB" label="논공읍작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HG" class="libCheck lib_HG" label="다사읍작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GD" class="libCheck lib_GD" label="다사읍서재작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GF" class="libCheck lib_GF" label="유가읍작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GH" class="libCheck lib_GH" label="옥포읍작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FR" class="libCheck lib_FR" label="가창면참꽃작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GE" class="libCheck lib_GE" label="하빈면작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GC" class="libCheck lib_GC" label="구지면작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FN" class="libCheck lib_FN" label="달성군청소년센터"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FJ" class="libCheck lib_FJ" label="달성군청도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'seogulib'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="BL" class="libCheck lib_BL" label="서구어린이도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BQ" class="libCheck lib_BQ" label="비산도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BP" class="libCheck lib_BP" label="서구영어도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BM" class="libCheck lib_BM" label="비원도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BN" class="libCheck lib_BN" label="원고개도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GQ" class="libCheck lib_GQ" label="내당2,3동 드림도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FU" class="libCheck lib_FU" label="내당4동어린이도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FZ" class="libCheck lib_FZ" label="비산7동 작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FH" class="libCheck lib_FH" label="새마을문고대구서구지부작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FT" class="libCheck lib_FT" label="서구청작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HC" class="libCheck lib_HC" label="달성토성마을 다락방 작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="CC" class="libCheck lib_CC" label="New평리도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HT" class="libCheck lib_CC" label="서구어린이영어도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'dalseolib'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="BU" class="libCheck lib_BU" label="성서도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BV" class="libCheck lib_BV" label="달서어린이도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BW" class="libCheck lib_BW" label="도원도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BX" class="libCheck lib_BX" label="본리도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BY" class="libCheck lib_BY" label="달서가족문화도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BZ" class="libCheck lib_BZ" label="달서영어도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FA" class="libCheck lib_FA" label="이곡2동공립작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FB" class="libCheck lib_FB" label="용산1동작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FC" class="libCheck lib_FC" label="장기동작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FD" class="libCheck lib_FD" label="죽전동공립작은도서관"/>
									</li>
									<!--<li>
										<form:checkbox path="libraryCodes" value="FW" class="libCheck lib_FW" label="달서아트센터 도서관"/>
									</li>-->
									<li>
										<form:checkbox path="libraryCodes" value="FX" class="libCheck lib_FX" label="행정정보문고센터"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GK" class="libCheck lib_GK" label="학산작은도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'namdm' || homepage.context_path eq 'namic'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="BT" class="libCheck lib_BT" label="이천어울림도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BS" class="libCheck lib_BS" label="대명어울림도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FE" class="libCheck lib_FE" label="꿈틀작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HV" class="libCheck lib_HV" label="다문화어린이도서관모두"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'junggu'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="FS" class="libCheck lib_FS" label="대구중구영어도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FF" class="libCheck lib_FF" label="남산4동작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FQ" class="libCheck lib_FQ" label="동인 느티나무 도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FY" class="libCheck lib_FY" label="중구청교양정보실"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GG" class="libCheck lib_GG" label="대신동작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HA" class="libCheck lib_HA" label="삼덕마루 작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HF" class="libCheck lib_HF" label="대봉2동작은도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'beomeo' || homepage.context_path eq 'yonghak' || homepage.context_path eq 'gosan'}">
						<div id="libraryList" class="libraryList">
							<c:if test="${homepage.context_path eq 'yonghak' and fn:length(mediaCodeList) < 1}">
								<form:hidden path="media_code"/>
							</c:if>

							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="BD" class="libCheck lib_BD" label="범어도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BE" class="libCheck lib_BE" label="용학도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BF" class="libCheck lib_BF" label="고산도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BG" class="libCheck lib_BG" label="파동도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BH" class="libCheck lib_BH" label="무학숲도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BJ" class="libCheck lib_BJ" label="책숲길도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BK" class="libCheck lib_BK" label="물망이도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="FG" class="libCheck lib_FG" label="사월책문화센터"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HR" class="libCheck lib_HR" label="황금책문화센터"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HS" class="libCheck lib_HS" label="수성못그림책도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체  </label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="BA" class="libCheck lib_BA" label="구수산도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BB" class="libCheck lib_BB" label="대현도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BC" class="libCheck lib_BC" label="태전도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GL" class="libCheck lib_GL" label="산격1동 작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GM" class="libCheck lib_GM" label="북구영어작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="GN" class="libCheck lib_GN" label="침산1동 작은도서관"/>
									</li>
									<!--<li>
										<form:checkbox path="libraryCodes" value="GP" class="libCheck lib_GP" label="노원동 작은도서관"/>
									</li>-->
									<li>
										<form:checkbox path="libraryCodes" value="HB" class="libCheck lib_HB" label="서변동작은도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HD" class="libCheck lib_HD" label="노원행복도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="HE" class="libCheck lib_HE" label="한강공원부키도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:when test="${homepage.context_path eq 'nearbylib'}">
						<div id="libraryList" class="libraryList">
							<div>
								<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL"/><label for="checkAll">전체</label>
							</div>
							<div>
								<ul>
									<li>
										<form:checkbox path="libraryCodes" value="AA" class="libCheck lib_AA" label="228기념학생도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="AH" class="libCheck lib_AH" label="동부도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="CA" class="libCheck lib_CA" label="안심도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="CB" class="libCheck lib_CB" label="신천도서관"/>
									</li>
									<li>
										<form:checkbox path="libraryCodes" value="BA" class="libCheck lib_BA" label="구수산도서관"/>
									</li>
								</ul>
							</div>
							<div class="end"></div>
						</div>
						<div class="end" style="padding:7px 0;"></div>
						</c:when>
						<c:otherwise>

						</c:otherwise>
						</c:choose>

							<dl>
								<dt><label for="author" class="title">저자</label></dt>
								<dd><form:input path="author" class="text-area" onkeyup="if(window.event.keyCode==13){searchIndex();}"/></dd>
							</dl>

							<dl>
								<dt><label for="publer" class="title">발행처</label></dt>
								<dd><form:input path="publer" class="text-area" onkeyup="if(window.event.keyCode==13){searchIndex();}"/></dd>
							</dl>
							<dl>
								<dt><label for="keyword" class="title">키워드</label></dt>
								<dd><form:input path="keyword" class="text-area" onkeyup="if(window.event.keyCode==13){searchIndex();}"/></dd>
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
								<dt><label for="isbn" class="title">ISBN</label></dt>
								<dd><form:input path="isbn" class="text-area" onkeyup="if(window.event.keyCode==13){searchIndex();}"/></dd>
							</dl>

							<dl>
								<dt>자료형태</dt>
								<dd>
									<div class="" style="padding:10px 0 0 0;">
									<form:radiobutton path="booktype" value="BOOKANDNONBOOK" class="radiocheck" checked="checked"/><label for="booktype1" class="booktype">통합</label>
									<form:radiobutton path="booktype" value="BOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype2" class="booktype">도서</label>
									<form:radiobutton path="booktype" value="NONBOOK" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype3" class="booktype">비도서</label>
									<%--<form:radiobutton path="booktype" value="SERIAL" class="radiocheck" cssStyle="margin-left:18px;"/><label for="booktype4" class="booktype">간행물</label> --%>
									</div>
								</dd>
							</dl>
							
							<c:if test="${fn:length(shelfCodeList) > 0}">
							<c:choose>
								<c:when test="${homepage.context_path eq '228' && (param.menu_idx eq '130' || param.menu_idx eq '131' || param.menu_idx eq '265')}">
								<form:hidden path="shelfCode"/>
								</c:when>
								<c:otherwise>
								<dl>
									<dt><label for="keyword" class="title">자료실구분</label></dt>
									<dd>
										<form:select path="shelfCode">
											<form:option value="">전체</form:option>
											<c:forEach items="${shelfCodeList}" var="i" varStatus="status">
												<c:choose>
													<c:when test="${(homepage.context_path eq 'suseong') and (param.menu_idx eq '181')}">
														<c:if test="${i.CODE eq 'AE52'}">
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>
													<c:when test="${homepage.context_path eq 'duryu'}">
														<c:if test="${i.CODE eq 'AB01' or
																		i.CODE eq 'AB02' or
																		i.CODE eq 'AB03' or
																		i.CODE eq 'AB04' or
																		i.CODE eq 'AB05' or
																		i.CODE eq 'AB06' or
																		i.CODE eq 'AB07' or
																		i.CODE eq 'AB27' or
																		i.CODE eq 'AB28' or
																		i.CODE eq 'AB35' or
																		i.CODE eq 'AB36' or
																		i.CODE eq 'AB55' or
																		i.CODE eq 'AB56'
																		}">
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>
													<c:when test="${homepage.context_path eq 'suseong'}">
														<c:if test="${i.CODE eq 'AE01' or
																		i.CODE eq 'AE01' or
																		i.CODE eq 'AE03' or
																		i.CODE eq 'AE04' or
																		i.CODE eq 'AE05' or
																		i.CODE eq 'AE11' or
																		i.CODE eq 'AE12' or
																		i.CODE eq 'AE14' or
																		i.CODE eq 'AE18' or
																		i.CODE eq 'AE19' or
																		i.CODE eq 'AE20' or
																		i.CODE eq 'AE22' or
																		i.CODE eq 'AE23'
																		}">
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>
													<c:when test="${homepage.context_path eq 'yonghak'}">
														<c:if test="${i.CODE eq 'BE01' or
																		i.CODE eq 'BE02' or
																		i.CODE eq 'BE03' or
																		i.CODE eq 'BE04' or
																		i.CODE eq 'BE05' or
																		i.CODE eq 'BE06' or
																		i.CODE eq 'BE09' or
																		i.CODE eq 'BE18' or
																		i.CODE eq 'BE13'
																		}">
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>
													<c:when test="${homepage.context_path eq 'gosan'}">
														<c:if test="${i.CODE eq 'BF01' or
																		i.CODE eq 'BF02' or
																		i.CODE eq 'BF03' or
																		i.CODE eq 'BF04' or
																		i.CODE eq 'BF05' or
																		i.CODE eq 'BF06' or
																		i.CODE eq 'BF07' or
																		i.CODE eq 'BF08' or
																		i.CODE eq 'FG01' or
																		i.CODE eq 'FG09' or
																		i.CODE eq 'FG10' or
																		i.CODE eq 'FG07'
																		}">
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>
													<c:when test="${homepage.context_path eq 'seobu'}">
														<c:if test="${i.CODE eq 'AF01' || i.CODE eq 'AF03' || i.CODE eq 'AF04' || i.CODE eq 'AF06' || i.CODE eq 'AF07' || i.CODE eq 'AF08' || i.CODE eq 'AF10' || i.CODE eq 'AF11' || i.CODE eq 'AF13' || i.CODE eq 'AF21' || i.CODE eq 'AF23' || i.CODE eq 'AF25' || i.CODE eq 'AF29' || i.CODE eq 'AF35' || i.CODE eq 'AF36' || i.CODE eq 'AF37' || i.CODE eq 'AF38' || i.CODE eq 'AF40' || i.CODE eq 'AF42' || i.CODE eq 'AF43' || i.CODE eq 'AF44' || i.CODE eq 'AF45' || i.CODE eq 'AF46' || i.CODE eq 'AF47'}">
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>
													<c:when test="${homepage.context_path eq 'gukbo'}">
													</c:when>
													<c:when test="${(homepage.context_path eq 'dongbu') and (param.menu_idx eq '173')}">
														<c:if test="${i.CODE eq 'AH14' or i.CODE eq 'AH16'}">
															<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
														</c:if>
													</c:when>

													<c:otherwise>
														<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
													</c:otherwise>
												</c:choose>

											</c:forEach>

											<c:if test="${homepage.context_path eq 'gukbo'}">
												<form:option value="AD01">[국보]종합자료실</form:option>
												<form:option value="AD43">[국보]종합자료실(대구경북다시보기)</form:option>
												<form:option value="AD08">[국보]종합자료실(세종도서)</form:option>
												<form:option value="AD49">[국보]종합자료실(다문화도서)</form:option>
												<form:option value="AD18">[국보]종합자료실(치매도서)</form:option>
												<form:option value="AD07">[국보]인문자료실</form:option>
												<form:option value="AD05">[국보]인문자료실(청소년도서)</form:option>
												<form:option value="AD14">[국보]인문자료실(큰글자도서)</form:option>
												<form:option value="AD50">[국보]인문자료실(DVD)</form:option>
												<form:option value="AD11">[국보]유아자료실</form:option>
												<form:option value="AD13">[국보]어린이자료실</form:option>
												<form:option value="AD39">[국보]스마트도서관(중앙로역)</form:option>
												<form:option value="AD40">[국보]스마트도서관(두류역)</form:option>
												<form:option value="AD36">[국보]대구전자도서관</form:option>
											</c:if>
										</form:select>
									</dd>
								</dl>
								</c:otherwise>
							</c:choose>
							</c:if>

							<c:if test="${fn:length(mediaCodeList) > 0}">
							<dl id="nonBookMedia" ${fn:escapeXml(param.booktype) eq 'NONBOOK' ? '' : 'style="display: none;"'}>
								<dt><label for="keyword" class="title">매체구분</label></dt>
								<dd>
									<form:select path="media_code">
										<form:option value="">전체</form:option>
										<c:forEach items="${mediaCodeList}" var="i" varStatus="status">
											<form:option value="${i.CODE}">${i.DESCRIPTION}</form:option>
										</c:forEach>
									</form:select>
								</dd>
							</dl>
							</c:if>


							<div class="end"></div>
						</div>
						<p class="btn_w">
							<a href="javascript:void(0);" class="btnNew4" onclick="searchIndex();">검색하기</a>
							<a id="vk-popup" class="btnNew2">다국어입력기</a>
							<a id="reset-btn" class="btnNew2">검색초기화</a>
						</p>
					</div>
					<!--// 검색하기_일반 -->

					<br/>
					<div id="autoFill">
					</div>
				</div>
			</c:otherwise>
		</c:choose>

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
				※ 검색결과 총 <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건이 검색되었습니다.
			</div>

			<div class="research-box">
				<select id="subSearchType" class="text-area01 new_select_box">
					<option value="title">서명</option>
					<option value="author">저자</option>
					<option value="publer">발행처</option>
					<option value="keyword">키워드</option>
				</select>
				<input id="subSearchText" placeholder="" class="text-area01" style="border-radius:3px;"/>
				<a href="#" id="subSearch" class="btn">결과 내 재검색</a>
				<div class="fl_right_btn">
					<a href="#" id="addStorage" class="btn btn4">관심도서 추가</a>
				</div>
			</div>

			<!--
			<div class="search-condition">

				<div class="mode">
					<ul>
						<li><a href="#;" class="btn-View imgView on">이미지형 표지형 설정</a></li>
						<li><a href="#;" class="btn-View listView">목록형 표지형 설정</a></li>
					</ul>
				</div>

			</div>
			 -->

			<div class="smain">
				<div class="box">
					<div class="ws-toolbar">
						<div class="checkBoxAll">
							<input type="hidden" name="" value="on"/>
							<input id="checkAllBook" name="" type="checkbox" value="Y"/>
							<label for="checkAllBook">전체</label>
						</div>

						<div class="control">
							<form:select path="sortField" cssClass="text-area01 new_select_box">
								<form:option value="NONE">정렬없음</form:option>
								<form:option value="TITLE">제목</form:option>
								<form:option value="AUTHOR">저자</form:option>
								<form:option value="PUBLISHER">발행처</form:option>
								<form:option value="PUB_YEAR">발행년도</form:option>
								<form:option value="SHELF_DATE">배가일</form:option>
							</form:select>
							<form:select path="sortType" cssClass="text-area01 new_select_box">
								<form:option value="ASC">오름차순</form:option>
								<form:option value="DESC">내림차순</form:option>
							</form:select>
							<form:select path="rowCount" cssClass="text-area01 new_select_box">
								<form:option value="10" label="10건"></form:option>
								<form:option value="20" label="20건"></form:option>
								<form:option value="30" label="30건"></form:option>
								<form:option value="40" label="40건"></form:option>
								<form:option value="50" label="50건"></form:option>
								<form:option value="100" label="100건"></form:option>
							</form:select>
							<a href="#sort" id="sort-btn" class="btn btn_mgt">정렬</a>
						</div>
					</div>

					<div id="search-results" class="search-results">
						<div class="imageType">
							<c:forEach items="${bookSearch}" var="i">
							<!-- 검색결과 루프 시작 -->
							<c:set var="detailURL" value="detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${fn:escapeXml(i.ST_CODE)}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}&bookkey=${i.BOOK_KEY}"></c:set>
							<div class="row">
								<p class="admin">
									<input name="print_param" type="checkbox" class="checkBook" id="print_param${status.index}" value="${fn:replace(i.TITLE_INFO, ',', ';;;')}///${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}///${fn:escapeXml(i.MANAGE_CODE)}///${fn:escapeXml(i.REG_NO)}///${fn:escapeXml(i.CALL_NO)}///${fn:escapeXml(param.menu_idx)}" title="책 선택"/>
								</p>
								<div class="thumb">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<a href="${detailURL}" class="noImg">
												<img src="/resources/homepage/libculture/img/book_noimg.png" alt="${i.TITLE_INFO}" onError="src='/resources/homepage/libculture/img/book_noimg.png';"/>
											</a>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<a href="${detailURL}">
												<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}" onError="src='/resources/homepage/libculture/img/book_noimg.png';"/>
											</a>
										</c:when>
										<c:otherwise>
											<a href="${detailURL}">
												<img src="${i.imageUrl}" alt="${i.TITLE_INFO}" onError="src='/resources/homepage/libculture/img/book_noimg.png';"/>
											</a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="box">
									<div class="item">
										<div class="bif">

											<a href="${detailURL}">
											<c:if test="${i.FORM_CODE eq 'BK'}">[도서]</c:if>
											<c:if test="${i.FORM_CODE ne 'BK'}">[비도서]</c:if>
											<c:if test="${librarySearch.booktype eq 'SERIAL'}">[간행물]</c:if>
											<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span>
											</a>

											<p><font style="color:#5e5e5e;">저자</font> : ${i.AUTHOR}</p>
											<p><font style="color:#5e5e5e">발행처</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}</p>
                      
											<p><font style="color:#5e5e5e">소장처</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span> / <font style="color:#5e5e5e">자료실</font> : 
											<c:choose>
												<c:when test="${homepage.context_path eq 'namic'}">
													<span style="font-weight:bold; font-size: 17px; color: #0000ff;">
												</c:when>
												<c:otherwise>
													<span style="font-weight:800;">
												</c:otherwise>
											</c:choose>
											${i.SHELF_LOC_NAME}</span> <c:if test="${i.MANAGE_CODE eq 'AD'}"><c:if test="${i.SHELF_LOCATION_KEY ne null && i.SHELF_LOCATION_KEY ne ''}">/ <font style="color:#5e5e5e">서가위치</font> : <span style="font-weight:800;">${fn:split(i.SHELF_LOCATION_KEY,'@^^@')[1]}</span></c:if></c:if></p>

											<p><font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}</p>
											<p><font style="color:#5e5e5e">등록번호</font> : ${i.REG_NO}</p>
											<c:if test="${i.SHELF_LOC_CODE ne 'AD36'}">
											<p><font style="color:#5e5e5e">대출가능여부</font> :
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${homepage.context_path eq 'yonghak' and i.droneLoanYn eq 'Y'}">
														<span style="color:#ff0000">대출불가(드론대출중)</span>
													</c:when>
													<c:when test="${i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HQ'}">
														<span style="color:#ff0000">대출불가(임시휴관)</span>
													</c:when>
													<c:when test="${i.MANAGE_CODE eq '' and i.SHELF_LOC_CODE eq ''}">
														<span style="color:#ff0000">대출불가</span>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${i.LOAN_CODE eq 'OK' and i.MEDIA_NAME eq 'DVD' and i.MANAGE_CODE eq 'BR'}">
																관내대출가능
															</c:when>
															<c:when test="${i.LOAN_CODE eq 'OK'}">
																대출가능
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${i.SHELF_LOC_CODE eq 'BA08' or i.SHELF_LOC_CODE eq 'BA22' or i.SHELF_LOC_CODE eq 'BA23'}">
																		<c:choose>
																			<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																				<c:choose>
																					<c:when test="${i.MEDIA_NAME eq 'DVD' and i.MANAGE_CODE eq 'BR'}">
																						<span style="color:#ff0000">대출불가(관내대출중)</span>
																					</c:when>
																					<c:otherwise>
																						<span style="color:#ff0000">대출불가(관외대출중)</span>
																					</c:otherwise>
																				</c:choose>
																			</c:when>
																			<c:when test="${i.WORKING_STATUS == 'BOL213O'}">
																				<c:choose>
																					<c:when test="${i.MEDIA_NAME eq 'DVD' and i.MANAGE_CODE eq 'BR'}">
																						<span style="color:#ff0000">대출불가(관내대출중)</span>
																					</c:when>
																					<c:otherwise>
																						<span style="color:#ff0000">대출불가(관외대출중)</span>
																					</c:otherwise>
																				</c:choose>
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
																				<span style="color:#ff0000">대출불가(예약대출 대기중)</span>
																			</c:otherwise>
																		</c:choose>
																	</c:when>
																	<c:otherwise>
																		<c:choose>
																			<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																				<c:choose>
																					<c:when test="${i.MEDIA_NAME eq 'DVD' and i.MANAGE_CODE eq 'BR'}">
																						<span style="color:#ff0000">대출불가(관내대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																					</c:when>
																					<c:otherwise>
																						<span style="color:#ff0000">대출불가(관외대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																					</c:otherwise>
																				</c:choose>
																			</c:when>
																			<c:when test="${i.WORKING_STATUS == 'BOL213O'}">
																				<c:choose>
																					<c:when test="${i.MEDIA_NAME eq 'DVD' and i.MANAGE_CODE eq 'BR'}">
																						<span style="color:#ff0000">대출불가(관내대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																					</c:when>
																					<c:otherwise>
																						<span style="color:#ff0000">대출불가(관외대출중)(예약 : ${i.RESERVATION_CNT}명)</span>
																					</c:otherwise>
																				</c:choose>
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
																				<c:choose>
																					<c:when test="${i.RESERVATION_CNT > 0}">
																						<span style="color:#ff0000">대출불가(예약대출 대기중)(예약 : ${i.RESERVATION_CNT}명)</span>
																					</c:when>
																					<c:otherwise> 
																						<span style="color:#ff0000">대출불가</span>
																					</c:otherwise>
																				</c:choose>
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
												<c:choose>
													<c:when test="${(homepage.context_path eq '' or homepage.context_path eq 'seobu' or homepage.context_path eq 'dongbu') and i.RESERVE_CODE eq 'OK'}">
														<a href="javascript:void(0);" class="btn btn1" style="padding:3px 7px 4px 7px;background:#fe6d02;border-color:#fe6d02;font-size:12px;" onclick="resveReq('${i.BOOK_KEY}', '${fn:startsWith(i.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}', 'ADD');">예약신청</a>
													</c:when>
												</c:choose>
											</p>
											</c:if>
											<!--
											JU : 아동, MS : 중학생, AD : 성인, PU : 일반, ES : 초등, HS : 고등, SP : 특수, TE : 청소년, 기타 :
											-->
<c:set var="getIp" value="<%=request.getRemoteAddr()%>" />
<c:if test="${getIp eq '218.48.151.16'}">

</c:if>
											<c:if test="${not empty i.APPENDIX_INFO}">
											<c:if test="${i.APPENDIX_LIST[0].LOAN_CODE eq 'OK'}">
											<p><font style="color:#5e5e5e">부록여부</font> : ${i.APPENDIX_INFO[0].DESCRIPTION} (${i.APPENDIX_INFO[0].APPENDIX_CNT}개)</p>
											</c:if>
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
															<c:when test="${i.USE_OBJECT_CODE eq 'TE'}">
																<span style="">청소년</span>
															</c:when>
															<c:otherwise>
																<span style="">기타</span>
															</c:otherwise>
														</c:choose>
											</p>
											<p><font style="color:#5e5e5e">매체구분</font> : <span style="">${i.MEDIA_NAME}</span></p>
											<c:if test="${not empty i.marc and (homepage.context_path eq 'dalseolib' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj')}">
											<p><font style="color:#5e5e5e">영어독서 레벨</font> : <span style="">${i.marc}</span></p>
											</c:if>
											<c:if test="${i.SHELF_LOC_CODE eq 'BC03' || i.SHELF_LOC_CODE eq 'BC05' || i.SHELF_LOC_CODE eq 'BC06'}">
												<div class="" style="font-size:14px;font-weight:bold;color:red;">
													※ 이관도서는 공동 보존서고에 보관중이므로 당일 대출 불가, 사전 신청을 통해 대출 가능합니다.<br>신청 및 문의 (☎ 053-320-5184/5188)
												</div>
											</c:if>
											<c:if test="${i.SHELF_LOC_CODE eq 'BB03'}">
												<div class="" style="font-size:14px;font-weight:bold;color:red;">
													※ 보존서고 도서는 폐가제로 운영됩니다. &nbsp;대출 관련은 담당자에게 문의바랍니다. (☎ 053-320-5174)
												</div>
											</c:if>
											<!-- <p><font style="color:#5e5e5e">소장위치</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span></p> -->
											<div class="stat">
												<a href="#showSlide" class="showSlide"><span>소장정보</span></a>

												<!-- 상호대차 -->
												<c:if test="${i.LOAN_CODE eq 'OK'}">
													<c:choose>
														<c:when test="${homepage.context_path eq '228'}">
															<c:choose>
																<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																	<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'namdm' || homepage.context_path eq 'namic'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'BT' || i.MANAGE_CODE eq 'BS' || i.MANAGE_CODE eq 'FE'}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'dalseolib'}"> <!-- 달서통합도서관 -->
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'FD'||i.MANAGE_CODE eq 'FW'||i.MANAGE_CODE eq ''}">
																</c:when>
																<c:when test="${i.MANAGE_CODE eq 'BV'||i.MANAGE_CODE eq 'FA'|| i.MANAGE_CODE eq 'BW'|| i.MANAGE_CODE eq 'BU'|| i.MANAGE_CODE eq 'BX' ||i.MANAGE_CODE eq 'BY' ||i.MANAGE_CODE eq 'FB' ||i.MANAGE_CODE eq 'FC' || i.MANAGE_CODE eq 'GK' || i.MANAGE_CODE eq 'FX' || i.MANAGE_CODE eq 'BZ'}"><!--9/30 달서가족문화도서관 상호대차 중지 재개시 빈칸에 BY 입력 -->
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'donggu'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HQ' || i.MANAGE_CODE eq 'HP'}">
																</c:when>
																<c:when test="${i.MANAGE_CODE eq 'CA'|| i.MANAGE_CODE eq 'CB' || i.MANAGE_CODE eq 'GR' || i.MANAGE_CODE eq 'GS' || i.MANAGE_CODE eq 'FK' || i.MANAGE_CODE eq 'GT' || i.MANAGE_CODE eq 'FP' || i.MANAGE_CODE eq 'FL' || i.MANAGE_CODE eq 'GU' || i.MANAGE_CODE eq 'GV' || i.MANAGE_CODE eq 'GW' || i.MANAGE_CODE eq 'GX' || i.MANAGE_CODE eq 'GY' || i.MANAGE_CODE eq 'FM' || i.MANAGE_CODE eq 'FL' || i.MANAGE_CODE eq 'HJ' || i.MANAGE_CODE eq 'HK' || i.MANAGE_CODE eq 'HL' || i.MANAGE_CODE eq 'HN' || i.MANAGE_CODE eq ''}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'GJ'}">
																	<!--   제외 -->
																</c:when>
																<c:when test="${i.MANAGE_CODE eq 'BA'  || i.MANAGE_CODE eq 'BB' || i.MANAGE_CODE eq 'BC' || i.MANAGE_CODE eq 'GN' || i.MANAGE_CODE eq 'GP' || i.MANAGE_CODE eq 'HB' || i.MANAGE_CODE eq 'HD' || i.MANAGE_CODE eq 'HE' || i.MANAGE_CODE eq 'GL' || i.MANAGE_CODE eq 'GM'}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'seogulib'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'BL' || i.MANAGE_CODE eq 'BQ' || i.MANAGE_CODE eq 'BP' || i.MANAGE_CODE eq 'BM' || i.MANAGE_CODE eq 'BN' || i.MANAGE_CODE eq 'CC'}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'beomeo'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'BD' || i.MANAGE_CODE eq 'BE' || i.MANAGE_CODE eq 'BF' || i.MANAGE_CODE eq 'BG' || i.MANAGE_CODE eq 'BH' || i.MANAGE_CODE eq 'BJ' || i.MANAGE_CODE eq 'BK' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'HR'}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'yonghak'}">
															<c:choose>
																<c:when test="${homepage.context_path eq 'yonghak' and droneLoanYn eq 'Y'}">
																</c:when>
																<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																	<c:choose>
																		<c:when test="${i.MANAGE_CODE eq 'BD' || i.MANAGE_CODE eq 'BE' || i.MANAGE_CODE eq 'BF' || i.MANAGE_CODE eq 'BG' || i.MANAGE_CODE eq 'BH' || i.MANAGE_CODE eq 'BJ' || i.MANAGE_CODE eq 'BK' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'HR'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'gosan'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'BD' || i.MANAGE_CODE eq 'BE' || i.MANAGE_CODE eq 'BF' || i.MANAGE_CODE eq 'BG' || i.MANAGE_CODE eq 'BH' || i.MANAGE_CODE eq 'BJ' || i.MANAGE_CODE eq 'BK' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'HR'}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>

														<c:when test="${homepage.context_path eq 'junggu'}">
															<c:choose>
																<c:when test="${i.MANAGE_CODE eq 'FS' || i.MANAGE_CODE eq 'FY' || i.MANAGE_CODE eq 'FF' || i.MANAGE_CODE eq 'FQ' || i.MANAGE_CODE eq 'GG' || i.MANAGE_CODE eq 'HA' || i.MANAGE_CODE eq 'HF' || i.MANAGE_CODE eq 'FV'}">
																	<c:choose>
																		<c:when test="${i.KBILL_LILL_YN eq 'O'}">
																			<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																		</c:when>
																		<c:otherwise>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:when>


													</c:choose>
												</c:if>

												<!-- 예약 -->
												<c:if test="${homepage.context_path ne 'nearbylib'}">
													<c:choose>
														<c:when test="${i.SHELF_LOC_CODE eq 'AD39' || i.SHELF_LOC_CODE eq 'AD40' || i.SHELF_LOC_CODE eq 'BA08' || i.SHELF_LOC_CODE eq 'BA01' || i.SHELF_LOC_CODE eq 'BD10' || i.MANAGE_CODE eq 'FW' || i.SHELF_LOC_CODE eq 'BU11'}">

														</c:when>
														<c:when test="${i.MANAGE_CODE eq 'AC' && now <= 20241220000000}">
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${i.RESERVE_CODE eq 'OK'}">
																	<a href="" class="btn btn1 booking resve-req" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}">
																		예약신청(${i.RESERVATION_CNT} / ${i.RESERVATION_NUMBER})</a>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${i.SEPARATE_SHELF_CODE eq 'BMY' || i.SEPARATE_SHELF_CODE eq 'BMZ' || i.SEPARATE_SHELF_CODE eq 'BNB' || i.SEPARATE_SHELF_CODE eq 'BNC' || i.SEPARATE_SHELF_CODE eq 'BMN' || i.SEPARATE_SHELF_CODE eq 'BMT'}">

																		</c:when>

																		<c:otherwise>
																			<a href="#" id="resve-req-not" class="btn btn5">예약불가(${i.RESERVATION_CNT} / ${i.RESERVATION_NUMBER})</a>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
												</c:if>

												<!--비대면도서대출 버튼-->
												<c:choose>
													<c:when test="${homepage.context_path eq 'bukgs' and i.MANAGE_CODE eq 'BA' and i.LOAN_CODE eq 'OK'}">
														<c:choose>
															<c:when test="${i.SHELF_LOC_CODE eq 'BA08'||i.SHELF_LOC_CODE eq 'BA22'||i.SHELF_LOC_CODE eq 'BA23'}">

															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${i.REG_CODE eq 'CDG'}">

																	</c:when>
																	<c:otherwise>
																		<jsp:useBean id="Day1" class="java.util.Date" />
																		<fmt:formatDate var="day" value="${Day1}" pattern="E"/>
																		<c:set var="endTime" value="17:00:00"></c:set>
																		<fmt:parseDate var="dateStr1" value="${endTime}" pattern="HH:mm:ss"/>
																		<fmt:formatDate var="dateStr2" value="${Day1}" pattern="HH:mm:ss"/>
																		<fmt:formatDate var="endTime" value="${dateStr1}" pattern="HH:mm:ss"/>
																		<c:choose>
																			<c:when test="${(day eq '토' or day eq '일') and endTime <= dateStr2}">

																			</c:when>
																			<c:otherwise>
																				<a href="#untact" class="btn btn2 untactBook-req" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}">
																					<span>무인예약대출 신청</span></a>
																			</c:otherwise>
																		</c:choose>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:when>

													<c:when test="${homepage.context_path eq 'suseong' and i.MANAGE_CODE eq 'AE' and i.LOAN_CODE eq 'OK'}"><!--수성도서관 무인예약대출 일시 중지-->
														<c:choose>
															<c:when test="${i.SHELF_LOC_CODE eq 'BA08'||i.SHELF_LOC_CODE eq 'BA22'||i.SHELF_LOC_CODE eq 'BA23'}">

															</c:when>
															<c:otherwise>
																<jsp:useBean id="Daysu" class="java.util.Date"/>
																<fmt:formatDate var="day" value="${Daysu}" pattern="E"/>
																<c:if test="${day ne '토' and day ne '일'}">
																	<a href="#untact" class="btn btn2 untactBook-req" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}">
																		<span>무인예약대출</span></a>
																</c:if>
															</c:otherwise>
														</c:choose>
													</c:when>

													<c:when test="${homepage.context_path eq 'dalseonglib'}">
														<!-- 달성군립 무인예약 버튼은 토,일,월 제외한 09:00~12:00 까지만 활성화 -->
														<jsp:useBean id="toDay" class="java.util.Date" />
														<c:set var="startTime" value="09:00:00"></c:set>
														<c:set var="endTime" value="12:00:00"></c:set>
														<fmt:parseDate var="dateStr1" value="${startTime}" pattern="HH:mm:ss"/>
														<fmt:parseDate var="dateStr2" value="${endTime}" pattern="HH:mm:ss"/>
														<fmt:formatDate var="dateStr3" value="${toDay}" pattern="HH:mm:ss"/>
														<fmt:formatDate var="day" value="${toDay}" pattern="E"/>
														<fmt:formatDate var="startTime" value="${dateStr1}" pattern="HH:mm:ss"/>
														<fmt:formatDate var="endTime" value="${dateStr2}" pattern="HH:mm:ss"/>
														<c:if test="${startTime <= dateStr3 and dateStr3 <= endTime and (day ne '토' and day ne '일' and day ne '월')}">
															<c:if test="${i.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
																<c:if test="${i.RESERVATION_CNT eq '0' and i.LOAN_CODE eq 'OK'}">
																	<c:if test="${i.SHELF_LOC_CODE eq 'BR01' || i.SHELF_LOC_CODE eq 'BR02' || i.SHELF_LOC_CODE eq 'BR03' || i.SHELF_LOC_CODE eq 'BR05' || i.SHELF_LOC_CODE eq 'BR06' || i.SHELF_LOC_CODE eq 'BR07' || i.SHELF_LOC_CODE eq 'BR10'}">
																		<c:choose>
																			<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
																				<a href="#muin" id="service-noreq" class="btn">무인예약신청</a>
																			</c:when>
																			<c:otherwise>
																				<a href="#muin" id="unmanned-req" class="btn btn2" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}">
																					<span>무인예약대출 신청</span></a>
																			</c:otherwise>
																		</c:choose>
																	</c:if>
																</c:if>
															</c:if>
														</c:if>
													</c:when>

													<c:when test="${homepage.context_path eq 'gukbo'}">
														<c:if test="${i.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
															<c:if test="${i.RESERVATION_CNT eq '0'}">
																<c:if test="${i.SHELF_LOC_CODE eq 'AD01' || i.SHELF_LOC_CODE eq 'AD05' || i.SHELF_LOC_CODE eq 'AD07' || i.SHELF_LOC_CODE eq 'AD08' || i.SHELF_LOC_CODE eq 'AD09' || i.SHELF_LOC_CODE eq 'AD11' || i.SHELF_LOC_CODE eq 'AD13' || i.SHELF_LOC_CODE eq 'AD17' || i.SHELF_LOC_CODE eq 'AD18' || i.SHELF_LOC_CODE eq 'AD21' || i.SHELF_LOC_CODE eq 'AD22' || i.SHELF_LOC_CODE eq 'AD27' || i.SHELF_LOC_CODE eq 'AD28' || i.SHELF_LOC_CODE eq 'AD43' || i.SHELF_LOC_CODE eq 'AD49' || i.SHELF_LOC_CODE eq 'AD67'}">
																	<c:choose>
																		<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
																			<!-- <a href="#muin" id="service-noreq" class="btn">무인예약신청</a> -->
																		</c:when>
																		<c:otherwise>
																			<a href="#muin" id="unmanned-req" class="btn" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}">
																				<span>무인예약신청</span></a>
																		</c:otherwise>
																	</c:choose>
																</c:if>
															</c:if>
														</c:if>
													</c:when>
												</c:choose>

												<!--내집앞도서관-->
												<c:if test="${i.LOAN_CODE eq 'OK'}">
													<c:choose>
														<c:when test="${homepage.context_path eq 'dongbu'}">
															<c:if test="${i.MANAGE_CODE eq 'BA' || i.MANAGE_CODE eq 'AH' || i.MANAGE_CODE eq 'CB' || i.MANAGE_CODE eq 'AA' || i.MANAGE_CODE eq 'CA'}">
																<c:if test="${reserveData == 0 and reserveAvailability eq 'Y'}">
																	<c:if test="${i.SHELF_LOC_CODE ne 'AA02' and i.SHELF_LOC_CODE ne 'AA03' and i.SHELF_LOC_CODE ne 'AA05' and i.SHELF_LOC_CODE ne 'AA07' and i.SHELF_LOC_CODE ne 'AA09' and i.SHELF_LOC_CODE ne 'AA10' and i.SHELF_LOC_CODE ne 'AA11' and i.SHELF_LOC_CODE ne 'AA14' and i.SHELF_LOC_CODE ne 'AA15' and i.SHELF_LOC_CODE ne 'AA16' and i.SHELF_LOC_CODE ne 'AA17' and i.SHELF_LOC_CODE ne 'AA18' and i.SHELF_LOC_CODE ne 'AA19' and i.SHELF_LOC_CODE ne 'AA20' and i.SHELF_LOC_CODE ne 'AA21' and i.SHELF_LOC_CODE ne 'AA22' and  i.SHELF_LOC_CODE ne 'AA23' and i.SHELF_LOC_CODE ne 'AA29' and i.SHELF_LOC_CODE ne 'AA30' and i.SHELF_LOC_CODE ne 'AA31' and i.SHELF_LOC_CODE ne 'AA36' and i.SHELF_LOC_CODE ne 'AA37' and i.SHELF_LOC_CODE ne 'AA39' and i.SHELF_LOC_CODE ne 'AA40' and i.SHELF_LOC_CODE ne 'AA41' and i.SHELF_LOC_CODE ne 'AA51' and i.SHELF_LOC_CODE ne 'AA52' and i.SHELF_LOC_CODE ne 'AA53' and i.SHELF_LOC_CODE ne 'AA56' and i.SHELF_LOC_CODE ne 'AA58' and i.SHELF_LOC_CODE ne 'AA59' and i.SHELF_LOC_CODE ne 'AA60' and i.SHELF_LOC_CODE ne 'AA62' and i.SHELF_LOC_CODE ne 'AA65' and i.SHELF_LOC_CODE ne 'AA66' and i.SHELF_LOC_CODE ne 'AH14' and i.SHELF_LOC_CODE ne 'AH16' and i.SHELF_LOC_CODE ne 'AH26' and i.SHELF_LOC_CODE ne 'AH33' and i.SHELF_LOC_CODE ne 'AH60' and i.SHELF_LOC_CODE ne 'CA08' and i.SHELF_LOC_CODE ne 'CB08' and i.SHELF_LOC_CODE ne 'CB10' and i.SHELF_LOC_CODE ne 'BA08' and i.SHELF_LOC_CODE ne 'BA22' and i.SHELF_LOC_CODE ne 'BA23' and i.SHELF_LOC_CODE ne 'CA18' and i.SHELF_LOC_CODE eq 'AH64'}">
																		<c:choose>
																			<c:when test="${not empty nearbylibRejectMessage}">
																				<a href="javascript:void(0);" class="btn btn1" onclick="alert('${nearbylibRejectMessage}')">내 집 앞 도서관 예약</a>
																			</c:when>
																			<c:otherwise>
																				<a href="" class="btn btn1 neighborhoodLibrary-req" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}" title_info="${i.TITLE_INFO}" lib_name="${i.LIB_NAME}" call_no="${i.CALL_NO}" author="${i.AUTHOR}" shelf_loc_name="${i.SHELF_LOC_NAME}">내 집 앞 도서관 예약</a>
																			</c:otherwise>
																		</c:choose>
																	</c:if>
																</c:if>
															</c:if>
														</c:when>
														<c:otherwise>
															<c:if test="${homepage.context_path eq 'dgportal' || homepage.context_path eq '228' || homepage.context_path eq 'donggu' || homepage.context_path eq 'bukgs'}">
																<c:if test="${i.MANAGE_CODE eq 'BA' || i.MANAGE_CODE eq 'AH' || i.MANAGE_CODE eq 'CB' || i.MANAGE_CODE eq 'AA' || i.MANAGE_CODE eq 'CA'}">
																	<c:if test="${reserveData == 0 and reserveAvailability eq 'Y'}">
																		<c:if test="${i.SHELF_LOC_CODE ne 'AA02' and i.SHELF_LOC_CODE ne 'AA03' and i.SHELF_LOC_CODE ne 'AA05' and i.SHELF_LOC_CODE ne 'AA07' and i.SHELF_LOC_CODE ne 'AA09' and i.SHELF_LOC_CODE ne 'AA10' and i.SHELF_LOC_CODE ne 'AA11' and i.SHELF_LOC_CODE ne 'AA14' and i.SHELF_LOC_CODE ne 'AA15' and i.SHELF_LOC_CODE ne 'AA16' and i.SHELF_LOC_CODE ne 'AA17' and i.SHELF_LOC_CODE ne 'AA18' and i.SHELF_LOC_CODE ne 'AA19' and i.SHELF_LOC_CODE ne 'AA20' and i.SHELF_LOC_CODE ne 'AA21' and i.SHELF_LOC_CODE ne 'AA22' and  i.SHELF_LOC_CODE ne 'AA23' and i.SHELF_LOC_CODE ne 'AA29' and i.SHELF_LOC_CODE ne 'AA30' and i.SHELF_LOC_CODE ne 'AA31' and i.SHELF_LOC_CODE ne 'AA36' and i.SHELF_LOC_CODE ne 'AA37' and i.SHELF_LOC_CODE ne 'AA39' and i.SHELF_LOC_CODE ne 'AA40' and i.SHELF_LOC_CODE ne 'AA41' and i.SHELF_LOC_CODE ne 'AA51' and i.SHELF_LOC_CODE ne 'AA52' and i.SHELF_LOC_CODE ne 'AA53' and i.SHELF_LOC_CODE ne 'AA56' and i.SHELF_LOC_CODE ne 'AA58' and i.SHELF_LOC_CODE ne 'AA59' and i.SHELF_LOC_CODE ne 'AA60' and i.SHELF_LOC_CODE ne 'AA62' and i.SHELF_LOC_CODE ne 'AA65' and i.SHELF_LOC_CODE ne 'AA66' and i.SHELF_LOC_CODE ne 'AH14' and i.SHELF_LOC_CODE ne 'AH16' and i.SHELF_LOC_CODE ne 'AH26' and i.SHELF_LOC_CODE ne 'AH33' and i.SHELF_LOC_CODE ne 'AH60' and i.SHELF_LOC_CODE ne 'CA08' and i.SHELF_LOC_CODE ne 'CB08' and i.SHELF_LOC_CODE ne 'CB10' and i.SHELF_LOC_CODE ne 'BA08' and i.SHELF_LOC_CODE ne 'BA22' and i.SHELF_LOC_CODE ne 'BA23' and i.SHELF_LOC_CODE ne 'CA18'}">
																			<c:choose>
																				<c:when test="${not empty nearbylibRejectMessage}">
																					<a href="javascript:void(0);" class="btn btn1" onclick="alert('${nearbylibRejectMessage}')">내 집 앞 도서관 예약</a>
																				</c:when>
																				<c:otherwise>
																					<a href="" class="btn btn1 neighborhoodLibrary-req" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}" title_info="${i.TITLE_INFO}" lib_name="${i.LIB_NAME}" call_no="${i.CALL_NO}" author="${i.AUTHOR}" shelf_loc_name="${i.SHELF_LOC_NAME}">내 집 앞 도서관 예약</a>
																				</c:otherwise>
																			</c:choose>
																		</c:if>
																	</c:if>
																</c:if>
															</c:if>
														</c:otherwise>
													</c:choose>
												</c:if>

											</div>
										</div>
									</div>
								</div>
								<div class="bci" style="display:none;">
									<table summary="도서 상태 및 등록 정보" style="text-align:center" class="statusBox">
										<caption>도서 상태 및 등록 정보</caption>
										<thead>
											<tr>
												<th>소장<br class="mBr"/>위치</th>
												<th>등록<br class="mBr"/>번호</th>
												<c:if test="${i.SHELF_LOC_CODE ne 'AD36'}">
												<th>대출가능<br class="mBr"/>여부</th>
												</c:if>
												<th>반납<br class="mBr"/>예정일</th>
<%--												<th>자료위치<br class="mBr"/>인쇄</th>--%>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>${i.SHELF_LOC_NAME}</td>
												<td>${i.REG_NO}</td>
												<c:if test="${i.SHELF_LOC_CODE ne 'AD36'}">
												<td>
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HQ'}">
														<span style="color:#ff0000">대출불가(임시휴관)</span>
													</c:when>
													<c:when test="${i.MANAGE_CODE eq '' and i.SHELF_LOC_CODE eq ''}">
														<span style="color:#ff0000">대출불가</span>
													</c:when>
													<c:otherwise>
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
																			<c:when test="${i.USE_LIMIT_CODE eq 'CA'}">
																				대출불가
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
													</c:otherwise>
												</c:choose>
												<!-- 대출가능 여부 [ END ] -->
												<c:choose>
													<c:when test="${(homepage.context_path eq '' or homepage.context_path eq 'seobu' or homepage.context_path eq 'dongbu') and i.RESERVE_CODE eq 'OK'}">
														<a href="javascript:void(0);" class="btn btn1" style="padding:3px 7px 4px 7px;background:#fe6d02;border-color:#fe6d02;font-size:12px;" onclick="resveReq('${i.BOOK_KEY}', '${fn:startsWith(i.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}', 'ADD');">예약신청</a>
													</c:when>
												</c:choose>
												</td>
												</c:if>
												<td>
													<!--동촌역 스마트도서관 자료실은 반납예정일 숨김처리-->
													<c:choose>
														<c:when test="${(homepage.context_path eq 'donggu' || homepage.context_path eq 'dgportal') && i.SHELF_LOC_CODE eq 'CA18'}">
														</c:when>
														<c:otherwise>
															${i.RETURN_PLAN_DATE}
														</c:otherwise>
													</c:choose>
												</td>
<%--												<td>--%>
<%--													<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2">자료위치<br/>인쇄</a>--%>
<%--												</td>--%>
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
							<c:set var="detailURL" value="detail.do?menu_idx=${fn:escapeXml(param.menu_idx)}&isbn=${fn:escapeXml(i.ST_CODE)}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}"></c:set>
							<div class="row">
								<div class="box">
									<div class="item">
										<div class="bif">
										<input name="print_param" type="checkbox" class="checkBook" value="${i.TITLE_INFO}///${i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK'}///${i.MANAGE_CODE}///${i.REG_NO}///${param.menu_idx}"/>
											<a href="${detailURL}" class="name">
												<c:if test="${i.MEDIA_CODE eq 'PR'}">[도서]</c:if>
												<c:if test="${i.MEDIA_CODE ne 'PR'}">[비도서]</c:if>
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
												<font style="color:#5e5e5e">등록번호</font> : ${i.REG_NO}

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">매체구분</font> : ${i.MEDIA_NAME}

												<br/>
												<font style="color:#5e5e5e">소장처 </font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span>

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
												<font style="color:#5e5e5e">자료실</font> : <span style="font-weight:800;">${i.SHELF_LOC_NAME}</span>

												<br class="mobileBr"/>
												<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>

												<font style="color:#5e5e5e">대출가능여부</font> :
												<!-- 대출가능 여부 [START] -->
												<c:choose>
													<c:when test="${i.MANAGE_CODE eq ''}">
														<span style="color:#ff0000">대출불가</span>
													</c:when>													
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
																		<c:when test="${i.USE_LIMIT_CODE eq 'CA'}">
																			대출불가
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
												<c:choose>
													<c:when test="${(homepage.context_path eq 'bukbu' or homepage.context_path eq 'seobu' or homepage.context_path eq 'dongbu') and i.RESERVE_CODE eq 'OK'}">
														<a href="javascript:void(0);" class="btn btn1" style="padding:3px 7px 4px 7px;background:#fe6d02;border-color:#fe6d02;font-size:12px;" onclick="resveReq('${i.BOOK_KEY}', '${fn:startsWith(i.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}', 'ADD');">예약신청</a>
													</c:when>
												</c:choose>
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
<%--												<th>자료위치<br class="mBr"/>인쇄</th>--%>
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
																	<c:when test="${i.USE_LIMIT_CODE eq 'CA'}">
																		대출불가
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
												<c:choose>
													<c:when test="${(homepage.context_path eq 'bukbu' or homepage.context_path eq 'seobu' or homepage.context_path eq 'dongbu') and i.RESERVE_CODE eq 'OK'}">
														<a href="javascript:void(0);" class="btn btn1" style="padding:3px 7px 4px 7px;background:#fe6d02;border-color:#fe6d02;font-size:12px;" onclick="resveReq('${i.BOOK_KEY}', '${fn:startsWith(i.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}', 'ADD');">예약신청</a>
													</c:when>
												</c:choose>
												</td>
												<td>
													${i.RETURN_PLAN_DATE}
												</td>
<%--												<td>--%>
<%--													<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2">자료위치<br/>인쇄</a>--%>
<%--												</td>--%>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							</c:forEach>
							<!-- 검색결과루프 끝 -->
							<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
						</div>

						<div style="padding-top:30px ;text-align:right">
							<a href="https://www.aladin.co.kr/home/welcome.aspx" target="_blank" style="color:#000">도서 DB 이미지 제공 : 알라딘 인터넷서점(www.aladin.co.kr)</a> <img src="/resources/common/img/aladin_01.png" alt="alandin" align="absmiddle"/>
						</div>
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