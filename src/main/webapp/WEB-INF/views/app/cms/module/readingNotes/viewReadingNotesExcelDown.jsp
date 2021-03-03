<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8;" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils, kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<%@ page import="kr.co.whalesoft.app.cms.member.Member" %>
<%@ page import="kr.go.gbelib.app.cms.module.readingNotes.ReadingNotes" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<%
	response.setContentType("application/vnd.ms-excel; charset=UTF-8;");

	String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
	ReadingNotes readingNotes = (ReadingNotes)request.getAttribute("readingNotes");
	Member member = (Member)request.getAttribute("member");
	String filename = "독서노트_" + today + ".xls";

	response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(filename, request.getHeader("user-agent")));
%>
	<style>
		table {border-collapse: collapse;}
	</style>
	<div style="font-size:25px;font-weight:bold;">
		독서 노트
	</div>
	<br/>
	<table style="margin-top:3%;font-size:15px;padding:5px 5px">
		<tr>
			<th style="border:thin solid black;width:100px;">번호</th>
			<th style="border:thin solid black;">작성자 / 대출번호</th>
			<th style="border:thin solid black;">도서명</th>
			<th style="border:thin solid black;">자료구분</th>
			<th style="border:thin solid black;">일지상태</th>
			<th style="border:thin solid black;">사유</th>
			<th style="border:thin solid black;">완독일</th>
			<th style="border:thin solid black;">등록일</th>
		</tr>
		<c:forEach items="${readingNotesList}" var="i" varStatus="status">
		<tr>
			<td style="border:thin solid black;">${status.count}</td>
			<td style="border:thin solid black;">${i.member_name} / ${i.user_no}</td>
			<td style="border:thin solid black;">${i.book_name}</td>
			<td style="border:thin solid black;">
				<c:choose>
					<c:when test="${i.book_type eq 'LOAN'}">
						대출도서
					</c:when>
					<c:otherwise>
						개별(API)
					</c:otherwise>
				</c:choose>
			</td>
			<td style="border:thin solid black;">
				<c:choose>
					<c:when test="${i.approve_status eq 'C'}">
						확인중
					</c:when>
					<c:when test="${i.approve_status eq 'Y'}">
						승인
					</c:when>
					<c:otherwise>
						반려
					</c:otherwise>
				</c:choose>
			</td>
			<td style="border:thin solid black;">${i.cancel_reason}</td>
			<td style="border:thin solid black;">${i.read_success_date}</td>
			<td style="border:thin solid black;"><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td colspan="8" style="border:thin solid black;">
				${fn:replace(i.contents, crlf, '<br/>')}
			</td>
		</tr>
		</c:forEach>
	</table>
	