<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('#editMode').val() == 'ADD') {
			if($('#agreeChk').prop('checked') == false) {
				alert('신청 동의에 체크해주시기 바랍니다.');
				$('#agreeChk').focus();
				return false;
			}
			
			if($('#agreeChk2').prop('checked') == false) {
				alert('개인정보 동의에 체크해주시기 바랍니다.');
				$('#agreeChk2').focus();
				return false;
			}
		}
		
		doAjaxPost($('#pictureBookLoan'));
	});
	
	$('#cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
	
	var sysDate = new Date();
	var sysYear = sysDate.getFullYear();
	var sysMonth = sysDate.getMonth() + 1;
	var currYear = '${pictureBook.loan_year}';
	var currMonth = '${pictureBook.loan_month}';
	
	for(var i = 2016; i <= sysYear+1; i++) {
		var selected = '';
		selected = i == currYear ? 'selected="selected"' : '';
		$('#loan_year_edit').append('<option value="'+i+'" '+selected+'>'+i+'</option>');
	}
	
	for(var j = 1; j <= 12; j++) {
		var selected = '';
		selected = j == currMonth ? 'selected="selected"' : '';
		$('#loan_month_edit').append('<option value="'+j+'" '+selected+'>'+j+'</option>');
	}
	
});

</script>
<style>
input[type="checkbox"]:focus {outline: 1px solid red;}
.title-info h3 {display: inline-block;font-weight: bold;color: #e94949;padding: 10px 65px;background: url(/resources/common/img/icon0105.gif) no-repeat 0px;background-size: 50px;}
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
<form:form id="pictureBookLoan" modelAttribute="pictureBook" action="loanSave.do" method="POST">
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="pay_yn"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="picture_book_idx"/>
	<form:hidden path="picture_book_loan_idx"/>
	<form:hidden path="search_type"/>
	<form:hidden path="search_text"/>
	<table class="type2">
		<colgroup>
			<col width="130" />
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th>책 꾸러미명</th>
				<td>${pictureBook.picture_book_subject}</td>
			</tr>
			<tr>
				<th>대출기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="loan_year" id="loan_year_edit" cssClass="selectmenu"></form:select>
					<form:select path="loan_month" id="loan_month_edit" cssClass="selectmenu"></form:select>
					<div class="ui-state-highlight">
						<i class="fa fa-question-circle"></i>
						<em>원화꾸러미는 매달 26일(주말 공휴일인경우, 그 전날) 자동 반송 요청됩니다. 미리 반납 준비를 해주시기 바랍니다.</em>
					</div>
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
					<form:select path="phone_1" cssClass="selectmenu">
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
				<th>신청사유</th>
				<td>
					<form:textarea path="request_content" cols="60" rows="5" cssStyle="width:95%;"/>
				</td>
			</tr>
			<tr>
				<th>진행상태</th>
				<td>
					<form:select path="request_status" cssClass="selectmenu">
						<form:option value="1">신청완료</form:option>
						<form:option value="2">대출중</form:option>
						<form:option value="3">반납신청</form:option>
						<form:option value="4">반납요청완료</form:option>
						<form:option value="5">반납완료</form:option>
						<form:option value="6">대출불가</form:option>
					</form:select>
				</td>
			</tr>
		</tbody>
	</table>
	<c:if test="${pictureBook.editMode eq 'ADD'}">
	<div>
		<div>
			<span style="display: block;font-size: 13px;color: #3366bb;">
				그림책 원화는 매달 26일 자동 반납 요청되어 27일 배송했던 장소로 택배 기사님이 방문합니다.<br>
				기사님이 바로 수거하실 수 있도록 준비해 주시길 바랍니다.<br/>
				※ 26일이 공휴일일 경우 그 전날, 주말일 경우 앞의 금요일에 자동 반납 요청됨
			</span>
			<input type="checkbox" id="agreeChk">
			<label for="agreeChk" style="font-size: 13px;">위 내용을 확인하고 신청합니다.</label>
		</div>
		<br>
		<div>
			<h4>개인정보 수집 및 이용 안내</h4>
			<ul>
				<li style="list-style-type: disc;font-size: 13px;margin-left: 15px;">기재해주신 개인정보(학교명,이름, 연락처 등)는 도서관 서비스 제공을 위한 목적으로만 사용합니다.</li>
			</ul>
			<input type="checkbox" id="agreeChk2">
			<label for="agreeChk2" style="font-size: 12px;">도서관 서비스를 제공 받기 위해 상기 개인정보(학교명, 이름, 연락처 등)제공 및 이용에 동의합니다.</label>
		</div>
	</div>
	</c:if>
</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">목록</button>
</div>
