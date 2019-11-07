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
					if (doAjaxPost($('form#moduleAuth'))) {
						
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
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 500,
		height: 600
	});
	
});

</script>
<form:form modelAttribute="moduleAuth" method="post" action="saveModuleAuth.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="module_idx" id="moduleAuthModuleIdx"/>			
	<form:hidden path="editMode" id="moduleAuthEditMode"/>
	<form:hidden path="remark"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>모듈명</th>
	         	<td>${moduleManage.module_name}</td>
	        </tr>
	        
	        <tr>
	         	<th>권한정보</th>
	         	<td>
	         		<table class="type2 center">
						<colgroup>
					       <col width="10%" />
					       <col width="30%"/>
					       <col width="*"/>
				       	</colgroup>
				       	<tbody>
					        <tr>
					         	<th><input type="checkbox"></th>
					         	<th>권한</th>
					         	<th>설명</th>
					        </tr>
					        <c:forEach items="${moduleAuthCodeList}" var="i" varStatus="status">
					        <tr>
					        	<td><form:checkbox id="_moduleAuthIdList${status.index}" path="moduleAuthIdList" value="${i.auth_id}"/></td>
					         	<td><label for="_moduleAuthIdList${status.index}">${i.auth_name}</label></td>
					         	<td>${i.remark }</td>
					        </tr>
					        </c:forEach>
						</tbody>
					</table>
	         	</td>
	        </tr>
		</tbody>
	</table>
</form:form>
