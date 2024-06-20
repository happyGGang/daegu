<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	var $form = $('form#pictureBook');
	
	$('.edit-btn').on('click', function(e) {
		e.preventDefault();
		if('${member.admin or authMBA}' == 'false' || $(this).data('last') == 'Y') {
			return false;
		}
		
		var formData = 'editMode=MODIFY&menu_idx='+$('#menu_idx').val() + '&picture_book_loan_idx='+$(this).attr('keyValue');
		doGetLoad('loanEdit.do', formData);
	});
	
	$('.request-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&pay_yn='+$('#pay_yn').val()  + '&picture_book_idx='+$(this).attr('keyValue') + '&loan_year='+$(this).attr('keyValue2') + '&loan_month='+$(this).attr('keyValue3') + '&picture_book_subject='+encodeURI($(this).attr('keyValue4'));
		doGetLoad('loanEdit.do', formData);
	});
	
	$('.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&pay_yn='+$('#pay_yn').val() + '&picture_book_idx='+$(this).attr('keyValue') + '&loan_year=2020';
		doGetLoad('viewFrame.do', formData)
	});
	
	$('a#list-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#pictureBook').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#pictureBook').serialize());
	});
	
	$('select#category').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#pictureBook').serialize());
	});
	
});
</script>
<style>
.month-txt ul {height: 30px;list-style-type: disc;}
.month-txt ul li:first-child {float: right;color: #888;margin-left: 35px;}
.month-txt ul li:nth-child(2) {float: right;color: #fd5c4a;margin-left: 35px;}
.group-box {position: relative;display: inline-block;padding: 10px;border: 1px solid #e5e5e5;width: 22.3%; text-align: center;margin: 5px 0;}
.img-box {display:inline-block;width: 120px;height: 170px;border: 1px solid #ccc;padding: 0;}
.book-desc {margin: 20px 0;}
.keyword-box {border-top: 1px dashed #e5e5e5;padding-top: 15px;}
.content-box span {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}
.btn-box {display: inline-block;}
.btn-box a {display: block;height: 31px;padding: 0 20px 0 35px;border-radius: 50px;line-height: 32px;}
.btn-box a.loan {border: 2px solid #d2dfe8;color: #5c90b5;background: url(/resources/common/img/icon_bt_apply01.png) no-repeat 14px 50%;}


ul.select-month {margin: 15px 0 auto;padding: 20px 0;border-top: 1px dashed #e5e5e5;}
ul.select-month li {display: inline-block;width: 20px;line-height: 20px;font-size: 11px;font-weight: 600;text-align: center;margin: 0 4px;padding: 0;}
ul.select-month li a {color: #d5d5d5;}
ul.select-month li a.loan-ing {display: block;color: #fff;background-color: #ff5500;border-radius: 100%;}
div.pay-ul ul {list-style: disc;padding-left: 20px;margin-bottom: 30px;font-weight: bold;}
</style>

<c:if test="${pictureBook.pay_yn eq 'Y'}">
<div class="pay-ul">
	<ul>
		<li>원화꾸러미(유료)는 자동발송되지 않습니다. 학교에서 직접 택배 신청을 하셔서 다음 기관으로 발송해주시기 바랍니다.</li>
		<li>배송비는 대출중인 학교에서 선불로 지급하셔야 합니다.</li>
		<li>글자 없이 그림 원화로만 제공되는 원화꾸러미입니다.</li>
	</ul>
</div>
</c:if>

<form:form modelAttribute="pictureBook" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="picture_book_idx" id="picture_book_idx_d"/>
</form:form>

<form:form modelAttribute="pictureBook" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="picture_book_idx"/>
<form:hidden path="pay_yn"/>
<div class="infodesk">
	<form:select path="category" cssClass="selectmenu">
		<form:option value="">원화유형별보기</form:option>
		<form:option value="18">글 있음</form:option>
		<form:option value="17">글 없음</form:option>
	</form:select>
	<div class="button">
<!-- 		<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a> -->
		<a href="#" class="btn btn3 left" id="list-btn"><i class="fa fa-list"></i><span>리스트형 전환</span></a>
	</div>
</div>
<div class="month-txt">
	<ul>
		<li>신청불가능한 달</li>
		<li>신청가능한 달</li>
	</ul>
</div>
<div>
	<c:forEach items="${pictureBookList}" var="i" varStatus="status">
	<div class="group-box">
		<div class="img-box">
			<c:choose>
				<c:when test="${not empty i.thumb_image}">
<%-- 				<a href="${i.desc_link}" target="_blank"> --%>
				<a href="#" class="view-btn" keyValue="${i.picture_book_idx}">
					<img src="${i.thumb_image}" alt="${i.picture_book_subject}" width="100%" height="100%">
				</a>
				</c:when>
				<c:when test="${not empty i.server_file_name}">
				<a href="#" class="view-btn" keyValue="${i.picture_book_idx}">
					<img src="${getContextPath}/data/pictureBook/${i.server_file_name}" alt="${i.picture_book_subject}" width="100%" height="100%">
				</a>
				</c:when>
				<c:otherwise>
				<img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="content-box">
			<h4 style="background: none;">
				<a href="#" class="view-btn" keyValue="${i.picture_book_idx}">${i.picture_book_subject}</a>
			</h4>
			<div class="btn-box">
				<a href="#" class="view-btn loan" keyValue="${i.picture_book_idx}">신청하기</a>
			</div>
			<ul class="select-month">
				<c:forEach items="${i.monthList}" var="month">
				<li>
					<c:choose>
						<c:when test="${empty month.PICTURE_BOOK_LOAN_IDX and month.LAST_MONTH eq 'N'}">
						<a href="#" class="request-btn loan-ing" keyValue="${i.picture_book_idx}" keyValue2="${i.loan_year}" keyValue3="${month.LOAN_MONTH}" keyValue4="${i.picture_book_subject}">${month.LOAN_MONTH}</a>
						</c:when>
						<c:otherwise>
						<a href="#" class="edit-btn" keyValue="${month.PICTURE_BOOK_LOAN_IDX}" data-last="${month.LAST_MONTH}">${month.LOAN_MONTH}</a>
						</c:otherwise>
					</c:choose>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	</c:forEach>
	<c:if test="${fn:length(pictureBookList) < 1}">
	<div align="center">
		<h3>등록된 원화 리스트가 없습니다.</h3>
	</div>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#pictureBook"/>
	<jsp:param name="pagingUrl" value="indexFrame.do"/>
</jsp:include>

<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu">
			<form:option value="picture_book_subject">서명</form:option>
			<form:option value="keyword">키워드</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
		<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
</form:form>