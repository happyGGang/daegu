<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
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
				text: "닫기",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 430
	});
	
	$('.ui-calendar').each(function() {
		$(this).datepicker({
			//기본달력
		});
	});
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="teachForm" modelAttribute="teach" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teach_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>카테고리</th>			
	         	<td>${teach.category_name}</td>
        	</tr>
			<tr>
	         	<th>강의명</th>			
	         	<td>${teach.teach_name}</td>
        	</tr>	        
	        <tr>
	         	<th>강의상태</th>
	         	<td>
	         		<c:if test="${teach.teach_status eq 1 }">
	         			접수마감
	         		</c:if>
	         		<c:if test="${teach.teach_status eq 2 }">
	         			접수대기
	         		</c:if>
	         		<c:if test="${teach.teach_status eq 3 }">
	         			오프라인
	         		</c:if>
	         		<c:if test="${teach.teach_status eq 4 }">
	         			폐강
	         		</c:if>					
				</td>
	        </tr>
        	<tr>
	         	<th>모집인원</th>
	         	<td>${teach.teach_limit_count }</td>
	        </tr>
	        <tr>
	         	<th>모집후보인원</th>
	         	<td>${teach.teach_backup_count }</td>
	        </tr>	        
	        <tr>
				<th>접수기간</th>
				<td>
					${teach.start_join_date } ~ ${teach.end_join_date }
				</td>
			</tr>
			<tr>
				<th>접수시간</th>
				<td>
					${teach.start_join_time } ~ ${teach.end_join_time }					
				</td>
			</tr>
			<tr>
				<th>강의요일</th>
				<td>
					매주
					<c:forEach var="i" varStatus="stats_j" items="${teach.teach_day_arr}">											
						<c:if test="${i eq 1 }">
		         			일
		         		</c:if>
		         		<c:if test="${i eq 2 }">
		         			월
		         		</c:if>
		         		<c:if test="${i eq 3 }">
		         			화
		         		</c:if>
		         		<c:if test="${i eq 4 }">
		         			수
		         		</c:if>
		         		<c:if test="${i eq 5 }">
		         			목
		         		</c:if>
		         		<c:if test="${i eq 6 }">
		         			금
		         		</c:if>
		         		<c:if test="${i eq 7 }">
		         			토
		         		</c:if>	
					</c:forEach>
<%-- 					<input type="checkbox" name="teach_day" id="day${i}" value="${i}" ${checked} /><label for="day${i}">${label}</label>&nbsp; --%>
				</td>
			</tr>
			<tr>
				<th>강의기간(*)</th>
				<td>
					${teach.start_date } ~ ${teach.end_date }
				</td>
			</tr>
			<tr>
				<th>강의시간(*)</th>
				<td>
					${teach.start_time } ~ ${teach.end_time }					
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
