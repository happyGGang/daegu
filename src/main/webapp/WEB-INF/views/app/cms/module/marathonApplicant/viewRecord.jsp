<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({
		autoOpen: false,
		resizable: true,
		modal: true,
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
			$('.ui-widget-overlay').removeClass('custom-overlay');
		},
		buttons: [
			{
				text: "닫기",
				"class": 'btn',
				click: function(){
					$('#dialog-2').dialog('destroy');
				}
			}
		]
	});

	$('#dialog-2').dialog({
		width: 1100,
		height: 900
	});
	
	$('a.formPrint-btn').on('click', function(e) {
		var divToPrint = $('div#printPage').clone();
		divToPrint = divToPrint.show()[0];
	    newWin= window.open("");
	    newWin.document.write(divToPrint.outerHTML);
	    newWin.document.close();
	    newWin.print();
	    newWin.close();
	});
});
</script>

<table class="type1 center">
	<colgroup>
		<col width="200"/>
		<col width="*"/>
	</colgroup>
	<thead>
		<tr>
			<th colspan="2" style="background:#fff;border-top:1px solid black;border-left:0px;border-right:0px;color:black;font-weight:bold;padding:15px 0px;">신청자 정보</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>목표페이지 / 누적페이지</th>
			<td style="text-align:left;"><fmt:formatNumber value="${read_page_count_total}" pattern="#,###"/> / <fmt:formatNumber value="${marathonApplicant.page_count}" pattern="#,###"/>
			 (남은 페이지 :
			 <c:choose>
			 	<c:when test="${marathonApplicant.page_count - read_page_count_total <= 0}">
			 		<fmt:formatNumber value="0"/>)
			 	</c:when>
			 	<c:otherwise>
			 		<fmt:formatNumber value="${marathonApplicant.page_count - read_page_count_total}" pattern="#,###"/>)
			 	</c:otherwise>
			 </c:choose>
			 </td>
		</tr>
		<tr>
			<th>달성율</th>
			<td style="text-align:left;"><fmt:formatNumber value="${(read_page_count_total / marathonApplicant.page_count) * 100}" pattern="##.##"/>%</td>
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
	
<div style="float:right;margin-top:3%;margin-bottom:1%;">
	<a href="#" class="btn btn1 formPrint-btn"><i class="fa fa-file-excel-o"></i><span>인쇄</span></a>
</div>
<div style="margin-top:5%;">전체 <span style="font-weight:bold;">${fn:length(marathonRecordList)}</span>개</div>
	
	
<table class="type1 center">
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>도서명</th>
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
		<c:forEach items="${marathonRecordList}" var="i" varStatus="status">
			<tr>
				<td>${fn:length(marathonRecordList) - status.index}</td>
				<td>${i.member_name}</td>
				<td style="width:25%;">${i.book_name}</td>
				<td style="width:20%;">${i.book_author}</td>
				<td>${i.publisher}</td>
				<td><fmt:formatDate value="${i.record_date}" pattern="yyyy.MM.dd"/></td>
				<td>${i.book_type}</td>
				<td><fmt:formatNumber value="${i.read_page_count}" pattern="#,###"/></td>
				<td><fmt:formatNumber value="${i.read_page_count_acc}" pattern="#,###"/></td>
				<td style="width:15%">
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
							공공도서관(본리도서관)
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
				<td colspan="10" style="text-align:left;padding:5px 5px 5px 5px;background-color:#EEEEEE;white-space:pre-wrap;">${i.book_journals}</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(marathonRecordList) < 1}">
			<tr>
				<td colspan="10">등록된 내용이 없습니다.</td> 
			</tr>
		</c:if>
	</tbody>
</table>

<div id="printPage" class="center" style="display:none; width:600; float:center">
<%@ include file="print.jsp"%>
</div>
	
