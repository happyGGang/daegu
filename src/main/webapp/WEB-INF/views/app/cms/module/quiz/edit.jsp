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
	
	$('a#getIlus').on('click', function(e) {
		e.preventDefault();
		var ilusList = window.open('/${homepage.context_path}/intro/search/indexForBoard.do', 'ilusLnkBook', 'width=800 height=600,scrollbars=yes');
	});
	
});

function getIlusData(arg) {
	arg = arg.split('///');
	//${i.TITLE}//${i.PUBLER_YEAR}//${i.AUTHOR}//${i.PUBLER}//${i.ISBN}//${i.CALL_NO}//${i.i.COVER_SMALLURL}//${i.CTRLNO}//${i.PLACE_NAME}
	$('input#book_name').val(arg[0]);
	$('input#book_author').val(arg[2]);
	$('input#book_publisher').val(arg[3]);
	$('input#call_no').val(arg[5]);
	$('input#real_file_name').val(arg[6]);
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
	         	<th>퀴즈기간</th>
	         	<td><form:input path="quiz_start_date" cssClass="text ui-calendar"/> ~ <form:input path="quiz_end_date" cssClass="text ui-calendar"/></td>
	        </tr>
	        <tr>
	         	<th>퀴즈제목</th>
	         	<td><form:input path="quiz_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	        	<th>학교입력여부</th>
	        	<td>
	        		<form:radiobutton path="school_yn" value="N" label="아니오"/>
					<form:radiobutton path="school_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	         <tr>
	        	<th>학년입력여부</th>
	        	<td>
	        		<form:radiobutton path="hak_yn" value="N" label="아니오"/>
					<form:radiobutton path="hak_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	         <tr>
	        	<th>반입력여부</th>
	        	<td>
	        		<form:radiobutton path="ban_yn" value="N" label="아니오"/>
					<form:radiobutton path="ban_yn" value="Y" label="예"/>
	        	</td>
	        </tr>
	        <tr>
				<th>도서검색</th>
				<td>
					<a href="#" class="btn btn2" id="getIlus"><i class="fa fa-plus"></i><span>도서검색</span></a>&nbsp;&nbsp;<span id="img_file"></span>
					<br/>
					* 책이름, 저자, 출판사, 청구기호, 도서 이미지는 자동으로 등록 됩니다.
				</td>
	        </tr>
	        <tr>
	         	<th>책이름</th>
	         	<td><form:input path="book_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	         <tr>
	         	<th>책 이미지</th>
	         	<td><form:input path="real_file_name" class="text" cssStyle="width:100%"/></td>
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
	         	<th>책 설명</th>
	         	<td><form:textarea path="book_desc" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
	        <tr>
	         	<th>하단 HTML</th>
	         	<td><form:textarea path="bottom_html" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
		</tbody>
	</table>
</form:form>
