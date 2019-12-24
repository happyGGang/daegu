<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&book_package_idx='+$(this).attr('keyValue'), function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.dialog-delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$('#book_package_idx_d').val($(this).attr('keyValue'));
			if(doAjaxPost($('form#bookPackageDel'))) {
				location.reload();
			};
		}
	});
	
	// 책 꾸러미 대출 신청
	$('.dialog-req').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('loanEdit.do?editMode=ADD&book_package_idx='+$(this).attr('keyValue'), function(response, status, xhr) {
			$('#dialog-2').dialog('open');
		});
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
	
});
</script>
<style>
.group-box {position: relative;padding: 10px;}
.img-box {display:inline-block;width: 120px;height: 170px;border: 1px solid #ccc;}
.content-box {position: absolute;display: inline-block;width: 75%;padding: 0 20px;}
.book-desc {margin: 20px 0;}
.keyword-box {border-top: 1px dashed #e5e5e5;padding-top: 15px;}
.content-box span {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}
.btn-box {display: inline-block;position: absolute;right: 49px;top: 40%;}
</style>

<form:form modelAttribute="bookPackage" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="book_package_idx" id="book_package_idx_d"/>
</form:form>

<form:form modelAttribute="bookPackage" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="book_package_idx"/>
<div>
	<form:checkbox path="category" value="all" checked="${fn:contains(bookPackage.category, 'all') ? 'checked' : ''}" label="전체" id="chkAll"/>
	<form:checkbox path="category" value="000" checked="${fn:contains(bookPackage.category, '000') ? 'checked' : ''}" label="총류" class="categoryChk"/>
	<form:checkbox path="category" value="100" checked="${fn:contains(bookPackage.category, '100') ? 'checked' : ''}" label="철학" class="categoryChk"/>
	<form:checkbox path="category" value="200" checked="${fn:contains(bookPackage.category, '200') ? 'checked' : ''}" label="종교" class="categoryChk"/>
	<form:checkbox path="category" value="300" checked="${fn:contains(bookPackage.category, '300') ? 'checked' : ''}" label="사회과학" class="categoryChk"/>
	<form:checkbox path="category" value="400" checked="${fn:contains(bookPackage.category, '400') ? 'checked' : ''}" label="자연과학" class="categoryChk"/>
	<form:checkbox path="category" value="500" checked="${fn:contains(bookPackage.category, '500') ? 'checked' : ''}" label="기술과학" class="categoryChk"/>
	<form:checkbox path="category" value="600" checked="${fn:contains(bookPackage.category, '600') ? 'checked' : ''}" label="예술" class="categoryChk"/>
	<form:checkbox path="category" value="700" checked="${fn:contains(bookPackage.category, '700') ? 'checked' : ''}" label="언어" class="categoryChk"/>
	<form:checkbox path="category" value="800" checked="${fn:contains(bookPackage.category, '800') ? 'checked' : ''}" label="문학" class="categoryChk"/>
	<form:checkbox path="category" value="900" checked="${fn:contains(bookPackage.category, '900') ? 'checked' : ''}" label="역사" class="categoryChk"/>
</div>
<div class="infodesk">
	<form:select path="grade" cssClass="selectmenu">
		<form:option value="">수준별보기</form:option>
		<form:option value="3">초등</form:option>
		<form:option value="4">중등</form:option>
		<form:option value="5">고등</form:option>
	</form:select>
	<form:select path="lender_count" cssClass="selectmenu">
		<form:option value="-1">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select>
	<div class="button">
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
	</div>
</div>
<div>
	<c:forEach items="${bookPackageList}" var="i" varStatus="status">
	<div class="group-box">
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
			<h3>
				<c:if test="${i.lender_count > 0}">대출중</c:if>
				<a href="#" class="dialog-modify" keyValue="${i.book_package_idx}">${i.book_package_subject}</a>
			</h3>
			<div>
				<c:choose>
					<c:when test="${i.grade eq '3'}">초등</c:when>
					<c:when test="${i.grade eq '4'}">중등</c:when>
					<c:when test="${i.grade eq '5'}">고등</c:when>
				</c:choose>
				<c:forTokens items="${i.category}" delims="," var="category">
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
				</c:forTokens>
			</div>
			<div>${i.author} | ${i.publisher} | ${i.publish_year}</div>
			<div class="book-desc">${i.content}</div>
			<div class="keyword-box">
				<c:forTokens items="${i.keyword}" delims="," var="keyword">
				<span>${keyword}</span>
				</c:forTokens>
			</div>
		</div>
		<div class="btn-box">
			<a href="#" class="dialog-req" keyValue="${i.book_package_idx}">
			<c:choose>
				<c:when test="${i.lender_count > 0}">예약하기</c:when>
				<c:otherwise>신청하기</c:otherwise>
			</c:choose>
			</a>
			<a href="#" class="dialog-delete" keyValue="${i.book_package_idx}">삭제</a>
		</div>
	</div>
	</c:forEach>
	<c:if test="${fn:length(bookPackageList) < 1}">
	<div align="center">
		<h3>등록된 책 꾸러미 리스트가 없습니다.</h3>
	</div>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookPackage"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="book_package_subject">서명</form:option>
			<form:option value="keyword">키워드</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="책 꾸러미 "></div>
<div id="dialog-2" class="dialog-common" title="책 꾸러미  신청"></div>