<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(document).ready(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "인쇄",
				"class": 'btn',
				click: function() {
					window.print();					
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

	$("#dialog-5").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 820,
		height: 800
	});
});

</script>
<div class="guide">
	<div class="inBox">
		<div class="list QType">
			<h1>${survey.survey_title}</h1>
			${survey.survey_content}
		</div>
	</div>
	<div class="infodesk">
		검색 결과 : 총 ${fn:length(answerUser)}건
	</div>
	<table class="type1 center">
		<tbody>
		<caption></caption>
		<colgroup>
			<col width="50" />
			<col />
			<col />
			<col />
			<col />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>성명</th>
				<th>회원구분</th>
				<th>아이피</th>
				<th>설문일시</th>
				<th>당첨자 여부</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${answerUser}">
			<tr>
				<td>${status.count}</td>
				<td>${i.add_user_name}</td>
				<td>${i.add_user_div}</td>
				<td>${i.add_user_ip}</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd HH:mm"/> </td>
				<td>${i.chosen_yn}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table> 
</div>