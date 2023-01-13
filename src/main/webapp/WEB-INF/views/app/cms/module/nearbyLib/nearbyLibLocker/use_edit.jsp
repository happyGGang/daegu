<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if ( doAjaxPost($('#lockerEachEdit')) ) {
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
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 310
	});
	
	
	$('#return_machine_yn').change(function(e){
		var val = $(this).val();
		if(val == 'Y'){
			$('#add_low').hide();
		}
		if(val== 'N'){
			$('#add_low').show();	
		}
	});
});

</script>
<!-- 내집앞도서관 운영장비 등록 form -->
<form:form id="lockerEachEdit" modelAttribute="nearbyLibLocker" method="post" action="/cms/module/nearbyLibLocker/locker_each_edit.do" >	
	<form:hidden path="device_idx"/>
	<form:hidden path="locker_idx"/>
	<form:hidden path="use_yn"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>장비명</th>
	         	<td>${device.device_name }</td>
	        </tr>
			<tr>
	         	<th>사물함번호</th>
	         	<td>${nearbyLibLocker.locker_each_idx }</td>
	        </tr>	        
	        <tr>
	         	<th>사용중지 사유</th>
         		<td>
	         		<form:textarea path="unused_reason" class="text" cssStyle="width:100%; height:80px; resize:none;"/>
	         	</td>	         		
	        </tr>	        
		</tbody>
	</table>
</form:form>
