
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" href="/resources/common/css/search/jqcloud.css" type="text/css">
<script type="text/javascript" src="/resources/common/js/jqcloud.js"></script>
<script type="text/javascript">
$(function() {

	$('a#resve-req').on('click', function(e) {
		e.preventDefault();
		<c:choose>
		<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'HOMEPAGE'}">
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}
		if ( doAjaxPost($('#resveReqForm')) ) {
			location.reload();
		}
		</c:when>
		<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'PRIVATEHOMEPAGE'}">
		if (!confirm('예약 신청 하시겠습니까?')) {
			return false;
		}
		if ( doAjaxPost($('#resveReqForm')) ) {
			location.reload();
		}
		</c:when>
		<c:otherwise>
		alert('로그인 후 이용 가능합니다.');
		location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&before_url='+encodeURIComponent(location.href);
		</c:otherwise>
		</c:choose>

	});
	
	<%-- 내집앞도서관 대출 신청 --%>	
	$('a#neighborhoodLibrary-req').on('click',function(e){
		e.preventDefault();
		$('form#neighborhoodLibrary').submit();
	});

	<%-- 비대면 도서대출 신청 --%>
	$('a#untactBook-req').on('click', function(e) {
		e.preventDefault();
		$('form#untactBookReqForm').submit();
	});

	<%-- 워킹스루 도서대출 신청 --%>
	$('a#walkingThru-req').on('click', function(e) {
		e.preventDefault();
		$('form#walkingThruReqForm').submit();
	});

	<%-- 무인대출예약 신청 --%>
	$('a#unmanned-req').on('click', function(e) {
		e.preventDefault();
		$('form#unmannedReqForm').submit();
	});

	<%-- 달서구립도서관 무인대출예약 신청 --%>
	$('a#dalseo-unmanned-req').on('click', function(e) {
		e.preventDefault();

		modal_layer_add('dialog_layer');

		$.ajax({
			url: 'popup.do',
			method: 'GET',
			success: function(html){
				$('#dialog_layer').html(html);
			},error: function(html){
			}
		});

		$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
			resizable: false,
			modal: true,
			title: '무인예약신청 주의사항 안내',
			open: function(){
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function(){
			},
			buttons: [
				{
					text : '예',
					'class' : 'btn btn1',
					click : function() {
						$('form#unmannedReqForm').submit();
					}
				},
				{
					text: "아니오",
					"class": 'btn btn_round btn_gray',
					click: function() {
						$(this).dialog('close');
					}
				}
			]
		});

		$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
			width: 600,
			height: 360
		});
// 		$('form#unmannedReqForm').submit();
	});

	<%-- 야간대출예약 신청 --%>
	$('a#night-req').on('click', function(e) {
		e.preventDefault();
		$('form#nightReqForm').submit();
	});

	<%-- 야간대출예약 신청제한 --%>
	$('a#service-noreq').on('click', function(e) {
		e.preventDefault();
		alert('비대면인증 회원은 서비스 이용이 불가능 하며 전자도서관만 이용가능 합니다.');
		return;
	});

	$('a#addStorage').on('click', function(e) {
		e.preventDefault();
		/* if ( doAjaxPost($('storageReqForm')) ) {

		} */

		window.open("/${homepage.context_path}/module/myStorage/viewStorage.do?"+serializeCustom($('#storageReqForm')), "", "width=450, height=400");
	});

	$('a.addDelivery').on('click', function(e) {
		e.preventDefault();

	});

	$('a#drone-lone-req').on('click',function(e) {
		e.preventDefault();
		<c:choose>
		<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'HOMEPAGE'}">
		$('form#droneReqForm').submit();
		</c:when>
		<c:when test="${sessionScope.member.login and sessionScope.member.loginType eq 'PRIVATEHOMEPAGE'}">
		$('form#droneReqForm').submit();
		</c:when>
		<c:otherwise>
		alert('로그인 후 이용 가능합니다.');
		location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&before_url='+encodeURIComponent(location.href);
		</c:otherwise>
		</c:choose>
	})


	<%--상호대차 신청--%>
	$('a.sangho').on('click', function(e) {
		e.preventDefault();

		<c:if test="${detail.BOOK_STATUS eq '0'}">
		alert('대출중인도서는 상호대차 신청이 불가능합니다.');
		</c:if>
		<c:if test="${detail.BOOK_STATUS ne '0'}">
		$('form#sanghoReqForm').submit();
		</c:if>
	});

	try {
		var words = JSON.parse('${data4ItemList}');
		$('#cloud').jQCloud(words, {
			autoResize: true
		});
	} catch (e) {
		// TODO: handle exception
	}

	<c:if test="${not empty loginPortal and loginPortal.login}">
	<%-- 대표도서관 택배대출 관심도서 --%>
	$('#interest').on('click', function(e) {
		e.preventDefault();
		if(confirm('택배서비스 관심도서 추가하겠습니까?')) {
			doAjaxPost($('#bookExpressForm'));
		}
	});
	</c:if >

	if (document.referrer.indexOf('/intro/search/index.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}

	if (document.referrer.indexOf('/intro/search/indexAll.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}

	if (document.referrer.indexOf('/intro/search/newBook/index.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}

	if (document.referrer.indexOf('/intro/search/bestBook/index.do') > -1) {
		$('a#goBack').on('click', function(e) {
			e.preventDefault();
			history.back();
		});
	}
 	//$('div#bookReviewDiv').load('/${homepage.context_path}/module/bookReview/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}&manage_code=${fn:escapeXml(detail.MANAGE_CODE)}&reg_no=${fn:escapeXml(detail.REG_NO)}');

	$('a.booksearchdgportal').on('click', function(e) {
		e.preventDefault();

		var txt = $(this).data('roll');
		$('input#search_text_2').val(txt);
		$('form#dgportalSearchForm').submit();
	});
});

</script>

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

<form id="storageReqForm" action="/${homepage.context_path}/module/myStorage/saveItem.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" id="itemEditMode" name="editMode" value="ADD">
	<input type="hidden" id="item_name" name="item_name" value="${detail.TITLE_INFO}">
	<input type="hidden" id="author" name="author" value="${detail.AUTHOR}">
	<input type="hidden" id="publer" name="publer" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" id="loca" name="loca" value="${detail.MANAGE_CODE}">
	<input type="hidden" id="ctrl_no" name="ctrl_no" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" id="call_no" name="call_no" value="${fn:escapeXml(detail.CALL_NO)}">
	<input type="hidden" id="img_url" name="img_url" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="resveReqForm" action="resve/save.do" method="post" onsubmit="return false;">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" id="reserveMode" name="editMode" value="ADD">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:startsWith(detail.WORKING_STATUS, 'BO') ? 'BO' : 'SE'}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(detail.MANAGE_CODE)}">
</form>

<form id="untactBookReqForm" action="/${homepage.context_path}/module/untactBook/form.do" method="post">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${detail.REG_NO}">
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

<form id="nightReqForm" action="night/form.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="basketReqForm" action="/${homepage.context_path}/intro/search/saveDeliveryBasket.do">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" id="book_key" name="book_key">
	<input type="hidden" name="editMode" value="ADD">
</form>

<form id="droneReqForm" action="drone/req.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
	<input type="hidden" name="book_name" value="${fn:escapeXml(detail.TITLE_INFO)}">
	<input type="hidden" name="author" value="${fn:escapeXml(detail.AUTHOR)}">
</form>


<form id="sanghoReqForm" action="sangho/form.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="isbn" value="${fn:escapeXml(param.isbn)}">
	<input type="hidden" name="regNo" value="${fn:escapeXml(param.regNo)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>

<form id="walkingThruReqForm" action="/${homepage.context_path}/module/walkingThru/form.do" method="post">
	<input type="hidden" name="bookkey" value="${fn:escapeXml(detail.BOOK_KEY)}">
	<input type="hidden" name="booktype" value="${fn:escapeXml(param.booktype)}">
	<input type="hidden" name="regNo" value="${detail.REG_NO}">
	<input type="hidden" name="manageCode" value="${fn:escapeXml(param.manageCode)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(param.menu_idx)}">
</form>

<c:if test="${not empty loginPortal and loginPortal.login}">
<form id="bookExpressForm" action="/${homepage.context_path}/module/bookExpress/save.do" method="post">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" name="editMode" value="INTEREST">
	<input type="hidden" name="book_name" value="${detail.TITLE_INFO} / ${detail.AUTHOR}">
	<input type="hidden" name="book_reg_no" value="${detail.REG_NO}">
	<input type="hidden" name="book_call_no" value="${detail.CALL_NO}">
	<input type="hidden" name="thumb_image" value="${detail.IMAGE}">
	<input type="hidden" name="library_code" value="${detail.LIB_CODE}">
</form>
</c:if>

<form id="dgportalSearchForm" action="/dgportal/intro/search/indexAll.do" target="_blank">
<input type="hidden" name="menu_idx" value="7">
<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
<input type="hidden" name="libraryCodes" class="libCheck lib_AA" value="AA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AL" value="AL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AG" value="AG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AJ" value="AJ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AH" value="AH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AB" value="AB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AC" value="AC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AF" value="AF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AE" value="AE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AD" value="AD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_CA" value="CA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_CB" value="CB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BL" value="BL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BQ" value="BQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BP" value="BP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BM" value="BM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BN" value="BN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BT" value="BT"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BS" value="BS"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BA" value="BA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BB" value="BB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BC" value="BC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FS" value="FS"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BD" value="BD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BE" value="BE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BF" value="BF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BG" value="BG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BH" value="BH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BJ" value="BJ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BK" value="BK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BU" value="BU"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BV" value="BV"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BW" value="BW"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BX" value="BX"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BY" value="BY"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BZ" value="BZ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_BR" value="BR"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GR" value="GR"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GS" value="GS"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HJ" value="HJ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FK" value="FK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GT" value="GT"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FP" value="FP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FL" value="FL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GU" value="GU"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GV" value="GV"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GW" value="GW"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GX" value="GX"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GY" value="GY"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FM" value="FM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HK" value="HK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HM" value="HM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HN" value="HN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HP" value="HP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HQ" value="HQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GQ" value="GQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FU" value="FU"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FZ" value="FZ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FH" value="FH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FT" value="FT"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HC" value="HC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FE" value="FE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GL" value="GL"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GM" value="GM"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GN" value="GN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GP" value="GP"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HB" value="HB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HD" value="HD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HE" value="HE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FF" value="FF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FQ" value="FQ"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FY" value="FY"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GG" value="GG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HA" value="HA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HF" value="HF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FV" value="FV"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FG" value="FG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FA" value="FA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FB" value="FB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FC" value="FC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FD" value="FD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FX" value="FX"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GK" value="GK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_AK" value="AK"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GA" value="GA"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GB" value="GB"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_HG" value="HG"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GD" value="GD"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GF" value="GF"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GH" value="GH"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FR" value="FR"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GE" value="GE"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_GC" value="GC"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FN" value="FN"/>
<input type="hidden" name="libraryCodes" class="libCheck lib_FJ" value="FJ"/>
<input type="hidden" name="title" id="search_text_2"/>
</form>

<!-- contents-title-->
<div id="contents-title">
	<h2>도서의 상세 내용<span style="font-weight:300">을 확인하세요</span></h2>
</div>
<!-- /contents-title-->

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="search-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<c:choose>
					<c:when test="${(empty detail.aladin or empty detail.aladin.cover) and empty detail.imageUrl}">
				<p class="noImg">
					<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="noImage"/>
				</p>
					</c:when>
					<c:when test="${not empty detail.aladin or not empty detail.aladin.cover}">
						<img src="${detail.aladin.cover}" alt="${detail.TITLE_INFO}">
					</c:when>
					<c:otherwise>
				<p>
					<img src="${detail.imageUrl}" alt="${detail.TITLE_INFO}">
				</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>
					<li style="line-height: 150%;font-size:20px;"><b>${detail.TITLE_INFO}</b></li>
					<li><strong>저자사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.AUTHOR}</li>
					<li><strong>발행사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PUBLISHER}, ${detail.PUB_YEAR},  ${detail.MEDIA_NAME}, \ ${detail.PRICE}</li>
					<li><strong>형태사항</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.PAGE} : ${detail.BOOK_SIZE}</li>
					<c:if test="${detail.MEDIA_CODE eq 'PR' || detail.MEDIA_CODE eq 'EB'}">
					<li><strong>표준부호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ISBN : ${detail.ISBN}</li>
					</c:if>
					<li><strong>분류기호</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;한국십진분류법 : ${detail.CLASS_NO}</li>
					<c:if test="${not empty detail.APPENDIX_INFO}">
					<c:if test="${detail.APPENDIX_LIST[0].LOAN_CODE eq 'OK'}">
					<li><strong>부록여부</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.APPENDIX_INFO[0].DESCRIPTION} (${detail.APPENDIX_INFO[0].APPENDIX_CNT}개)</li>
					</c:if>
					</c:if>
					<c:if test="${not empty detail.marc and (homepage.context_path eq 'dalseolib' || homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj')}">
					<li><strong>영어독서 레벨</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${detail.marc}</li>
					</c:if>
					<c:if test="${detail.MANAGE_CODE eq 'NA' || detail.MANAGE_CODE eq 'NB' || detail.MANAGE_CODE eq 'NE' || detail.MANAGE_CODE eq 'NJ'}">
					<p><font style="color:#f31d1d;font-weight:bold;">★ 해당 도서는 도서관 사정에 따른 유료회원제 자료입니다.</font></p>
					</c:if>
				</ul>
			</div>
		</div>
		<c:if test="${detail.SHELF_LOC_CODE eq 'AD36'}">
			* 소장위치가 대구전자도서관인 경우, 실시간 대출가능 확인이 어렵습니다. 정확한 대출가능여부 확인은 대구전자도서관에 접속 대출가능 확인이 가능합니다.
		</c:if>
		<div class="bookDetailInfo">
			<table class="bookDetailInfoTbl">
			<caption>도서 상태 및 등록 정보</caption>
			<colgroup>
				<col width="20%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
				<c:if test="${detail.SHELF_LOC_CODE ne 'AD36'}">
				<col width="20%">
				</c:if>
			</colgroup>
			<thead>
			<tr>
				<th>청구기호</th>
				<th>등록번호</th>
				<th>자료실</th>
				<th>반납예정일</th>
				<c:if test="${detail.SHELF_LOC_CODE ne 'AD36'}">
				<th>대출상태</th>
				</c:if>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>${detail.CALL_NO}</td>
				<td>${detail.REG_NO}</td>
				<td>${detail.SHELF_LOC_NAME}</td>
				<td>${detail.RETURN_PLAN_DATE}</td>
				<c:if test="${detail.SHELF_LOC_CODE ne 'AD36'}">
				<td>

					<!-- 대출가능 여부 [START] -->
					<c:choose>
						<c:when test="${homepage.context_path eq 'yonghak' and droneLoanYn eq 'Y'}">
							<span style="color:#ff0000">대출불가(드론대출중)</span>
						</c:when>
						<c:when test="${detail.MANAGE_CODE eq 'HM' || detail.MANAGE_CODE eq 'HQ'}">
							<span style="color:#ff0000">대출불가(임시휴관)</span>
						</c:when>
						<c:when test="${detail.MANAGE_CODE eq 'FG' and detail.SHELF_LOC_CODE ne 'FG07'}">
							<span style="color:#ff0000">대출불가</span>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.LOAN_CODE eq 'OK' and detail.MEDIA_NAME eq 'DVD' and detail.MANAGE_CODE eq 'BR'}">
									관내대출가능
								</c:when>
								<c:when test="${detail.LOAN_CODE eq 'OK'}">
									대출가능
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${detail.WORKING_STATUS == 'BOL211O'}">
											<c:choose>
												<c:when test="${detail.MEDIA_NAME eq 'DVD' and detail.MANAGE_CODE eq 'BR'}">
													<span style="color:#ff0000">대출불가(관내대출중)</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ff0000">대출불가(관외대출중)</span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL213O'}">
											<c:choose>
												<c:when test="${detail.MEDIA_NAME eq 'DVD' and detail.MANAGE_CODE eq 'BR'}">
													<span style="color:#ff0000">대출불가(관내대출중)</span>
												</c:when>
												<c:otherwise>
													<span style="color:#ff0000">대출불가(관외대출중)</span>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL212O'}">
											<span style="color:#ff0000">대출불가(관내대출중)</span>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL511O'}">
											<span style="color:#ff0000">대출불가(타관반납중)</span>
										</c:when>
										<c:when test="${detail.WORKING_STATUS == 'BOL611O'}">
											<span style="color:#ff0000">대출불가(타관대출중)</span>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${detail.RESERVATION_CNT > 0}">
													<span style="color:#ff0000">대출불가(예약대출 대기중)</span>
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

				</td>
				</c:if>
			</tr>
			</tbody>
			</table>
		</div>

		<c:if test="${detail.SHELF_LOC_CODE eq 'BC03' || detail.SHELF_LOC_CODE eq 'BC05' || detail.SHELF_LOC_CODE eq 'BC06'}">
		<div class="" style="margin:20px 0;text-align:center;font-size:14px;font-weight:bold;color:red;">
			※ 이관도서는 공동 보존서고에 보관중이므로 당일 대출 불가, 사전 신청을 통해 대출 가능합니다.<br>신청 및 문의 (☎ 053-320-5184/5188)
		</div>
		</c:if>

		<c:if test="${detail.SHELF_LOC_CODE eq 'BB03'}">
		<div class="" style="margin:20px 0;text-align:center;font-size:14px;font-weight:bold;color:red;">
			※ 보존서고 도서는 폐가제로 운영됩니다. &nbsp;대출 관련은 담당자에게 문의바랍니다. (☎ 053-320-5174)
		</div>
		</c:if>

		<c:if test="${detail.SHELF_LOC_CODE eq 'BN13'}">
		<div class="" style="margin:20px 0;text-align:center;font-size:14px;font-weight:bold;color:red;">
			※ 서대구역 스마트도서관에서만 이용 가능합니다.
		</div>
		</c:if>

		<c:if test="${detail.SHELF_LOC_CODE eq 'BT10'}">
		<div class="" style="margin:20px 0;text-align:center;font-size:14px;font-weight:bold;color:red;">
			※ 남구 스마트 도서관에서 대출 하실 수 있습니다. [남구 효성로 37 (경일여자고등학교 정문 옆)]
		</div>
		</c:if>

		<c:if test="${detail.SHELF_LOC_CODE eq 'BU11'}">
		<div class="" style="margin:20px 0;text-align:center;font-size:14px;font-weight:bold;color:red;">
			※ 강창역스마트도서관 도서는 무인예약, 상호대차, 일반예약이 불가하며 스마트도서관 기기에서의 대출반납만 가능합니다.
		</div>
		</c:if>

		<div style="margin-top:20px;">
			<c:set var="getIp" value="<%=request.getRemoteAddr()%>" />

			<c:if test="${getIp eq '218.48.151.16' || getIp eq '14.46.149.38' || getIp eq '0:0:0:0:0:0:0:1'}">
			<ul class="con">
				<li style="background:none;">
					<ul>
						<li>KBILL_LILL_YN : ${detail.KBILL_LILL_YN} </li>
						<li>SHELF_LOC_CODE : ${detail.SHELF_LOC_CODE} </li>
						<li>SEPARATE_SHELF_CODE : ${detail.SEPARATE_SHELF_CODE} </li>
						<li>REG_CODE : ${detail.REG_CODE}</li>
						<li>LOAN_CODE : ${detail.LOAN_CODE}</li>
						<li>RESERVE_CODE : ${detail.RESERVE_CODE}</li>
						<li>CONTEXT_PATH : ${homepage.context_path}</li>
						<li>MANAGE_CODE : ${detail.MANAGE_CODE}</li>
						<li>reserveData : ${reserveData}</li>
						<li>reserveAvailability : ${reserveAvailability}</li>
					</ul>
				</li>
			</ul>
			</c:if>
		</div>

		 <c:if test="${detail.MANAGE_CODE eq 'FX'}">
			<p style="color:#ff0000;font-weight:bold;text-align:center;">
				<!-- * 행정정보문고센터가 휴관으로 인해 상호대차 신청 중지(24.08.28 ~ 24.08.30)되오니, 많은 양해 부탁드립니다. -->
			</p>
		</c:if> 

		<c:if test="${detail.MANAGE_CODE eq ''}">
			<p style="color:#ff0000;font-weight:bold;text-align:center;">
				* 성서도서관 장서점검으로 인한 상호대차 및 무인예약 신청 중지(6/3~6/19)를 안내드리오니, 양해 바랍니다.(성서도서관 소장자료만 해당)
			</p>
		</c:if>
		
		<c:if test="${detail.MANAGE_CODE eq 'AC'}">
			<p style="color:#ff0000;font-weight:bold;text-align:center;">
				* 도서관 리모델링 공사에 따른 도서 예약 서비스 불가<br>
				- 기간 : 2024.08.22.(목) ~ 개관 전까지
			</p>
		</c:if>

		<p></p>


		<div class="sbtn" style="text-align:center;">
			<c:if test="${detail.SANGHO_REQ_YN eq 'Y'}">
			<!-- <a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a> -->
			</c:if>

			<c:if test="${detail.LOAN_CODE eq 'OK'}">
			<!-- 북구통합도서관 상호대차 설정시작-->
			<c:choose>
				<c:when test="${homepage.context_path eq 'bukgs' || homepage.context_path eq 'bukdh' || homepage.context_path eq 'buktj'}">
					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'GJ'}">
						<!--   제외 -->
						</c:when>
						<c:when test="${detail.MANAGE_CODE eq 'BA'  || detail.MANAGE_CODE eq 'BB' || detail.MANAGE_CODE eq 'BC' || detail.MANAGE_CODE eq 'GN' || detail.MANAGE_CODE eq 'GP' || detail.MANAGE_CODE eq 'HB' || detail.MANAGE_CODE eq 'HD' || detail.MANAGE_CODE eq 'HE' || detail.MANAGE_CODE eq 'GL' || detail.MANAGE_CODE eq 'GM'}">
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.MANAGE_CODE eq 'BD'  || detail.MANAGE_CODE eq 'BE' || detail.MANAGE_CODE eq 'BF' || detail.MANAGE_CODE eq 'BG' || detail.MANAGE_CODE eq 'BH' || detail.MANAGE_CODE eq 'BJ' || detail.MANAGE_CODE eq 'BK' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq 'HR'}">
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
							<c:choose>
								<c:when test="${detail.MANAGE_CODE eq 'BD'  || detail.MANAGE_CODE eq 'BE' || detail.MANAGE_CODE eq 'BF' || detail.MANAGE_CODE eq 'BG' || detail.MANAGE_CODE eq 'BH' || detail.MANAGE_CODE eq 'BJ' || detail.MANAGE_CODE eq 'BK' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq 'HR'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.MANAGE_CODE eq 'BD'  || detail.MANAGE_CODE eq 'BE' || detail.MANAGE_CODE eq 'BF' || detail.MANAGE_CODE eq 'BG' || detail.MANAGE_CODE eq 'BH' || detail.MANAGE_CODE eq 'BJ' || detail.MANAGE_CODE eq 'BK' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq 'HR'}">
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.MANAGE_CODE eq 'FS'  || detail.MANAGE_CODE eq 'FY' || detail.MANAGE_CODE eq 'FF' || detail.MANAGE_CODE eq 'FQ' || detail.MANAGE_CODE eq 'GG' || detail.MANAGE_CODE eq 'HA' || detail.MANAGE_CODE eq 'HF' || detail.MANAGE_CODE eq 'FV'}">
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.MANAGE_CODE eq 'FD'||detail.MANAGE_CODE eq 'FW'||detail.MANAGE_CODE eq ''}">
						</c:when>
						
						<c:when test="${detail.MANAGE_CODE eq 'BV'||detail.MANAGE_CODE eq 'FA'|| detail.MANAGE_CODE eq 'BW'|| detail.MANAGE_CODE eq 'BU'|| detail.MANAGE_CODE eq 'BX' ||detail.MANAGE_CODE eq 'BY' ||detail.MANAGE_CODE eq 'FA' ||detail.MANAGE_CODE eq 'FB' ||detail.MANAGE_CODE eq 'FC' || detail.MANAGE_CODE eq 'GK' || detail.MANAGE_CODE eq 'FX' || detail.MANAGE_CODE eq 'BZ'}">
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.MANAGE_CODE eq 'HM' || detail.MANAGE_CODE eq 'HQ'}">
						</c:when>
						<c:when test="${detail.MANAGE_CODE eq 'CA'|| detail.MANAGE_CODE eq 'CB' || detail.MANAGE_CODE eq 'GR' || detail.MANAGE_CODE eq 'GS' || detail.MANAGE_CODE eq 'FK' || detail.MANAGE_CODE eq 'GT' || detail.MANAGE_CODE eq 'FP' || detail.MANAGE_CODE eq 'FL' || detail.MANAGE_CODE eq 'GU' || detail.MANAGE_CODE eq 'GV' || detail.MANAGE_CODE eq 'GW' || detail.MANAGE_CODE eq 'GX' || detail.MANAGE_CODE eq 'GY' || detail.MANAGE_CODE eq 'FM' || detail.MANAGE_CODE eq 'FL' || detail.MANAGE_CODE eq 'HJ' || detail.MANAGE_CODE eq 'HK' || detail.MANAGE_CODE eq 'HL' || detail.MANAGE_CODE eq 'HN' || detail.MANAGE_CODE eq 'HP'}">
							<c:choose>
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
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
						<c:when test="${detail.MANAGE_CODE eq 'BL' || detail.MANAGE_CODE eq 'BQ' || detail.MANAGE_CODE eq 'BP' || detail.MANAGE_CODE eq 'BM' || detail.MANAGE_CODE eq 'BN' || detail.MANAGE_CODE eq 'CC'}">
							<c:choose>
								
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">

									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
								</c:when>
								
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>

				<c:when test="${homepage.context_path eq 'namdm' || homepage.context_path eq 'namic'}">
					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'BT' || detail.MANAGE_CODE eq 'BS' || detail.MANAGE_CODE eq 'FE'}">
							<c:choose>
								
								<c:when test="${detail.KBILL_LILL_YN eq 'O'}">
									<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
								</c:when>
								
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</c:when>
				
				<c:when test="${homepage.context_path eq 'dgportal'}">


					<c:choose>
						<c:when test="${detail.MANAGE_CODE eq 'BA'  || detail.MANAGE_CODE eq 'BB' || detail.MANAGE_CODE eq 'BC' || detail.MANAGE_CODE eq 'GN' || detail.MANAGE_CODE eq 'HB' || detail.MANAGE_CODE eq 'HD' || detail.MANAGE_CODE eq 'HE' || detail.MANAGE_CODE eq 'GL' || detail.MANAGE_CODE eq 'GM' || detail.MANAGE_CODE eq 'BD'  || detail.MANAGE_CODE eq 'BE' || detail.MANAGE_CODE eq 'BF' || detail.MANAGE_CODE eq 'BG' || detail.MANAGE_CODE eq 'BH' || detail.MANAGE_CODE eq 'BJ' || detail.MANAGE_CODE eq 'BK' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq 'HR' || detail.MANAGE_CODE eq ''  || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq 'BX' || detail.MANAGE_CODE eq 'BY' || detail.MANAGE_CODE eq 'FA' || detail.MANAGE_CODE eq 'FB' || detail.MANAGE_CODE eq 'FC' || detail.MANAGE_CODE eq 'GK' || detail.MANAGE_CODE eq '' || detail.MANAGE_CODE eq 'BZ' || detail.MANAGE_CODE eq 'CA' || detail.MANAGE_CODE eq 'CB' || detail.MANAGE_CODE eq 'GA' || detail.MANAGE_CODE eq 'GB' || detail.MANAGE_CODE eq 'GC' || detail.MANAGE_CODE eq 'GD' || detail.MANAGE_CODE eq 'GE' || detail.MANAGE_CODE eq 'GF' || detail.MANAGE_CODE eq 'GH' || detail.MANAGE_CODE eq 'FJ' || detail.MANAGE_CODE eq 'FN' || detail.MANAGE_CODE eq 'HG' || detail.MANAGE_CODE eq 'GX' || detail.MANAGE_CODE eq 'GY' || detail.MANAGE_CODE eq 'FM' || detail.MANAGE_CODE eq 'HK' || detail.MANAGE_CODE eq 'HM' || detail.MANAGE_CODE eq 'HN' || detail.MANAGE_CODE eq 'HP' || detail.MANAGE_CODE eq 'HQ' || detail.MANAGE_CODE eq 'BL' || detail.MANAGE_CODE eq 'BQ' || detail.MANAGE_CODE eq 'BP' || detail.MANAGE_CODE eq 'BM' || detail.MANAGE_CODE eq 'BN'}">


							<c:if test="${detail.KBILL_LILL_YN eq 'O'}">
								<a href="" class="btn btn3 sangho"><span>상호대차 신청</span></a>
							</c:if>
								
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>


				</c:when>				

				<c:otherwise>
				</c:otherwise>
			</c:choose>
			</c:if>


			<c:if test="${homepage.context_path ne 'nearbylib'}">
				<c:if test="${detail.walkingThroughTime eq true || sessionScope.member.member_id eq 'library16'|| sessionScope.member.member_id eq 'duswls0902'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'CA02'}">
						<a href="#night" id="night-req" class="btn">도서예약제신청</a>
					</c:if>
				</c:if>
			</c:if>

<!--
			<%
				org.joda.time.DateTime now = new org.joda.time.DateTime();
				int dayOfWeek = now.getDayOfWeek(); /* dayOfWeek 월 1 화 2 수 3 목 4 금 5 토 6 일 7 */
				int hour = now.getHourOfDay();
			%>
			 -->
			<!--비대면도서대출 버튼-->
			<c:choose>
				<c:when test="${homepage.context_path eq 'bukgs' and detail.MANAGE_CODE eq 'BA' and detail.LOAN_CODE eq 'OK'}">
					<c:choose>
						<c:when test="${detail.SHELF_LOC_CODE eq 'BA08'||detail.SHELF_LOC_CODE eq 'BA22'||detail.SHELF_LOC_CODE eq 'BA23'}">
						
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.REG_CODE eq 'CDG'}">
						
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
											<a href="#untact" id="untactBook-req" class="btn btn2"><span>무인예약대출 신청</span></a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:when>
			</c:choose>

			<c:choose>
				<c:when test="${homepage.context_path eq 'suseong' and detail.MANAGE_CODE eq 'AE' and detail.LOAN_CODE eq 'OK'}">
					<c:choose>
						<c:when test="${detail.SHELF_LOC_CODE eq 'BA08'||detail.SHELF_LOC_CODE eq 'BA22'||detail.SHELF_LOC_CODE eq 'BA23'}">
						
						</c:when>
						<c:otherwise>
								<jsp:useBean id="Daysu" class="java.util.Date" />
								<fmt:formatDate var="day" value="${Daysu}" pattern="E"/>
									<c:if test="${day ne '토' and day ne '일'}">
									<a href="#untact" id="untactBook-req" class="btn btn2"><span>무인예약대출</span>
									</c:if>
						</c:otherwise>
					</c:choose>
				</c:when>
			</c:choose>
			


			<!--워킹스루 도서대출 버튼-->
			<!--
			<c:if test="${sessionScope.member.member_id eq 'info8910' || sessionScope.member.member_id eq 'hades530' || sessionScope.member.member_id eq 'infoset' || sessionScope.member.member_id eq 'ennesia'|| sessionScope.member.member_id eq 'test01'|| sessionScope.member.member_id eq 'test02'|| sessionScope.member.member_id eq 'test03'|| sessionScope.member.member_id eq 'hades520'}">
				<c:choose>
					<c:when test="${detail.LOAN_CODE eq 'OK'}">
						<a href="#walkingThru" id="walkingThru-req" class="btn"><span>워킹스루 도서대출</span></a>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</c:if>
			-->

			<c:choose>
				<c:when test="${homepage.context_path eq 'gukbo'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AD01' || detail.SHELF_LOC_CODE eq 'AD05' || detail.SHELF_LOC_CODE eq 'AD07' || detail.SHELF_LOC_CODE eq 'AD08' || detail.SHELF_LOC_CODE eq 'AD09' || detail.SHELF_LOC_CODE eq 'AD11' || detail.SHELF_LOC_CODE eq 'AD13' || detail.SHELF_LOC_CODE eq 'AD17' || detail.SHELF_LOC_CODE eq 'AD18' || detail.SHELF_LOC_CODE eq 'AD21' || detail.SHELF_LOC_CODE eq 'AD22' || detail.SHELF_LOC_CODE eq 'AD27' || detail.SHELF_LOC_CODE eq 'AD28' || detail.SHELF_LOC_CODE eq 'AD43' || detail.SHELF_LOC_CODE eq 'AD49' || detail.SHELF_LOC_CODE eq 'AD67'}">
						<c:choose>
							<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
								<!-- <a href="#muin" id="service-noreq" class="btn">무인예약신청</a> -->
							</c:when>
							<c:otherwise>
								<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
							</c:otherwise>
						</c:choose>
					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq '228'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${detail.SHELF_LOC_CODE eq 'AA03' || detail.SHELF_LOC_CODE eq 'AA04' || detail.SHELF_LOC_CODE eq 'AA09' || detail.SHELF_LOC_CODE eq 'AA10' || detail.SHELF_LOC_CODE eq 'AA11' || detail.SHELF_LOC_CODE eq 'AA14' || detail.SHELF_LOC_CODE eq 'AA15' || detail.SHELF_LOC_CODE eq 'AA16' || detail.SHELF_LOC_CODE eq 'AA17' || detail.SHELF_LOC_CODE eq 'AA18' || detail.SHELF_LOC_CODE eq 'AA20' || detail.SHELF_LOC_CODE eq 'AA21' || detail.SHELF_LOC_CODE eq 'AA22' || detail.SHELF_LOC_CODE eq 'AA23' || detail.SHELF_LOC_CODE eq 'AA37' || detail.SHELF_LOC_CODE eq 'AA39'}">

						<c:choose>
							<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
								<a href="#muin" id="service-noreq" class="btn">무인예약신청</a>
							</c:when>
							<c:otherwise>
								<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
							</c:otherwise>
						</c:choose>

					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq 'dmsl'}">
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
					<c:if test="${detail.RESERVATION_CNT eq '0'}">
					<c:if test="${sessionScope.member.user_class_code eq '701'}">
					<!--<a href="#muin" id="unmanned-req" class="btn">별관 이동도서관 신청</a>-->
					</c:if>
					</c:if>
					</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq 'dalseolib'}"> <!-- 달서통합도서관 무인예약 신청-->
					<c:if test="${detail.MANAGE_CODE eq 'BU'||detail.MANAGE_CODE eq 'BV'||detail.MANAGE_CODE eq 'BW' || detail.MANAGE_CODE eq 'BX' || detail.MANAGE_CODE eq 'BY' || detail.MANAGE_CODE eq 'BZ'}">
						<c:choose>
							<c:when test="${detail.SHELF_LOC_CODE eq 'BU11'}">
							
							</c:when>
							<c:otherwise>
								<c:if test="${detail.MEDIA_CODE eq 'PR'}">
									<c:choose>
										<c:when test="${detail.LOAN_CODE eq 'OK'}">
											<a href="#muin" id="dalseo-unmanned-req" class="btn">무인예약신청</a>
											<!--<a href="#" class="btn btn1" onclick="alert('상인/용산역 도서 투입이 지연되는 관계로 2024.01.04(목)~2024.01.06(일)까지 일시 중단됩니다.');">무인예약신청</a>-->
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:if>
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
					<c:if test="${detail.WORKING_STATUS eq 'BOL112N' and param.booktype ne 'NONBOOK'}">
						<c:if test="${detail.RESERVATION_CNT eq '0' and detail.LOAN_CODE eq 'OK'}">
							<c:if test="${detail.SHELF_LOC_CODE eq 'BR01' || detail.SHELF_LOC_CODE eq 'BR02' || detail.SHELF_LOC_CODE eq 'BR03' || detail.SHELF_LOC_CODE eq 'BR05' || detail.SHELF_LOC_CODE eq 'BR06' || detail.SHELF_LOC_CODE eq 'BR07' || detail.SHELF_LOC_CODE eq 'BR10'}">
							<c:choose>
								<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
									<a href="#muin" id="service-noreq" class="btn">무인예약신청</a>
								</c:when>
								<c:otherwise>
									<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
								</c:otherwise>
							</c:choose>
							</c:if>
						</c:if>
					</c:if>
				</c:if>
				</c:when>
				<c:when test="${homepage.context_path eq 'seogulib'}">
					<jsp:useBean id="toDay2" class="java.util.Date" />
					<c:set var="startTime2" value="09:00:00"></c:set>
					<c:set var="endTime2" value="17:00:00"></c:set>
					<fmt:formatDate var="nowdate" value="${toDay2}" pattern="HH:mm:ss"/>
					<fmt:formatDate var="day2" value="${toDay2}" pattern="E"/>
					<c:if test="${startTime2 <= nowdate and nowdate <= endTime2 and (day2 ne '월')}">
						<c:if test="${detail.MANAGE_CODE eq 'BM'}">
							<c:if test="${detail.MEDIA_CODE eq 'PR'}">
								<c:choose>
									<c:when test="${detail.LOAN_CODE eq 'OK'}">
										<a href="#muin" id="unmanned-req" class="btn">무인예약신청</a>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:if>
					</c:if>
				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>

			<c:if test="${detail.LOAN_CODE eq 'OK'}">
				<c:if test="${detail.MANAGE_CODE eq 'BA' || detail.MANAGE_CODE eq 'AH' || detail.MANAGE_CODE eq 'CB' || detail.MANAGE_CODE eq 'AA' || detail.MANAGE_CODE eq 'CA'}">
					<c:if test="${reserveData == 0 and reserveAvailability eq 'Y'}">
						<c:if test="${detail.SHELF_LOC_CODE ne 'AA02' and detail.SHELF_LOC_CODE ne 'AA03' and detail.SHELF_LOC_CODE ne 'AA05' and detail.SHELF_LOC_CODE ne 'AA07' and detail.SHELF_LOC_CODE ne 'AA09' and detail.SHELF_LOC_CODE ne 'AA10' and detail.SHELF_LOC_CODE ne 'AA11' and detail.SHELF_LOC_CODE ne 'AA14' and detail.SHELF_LOC_CODE ne 'AA15' and detail.SHELF_LOC_CODE ne 'AA16' and detail.SHELF_LOC_CODE ne 'AA17' and detail.SHELF_LOC_CODE ne 'AA18' and detail.SHELF_LOC_CODE ne 'AA19' and detail.SHELF_LOC_CODE ne 'AA20' and detail.SHELF_LOC_CODE ne 'AA21' and detail.SHELF_LOC_CODE ne 'AA22' and  detail.SHELF_LOC_CODE ne 'AA23' and detail.SHELF_LOC_CODE ne 'AA29' and detail.SHELF_LOC_CODE ne 'AA30' and detail.SHELF_LOC_CODE ne 'AA31' and detail.SHELF_LOC_CODE ne 'AA36' and detail.SHELF_LOC_CODE ne 'AA37' and detail.SHELF_LOC_CODE ne 'AA39' and detail.SHELF_LOC_CODE ne 'AA40' and detail.SHELF_LOC_CODE ne 'AA41' and detail.SHELF_LOC_CODE ne 'AA51' and detail.SHELF_LOC_CODE ne 'AA52' and detail.SHELF_LOC_CODE ne 'AA53' and detail.SHELF_LOC_CODE ne 'AA56' and detail.SHELF_LOC_CODE ne 'AA58' and detail.SHELF_LOC_CODE ne 'AA59' and detail.SHELF_LOC_CODE ne 'AA60' and detail.SHELF_LOC_CODE ne 'AA62' and detail.SHELF_LOC_CODE ne 'AA65' and detail.SHELF_LOC_CODE ne 'AA66' and detail.SHELF_LOC_CODE ne 'AH14' and detail.SHELF_LOC_CODE ne 'AH16' and detail.SHELF_LOC_CODE ne 'AH26' and detail.SHELF_LOC_CODE ne 'AH33' and detail.SHELF_LOC_CODE ne 'AH60' and detail.SHELF_LOC_CODE ne 'CA08' and detail.SHELF_LOC_CODE ne 'CB08' and detail.SHELF_LOC_CODE ne 'CB10' and detail.SHELF_LOC_CODE ne 'BA08' and detail.SHELF_LOC_CODE ne 'BA22' and detail.SHELF_LOC_CODE ne 'BA23'}">
							<c:choose>
								<c:when test="${not empty nearbylibRejectMessage}">
									<a href="javascript:void(0);" class="btn btn1" onclick="alert('${nearbylibRejectMessage}')" style="padding:8.5px 2%">내 집 앞 도서관 예약</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" id="neighborhoodLibrary-req" class="btn btn1" style="padding:8.5px 2%">내 집 앞 도서관 예약</a>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>
				</c:if>
			</c:if>

<c:if test="${homepage.context_path ne 'nearbylib'}">
			<c:choose>
				<c:when test="${detail.SHELF_LOC_CODE eq 'AD39' || detail.SHELF_LOC_CODE eq 'AD40' || detail.SHELF_LOC_CODE eq 'BA08' || detail.SHELF_LOC_CODE eq 'BA01' || detail.SHELF_LOC_CODE eq 'BD10' || detail.MANAGE_CODE eq 'FW' || detail.SHELF_LOC_CODE eq 'BU11'}">

				</c:when>
				<c:when test="${detail.MANAGE_CODE eq 'AC'}">
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${detail.RESERVE_CODE eq 'OK'}">
							<a href="#" id="resve-req" class="btn btn1" style="padding:8.5px 2%">예약신청(${detail.RESERVATION_CNT} / ${detail.RESERVATION_NUMBER})</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${detail.SEPARATE_SHELF_CODE eq 'BMY' || detail.SEPARATE_SHELF_CODE eq 'BMZ' || detail.SEPARATE_SHELF_CODE eq 'BNB' || detail.SEPARATE_SHELF_CODE eq 'BNC' || detail.SEPARATE_SHELF_CODE eq 'BMN' || detail.SEPARATE_SHELF_CODE eq 'BMT'}">

								</c:when>
								
								<c:otherwise>
									<a href="#" id="resve-req-not" class="btn btn5" style="padding:8.5px 2%">예약불가(${detail.RESERVATION_CNT} / ${detail.RESERVATION_NUMBER})</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
</c:if>

<c:if test="${homepage.context_path ne 'nearbylib'}">
			<c:if test="${detail.MANAGE_CODE eq 'BE'}">
			<c:choose>
			<c:when test="${detail.SHELF_LOC_CODE eq 'BE06'}">
			</c:when>
			<c:otherwise>
				<c:if test="${droneDeviceUsedCount > 0}">
					<jsp:useBean id="droneNow" class="java.util.Date" />
					<fmt:formatDate value="${droneNow}" pattern="yyyyMMdd" var="today"/>
					<c:set var="requestStartTime" value="${today}0000"></c:set>
					<c:set var="requestEndTime" value="${today}1430"></c:set>
					<fmt:parseDate value="${requestStartTime}" pattern="yyyyMMddHHmm" var="requestStartDate" />
					<fmt:parseDate value="${requestEndTime}" pattern="yyyyMMddHHmm" var="requestEndDate" />

					<fmt:formatDate value="${droneNow}" pattern="yyyyMMddHHmm" var="nowDate" />         <%-- 오늘날짜 --%>
					<fmt:formatDate value="${requestStartDate}" pattern="yyyyMMddHHmm" var="openDate"/>       <%-- 시작날짜--%>
					<fmt:formatDate value="${requestEndDate}" pattern="yyyyMMddHHmm" var="closeDate"/>         <%--마감날짜--%>
					<!-- 드론대출 기능 노출 도서관
					openDate <= nowDate and closeDate > nowDate 오픈하면 이걸로 바꿔야함
					-->
					<c:if test="${openDate <= nowDate and closeDate > nowDate }">
						<c:if test="${droneDayLoanCount <= 20 && droneLoanYn eq 'N' && dronePersonalLoanCount < 2}">
							<c:if test="${detail.LOAN_CODE eq 'OK'}">
								<a href="" class="btn" id="drone-lone-req">드론대출</a>
							</c:if>
						</c:if>
					</c:if>
				</c:if>
			</c:otherwise>
			</c:choose>
			</c:if>
</c:if>

<c:if test="${homepage.context_path ne 'nearbylib'}">
			<a href="#" id="addStorage" class="btn btn4"><span>관심도서 추가</span></a>
</c:if>

			<a href="index.do?menu_idx=${param.menu_idx}" id="goBack" class="btn"><i class="fa fa-book"></i><span>목록으로</span></a>

			<c:if test="${not empty loginPortal and loginPortal.login}">
			<a href="#" id="interest" class="btn"><span>교수학습 택배용 관심도서</span></a>
			</c:if>
		</div>

		<c:if test="${homepage.context_path eq '228'}">
			<p style="font-weight:bold;text-align:center;">
				<c:if test="${detail.SHELF_LOC_CODE eq 'AA03' or detail.SHELF_LOC_CODE eq 'AA04' or detail.SHELF_LOC_CODE eq 'AA10' or detail.SHELF_LOC_CODE eq 'AA11' or detail.SHELF_LOC_CODE eq 'AA17' or detail.SHELF_LOC_CODE eq 'AA20'}">
					※ &lt;무인예약신청&gt; 후 1층 현관 옆 스마트도서관에서 수령바랍니다.
				</c:if>
			</p>
		</c:if>

		<c:choose>
			<c:when test="${homepage.context_path eq 'bukgs' and detail.MANAGE_CODE eq 'BA' and detail.LOAN_CODE eq 'OK'}">
			<h3>무인예약대출 신청안내</h3>
			<ul class="con">
				<li><b>대출시간 : </b>당일 18:00 ~ 다음날 09:00</li>
				<li><b>대출장소 : </b>지하 1층 도서무인예약기 부스</li>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>



		<%-- <div style="padding-top:30px ;text-align:right">
			<a href="${detail.aladin.link}" target="_blank" style="color:#000">도서 정보 제공 : 알라딘 인터넷서점(www.aladin.co.kr)</a> <img src="/resources/common/img/aladin_01.png" alt="alandin" align="absmiddle"/>
		</div> --%>

		<!-- 선호도정보 -->
		<c:if test="${not empty data4ageList}">
		<h5 class="bookTitle">연령별 대출선호도 정보</h5>
		<div class="graphWrap">
			<!-- 막대그래프 -->
			<c:if test="${not empty data4ageList}">
			<div class="barGraph">
				<div class="graphBox">
					<ul class="axis-x clearfix">
						<c:forEach var="i" varStatus="stauts" items="${data4ageList}">
						<li>
							<span class="bar"><span class="fill" style="height:${(i.loanCnt/data4LoanCnt)*100}%;"><em class="num">${i.loanCnt}건</em></span></span>
							<p class="txt">${i.name}</p>
						</li>
						</c:forEach>
					</ul>
					<div class="axis-y">
						<span class="line"><span class="txt">100</span></span>
						<span class="line"><span class="txt">80</span></span>
						<span class="line"><span class="txt">60</span></span>
						<span class="line"><span class="txt">40</span></span>
						<span class="line"><span class="txt">20</span></span>
						<span class="line"><span class="txt">0</span></span>
					</div>
					<div class="end"></div>
				</div>
				<div class="end"></div>
			</div>
			</c:if>
			<c:if test="${empty data4ageList}">
			<div>데이터가 없습니다.</div>
			</c:if>
			<!-- //막대그래프 -->
		</div>
		</c:if>
		<!-- 선호도정보 -->
		<div class="end"></div>

		<c:if test="${not empty data4ItemList}">
		<h5 class="bookTitle">이 책의 주요키워드</h5>
		<div class="tagCloud">
			<div id="cloud" class="jqcloud"></div>
		</div>
		<div class="end"></div>
		</c:if>
		
		<c:if test="${not empty data4recommandList}">
		<!-- 도서정보목록 -->
		<h5 class="bookTitle">이 책과 같이 빌린 도서 정보</h5>
		<div class="kdcBookList">
			<ul class="bookListz">
				<c:forEach items="${data4recommandList}" var="i" varStatus="status" begin="1" end="5" step="1">
					<li>
						<div class="thumb">
							<a href="#" data-roll="${i.bookname}" class="cover booksearchdgportal">
								<span class="img">
									<img src="${i.bookImageURL}" alt="${i.bookname}" >
								</span>
							</a>
						</div>
						<span class="tit">${i.bookname}</span>
						<span class="author">${i.authors}</span>
					</li>
				</c:forEach>
			</ul>
		</div>
		</c:if>
		
		<h3 style="border-top: 1px solid #ccc; display: none;">서평</h3>
		<div class="showFoldDiv" id="bookReviewDiv"></div>
	</div>
</div>