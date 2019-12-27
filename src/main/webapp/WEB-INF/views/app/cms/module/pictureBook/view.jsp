<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	var $form = $('form#pictureBook');
	
	$('.dialog-req').on('click', function(e) {
		e.preventDefault();
		var formData = $form.serialize() + '&loan_year='+$(this).attr('keyValue') + '&loan_month='+$(this).attr('keyValue2');
		$('#dialog-1').load('loanEdit.do?' + formData, function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
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
.img-box {display:inline-block;width: 120px;height: 170px;border: 1px solid #ccc;}
.content-box {position: absolute;display: inline-block;width: 75%;padding: 0 20px;}
.book-desc {margin: 20px 0;}
.keyword-box {border-top: 1px dashed #e5e5e5;padding-top: 15px;}
.content-box span {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}
.btn-box {display: inline-block;position: absolute;right: 49px;top: 40%;}
</style>

<form:form modelAttribute="pictureBook" id="bookPackageDel" action="save.do" method="POST">
<form:hidden path="editMode" id="editMode_d" value="DELETE"/>
<form:hidden path="picture_book_idx" id="picture_book_idx_d"/>
</form:form>

<form:form modelAttribute="pictureBook" action="index.do" method="GET">
<form:hidden path="viewPage"/>
<form:hidden path="editMode"/>
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
			<h3>
				<a href="#" class="dialog-modify" keyValue="${pictureBook.picture_book_idx}">${pictureBook.picture_book_subject}</a>
			</h3>
			<div>작가 : ${pictureBook.author}</div>
			<div>출판사 : ${pictureBook.publisher}</div>
			<div>출판년도 : ${pictureBook.publish_year}</div>
			<div>ISBN : ${pictureBook.isbn}</div>
			<div>가격 : ${pictureBook.picture_price}</div>
		</div>
		<div class="book-desc">${pictureBook.content}</div>
		<div>
			<span>2020년</span>
			<c:forEach var="month" begin="1" end="12">
			<div style="display: inline-block;">
				<span>${month}월</span>
				<div>
				<c:choose>
					<c:when test="${loanableMonth[month]}">
					<span>대출완료</span>
					</c:when>
					<c:otherwise>
					<a href="#" class="dialog-req" keyValue="2020" keyValue2="${month}" style="color: blue;">대출신청</a>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</div>
</form:form>
<div>
	<a href="#" id="list-btn">목록으로</a>
</div>
<div id="dialog-1" class="dialog-common" title="그림책 원화 신청 "></div>