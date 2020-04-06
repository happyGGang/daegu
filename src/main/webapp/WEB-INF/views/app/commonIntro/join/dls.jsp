<%@ page language="java" pageEncoding="utf-8" %>

<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();

		var certCheck = true;

		if ($('input#certType').val() == '' ) {
			var certCheck = false;
		}

		if (!certCheck) {
			alert('본인 인증 후 가입 가능합니다.');
			return false;
		}

		if (!idCheck) {
			alert('아이디 중복확인 후 가능합니다.');
			$('#memberJoinForm #member_id').focus();
			return false;
		}

		if (!pwCheck2) {
			alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
			return false;
		}
		if (!pwCheck) {
			alert('비밀번호 확인 후 가능 합니다.');
			return false;
		}

		doAjaxPost($('#memberJoinForm'));
	});

	$('th.th1').css('width', '15%');
	$('th.th1').css('text-align', 'right');

});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<div class="join-wrap" style="padding: 0">

	<h4>개인정보 제3자 제공 내역</h4>
	<div class="Box" style="height:200px">
		<br>

		<table class="t_list tac" summary="개인정보 처리 및 위탁에 관한 안내표">
		<caption class="disnone">개인정보 처리 및 위탁에 관한 안내</caption>
		<colgroup>
			<col width="15%"/>
			<col width="30%"/>
			<col width=""/>
			<col width="15%"/>
		</colgroup>
		<thead>
		<tr>
		<td>제공받는 기관</td>
		<td>제공목적</td>
		<td>제공항목</td>
		<td>보유기간</td>
		</tr>
		</thead>
		<tbody>
		<tr>
		<td>국립중앙도서관 및 지역센터</td>
		<td>책이음서비스 이용</td>
		<td>도서회원번호,성명,출생년도,성별, 휴대폰번호,CI값,도서대출내역</td>
		<td>회원 탈퇴시까지</td>
		</tr>
		<tr>
		<td>책이음서비스
			 참여 도서관</td>
		<td>책이음서비스를 통한 회원가입</td>
		<td>아이디, 비밀번호, 도서회원번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, CI값, 도서대출내역 법정대리인 성명 및 연락처, 이메일, 전화번호(자택), 근무처(학교명), 근무지(학교)연락처, 근무지(학교)주소</td>
		<td>회원 탈퇴시까지</td>
		</tr>
		<tr>
		<td colspan="4">개인정보 제3자 제공에 거부할 권리가 있습니다. 다만 동의를 거부 할 경우 책이음서비스 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다.</td>
		</tr>
		</tbody>
		</table>

		<br>
	</div>

	<div class="agree_codes" style="margin-bottom: 20px;">
		<input id="agree_codes4" name="agree_codes" req="0001" type="checkbox" value="3"><label for="agree_codes4">개인정보 제3자 제공에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
	</div>


	<form:form id="memberJoinForm" modelAttribute="member" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>

		<div style="border-top:2px solid #ccc">
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<caption>DLS인증</caption>
			<tbody>
				<tr>
					<th>
						DLS회원인증
					</th>
					<td>
						<div style="padding-top: 5px; padding-bottom: 5px; " id="dlsForm">
							DLS 회원명 : <input type="text" id="dlsName" class="text" style="width: 100px;" title="DLS성명 입력">
							DLS 아이디 : <input type="text" id="dlsId" class="text" style="width: 100px;" title="DLS아이디 입력">
							DLS 패스워드 : <input type="password" id="dlsPw" class="text" title="DLS 패스워드 입력 ">
						</div>
						<div id="dlsCmt" class="ui-state-highlight">
							* 회원가입일 기준, 학교도서관지원시스템(DLS) 회원일 경우에만 인증을 통해 정회원으로 등록하시기 바랍니다.
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		</div>

		<div class="btn-wrap">
			<a href="#" id="save-btn" class="btn btn1" title="회원가입">인증하기</a>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소">취소</a>
		</div>

	</form:form>
	<br/>
</div>
