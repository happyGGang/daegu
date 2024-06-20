<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(document).ready(function() {
	$('div#teachBookViewArea').dialog({ //모달창 기본 스크립트 선언
		width: '100%',
		height: 700,
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "엑셀저장",
				"class": 'btn btn1',
				click: function() {
					$('#excelDownForm').submit();
				}
			},{
				text: "출력",
				"class": 'btn btn1',
				click: function() {
					var divToPrint = document.getElementById("teachBookViewArea");
					   newWin= window.open("");
					   newWin.document.write(divToPrint.outerHTML);
					   newWin.print();
					   newWin.close();
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});	
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form id="excelDownForm" modelAttribute="teachBook" action="excelDownload.do" method="get">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>	
</form:form>
<table class="type2 center" style="">
	<colgroup>
		<col width="100">
	</colgroup>
	<tbody>
		<c:choose>
			<c:when test="${fn:length(teachBookInfo) > 0 and fn:length(teachBookInfo[0]) > 1}">
				<c:forEach var="i" varStatus="status" items="${teachBookInfo}">
				<tr>
					<c:forEach var="j" varStatus="status_j" items="${i}">
						<c:choose>
							<c:when test="${status.first or status_j.first}">
								<th <c:if test="${ !status_j.first }">colspan="4"</c:if>style="font-weight: bold; text-align: center; background: #e8eef2; border-right: 1px solid #ced8da !important;">${j}</th>
							</c:when>
							<c:otherwise>
								<%-- 출석부 표시 --%>
								<c:set var="mark" value="${j}" />
								<c:choose>
								<c:when test="${mark eq '1'}">
									<c:set var="mark" value="●" />
								</c:when>
								<c:when test="${mark eq '2'}">
									<c:set var="mark" value="△" />
								</c:when>
								<c:when test="${mark eq '3'}">
									<c:set var="mark" value="×" />
								</c:when>
								<c:otherwise>
									<c:if test="${status_j.index % 4 eq 1  }">
										<c:set var="mark" value="－" />
									</c:if>
								</c:otherwise>
								</c:choose>
								<%-------------%>
								<td style="text-align: center; border-right: 1px solid #ced8da !important;">${mark}</td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
			<tr>
				<td style="width:100%">조회된 데이터가 없습니다.</td>
			</tr>			
			</c:otherwise>
		</c:choose>
	</tbody>
</table>