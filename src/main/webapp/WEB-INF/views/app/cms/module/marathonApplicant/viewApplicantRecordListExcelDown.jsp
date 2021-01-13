<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8;" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils, kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<%
	response.setContentType("application/vnd.ms-excel; charset=EUC-KR;");

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
	<table style="margin-top:3%;font-size:15px;padding:5px 5px">
		<c:set var="count" value="1"/>
		<c:forEach items="${marathonApplicantRecordList}" var="i" varStatus="status">
			<c:if test="${status.count > 1}">
				<c:set var="before" value="${marathonApplicantRecordList[status.count - 2]}"/>
			</c:if>
			<c:choose>
				<c:when test="${status.first}">
					<tr>
						<td colspan="2" style="width:350px;text-align:left;">번호</th>
						<th style="width:250px;text-align:left;">아이디</th>
						<td style="width:250px;text-align:left;">이름</th>
						<td style="width:250px;text-align:left;">학교</th>
						<td style="width:70px;text-align:left;">학년</th>
						<th colspan="2" style="width:280px;text-align:left;">참가종목</th>
						<th style="width:130px;text-align:left;">달성률</th>
						<th style="width:200px;text-align:left;">달성일</th>
					</tr>
					<tr>
						<td rowspan="2" colspan="2">${count}</td>
						<td rowspan="2">${i.member_id}</td>
						<td rowspan="2">${i.member_name}</td>
						<td rowspan="2">${i.school_name}</td>
						<td rowspan="2">${i.school_class_one}</td>
						<td rowspan="2">${i.contest_type} (<fmt:formatNumber value="${i.page_count}" pattern="#,###"/>쪽)</td>
						<td>목표치 : <fmt:formatNumber value="${i.page_count}" pattern="#,###"/></td>
						<td rowspan="2" style="color:red;font-weight:bold;"><fmt:formatNumber value="${(i.read_page_count_total / i.page_count) * 100}" pattern="####.##"/>%</td>
						<td rowspan="2"><fmt:formatDate value="${i.finish_date}" pattern="yyyy-MM-dd HH:mm"/></td>
					</tr>
					<tr>
						<td>달성치 : <fmt:formatNumber value="${i.read_page_count_total}" pattern="#,###"/></td>
					</tr>
					<tr>
						<th style="border:1px solid black;width:100px;">이름</th>
						<th style="border:1px solid black;">도서제목</th>
						<th style="border:1px solid black;">저자</th>
						<th style="border:1px solid black;">출판사</th>
						<th style="border:1px solid black;">날짜</th>
						<th style="border:1px solid black;">분류번호</th>
						<th style="border:1px solid black;">읽은쪽수</th>
						<th style="border:1px solid black;">누적쪽수</th>
						<th style="border:1px solid black;">아이디</th>
						<th style="border:1px solid black;">대출도서관</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:if test="${i.applicant_idx != before.applicant_idx}">
						<c:set var="count" value="${count + 1}"/>
						<tr>
							<td colspan="2" style="width:350px;text-align:left;">번호</th>
							<th style="width:250px;text-align:left;">아이디</th>
							<td style="width:250px;text-align:left;">이름</th>
							<td style="width:250px;text-align:left;">학교</th>
							<td style="width:70px;text-align:left;">학년</th>
							<th colspan="2" style="width:280px;text-align:left;">참가종목</th>
							<th style="width:130px;text-align:left;">달성률</th>
							<th style="width:200px;text-align:left;">달성일</th>
						</tr>
						<tr>
							<td rowspan="2" colspan="2">${count}</td>
							<td rowspan="2">${i.member_id}</td>
							<td rowspan="2">${i.member_name}</td>
							<td rowspan="2">${i.school_name}</td>
							<td rowspan="2">${i.school_class_one}</td>
							<td rowspan="2">${i.contest_type} (<fmt:formatNumber value="${i.page_count}" pattern="#,###"/>쪽)</td>
							<td>목표치 : <fmt:formatNumber value="${i.page_count}" pattern="#,###"/></td>
							<td rowspan="2" style="color:red;"><fmt:formatNumber value="${(i.read_page_count_total / i.page_count) * 100}" pattern="####.##"/>%</td>
							<td rowspan="2"><fmt:formatDate value="${i.finish_date}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<td>달성치 : <fmt:formatNumber value="${i.read_page_count_total}" pattern="#,###"/></td>
						</tr>
						<tr>
							<th style="border:1px solid black;width:100px;">이름</th>
							<th style="border:1px solid black;">도서제목</th>
							<th style="border:1px solid black;">저자</th>
							<th style="border:1px solid black;">출판사</th>
							<th style="border:1px solid black;">날짜</th>
							<th style="border:1px solid black;">분류번호</th>
							<th style="border:1px solid black;">읽은쪽수</th>
							<th style="border:1px solid black;">누적쪽수</th>
							<th style="border:1px solid black;">아이디</th>
							<th style="border:1px solid black;">대출도서관</th>
						</tr>
					</c:if>
				</c:otherwise>
			</c:choose>
			<tr>
				<td style="border:1px solid black;">${i.member_name}</td>
				<td style="border:1px solid black;">${i.book_name}</td>
				<td style="border:1px solid black;">${i.book_author}</td>
				<td style="border:1px solid black;">${i.publisher}</td>
				<td style="border:1px solid black;"><fmt:formatDate value="${i.record_date}" pattern="yyyy-MM-dd"/></td>
				<td style="border:1px solid black;">${i.book_type}</td>
				<td style="border:1px solid black;"><fmt:formatNumber value="${i.read_page_count}" pattern="#,###"/></td>
				<c:choose>
					<c:when test="${status.first}">
						<c:set var="read_page_count_total_thisPage_first" value="${read_page_count_total_thisPage_first + i.read_page_count}"/>
						<td style="border:1px solid black;"><fmt:formatNumber value="${read_page_count_total_thisPage_first}" pattern="#,###"/></td>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${i.applicant_idx == before.applicant_idx}">
								<td style="border:1px solid black;"><fmt:formatNumber value="${read_page_count_total_thisPage_first + i.read_page_count}" pattern="#,###"/></td>
								<c:set var="read_page_count_total_thisPage_first" value="${read_page_count_total_thisPage_first + i.read_page_count}"/>
							</c:when>
							<c:otherwise>
								<c:remove var="read_page_count_total_thisPage_first"/>
								<c:set var="read_page_count_total_thisPage_first" value="0"/>
								<td style="border:1px solid black;"><fmt:formatNumber value="${read_page_count_total_thisPage_first + i.read_page_count}" pattern="#,###"/></td>
								<c:set var="read_page_count_total_thisPage_first" value="${read_page_count_total_thisPage_first + i.read_page_count}"/>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<td style="border:1px solid black;">${i.member_id}</td>
				<td style="border:1px solid black;">
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
						<c:when test="${i.book_resources == '900'}">
							소장도서
						</c:when>
						<c:otherwise>
							${i.book_resources}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td style="border:1px solid black;">독서감상문</td>
				<td colspan="5" style="border:1px solid black;white-space:pre;">
					${fn:replace(i.book_journals, crlf, '<br/>')}
				</td>
				<td style="border:1px solid black;"> </td>
				<td colspan="3" style="border:1px solid black;"></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(marathonApplicantRecordList) < 1}">
			<tr>
				<td colspan="2" style="width:350px;text-align:left;">번호</th>
				<th style="width:250px;text-align:left;">아이디</th>
				<td style="width:250px;text-align:left;">이름</th>
				<td style="width:250px;text-align:left;">학교</th>
				<td style="width:70px;text-align:left;">학년</th>
				<th colspan="2" style="width:280px;text-align:left;">참가종목</th>
				<th style="width:130px;text-align:left;">달성률</th>
				<th style="width:200px;text-align:left;">달성일</th>
			</tr>
			<tr>
				<td colspan="10" style="text-align:center;">등록된 내용이 없습니다.</td>
			</tr>
		</c:if>
	</table>
	