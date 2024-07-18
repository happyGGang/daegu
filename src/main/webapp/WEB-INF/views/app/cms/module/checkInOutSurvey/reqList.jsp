<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(checkInOutSurveyReqList)}' > 0) {
						$('#winnerForm').attr('action', '/cms/module/checkInOutSurveyReq/excelDownload.do').submit();
					} else {
						alert('해당 내역이 없습니다.');	
					}
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
	
	$("#dialog-3").dialog({
		width: 1300,
		height: 700
	});
	
	$('div#cms_paging_ajax a').on('click', function(e) {
		$('#viewPage_ajax').attr('value', $(this).attr('keyValue'));
		var param = $('form#checkInOutSurveyForm').serialize();
		$('div#dialog-3').load('reqList.do?' + param);
		e.preventDefault();
	});
	
});

</script>

<div>
<h3>
	설문조사명 : ${checkInOutSurvey.checkinout_survey_name}
</h3>
</div>
<br/>
<form:form id="checkInOutSurveyForm" modelAttribute="checkInOutSurveyReq" action="reqList.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="checkinout_survey_idx"/>	
	<form:hidden id="viewPage_ajax" path="viewPage"/>		
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="250" />
			<col width="50" />
			<col width="50" />
			<col width="150" />
		</colgroup>
       	<thead>
       		<tr>
       			<th>번호</th>
       			<th>이용장소</th>
       			<th>나이</th>
       			<th>성별</th>
       			<th>응모일시</th>
       		</tr>
       	</thead>
       	<tbody>
       		<c:choose>
       			<c:when test="${fn:length(checkInOutSurveyReqList) > 0}">
       				<c:forEach items="${checkInOutSurveyReqList}" var="i" varStatus="status">
			       		<tr>
							<td>${status.count}</td>
				         	<td>${i.checkinout_survey_answer}</td>
				         	<td>
								<c:forTokens items="${i.checkinout_survey_answer}" delims="|" var="oneAnswer" varStatus="status">
								<c:if test="${fn:replace(fn:trim(checkInOutSurveyQuestionList[status.index].checkinout_survey_answer), ' ', '') eq fn:replace(fn:trim(oneAnswer), ' ', '')}">

								</c:if> ${oneAnswer}
								</c:forTokens>
							</td>
				         	<td>${i.member_age}</td>
				         	<td>${i.member_sex}</td>
				         	<td>${i.add_date}</td>
				        </tr>
		       		</c:forEach>
       			</c:when>
       			<c:otherwise>
       				<tr>
       					<td colspan="14">조회된 데이터가 없습니다.</td>
       				</tr>
       			</c:otherwise>
       		</c:choose>
		</tbody>
	</table>
	
	<div id="cms_paging_ajax" class="dataTables_paginate">
		<c:if test="${paging.firstPageNum > 0}">
			<a href="#" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<a href="#" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
		</c:if>
		<span>
			<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
			<c:choose>
			<c:when test="${i eq paging.viewPage}">
				<a href="#" class="paginate_button current" keyValue="${i}">${i}</a>
			</c:when>
			<c:otherwise>
				<a href="#" class="paginate_button" keyValue="${i}">${i}</a>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${paging.nextPageNum > 0}">
				<a href="#" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
			</c:if>
			<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
				<a href="#" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
			</c:if>
		</span>
	</div>
</form:form>
