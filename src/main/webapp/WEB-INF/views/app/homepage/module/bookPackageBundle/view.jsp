<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
dl dt {display: inline-block;border-right: 1px solid silver;padding-right: 5px;margin-right: 5px;}
dl dd {display: inline-block;margin-right: 15px;}

.bookPackageBundleAll {border: 1px solid #e5e8eb;border-left-width: 0px;border-right-width: 0px;}
.bookPackageBundleSubject {font-size: 20px;background: #f6f6f6;font-weight: bold;text-align: center;height: 42px;width: 1000px;display: table-cell;vertical-align: middle;border: 1px solid #e5e8eb;}
.bookPackageBundleList::after {
	content: '';
	display: block;
	width: 100%;
	clear: both;
}
.bookPackageBundleList .bookPackageBundleListItem {
	float: left;
	width: 48%;
	margin: 1em 0;
}
.bookPackageBundleList .bookPackageBundleListItem:nth-child(odd) {clear: left;}
.bookPackageBundleList .bookPackageBundleListItem:nth-child(2n) {margin-left: 4%;}
.bookPackageBundleList .bookPackageBundleListItem dl {border: 1px solid #e5e8eb;border-left-width: 0px;border-right-width: 0px;}

@media screen and (max-width: 540px){
	.bookPackageBundleList .bookPackageBundleListItem {
		float: none;
		width: 100%;
	}
	.bookPackageBundleList .bookPackageBundleListItem:nth-child(2n) {margin-left: 0;}
}

</style>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="bookPackageBundle" action="index.do" method="GET">
<form:hidden path="menu_idx"/>
<form:hidden path="viewPage"/>

<div class="bookPackageBundleAll">
	<div class="bookPackageBundleSubject">
		꾸러미명 : ${bookPackageBundle.book_package_bundle_title}
	</div>
	<div class="bookPackageBundleList">
		<c:forEach var="j" varStatus="status" begin="0" end="1">
			<c:forEach items="${bookPackageBundleList}" var="i" varStatus="status" begin="${j}" step="2">
			<div class="bookPackageBundleListItem">
				<dl style="background: #f6f6f6;">
					도서명 : ${i.book_package_name}
				</dl>
				<dl>
					<dt>작가</dt><dd>${i.author}</dd>
					<dt>출판사</dt><dd>${i.publisher}</dd>
					<dt>출판 연도</dt><dd>${i.publish_year}</dd>
				</dl>
				<dl>
					<dt>대출가능권수</dt><dd>${i.loan_count}권</dd>
					<dt>소장권수</dt><dd>${i.quantity}</dd>
				</dl>
				<dl>
					<dt>수준법</dt>
					<dd>
						<c:choose>
							<c:when test="${i.grade eq '3'}">초</c:when>
							<c:when test="${i.grade eq '4'}">중</c:when>
							<c:when test="${i.grade eq '5'}">고</c:when>
						</c:choose>
					</dd>
					<dt>주류법</dt>
					<dd>
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
					</dd>
				</dl>
				<dl>
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
					<br>
					${i.content}
				</dl>
			</div>
			</c:forEach>
		</c:forEach>
	</div>
</div>
</form:form>

<div class="button bbs-btn center">
	<a href="" class="btn btn1 list" id="list_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
</div>