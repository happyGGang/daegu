<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\n"); %>
<c:choose>
<c:when test="${book.com_code == 'KYOB'}">
<c:set var="viewer_url" value="http://ebook.busan.go.kr:8085/Kyobo_T3/HelpDesk/HelpDesk_InstallProgram.asp?mcode=2&tcode=1"/>
</c:when>
<c:when test="${book.com_code == 'YESB'}">
<c:set var="viewer_url" value="http://yes24viewer.yes24library.com/activex/yes24viewersetup.exe"/>
</c:when>
<c:when test="${book.com_code == 'Y2BK'}">
<c:set var="viewer_url" value="http://www.readingrak.com/support/guide"/>
</c:when>
<c:when test="${book.com_code == 'FXLI'}">
<c:set var="viewer_url" value="http://www.bookcube.com/customer.asp?page=viewer"/>
</c:when>
</c:choose>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<script>
$(document).ready(function() {

	$('a#goto_list').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');
		<c:choose>
		<c:when test="${param.from_search == 'Y'}">
		$form = $('form#detailForm');
		$form.prop('action', '../search/index.do');
		</c:when>
		<c:otherwise>
		$form.prop('action', 'index.do');
		</c:otherwise>
		</c:choose>
		$form.submit();
	});

	$('div.tabmenu > ul > li > a').on('click', function(e) {
		e.preventDefault();
		$('div.tabmenu > ul > li').removeClass('active');
		$(this).parent().addClass('active');
		$('div.tab_body').hide();
		$('#'+$(this).data('target')).show();
	});

	<c:choose>
	<c:when test="${member.login && member.user_class == '1'}">
	$('a#book_borrow, a#book_reserve, a#book_addfavorite, a#book_recommend').on('click', function(e) {
		e.preventDefault();
		alert('대출중지 상태입니다.');
	});
	</c:when>
	<c:when test="${member.login && member.member_class == '2'}">
	$('a#book_borrow, a#book_reserve, a#book_addfavorite, a#book_recommend').on('click', function(e) {
		e.preventDefault();
		alert('이용자님은 현재 미승인 회원입니다. 대구광역시 도서관 소속도서관에서 정회원으로 승인 받은 후 전자도서관을 이용 바랍니다');
	});
	</c:when>
	<c:when test="${member.login && member.member_class == '0'}">
	$('a#book_borrow').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');

		$('#editMode').val('BORROW');
		$form.prop('action', '../lending/save.do');
		if(doAjaxPost($form)) {
			if(confirm('지금 대출 목록을 확인하시겠습니까?')) {
				location.href = '/${homepage.context_path}/module/elib/lending/index.do?menu_idx=4&menu=LENDING'
			}
		}
		$form.prop('action', 'index.do');
	});
	$('a#book_borrow_').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');

		$('#editMode').val('BORROW_');
		$form.prop('action', '../lending/save.do');
		doAjaxPost($form);
	});

	$('a#book_reserve').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');

		$('#editMode').val('RESERVE');
		$form.prop('action', '../lending/save.do');
		if(doAjaxPost($form)) {
			if(confirm('지금 예약 목록을 확인하시겠습니까?')) {
				location.href = '/${homepage.context_path}/module/elib/lending/index.do?menu_idx=5&menu=RESERVE'
			}
		}
		$form.prop('action', 'index.do');
	});

	$('a#book_addfavorite').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');

		$('#editMode').val('ADDFAVORITE');
		$form.prop('action', '../lending/save.do');
		if(doAjaxPost($form)) {
			if(confirm('지금 나의 관심도서 목록을 확인하시겠습니까?')) {
				location.href = '/${homepage.context_path}/module/elib/lending/index.do?menu_idx=78&menu=MYSTUDY'
			}
		}
		$form.prop('action', 'index.do');
	});

	$('a#book_recommend').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');

		$('#editMode').val('RECOMMEND');
		$form.prop('action', '../book/save.do');
		doAjaxPost($form);
		$form.prop('action', 'index.do');
	});
	</c:when>
<%--
	<c:when test="${member.login}">
	$('a#book_borrow, a#book_reserve, a#book_addfavorite, a#book_recommend').on('click', function(e) {
		e.preventDefault();
		alert('소속 도서관 회원만 이용 가능합니다.');
	});
	</c:when>
--%>
	<c:otherwise>
	$('a#book_borrow, a#book_reserve, a#book_addfavorite, a#book_recommend').on('click', function(e) {
		e.preventDefault();
		console.log('view.jsp member:', '${member}');
		console.log('view.jsp member.status_code:', '${member.status_code}')
		alert('로그인 후 이용 가능합니다.');
		location.href = '/elib/intro/login/index.do?menu_idx=4&before_url=' + encodeURIComponent(window.location.pathname + window.location.search + window.location.hash);
	});
	</c:otherwise>
	</c:choose>

	<c:if test="${book.type == 'WEB'}">
	<c:choose>
	<c:when test="${member.login && member.user_class == '1'}">
	$('a.course_view').on('click', function(e) {
		e.preventDefault();
		alert('대출중지 상태입니다.');
	});
	</c:when>
	<c:when test="${member.login && member.member_class == '2'}">
	$('a.course_view').on('click', function(e) {
		e.preventDefault();
		alert('이용자님은 현재 미승인 회원입니다. 대구광역시 통합도서관에서 정회원으로 승인 받은 후 전자도서관을 이용 바랍니다');
	});
	</c:when>
	<c:when test="${member.login && member.member_class == '0'}">
	$('a.course_view').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');
		$('#lesson_no').val($(this).data('lessonno'));
		$('#editMode').val('BORROW_RETURN_ELEARN');
		$form.prop('action', '../lending/save.do');
		doAjaxPost($form);

		<c:choose>
		<c:when test="${book.com_code == 'CONT'}">
		cont2_read($(this).data('url'));
		</c:when>
		<c:when test="${book.com_code == 'GLOB' || book.com_code == 'ECSM'}">
		glob_read($(this).data('url'));
		</c:when>
		<c:when test="${book.com_code == 'YBMN'}">
		ybmn_read($(this).data('url') + '&user_id=${member.member_id}');
		</c:when>
		<c:when test="${book.com_code == 'ARTN' && isMobile}">
		var url = $(this).data('url');
		var userAgent = navigator.userAgent;
		var visitedAt = (new Date()).getTime();

		//ios 인 경우
		if(userAgent.match(/iPhone|iPad|iPod/)){
			var delaySec = 500;
			if(userAgent.match(/OS 9_/)){
				delaySec = 1500;
			}
			setTimeout(
			  function(){
				  if((new Date()).getTime() - visitedAt < 2000){
					  location.href="https://itunes.apple.com/us/app/biteupeulleieo-beat-player/id994806028?mt=8";
				  }
			  },delaySec);

			setTimeout(function(){location.href=url;},0);
		}
		else if(userAgent.match(/Mac|Macintosh|Windows/)){
			location.href=url;
		}
		// Android
		else{
			url = url.replace("beatplayer://","");
			location.href="intent://"+url+"&#Intent;scheme=beatplayer;package=net.stway.beatplayer;end";
		}
		</c:when>
		<c:when test="${book.com_code == 'ARTN'}">
		cont2_read($(this).data('url'));
		</c:when>
		<c:when test="${book.com_code == 'YESB'}">
		yesb_read($(this).data('url'));
		</c:when>
		<c:otherwise>
		window.open($(this).data('url'));
		</c:otherwise>
		</c:choose>
	});
	</c:when>
<%--
	<c:when test="${member.login}">
	$('a.course_view').on('click', function(e) {
		e.preventDefault();
		alert('소속 도서관 회원만 이용 가능합니다.');
	});
	</c:when>
--%>
	<c:otherwise>
	$('a.course_view').on('click', function(e) {
		e.preventDefault();
		alert('로그인 후 이용 가능합니다.');
		location.href = '/elib/intro/login/index.do?menu_idx=4&before_url=' + encodeURIComponent(window.location.pathname + window.location.search + window.location.hash);
	});
	</c:otherwise>
	</c:choose>
	</c:if>

	<c:if test="${book.type == 'ADO' && (book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD')}">
	<c:choose>
	<c:when test="${member.login && member.user_class == '1'}">
	$('a.audio_view').on('click', function(e) {
		e.preventDefault();
		alert('대출중지 상태입니다.');
	});
	</c:when>
	<c:when test="${member.login && member.member_class == '2'}">
	$('a.audio_view').on('click', function(e) {
		e.preventDefault();
		alert('이용자님은 현재 미승인 회원입니다. 대구광역시 통합도서관에서 정회원으로 승인 받은 후 전자도서관을 이용 바랍니다');
	});
	</c:when>
	<c:when test="${member.login && member.member_class == '0'}">
	$('a.audio_view').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#book');
		$('#audio_no').val($(this).data('audiono'));
		$('#editMode').val('BORROW_RETURN');
		$form.prop('action', '../lending/save.do');
		doAjaxPost($form);
		<c:choose>
		<c:when test="${book.com_code == 'HANS'}">
		hans_read($(this).data('url'));
		</c:when>
		<c:when test="${book.com_code == 'CONT'}">
		cont_read($(this).data('url'));
		</c:when>
		<c:otherwise>
		window.open($(this).data('url'));
		</c:otherwise>
		</c:choose>
	});
	</c:when>
<%--
	<c:when test="${member.login}">
	$('a.audio_view').on('click', function(e) {
		e.preventDefault();
		alert('소속 도서관 회원만 이용 가능합니다.');
	});
	</c:when>
--%>
	<c:otherwise>
	$('a.audio_view').on('click', function(e) {
		e.preventDefault();
		alert('로그인 후 이용 가능합니다.');
		location.href = '/elib/intro/login/index.do?menu_idx=4&before_url=' + encodeURIComponent(window.location.pathname + window.location.search + window.location.hash);
	});
	</c:otherwise>
	</c:choose>
	</c:if>

	//$('#comments').load('/${homepage.context_path}/module/elib/book/comments.do?book_idx=${book.book_idx}');

	<c:if test="${param.show_comments == 'Y'}">
	$('div.tabmenu > ul > li > a[data-target="comments"]').click();
	</c:if>
});

function hans_read(url) {
	var features = 'width=1120,height=710,scrollbars=yes';
	var popupPlayer = window.open(url, "HANS", features);
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.busan.go.kr 추가");
		return false;
	}
}

function cont_read(url) {
	var width = 1150, height = 800;
	if(url.indexOf('gbelib_contents_player.php') > -1) {
		width = 800;
		height = 700;
	}
	var popupPlayer = window.open(url, "CONT", 'width='+width+',height='+height+',scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.busan.go.kr 추가");
		return false;
	}
}

function cont2_read(url) {
	var dimension = 'width=750,height=600';
	if(url.indexOf('gbelib_contents_player.php') > -1) {
		dimension = 'width=1024,height=768';
	}
	var popupPlayer = window.open(url, "CONT2", dimension+',scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.busan.go.kr 추가");
		return false;
	}
}

function glob_read(url) {
	var popupPlayer = window.open(url, "GLOB", 'width=710,height=527,scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.busan.go.kr 추가");
		return false;
	}
}

function ybmn_read(url) {
	var popupPlayer = window.open(url, "YBMN", 'width=835,height=650,scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.busan.go.kr 추가");
		return false;
	}
}

function yesb_read(url) {
	var popupPlayer = window.open(url, "YESB", 'width=715,height=415,scrollbars=yes');
	if (popupPlayer == null) {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n팝업 차단 기능을 해제하지 않으면\n정상적인 전자책을 이용하실 수 없습니다.\n\n* 차단 해제 방법 \n설정 - 인터넷 옵션 - 개인정보 - 팝업차단 설정\n허용할 웹 사이트 주소 : *.busan.go.kr 추가");
		return false;
	}
}

function go_to_login() {
	alert('로그인 후 이용 가능합니다.');
	location.href = '/elib/intro/login/index.do?menu_idx=4&before_url=' + encodeURIComponent(window.location.pathname + window.location.search + window.location.hash);
}
</script>

<c:if test="${param.from_search == 'Y'}">
<form:form modelAttribute="book" id="detailForm" action="../search/index.do" method="post">
<form:hidden path="menu_idx" value="${param.menu_idx}"/>
<form:hidden path="book_idx" value="${param.book_idx}"/>
<form:hidden path="viewPage" value="${param.viewPage}"/>
<form:hidden path="search_text" value="${param.search_text}"/>
<form:hidden path="search_type" value="${param.search_type}"/>
<form:hidden path="type" value="${param.type}"/>
<form:hidden path="author_name" value="${param.author_name}"/>
<form:hidden path="book_pubname" value="${param.book_pubname}"/>
<form:hidden path="book_year" value="${param.book_year}"/>
<form:hidden path="rowCount" value="${param.rowCount}"/>
</form:form>
</c:if>

<form:form modelAttribute="book" method="GET" action="view.do">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx" value="${param.menu_idx}"/>
<form:hidden path="menu" value="${param.menu}"/>
<form:hidden path="type"/>
<form:hidden path="sortField" value="${param.sortField}"/>
<form:hidden path="sortType" value="${param.sortType}"/>
<form:hidden path="viewPage" value="${param.viewPage}"/>
<form:hidden path="parent_id" value="${param.parent_id}"/>
<form:hidden path="com_code" value="${param.com_code}"/>
<form:hidden path="book_idx" value="${param.book_idx}"/>
<form:hidden path="lesson_no"/>
<form:hidden path="audio_no"/>

<div class="serial-wrap">
	<div class="sview">
		<div class="sinfo">
			<div class="thumb">
				<c:if test="${not empty book.book_image}">
				<c:if test="${book.bestbook_idx > 0}">
				<img src="/resources/homepage/elib/img/book_best.png" alt="베스트도서" style="position:relative; top: 43px; left: -17px; border: 0px;"/>
				</c:if>
				<img src="${book.book_image}" alt="${book.book_name}">
				</c:if>
				<c:if test="${empty book.book_image}">
				<p class="noImg">
					<img src="/resources/common/img/noImg.gif" alt="noImage"/>
				</p>
				</c:if>
			</div>
			<div class="info">
				<ul>
					<li>
						<b>${fn:escapeXml(book.book_name)}</b>
					</li>
					<li>카테고리 : ${fn:escapeXml(book.parent_name)} &gt; ${fn:escapeXml(book.cate_name)}</li>
					<li>저자 : ${fn:escapeXml(book.author_name)}<span class="txt-bar">&nbsp;</span>출판사 : ${fn:escapeXml(book.book_pubname)}<span class="txt-bar">&nbsp;</span>출판년도 : ${fn:escapeXml(book.book_pubdt)}</li>
					<li>공급사 : ${fn:escapeXml(book.comp_name)}
						<c:if test="${not empty viewer_url}">
						<span class="txt-bar">&nbsp;</span><a href="${viewer_url}" target="_blank" style="color:#fe6d02;">뷰어 다운로드 페이지 이동</a>
						</c:if>
					</li>
					<li>소속도서관: ${fn:escapeXml(book.library_name)}</li>
<%--
					<li>대출 가능 여부: ${fn:escapeXml(book.status)}<span class="txt-bar">&nbsp;</span>대출 : ${fn:escapeXml(book.book_lend)}<%-- / ${fn:escapeXml(book.max_lend)}--%><%--<span class="txt-bar">&nbsp;</span>예약 : ${fn:escapeXml(book.book_reserve)}</li>
--%>
					<li>지원 기기: ${fn:escapeXml(book.label)}<span class="txt-bar">&nbsp;</span>서비스 형태: ${fn:escapeXml(book.format)}</li>
					<li>좋아요: ${fn:escapeXml(book.recommend_cnt)}</li>
				</ul>
			</div>
			<br/>
			<div class="sbtn">
				<c:choose>
				<c:when test="${book.type == 'WEB'}">
				</c:when>
				<c:when test="${book.type == 'ADO' && (book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD')}">
				</c:when>
<%--
				<c:when test="${book.type == 'ADO' && book.com_code == 'HANS' && (!isMobile || empty i.mobile_link_url)}">
				<a href="#" class="btn btn1" id="book_view" data-url="${book.link_url}"><span>바로보기</span></a>
				</c:when>
				<c:when test="${book.type == 'ADO' && book.com_code == 'HANS' && isMobile}">
				<a href="#" class="btn btn1" id="book_view" data-url="${book.mobile_link_url}"><span>바로보기</span></a>
				</c:when>
				<c:when test="${book.type == 'ADO' && book.com_code != 'FXLI' && (!isMobile || empty book.mobile_link_url)}">
				<a href="#" class="btn btn1" id="book_view" data-url="${book.link_url}&user_id=${member.member_id}&user_name=${member.member_id}"><span>바로보기</span></a>
				</c:when>
				<c:when test="${book.type == 'ADO' && book.com_code != 'FXLI' && isMobile}">
				<a href="#" class="btn btn1" id="book_view" data-url="${book.mobile_link_url}&user_id=${member.member_id}&user_name=${member.member_id}"><span>바로보기</span></a>
				</c:when>
--%>
				<c:when test="${book.status == '대출 가능'}">
				<a href="#" class="btn btn1" id="book_borrow"><span>대출하기</span></a>
				</c:when>
				<c:when test="${book.status == '예약 가능'}">
				<a href="#" class="btn btn2" id="book_reserve"><span>예약하기</span></a>
				</c:when>
				<c:when test="${book.status == '3'}">
<%--
				<a href="#" class="btn btn1" id="book_return"><span>반납하기</span></a>
				<a href="#" class="btn btn1" id="book_extend"><span>대출 연장</span></a>
--%>
				</c:when>
				<c:when test="${book.status == '4'}">
<%--
				<a href="#" class="btn btn2" id="book_cancel"><span>예약 취소</span></a>
--%>
				</c:when>
				<c:when test="${book.status == '5'}">
				</c:when>
				</c:choose>
				<a href="#" class="btn btn3" id="book_recommend"><span>좋아요</span></a>
				<a href="#" class="btn btn4" id="book_addfavorite"><span>나의 관심도서</span></a>
			</div>
		</div>
		<div class="tabmenu tab1">
			<c:choose>
			<c:when test="${book.type == 'WEB'}">
			<ul>
				<li class="active"><a href="#" data-target="chapters">회차</a></li>
				<li class=""><a href="#" data-target="book_info">강좌 소개</a></li>
				<li class=""><a href="#" data-target="author_info">강사 소개</a></li>
				<li class=""><a href="#" data-target="book_table">목차</a></li>
				<!-- <li class=""><a href="#" data-target="comments">서평</a></li> -->
			</ul>
			</c:when>
			<c:when test="${book.type == 'ADO' && (book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD')}">
			<ul>
				<li class="active"><a href="#" data-target="chapters">회차</a></li>
				<li class=""><a href="#" data-target="book_info">도서 소개</a></li>
				<li class=""><a href="#" data-target="author_info">저자 소개</a></li>
				<li class=""><a href="#" data-target="book_table">목차</a></li>
				<!-- <li class=""><a href="#" data-target="comments">서평</a></li> -->
			</ul>
			</c:when>
			<c:otherwise>
			<ul>
				<li class="active"><a href="#" data-target="book_info">도서 소개</a></li>
				<li class=""><a href="#" data-target="author_info">저자 소개</a></li>
				<li class=""><a href="#" data-target="book_table">목차</a></li>
				<!-- <li class=""><a href="#" data-target="comments">서평</a></li> -->
			</ul>
			</c:otherwise>
			</c:choose>
		</div>
		<c:choose>
		<c:when test="${book.type == 'WEB'}">
		<c:if test="${book.com_code == 'YBMN' && isMobile}">
		<p><a href="https://itunes.apple.com/kr/app/aqua-nmanager/id1048325731?mt=8" target="_blank"><span style="color: red; font-weight: bold;">* 아이폰에서 재생이 되지 않을 경우 [플레이어 수동 설치] 클릭</span></a></p>
		</c:if>
		<c:if test="${book.com_code == 'ARTN' && isMobile}">
		<p><span style="color: red; font-weight: bold;">* 로그인 화면이 나타나면 비밀번호에 아이디를 입력해주세요. 예) 아이디: CPgbelib / 비번: gbelib</span></p>
		</c:if>
		<div id="chapters" class="tab_body">
			<table>
				<thead>
					<tr>
						<th>회차</th>
						<th>제목</th>
						<th>내용보기</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
					<c:when test="${empty courseList}">
					<tr>
						<td colspan="3">회차가 없습니다.</td>
					</tr>
					</c:when>
					<c:otherwise>
					<c:forEach items="${courseList}" var="i" varStatus="status">
					<tr>
						<td>${i.lesson_no}</td>
						<td>${i.lesson_name}</td>
						<c:choose>
						<c:when test="${book.com_code == 'ARTN'}">
							<c:choose>
							<c:when test="${isMobile && member.login && member.member_class eq '0'}">
							<td><a href="#" class="btn btn1 course_view" data-url="${i.mobile_url}&u=CP${member.member_id}" data-lessonno="${i.lesson_no}"><span>바로보기</span></a></td>
							</c:when>
							<c:when test="${member.login && member.member_class eq '0'}">
							<td><a href="#" class="btn btn1 course_view" data-url="${i.lesson_url}&UserID=${member.member_id}" data-lessonno="${i.lesson_no}"><span>바로보기</span></a></td>
							</c:when>
							<c:otherwise>
							<td><a href="#" class="btn btn1 course_view"><span>바로보기</span></a></td>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${book.com_code == 'YESB'}">
							<c:choose>
							<c:when test="${isMobile && member.login && member.member_class eq '0'}">
							<td><a href="#" class="btn btn1 course_view" data-url="${i.mobile_url}&user_id=${member.member_id}" data-lessonno="${i.lesson_no}"><span>바로보기</span></a></td>
							</c:when>
							<c:when test="${member.login && member.member_class eq '0'}">
							<td><a href="#" class="btn btn1 course_view" data-url="${i.lesson_url}&user_id=${member.member_id}" data-lessonno="${i.lesson_no}"><span>바로보기</span></a></td>
							</c:when>
							<c:otherwise>
							<td><a href="#" class="btn btn1 course_view"><span>바로보기</span></a></td>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
							<c:when test="${isMobile && member.login && member.member_class eq '0'}">
							<td><a href="#" class="btn btn1 course_view" data-url="${i.mobile_url}" data-lessonno="${i.lesson_no}"><span>바로보기</span></a></td>
							</c:when>
							<c:when test="${member.login && member.member_class eq '0'}">
							<td><a href="#" class="btn btn1 course_view" data-url="${i.lesson_url}" data-lessonno="${i.lesson_no}"><span>바로보기</span></a></td>
							</c:when>
							<c:otherwise>
							<td><a href="#" class="btn btn1 course_view"><span>바로보기</span></a></td>
							</c:otherwise>
							</c:choose>
						</c:otherwise>
						</c:choose>
					</tr>
					</c:forEach>
					</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		</c:when>
		<c:when test="${book.type == 'ADO' && (book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD')}">
		<div id="chapters" class="tab_body">
			<table>
				<thead>
					<tr>
						<th>회차</th>
						<th>제목</th>
						<th>내용보기</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
					<c:when test="${empty audioList}">
					<tr>
						<td colspan="3">회차가 없습니다.</td>
					</tr>
					</c:when>
					<c:otherwise>
					<c:forEach items="${audioList}" var="i" varStatus="status">
					<tr>
						<td>${i.audio_no}</td>
						<td>${i.audio_name}</td>
						<td>
						<c:choose>
						<c:when test="${book.com_code == 'HANS' && (!isMobile || empty i.mobile_link_url) && member.login && member.member_class eq '0'}">
						<a href="#" class="btn btn1 audio_view" data-url="${i.link_url}&userId=${member.member_id}" data-audiono="${i.audio_no}"><span>바로듣기</span></a>
						</c:when>
						<c:when test="${book.com_code == 'HANS' && isMobile && member.login && member.member_class eq '0'}">
						<a href="#" class="btn btn1 audio_view" data-url="${i.mobile_link_url}&userId=${member.member_id}" data-audiono="${i.audio_no}"><span>바로듣기</span></a>
						</c:when>
						<c:when test="${(book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD') && (!isMobile || empty i.mobile_link_url) && member.login && member.member_class eq '0'}">
						<a href="#" class="btn btn1 audio_view" data-url="${i.link_url}&user_id=${member.member_id}&user_name=${member.member_id}" data-audiono="${i.audio_no}"><span>바로듣기</span></a>
						</c:when>
						<c:when test="${(book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD') && isMobile && member.login && member.member_class eq '0'}">
						<a href="#" class="btn btn1 audio_view" data-url="${i.mobile_link_url}&user_id=${member.member_id}&user_name=${member.member_id}" data-audiono="${i.audio_no}"><span>바로듣기</span></a>
						</c:when>
<%--
						<c:when test="${isMobile &&member.login && member.member_class eq '0'}">
						<td><a href="#" class="btn btn1 audio_view" data-url="${i.mobile_link_url}" data-audiono="${i.audio_no}"><span>바로듣기</span></a></td>
						</c:when>
						<c:when test="${member.login && member.member_class eq '0'}">
						<td><a href="#" class="btn btn1 audio_view" data-url="${i.link_url}" data-audiono="${i.audio_no}"><span>바로듣기</span></a></td>
						</c:when>
--%>
						<c:otherwise>
						<a href="#" class="btn btn1 audio_view"><span>바로듣기</span></a>
						</c:otherwise>
						</c:choose>
						</td>
					</tr>
					</c:forEach>
					</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		</c:when>
		</c:choose>
		<div id="book_info" class="tab_body" <c:if test="${book.type == 'WEB' || (book.type == 'ADO' && (book.com_code ne 'FXLI' and book.com_code ne 'KYOB' and book.com_code ne 'ALAD'))}">style="display: none;"</c:if>>
			<c:set var="book_info" value="${fn:replace(book.book_info, crlf, '<br/>')}"></c:set>
			${book_info}
		</div>
		<div id="author_info" class="tab_body" style="display: none;">
			<c:set var="author_info" value="${fn:replace(book.author_info, crlf, '<br/>')}"></c:set>
			${author_info}
		</div>
		<div id="book_table" class="tab_body" style="display: none;">
			<c:set var="book_table" value="${fn:replace(book.book_table, crlf, '<br/>')}"></c:set>
			${book_table}
		</div>
		<div id="comments" class="tab_body" style="display: none;">
		</div>
		<br/>
		<div class="sbtn">
			<a href="#" id="goto_list" class="btn"><span>목록으로</span></a>
		</div>
	</div>
</div>
</form:form>
