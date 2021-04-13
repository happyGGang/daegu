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
		if(confirm('선택 항목들을 삭제하시겠습니까?')) {
			$('form#bookPackage').attr('action', 'save.do');
			$('form#bookPackage').attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($('form#bookPackage'))) {
				location.reload();
			}
		}
	});
	
});
</script>
<style>
div#category-box {padding-bottom: 20px;border-bottom: 2px solid #554246;margin-bottom: 20px;}
input[type="checkbox"].customCheck {display: none;}
input[type="checkbox"].customCheck + label, input[type="checkbox"].customCheck:checked + label {display: inline-block;cursor: pointer;padding-left: 30px;padding-right: 15px;}
input[type="checkbox"].customCheck + label {color: #222;background: url("/resources/common/img/icon_cate_chk.png") no-repeat;}
input[type="checkbox"].customCheck:checked + label {color: #1ba8ed;background: url("/resources/common/img/icon_cate_chk_on.png") no-repeat;}

.group-box {position: relative;padding: 20px 10px;border-bottom: 1px solid #e5e5e5;}
.book_check {position: absolute;left: 0;}
.img-box {display:inline-block;float:left;width: 120px;height: 170px;border: 1px solid #ccc;margin-left: 10px;}
.content-box {display: inline-block;width: 75%;padding: 0 20px;}
.subject a {display: inline-block;margin-right: 20px;font-size: 19px;font-weight: bold;color: #222;}
.subject .ing {display: inline-block;width: 35px;height: 35px;margin: 0 10px 8px 0;border-radius: 100%;background: #ff5700;font-size: 11px;line-height: 35px;color: #fff;letter-spacing: -0.075em;text-align: center;}
.step1 {border: 1px solid #1ec0b0;color: #1ec0b0;}
.step2 {border: 1px solid #f9a406;color: #f9a406;}
.step1, .step2 {display: inline-block;margin-right: 5px;padding: 3px 5px;font-family: 'dotum';font-size: 11px;line-height: 1;letter-spacing: -1px;text-align: center;}
ul.pub_info {padding: 10px 0 15px;}
ul.pub_info li {display: inline-block;font-size: 13px;padding-right: 15px;}
.book-desc {font-size: 13px;}
.keyword-box {border-top: 1px dashed #e5e5e5;padding-top: 14px;margin-top: 18px;}
.content-box span.keyword {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}
.btn-box {position: absolute;top: 35px;right: 0;text-align: center;}
.btn-box a {display: block;height: 31px;padding: 0 20px 0 35px;border-radius: 50px;line-height: 32px;}
.btn-box a.loan {border: 2px solid #d2dfe8;color: #5c90b5;background: url(/resources/common/img/icon_bt_apply01.png) no-repeat 14px 50%;}
.btn-box a.reserv {border: 2px solid #cbbcf2;color: #7d57de;background: url(/resources/common/img/icon_bt_apply01_3.png) no-repeat 14px 50%;}
.btn-box a.docfile {border: 2px solid #d2dfe8;color: #5c90b5;position: absolute;top: 0px;right: 130px;padding: 0 20px 0 25px;}
span.loan-cnt {display: inline-block;width: 60px;height: 60px;margin: 30px auto 0;border-radius: 100%;background: #1ba8ed;text-align: center;font-size: 13px;color: #8dd4f6;}
span.loan-cnt strong {display: block;padding-top: 10px;font-family: 'Montserrat',sans-serif;font-size: 20px;letter-spacing: 0;color: #fff;}
</style>

<form:form modelAttribute="bookPackage" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="book_package_idx" id="book_package_idx_d"/>
</form:form>

<form:form modelAttribute="bookPackage" action="index.do" method="GET">
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
<div class="infodesk">
	<form:select path="grade" cssClass="selectmenu">
		<form:option value="">수준별보기</form:option>
		<form:option value="3">초</form:option>
		<form:option value="4">중</form:option>
		<form:option value="5">고</form:option>
	</form:select>
	<form:select path="lender_count" cssClass="selectmenu">
		<form:option value="-1">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select>
	<div class="button">
		<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>도서목록 다운받기</span></a>
		<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
	</div>
</div>
<div>
	<c:forEach items="${bookPackageList}" var="i" varStatus="status">
	<div class="group-box">
		<form:checkbox path="book_package_arr" cssClass="book_check" value="${i.book_package_idx}"/>
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
				<c:if test="${i.lender_count > 0}"><span class="ing">대출중</span></c:if>
				<a href="#" class="dialog-modify" keyValue="${i.book_package_idx}">${i.book_package_subject}</a>
			</div>
			<div>
				<c:if test="${not empty i.grade}">
				<span class="step1">
				<c:choose>
					<c:when test="${i.grade eq '3'}">초</c:when>
					<c:when test="${i.grade eq '4'}">중</c:when>
					<c:when test="${i.grade eq '5'}">고</c:when>
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
					<a href="#" class="dialog-req reserv" keyValue="${i.book_package_idx}">예약신청</a>
				</c:when>
				<c:otherwise>
					<a href="#" class="dialog-req loan" keyValue="${i.book_package_idx}">대출신청</a>
				</c:otherwise>
			</c:choose>
<%-- 			<c:if test="${not empty i.doc_server_file_name}"> --%>
<%-- 			<a href="download/${i.book_package_idx}.do" class="docfile">파일다운로드</a> --%>
<%-- 			</c:if> --%>
<%-- 			<a href="#" class="dialog-delete" keyValue="${i.book_package_idx}">삭제</a> --%>
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
	<a href="#" id="all-check" class="btn" keyValue="N">전체 선택/해제</a>
	<a href="#" id="delete-check" class="btn">선택 게시글삭제</a>
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