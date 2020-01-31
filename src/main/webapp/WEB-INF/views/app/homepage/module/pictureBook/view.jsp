<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	var $form = $('form#pictureBook');

	$('.request-btn').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('ADD');
		var formData = $form.serialize() + '&loan_year='+$(this).attr('keyValue') + '&loan_month='+$(this).attr('keyValue2');
		doGetLoad('loanEdit.do', formData);
	});

	$('.edit-btn').on('click', function(e) {
		e.preventDefault();
		if(!'${member.admin or authMBA}') {
			return false;
		}

		$('#editMode').val('MODIFY');
		var formData = $form.serialize() + '&picture_book_loan_idx='+$(this).attr('keyValue');
		doGetLoad('loanEdit.do', formData);
	});

	$('#list-btn').on('click', function(e) {
		e.preventDefault();
		var url = 'index${pictureBook.before_url}.do';
		doGetLoad(url, $('#pictureBook').serialize());
	});
});
</script>
<style>
.group-box {position: relative;padding: 10px;}
.img-box {display:inline-block;width: 183px;height: 261px;border: 1px solid #ccc;padding: 0;}
.content-box {position: absolute;display: inline-block;width: 75%;padding: 0 20px;}
.content-box p {padding: 20px 0 40px;font-size: 25px;font-weight: bold;color: #222;}
dl#author {overflow: hidden;width: 470px;font-size: 13px;}
dl#author dt {float: left;width: 65px;margin-bottom: 15px;background: url(/img/common/bar_author.gif) no-repeat right;font-weight: bold;color: #222;}
dl#author dd {float: left;width: 140px;margin-bottom: 15px;padding: 0 15px;}
.book-desc {margin: 20px 0 40px;}
.calendar-box #req-year {display:block;padding-left: 30px;background: url(/resources/common/img/calendar-icon.gif) no-repeat;font-size: 21px;font-weight: bold;color: #222;margin-bottom: 20px;}
.calendar-box>div {display:inline-block;width: 130px;height: 120px;margin-right: 10px;}
.calendar-box>div>span.req-month {width: 130px;margin-bottom: 10px;border-radius: 5px;background: #e8f2f7;text-align: center;font-weight: bold;line-height: 40px;color: #333;display: block;}
.btn-box a{display: block;width: 128px;height: 34px;border-radius: 5px;font-size: 13px;font-weight: bold;line-height: 34px;letter-spacing: -0.05em;text-align: center;}
.btn-box a.apply-req {border: 1px solid #8dd3f6;color: #1ba8ed;}
.btn-box a.apply-ok {border: 1px solid #7f7f7f;color: #000;pointer-events: none;}
</style>

<form:form modelAttribute="pictureBook" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="picture_book_idx" id="picture_book_idx_d"/>
</form:form>

<form:form modelAttribute="pictureBook" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="viewPage"/>
<form:hidden path="pay_yn"/>
<form:hidden path="picture_book_idx"/>
<form:hidden path="picture_book_subject"/>
<div>
	<div class="group-box">
		<div class="img-box">
			<c:choose>
				<c:when test="${not empty pictureBook.thumb_image}">
				<img src="${pictureBook.thumb_image}" alt="${pictureBook.picture_book_subject}" width="100%" height="100%">
				</c:when>
				<c:when test="${not empty pictureBook.server_file_name}">
				<img src="${getContextPath}/data/pictureBook/${pictureBook.server_file_name}" alt="${pictureBook.picture_book_subject}" width="100%" height="100%">
				</c:when>
				<c:otherwise>
				<img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="content-box">
			<p>${pictureBook.picture_book_subject}</p>
			<dl id="author">
				<dt>작가</dt>
				<dd>${pictureBook.author}</dd>
				<dt>출판사</dt>
				<dd>${pictureBook.publisher}</dd>
				<dt>출판년도</dt>
				<dd>${pictureBook.publish_year}</dd>
				<c:if test="${not empty pictureBook.isbn}">
				<dt>ISBN</dt>
				<dd>${pictureBook.isbn}</dd>
				</c:if>
				<dt>가격</dt>
				<dd>${pictureBook.picture_price}</dd>
				<dt>액자개수</dt>
				<dd>${pictureBook.picture_count}</dd>
				<c:if test="${not empty pictureBook.keyword}">
				<dt>주제</dt>
				<dd>${pictureBook.keyword}</dd>
				</c:if>
			</dl>
		</div>
		<c:if test="${pictureBook.pay_yn eq 'Y'}">
		<div class="book-desc">${pictureBook.content}</div>
		</c:if>
		<div class="calendar-box">
			<span id="req-year">${pictureBook.loan_year}년</span>
			<c:forEach var="month" begin="1" end="12">
			<div>
				<span class="req-month">${month}월</span>
				<div class="btn-box">
				<c:choose>
					<c:when test="${not empty loanableMonth[month].isMonth and loanableMonth[month].isMonth}">
					<a href="javascript:void(0)" class="apply-ok"><span>대출완료</span></a>
					</c:when>
					<c:otherwise>
					<a href="#" class="request-btn apply-req" keyValue="${pictureBook.loan_year}" keyValue2="${month}" style="color: blue;">대출신청</a>
					</c:otherwise>
				</c:choose>
				</div>
				<c:if test="${not empty loanableMonth[month].isMonth and loanableMonth[month].isMonth}">
				<a href="#" class="edit-btn" keyValue="${loanableMonth[month].picture_book_loan_idx}">${loanableMonth[month].school_name}/${loanableMonth[month].request_name}</a>
				</c:if>
			</div>
			</c:forEach>
		</div>
	</div>
</div>
</form:form>
<div>
	<a href="#" id="list-btn" class="btn btn3">목록으로</a>
</div>