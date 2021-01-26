<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$(function() {

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        location.reload();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if (doAjaxPost($('form#facilityStudy_2'))) {
						location.reload();
					}
				}
			},{
				text: "닫기",
				"class": 'btn',
				click: function() {
					$('#dialog-2').dialog('destroy');
					location.reload();
				}
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 200
	});

});

</script>
<form:form id="facilityStudy_2" modelAttribute="facilityStudy" action="save.do" method="POST" onsubmit="return false;" >
<form:hidden path="editMode" id="editMode_2"/>
<form:hidden path="homepage_id" id="homepage_id_2"/>
<form:hidden path="study_idx" id="study_idx_2"/>
<table class="type2">
		<colgroup>
	       <col width="120" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>취소 사유</th>
	         	<td><form:input path="cancel_txt" cssClass="text" size="30"/></td>
	        </tr>
		</tbody>
	</table>
</form:form>