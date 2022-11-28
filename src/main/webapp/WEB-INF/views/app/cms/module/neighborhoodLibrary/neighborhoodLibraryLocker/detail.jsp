<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	var return_machine = $('#return_machine_yn').val();
	if(return_machine == 'Y'){
		$('#add_low').hide();
	}
	if(return_machine == 'N'){
		$('#add_low').show();
	}
	
	/*
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
					if ( doAjaxPost($('#LockerAdd')) ) {
						location.reload();
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
	*/
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    }
	});
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 300,
		height: 350
	});
});

</script>
<!-- 내집앞도서관 운영장비 등록 form -->
<form:form modelAttribute="neighborhoodLibraryLocker" method="post">
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<c:choose>
       			<c:when test="${locker.device_idx > 0}">
       				<tr>
			         	<th>열갯수</th>
			         	<td><form:input path="col_no" value="${locker.col_no }" class="text" cssStyle="width:100%" disabled="true"/></td>
			        </tr>
					<tr>
			         	<th>행갯수</th>
			         	<td><form:input path="row_no" value="${locker.row_no }" class="text" cssStyle="width:100%" disabled="true"/></td>
			        </tr>	        
			        <tr>
			         	<th>반납기여부</th>
		         		<td>
			         		<form:input path="return_machine_yn" value="${locker.return_machine_yn }" class="text" cssStyle="width:100%" disabled="true"/>
			         	</td>	         		
			        </tr>
			        <tr>
			         	<th>모니터위치(열)</th>
			         	<td><form:input path="monitor_position" value="${locker.monitor_position }" class="text" cssStyle="width:100%" disabled="true"/></td>
			        </tr>
			        <tr id="add_low">
			         	<th>추가행</th>
			         	<td><form:input path="add_row_no" value="${locker.add_row_no }" class="text" cssStyle="width:100%" disabled="true"/></td>
			        </tr>
       			</c:when>
       			<c:otherwise>
       				<tr>
       					<td colspan="5" cssStyle="width:100%">등록된 사물함이 없습니다.</td>
       				</tr>
       			</c:otherwise>
       		</c:choose>
       		
	        
		</tbody>
	</table>
</form:form>
