<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script>
var oEditors = [];
$(function() {

	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-2').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 780,
		height: 550
	});

});
</script>
<form:form modelAttribute="terms" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="terms_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>약관구분</th>
			<td>
				${terms.terms_type_name }
			</td>
		</tr>

		<tr>
			<th>제목</th>
			<td>
				${terms.title }
			</td>
		</tr>

		<tr class="detailContent">
			<th>상세내용</th>
			<td>
				${terms.contents }
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				${terms.use_yn }
			</td>
		</tr>
	</tbody>
</table>
</form:form>