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
		width: 600,
		height: 500
	});

});

</script>
<form:form id="siteForm" modelAttribute="recommendSite" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="recommend_site_idx"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>사이트명(<span style="color: red;font-weight: bold;">*</span>)</th>
	         	<td><form:input path="recommend_site_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>사이트설명</th>
	         	<td><form:textarea path="recommend_site_desc" class="text" cssStyle="width:100%; height:50px;"/></td>
	        </tr>
	        <tr>
	         	<th>링크(<span style="color: red;font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:input path="link_target" class="text" cssStyle="width:100%"/>
	         		<div class="ui-state-highlight">
						<em>
							* 클릭시 이동 할 URL 입니다.<br>
							* http:// 부터 전체 URL을 입력하세요.
						</em>
					</div>
	         	</td>
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
