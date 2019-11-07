<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('#dialog-4.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if ( doAjaxPost($('#teachSettingForm')) ) {
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
	
	$("#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 300
	});
});

</script>
<form:form id="teachSettingForm" modelAttribute="teachSetting" method="post" action="saveSetting.do">
	<form:hidden path="homepage_id"/>
	<table class="type2">
		<colgroup>
	       <col width="150" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>사용여부</th>			
	         	<td>
	         		<form:radiobutton path="use_yn" value="Y" label="사용함"/>
	         		<form:radiobutton path="use_yn" value="N" label="사용안함"/>
	         	</td>
        	</tr>
        	<tr>
	         	<th>기간</th>			
	         	<td>
	         		<form:select path="term_type" class="selectmenu">
	         			<form:option value="1" label="1년"></form:option>
	         			<form:option value="6" label="6개월"></form:option>
	         			<form:option value="3" label="3개월"></form:option>
	         		</form:select>
	         	</td>
        	</tr>
        	<tr>
	         	<th>횟수</th>			
	         	<td>
	         		<form:input path="term_count" class="text" style="width:50px"/>
	         	</td>
        	</tr>
		</tbody>
	</table>
	<div class="ui-state-highlight">
		* 해당 설정은 도서관의 모든 강좌에 대하여 1인당 강좌수 제한을 설정합니다.<br/>
		* 1년(1월~12월), 6개월(1월~6월, 7월~12월)<br/>
		* 3개월(1월~3월, 4월~6월, 7월~9월, 10월~12월)단위로 제한합니다.
	</div>
</form:form>