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
			$('form#neighborhoodLibrary').submit();
		});

		//검색하기
		$('a#search-btn').on('click', function(e) {
			e.preventDefault();

			if ($('input#title').val() == '' && $('input#author').val() == '' && $('input#publer').val() == '' && $('input#keyword').val() == '') {
				alert('검색어를 입력하세요!');
				$('input#title').focus();

				return false;
			}

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
			//location.href='/intro/${homepage.context_path}/search/indexAll.do';
			//$('#title').focus();
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

		$('#checkAllSilip').change(function(e) {
			$('div#libraryList .silipAll input:checkbox').prop('checked', $(this).prop('checked'));
		});

		$('#checkAllGulip').change(function(e) {
			$('div#libraryList .gulipAll input:checkbox').prop('checked', $(this).prop('checked'));
			$('#checkGulipDonggu, #checkGulipSeogu, #checkGulipNamgu, #checkGulipBukgu, #checkGulipJunggu, #checkGulipSuseonggu, #checkGulipDalseogu, #checkGulipDalseong').prop('checked', $(this).prop('checked'));
		});

		$('#checkAllGulipSmall').change(function(e) {
			$('div#libraryList .gulipSmallAll input:checkbox').prop('checked', $(this).prop('checked'));
			$('#checkGulipSmallDonggu, #checkGulipSmallSeogu, #checkGulipSmallNamgu, #checkGulipSmallBukgu, #checkGulipSmallJunggu, #checkGulipSmallSuseonggu, #checkGulipSmallDalseogu, #checkGulipSmallDalseong').prop('checked', $(this).prop('checked'));
		});
		<%--군립도서관 구분--%>
		$('#checkGulipDonggu').change(function (e) {
			$('div.gulipAll input.lib_CA, div.gulipAll input.lib_CB').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSeogu').change(function (e) {
			$('div.gulipAll input.lib_BL, div.gulipAll input.lib_BQ, div.gulipAll input.lib_BP, div.gulipAll input.lib_BM, div.gulipAll input.lib_BN, div.gulipAll input.lib_CC, div.gulipAll input.lib_HT').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipNamgu').change(function (e) {
			$('div.gulipAll input.lib_BT, div.gulipAll input.lib_BS').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipBukgu').change(function (e) {
			$('div.gulipAll input.lib_BA, div.gulipAll input.lib_BB, div.gulipAll input.lib_BC').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipJunggu').change(function (e) {
			$('div.gulipAll input.lib_FS').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSuseonggu').change(function (e) {
			$('div.gulipAll input.lib_BD, div.gulipAll input.lib_BE, div.gulipAll input.lib_BF, div.gulipAll input.lib_BG, div.gulipAll input.lib_BH, div.gulipAll input.lib_BJ, div.gulipAll input.lib_BK, div.gulipAll input.lib_HR, div.gulipAll input.lib_HS').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipDalseogu').change(function (e) {
			$('div.gulipAll input.lib_BU, div.gulipAll input.lib_BV, div.gulipAll input.lib_BW, div.gulipAll input.lib_BX, div.gulipAll input.lib_BY, div.gulipAll input.lib_BZ').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipDalseong').change(function (e) {
			$('div.gulipAll input.lib_BR').prop('checked', $(this).prop('checked'));
		});
		<%--구군립 작은 구분--%>
		$('#checkGulipSmallDonggu').change(function (e) {
			$('div.gulipSmallAll input.lib_GR, div.gulipSmallAll input.lib_GS, div.gulipSmallAll input.lib_HJ, div.gulipSmallAll input.lib_FK, div.gulipSmallAll input.lib_GT, div.gulipSmallAll input.lib_FP, div.gulipSmallAll input.lib_FL, div.gulipSmallAll input.lib_GU, div.gulipSmallAll input.lib_GV, div.gulipSmallAll input.lib_GW, div.gulipSmallAll input.lib_GX, div.gulipSmallAll input.lib_GY, div.gulipSmallAll input.lib_FM, div.gulipSmallAll input.lib_HK, div.gulipSmallAll input.lib_HM, div.gulipSmallAll input.lib_HN, div.gulipSmallAll input.lib_HP').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallSeogu').change(function (e) {
			$('div.gulipSmallAll input.lib_GQ, div.gulipSmallAll input.lib_FU, div.gulipSmallAll input.lib_FZ, div.gulipSmallAll input.lib_FH, div.gulipSmallAll input.lib_FT, div.gulipSmallAll input.lib_HC').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallNamgu').change(function (e) {
			$('div.gulipSmallAll input.lib_FE').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallBukgu').change(function (e) {
			$('div.gulipSmallAll input.lib_GL, div.gulipSmallAll input.lib_GM, div.gulipSmallAll input.lib_GN, div.gulipSmallAll input.lib_HB, div.gulipSmallAll input.lib_HD, div.gulipSmallAll input.lib_HE').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallJunggu').change(function (e) {
			$('div.gulipSmallAll input.lib_FF, div.gulipSmallAll input.lib_FQ, div.gulipSmallAll input.lib_FY, div.gulipSmallAll input.lib_GG, div.gulipSmallAll input.lib_HA, div.gulipSmallAll input.lib_HF').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallSuseonggu').change(function (e) {
			$('div.gulipSmallAll input.lib_FG').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallDalseogu').change(function (e) {
			$('div.gulipSmallAll input.lib_FA, div.gulipSmallAll input.lib_FB, div.gulipSmallAll input.lib_FC, div.gulipSmallAll input.lib_FD, div.gulipSmallAll input.lib_FX, div.gulipSmallAll input.lib_GK').prop('checked', $(this).prop('checked'));
		});
		$('#checkGulipSmallDalseong').change(function (e) {
			$('div.gulipSmallAll input.lib_GA, div.gulipSmallAll input.lib_GB, div.gulipSmallAll input.lib_HG, div.gulipSmallAll input.lib_GD, div.gulipSmallAll input.lib_GF, div.gulipSmallAll input.lib_GH, div.gulipSmallAll input.lib_FR, div.gulipSmallAll input.lib_GE, div.gulipSmallAll input.lib_GC, div.gulipSmallAll input.lib_FN, div.gulipSmallAll input.lib_FJ').prop('checked', $(this).prop('checked'));
		});


		$('a#closeBtn1').on('click', function() {
			if($(".silipAll").css("display") != "none"){
				$(".silipAll").slideUp();
				$("a#closeBtn1").text('열기');
			}
			else
			{
				$(".silipAll").slideDown();
				$("a#closeBtn1").text('닫기');
			}
		});

		$('a#closeBtn2').on('click', function() {
			if($(".gulipAll").css("display") != "none"){
				$(".gulipAll").slideUp();
				$("a#closeBtn2").text('열기');
			}
			else
			{
				$(".gulipAll").slideDown();
				$("a#closeBtn2").text('닫기');
			}
		});

		$('a#closeBtn3').on('click', function() {
			if($(".gulipSmallAll").css("display") != "none"){
				$(".gulipSmallAll").slideUp();
				$("a#closeBtn3").text('열기');
			}
			else
			{
				$(".gulipSmallAll").slideDown();
				$("a#closeBtn3").text('닫기');
			}
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

		$('#meta-search').on('click', function(e) {
			e.preventDefault();
			searchText = $('input#title').val();
			$('#text1').val(searchText);
			$('form#direct').submit();
		});

		<c:if test="${not empty loginPortal and loginPortal.login}">
		<%-- 대표도서관 택배대출 관심도서 --%>
		$('a#interestList').on('click', function(e) {
			e.preventDefault();
			var frm = $('#bookExpressForm');

			if(confirm('택배서비스 관심도서 추가하겠습니까?')) {
				$('input.checkBook:checked').each(function(i) {
					frm.append('<input type="hidden" name="bookExpressList['+i+'].book_name" value="'+$(this).siblings('input#bex1').val()+'">');
					frm.append('<input type="hidden" name="bookExpressList['+i+'].book_reg_no" value="'+$(this).siblings('input#bex2').val()+'">');
					frm.append('<input type="hidden" name="bookExpressList['+i+'].book_call_no" value="'+$(this).siblings('input#bex3').val()+'">');
					frm.append('<input type="hidden" name="bookExpressList['+i+'].thumb_image" value="'+$(this).siblings('input#bex4').val()+'">');
					frm.append('<input type="hidden" name="bookExpressList['+i+'].library_code" value="'+$(this).siblings('input#bex5').val()+'">');
				});
				
				if(doAjaxPost($('#bookExpressForm'))) {
					location.reload();
				}

			}

		});
		</c:if >

		if ('${fn:length(param.libraryCodes)}' == '0' ) {
			$('input#checkAll').click();
		}
	});


</script>

<c:if test="${not empty loginPortal and loginPortal.login}">
	<form id="bookExpressForm" action="/${homepage.context_path}/module/bookExpress/save.do" method="post">
		<input type="hidden" name="editMode" value="INTERESTLIST">
	</form>
</c:if>

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

<form id="direct" name="direct" action="http://152.99.21.156/DG/" method="post" target="_blank">
	<input type="hidden" name="m" value="direct">
	<input type="hidden" name="skey" value="1077">
	<input type="hidden" name="charset" value="utf-8">
	<input type="hidden" name="userid" value="">
	<input type="hidden" name="dbGroup" value="0">
	<input type="hidden" name="text1" id="text1">
</form>

<!-- contents-title-->
<div id="contents-title"></div>
<!-- /contents-title-->

<div class="tab_menu">
	<ul class="list">
		<li class="active">
		  <a href="/${homepage.context_path}/intro/search/indexAll.do?menu_idx=7" class="btn">시립/구·군립 도서관 자료검색</a>
		</li>
		<li>
		  <a href="/${homepage.context_path}/intro/search/index_All.do?menu_idx=7" class="btn">사립공공·전문 도서관 자료검색</a>
		</li>
	</ul>
</div>

<form:form modelAttribute="librarySearch" action="indexAll.do" method="get">
	<form:hidden path="viewPage"/>
	<form:hidden path="menu_idx"/>

	<div class="search-wrap">

		<div class="search-form">

			<!-- 검색하기_일반 -->
			<div class="searchbox detail_search">
				<div class="section">

					<div class="title-box">
						<form:input path="title" class="text-area" placeholder="도서 제목을 입력하세요"/> <a id="search-btn" class="btnNew foreign-inp">검색하기</a>
					</div>

					<div class="main-menu">
						<div class="right">
							<ul>
								<li><a id="vk-popup" class="btnNew2">다국어입력기</a></li>
								<li><a href="javascript:void(0);" id="search_type" class="btnNew2">상세검색</a></li>
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

					<a href="/${homepage.context_path}/intro/search/indexAll.do?menu_idx=7" class="btnNew1">검색초기화</a>
					<a href="javascript:void(0);" id="btn_search_target" class="btnNew5">도서관선택</a>
					<c:if test="${librarySearch.totalDataCount eq 0}"><a href="http://152.99.21.156/DG/index.php/default_search" target="_blank" class="btnNew6">대구광역시 인근 도서관 자료 검색하기</a></c:if>
				</div>


				<div id="libraryList" class="libraryList">
					<div>
						<input id="checkAll" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkAll">전체선택</label>
					</div>

					<div class="title">
						<h4 class="contTit_line_s mg20t" style="padding:5px 0 20px 0;">대구광역시립도서관</h4>
						<a href="#checkAllSilip" class="btn boxviewbtn" id="closeBtn1">닫기</a>
					</div>
					<div>
						<input id="checkAllSilip" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkAllSilip">시립전체</label>
					</div>
					<div class='silipAll'>
						<ul>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AA" value="AA" label="대구2ㆍ28기념학생도서관" />
							</li>
							<c:if test="${empty loginPortal or !loginPortal.login}">
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AL" value="AL" label="대구2ㆍ28민주운동기념회관" />
							</li>
							</c:if>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AG" value="AG" label="대구광역시립 남부도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AJ" value="AJ" label="대구광역시립 달성도서관" />
							</li>
<%--							<li>--%>
<%--								<form:checkbox path="libraryCodes" class="libCheck lib_AH" value="AH" label="대구광역시립 동부도서관" />--%>
<%--							</li>--%>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AB" value="AB" label="대구광역시립 두류도서관" />
							</li>
							<%--<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AC" value="AC" label="대구광역시립 북부도서관" />
							</li>--%>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AF" value="AF" label="대구광역시립 서부도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AE" value="AE" label="대구광역시립 수성도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AD" value="AD" label="국채보상운동기념도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AM" value="AM" label="대구광역시교육청 삼국유사군위도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FV" value="FV" label="시청작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_AK" value="AK" label="학생문화센터" />
							</li>
						</ul>
					</div>
					<div class="end"></div>

					<c:if test="${empty loginPortal or !loginPortal.login}">
					<div class="title">
						<h4 class="contTit_line_s mg20t" style="padding:5px 0 20px 0;">대구광역시 구·군립도서관</h4>
						<a href="#checkAllSilip" class="btn boxviewbtn" id="closeBtn2">닫기</a>
					</div>
					<div>
						<input id="checkAllGulip" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkAllGulip">구립전체</label>
						<input id="checkGulipDonggu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipDonggu">동구</label>
						<input id="checkGulipSeogu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSeogu">서구</label>
						<input id="checkGulipNamgu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipNamgu">남구</label>
						<input id="checkGulipBukgu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipBukgu">북구</label>
						<input id="checkGulipJunggu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipJunggu">중구</label>
						<input id="checkGulipSuseonggu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSuseonggu">수성구</label>
						<input id="checkGulipDalseogu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipDalseogu">달서구</label>
						<input id="checkGulipDalseong" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipDalseong">달성군</label>
					</div>
					<div class='gulipAll'>
						<ul>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_CA" value="CA" label="안심도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_CB" value="CB" label="신천도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BL" value="BL" label="서구어린이도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BQ" value="BQ" label="비산도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BP" value="BP" label="서구영어도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BM" value="BM" label="비원도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BN" value="BN" label="원고개도서관" />
							</li>


							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BT" value="BT" label="이천어울림도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BS" value="BS" label="대명어울림도서관" />
							</li>



							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BA" value="BA" label="구수산도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BB" value="BB" label="대현도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BC" value="BC" label="태전도서관" />
							</li>


							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FS" value="FS" label="대구중구영어도서관" />
							</li>



							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BD" value="BD" label="범어도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BE" value="BE" label="용학도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BF" value="BF" label="고산도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BG" value="BG" label="파동도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BH" value="BH" label="무학숲도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BJ" value="BJ" label="책숲길도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BK" value="BK" label="물망이도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HR" value="HR" label="황금책문화센터" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HS" value="HS" label="수성못그림책도서관" />
							</li>



							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BU" value="BU" label="성서도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BV" value="BV" label="달서어린이도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BW" value="BW" label="도원도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BX" value="BX" label="본리도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BY" value="BY" label="달서가족문화도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BZ" value="BZ" label="달서영어도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_BR" value="BR" label="달성군립도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_CC" value="CC" label="New평리도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HT" value="HT" label="서구어린이영어도서관" />
							</li>


						</ul>
					</div>
					<div class="end"></div>


					<div class="title">
						<h4 class="contTit_line_s mg20t" style="padding:5px 0 20px 0;">대구광역시 구·군립 작은도서관</h4>
						<a href="#checkAllSilip" class="btn boxviewbtn" id="closeBtn3">닫기</a>
					</div>
					<div>
						<input id="checkAllGulipSmall" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkAllGulipSmall">구립작은전체</label>
						<input id="checkGulipSmallDonggu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallDonggu">동구</label>
						<input id="checkGulipSmallSeogu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallSeogu">서구</label>
						<input id="checkGulipSmallNamgu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallNamgu">남구</label>
						<input id="checkGulipSmallBukgu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallBukgu">북구</label>
						<input id="checkGulipSmallJunggu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallJunggu">중구</label>
						<input id="checkGulipSmallSuseonggu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallSuseonggu">수성구</label>
						<input id="checkGulipSmallDalseogu" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallDalseogu">달서구</label>
						<input id="checkGulipSmallDalseong" name="libraryCodes" type="checkbox" value="ALL" /><label for="checkGulipSmallDalseong">달성군</label>
					</div>
					<div class='gulipSmallAll'>
						<ul>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GR" value="GR" label="신암2동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GS" value="GS" label="신암3동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HJ" value="HJ" label="신암5동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FK" value="FK" label="신천3동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GT" value="GT" label="효목1동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FP" value="FP" label="효목2동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FL" value="FL" label="도평동 작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GU" value="GU" label="불로어울림작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GV" value="GV" label="지저동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GW" value="GW" label="동촌역사작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GX" value="GX" label="방촌동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GY" value="GY" label="해안동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FM" value="FM" label="반야월역사작은도서관" />
							</li>

							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HK" value="HK" label="늘푸른작은도서관" />
							</li>
							<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
							<%-- <li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HL" value="HL" label="초록우산작은도서관" />
							</li> --%>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HM" value="HM" label="꿈날자문고작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HN" value="HN" label="행복작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HP" value="HP" label="율하5주민작은도서관" />
							</li>


							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GQ" value="GQ" label="내당2,3동 드림도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FU" value="FU" label="내당4동어린이도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FZ" value="FZ" label="비산7동 작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FH" value="FH" label="새마을문고대구서구지부작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FT" value="FT" label="서구청작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HC" value="HC" label="달성토성마을 다락방 작은도서관" />
							</li>



							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FE" value="FE" label="꿈틀작은도서관" />
							</li>



							<!-- <li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GJ" value="GJ" label="태전1동 작은도서관" />
							</li> -->
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GL" value="GL" label="산격1동 작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GM" value="GM" label="북구영어작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GN" value="GN" label="침산1동 작은도서관" />
							</li>
<!-- 							<li> -->
<%-- 								<form:checkbox path="libraryCodes" class="libCheck lib_GP" value="GP" label="노원동 작은도서관" /> --%>
<!-- 							</li> -->
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HB" value="HB" label="서변동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HD" value="HD" label="노원행복도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HE" value="HE" label="한강공원부키도서관" />
							</li>



							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FF" value="FF" label="남산4동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FQ" value="FQ" label="동인 느티나무 도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FY" value="FY" label="중구청교양정보실" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GG" value="GG" label="대신동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HA" value="HA" label="삼덕마루 작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HF" value="HF" label="대봉2동작은도서관" />
							</li>






							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FG" value="FG" label="사월책문화센터" />
							</li>





							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FA" value="FA" label="이곡2동공립작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FB" value="FB" label="용산1동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FC" value="FC" label="장기동작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FD" value="FD" label="죽전동공립작은도서관" />
							</li>
							<!--<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FW" value="FW" label="달서아트센터 도서관" />
							</li>-->
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FX" value="FX" label="행정정보문고센터" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GK" value="GK" label="학산작은도서관" />
							</li>




							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GA" value="GA" label="화원읍작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GB" value="GB" label="논공읍작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HG" value="HG" label="다사읍작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GD" value="GD" label="다사읍서재작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GF" value="GF" label="유가읍작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GH" value="GH" label="옥포읍작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FR" value="FR" label="가창면참꽃작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GE" value="GE" label="하빈면작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_GC" value="GC" label="구지면작은도서관" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FN" value="FN" label="달성군청소년센터" />
							</li>
							<li>
								<form:checkbox path="libraryCodes" class="libCheck lib_FJ" value="FJ" label="달성군청도서관" />
							</li>
							<!-- <li>
								<form:checkbox path="libraryCodes" class="libCheck lib_HC" value="HC" label="달성토성마을 다락방 작은도서관" />
							</li> -->

						</ul>
					</div>
					<div class="end"></div>
					</c:if>
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

				<div class="" style="position:relative;overflow:hidden;padding-top:5px;">
					<div class="research-box">
						<select id="subSearchType" class="text-area01">
							<option value="title">서명</option>
							<option value="author">저자</option>
							<option value="publer">발행처</option>
							<option value="keyword">키워드</option>
						</select>
						<input id="subSearchText" placeholder="결과 내 재검색" class="text-area01" />
						<a href="#" id="subSearch" class="btn">결과 내 재검색</a>
						<c:if test="${not empty loginPortal and loginPortal.login}">
							<a href="#" id="interestList" class="btn">교수학습 관심도서</a>
						</c:if>
					</div>

					<div class="gugun-search">
						<!-- <a href="#gugunsearch" id="meta-search" class="btn btn8">더 많은 검색결과를 원하십니까?</a> -->
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
									<c:set var="detailURL" value="detail.do?&menu_idx=7&isbn=${i.ISBN}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(i.MEDIA_CODE eq 'PR' ? 'BOOK' : 'NONBOOK')}"></c:set>
									<div class="row">
										<p class="admin">
											<input name="print_param" type="checkbox" class="checkBook" value="${fn:escapeXml(i.ISBN)}_${fn:escapeXml(i.MANAGE_CODE)}"/>
											<c:if test="${not empty loginPortal and loginPortal.login}">
												<input type="hidden" id="bex1" value="${i.TITLE_INFO} / ${i.AUTHOR}">
												<input type="hidden" id="bex2" value="${i.REG_NO}">
												<input type="hidden" id="bex3" value="${i.CALL_NO}">
												<input type="hidden" id="bex4" value="${i.aladin.cover}">
												<input type="hidden" id="bex5" value="${i.LIB_CODE}">
											</c:if>
										</p>
										<div class="thumb">
											<c:choose>
												<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
													<a href="${detailURL}" class="noImg">
														<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${i.TITLE_INFO}"/>
													</a>
												</c:when>
												<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
													<a href="${detailURL}">
														<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}"/>
													</a>
												</c:when>
												<c:otherwise>
													<a href="${detailURL}">
														<img src="${i.imageUrl}" alt="${i.TITLE_INFO}"/>
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
													<c:if test="${i.SHELF_LOC_CODE ne 'AD36'}">
													<p><font style="color:#5e5e5e">대출가능여부</font> :
													<!-- 대출가능 여부 [START] -->
													<c:choose>
														<c:when test="${i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HQ'}">
															<span style="color:#ff0000">대출불가(임시휴관)</span>
														</c:when>
														<c:when test="${i.MANAGE_CODE eq 'FG'}">
															<span style="color:#ff0000">대출불가</span>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${i.LOAN_CODE eq 'OK'}">
																	대출가능
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
													<!-- 대출가능 여부 [ END ] -->
													</p>
													</c:if>
													<!--
                                                    JU : 아동, MS : 중학생, AD : 성인, PU : 일반, ES : 초등, HS : 고등, SP : 특수, TE : 청소년, 기타 :
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
															<c:when test="${i.USE_OBJECT_CODE eq 'TE'}">
																<span style="">청소년</span>
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

														<!-- 상호대차 -->
														<c:if test="${i.LOAN_CODE eq 'OK'}">
															<c:choose>
																<c:when test="${homepage.context_path eq 'dgportal'}">
																	<c:choose>
																		<c:when test="${i.MANAGE_CODE eq 'BA'  || i.MANAGE_CODE eq 'BB' || i.MANAGE_CODE eq 'BC' || i.MANAGE_CODE eq 'GN' || i.MANAGE_CODE eq 'HB' || i.MANAGE_CODE eq 'HD' || i.MANAGE_CODE eq 'HE' || i.MANAGE_CODE eq 'GL' || i.MANAGE_CODE eq 'GM' || i.MANAGE_CODE eq 'BD'  || i.MANAGE_CODE eq 'BE' || i.MANAGE_CODE eq 'BF' || i.MANAGE_CODE eq 'BG' || i.MANAGE_CODE eq 'BH' || i.MANAGE_CODE eq 'BJ' || i.MANAGE_CODE eq 'BK' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'HR' || i.MANAGE_CODE eq ''  || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'BX' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'FA' || i.MANAGE_CODE eq 'FB' || i.MANAGE_CODE eq 'FC' || i.MANAGE_CODE eq 'GK' || i.MANAGE_CODE eq '' || i.MANAGE_CODE eq 'BZ' || i.MANAGE_CODE eq 'CA' || i.MANAGE_CODE eq 'CB' || i.MANAGE_CODE eq 'GA' || i.MANAGE_CODE eq 'GB' || i.MANAGE_CODE eq 'GC' || i.MANAGE_CODE eq 'GD' || i.MANAGE_CODE eq 'GE' || i.MANAGE_CODE eq 'GF' || i.MANAGE_CODE eq 'GH' || i.MANAGE_CODE eq 'FJ' || i.MANAGE_CODE eq 'FN' || i.MANAGE_CODE eq 'HG' || i.MANAGE_CODE eq 'GX' || i.MANAGE_CODE eq 'GY' || i.MANAGE_CODE eq 'FM' || i.MANAGE_CODE eq 'HK' || i.MANAGE_CODE eq 'HM' || i.MANAGE_CODE eq 'HN' || i.MANAGE_CODE eq 'HP' || i.MANAGE_CODE eq 'HQ' || i.MANAGE_CODE eq 'BL' || i.MANAGE_CODE eq 'BQ' || i.MANAGE_CODE eq 'BP' || i.MANAGE_CODE eq 'BM' || i.MANAGE_CODE eq 'BN'}">
																			<c:if test="${i.KBILL_LILL_YN eq 'O'}">
																				<a href="" class="btn btn3 sangho" bookkey="${i.BOOK_KEY}" booktype="BO" isbn="${i.ISBN}" regNo="${i.REG_NO}" manageCode="${i.MANAGE_CODE}"><span>상호대차 신청</span></a>
																			</c:if>
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
																<c:when test="${i.MANAGE_CODE eq 'AC'}">
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

														<!--내집앞도서관-->
														<c:if test="${i.LOAN_CODE eq 'OK'}">
															<c:if test="${homepage.context_path eq 'dgportal' || homepage.context_path eq '228' || homepage.context_path eq 'dongbu' || homepage.context_path eq 'donggu' || homepage.context_path eq 'bukgs'}">
																<c:if test="${i.MANAGE_CODE eq 'BA' || i.MANAGE_CODE eq 'AH' || i.MANAGE_CODE eq 'CB' || i.MANAGE_CODE eq 'AA' || i.MANAGE_CODE eq 'CA'}">
																	<c:if test="${reserveData == 0 and reserveAvailability eq 'Y'}">
																	<c:if test="${i.SHELF_LOC_CODE ne 'AA02' and i.SHELF_LOC_CODE ne 'AA03' and i.SHELF_LOC_CODE ne 'AA05' and i.SHELF_LOC_CODE ne 'AA07' and i.SHELF_LOC_CODE ne 'AA09' and i.SHELF_LOC_CODE ne 'AA10' and i.SHELF_LOC_CODE ne 'AA11' and i.SHELF_LOC_CODE ne 'AA14' and i.SHELF_LOC_CODE ne 'AA15' and i.SHELF_LOC_CODE ne 'AA16' and i.SHELF_LOC_CODE ne 'AA17' and i.SHELF_LOC_CODE ne 'AA18' and i.SHELF_LOC_CODE ne 'AA19' and i.SHELF_LOC_CODE ne 'AA20' and i.SHELF_LOC_CODE ne 'AA21' and i.SHELF_LOC_CODE ne 'AA22' and  i.SHELF_LOC_CODE ne 'AA23' and i.SHELF_LOC_CODE ne 'AA29' and i.SHELF_LOC_CODE ne 'AA30' and i.SHELF_LOC_CODE ne 'AA31' and i.SHELF_LOC_CODE ne 'AA36' and i.SHELF_LOC_CODE ne 'AA37' and i.SHELF_LOC_CODE ne 'AA39' and i.SHELF_LOC_CODE ne 'AA40' and i.SHELF_LOC_CODE ne 'AA41' and i.SHELF_LOC_CODE ne 'AA51' and i.SHELF_LOC_CODE ne 'AA52' and i.SHELF_LOC_CODE ne 'AA53' and i.SHELF_LOC_CODE ne 'AA56' and i.SHELF_LOC_CODE ne 'AA58' and i.SHELF_LOC_CODE ne 'AA59' and i.SHELF_LOC_CODE ne 'AA60' and i.SHELF_LOC_CODE ne 'AA62' and i.SHELF_LOC_CODE ne 'AA65' and i.SHELF_LOC_CODE ne 'AA66' and i.SHELF_LOC_CODE ne 'AH14' and i.SHELF_LOC_CODE ne 'AH16' and i.SHELF_LOC_CODE ne 'AH26' and i.SHELF_LOC_CODE ne 'AH33' and i.SHELF_LOC_CODE ne 'AH60' and i.SHELF_LOC_CODE ne 'CA08' and i.SHELF_LOC_CODE ne 'CB08' and i.SHELF_LOC_CODE ne 'CB10' and i.SHELF_LOC_CODE ne 'BA08' and i.SHELF_LOC_CODE ne 'BA22' and i.SHELF_LOC_CODE ne 'BA23' and i.SHELF_LOC_CODE ne 'CA18'}">
																		<c:choose>
																			<c:when test="${not empty nearbylibRejectMessage}">
																				<a href="javascript:void(0);" class="btn btn1" onclick="alert('${nearbylibRejectMessage}')">내 집 앞 도서관 예약</a>
																			</c:when>
																			<c:otherwise>
																				<a href="" class="btn btn1 neighborhoodLibrary-req" bookkey="${i.BOOK_KEY}" booktype="BO" regNo="${i.REG_NO}" managecode="${i.MANAGE_CODE}" isbn="${i.ISBN}" title_info="${i.TITLE_INFO}" lib_name="${i.LIB_NAME}" call_no="${i.CALL_NO}" author="${i.AUTHOR}">내 집 앞 도서관 예약</a>
																			</c:otherwise>
																		</c:choose>
																	</c:if>
																	</c:if>
																</c:if>
															</c:if>
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
<%--													<th>자료위치<br class="mBr"/>인쇄</th>--%>
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
															<c:when test="${i.MANAGE_CODE eq 'FG'}">
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
<%--													<td>--%>
<%--														<a href="#" class="btn_print" data-param="${detailURL}" class="btn btn2">자료위치<br/>인쇄</a>--%>
<%--													</td>--%>
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