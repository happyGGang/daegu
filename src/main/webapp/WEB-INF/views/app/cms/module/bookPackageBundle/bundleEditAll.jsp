<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
function addBookPackageDetailAll() {
	if ( doAjaxPost($('#bookPackageBundle')) ) {
		location.reload();
	}
}
</script>
<form:form id="bookPackageBundle" modelAttribute="bookPackageBundle" action="addBookPackageDetailAll.do" method="POST">
<form:hidden path="book_package_bundle_detail_idx_arr"/>
${bookPackageBundle.book_package_bundle_detail_idx_arr}
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수선택항목입니다.</p>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	        	<th>도서명(<span style="color: red;font-weight: bold;">*</span>)</th>
	        	<td>
	        		<c:forEach items="${bookPackageDetailList}" var="i" varStatus="status">
					${i.book_package_name}
					</c:forEach>
	        	</td>
	        </tr>
	        <tr>
	        	<th>책꾸러미명(<span style="color: red;font-weight: bold;">*</span>)</th>
	        	<td>
	        		<c:choose>
	        			<c:when test="${bookPackageBundle.book_package_bundle_idx ne 0}">
	        			${bookPackageBundle.book_package_bundle_title}
	        			</c:when>
	        			<c:otherwise>
	        			<form:select path="book_package_bundle_idx">
							<c:forEach var="i" varStatus="status" items="${bookPackageBundleList}">
								<option value="${i.book_package_bundle_idx}">${i.book_package_bundle_title}</option>
							</c:forEach>
						</form:select>
	        			</c:otherwise>
	        		</c:choose>
	        	</td>
	        </tr>
		</tbody>
	</table>
</form:form>