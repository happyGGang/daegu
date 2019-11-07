<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					
				}
			},{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 400
	});
	
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="historyForm" modelAttribute="teacher" method="post" action="">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
	<table class="type2">
		<colgroup>
	       <col width="*"/>
       	</colgroup>
       	<thead>
       		<tr>
       			<th>강의명</th>
     		</tr>
       	</thead>
       	<tbody>
       		<c:forEach items="${history}" var="i">
	       		<tr>
		         	<td>${i.teach_name}</td>
	        	</tr>
       		</c:forEach>
       		<c:if test="${fn:length(history) < 1}">
				<tr>
					<td class="center">조회된 이력이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</form:form>
