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

		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {
		} else {
			alert('약관 동의 하지 않았습니다.');
			return false;
		}

		if ($('input#member_name').val() == '') {
			alert('DLS 회원명을 입력하세요.');
			$('input#member_name').focus();
			return false;
		}
		if ($('input#member_id').val() == '') {
			alert('DLS 아이디를 입력하세요.');
			$('input#member_id').focus();
			return false;
		}
		if ($('input#member_pw').val() == '') {
			alert('DLS 패스워드를 입력하세요.');
			$('input#member_pw').focus();
			return false;
		}

		var wWidth = 360;
 		var wHight = 360;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;

		var dlsWindow = window.open('', "dlsWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#memberJoinForm').submit();
		dlsWindow.focus();
	});

	$('th.th1').css('width', '15%');
	$('th.th1').css('text-align', 'right');

});

$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});

</script>

<div class="join-wrap" style="padding: 0">

	<h4>개인정보 제3자 제공 동의(대구학생인증)</h4>
	<p>※ 대구광역시 공립도서관에서는 대구학생인증을 통한 정회원 자격 부여를 위하여 수집한 개인정보를 아래와 같이 제3자 제공합니다</p>
	<p style="font-weight:bold;color:#b93b74;">※ DLS 아이디/패스워드 정보를 모를 경우 해당 학교에 문의하여 주시기 바랍니다.</p>
	<div class="Box" style="height:200px;margin-top:10px;">
		<br>

		<table class="t_list tac" summary="개인정보 처리 및 위탁에 관한 안내표">
		<caption class="disnone">개인정보 처리 및 위탁에 관한 안내</caption>
		<colgroup>
			<col width="15%"/>
			<col width="15%"/>
			<col width="30%"/>
			<col width=""/>
			<col width="15%"/>
		</colgroup>
		<thead>
		<tr>
		<td>제공하는 기관</td>
		<td>제공받는 기관</td>
		<td>제공목적</td>
		<td>제공항목</td>
		<td>보유기간</td>
		</tr>
		</thead>
		<tbody>
		<tr>
		<td>대구광역시</td>
		<td>대구미래<br/>교육연구원</td>
		<td>대구광역시 공립도서관<Br/>이용을 위한 비대면 인증</td>
		<td>DLS에 등록된<br/>성명, 아이디, 비밀번호</td>
		<td>인증 후 즉시 파기(미보유)</td>
		</tr>
		<tr>
		<td>대구광역시<br/>교육연구원</td>
		<td>대구광역시</td>
		<td>대구학생인증 안내 메뉴 클릭</td>
		<td>대구학생인증 정보 확인 요청에 대한 존재 유무</td>
		<td>인증 후 즉시 파기(미보유)</td>
		</tr>
		<tr>
		<td colspan="5">개인정보 제3자 제공에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부 할 경우 대구광역시 공립도서관 정회원 자격이 부여되지 않으며, 도서관에서 제공하는 서비스 이용에 제한을 받을 수 있습니다.</td>
		</tr>
		</tbody>
		</table>

		<br>
	</div>

	<div class="agree_codes" style="margin-bottom: 20px;">
		<input id="agree_codes4" name="agree_codes" req="0001" type="checkbox" value="3"><label for="agree_codes4">개인정보 제3자 제공에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
	</div>
	<form:form id="memberJoinForm" modelAttribute="member" target="dlsWindow" action="dlsCheck.do" method="post">
		<form:hidden path="editMode"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>

		<div style="border-top:2px solid #ccc">
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<caption>대구학생인증</caption>
			<tbody>
				<tr>
					<th>
						대구학생인증
					</th>
					<td>
						<div style="padding-top: 5px; padding-bottom: 5px; " id="dlsForm">
							DLS 회원명 : <input type="text" id="member_name" name="member_name" class="text" style="width: 100px;" title="DLS성명 입력">
							DLS 아이디 : <input type="text" id="member_id" name="member_id" class="text" style="width: 100px;" title="DLS아이디 입력">
							DLS 패스워드 : <input type="password" id="member_pw" name="member_pw" class="text" title="DLS 패스워드 입력 ">
						</div>
						<div id="dlsCmt" class="ui-state-highlight">
							* 회원가입일 기준, 학교도서관지원시스템(DLS) 회원일 경우에만 인증을 통해 정회원으로 등록하시기 바랍니다.
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		</div>

		<div class="btn-wrap" style="text-align:center;padding:20px 0">
			<a href="#" id="save-btn" class="btn btn1" title="회원가입">인증하기</a>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소">취소</a>
		</div>

	</form:form>
	<br/><br/>
</div>
