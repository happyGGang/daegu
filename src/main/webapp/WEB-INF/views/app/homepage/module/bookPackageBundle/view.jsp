<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/sub_design_new.css"/>
<link rel="stylesheet" type="text/css" href="/resources/book/css/serial.css">
<script type="text/javascript">
$(function() {
	var $form = $('form#bookPackageBundle');
	
	$('#list_btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
});
</script>
<style type="text/css">
	.bookPackageBundleSubject {font-size: 20px;background: #f6f6f6;font-weight: bold;text-align: center;height: 42px;width: 1000px;display: table-cell;vertical-align: middle;border: 1px solid #e5e8eb;}

	span.keyword {display: inline-block;padding: 0 10px;background: #e8f2f7;border-radius: 20px;font-size: 12px;color: #7e8c93;}

	.serial-wrap .search-results .row{height:225px;}

	@media all and (max-width:550px){
		.serial-wrap .search-results .row{border-bottom:1px solid #e5e5e5;height:auto;margin-top:10px;}
	}
</style>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="bookPackageBundle" action="index.do" method="GET">
<form:hidden path="menu_idx"/>

<div class="serial-wrap" style="margin-top:20px;">
	<div class="bookPackageBundleSubject">
		${bookPackageBundle.book_package_bundle_title}
	</div>
	<div class="smain">
		<div class="box">
			<div class="search-results">
			<c:forEach items="${bookPackageBundleList}" var="i" varStatus="status">
			<div class="row">
				<div class="thumb">
					<c:choose>
						<c:when test="${not empty i.image_link}">
						<a href="${i.desc_link}" target="_blank">
							<img src="${i.image_link}" alt="${i.book_package_bundle_title}">
						</a>
						</c:when>
						<c:when test="${not empty i.server_file_name}">
						<a href="#">
							<img src="${getContextPath}/data/bookPackageBundle/${i.server_file_name}" alt="${i.book_package_bundle_title}" style="max-width: 500px;margin: 0 auto;">
						</a>
						</c:when>
					</c:choose>
				</div>
				<div class="box">
					<div class="item">
						<div class="bif">
							<a class="name" title="${i.book_package_name}" style="display:block;">
								${fn:substring(i.book_package_name, 0, 30)}<c:if test="${fn:length(i.book_package_name) > 30}">...</c:if>
							</a>
							<ul class="con2">
								<li>저자 : ${fn:substring(i.author, 0, 20)}<c:if test="${fn:length(i.author) > 20}">...</c:if></li>
								<li>출판사 : ${fn:substring(i.publisher, 0, 20)}<c:if test="${fn:length(i.publisher) > 20}">...</c:if></li>
								<li>출판년도 : ${i.publish_year}</li>
								<li>
									주제 :
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
								</li>
								<li>
									대상 : 
									<c:choose>
										<c:when test="${i.grade eq '3'}">초등1-2학년</c:when>
										<c:when test="${i.grade eq '4'}">초등3-4학년</c:when>
										<c:when test="${i.grade eq '5'}">초등5-6학년</c:when>
										<c:when test="${i.grade eq '6'}">중학생</c:when>
										<c:when test="${i.grade eq '7'}">고등학생</c:when>
									</c:choose>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div style="float:left;margin-top:10px;">
					<c:forTokens items="${i.keyword}" delims="," var="keyword">
					<span class="keyword">${keyword}</span>
					</c:forTokens>
				</div>
			</div>
			</c:forEach>
			</div>
		</div>
	</div>
</div>
</form:form>

<div class="button bbs-btn center">
	<a href="" class="btn btn1 list" id="list_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>