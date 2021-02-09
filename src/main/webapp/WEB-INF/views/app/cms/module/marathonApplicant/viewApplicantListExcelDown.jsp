<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8;" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, org.apache.commons.lang3.time.DateFormatUtils, kr.co.whalesoft.framework.utils.AttachmentUtils" %>
<%
	response.setContentType("application/vnd.ms-excel");

	String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
	String filename = "참가자 목록_" + today + ".xls";

	response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(filename, request.getHeader("user-agent")));
%> 
	<style>
		table {margin-top:3%; border:1px solid black; font-size:15px; width:1200px; border-collapse:collapse;} 
		th {border:1px solid black; cellpadding:10px; border-collapse:collapse;}
		td {border:1px solid black; cellpadding:10px; border-collapse:collapse;}
	</style>
	<div style="font-size:25px;font-weight:bold;">
		참가자목록
	</div>
	<br/>
	<table style="margin-top:3%;border:1px solid black;font-size:15px;padding:5px 5px">
		<tr>
			<th style="width:60px;">순번</th>
			<th style="width:100px;">아이디</th>
			<th style="width:60px;">이름</th>
			<th style="width:100px;">학교</th>
			<th style="width:50px;">학년</th>
			<th style="width:40px;">반</th>
			<th style="width:250px;">주소</th>
			<th style="width:70px;">참가종목</th>
			<th style="width:80px;">완주기념품</th>
			<th style="width:80px;">휴대폰</th>
			<th style="width:80px;">일반전화</th>
			<th style="width:130px;">이메일</th>
			<th style="width:40px;">성별</th>
			<th style="width:90px;">생년월일</th>
			<th style="width:90px;">참가신청일</th>
			<th style="width:300px;">각오한마디</th>
			<th style="width:60px;">기록</th>
			<th style="width:90px;">완주일</th>
			<th style="width:80px;">완주여부</th>
		</tr>
		<c:forEach items="${marathonApplicantList}" var="i" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td>${i.member_id}</td>
				<td>${i.member_name}</td>
				<td>${i.school_name}</td>
				<td>${i.school_class_one}</td>
				<td>${i.school_class_two}</td>
				<td>${i.address_one} ${i.address_two}</td>
				<td>${i.contest_type}</td>
				<td>${i.finish_memorial == 'document' ? '완주증서' : '완주메달'}</td>
				<td>${i.cellphone}</td>
				<td>${i.telephone}</td>
				<td>${i.email}</td>
				<td>${i.gender == 'M' ? '남' : '여'}</td>
				<td>${i.birthday}</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
				<td>${i.determination_talk}</td>
				<td><fmt:formatNumber value="${i.read_page_count_total}" pattern="#,###"/></td>
				<td><fmt:formatDate value="${i.finish_date}" pattern="yyyy-MM-dd"/></td>
				<c:choose>
					<c:when test="${i.process_status == 0}">
						<td style="color:black">심사대기</td>
					</c:when>
					<c:when test="${i.process_status == 1}">
						<td style="color:blue">완주완료</td>
					</c:when>
					<c:otherwise>
						<td style="color:red">완주실패</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(marathonApplicantList) < 1}">
			<tr>
				<td colspan="19" style="text-align:center;">등록된 참가자가 없습니다.</td> 
			</tr>
		</c:if>
	</table>
	
