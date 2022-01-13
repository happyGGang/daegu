<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar"%>
<style>
	span.text2{font-style: normal;color: #888;font-size: 90%;margin: 0 5px;}
</style>
<script type="text/javascript">
$(function() {
	$('input#read_success_date').datepicker({
		
	});
	
	$('a#record_save_btn').on('click', function(e) {
		e.preventDefault();
		if($('input#read_success_date').val() == ''){
			alert('완독일을 입력해 주세요.');
			$('input#read_success_date').focus();
			return false;
		}
		if($('textarea#contents').val() == ''){
			alert('내용을 입력해 주세요.');
			$('textarea#contents').focus();
			return false;
		}
		if($('textarea#contents').val().length < 100){
			alert('내용은 띄어쓰기 빈칸을 포함하여 100자 이상 기록하여야 합니다.');
			$('textarea#contents').focus();
			return false;
		}
		
		$('input#book_type').val('LOAN');
		doAjaxPost($('form#readingNotes'));
	});
	
	$('a#record_index_btn').on('click', function(e) {
		e.preventDefault();
		var url = '/${homepage.context_path}/module/readingNotes/index.do';
		$('#viewPage').val(1);
		doGetLoad(url, 'menu_idx='+ $('input#menu_idx').val());
	});
	
	$('textarea#contents').keyup(function() {
		bytesHandler();
	});
	
	function bytesHandler(){
		var text = $('textarea#contents').val();
		$('span#textLength').text(getTextLength(text));
	}
	
	function getTextLength(str){
		var len = 0;
		for(var i = 0; i < str.length; i++){
			len++;
		}
		return len;
	}
	
	function checkTextLength(){
		var text = $('textarea#contents').val();
		$('span#textLength').text(getTextLength(text));
	}
	
	checkTextLength();
	
	<%
		int maxInactiveInterval = request.getSession().getMaxInactiveInterval();
	%>
	var time = <%=maxInactiveInterval%>;
	var min = "";
	var sec = "";
	
	var x = setInterval(function() {
		min = parseInt(time / 60);
		sec = time % 60;
		document.getElementById("demo").innerHTML = min + "분" + sec + "초";
		time--;
		
		if(time < 0) {
			clearInterval(x);
			document.getElementById("demo").innerHTML = "시간 초과. 재로그인 후 이용하시길 바랍니다.";
		}
	}, 1000);
	
	
	$('select#book_resources').on('change', function(e) {
		var onfocus = $('select#book_resources').attr('onfocus');
		
		if (onfocus == 'this.initialSelect = this.selectedIndex') {
			
		} else {
			if($(this).val() != '100' && $(this).val() != '200' && $(this).val() != '300' && $(this).val() != '400'
				&& $(this).val() != '500' && $(this).val() != '600' && $(this).val() != '700' && $(this).val() != '800'
				&& $(this).val() != '900' && $(this).val() != '' && $(this).val() != null) {
				$('input#book_resources_1').css('display', '');
			}else{
				$('input#book_resources_1').css('display', 'none');
				$('input#book_resources_1').val('');
			}
		}
	});
	
	/* doAjaxLoad('div#searchBox', 'search.do'); */
	doAjaxLoad('div#historyBox', 'loan/history.do');
});
</script>
<div id="historyBox">

</div>
<!-- <div id="searchBox">

</div> -->
<form:form modelAttribute="readingNotes" action="save.do" method="POST">
	<form:hidden path="homepage_id"/>
	<form:hidden path="reading_notes_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="book_name"/>
	<form:hidden path="publisher"/>
	<form:hidden path="author"/>
	<form:hidden path="isbn"/>
	<form:hidden path="book_type"/>
	<form:hidden path="cancel_reason"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="rsv-info"></div>
	<div class="auto-scroll">
	<table class="type2 nohead">
		<colgroup>
			<col width="20%" class="col1">
			<col width="*" class="col2">
		</colgroup>
		<tbody>
			<tr>
				<td colspan="2" class="last td1" style="text-align:center;">독서노트</th>
			</tr>
			<tr>
				<th>도서명</th>
				<td>${readingNotes.book_name}</td>
			</tr>
			<tr>
				<th>출판사</th>
				<td>${readingNotes.publisher}</td>
			</tr>
			<tr>
				<th>작가</th>
				<td>${readingNotes.author}</td>
			</tr>
			<tr>
				<th>ISBN</th>
				<td>${readingNotes.isbn}</td>
			</tr>
			<tr>
				<th>글자수</th>
				<td>100자 이상  (설정된 글자수 이상 적으셔야 등록이 가능합니다.)</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td>
					<fmt:formatDate value="${readingNotes.add_date}" pattern="yyyy-MM-dd" var="add_date"/>
					<span id="add_date">${add_date}</span>
				</td>
			</tr>
			<tr>
				<th>완독일</th>
				<td><form:input path="read_success_date" class="text ui-calendar" size="10" maxlength="10"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<div style="padding-left:1%"><span id="textLength">0</span>/100자 &nbsp;&nbsp;&nbsp; 로그인 유지 시간 : <span id="demo"></span></div>
					<form:textarea path="contents" rows="10" cols="100" cssStyle="padding:10px 10px;width:90%;"></form:textarea><br/>
					<div style="font-size:13px;">
						* 작성하신 독서기록일지는 나의도서관 메뉴에서 확인 가능합니다.<br/>
						* 복사하여 붙이기(Ctrl+V) 기능은 제한됩니다.<br/>
						* 욕설이나 의미 없는 내용 등 감상평으로 부적절한 내용을 포함하고 있는 경우 관리자에 의해 추후 반려 처리됩니다.
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	<div class="button bbs-btn center" style="margin-top:15px;">
		<a href="#" class="btn btn2" id="record_save_btn"><i class="fa fa-pencil"></i><span>저장하기</span></a>
		<a href="#" class="btn btn1" id="record_index_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
	</div>

</form:form>