<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		
		if($('#loan_start_date').val() == '') {
			alert('대출시작기간을 선택하세요.');
			$('#loan_start_date').focus();
			return false;
		}
		if($('#loan_end_date').val() == '') {
			alert('대출종료기간을 선택하세요.');
			$('#loan_end_date').focus();
			return false;
		}
		if($('#request_name').val() == '') {
			alert('신청자를 입력하세요.');
			$('#request_name').focus();
			return false;
		}
		if($('#phone_2').val() == '') {
			alert('휴대폰을 입력하세요.');
			$('#phone_2').focus();
			return false;
		}
		if($('#phone_3').val() == '') {
			alert('휴대폰을 입력하세요.');
			$('#phone_3').focus();
			return false;
		}
		if($('#school_tel_2').val() == '') {
			alert('학교 연락처를 입력하세요.');
			$('#school_tel_2').focus();
			return false;
		}
		if($('#school_tel_3').val() == '') {
			alert('학교 연락처를 입력하세요.');
			$('#school_tel_3').focus();
			return false;
		}
		if($('#request_content').val() == '') {
			alert('신청사유를 입력하세요.');
			$('#request_content').focus();
			return false;
		}
		
		if($('#agree').prop('checked') == false && $('#editMode').val() == 'ADD') {
			alert('개인정보 수집 및 이용에 동의를 하셔야 합니다.');
			$('#agree').focus();
			return false;
		}
		
		doAjaxPost($('#bookPackageLoan'));
	});
	
	$('#cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
	
	var currDate = new Date();
	currDate.setDate(currDate.getDate() + 3);
	var str_min_date = currDate.getFullYear()+'-'+(currDate.getMonth()+1)+'-'+currDate.getDate();
	currDate.setDate(currDate.getDate() + 14);
	var str_max_date = currDate.getFullYear()+'-'+(currDate.getMonth()+1)+'-'+currDate.getDate();
	
	$('input#loan_start_date').datepicker({
		minDate: str_min_date,
		maxDate: str_max_date,
		onClose: function(selectedDate){
			$('input#loan_end_date').datepicker('option', 'minDate', selectedDate);
			
			var week2 = new Date(selectedDate);
			week2.setDate(week2.getDate() + 60);
			var end_max_date = week2.getFullYear()+'-'+(week2.getMonth()+1)+'-'+week2.getDate();
			$('input#loan_end_date').datepicker('option', 'maxDate', end_max_date);
		}
	});

	var week2 = new Date(str_min_date);
	week2.setDate(week2.getDate() + 60);
	var end_max_date = week2.getFullYear()+'-'+(week2.getMonth()+1)+'-'+week2.getDate();
	
	$('input#loan_end_date').datepicker({
		minDate: $('input#loan_start_date').val(),
		maxDate: end_max_date
	});
	
	$('#school_name').focus();
	
});

</script>
<style>
input[type="checkbox"]:focus {outline: 1px solid red;}
.title-info {position: relative;border: 2px solid #d2dfe8;padding: 28px;margin-bottom: 30px;}
.title-info h3 {display: inline-block;font-weight: bold;color: #e94949;padding: 10px 120px;background: url(/resources/common/img/icon0105.gif) no-repeat;min-height: 100px;}
.title-info ul {position: absolute;top: 80px; left: 145px;}
.title-info ul li {font-size: 14px;color: #222;margin-left: 20px;margin-bottom: 6px;list-style-type: disc;}
</style>
<div class="title-info">
	<h3>꼭 읽어주세요!</h3>
	<ul>
		<li>대출 기간은 배송 기간 포함입니다.</li>
		<li>다음 학교가 희망하는 일자부터 사용할 수 있도록 대출 기간을 반드시 지켜주십시오.</li>
		<li>원화는 액자에 부착되어 있습니다. 원화 전시 중 학생들의 안전에 더욱 신경 써주십시오.</li>
	</ul>
</div>
<form:form id="bookPackageLoan" modelAttribute="bookPackage" action="loanSave.do" method="POST">
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="rowCount"/>
	<form:hidden path="book_package_idx"/>
	<form:hidden path="book_package_loan_idx"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>책 꾸러미명</th>
				<td>${bookPackage.book_package_subject}</td>
			</tr>
			<tr>
				<th>대출기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="loan_start_date" cssClass="text ui-calendar"/>
					<span>~</span>
					<form:input path="loan_end_date" cssClass="text ui-calendar"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>대출 기간은 택배 배송 소요일을 포합합니다. 반납일 3일전 반납 신청해주시길 바랍니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>학교명</th>
				<td>
					<form:input path="school_name" cssClass="text" cssStyle="width:200px;"/>
				</td>
			</tr>
			<tr>
				<th>신청자(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="request_name" cssClass="text" cssStyle="width:100px;"/>
				</td>
			</tr>
			<tr>
				<th>휴대폰(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="phone_1" cssStyle="selectmenu">
						<form:option value="010">010</form:option>
						<form:option value="011">012</form:option>
						<form:option value="016">016</form:option>
						<form:option value="017">017</form:option>
						<form:option value="018">018</form:option>
						<form:option value="019">019</form:option>
					</form:select>
					<span>-</span>
					<form:input path="phone_2" cssClass="text" cssStyle="width:50px;"/>
					<span>-</span>
					<form:input path="phone_3" cssClass="text" cssStyle="width:50px;"/>
				</td>
			</tr>
			<tr>
				<th>학교 연락처(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="school_tel_1" cssClass="selectmenu">
						<form:option value="053">053</form:option>
					</form:select>
					<span>-</span>
					<form:input path="school_tel_2" cssClass="text" cssStyle="width:50px;"/>
					<span>-</span>
					<form:input path="school_tel_3" cssClass="text" cssStyle="width:50px;"/>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>연락처는 원화택배 발송을 위한 필수 정보입니다. 꼭 기입하여 주세요.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>신청사유(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:textarea path="request_content" cols="60" rows="5" cssStyle="width:95%;"/>
				</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
				<c:choose>
					<c:when test="${loginSupport.auth_group eq '3'}">
					<form:hidden path="request_status" value="0"/>신청중
					</c:when>
					<c:otherwise>
					<form:select path="request_status" cssClass="selectmenu">
						<form:option value="0">신청중</form:option>
						<form:option value="1">예약상담중</form:option>
						<form:option value="2">대출중</form:option>
						<form:option value="3">반납완료</form:option>
						<form:option value="4">관리자취소</form:option>
						<form:option value="5">반납요청완료</form:option>
					</form:select>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<br/>
<c:if test="${bookPackage.editMode eq 'ADD'}">
<div>
	<h3>개인정보 수집 및 이용 안내</h3>
	<ul>
		<li>기재해주신 개인정보(학교명,이름, 연락처 등)는 도서관 서비스 제공을 위한 목적으로만 사용합니다.</li>
	</ul>
	<div class="agree_box">
		<input type="checkbox" id="agree"><label for="agree">도서관 서비스를 제공 받기 위해 상기 개인정보(학교명, 이름, 연락처 등) 제공 및 이용에 동의합니다.</label>
	</div>
</div>
</c:if>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
