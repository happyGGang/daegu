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
					if ( doAjaxPost($('#historyForm')) ) {
						location.reload();
					} 
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
		width: 1400,
		height: 600
	});
	
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="historyForm" modelAttribute="teacher" method="post" action="modifyManageHistory.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
	<table class="type2 center">
		<colgroup>
	       <col width="*"/>
       	</colgroup>
       	<thead>
       		<tr>
       			<th width="100">강사 이력 관리</th>
       			<td>
       				<form:textarea path="teacher_history_manage" class="text" style="width:100%; height:100px"/>
       			</td>
     		</tr>
       	</thead>
       	<tbody>
       		<tr>
     			<td colspan="2">
     				<div class="ui-state-highlight">
						<em>* 위 이력은 관리자가 등록하는 강사의 이력입니다.</em>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>


<table class="type1 center">
	<colgroup>
       <col width="*"/>
   	</colgroup>
    <thead>
    	<tr>
    		<th rowspan="2">번호</th>
    		<th rowspan="2">성명</th>
    		<th rowspan="2">생년월일</th>
    		<th rowspan="2">성별</th>
    		<th colspan="2">전화번호</th>
    		<th rowspan="2">e-mail</th>
    		<th rowspan="2">주소</th>
    		<th rowspan="2">강의 기간</th>
    		<th rowspan="2">강의 일수</th>
    		<th rowspan="2">강의 시간</th>
    		<th rowspan="2">강의 횟수 (시간)</th>
    		<th colspan="2">강의 관련 사항</th>
    		<th rowspan="2">강의 과목</th>
    		<th rowspan="2">비고</th>
    	</tr>
    	<tr>
    		<th>집전화</th>
    		<th>휴대폰</th>
    		<th>학과,경력</th>
    		<th>자격증</th>
    	</tr>
    </thead>
    <tbody>
      	<c:forEach items="${history}" var="i" varStatus="status">
       		<tr>
       			<td>${status.count}</td>
	         	<td>${i.teacher_name}</td>
	         	<td>${i.teacher_birth}</td>
	         	<td>${i.teacher_sex}</td>
	         	<td>${i.teacher_phone}</td>
	         	<td>${i.teacher_cell_phone}</td>
	         	<td>${i.teacher_email}</td>
	         	<td>${i.teacher_address}</td>
	         	<td>${i.start_date} ~ ${i.end_date}</td>
	         	<td>${i.teach_count}</td>
	         	<td>${i.start_time} ~ ${i.end_time}</td>
	         	<td>${i.teach_count}(${i.total_time})</td>
	         	<td></td>
	         	<td></td>
	         	<td>${i.teach_name}</td>
	         	<td>${i.group_name}/${i.category_name}</td>
        	</tr>
      	</c:forEach>
      	<c:if test="${fn:length(history) < 1}">
			<tr>
				<td colspan="2" class="center">조회된 이력이 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>