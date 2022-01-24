<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<script type="text/javascript">
$(document).ready(function() {
	
	$('a#add_book_btn').on('click', function(e) {
		e.preventDefault();
		
		if($('div#theme-list>ul>li').length >= 12) {
			return false;
		}
		
		if ('${homepage.context_path}' == '') {
			alert('홈페이지에서만 가능합니다');
		} else {
			var ilusList = window.open('/${homepage.context_path}/intro/search/indexForBoard.do', 'ilusLnkBook', 'width=800 height=600,scrollbars=yes');
		}
	});
	
	// 컬렉션 상세보기
	// manage_code, ctrlno 필수 값
	// menu_idx, board_idx, maange_idx 게시판 필수 값
	// 위 파라미터로 API 조회
	// 
	$('a.detail-btn').on('click', function(e) {
		e.preventDefault();
// 		doGetLoad("${homepage.context_path}/intro/search/themeDetail.do", serializeCustom($('form#board')));
		$('input#regNo').val($(this).data('regno'));
		doGetLoad("themeDetail.do", serializeCustom($('form#themeDetail')));
	});
	
	$('a#imsi_v_del').on('click', function(e) {
		e.preventDefault();
		$('input.imsi_v:checked').each(function(i, v) {
			if(i == 0) {
				$('input#theme_imsi_key').val($(this).attr('id'));
			} else {
				$('input#theme_imsi_key').val($('input#theme_imsi_key').val() + ',' + $(this).attr('id'));
			}
		});
		
		$('input#editMode_theme').val('THEME_DEL');
		doAjaxPost($('form#boardTheme'));
	});
	
	$('a#imsi_v_all').on('click', function(e) {
		e.preventDefault();
		var checked = $(this).data('checked');
		if(checked) {
			$('input.imsi_v').prop('checked', false);
			$(this).data('checked', false);
		} else {
			$('input.imsi_v').prop('checked', true);
			$(this).data('checked', true);
		}
	});
	
});

function getLasData(arg) {
	arg = arg.split('///');
	//${i.TITLE}//${i.PUBLER_YEAR}//${i.AUTHOR}//${i.PUBLER}//${i.ISBN}//${i.CALL_NO}//${i.i.COVER_SMALLURL}//${i.PLACE_NAME}//${i.CTRLNO}
	// imsi_v_3 부터 theme list 컬럼을사용
	var imsi_n = $('div#theme-list>ul>li').length + 3;
	$('#theme_imsi_key').val('imsi_v_' + imsi_n);
	$('#theme_imsi_val').val(arg[8]);
	$('#editMode_theme').val('THEMEBOOK');
	
	doAjaxPost($('form#boardTheme'));
}
</script>

<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />

<form:form modelAttribute="board" id="boardTheme" method="POST" action="save.do">
<form:hidden path="menu_idx" id="menu_idx_theme"/>
<form:hidden path="manage_idx" id="manage_idx_theme"/>
<form:hidden path="board_idx" id="board_idx_theme"/>
<form:hidden path="editMode" id="editMode_theme"/>
<form:hidden path="theme_imsi_key"/>
<form:hidden path="theme_imsi_val"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<form name="librarySearch" id="themeDetail" action="themeDetail" method="get">
<input type="hidden" name="menu_idx" value="${board.menu_idx}">
<input type="hidden" name="manage_idx" value="${board.manage_idx}">
<input type="hidden" name="board_idx" value="${board.board_idx}">
<!-- <input type="hidden" name="manageCode" id="manageCode"> -->
<input type="hidden" name="regNo" id="regNo">
</form>

<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<c:if test="${board.delete_yn eq 'Y'}">
<form:hidden path="boardIdxArray"/>
</c:if>
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="wrapper-bbs">
	<div class="bbs-view">
		<h3 style="margin-top:15px;">${board.title}</h3>
		<ul class="con2">
			<li>전시기간 : ${board.imsi_v_1} ~ ${board.imsi_v_2}</li>
			<li>전시장소 : ${fn:substring(board.imsi_v_20, 0, 20)}<c:if test="${fn:length(board.imsi_v_20) > 20}">...</c:if></li>
		</ul>
		<div class="bbs-view-body" style="margin-top:10px;padding:30px 0;border-top:1px solid #aaa;">
			${fn:replace(board.content, crlf, '<br/>')}
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
		
		
		
		<div class="bbs-comment" id="bbs-comment">

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
</div>
<div style="border-top:1px solid #ddd;margin-top:50px;padding-top:10px;">
	<h4>도서목록</h4>
	<div id="theme-list">
		<ul>
			<c:if test="${fn:length(collectionList) < 0}">
			<li>등록된 컬렉션이 없습니다.</li>
			</c:if>
			<c:forEach items="${collectionList}" var="i" varStatus="status">
			<li>
				<input type="checkbox" id="${i.theme_key}" class="imsi_v">
				<a href="#" class="detail-btn" data-regno="${i.REG_NO}">
				<c:choose>
					<c:when test="${empty i.aladin or empty i.aladin.cover}">
					<p class="noImg">
						<img src="/resources/common/img/noImg2.png" alt="noImage"/>
						<span>등록된 이미지가<br/>없습니다.</span>
					</p>
					</c:when>
					<c:otherwise>
					<p>
						<img src="${i.aladin.cover}" alt="${i.TITLE_INFO}">
					</p>
					</c:otherwise>
				</c:choose>
				</a>
				<a href="#" class="detail-btn" data-regno="${i.REG_NO}">
					<p>${i.TITLE_INFO}</p>
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="button bbs-btn right" style="clear: both;">
		<a href="" class="btn" id="imsi_v_all" data-checked="false"><span>전체 선택/해제</span></a>
		<a href="" class="btn" id="imsi_v_del"><span>선택 도서삭제</span></a>
		<a href="" class="btn btn1" id="add_book_btn"><span>도서등록</span></a>
	</div>
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>