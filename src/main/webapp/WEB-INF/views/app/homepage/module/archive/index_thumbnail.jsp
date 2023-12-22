<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<script type="text/javascript">
	$(function() {
		$('a.noView').on('click', function(e) {
			e.preventDefault();
			alert('뷰어 파일이 존재하지 않습니다.');
			return false;
		});
		
		$('a#by_popularity').on('click', function(e) {
			e.preventDefault();
			$('#sortField').val('view_count');
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
		});
		
		$('a#by_title').on('click', function(e) {
			e.preventDefault();
			$('#sortField').val('title');
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
		});
		
		$('a#by_date').on('click', function(e) {
			e.preventDefault();
			$('#sortField').val('add_date');
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
		});
		
		$('a.view').on('click', function(e) {
			e.preventDefault();
			$('form#archiveViewForm input#large_code').val($(this).attr('keyValue1'));
			$('form#archiveViewForm input#book_idx').val($(this).attr('keyValue4'));
			if (doAjaxPost($('form#archiveViewForm'))) {
				var url = $(this).attr('keyValue5');

				window.open(url, '_blank', 'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
			}
		});
		
		$('a#viewList').on('click', function(e) {
			e.preventDefault();
			$('#view_mode').val('list');
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#archiveListForm')));
		});
		
		$('a#viewThumbnail').on('click', function(e) {
			e.preventDefault();
			$('#view_mode').val('thumbnail');
			$('#viewPage').val(1);
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

<form:form id="archiveViewForm" action="save.do" method="POST">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<input type="hidden" id="editMode" name="editMode" value="VIEW"/>
	<input type="hidden" id="large_code" name="large_code" value="">
	<input type="hidden" id="book_idx" name="book_idx" value="">
</form:form>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form id="archiveListForm" modelAttribute="archive" action="index.do" method="get" onsubmit="return false;">
<form:hidden path="menu_idx"/>
<form:hidden path="sortField"/>
<form:hidden path="view_mode"/>
<form:hidden path="large_code"/>
<form:hidden path="type"/>
<form:hidden path="product_date"/>
<form:hidden path="producer_name"/>
<form:hidden path="original_owner"/>
<form:hidden path="region"/>
<form:hidden path="person"/>
<form:hidden path="era"/>

<div class="archive_top">
	<!-- 전자책 총 권수, 검색 조건 시작-->
	<div class="sub001">
		<div class="lsort">
			<span><span class="dp_none">전체자료</span> <b><fmt:formatNumber value="${archiveCnt}" pattern="#,###" /></b>건</span>
		</div>
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
			
			<div class="comment-bok" style="text-align:center;font-size:12px;letter-spacing:-0.6px;color:#324592;">
				<c:choose>
					<c:when test="${i.copyright eq '공공누리 1유형 이미지'}">
						<div class="gg4-box">
							<img src="/resources/homepage/archive/img/openright_01.gif" alt="${i.copyright}"/>
							<span class="comment">${i.information_ment}</span>
						</div>
					</c:when>
					<c:when test="${i.copyright eq '공공누리 2유형 이미지'}">
						<div class="gg4-box">
							<img src="/resources/homepage/archive/img/openright_02.gif" alt="${i.copyright}"/>
							<span class="comment">${i.information_ment}</span>
						</div>
					</c:when>
					<c:when test="${i.copyright eq '공공누리 3유형 이미지'}">
						<div class="gg4-box">
							<img src="/resources/homepage/archive/img/openright_03.gif" alt="${i.copyright}"/>
							<span class="comment">${i.information_ment}</span>
						</div>
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

</form:form>