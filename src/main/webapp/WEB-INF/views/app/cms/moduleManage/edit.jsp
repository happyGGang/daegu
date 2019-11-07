<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					if ( doAjaxPost($('#moduleManageForm')) ) {
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
		height: 500
	});
	
	$('.ui-calendar').each(function() {
		$(this).datepicker({
			//기본달력
		});
	});
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="moduleManageForm" modelAttribute="moduleManage" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="module_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>구분</th>
	         	<td>
					<form:select path="module_type" class="selectmenu" style="width:100px;">
						<form:option value="CMS" label="CMS" />
						<form:option value="SITE" label="SITE" />
					</form:select> 
	         	</td>
	        </tr>
	        <tr>
	         	<th>모듈명</th>
	         	<td><form:input path="module_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>모듈설명</th>
	         	<td><form:textarea path="module_desc" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
	        <tr>
	         	<th>링크URL</th>
	         	<td><form:input path="link_url" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr style="display: none;">
	         	<th>사용여부</th>
	         	<td>
	         		<form:radiobutton path="use_yn" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
         		</td>
	        </tr>
		</tbody>
	</table>
</form:form>
