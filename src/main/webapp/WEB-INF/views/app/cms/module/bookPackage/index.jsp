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

<form:form modelAttribute="bookPackage" action="save.do" method="POST">
<form:hidden path="editMode"/>
<form:hidden path="book_package_idx"/>
<div class="infodesk">
	<div class="button">
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
				<c:otherwise>
				<img src="/resources/common/img/noimg-gall.png" alt="no-image" height="100%">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="content-box">
			<h3><a href="#" class="dialog-modify" keyValue="${i.book_package_idx}">${i.book_package_subject}</a></h3>
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
			<div class="book-desc">${fn:substring(i.content, 0, 100)}<c:if test="${fn:length(i.content) > 100}">...</c:if></div>
			<div class="keyword-box">
				<c:forTokens items="${i.keyword}" delims="," var="keyword">
				<span>${keyword}</span>
				</c:forTokens>
			</div>
		</div>
		<div class="btn-box">
			<a href="#">신청하기</a>
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
</form:form>

<div id="dialog-1" class="dialog-common" title="책 꾸러미 "></div>