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
				text: "예약취소",
				"class": 'btn btn1',
				click: function() {
					if ( doAjaxPost($('#neighborhoodLibraryDelete')) ) {
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
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 410
	});
	
});

</script>
<!-- 내집앞도서관 운영장비 등록 form -->
<form:form id="neighborhoodLibraryDelete" modelAttribute="neighborhoodLibrary" method="post" action="save.do" >
	<form:hidden path="device_idx"/>
	<form:hidden path="reserve_status"/>
	<form:hidden path="reserve_idx"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>예약번호</th>
	         	<td>${neighborhoodLibrary.reserve_idx }</td>
	        </tr>
	        <tr>
	         	<th>취소사유</th>
	         	<td><form:textarea path="cancel_reason" class="text" style="resize:none; width:100%; height:200px;" /></td>
	        </tr>
	        
		</tbody>
	</table>
</form:form>
