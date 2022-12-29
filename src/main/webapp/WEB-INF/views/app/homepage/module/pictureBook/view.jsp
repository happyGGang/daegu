<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	long st = System.currentTimeMillis();
%>
<c:set var="st" value="<%=st%>"></c:set>

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
		if('${member.admin or authMBA}' == 'false') {
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

.content-box {position: absolute;display: inline-block;width: calc(100% - 223px);padding: 0 20px;}

.content-box p {padding: 32px 0;font-size: 25px;font-weight: bold;color: #222;}

/*dl#author {overflow: hidden;width: 470px;font-size: 13px;}

dl#author dt {float: left;width: 65px;margin-bottom: 15px;background: url(/img/common/bar_author.gif) no-repeat right;font-weight: bold;color: #222;}

dl#author dd {float: left;width: 140px;margin-bottom: 15px;padding: 0 15px;}*/

.book-desc {margin: 20px 0 40px;}

.calendar-box {margin-top: 50px;}

.calendar-box #req-year {display:block;padding-left: 30px;background: url(/resources/common/img/calendar-icon.gif) no-repeat;font-size: 21px;font-weight: bold;color: #222;margin-bottom: 20px;}

.calendar-box>div {display:inline-block;width: 15%;height: 140px;margin-right: 10px;vertical-align: top;padding-bottom: 25px;word-break: normal;}

.calendar-box>div>span.req-month {width: 100%;margin-bottom: 10px;border-radius: 5px;background: #e8f2f7;text-align: center;font-weight: bold;line-height: 40px;color: #333;display: block;}

.btn-box a{display: block;width: 100%;height: 34px;border-radius: 5px;font-size: 13px;font-weight: bold;line-height: 34px;letter-spacing: -0.05em;text-align: center;}

.btn-box a.apply-req {border: 1px solid #8dd3f6;color: #1ba8ed;}

.btn-box a.apply-ok {border: 1px solid #7f7f7f;color: #000;pointer-events: none;}

.btn-box a.apply-last {border: 1px solid #bebebe;color: #7d7d7d;pointer-events: none;}

a.edit-btn{font-size:13px;}
</style>

<form:form modelAttribute="pictureBook" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="picture_book_idx" id="picture_book_idx_d"/>
</form:form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
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
			<div class="auto-scroll">
				<table class="tbl-type01">
					<thead>
						<th colspan="4"><p>${pictureBook.picture_book_subject}</p></th>
					</thead>
					<tbody>
					<tr>
						<th style="width:10%;">작가</th>
						<td colspan="3">${pictureBook.author}</td>
					</tr>
					<tr>
						<th style="width:10%;">출판사</th>
						<td>${pictureBook.publisher}</td>
						<th style="width:10%;">출판년도</th>
						<td>${pictureBook.publish_year}</td>
					</tr>
					<tr>
						<th style="width:10%;">가격</th>
						<td>${pictureBook.picture_price}</td>
						<th style="width:10%;">액자개수</th>
						<td>${pictureBook.picture_count}</td>
					</tr>
					<tr>
						<c:if test="${not empty pictureBook.isbn}">
						<th style="width:10%;">ISBN</th>
						<td>${pictureBook.isbn}</td>
						</c:if>
						<c:if test="${not empty pictureBook.keyword}">
						<th style="width:10%;">주제</th>
						<td>${pictureBook.keyword}</td>
						</c:if>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		<c:if test="${pictureBook.pay_yn eq 'Y'}">
		<div class="book-desc">${pictureBook.content}</div>
		</c:if>
	</div>
</div>
</form:form>
<div style="width:100%;text-align:center;">
	<a href="#" id="list-btn" class="btn btn3">목록으로</a>
</div>