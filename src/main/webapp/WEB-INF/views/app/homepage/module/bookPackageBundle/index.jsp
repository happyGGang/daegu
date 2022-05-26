<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	$('.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'menu_idx='+$('#menu_idx').val() + '&viewPage='+$('#viewPage').val() + '&book_package_bundle_idx='+$(this).attr('keyValue');
		doGetLoad('view.do', formData);
	});

	$('.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('#book_package_bundle_idx_d').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#bookPackageBundleDel'))) {
				location.reload();
			};
		}
	});

	// 책 꾸러미 대출 신청
	$('.request-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&book_package_bundle_idx='+$(this).attr('keyValue');
		doGetLoad('loanEdit.do', formData);
	});

	$('input#chkAll').on('click', function() {
		$('.categoryChk').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle').serialize());
	});

	$('.categoryChk').on('click', function() {
		$('input#chkAll').prop('checked', false);
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle').serialize());
	});

	$('select#grade, select#lender_count').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle').serialize());
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bookPackageBundle').serialize());
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		if('${fn:length(bookPackageBundleList)}' > 0) {
			$('#editMode').val('bookPackage');
			$('#bookPackageBundle').attr('method', 'POST');
			$('#bookPackageBundle').attr('action', 'excelDownload.do').submit();
			$('form#bookPackageBundle').submit();

			$('#bookPackageBundle').attr('method', 'GET');
			$('#bookPackageBundle').attr('action', 'index.do');
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
			$('form#bookPackageBundle').attr('action', 'save.do');
			$('form#bookPackageBundle').attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($('form#bookPackageBundle'))) {
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
<link rel="stylesheet" href="/resources/common/css/bookPackageBundle.css" />

<form:form modelAttribute="bookPackageBundle" id="bookPackageBundleDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="book_package_bundle_idx" id="book_package_bundle_idx_d"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="bookPackageBundle" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="book_package_bundle_idx"/>

<%-- <div id="category-box">
	<form:checkbox path="category" value="all" checked="${fn:contains(bookPackageBundle.category, 'all') ? 'checked' : ''}" label="전체" id="chkAll" class="customCheck"/>
	<form:checkbox path="category" value="000" checked="${fn:contains(bookPackageBundle.category, '000') ? 'checked' : ''}" label="총류" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="100" checked="${fn:contains(bookPackageBundle.category, '100') ? 'checked' : ''}" label="철학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="200" checked="${fn:contains(bookPackageBundle.category, '200') ? 'checked' : ''}" label="종교" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="300" checked="${fn:contains(bookPackageBundle.category, '300') ? 'checked' : ''}" label="사회과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="400" checked="${fn:contains(bookPackageBundle.category, '400') ? 'checked' : ''}" label="자연과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="500" checked="${fn:contains(bookPackageBundle.category, '500') ? 'checked' : ''}" label="기술과학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="600" checked="${fn:contains(bookPackageBundle.category, '600') ? 'checked' : ''}" label="예술" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="700" checked="${fn:contains(bookPackageBundle.category, '700') ? 'checked' : ''}" label="언어" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="800" checked="${fn:contains(bookPackageBundle.category, '800') ? 'checked' : ''}" label="문학" class="customCheck categoryChk"/>
	<form:checkbox path="category" value="900" checked="${fn:contains(bookPackageBundle.category, '900') ? 'checked' : ''}" label="역사" class="customCheck categoryChk"/>
</div> --%>

<div class="doc-body">
  <div class="summaryDesc">
    <div class="innerBox" style="padding:10px;">
      <div class="img ticon_02" style="top:10px;"></div>
      <div class="desc">
        <h3 style="margin-top:-10px;">「학생추천도서꾸러미」</h3>
        <p><b>학생추천도서 목록에 수록된 도서</b>를 <b>각각 다른 도서 1권씩, 총 30~35권으로 구성</b>한 꾸러미입니다.<br />학생추천도서꾸러미를 무료 택배로 받아보세요! 배송비는 우리 도서관에서 부담합니다.</p>
      </div>
    </div>
  </div>
 </div>

 <div class="search txt-center" style="margin:25px 0;clear:both;">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu new_select_box">
			<form:option value="book_package_bundle_title">꾸러미 제목</form:option>
			<%-- <form:option value="keyword">키워드</form:option> --%>
		</form:select>
		<form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
		<button id="search_btn" style="background-color:#2c75cb;border-color:#1962ba;background-image:none;padding:6px 10px;"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>

<div class="infodesk">
	<form:select path="grade" cssClass="selectmenu new_select_box">
		<form:option value="">수준별보기</form:option>
		<form:option value="3">초등1-2학년</form:option>
		<form:option value="4">초등3-4학년</form:option>
		<form:option value="5">초등5-6학년</form:option>
		<form:option value="6">중학생</form:option>
		<form:option value="7">고등학생</form:option>
	</form:select>
	<%-- <form:select path="lender_count" cssClass="selectmenu new_select_box">
		<form:option value="-1">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select> --%>
	<div class="button">
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>도서목록 다운받기</span></a>
	</div>
</div>

<div>
	<c:forEach items="${bookPackageTitleList}" var="i" varStatus="status">
	<div class="group-box" style="height: 165px;">
		<div class="content-box" style="line-height: 350%">
			<a href="#" class="view-btn" keyValue="${i.book_package_bundle_idx}">${i.book_package_bundle_title}</a><br/>
				<c:forEach items="${getBookPackageLoanCountCheck}" var="c" varStatus="status">
					<c:choose>
						<c:when test="${i.book_package_bundle_idx == c.book_package_bundle_idx }">
							<div class="ing-box">
								<c:if test="${c.lender_count > 0}"><span class="ing">대출중</span>(${c.loan_start_date}~${c.loan_end_date})</c:if>
							</div>
							
						</c:when>
					</c:choose>
							<%-- <div class="ing-box"><span class="ing2">대출가능</span></div>
							<div class="btn-box" style="text-align: left; width: 400px;" >
								<a href="#" class="request-btn loan" keyValue="${i.book_package_bundle_idx}">대출신청</a>
								<a href="#" class="view-btn booklist" keyValue="${i.book_package_bundle_idx}">포함도서 보기</a>
							</div> --%>
				</c:forEach>
				<div class="btn-box" style="text-align: left; width: 400px;">
					<a href="#" class="request-btn reserv" keyValue="${i.book_package_bundle_idx}">신청하기</a>
					<a href="#" class="view-btn booklist" keyValue="${i.book_package_bundle_idx}">포함도서 보기</a>
				</div>
		</div>
			<%-- <div>
				<c:if test="${not empty i.grade}">
				<span class="step1">
				<c:choose>
					<c:when test="${i.grade eq '3'}">초등1-2학년</c:when>
					<c:when test="${i.grade eq '4'}">초등3-4학년</c:when>
					<c:when test="${i.grade eq '5'}">초등5-6학년</c:when>
					<c:when test="${i.grade eq '6'}">중학생</c:when>
					<c:when test="${i.grade eq '7'}">고등학생</c:when>
				</c:choose>
				</span>
				</c:if>
				<c:forEach items="${bookPackageCategoryList}" var="j" varStatus="status">
					<c:if test="${i.book_package_bundle_idx == j.book_package_bundle_idx}">
					<c:forTokens items="${j.category}" delims="," var="category">
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
					</c:if>
				</c:forEach>
			</div> --%>
			<%-- <div class="book-desc">
				<c:forEach items="${bookPackageCategoryList}" var="j" varStatus="status">
					<c:if test="${i.book_package_bundle_idx == j.book_package_bundle_idx}">
						${fn:substring(j.book_package_name, 0, 85)}<c:if test="${fn:length(j.book_package_name) > 85}">...</c:if>
					</c:if>
				</c:forEach>
			</div>
			<div class="keyword-box">
				<c:forEach items="${bookPackageCategoryList}" var="j" varStatus="status">
					<c:if test="${i.book_package_bundle_idx == j.book_package_bundle_idx}">
						<c:forTokens items="${j.keyword}" delims="," var="keyword">
						<span class="keyword">${keyword}</span>
						</c:forTokens>
					</c:if>
				</c:forEach>
			</div> --%>
		
		<%-- <div class="btn-box">
			<c:choose>
				<c:when test="${i.lender_count > 0}">
					<a href="#" class="request-btn reserv" keyValue="${i.book_package_bundle_idx}">예약신청</a>
				</c:when>
				<c:otherwise>
					<a href="#" class="request-btn loan" keyValue="${i.book_package_bundle_idx}">대출신청</a>
				</c:otherwise>
			</c:choose>
			<a href="#" class="view-btn booklist" keyValue="${i.book_package_bundle_idx}">포함도서 보기</a>
		</div> --%>
		<span class="loan-cnt">
			<strong>${i.loan_count}</strong>권
		</span>
	</div>
	</c:forEach>
	<c:if test="${fn:length(bookPackageBundleList) < 1}">
	<div align="center">
		<h3>등록된 책 꾸러미 리스트가 없습니다.</h3>
	</div>
	</c:if>
</div>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookPackageBundle"/>
	<jsp:param name="pagingUrl" value="index.do"/>
</jsp:include>



</form:form>