<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/common/css/myDashBoard.css">

 <script type="text/javascript">

$(document).ready(function() {


});
</script>
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-body">
			<table>
				<c:if test="${empty noticeDetail}">
				</c:if>
				<c:if test="${not empty noticeDetail}">
				<tr>
					<th>제목</th>
					<td>${noticeDetail.dsMyLibraryListD[0].INFORM_TITLE}</td>
				</tr>
				<tr>
					<th>일시</th>
					<td>
						<fmt:parseDate var="curDate" value="${noticeDetail.dsMyLibraryListD[0].INSERT_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>

						<fmt:parseDate var="curDate" value="${noticeDetail.dsMyLibraryListD[0].INSERT_TIME}" pattern="HHmmss"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="HH:mm:ss"/>

					</td>
				</tr>
				<tr>
					<th>상세내용</th>
					<td>${noticeDetail.dsMyLibraryListD[0].CONTET_INFO}</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>