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
					if ( doAjaxPost($('#moduleMngtForm')) ) {
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
<form:form id="moduleMngtForm" modelAttribute="moduleMngt" method="post" action="save.do" >
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
						<form:option value="SITE" label="SITE" />
						<form:option value="CMS" label="CMS" />
					</form:select>
	         	</td>
	        </tr>
	        <tr>
	         	<th>모듈명</th>
	         	<td><form:input path="module_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>모듈설명</th>
	         	<td><form:textarea path="remark" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
	        <tr>
	         	<th>링크URL</th>
	         	<td><form:input path="link_url" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>링크파라미터</th>
	         	<td><form:input path="link_param" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>약관선택</th>
	         	<td>
	         		<form:select path="terms_group_id" class="selectmenu" style="width:100%;">
	         			<form:option value="" label="--없음--"></form:option>
	         			<form:options items="${termsCodeList}" itemValue="code_id" itemLabel="code_name"/>
	         		</form:select>
	         	</td>
	        </tr>
	        <tr>
	         	<th>모듈권한선택</th>
	         	<td>
	         		<form:select path="auth_group_id" class="selectmenu" style="width:150px;">
	         			<form:option value="" label="--없음--"></form:option>
	         			<form:options items="${authCodeList}" itemValue="auth_group_id" itemLabel="auth_group_name"/>
	         		</form:select>
	         	</td>
	        </tr>

		</tbody>
	</table>
</form:form>
