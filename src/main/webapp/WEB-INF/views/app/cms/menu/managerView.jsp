<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('div#dialog_manager').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	        $('button.cancel-btn').focus();
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn cancel-btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("div#dialog_manager").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 650,
		height: 500
	});
	
	$('a.select-btn').on('click', function(e) {
		e.preventDefault();
		$('#manager_dept').val($(this).attr('keyValue1'));
		$('#manager_name').val($(this).attr('keyValue2'));
		$('#manager_phone').val($(this).attr('keyValue3'));
		$('#manager_idx').val($(this).attr('keyValue4'));
		$('div#dialog_manager').dialog('destroy');
	});
	
});

</script>
<table class="type1 center">
	<colgroup>
		<col width="50" />
       	<col width="130" />
       	<col width="130" />
       	<col width="130" />
       	<col width="130" />
       	<col width="80"/>
      	</colgroup>
      	<thead>
      		<tr>
      			<th>번호</th>
      			<th>부서</th>
      			<th>담당자</th>
      			<th>전화번호</th>
      			<th>기능</th>
      		</tr>
      	</thead>
      	<tbody>
      		<c:choose>
      			<c:when test="${fn:length(manageList) > 0}">
      				<c:forEach items="${manageList}" var="i" varStatus="status">
       				<tr>
       					<td>${status.count}</td>
       					<td>${i.organization_name}</td>
			         	<td>${i.worker}</td>
			         	<td>${i.phone}</td>
			         	<td><a class="btn btn1 select-btn" keyValue1="${i.organization_name}" keyValue2="${i.worker}" keyValue3="${i.phone}" keyValue4="${i.organization_work_idx}">선택</a></td>
			        </tr>
      				</c:forEach>
      			</c:when>
      			<c:otherwise>
      				<tr>
		         	<td colspan="6">조회된 정보가 없습니다.</td>
		        </tr>
      			</c:otherwise>
      		</c:choose>
	</tbody>
</table>
