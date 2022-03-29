<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function bookPackageBundleSave() {
	if ( doAjaxPost($('#bookPackageBundle')) ) {
		location.reload();
	}
}

function deleteBookPackageDetail(book_package_bundle_detail_idx, book_package_bundle_idx, bundle_idx) {
	var ajaxData = {
			'bundle_idx' : bundle_idx
	};
	if(confirm('삭제 하시겠습니까?')) {
		$.ajax({
			type: "POST",
			url: 'deleteBookPackageDetail.do',
			data: ajaxData,
			success: function(response) {
				if(response.valid) {
					alert('삭제 되었습니다.');
				} else {
					alert(response.message);
				}
				drawBookPackageDetailData(book_package_bundle_idx);
			},
			error : function() {
				alert('삭제에 실패했습니다.\n관리자에게 문의해 주세요.');
			}
		});
	}
}
</script>
<form:form modelAttribute="bookPackageBundle" action="bookPackageBundleSave.do" >
	<c:if test="${fn:length(bookPackageDetailList) < 1}">
		<div align="center">
			<h3>등록된 학생추천도서꾸러미 리스트가 없습니다.</h3>
		</div>
	</c:if>
	<table class="type1 center">
		<colgroup>
			<col width="10%" />
			<col />
			<col width="10%" />
			<col width="10%" />
			<col width="10%"/>
			<col width="10%" />
			<col width="7%" />
		</colgroup>
		<thead>
			<tr>
				<th>주제</th>
				<th>도서명</th>
				<th>작가</th>
				<th>출판사</th>
				<th>출판년도</th>
				<th>키워드</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bookPackageDetailList}" var="i" varStatus="status">
				<tr>
					<td>
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
					</td>
					<td class="left">${i.book_package_name}</td>
					<td>${i.author}</td>
					<td>${i.publisher}</td>
					<td>${i.publish_year}</td>
					<td>
						<c:forTokens items="${i.keyword}" delims="," var="keyword">
							<span class="keyword">${keyword}</span>
						</c:forTokens>
					</td>
					<td><a href="javascript:void(0);" class="btn btn5" onclick="deleteBookPackageDetail('${i.book_package_bundle_detail_idx}', '${i.book_package_bundle_idx}', '${i.bundle_idx}')">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>
