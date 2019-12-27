<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	var $form = $('form#pictureBook');
	
	$('#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD&pay_yn='+$('#pay_yn').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&pay_yn='+$('#pay_yn').val()+'&picture_book_idx='+$(this).attr('keyValue'), function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$form.attr('action', 'save.do');
			$form.attr('method', 'POST');
			$('#editMode').val('DELETE');
			$('#picture_book_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($form)) {
				location.reload();
			};
		}
	});
	
	$('.dialog-view').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&pay_yn='+$('#pay_yn').val() + '&viewPage='+$('#viewPage').val() + '&picture_book_idx='+$(this).attr('keyValue') + '&loan_year=2020';
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
<form:hidden path="editMode"/>
<form:hidden path="picture_book_idx"/>
<form:hidden path="pay_yn"/>
<div class="infodesk">
	<form:select path="category" cssClass="selectmenu">
		<form:option value="">원화유형별보기</form:option>
		<form:option value="18">글 있음</form:option>
		<form:option value="17">글 없음</form:option>
	</form:select>
	<div class="button">
		<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		<a href="#" class="btn btn3 left" id="frame-btn"><i class="fa fa-list"></i><span>액자형 전환</span></a>
	</div>
</div>
<div>
	<c:forEach items="${pictureBookList}" var="i" varStatus="status">
	<div class="group-box">
		<div class="img-box">
			<c:choose>
				<c:when test="${not empty i.thumb_image}">
				<a href="${i.desc_link}" target="_blank">
					<img src="${i.thumb_image}" alt="${i.picture_book_subject}" width="100%" height="100%">
				</a>
				</c:when>
				<c:when test="${not empty i.server_file_name}">
				<a href="#">
					<img src="${getContextPath}/data/pictureBook/${i.server_file_name}" alt="${i.picture_book_subject}" width="100%" height="100%">
				</a>
				</c:when>
				<c:otherwise>
				<img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="content-box">
			<h3>
				<a href="#" class="dialog-modify" keyValue="${i.picture_book_idx}">${i.picture_book_subject}</a>
			</h3>
			<div>${i.author} | ${i.publisher} | ${i.publish_year}</div>
			<div class="book-desc">${i.content}</div>
		</div>
		<div class="btn-box">
			<a href="#" class="dialog-view" keyValue="${i.picture_book_idx}">신청하기</a>
			<a href="#" class="delete-btn" keyValue="${i.picture_book_idx}">삭제</a>
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

<div id="dialog-1" class="dialog-common" title="그림책 원화 "></div>
<div id="dialog-2" class="dialog-common" title="그림책 원화 신청"></div>