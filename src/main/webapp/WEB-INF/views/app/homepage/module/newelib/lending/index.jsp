<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
$(document).ready(function() {
	$('a.book_link').on('click', function(e) {
		e.preventDefault();
		$('#book_idx').val($(this).data('book_idx'));
		$('#type').val($(this).data('type'));
		$('form#lendingListForm').submit();
	});

	<c:if test="${lending.menu == 'LENDING'}">
<%--
	$('a.book_view').on('click', function(e) {
		e.preventDefault();
		window.open('http://elib.gbelib.kr:8085/view_if.asp?user_id=${lending.member_id}&barcode=' + $(this).data('book_code'));
	});
--%>

	$('a.book_return').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		if(confirm('반납하시겠습니까?')) {
			$('#editMode').val('RETURN');
			$('#book_idx').val($(this).data('book_idx'));
			$('#lend_idx').val($(this).data('lend_idx'));
			$form.prop('action', 'save.do');
			if(doAjaxPost($form)) {
				$form.prop('action', 'view.do');
				location.reload();
			}
		}
	});
<%--
	$('a.book_extend').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		if(confirm('연장하시겠습니까?')) {
			$('#editMode').val('EXTEND');
			$('#book_idx').val($(this).data('book_idx'));
			$('#lend_idx').val($(this).data('lend_idx'));
			$form.prop('action', 'save.do');
			if(doAjaxPost($form)) {
				$form.prop('action', 'view.do');
				location.reload();
			}
		}
	});
--%>
	</c:if>
	<c:if test="${lending.menu == 'RESERVE'}">
	$('a.book_cancel').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		if(confirm('취소하시겠습니까?')) {
			$('#editMode').val('CANCEL');
			$('#book_idx').val($(this).data('book_idx'));
			$('#reserve_idx').val($(this).data('reserve_idx'));
			$form.prop('action', 'save.do');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	</c:if>
	<c:if test="${lending.menu == 'MYSTUDY'}">
	$('a.book_borrow').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		$('#editMode').val('BORROW');
		$('#book_idx').val($(this).data('book_idx'));
		$form.prop('action', 'save.do');
		if(doAjaxPost($form)) {
			if(confirm('지금 대출 목록을 확인하시겠습니까?')) {
				location.href = '/${homepage.context_path}/module/newelib/lending/index.do?menu_idx=4&menu=LENDING'
			}
		}
		$form.prop('action', 'index.do');
	})

	$('a.book_reserve').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		$('#editMode').val('RESERVE');
		$('#book_idx').val($(this).data('book_idx'));
		$form.prop('action', 'save.do');
		if(doAjaxPost($form)) {
			if(confirm('지금 예약 목록을 확인하시겠습니까?')) {
				location.href = '/${homepage.context_path}/module/newelib/lending/index.do?menu_idx=5&menu=RESERVE'
			}
		}
		$form.prop('action', 'index.do');
	})

	$('a.book_deletefavorite').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		if(confirm('삭제하시겠습니까?')) {
			$('#editMode').val('DELETEFAVORITE');
			$('#book_idx').val($(this).data('book_idx'));
			$form.prop('action', 'save.do');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	</c:if>

	//달력(통계 기간 선택 오류 방지)
	$('input#dateStart').datepicker({
		maxDate: $('input#dateEnd').val(),
		onClose: function(selectedDate){
			$('input#dateEnd').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#dateEnd').datepicker({
		minDate: $('input#dateStart').val(),
		onClose: function(selectedDate){
			$('input#dateStart').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('button#searchBtn').on('click', function(e) {
		$('#viewPage').attr('value', '1');
		var param = $(lendingListForm).serialize();
		doGetLoad('index.do', param);
		e.preventDefault();
	});
});

function yesb_read(url) {
	var popupPlayer = window.open(url, "YESB", 'width=640,height=480,scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.daegu.go.kr 추가");
		return false;
	} 
}

function fxli_read(book_num) {
	$('input#book_num').val(book_num);
	$('form#frm_fx').prop('action', 'https://elib.daegu.go.kr:9081/FxLibrary/dependency/sso/sso.jsp');
	$('form#frm_fx').prop('target', 'FXLI');
	var popupPlayer = window.open('', "FXLI", 'width=640,height=760,scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.daegu.go.kr 추가");
		return false;
	}
	$('form#frm_fx').submit();
}

function alad_read(url) {
	var popupPlayer = window.open(url, "ALAD", 'width=640,height=480,scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.jbe.go.kr 추가");
		return false;
	}
}

function checkApp(url, com_code) {
	var _APP_INSTALL_URL_IOS, _APP_INSTALL_URL_IPAD, _APP_INSTALL_URL_ANDROID, _APP_SCHEME, _APP_PACKAGE_ID;

	if(com_code == 'FXLI') {
		_APP_INSTALL_URL_IOS = "https://apps.apple.com/us/app/bugkyubeu-jeonjadoseogwan/id1007007455?l=ko&ls=1";
		_APP_INSTALL_URL_IPAD = "https://apps.apple.com/us/app/bugkyubeu-jeonjadoseogwan/id1007007455?l=ko&ls=1";
		_APP_INSTALL_URL_ANDROID = "market://details?id=com.bookcube.digitallibrary";
		_APP_SCHEME = "bookcubedigitallibrary";
		_APP_PACKAGE_ID = "com.bookcube.digitallibrary";
	} else if(com_code == 'YESB') {
		_APP_INSTALL_URL_IOS = "https://apps.apple.com/kr/app/%EB%8C%80%EA%B5%AC%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80/id1592033310";
		_APP_INSTALL_URL_IPAD = "https://apps.apple.com/kr/app/%EB%8C%80%EA%B5%AC%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80/id1592033310";
		_APP_INSTALL_URL_ANDROID = "market://details?id=com.yes24.library.daegu";
		_APP_SCHEME = "yes24lib-daegu";
		_APP_PACKAGE_ID = "com.yes24.library.daegu";
	} else if(com_code == 'ECO') {
		_APP_INSTALL_URL_IOS = "https://apps.apple.com/kr/app/%EB%8C%80%EA%B5%AC%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80/id1592033310";
		_APP_INSTALL_URL_IPAD = "https://apps.apple.com/kr/app/%EB%8C%80%EA%B5%AC%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80/id1592033310";
		_APP_INSTALL_URL_ANDROID = "market://details?id=com.yes24.library.daegu";
		_APP_SCHEME = "yes24lib-daegu";
		_APP_PACKAGE_ID = "com.yes24.library.daegu";
	} else {
		_APP_INSTALL_URL_IOS = "https://apps.apple.com/kr/app/%EB%8C%80%EA%B5%AC%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80/id1592033310";
		_APP_INSTALL_URL_IPAD = "https://apps.apple.com/kr/app/%EB%8C%80%EA%B5%AC%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80/id1592033310";
		_APP_INSTALL_URL_ANDROID = "market://details?id=com.yes24.library.daegu";
		_APP_SCHEME = "yes24lib-daegu";
		_APP_PACKAGE_ID = "com.yes24.library.daegu";
	}
/*
	_APP_INSTALL_URL_IOS = "https://itunes.apple.com/kr/app/alladin-jeonjadoseogwan/id897344878?mt=8";
	_APP_INSTALL_URL_IPAD = "https://itunes.apple.com/kr/app/alladin-jeonjadoseogwan/id897344878?mt=8";
	_APP_INSTALL_URL_ANDROID = "https://play.google.com/store/apps/details?id=kr.co.aladin.elibrary";
	_APP_SCHEME = "aladinelibrary";
	_APP_PACKAGE_ID = "kr.co.aladin.elibrary";
*/
	var ua = navigator.userAgent;
	var isIphone = ua.indexOf('iPhone') !== -1 || ua.indexOf('iPod') !== -1;
	var isIpad = ua.indexOf('iPad') !== -1;
	var isAndroid = ua.indexOf('Android') !== -1;

	if (isIphone) {
		if(confirm('뷰어앱이 설치되어 있으면 확인(승인)을 클릭하시고,\n설치되어 있지 않다면 취소를 클릭하세요. (앱스토어 이동)')) {
			window.location.href = url;
		} else {
			window.location.href = _APP_INSTALL_URL_IOS;
		}
	} else if (isAndroid) {
		if (url.indexOf("intent://") > -1) {
			location.href = url;
		} else {
			if (url.indexOf("://") > -1) {
				var targetScheme = url.split("://");
				location.href = "intent://" + targetScheme[1] + "#Intent;scheme=" + _APP_SCHEME + ";action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=" + _APP_PACKAGE_ID + ";end";
			} else {
				location.href = url;
			}
		}
	} else if (isIpad) {
		if(confirm('뷰어앱이 설치되어 있으면 확인(승인)을 클릭하시고,\n설치되어 있지 않다면 취소를 클릭하세요. (앱스토어 이동)')) {
			window.location.href = url;
		} else {
			window.location.href = _APP_INSTALL_URL_IPAD;
		}
	} else {
		alert('모바일 기기는 안드로이드, 아이폰, 아이패드만 지원합니다.');
	}
}

function opmsCheckApp(server_url, book_id, user_id) {
	alert('현재 웅진 OPMS 전자책 모바일 앱 오류로 인해 일시적으로 중단되오니 당분간 PC버전에서 사용하여 주시기 바랍니다. \n\r이용에 불편함을 드려 죄송합니다.');
	return;
	/*
	var _APP_INSTALL_URL_IOS = "https://itunes.apple.com/app/id1281509812?l=ko&ls=1&mt=8";
	var _APP_INSTALL_URL_IPAD = "https://itunes.apple.com/app/id1281509812?l=ko&ls=1&mt=8";
	var _APP_INSTALL_URL_ANDROID = "https://play.google.com/store/apps/details?id=com.wjopms.ebooklibrary";
	var _APP_SCHEME = "wjopms";
	var _APP_PACKAGE_ID = "com.wjopms.ebooklibrary";

	var ua = navigator.userAgent;
	var isIphone = ua.indexOf('iPhone') !== -1 || ua.indexOf('iPod') !== -1;
	var isIpad = ua.indexOf('iPad') !== -1;
	var isAndroid = ua.indexOf('Android') !== -1;

	if (isIphone) {
		var url = 'wjopms://app?script=download&host=' + server_url + '&book_id=' + book_id + '&user_id=' + user_id + '&subview=V_MYBOOKS';
		if(confirm('뷰어앱이 설치되어 있으면 확인(승인)을 클릭하시고,\n설치되어 있지 않다면 취소를 클릭하세요. (앱스토어 이동)')) {
			window.location.href = url;
		} else {
			window.location.href = _APP_INSTALL_URL_IOS;
		}
	} else if (isAndroid) {
		var url = 'intent://app?script=download&host=' + server_url + '&book_id=' + book_id + '&user_id=' + user_id + '&subview=V_MYBOOKS#Intent;scheme=wjopms;action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=com.wjopms.ebooklibrary;end';
		window.location.href = url;
	} else if (isIpad) {
		var url = 'wjopms://app?script=download&host=' + server_url + '&book_id=' + book_id + '&user_id=' + user_id + '&subview=V_MYBOOKS';
		if(confirm('뷰어앱이 설치되어 있으면 확인(승인)을 클릭하시고,\n설치되어 있지 않다면 취소를 클릭하세요. (앱스토어 이동)')) {
			window.location.href = url;
		} else {
			window.location.href = _APP_INSTALL_URL_IOS;
		}
	} else {
		alert('모바일 기기는 안드로이드, 아이폰, 아이패드만 지원합니다.');
	}
	*/
}

function goto_store() {
	alert('스토어로 이동합니다');

	var ua = navigator.userAgent;
	var isIphone = ua.indexOf('iPhone') !== -1 || ua.indexOf('iPod') !== -1;
	var isIpad = ua.indexOf('iPad') !== -1;
	var isAndroid = ua.indexOf('Android') !== -1;

	if(isIphone || isIpad) {
		window.location.href = 'https://apps.apple.com/kr/app/id574705183';
	} else if(isAndroid) {
		window.location.href = 'market://details?id=eco.app.daegu_mobile';
	} else {
		alert('모바일 기기는 안드로이드, 아이폰, 아이패드만 지원합니다.');
	}

}
</script>
<span style="color: white;">${lending.libcode }</span>
<c:set var='user_id' value = "${fn:toUpperCase(lending.member_id)}" />

<form id="frm_fx" name="frm_fx" method="post" action="https://elib.daegu.go.kr:9081/FxLibrary/dependency/sso/sso.jsp" target="_blank" accept-charset="utf-8">
	<input type="hidden" name="param_1" value="${lending.member_id}">
	<input type="hidden" name="param_2" value="${lending.member_id}">
	<input type="hidden" name="param_3" value="${lending.member_id}">
	<input type="hidden" name="pathtype" value="PC">
	<input type="hidden" name="next" value="bookplayer">
	<input type="hidden" name="book_num" id="book_num">
</form>
<form:form id="lendingListForm" modelAttribute="lending" action="view.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="book_idx"/>
<form:hidden path="lend_idx"/>
<form:hidden path="reserve_idx"/>
<form:hidden path="type"/>
<form:hidden path="menu"/>
<%--
<div class="search" style="text-align: center;">
	기간 검색:&nbsp;&nbsp;
	<form:input type="text" id="dateStart" path="start_date" class="text ui-calendar"/>
	<span id="tilde" style="font-size:12px">~</span>
	<form:input type="text" id="dateEnd" path="end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>검색</span></button>
</div>
--%>
<div class="elib_top">
	<!-- 전자책 총 권수, 검색 조건 시작-->
	<div class="sub001">
		<span><fmt:formatNumber value="${lendingListCnt}" pattern="#,###" /></span> 권의 <%--${lending.type_name}--%>전자책이 있습니다.    &nbsp; <span>${lending.viewPage}</span>  of <fmt:formatNumber value="${lending.totalPageCount}" pattern="#,###" /> page
	</div>
</div>
<ul class="bbs_webzine elib">
	<c:forEach items="${lendingList}" var="i" varStatus="status">
	<li>
		<div class="thumb">
			<a href="#" class="book_link" data-book_idx="${i.book_idx}" data-type="${i.type}" style="background:url(/resources/board/img/lock-bg.gif) no-repeat center center">
				<c:if test="${not empty i.book_image}">
				<img src="${i.book_image}" alt="${i.book_name}" onerror="this.src='/resources/homepage/dgportal/img/book_noimg.png'"/>
				</c:if>
				<c:if test="${empty i.book_image}">
				<img src="/resources/common/img/noImg.gif" alt="noImage"/>
				</c:if>
			</a>
		</div>
		<div class="list-body">
			<div class="flexbox">
				<a href="#" class="book_link" data-book_idx="${i.book_idx}" data-type="${i.type}">
					<b>${fn:escapeXml(i.book_name)}</b>
				</a>
				<div class="info">
					<span>${fn:escapeXml(i.book_pubname)}</span>
					<span class="txt-bar">&nbsp;</span>
					<span>${fn:escapeXml(i.author_name)}</span>
					<span class="txt-bar">&nbsp;</span>
					<span>${fn:escapeXml(i.book_pubdt)}</span>
				</div>
<%--
				<c:set var="body" value="${i.book_info}"/>
				<c:if test="${fn:length(body) > 200}">
				<c:set var="body" value="${fn:substring(body, 0, 200)}..."/>
				</c:if>
				<span class="snipet">${fn:escapeXml(body)}</span>
--%>
			</div>
			<div class="meta">
				<label>소속도서관:</label>
				<span>${fn:escapeXml(i.library_name)}</span>
				<br/>
				<c:if test="${lending.menu == 'LENDING'}">
				<label>대출일:</label>
				<span>${fn:escapeXml(i.lend_dt)}</span>
				<br/>
				<label>반납예정일:</label>
				<span>${fn:escapeXml(i.return_due_dt)}</span>
				</c:if>
				<c:if test="${lending.menu == 'RESERVE'}">
				<label>예약일:</label>
				<span>${fn:escapeXml(i.reserve_dt)}</span>
				</c:if>
				<c:if test="${lending.menu == 'HISTORY'}">
				<label>대출일:</label>
				<span>${fn:escapeXml(i.lend_dt)}</span>
				<br/>
				<label>반납일:</label>
				<span>${fn:escapeXml(i.return_dt)}</span>
				</c:if>
				<c:if test="${lending.menu == 'MYSTUDY'}">
				<label>보관함 등록일:</label>
				<span>${i.favorite_regdt}</span>
				<span class="txt-bar">&nbsp;</span>
				<span>대출 가능 여부: ${i.status}</span>
				<span class="txt-bar">&nbsp;</span>
				<span>대출 : ${i.book_lend}<%-- / ${fn:escapeXml(i.max_lend)}--%></span>
				<span class="txt-bar">&nbsp;</span>
				<span>예약 : ${i.book_reserve}</span>
				</c:if>
				<div style="float: right;">
					<c:if test="${lending.menu == 'LENDING'}">
					<c:choose>
					<c:when test="${i.com_code == 'FXLI'}">
						<c:set var="site_code" value=""/>
						<c:choose>
						<c:when test="${isMobile && i.com_code ne 'ECO'}">
							<c:set var="data" value="${mobileList[status.index]}"/>
							<c:set var="read" value="checkApp('${data['appurl']}', '${i.com_code}'); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="fxli_read('${i.book_code}'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${i.com_code == 'YESB'}">
						<c:set var="site_code" value=""/>
						<c:choose>
						<c:when test="${isMobile && i.com_code ne 'ECO'}">
							<c:set var="data" value="${mobileList[status.index]}"/>
							<c:set var="read" value="checkApp('${data['appurl']}', '${i.com_code}'); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="javascript:yesb_read('https://elib.daegu.go.kr:8082/YES24/yes24viewer_open.asp?user_id=${lending.member_id}&goods_id=${i.book_code}&site_code=B2B_DAEGU'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${i.com_code == 'ECO'}">
						<c:set var="site_code" value=""/>
						<c:choose>
						<c:when test="${isMobile}">
							<c:set var="data" value="${mobileList[status.index]}"/>
							<c:set var="read" value="checkApp('${data['appurl']}', '${i.com_code}'); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="javascript:yesb_read('https://elib.daegu.go.kr:8082/YES24/yes24viewer_open.asp?libCode=${sessionScope.member.lib_code}&ownerCode=EC&userId=${lending.member_id}&contentsKey=${i.book_code}&site_code=B2B_DAEGU&drm_type=ECO'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
						<c:when test="${isMobile}">
							<c:set var="data" value="${mobileList[status.index]}"/>
							<c:set var="read" value="checkApp('${data['appurl']}', '${i.com_code}'); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="javascript:yesb_read('https://elib.daegu.go.kr:8082/YES24/yes24viewer_open.asp?libCode=${sessionScope.member.lib_code}&ownerCode=EC&userId=${lending.member_id}&contentsKey=${i.book_code}&site_code=B2B_DAEGU&drm_type=ECO'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:otherwise>
					</c:choose>

					<span><a href="#" class="btn btn1 book_view" data-book_code="${i.book_code}" onclick="${read}" data-type="${i.type}">책읽기</a></span>
					<span><a href="#" class="btn btn4 book_return" data-book_idx="${i.book_idx}" data-lend_idx="${i.lend_idx}" data-type="${i.type}">반납하기</a></span>
<%--
					<span><a href="#" class="btn btn5 book_extend" data-book_idx="${i.book_idx}" data-lend_idx="${i.lend_idx}" data-type="${i.type}">연장하기</a></span>
--%>
					</c:if>
					<c:if test="${lending.menu == 'RESERVE'}">
					<span><a href="#" class="btn btn4 book_cancel" data-book_idx="${i.book_idx}" data-reserve_idx="${i.lend_idx}" data-type="${i.type}">예약취소</a></span>
					</c:if>
					<c:if test="${lending.menu == 'MYSTUDY'}">
					<c:choose>
					<c:when test="${i.type == 'EBK' && i.status == '대출 가능'}">
					<span><a href="#" class="btn btn1 book_borrow" data-book_idx="${i.book_idx}" data-type="${i.type}">대출하기</a></span>
					</c:when>
					<c:when test="${i.type == 'EBK' && i.status == '예약 가능'}">
					<span><a href="#" class="btn btn2 book_reserve" data-book_idx="${i.book_idx}" data-type="${i.type}">예약하기</a></span>
					</c:when>
					</c:choose>
					<span><a href="#" class="btn btn4 book_deletefavorite" data-book_idx="${i.book_idx}" data-type="${i.type}">삭제</a></span>
					</c:if>
				</div>
			</div>
		</div>
	</li>
	</c:forEach>
</ul>
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#lendingListForm"/>
	<jsp:param name="pagingUrl" value="index.do"/>
</jsp:include>
</form:form>
