<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#archiveBookForm'))) {
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
		height: 700
	});

});

</script>
<form:form id="archiveBookForm" modelAttribute="archive" method="POST" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="book_idx"/>
	<form:hidden path="editMode"/>

	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>사용여부</th>
				<td>
					<form:radiobutton path="use_yn" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
				</td>
	        </tr>
       		<tr>
	         	<th>서명</th>
	         	<td><form:input path="subject" class="text" cssStyle="width:100%;"/></td>
	        </tr>
       		<tr>
	         	<th>저자</th>
	         	<td><form:input path="author" class="text" cssStyle="width:80%;"/></td>
	        </tr>
       		<tr>
	         	<th>출판사</th>
	         	<td><form:input path="publisher" class="text" cssStyle="width:80%;"/></td>
	        </tr>
       		<tr>
	         	<th>발행년도</th>
	         	<td><form:input path="year" class="text" cssStyle="width:80%;"/></td>
	        </tr>
       		<tr>
	         	<th>청구기호</th>
	         	<td><form:input path="callnumber" class="text" cssStyle="width:80%;"/></td>
	        </tr>
       		<tr>
	         	<th>등록번호</th>
	         	<td><form:input path="regnumber" class="text" cssStyle="width:80%;"/></td>
	        </tr>
       		<tr>
	         	<th>검색키워드</th>
	         	<td><form:input path="keyword" class="text" cssStyle="width:80%;"/></td>
	        </tr>
	        <tr>
	         	<th>원본 이미지 사이즈</th>
	         	<td>가로: <form:input path="orig_width" class="text" cssStyle="width:50px;"/> px &nbsp;&nbsp;&nbsp;세로: <form:input path="orig_height" class="text" cssStyle="width:50px;"/> px<br><em>* 이미지 한장 사이즈입니다.</em></td>
	        </tr>
	        <tr>
	         	<th>축소 이미지 사이즈</th>
	         	<td>가로: <form:input path="resize_width" class="text" cssStyle="width:50px;"/> px &nbsp;&nbsp;&nbsp;세로: <form:input path="resize_height" class="text" cssStyle="width:50px;"/> px<br><em>* 이미지 한장 사이즈입니다.</em></td>
	        </tr>
		</tbody>
	</table>
</form:form>
