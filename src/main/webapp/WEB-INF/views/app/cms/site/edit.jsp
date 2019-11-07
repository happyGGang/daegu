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
					if ( doAjaxPost($('#siteForm')) ) {
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
		width: 400,
		height: 500
	});
	
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="siteForm" modelAttribute="site" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="site_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>사이트명</th>
	         	<td><form:input path="site_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>사이트설명</th>
	         	<td><form:textarea path="site_desc" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
	        <tr>
	         	<th>링크</th>
	         	<td><form:input path="link_target" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
				<th>출력 순서</th>
				<td>
					<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
