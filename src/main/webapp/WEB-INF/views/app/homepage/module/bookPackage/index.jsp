<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

// 	$('#add-btn').on('click', function(e) {
// 		e.preventDefault();
// 		doGetLoad('edit.do', 'editMode=ADD&menu_idx='+$('#menu_idx').val());
// 	});

	$('.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'menu_idx='+$('#menu_idx').val() + '&viewPage='+$('#viewPage').val() + '&book_package_idx='+$(this).attr('keyValue');
		doGetLoad('view.do', formData);
	});

	$('.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('#book_package_idx_d').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#bookPackageDel'))) {
				location.reload();
			};
		}
	});

	// 책 꾸러미 대출 신청
	$('.request-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&book_package_idx='+$(this).attr('keyValue');
		doGetLoad('loanEdit.do', formData);
	});

	$('input#chkAll').on('click', function() {
		$('.categoryChk').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackage').serialize());
	});

	$('.categoryChk').on('click', function() {
		$('input#chkAll').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackage').serialize());
	});

	$('select#grade, select#lender_count').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackage').serialize());
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackage').serialize());
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(bookPackageList)}' > 0) {
			$('#editMode').val('bookPackage');
			$('#bookPackage').attr('method', 'POST');
			$('#bookPackage').attr('action', 'excelDownload.do').submit();
			$('form#bookPackage').submit();

			$('#bookPackage').attr('method', 'GET');
			$('#bookPackage').attr('action', 'index.do');
		} else {
			alert('해당 내역이 없습니다.');
		}
	});

	$('#all-check').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.book_check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.book_check').prop('checked', false);
		}
	});

	$('#delete-check').on('click', function(e) {
		e.preventDefault();
		if($('.book_check:checked').length == 0) {
			alert('삭제할 리스트를 선택하세요.');
			return false;
		}
		if(confirm('선택 항목들을 삭제하시겠습니까?')) {
			$('form#bookPackage').attr('action', 'save.do');
			$('form#bookPackage').attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($('form#bookPackage'))) {
				location.reload();
			}
		}
	});

	$('a.tit-search-btn').on('click', function(e) {
		e.preventDefault();
		var title = $(this).parent('div.btn-box').siblings('div.content-box').find('div.subject a').text();
		var data = 'menu_idx=140&manage_idx=212&search_type=title%2Bcontent&search_text='+title.replace(/ ([(][A-Z][)])| [A-Z]$/g, '');
		doGetLoad('/${homepage.context_path}/board/index.do', data);
	});

});
</script>
<link rel="stylesheet" href="/resources/common/css/bookPackage.css" />

<form:form modelAttribute="bookPackage" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="book_package_idx" id="book_package_idx_d"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="bookPackage" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="book_package_idx"/>

<div id="category-box">
	<form:checkbox path="category" value="all" checked="${fn:contains(bookPackage.category, 'all') ? 'checked' : ''}" label="전체" id="chkAll" class="customCheck"/>
	<form:checkbox path="category" value="000" checked="${fn:contains(bookPackage.category, '000') ? 'checked' : ''}" label="총류" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="100" checked="${fn:contains(bookPackage.category, '100') ? 'checked' : ''}" label="철학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="200" checked="${fn:contains(bookPackage.category, '200') ? 'checked' : ''}" label="종교" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="300" checked="${fn:contains(bookPackage.category, '300') ? 'checked' : ''}" label="사회과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="400" checked="${fn:contains(bookPackage.category, '400') ? 'checked' : ''}" label="자연과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="500" checked="${fn:contains(bookPackage.category, '500') ? 'checked' : ''}" label="기술과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="600" checked="${fn:contains(bookPackage.category, '600') ? 'checked' : ''}" label="예술" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="700" checked="${fn:contains(bookPackage.category, '700') ? 'checked' : ''}" label="언어" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="800" checked="${fn:contains(bookPackage.category, '800') ? 'checked' : ''}" label="문학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="900" checked="${fn:contains(bookPackage.category, '900') ? 'checked' : ''}" label="역사" class="customCheck categoryChk"/>
</div>
<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu new_select_box">
			<form:option value="book_package_subject">서명</form:option>
			<form:option value="keyword">키워드</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
		<button id="search_btn" style="background-color:#2c75cb;border-color:#1962ba;background-image:none;padding:6px 10px;"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
<div class="infodesk">
	<form:select path="grade" cssClass="selectmenu new_select_box">
		<form:option value="">수준별보기</form:option>
		<form:option value="3">초</form:option>
		<form:option value="4">중</form:option>
		<form:option value="5">고</form:option>
	</form:select>
	<form:select path="lender_count" cssClass="selectmenu new_select_box">
		<form:option value="-1">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select>
	<div class="button">
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>도서목록 다운받기</span></a>
<%-- 		<c:if test="${member.admin or authMBA}"> --%>
<!-- 		<a href="#" class="btn btn5 left" id="add-btn"><i class="fa fa-plus"></i><span>등록</span></a> -->
<%-- 		</c:if> --%>
	</div>
</div>
<div>
	<c:forEach items="${bookPackageList}" var="i" varStatus="status">
	<div class="group-box">
<%-- 		<c:if test="${member.admin or authMBA}"> --%>
<%-- 		<form:checkbox path="book_package_arr" cssClass="book_check" value="${i.book_package_idx}"/> --%>
<%-- 		</c:if> --%>
		<div class="img-box">
			<c:choose>
				<c:when test="${not empty i.image_link}">
				<a href="${i.desc_link}" target="_blank">
					<img src="${i.image_link}" alt="${i.book_package_subject}" width="100%" height="100%">
				</a>
				</c:when>
				<c:when test="${not empty i.server_file_name}">
				<a href="#">
					<img src="${getContextPath}/data/bookPackage/${i.server_file_name}" alt="${i.book_package_subject}" width="100%" height="100%">
				</a>
				</c:when>
				<c:otherwise>
				<img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="content-box">
			<div class="subject">
				<c:if test="${i.lender_count > 0}"><span class="ing">대출중</span>(${i.loan_start_date}~${i.loan_end_date})</c:if>
				<a href="#" class="view-btn" keyValue="${i.book_package_idx}">${i.book_package_subject}</a>
			</div>
			<div>
				<c:if test="${not empty i.grade}">
				<span class="step1">
				<c:choose>
					<c:when test="${i.grade eq '3'}">초등</c:when>
					<c:when test="${i.grade eq '4'}">중등</c:when>
					<c:when test="${i.grade eq '5'}">고등</c:when>
				</c:choose>
				</span>
				</c:if>
				<c:forTokens items="${i.category}" delims="," var="category">
				<span class="step2">
				<c:choose>
					<c:when test="${category eq '000'}">총류</c:when>
					<c:when test="${category eq '100'}">철학</c:when>
					<c:when test="${category eq '200'}">종교</c:when>
					<c:when test="${category eq '300'}">사회과학</c:when>
					<c:when test="${category eq '400'}">자연과학</c:when>
					<c:when test="${category eq '500'}">기술과학</c:when>
					<c:when test="${category eq '600'}">예술</c:when>
					<c:when test="${category eq '700'}">언어</c:when>
					<c:when test="${category eq '800'}">문학</c:when>
					<c:when test="${category eq '900'}">역사</c:when>
				</c:choose>
				</span>
				</c:forTokens>
			</div>
			<div>
				<ul class="pub_info">
					<li>${i.author}</li>
					<li>|</li>
					<li>${i.publisher}</li>
					<li>|</li>
					<li>${i.publish_year}</li>
				</ul>
			</div>
			<div class="book-desc">
				${fn:substring(i.content, 0, 85)}<c:if test="${fn:length(i.content) > 85}">...</c:if>
			</div>
			<div class="keyword-box">
				<c:forTokens items="${i.keyword}" delims="," var="keyword">
				<span class="keyword">${keyword}</span>
				</c:forTokens>
			</div>
		</div>
		<div class="btn-box">
			<c:choose>
				<c:when test="${i.lender_count > 0}">
					<a href="#" class="request-btn reserv" keyValue="${i.book_package_idx}">예약신청</a>
				</c:when>
				<c:otherwise>
					<a href="#" class="request-btn loan" keyValue="${i.book_package_idx}">대출신청</a>
				</c:otherwise>
			</c:choose>
			<c:if test="${fn:indexOf(i.book_package_subject, '프로젝트길라잡이') < 1}">
				<a href="#" class="tit-search-btn">독서활동지</a>
			</c:if>
<%-- 			<c:if test="${not empty i.doc_server_file_name}"> --%>
<%-- 			<a href="download/${i.book_package_idx}.do" class="docfile">파일다운로드</a> --%>
<%-- 			</c:if> --%>
<%-- 			<a href="#" class="delete-btn" keyValue="${i.book_package_idx}">삭제</a> --%>
			<span class="loan-cnt">
				<strong>${i.loan_count}</strong>권
			</span>
		</div>
	</div>
	</c:forEach>
	<c:if test="${fn:length(bookPackageList) < 1}">
	<div align="center">
		<h3>등록된 책 꾸러미 리스트가 없습니다.</h3>
	</div>
	</c:if>
<%-- 	<c:if test="${member.admin or authMBA}"> --%>
<!-- 		<a href="#" id="all-check" class="btn" keyValue="N">전체 선택/해제</a> -->
<!-- 		<a href="#" id="delete-check" class="btn">선택 게시글삭제</a> -->
<%-- 	</c:if> --%>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookPackage"/>
</jsp:include>

</form:form>