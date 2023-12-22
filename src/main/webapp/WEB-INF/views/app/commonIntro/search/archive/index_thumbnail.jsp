<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/search.css" />
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>

<script>
$(document).ready(function() {
	
	$('a.noView').on('click', function(e) {
		e.preventDefault();
		alert('뷰어 파일이 존재하지 않습니다.');
		return false;
	});
	
	$('a#by_popularity').on('click', function(e) {
		e.preventDefault();
		$('#sortField').val('view_count');
		doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
	});
	
	$('a#by_title').on('click', function(e) {
		e.preventDefault();
		$('#sortField').val('title');
		doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
	});
	
	$('a#by_date').on('click', function(e) {
		e.preventDefault();
		$('#sortField').val('add_date');
		doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
	});
	
	$('a.view').on('click', function(e) {
		e.preventDefault();
		$('form#archiveViewForm input#large_code').val($(this).attr('keyValue1'));
		$('form#archiveViewForm input#mid_code').val($(this).attr('keyValue2'));
		$('form#archiveViewForm input#small_code').val($(this).attr('keyValue3'));
		$('form#archiveViewForm input#book_idx').val($(this).attr('keyValue4'));
		if (doAjaxPost($('form#archiveViewForm'))) {
			var url = $(this).attr('keyValue5');

			window.open(url, '_blank', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
		}
	});
	
	//외국어 입력기
	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('title','vk');
	});
	
	//검색하기
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('index.do', $('form#archiveListForm').serialize());
	});
	
	//검색초기화
	$('a#reset-btn').on('click', function(e) {
		e.preventDefault();
		location.href='/${homepage.context_path}/intro/search/archive/index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
		$('#title').focus();
	});
	//리스트형 검색
	$('a#viewList').on('click', function(e) {
		e.preventDefault();
		$('#view_mode').val('list');
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
	});
	//썸네일형 검색
	$('a#viewThumbnail').on('click', function(e) {
		e.preventDefault();
		$('#view_mode').val('thumbnail');
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
	});
	//결과 내 재검색
	$('a#subSearch').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		$('#research').val(true);
		doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
	});
});

function image_popup(filename, large_code, book_idx) {
	var ajaxData = {
			'large_code' : large_code,
			'book_idx' : book_idx,
			'editMode' : 'VIEW'
	};
	
	$.ajax({
		type: "POST",
		url: '/archive/module/archive/save.do',
		data: ajaxData
	});
	
	var url = filename;
	var imgObj = new Image();
	imgObj.src = "/data/archive/"+url+"";
	imageWin = window.open("", "profile_popup", "width=" + imgObj.width + "px, height=" + imgObj.height + "px"); 
	imageWin.document.write("<html><body style='margin:0'>"); 
	imageWin.document.write("<a href=javascript:window.close()><img src='" + imgObj.src + "' border=0></a>"); 
	imageWin.document.write("</body><html>"); 
	imageWin.document.title = imgObj.src;
}

function addViewCount(large_code, book_idx) {
	var ajaxData = {
			'large_code' : large_code,
			'book_idx' : book_idx,
			'editMode' : 'VIEW'
	};
	
	$.ajax({
		type: "POST",
		url: '/archive/module/archive/save.do',
		data: ajaxData
	});
}
</script>

<style>
	.search-form .detail_search{border:none;padding:0;}

	.search-form .detail_search .section{position:relative;}
	.search-form .detail_search .section select{width:100%;}

	.search-form .detail_search .section .title-box{width:100%;margin:0;margin-bottom:10px;}
	.search-form .detail_search .section .title-box input{width:calc(100% - 80px);height:50px;line-height:50px;font-size:20px;padding-left:20px;}
	.search-form .detail_search .section .title-box .btnNew2{position:absolute;top:10px;right:10px;}

	.re-search-box{position:absolute;right:330px;width:38%;}
	.re-search-box input{border-radius:3px;border:1px solid #ddd;padding:8px 10px;}
	.re-search-box a{padding:13px 3% 9px;border-radius:3px;font-size:13px;}

	.search-form .detail_search a{font-size:13px;}
	.search-form .detail_search a.btnNew2{background:none}

	.search-form .detail_search .section .vk-btn{float:right;width:60%;}
	.search-form .detail_search .section .vk-btn a{border:none !important;}

	.search-category{position:absolute;width:150px;float:left;z-index:9;top:30px;left:30px;}
	.search-category select{border:none;}

	.bbs_archive .flexbox .info p{font-size:13px;color:#888;margin-bottom:0;}

	.bbs_archive .flexbox span.tit{padding-top:3px;}	

	.search-form .detail_search .btn_w{padding-top:15px;padding-bottom:35px;margin-top:4px;}
	.search-form .detail_search .section .vk-btn a, a.btnNew2, a.btnNew4{letter-spacing:-0.5px;border:none;}
	a.btnNew4{padding:8px 2%;}

	.count{position:absolute;top:10px;}

	@media all and (max-width:1024px){
		.list_cate{right:300px;}

		.re-search-box{right:340px;}
	}

	@media all and (max-width:900px){
		.re-search-box input{padding:7px 10px;width:100%;}
		.re-search-box a{position:absolute;top:0;right:0;padding:9px 2% 7px;border-radius:0;}

		.count{top:auto;bottom:15px;}
	}

	@media all and (max-width:768px){
		.search-category{width:130px;}
		.search-form .detail_search .section select{font-size:17px;}

		.search-form .detail_search .section .title-box input{width:calc(100% - 40px);font-size:17px;margin-left:0;}

		.bbs_archive .flexbox span.tit{padding:10px 0 12px;}

		.bbs_archive .flexbox .info p{font-size:12px;}

		.re-search-box{position:relative;width:100%;right:0;margin-top:-30px;margin-bottom:5px;}
		.re-search-box input{padding:7px 10px;width:100%;}
		.re-search-box a{position:absolute;top:0;right:0;padding:9px 2% 7px;border-radius:0;}

		.search-form .detail_search .section .vk-btn{margin-bottom:0;}
		.search-form .detail_search .section .vk-btn a{padding:7px 4%;}

		.count{top:auto;bottom:15px;}
	}

	@media all and (max-width:750px){
		.count{font-size:0.8rem;}

		.list_cate{right:180px;}
	}

	@media all and (max-width:650px){
		.search-category{width:100px;}
		.search-form .detail_search .section select{font-size:16px;}

		.search-form .detail_search .section .title-box input{font-size:16px;}

		.count{font-size:0.8rem;}

		.list_cate{right:150px;}
	}

	@media all and (max-width:425px){
		.search-category{width:80px;}
		.search-form .detail_search .section select{font-size:14px;}

		.search-form .detail_search .section .title-box input{font-size:14px;border-left:none;}

		.search-form .detail_search .section .vk-btn a, a.btnNew2, a.btnNew4{font-size:11px;letter-spacing:-0.5px;}

		.re-search-box{width:100%;}
		.re-search-box input{}
		.re-search-box a{font-size:11px;}
	}
</style>

<form:form id="archiveViewForm" action="/archive/module/archive/save.do" method="POST">
	<input type="hidden" id="editMode" name="editMode" value="VIEW"/>
	<input type="hidden" id="large_code" name="large_code" value="">
	<input type="hidden" id="mid_code" name="mid_code" value="">
	<input type="hidden" id="small_code" name="small_code" value="">
	<input type="hidden" id="book_idx" name="book_idx" value="">
</form:form>
<form:form id="archiveListForm" modelAttribute="archive" action="index.do" method="GET" autocomplete="off">
<form:hidden path="menu_idx"/>
<form:hidden path="sortField"/>
<form:hidden path="view_mode"/>
<form:hidden path="research" value="false"/>
<!-- contents-title
<div id="contents-title">
	<h2>어떤 자료<span style="font-weight:300">를 찾고 싶으세요?...</span></h2>
</div>
<!-- /contents-title-->

<div class="search-wrap">

	<div class="search-form">

		<!-- 검색하기_일반 -->
		<div class="searchbox detail_search">
			<div class="section">
				<div class="search-category">				
					<form:select path="search_type" class="selectmenu">
						<form:option value="all">전체</form:option>
						<form:option value="title">제목</form:option>
						<form:option value="description">키워드</form:option>
						<form:option value="addle_data_yn">애뜰자료</form:option>
					</form:select>
				</div>
				<div class="title-box">
					<form:input path="search_text" class="text-area" placeholder="검색어를 입력해주세요"/>
					<a id="search-btn" class="btnNew2"><img src="/resources/homepage/archive/img/search-btn.png" alt="검색"></a>
				</div>
				<div class="vk-btn">
					<a id="vk-popup" class="btnNew2">다국어입력기</a>
				</div>

				<div class="end"></div>
			</div>
		</div>
		<!--// 검색하기_일반 -->

		<br/>
		<div id="autoFill">
		</div>
	</div>

	<c:if test="${not empty paging and archive.totalDataCount eq 0}">
	<p style="text-align: center;">
		<b>찾으시는 자료가 없습니다. </b>
	</p>
	</c:if>
</div>

<c:if test="${archive.totalDataCount > 0}">
	<div class="archive_top" style="position:relative;">
	<!-- 전자책 총 권수, 검색 조건 시작-->
	<div class="sub001">
		<c:if test="${not empty archive.search_text}">
		<div class="re-search-box">
			<form:input path="research_text" id="subSearchText"/> <a href="#" id="subSearch" class="btnNew2">결과 내 재검색</a>
		</div>
		</c:if>

		<div class="count">전체자료 <b><fmt:formatNumber value="${archiveCnt}" pattern="#,###" /></b>건</div>
		
		<div class="list_cate">
			<ul>
				<li class="f_l <c:if test="${archive.view_mode eq 'list'}">on</c:if>">
					<a href="" id="viewList"><img src="/resources/common/img/<c:choose><c:when test="${archive.view_mode == 'list'}">list01_on.png</c:when><c:otherwise>list01_off.png</c:otherwise></c:choose>" alt="목록타입1" title="목록타입1"></a>
				</li>
				<li class="f_2 <c:if test="${archive.view_mode eq 'thumbnail'}">on</c:if>">
					<a href="" id="viewThumbnail"><img src="/resources/common/img/<c:choose><c:when test="${archive.view_mode == 'thumbnail'}">list02_on.png</c:when><c:otherwise>list02_off.png</c:otherwise></c:choose>" alt="목록타입2" title="목록타입2"></a>
				</li>
			</ul>
		</div>

		<div class="sort">
			<a href="#" id="by_popularity" class="btn<c:if test="${archive.sortField == 'view_count'}"> active</c:if>">인기순</a>
			<a href="#" id="by_title" class="btn<c:if test="${archive.sortField == 'title'}"> active</c:if>">제목순</a>
			<a href="#" id="by_date" class="btn<c:if test="${archive.sortField == 'add_date'}"> active</c:if>">최신순</a>
		</div>
	</div>
	<div style="clear:both;"></div>
</div>
<div class="table-wrap">
	<ul class="bbs_module_thumbnail" id="board_tbody">
		<c:forEach var="i" varStatus="status" items="${archiveList}">
		<li>
			<div class="thumb">
				<c:choose>
				<c:when test="${not empty i.image_file_name}">
				<img src="${i.image_file_path}${i.image_file_name}" alt="${i.image_file_name}" onError="this.src='/resources/common/img/noImg.gif'"/>
				</c:when>
				<c:otherwise>
				<img src="/resources/common/img/noImg.gif" alt="noImage"/>
				</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<div class="meta">
					<p class="txt0">${fn:escapeXml(i.large_code_name)}</p>
					<p class="txt1">${fn:escapeXml(i.type)}</p>
					<p class="txt2">${fn:escapeXml(i.title)}</p>
					<p class="txt3">조회수 <b>${i.view_count}</b></p>
					<p class="txt4">생산연도 : ${fn:escapeXml(i.product_year)}</p>
					<p class="txt5">생산자명 : ${fn:escapeXml(i.producer_name)}</p>
					<p class="txt6">원본소장처 : ${fn:escapeXml(i.original_owner)}</p>
				</div>
			</div>
			<div style="text-align:center;">
				<!-- 전자책 -->
				<c:if test="${not empty i.view_file_path}">
					<a href="${i.view_file_path}/index.html" class="btn view ebook-view-btn" target="_blank" keyValue1="${i.large_code}" keyValue4="${i.book_idx}" keyValue5="${i.view_file_path}/index.html"></a>
				</c:if>
				<!-- PDF다운 -->
				<c:if test="${not empty i.file_name}">
					<a href="/archive/module/archive/download/${i.large_code}/--/--/${i.book_idx}.do" class="btn pdf-view-btn" onclick="addViewCount('${i.large_code}', '${i.book_idx}');"></a>
				</c:if>
				<!-- 링크 -->
				<c:if test="${not empty i.archive_link}">
					<a href="${i.archive_link}" target="_blank" class="btn link link-btn" onclick="addViewCount('${i.large_code}', '${i.book_idx}');"></a>
				</c:if>
				<!-- 사진 -->
				<c:if test="${not empty i.file_name and (i.provide_method eq '사진' or i.provide_method eq '고문헌')}">
					<c:set var="text" value="${i.file_name}" />
					<c:if test="${fn:contains(text, 'png') or fn:contains(text, 'jpg')}">
						<a href="javascript:void(0);" class="btn image picture-btn" onclick="image_popup('${i.file_name}', '${i.large_code}', '${i.book_idx}');"></a>
					</c:if>
				</c:if>
				<!-- 영상 -->
				<c:if test="${not empty i.file_name and i.provide_method eq '영상'}">
					<a href="/data/archive/${i.file_name}" class="btn video video-btn" target="_blank" onclick="addViewCount('${i.large_code}', '${i.book_idx}');"></a>
				</c:if>
			</div>
			
			<div class="comment-bok" style="text-align:center;font-size:13px;color:#324592;">
				<c:choose>
					<c:when test="${i.copyright eq '공공누리 1유형 이미지'}">
						<img src="/resources/homepage/archive/img/openright_01.gif" style="width:11%; margin-top:22px;" alt="${i.copyright}"/>
						<span class="comment">${i.information_ment}</span>
					</c:when>
					<c:when test="${i.copyright eq '공공누리 2유형 이미지'}">
						<img src="/resources/homepage/archive/img/openright_02.gif" style="width:11%; margin-top:22px;" alt="${i.copyright}"/>
						<span class="comment">${i.information_ment}</span>
					</c:when>
					<c:when test="${i.copyright eq '공공누리 3유형 이미지'}">
						<img src="/resources/homepage/archive/img/openright_03.gif" style="width:11%; margin-top:22px;" alt="${i.copyright}"/>
						<span class="comment">${i.information_ment}</span>
					</c:when>
					<c:when test="${i.copyright eq '공공누리 4유형 이미지'}">
						<div class="gg4-box">
							<img src="/resources/homepage/archive/img/openright_04.gif" alt="${i.copyright}"/>
							<span class="comment">${i.information_ment}</span>
						</div>
					</c:when>
					<c:otherwise>
						<span class="comment">${i.information_ment}</span>
					</c:otherwise>
				</c:choose>
			</div>
		</li>
		</c:forEach>
	</ul>
</div>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#archiveListForm"/>
		<jsp:param name="pagingUrl" value="index.do"/>
	</jsp:include>
</c:if>
</form:form>

