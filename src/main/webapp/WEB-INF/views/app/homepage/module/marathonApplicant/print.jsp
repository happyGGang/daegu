<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<title style="margin-left:10%;">독서마라톤 신청자정보</title>
<style>
	div#printPage .type1{
		border-collapse: collapse;
	}
	div#printPage .type1 th, td{
		border:1px solid gray;
		border-collapse: collapse;
		border-spacing:0px;
	}
	div#printPage .type1 th{
		width:30%;
		border-left: 0px;
	}
	div#printPage .type1 td{
		padding-left:1%;
		border-right: 0px;
	}
	div#printPage .type2{
		border-collapse: collapse;
	}
	div#printPage .type2 th{
		border-bottom: 1px solid gray;padding-bottom:10px;font-weight:normal;
	}
	div#printPage .type2 td{
		text-align:center;
		border-bottom: 1px solid gray;
		border-right: 0px;
		border-left: 0px;
		padding:15px 0px;
	}
</style>
<form id="printForm" method="post" action="save.do">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<table class="type1" style="width:100%;">
	<colgroup>
		<col width="200"/>
		<col width="*"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="2" style="background:#fff;border-top:2px solid black;border-left:0px;border-right:0px;border-bottom:0px;color:black;font-weight:normal;padding:15px 0px;">신청자 정보</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>목표페이지 / 누적페이지</th>
			<td style="text-align:left;"><fmt:formatNumber value="${read_page_count_total}" pattern="#,###"/> / <fmt:formatNumber value="${marathonApplicant.page_count}" pattern="#,###"/>
			 (남은 페이지 : <fmt:formatNumber value="${marathonApplicant.page_count - read_page_count_total}" pattern="#,###"/>)</td>
		</tr>
		<tr>
			<th>달성율</th>
			<td style="text-align:left;"><fmt:formatNumber value="${(marathonApplicant.read_page_count_total / marathonApplicant.page_count) * 100}" pattern="##.##"/>%</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td style="text-align:left;">${marathonApplicant.member_id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td style="text-align:left;">${marathonApplicant.member_name}</td>
		</tr>
		<tr>
			<th>참가종목</th>
			<td style="text-align:left;">${marathonApplicant.contest_type} (<fmt:formatNumber value="${marathonApplicant.page_count}" pattern="#,###"/>쪽)</td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td style="text-align:left;">${marathonApplicant.telephone}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td style="text-align:left;">${marathonApplicant.cellphone}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td style="text-align:left;">${marathonApplicant.email}</td>
		</tr>
		<tr>
			<th>참가신청일</th>
			<td style="text-align:left;"><fmt:formatDate value="${marathonApplicant.add_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
		<tr>
			<th>각오한마디</th>
			<td style="text-align:left;">${marathonApplicant.determination_talk}</td>
		</tr>
	</tbody>
</table>

<div style="margin-top:5%;margin-bottom:1%;">전체 <span style="font-weight:bold;">${fn:length(marathonRecordList)}</span>개</div>

<table class="type2" style="width:100%;">
	<thead>
		<tr>
			<th style="background:#fff;border-top:2px solid black;border-left:0px;border-right:0px;border-bottom:0px;color:black;font-weight:bold;padding-bottom:10px;" colspan="10"></th>
		</tr>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th style="width:25%;">도서명</th>
			<th>저자</th>
			<th>출판사</th>
			<th>날짜</th>
			<th>분류번호</th>
			<th>읽은쪽수</th>
			<th>누적쪽수</th>
			<th>도서관구분</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${marathonRecordList}" var="i">
			<tr>
				<td>${i.record_idx}</td>
				<td>${i.member_name}</td>
				<td>${i.book_name}</td>
				<td>${i.book_author}</td>
				<td>${i.publisher}</td>
				<td><fmt:formatDate value="${i.record_date}" pattern="yyyy.MM.dd"/></td>
				<td>${i.book_type}</td>
				<td><fmt:formatNumber value="${i.read_page_count}" pattern="#,###"/></td>
				<c:set var="read_page_count_total_thisPage" value="${read_page_count_total_thisPage + i.read_page_count}"/>
				<td><fmt:formatNumber value="${read_page_count_total_thisPage}" pattern="#,###"/></td>
				<td>
					<c:choose>
						<c:when test="${i.book_resources == '100'}">
							공공도서관(달서가족문화도서관)
						</c:when>
						<c:when test="${i.book_resources == '200'}">
							공공도서관(달서구립도원도서관)
						</c:when>
						<c:when test="${i.book_resources == '300'}">
							공공도서관(달서어린이도서관)
						</c:when>
						<c:when test="${i.book_resources == '400'}">
							공공도서관(달서영어도서관)
						</c:when>
						<c:when test="${i.book_resources == '500'}">
							공공도서관(도원도서관)
						</c:when>
						<c:when test="${i.book_resources == '600'}">
							공공도서관(분리도서관)
						</c:when>
						<c:when test="${i.book_resources == '700'}">
							공공도서관(성서도서관)
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
				<td colspan="10" style="width:600;text-align:left;padding:5px 5px 5px 5px;">
				<pre style="word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${i.book_journals}</pre></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(marathonRecordList) < 1}">
			<tr>
				<td colspan="10" style="border-left:0px;border-right:0px;border-bottom:1px solid gray;padding:15px 0px;text-align:center;">등록된 내용이 없습니다.</td> 
			</tr>
		</c:if>
	</tbody>
</table>
</form>