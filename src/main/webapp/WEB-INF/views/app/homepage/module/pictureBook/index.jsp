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
		
		var formData = 'editMode=MODIFY&menu_idx='+$('#menu_idx').val() + '&pay_yn='+$('#pay_yn').val()  + '&picture_book_loan_idx='+$(this).attr('keyValue');
		doGetLoad('loanEdit.do', formData);
	});
	
	$('.request-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&pay_yn='+$('#pay_yn').val()  + '&picture_book_idx='+$(this).attr('keyValue') + '&loan_year='+$(this).attr('keyValue2') + '&loan_month='+$(this).attr('keyValue3') + '&picture_book_subject='+encodeURI($(this).attr('keyValue4'));
		doGetLoad('loanEdit.do', formData);
	});
	
	$('.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&pay_yn='+$('#pay_yn').val() + '&picture_book_idx='+$(this).attr('keyValue') + '&loan_year='+$(this).attr('keyValue2');
		doGetLoad('view.do', formData)
	});
	
	$('a#frame-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('indexFrame.do', $('form#pictureBook').serialize());
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#pictureBook').serialize());
	});
	
	$('select#category').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#pictureBook').serialize());
	});
	
	var sysdate = new Date();
	var currYear = sysdate.getFullYear();
	var currMonth = sysdate.getMonth() + 1;
	if(currMonth == 12) {
		currYear++;
	}
	$('a.view-btn').attr('keyValue2', currYear);
	
});
function requestMonth() {
	
}
</script>
<style>
.month-txt ul {height: 30px;list-style-type: disc;}
.month-txt ul li:first-child {float: right;color: #888;margin-left: 35px;}
.month-txt ul li:nth-child(2) {float: right;color: #fd5c4a;margin-left: 35px;}
p.point-txt {display: inline-block;padding-left: 22px;background: url(/resources/common/img/icon_point.gif) no-repeat 0 1px;font-size: 13px;line-height: 17px;color: #222;word-break: keep-all;}
.group-box {position: relative;padding: 20px 10px;border-bottom: 1px solid #e5e5e5;}
.img-box {display:inline-block;/* float:left */;width: 120px;height: 170px;border: 1px solid #ccc;padding: 0;}
.content-box {position:absolute;display: inline-block;width: 75%;padding: 0 20px;}
.subject a {display: inline-block;margin-right: 20px;font-size: 19px;font-weight: bold;color: #222;}
.subject .ing {display: inline-block;width: 35px;height: 35px;margin: 0 10px 8px 0;border-radius: 100%;background: #ff5700;font-size: 11px;line-height: 35px;color: #fff;letter-spacing: -0.075em;text-align: center;}
ul.pub_info {padding: 10px 0 15px;}
ul.pub_info li {display: inline-block;font-size: 13px;padding-right: 15px;}
.btn-box {position: absolute;top: 35px;right: 0;text-align: center;}
.btn-box a {display: block;height: 31px;padding: 0 20px 0 35px;border-radius: 50px;line-height: 32px;}
.btn-box a.loan {border: 2px solid #d2dfe8;color: #5c90b5;background: url(/resources/common/img/icon_bt_apply01.png) no-repeat 14px 50%;}
ul.select-month {margin: 15px 0 auto;padding: 20px 0;border-top: 1px dashed #e5e5e5;}
ul.select-month li {display: inline-block;width: 25px;line-height: 25px;font-size: 11px;font-weight: 600;text-align: center;margin: 0 8px;padding: 0;}
ul.select-month li a {color: #d5d5d5;}
ul.select-month li a.loan-ing {display: block;color: #fff;background-color: #ff5500;border-radius: 100%;}
div.pay-ul ul {list-style: disc;padding-left: 20px;margin-bottom: 30px;font-weight: bold;}
</style>

<c:if test="${pictureBook.pay_yn eq 'Y'}">
<div class="pay-ul">
	<ul>
		<!--<li>원화꾸러미(유료)는 자동발송되지 않습니다. 학교에서 직접 택배 신청을 하셔서 다음 기관으로 발송해주시기 바랍니다.</li>
		<li>배송비는 대출중인 학교에서 선불로 지급하셔야 합니다.</li>-->
		<li>글자 없이 그림 원화로만 제공되는 원화꾸러미입니다.</li>
	</ul>
</div>
</c:if>

<form:form modelAttribute="pictureBook" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="picture_book_idx" id="picture_book_idx_d"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form:form>

<form:form modelAttribute="pictureBook" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pay_yn"/>
<form:hidden path="picture_book_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="search txt-center">
	<fieldset>
		<form:select path="search_type" cssClass="selectmenu new_select_box">
			<form:option value="picture_book_subject">서명</form:option>
			<form:option value="keyword">키워드</form:option>
		</form:select>
		<form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
		<button id="search_btn" style="background-color:#2c75cb;border-color:#1962ba;background-image:none;padding:6px 10px;"><i class="fa fa-search"></i><span>검색</span></button>
	</fieldset>
</div>
<div class="infodesk">
	<form:select path="category" cssClass="selectmenu new_select_box">
		<form:option value="">원화유형별보기</form:option>
		<form:option value="18">글 있음</form:option>
		<form:option value="17">글 없음</form:option>
	</form:select>
	<div class="button">
<!-- 		<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a> -->
		<a href="#" class="btn btn3 left" id="frame-btn"><i class="fa fa-list"></i><span>액자형 전환</span></a>
	</div>
</div>
<div class="month-txt">
	<ul>
		<li>신청불가능한 달</li>
		<li>신청가능한 달</li>
	</ul>
</div>
<c:if test="${pictureBook.pay_yn eq 'Y'}">
<div style="margin-bottom: 5px;">
	<p class="point-txt">길벗어린이 원화 액자로, 플라스틱 박스에 포장하여 보내드립니다.</p>
</div>
</c:if>
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
			<div class="subject">
				<a href="#" class="view-btn" keyValue="${i.picture_book_idx}">${i.picture_book_subject}</a>
			</div>
			<div>
				<ul class="pub_info">
					<li>${i.author}</li>
					<li>|</li>
					<li>${i.publisher}</li>
					<li>|</li>
					<li>${i.publish_year}</li>
				</ul>
				<c:if test="${pictureBook.pay_yn eq 'Y'}">
				<div class="book-desc">${i.content}</div>
				</c:if>
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
		<div class="btn-box">
			<a href="#" class="view-btn loan" keyValue="${i.picture_book_idx}">신청하기</a>
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
</jsp:include>

</form:form>

<div id="dialog-1" class="dialog-common" title="그림책 원화 "></div>
<div id="dialog-2" class="dialog-common" title="그림책 원화 신청"></div>