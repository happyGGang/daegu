<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					if(doAjaxPost($('#quizForm'))) {
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

	$('input#quiz_start_date').datepicker({
		maxDate: $('input#quiz_end_date').val(),
		onClose: function(selectedDate){
			$('input#quiz_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#quiz_end_date').datepicker({
		minDate: $('input#quiz_start_date').val(),
		onClose: function(selectedDate){
			$('input#quiz_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('a#getLas').on('click', function(e) {
		e.preventDefault();
		var lasList = window.open('/${homepage.context_path}/intro/search/indexForBoard.do', 'lasLnkBook', 'width=800 height=600,scrollbars=yes');
	});

});

function getLasData(arg) {
	arg = arg.split('///');
	<%--${i.TITLE_INFO}//${i.PUB_YEAR}///${i.AUTHOR}///${i.PUBLISHER}///${fn:escapeXml(i.ST_CODE)}///${i.CALL_NO}///${imageUrl}--%>
	$('input#book_name').val(arg[0]);
	$('input#book_author').val(arg[2]);
	$('input#book_publisher').val(arg[3]);
	$('input#call_no').val(arg[5]);
	$('input#book_image').val(arg[6]);
	return false;
}

</script>
<form:form id="quizForm" modelAttribute="quiz" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="quiz_idx"/>
	<form:hidden path="editMode"/>

	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>상단 HTML</th>
	         	<td><form:textarea path="top_html" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
       		<tr>
	         	<th>퀴즈구분</th>
	         	<td>
	         		<form:select path="quiz_type" class="text selectmenu">
	         			<form:options items="${quizTypeList}" itemLabel="code_name" itemValue="code_id"/>
	         		</form:select>
         		</td>
	        </tr>
	        <tr>
	         	<th>퀴즈연도</th>
	         	<td><form:input path="quiz_year" class="text" cssStyle="width:50px;"/> 년 <form:input path="quiz_month" class="text" cssStyle="width:50px;"/> 월</td>
	        </tr>
	        <tr>
	         	<th>퀴즈참여기간</th>
	         	<td><form:input path="quiz_start_date" cssClass="text ui-calendar"/> ~ <form:input path="quiz_end_date" cssClass="text ui-calendar"/></td>
	        </tr>
	        <tr>
	         	<th>퀴즈제목</th>
	         	<td><form:input path="quiz_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	        	<th>학교 입력여부</th>
	        	<td>
	        		<form:radiobutton path="school_yn" value="N" label="아니오"/>
					<form:radiobutton path="school_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	         <tr>
	        	<th>학년 입력여부</th>
	        	<td>
	        		<form:radiobutton path="hak_yn" value="N" label="아니오"/>
					<form:radiobutton path="hak_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	         <tr>
	        	<th>반 입력여부</th>
	        	<td>
	        		<form:radiobutton path="ban_yn" value="N" label="아니오"/>
					<form:radiobutton path="ban_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>성별 선택여부</th>
	        	<td>
	        		<form:radiobutton path="gender_yn" value="N" label="아니오"/>
	        		<form:radiobutton path="gender_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>연령대 선택여부</th>
	        	<td>
	        		<form:radiobutton path="age_yn"  value="N" label="아니오"/>
	        		<form:radiobutton path="age_yn"  value="Y" label="예"/>
	        	</td>
	        </tr>
	        <tr>
				<th>도서검색</th>
				<td>
					<a href="#" class="btn btn2" id="getLas"><i class="fa fa-plus"></i><span>도서검색</span></a>&nbsp;&nbsp;<span id="img_file"></span>
					<br/>
					* 도서명, 도서 이미지, 저자, 출판사, 청구기호는 자동으로 입력 됩니다.
				</td>
	        </tr>
	        <tr>
	         	<th>도서명</th>
	         	<td>
	         		<form:input path="book_name" class="text" cssStyle="width:100%"/>
	         		<br/>
	         		* 도서정보 노출을 원치 않으시면 '도서명' 항목을 입력하지 않고 등록하시기 바랍니다.
	         	</td>
	        </tr>
	         <tr>
	         	<th>도서 이미지</th>
	         	<td><form:input path="book_image" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>저자</th>
	         	<td><form:input path="book_author" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>출판사</th>
	         	<td><form:input path="book_publisher" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>청구기호</th>
	         	<td><form:input path="call_no" class="text"/></td>
	        </tr>
	        <tr>
	         	<th>줄거리</th>
	         	<td><form:textarea path="book_desc" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
	        <tr>
	         	<th>하단 HTML</th>
	         	<td><form:textarea path="bottom_html" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
		</tbody>
	</table>
</form:form>
