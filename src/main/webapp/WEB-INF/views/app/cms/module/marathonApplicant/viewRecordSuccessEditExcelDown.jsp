<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8;" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils, kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<%
	response.setContentType("application/vnd.ms-excel; charset=euc-kr;");

	String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
	String filename = "일지 목록_" + today + ".xls";

	response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(filename, request.getHeader("user-agent")));
%>
	<style>
		table {border-collapse: collapse;}
	</style>
	<div style="font-size:25px;font-weight:bold;">
		독서 이력
	</div>
	<br/>
	<table style="font-size:15px;padding:5px 5px">
		<c:forEach items="${marathonRecordSuccessEditList}" var="i" varStatus="status">
			<c:set var="next" value="${marathonRecordSuccessEditList[status.count]}"/>
			<tr>
				<td style="border:1px solid black;width:70px;">${i.member_name}</td>
				<td style="border:1px solid black;width:250px;">${i.book_name}</td>
				<td style="border:1px solid black;width:250px;">${i.book_author}</td>
				<td style="border:1px solid black;width:200px;">${i.publisher}</td>
				<td style="border:1px solid black;width:90px;"><fmt:formatDate value="${i.record_date}" pattern="yyyy-MM-dd"/></td>
				<td style="border:1px solid black;width:70px;">${i.book_type}</td>
				<td style="border:1px solid black;width:70px;"><fmt:formatNumber value="${i.read_page_count}" pattern="#,###"/></td>
				<c:choose>
					<c:when test="${status.first}">
						<c:set var="read_page_count_total_thisPage_first" value="${read_page_count_total_thisPage_first + i.read_page_count}"/>
						<td style="border:1px solid black;width:70px;"><fmt:formatNumber value="${read_page_count_total_thisPage_first}" pattern="#,###"/></td>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${i.applicant_idx == next.applicant_idx}">
								<td style="border:1px solid black;width:70px;"><fmt:formatNumber value="${read_page_count_total_thisPage_first + i.read_page_count}" pattern="#,###"/></td>
								<c:set var="read_page_count_total_thisPage_first" value="${read_page_count_total_thisPage_first + i.read_page_count}"/>
							</c:when>
							<c:otherwise>
								<td style="border:1px solid black;width:70px;"><fmt:formatNumber value="${read_page_count_total_thisPage_first + i.read_page_count}" pattern="#,###"/></td>
								<c:remove var="read_page_count_total_thisPage_first"/>
								<c:set var="read_page_count_total_thisPage_first" value="0"/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<td style="border:1px solid black;width:100px;">${i.member_id}</td>
				<td style="border:1px solid black;width:200px;">
					<c:choose>
						<c:when test="${i.book_resources == '100'}">
							달서가족문화도서관
						</c:when>
						<c:when test="${i.book_resources == '200'}">
							달서구립도원도서관
						</c:when>
						<c:when test="${i.book_resources == '300'}">
							달서어린이도서관
						</c:when>
						<c:when test="${i.book_resources == '400'}">
							달서영어도서관
						</c:when>
						<c:when test="${i.book_resources == '500'}">
							도원도서관
						</c:when>
						<c:when test="${i.book_resources == '600'}">
							분리도서관
						</c:when>
						<c:when test="${i.book_resources == '700'}">
							성서도서관
						</c:when>
						<c:when test="${i.book_resources == '800'}">
							구입도서
						</c:when>
						<c:otherwise>
							${i.book_resources}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(marathonRecordSuccessEditList) < 1}">
			<tr>
				<td style="text-align:center;" colspan="10">등록된 내용이 없습니다.</td>
			</tr>
		</c:if>
	</table>
	