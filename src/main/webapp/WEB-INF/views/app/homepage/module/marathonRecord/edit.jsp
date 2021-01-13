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
	$('input#book_get_date').datepicker({
		
	});
	
	<c:if test="${marathonRecord.book_get_date eq '' || marathonRecord.book_get_date eq null}">
		$('input#book_get_date').val(new Date().toISOString().substring(0, 10));
	</c:if>
	<c:if test="${marathonRecord.book_resources != '100' && marathonRecord.book_resources != '200' && marathonRecord.book_resources != '300'
		&& marathonRecord.book_resources != '400' && marathonRecord.book_resources != '500' && marathonRecord.book_resources != '600'
		&& marathonRecord.book_resources != '700' && marathonRecord.book_resources != '800' && marathonRecord.book_resources != '900'
		&& marathonRecord.book_resources != '' && marathonRecord.book_resources ne null}">
		$('select#book_resources option[value="write"]').prop('selected', 'true');
		$('input#book_resources_1').css('display', '');
		$('input#book_resources_1').val('${marathonRecord.book_resources}');
	</c:if>

	$('a#record_index_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#marathonRecord')));
	});
	
	$('a#record_save_btn').on('click', function(e) {
		e.preventDefault();
		if($('input#book_name').val() == ''){
			alert('도서명을 입력해 주세요.');
			$('input#book_name').focus();
			return false;
		}
		if($('input#read_page_count').val() == ''){
			alert('읽은 쪽수를 입력해 주세요.');
			$('input#read_page_count').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#read_page_count').val())){
			alert('읽은 쪽수에는 숫자만 입력해 주세요.');
			$('input#read_page_count').focus();
			return false;
		}
		if($('select#book_resources').val() == 'write' && $('input#book_resources_1').val() != ''){
			$('select#book_resources').append('<option value=' + $('input#book_resources_1').val() + ' selected="selected"></option>');
			$('select#book_resources option[value = "write"]').remove();
			if($('input#book_get_date').val() == ''){
				alert('대출/구입 날짜를 입력해 주세요.');
				$('input#book_get_date').focus();
				$('select#book_resources option[value=' + $('input#book_resources_1').val() +']').remove();
				$('select#book_resources').append('<option value="write" selected="selected">기타 도서관</option>');
				return false;
			}
			if($('input#book_type').val() == ''){
				alert('분류번호를 입력해 주세요.');
				$('input#book_type').focus();
				$('select#book_resources option[value=' + $('input#book_resources_1').val() +']').remove();
				$('select#book_resources').append('<option value="write" selected="selected">기타 도서관</option>');
				return false;
			}
			if($('input#book_author').val() == ''){
				alert('저자를 입력해 주세요.');
				$('input#book_author').focus();
				$('select#book_resources option[value=' + $('input#book_resources_1').val() +']').remove();
				$('select#book_resources').append('<option value="write" selected="selected">기타 도서관</option>');
				return false;
			}
			if($('input#publisher').val() == ''){
				alert('출판사를 입력해 주세요.');
				$('input#publisher').focus();
				$('select#book_resources option[value=' + $('input#book_resources_1').val() +']').remove();
				$('select#book_resources').append('<option value="write" selected="selected">기타 도서관</option>');
				return false;
			}
			if($('textarea#book_journals').val() == ''){
				alert('독서감상문을 입력해 주세요.');
				$('textarea#book_journals').focus();
				$('select#book_resources option[value=' + $('input#book_resources_1').val() +']').remove();
				$('select#book_resources').append('<option value="write" selected="selected">기타 도서관</option>');
				return false;
			}
			if($('textarea#book_journals').val().length < 51){
				alert('독서감상문은 띄어쓰기 빈칸을 포함하여 50자 이상 기록하여야 합니다.');
				$('textarea#book_journals').focus();
				$('select#book_resources option[value=' + $('input#book_resources_1').val() +']').remove();
				$('select#book_resources').append('<option value="write" selected="selected">기타 도서관</option>');
				return false;
			}
		}
		if($('select#book_resources').val() == ''){
			alert('대출/구입처를 선택해 주세요.');
			$('select#book_resources').focus();
			return false;
		}
		if($('select#book_resources').val() == 'write' && $('input#book_resources_1').val() == ''){
			alert('대출/구입처를 입력해 주세요.');
			$('input#book_resources_1').focus();
			return false;
		}
		if($('input#book_get_date').val() == ''){
			alert('대출/구입 날짜를 입력해 주세요.');
			$('input#book_get_date').focus();
			return false;
		}
		if($('input#book_type').val() == ''){
			alert('분류번호를 입력해 주세요.');
			$('input#book_type').focus();
			return false;
		}
		if($('input#book_author').val() == ''){
			alert('저자를 입력해 주세요.');
			$('input#book_author').focus();
			return false;
		}
		if($('input#publisher').val() == ''){
			alert('출판사를 입력해 주세요.');
			$('input#publisher').focus();
			return false;
		}
		if($('textarea#book_journals').val() == ''){
			alert('독서감상문을 입력해 주세요.');
			$('textarea#book_journals').focus();
			return false;
		}
		if($('textarea#book_journals').val().length < 51){
			alert('독서감상문은 띄어쓰기 빈칸을 포함하여 50자 이상 기록하여야 합니다.');
			$('textarea#book_journals').focus();
			return false;
		}
		
		doAjaxPost($('form#marathonRecord'));
	});
	
	$('textarea#book_journals').keyup(function() {
		bytesHandler();
	});
	
	function bytesHandler(){
		var text = $('textarea#book_journals').val();
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
		var text = $('textarea#book_journals').val();
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
		e.preventDefault();
		if($(this).val() != '100' && $(this).val() != '200' && $(this).val() != '300' && $(this).val() != '400'
				&& $(this).val() != '500' && $(this).val() != '600' && $(this).val() != '700' && $(this).val() != '800'
				&& $(this).val() != '900' && $(this).val() != '' && $(this).val() != null) {
			$('input#book_resources_1').css('display', '');
		}else{
			$('input#book_resources_1').css('display', 'none');
			$('input#book_resources_1').val('');
		}
	});
	
	doAjaxLoad('div#searchBox', 'search.do');
});
</script>
<div id="searchBox">

</div>
<form:form modelAttribute="marathonRecord" action="save.do" method="POST">
	<form:hidden path="homepage_id"/>
	<form:hidden path="contest_idx"/>
	<form:hidden path="contest_type_idx"/>
	<form:hidden path="applicant_idx"/>
	<form:hidden path="record_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<table class="type2 nohead">
		<colgroup>
			<col width="200" class="col1">
			<col width="*" class="col2">
		</colgroup>
		<tbody>
			<tr>
				<td colspan="2" class="last td1" style="text-align:center;">일지작성</th>
			</tr>
			<tr>
				<th>참가종목</th>
				<td>${marathonApplicant.contest_type} (<fmt:formatNumber value="${marathonApplicant.page_count}" pattern="#,###"/>쪽) / 누적 : <b><fmt:formatNumber value="${page_count_total}" pattern="#,###"/></b>쪽</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${marathonApplicant.member_name}</td>
			</tr>
			<tr>
				<th>일지 작성일</th>
				<td><fmt:formatDate value="${marathonRecord.record_date}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
			<tr>
				<th>*도서명</th>
				<td>
					<form:input path="book_name" cssClass="text" cssStyle="width:90%"/><br/>
					<span class="text2">*상단의 검색을 통해 도서명, 저자, 출판사를 자동으로 입력할 수 있습니다.</span>
				</td>
			</tr>
			<tr>
				<th>*읽은 쪽수</th>
				<td><form:input path="read_page_count" cssClass="text"/></td>
				<form:hidden path="read_page_count_beforeChange" value="${marathonRecord.read_page_count}"/>
			</tr>
			<tr>
				<th>*대출/구입 날짜</th>
				<td>
					<form:select path="book_resources" cssClass="selectmenu">
						<form:option value="">--도서관 선택--</form:option>
						<form:option value="100">공공도서관(달서가족문화도서관)</form:option>
						<form:option value="200">공공도서관(달서구립도원도서관)</form:option>
						<form:option value="300">공공도서관(달서어린이도서관)</form:option>
						<form:option value="400">공공도서관(달서영어도서관)</form:option>
						<form:option value="500">공공도서관(도원도서관)</form:option>
						<form:option value="600">공공도서관(본리도서관)</form:option>
						<form:option value="700">공공도서관(성서도서관)</form:option>
						<form:option value="800">구입도서</form:option>
						<form:option value="900">소장도서</form:option>
						<form:option value="write">기타 도서관</form:option>
					</form:select>
					<input type="text" class="text" id="book_resources_1" style="display:none;">
					<form:input path="book_get_date" cssClass="text" size="10" maxlength="10"/>
				</td>
			</tr>
			<tr>
				<th>*분류번호</th>
				<td>
					<form:select path="book_type" cssClass="selectmenu">
						<form:option value="000">000(총류)</form:option>
						<form:option value="100">100(철학)</form:option>
						<form:option value="200">200(종교)</form:option>
						<form:option value="300">300(사회과학)</form:option>
						<form:option value="400">400(순수과학)</form:option>
						<form:option value="500">500(기술과학)</form:option>
						<form:option value="600">600(예술)</form:option>
						<form:option value="700">700(언어)</form:option>
						<form:option value="800">800(문학)</form:option>
						<form:option value="900">900(역사)</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>*저자</th>
				<td><form:input path="book_author" cssClass="text" cssStyle="width:90%;"/></td>
			</tr>
			<tr>
				<th>*출판사</th>
				<td><form:input path="publisher" cssClass="text" cssStyle="width:90%;"/></td>
			</tr>
			<tr>
				<th>*독서감상문</th>
				<td>
					<div style="padding-left:1%"><span id="textLength">0</span>/50자 &nbsp;&nbsp;&nbsp; 로그인 유지 시간 : <span id="demo"></span></div>
					<form:textarea path="book_journals" rows="10" cols="100" cssStyle="padding:10px 10px;"></form:textarea><br/>
					<div style="font-size:13px;">
						* 독서감상문은 띄어쓰기 빈칸을 포함하여 50자 이상 기록하여야 합니다.<br/>
						* 20분간 사용이 없으면 자동으로 로그아웃되므로 작성이 길어질 경우 미리 작성하신 내용을 복사해서 등록하시기 바랍니다.
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn center" style="margin-top:15px;">
		<a href="#" class="btn btn2" id="record_save_btn"><i class="fa fa-pencil"></i><span>저장하기</span></a>
		<a href="#" class="btn btn1" id="record_index_btn"><i class="fa fa-reorder"></i><span>목록으로</span></a>
	</div>

</form:form>