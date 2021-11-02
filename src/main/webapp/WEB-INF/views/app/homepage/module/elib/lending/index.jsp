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

		if(confirm('ë°ë©íìê² ìµëê¹?')) {
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

		if(confirm('ì°ì¥íìê² ìµëê¹?')) {
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

		if(confirm('ì·¨ìíìê² ìµëê¹?')) {
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
			if(confirm('ì§ê¸ ëì¶ ëª©ë¡ì íì¸íìê² ìµëê¹?')) {
				location.href = '/${homepage.context_path}/module/elib/lending/index.do?menu_idx=4&menu=LENDING'
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
			if(confirm('ì§ê¸ ìì½ ëª©ë¡ì íì¸íìê² ìµëê¹?')) {
				location.href = '/${homepage.context_path}/module/elib/lending/index.do?menu_idx=5&menu=RESERVE'
			}
		}
		$form.prop('action', 'index.do');
	})

	$('a.book_deletefavorite').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#lendingListForm');

		if(confirm('ì­ì íìê² ìµëê¹?')) {
			$('#editMode').val('DELETEFAVORITE');
			$('#book_idx').val($(this).data('book_idx'));
			$form.prop('action', 'save.do');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	</c:if>

	//ë¬ë ¥(íµê³ ê¸°ê° ì í ì¤ë¥ ë°©ì§)
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

function readBook(arg) {
	if (arg != null && arg != '' && arg.length > 0) {
		var newWinBook = window.open(arg);
		if (newWinBook == null) {
			alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.daegu.go.kr ì¶ê°");
			return false;
		}
	}
}

function yesb_read(url) {
	var popupPlayer = window.open(url, "YESB", 'width=640,height=480,scrollbars=yes');
	if (popupPlayer == null) {
		alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.daegu.go.kr ì¶ê°");
		return false;
	}
}

function yesb_read2(url) {
	var popupPlayer = window.open(url, "YESB", 'width=715,height=415,scrollbars=yes');
	if (popupPlayer == null) {
		alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.daegu.go.kr ì¶ê°");
		return false;
	}
}

function fxli_read(book_num, lib_code) {
	$('input#book_num').val(book_num);
	$('input#param_1').val(lib_code + '_' + '${lending.member_id}'.toUpperCase());
	$('input#param_2').val(lib_code + '_' + '${lending.member_id}'.toUpperCase());
	$('input#param_3').val(lib_code + '_' + '${lending.member_id}'.toUpperCase());
	$('form#frm_fx').prop('action', 'http://e-lib.tglnet.or.kr:9080/FxLibrary/dependency/sso/sso.jsp');
	$('form#frm_fx').prop('target', 'FXLI');
	var popupPlayer = window.open('', "FXLI", 'width=640,height=760,scrollbars=yes');
	if (popupPlayer == null) {
		alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.daegu.go.kr ì¶ê°");
		return false;
	}
	$('form#frm_fx').submit();
}

function opms_read(url) {
	var popupPlayer = window.open(url, "OPMS", 'width=523,height=475,scrollbars=yes');
	if (popupPlayer == null) {
		alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.ice.go.kr ì¶ê°");
		return false;
	}
}

function eco_read(url) {
	//var p = /libCode=[0-9]{6}/gi;
	//url = url.replace(p, 'libCode=000000');
	var whole = '/elib/module/elib/redirect.do?url=' + encodeURIComponent(url);
	var popupPlayer = window.open(whole, "ECO", 'width=425,height=355,scrollbars=yes');
	if (popupPlayer == null) {
		alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.ice.go.kr ì¶ê°");
		return false;
	}
}

function eco_read2(libCode, ownerCode, contentsKey) {
	$('input#libCode').val(libCode);
	$('input#ownerCode').val(ownerCode);
	$('input#contentsKey').val(contentsKey);
	$('form#frm_eco').prop('action', 'http://e-lib.tglnet.or.kr:8099/ebookPlatform/b2b_homepage/B2B06_MyPage/chkViewer.jsp');
	$('form#frm_eco').prop('target', 'ECO');
	var popupPlayer = window.open('', "ECO", 'width=425,height=355,scrollbars=yes');
	if (popupPlayer == null) {
		alert("íì ì°¨ë¨ ê¸°ë¥ì´ ì¤ì ëì´ììµëë¤\n\nì°¨ë¨ ê¸°ë¥ì í´ì (íìíì©) í í ë¤ì ì´ì©í´ ì£¼ì­ìì¤.\n\níì ì°¨ë¨ ê¸°ë¥ì í´ì íì§ ìì¼ë©´\nì ìì ì¸ ì ìì±ì ì´ì©íì¤ ì ììµëë¤.\n\n* ì°¨ë¨ í´ì  ë°©ë² \nì¤ì  - ì¸í°ë· ìµì - ê°ì¸ì ë³´ - íìì°¨ë¨ ì¤ì \níì©í  ì¹ ì¬ì´í¸ ì£¼ì : *.ice.go.kr ì¶ê°");
		return false;
	}
	$('form#frm_eco').submit();
}

function checkApp(url, com_code) {
	var _APP_INSTALL_URL_IOS, _APP_INSTALL_URL_IPAD, _APP_INSTALL_URL_ANDROID, _APP_SCHEME, _APP_PACKAGE_ID;

	if(com_code == 'BQ') {
		_APP_INSTALL_URL_IOS = "https://itunes.apple.com/us/app/bugkyubeujeonjadoseogwan/id1007007455?l=ko&ls=1&mt=8";
		_APP_INSTALL_URL_IPAD = "https://itunes.apple.com/us/app/bugkyubeujeonjadoseogwanhd/id1007080008?l=ko&ls=1&mt=8";
		_APP_INSTALL_URL_ANDROID = "market://details?id=com.bookcube.digitallibrary";
		_APP_SCHEME = "bookcubedigitallibrary";
		_APP_PACKAGE_ID = "com.bookcube.digitallibrary";
	} else if(com_code == 'YE') {
		_APP_INSTALL_URL_IOS = "https://itunes.apple.com/kr/app/%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80-%EB%B7%B0%EC%96%B4/id1353292577?&mt=8";
		_APP_INSTALL_URL_IPAD = "https://itunes.apple.com/kr/app/%EC%A0%84%EC%9E%90%EB%8F%84%EC%84%9C%EA%B4%80-%EB%B7%B0%EC%96%B4/id1353292577?&mt=8";
		_APP_INSTALL_URL_ANDROID = "market://details?id=com.yes24.yes24viewer";
		_APP_SCHEME = "yes24lib-yes24viewer";
		_APP_PACKAGE_ID = "com.yes24.yes24viewer";
	}

	var ua = navigator.userAgent;
	var isIphone = ua.indexOf('iPhone') !== -1 || ua.indexOf('iPod') !== -1;
	var isIpad = ua.indexOf('iPad') !== -1;
	var isAndroid = ua.indexOf('Android') !== -1;

    if (isIphone) {
    	if(confirm('ë·°ì´ì±ì´ ì¤ì¹ëì´ ìì¼ë©´ íì¸(ì¹ì¸)ì í´ë¦­íìê³ ,\nì¤ì¹ëì´ ìì§ ìë¤ë©´ ì·¨ìë¥¼ í´ë¦­íì¸ì. (ì±ì¤í ì´ ì´ë)')) {
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
    	if(confirm('ë·°ì´ì±ì´ ì¤ì¹ëì´ ìì¼ë©´ íì¸(ì¹ì¸)ì í´ë¦­íìê³ ,\nì¤ì¹ëì´ ìì§ ìë¤ë©´ ì·¨ìë¥¼ í´ë¦­íì¸ì. (ì±ì¤í ì´ ì´ë)')) {
	        window.location.href = url;
    	} else {
            window.location.href = _APP_INSTALL_URL_IPAD;
    	}
    } else {
    	alert('ëª¨ë°ì¼ ê¸°ê¸°ë ìëë¡ì´ë, ìì´í°, ìì´í¨ëë§ ì§ìí©ëë¤.');
    }
}

function opmsCheckApp(server_url, book_id, user_id) {
	alert('íì¬ ìì§ OPMS ì ìì± ëª¨ë°ì¼ ì± ì¤ë¥ë¡ ì¸í´ ì¼ìì ì¼ë¡ ì¤ë¨ëì¤ë ë¹ë¶ê° PCë²ì ìì ì¬ì©íì¬ ì£¼ìê¸° ë°ëëë¤. \n\rì´ì©ì ë¶í¸í¨ì ëë ¤ ì£ì¡í©ëë¤.');
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
    	if(confirm('ë·°ì´ì±ì´ ì¤ì¹ëì´ ìì¼ë©´ íì¸(ì¹ì¸)ì í´ë¦­íìê³ ,\nì¤ì¹ëì´ ìì§ ìë¤ë©´ ì·¨ìë¥¼ í´ë¦­íì¸ì. (ì±ì¤í ì´ ì´ë)')) {
	        window.location.href = url;
    	} else {
            window.location.href = _APP_INSTALL_URL_IOS;
    	}
    } else if (isAndroid) {
    	var url = 'intent://app?script=download&host=' + server_url + '&book_id=' + book_id + '&user_id=' + user_id + '&subview=V_MYBOOKS#Intent;scheme=wjopms;action=android.intent.action.VIEW;category=android.intent.category.BROWSABLE;package=com.wjopms.ebooklibrary;end';
		window.location.href = url;
    } else if (isIpad) {
    	var url = 'wjopms://app?script=download&host=' + server_url + '&book_id=' + book_id + '&user_id=' + user_id + '&subview=V_MYBOOKS';
    	if(confirm('ë·°ì´ì±ì´ ì¤ì¹ëì´ ìì¼ë©´ íì¸(ì¹ì¸)ì í´ë¦­íìê³ ,\nì¤ì¹ëì´ ìì§ ìë¤ë©´ ì·¨ìë¥¼ í´ë¦­íì¸ì. (ì±ì¤í ì´ ì´ë)')) {
	        window.location.href = url;
    	} else {
            window.location.href = _APP_INSTALL_URL_IOS;
    	}
    } else {
    	alert('ëª¨ë°ì¼ ê¸°ê¸°ë ìëë¡ì´ë, ìì´í°, ìì´í¨ëë§ ì§ìí©ëë¤.');
    }
	*/
}

function goto_store() {
	alert('ì¤í ì´ë¡ ì´ëí©ëë¤');

	var ua = navigator.userAgent;
	var isIphone = ua.indexOf('iPhone') !== -1 || ua.indexOf('iPod') !== -1;
	var isIpad = ua.indexOf('iPad') !== -1;
	var isAndroid = ua.indexOf('Android') !== -1;

	if(isIphone || isIpad) {
		window.location.href = 'https://apps.apple.com/kr/app/id574705183';
	} else if(isAndroid) {
		window.location.href = 'market://details?id=eco.app.daegu_mobile';
    } else {
    	alert('ëª¨ë°ì¼ ê¸°ê¸°ë ìëë¡ì´ë, ìì´í°, ìì´í¨ëë§ ì§ìí©ëë¤.');
    }

}
</script>
<span style="color: white;">${lending.libcode }</span>
<c:set var='user_id' value = "${fn:toUpperCase(lending.member_id)}" />
<form id="frm_fx" name="frm_fx" method="post" action="http://e-lib.tglnet.or.kr:9080/FxLibrary/dependency/sso/sso.jsp" target="_blank" accept-charset="utf-8">
    <input type="hidden" name="param_1" id="param_1" value="${sessionScope.member.lib_code}_${user_id}">
    <input type="hidden" name="param_2" id="param_2" value="${sessionScope.member.lib_code}_${user_id}">
    <input type="hidden" name="param_3" id="param_3" value="${sessionScope.member.lib_code}_${user_id}">
    <input type="hidden" name="pathtype" value="PC">
    <input type="hidden" name="next" value="bookplayer">
 	<input type="hidden" name="book_num" id="book_num">
</form>

<form id="frm_eco" name="frm_eco" method="post" action="http://e-lib.tglnet.or.kr:8099/ebookPlatform/b2b_homepage/B2B06_MyPage/chkViewer.jsp" target="_blank" accept-charset="utf-8">
    <input type="hidden" name="libCode" id="libCode" value="${sessionScope.member.lib_code}">
    <input type="hidden" name="ownerCode" id="ownerCode" value="${lending.member_id}">
    <input type="hidden" name="userId" id="userId" value="${lending.member_id}">
    <input type="hidden" name="contentsKey" id="contentsKey" value="">
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
	ê¸°ê° ê²ì:&nbsp;&nbsp;
	<form:input type="text" id="dateStart" path="start_date" class="text ui-calendar"/>
	<span id="tilde" style="font-size:12px">~</span>
	<form:input type="text" id="dateEnd" path="end_date" class="text ui-calendar"/>
	<button id="searchBtn"><i class="fa fa-search"></i><span>ê²ì</span></button>
</div>
--%>
<div class="elib_top">
	<!-- ì ìì± ì´ ê¶ì, ê²ì ì¡°ê±´ ìì-->
	<div class="sub001">
		<span><fmt:formatNumber value="${lendingListCnt}" pattern="#,###" /></span> ê¶ì <%--${lending.type_name}--%>ì ìì±ì´ ììµëë¤.    &nbsp; <span>${lending.viewPage}</span>  of <fmt:formatNumber value="${lending.totalPageCount}" pattern="#,###" /> page
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
            	<label>ììëìê´:</label>
				<span>${fn:escapeXml(i.library_name)}</span>
            	<br/>
				<c:if test="${lending.menu == 'LENDING'}">
            	<label>ëì¶ì¼:</label>
				<span>${fn:escapeXml(i.lend_dt)}</span>
            	<br/>
            	<label>ë°ë©ìì ì¼:</label>
				<span>${fn:escapeXml(i.return_due_dt)}</span>
				</c:if>
				<c:if test="${lending.menu == 'RESERVE'}">
            	<label>ìì½ì¼:</label>
				<span>${fn:escapeXml(i.reserve_dt)}</span>
				</c:if>
				<c:if test="${lending.menu == 'HISTORY'}">
            	<label>ëì¶ì¼:</label>
				<span>${fn:escapeXml(i.lend_dt)}</span>
            	<br/>
            	<label>ë°ë©ì¼:</label>
				<span>${fn:escapeXml(i.return_dt)}</span>
				</c:if>
				<c:if test="${lending.menu == 'MYSTUDY'}">
            	<label>ë³´ê´í¨ ë±ë¡ì¼:</label>
				<span>${i.favorite_regdt}</span>
				<span class="txt-bar">&nbsp;</span>
				<span>ëì¶ ê°ë¥ ì¬ë¶: ${i.status}</span>
				<span class="txt-bar">&nbsp;</span>
				<span>ëì¶ : ${i.book_lend}<%-- / ${fn:escapeXml(i.max_lend)}--%></span>
				<span class="txt-bar">&nbsp;</span>
				<span>ìì½ : ${i.book_reserve}</span>
				</c:if>
	            <div style="float: right;">
	            	<c:if test="${lending.menu == 'LENDING'}">
	            	<c:choose>
	            	<c:when test="${isMobile}">
	            		<c:set var="read" value="goto_store(); return false;"/>
	            	</c:when>
					<c:when test="${i.com_code == 'BQ'}">
						<c:set var="site_code" value=""/>
						<c:choose>
						<c:when test="${isMobile}">
							<c:set var="data" value="${mobileList[status.index]}"/>
							<c:set var="read" value="checkApp('${data['appurl']}', '${i.com_code}'); return false;"/>
						</c:when>
						<c:when test="${empty i.viewer_url}">
							<c:set var="read" value="fxli_read('${i.book_code}', '${sessionScope.member.lib_code}'); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="yesb_read('${i.viewer_url}'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${i.com_code == 'YE'}">
						<c:choose>
						<c:when test="${isMobile}">
							<c:set var="data" value="${mobileList[status.index]}"/>
							<c:set var="read" value="checkApp('${data['appurl']}', '${i.com_code}'); return false;"/>
						</c:when>
						<c:when test="${empty i.viewer_url}">
							<c:set var="read" value="javascript:yesb_read('http://e-lib.tglnet.or.kr:8081/YES24/yes24viewer_open.asp?user_id=${lending.member_id}&goods_id=${i.book_code}&site_code='); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="yesb_read('${i.viewer_url}'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${i.com_code == 'EC' and empty i.viewer_url}">
						<%-- TODO: ECO ë·°ì´ URL ë°ìì êµì²´í´ì¼ í¨ --%>
						<%--<c:set var="read" value="javascript:eco_read('http://e-lib.tglnet.or.kr:8099/ebookPlatform/b2b_homepage/B2B06_MyPage/chkViewer.jsp?libCode=${sessionScope.member.lib_code}&ownerCode=EC&userId=${lending.member_id}&contentsKey=${i.book_code}'); return false;"/>--%>
						<c:set var="read" value="javascript:eco_read2('${sessionScope.member.lib_code}','EC', '${i.book_code}'); return false;"/>
					</c:when>
					<c:when test="${i.com_code == 'KP' and empty i.viewer_url}">
						<%-- TODO: ECO ë·°ì´ URL ë°ìì êµì²´í´ì¼ í¨ --%>
						<%-- <c:set var="read" value="javascript:eco_read('http://e-lib.tglnet.or.kr:8099/ebookPlatform/b2b_homepage/B2B06_MyPage/chkViewer.jsp?libCode=${sessionScope.member.lib_code}&ownerCode=KP&userId=${lending.member_id}&contentsKey=${i.book_code}'); return false;"/> --%>
						<c:set var="read" value="javascript:eco_read2('${sessionScope.member.lib_code}','KP', '${i.book_code}'); return false;"/>
					</c:when>
					<c:when test="${i.com_code == 'BX'}">
						<c:choose>
						<c:when test="${isMobile}">
							<c:set var="read" value="opmsCheckApp('http://e-lib.tglnet.or.kr:8000', '${i.book_code}', '${lending.member_id}'); return false;"/>
						</c:when>
						<c:when test="${empty i.viewer_url}">
							<c:set var="read" value="javascript:opms_read('http://e-lib.tglnet.or.kr:8000/opms_pop.asp?user_id=${lending.member_id}&eancode=${i.book_code}'); return false;"/>
						</c:when>
						<c:otherwise>
							<c:set var="read" value="yesb_read('${i.viewer_url}'); return false;"/>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:set var="read" value="yesb_read('${i.viewer_url}'); return false;"/>
					</c:otherwise>
					</c:choose>

	            	<span><a href="#" class="btn btn1 book_view" data-book_code="${i.book_code}" onclick="${read}" data-type="${i.type}">ì±ì½ê¸°</a></span>
	            	<span><a href="#" class="btn btn4 book_return" data-book_idx="${i.book_idx}" data-lend_idx="${i.lend_idx}" data-type="${i.type}">ë°ë©íê¸°</a></span>
<%--
	            	<span><a href="#" class="btn btn5 book_extend" data-book_idx="${i.book_idx}" data-lend_idx="${i.lend_idx}" data-type="${i.type}">ì°ì¥íê¸°</a></span>
--%>
	            	</c:if>
	            	<c:if test="${lending.menu == 'RESERVE'}">
	            	<span><a href="#" class="btn btn4 book_cancel" data-book_idx="${i.book_idx}" data-reserve_idx="${i.lend_idx}" data-type="${i.type}">ìì½ì·¨ì</a></span>
	            	</c:if>
	            	<c:if test="${lending.menu == 'MYSTUDY'}">
	            	<c:choose>
					<c:when test="${i.type == 'EBK' && i.status == 'ëì¶ ê°ë¥'}">
					<span><a href="#" class="btn btn1 book_borrow" data-book_idx="${i.book_idx}" data-type="${i.type}">ëì¶íê¸°</a></span>
					</c:when>
					<c:when test="${i.type == 'EBK' && i.status == 'ìì½ ê°ë¥'}">
					<span><a href="#" class="btn btn2 book_reserve" data-book_idx="${i.book_idx}" data-type="${i.type}">ìì½íê¸°</a></span>
					</c:when>
	            	</c:choose>
	            	<span><a href="#" class="btn btn4 book_deletefavorite" data-book_idx="${i.book_idx}" data-type="${i.type}">ì­ì </a></span>
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
