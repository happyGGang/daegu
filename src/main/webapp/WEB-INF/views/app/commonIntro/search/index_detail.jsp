<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">


</script>
<table>
<caption>도서의 소장위치, 청구기호, 등록정보, 상태 등을 나타내는 표</caption>
	<thead>
		<tr>
			<th>No.</th>
			<c:if test="${librarySearch.vLoca ne '00000001'}">
			<th>소장위치</th>
			<th>서가명</th>
			</c:if>
			<th>청구기호</th>
			<th>등록정보</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${detail.dsItemDetail}" var="i" varStatus="status">
		<tr>
			<td>${status.count}</td>
			<c:if test="${librarySearch.vLoca ne '00000001'}">
			<td class="txt-left">${fn:escapeXml(i.SUB_LOCA_NAME)}</td>
			<td class="txt-left">${fn:escapeXml(i.BOOKSH_NAME)}</td>
			</c:if>
			<td class="txt-left">${fn:escapeXml(i.LABEL_PLACE_NO_NAME)} ${fn:escapeXml(i.CALL_NO)}</td>
			<td>${fn:escapeXml(i.PRINT_ACSSON_NO)}</td>
			<td class="${i.LOAN_CHECK eq 'Y' ? 'y' : 'n'}">${fn:escapeXml(librarySearch.vLoca ne '00000001' ? i.DISPLAY_ITEM_STATUS : '대출가능')}</td>
		</tr>
		<c:if test="${fn:length(detail.dsItemDetail) < 1 }">
		<tr>
			<td colspan="5">조회된 자료가 없습니다.</td>
		</tr>
		</c:if>
		</c:forEach>
	</tbody>
</table>
