<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
if (!String.prototype.trim) {
	String.prototype.trim = function () {
		return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
	};
}

$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('#memberInfoForm'), 'div.findId');
	});
	$('a.certtype').on('click', function(e) {
		var a = $('input#web_id').val().trim();
		var b = $('input#member_name').val();
		var c = $('input#cell_phone').val();

		if (a == '') {
			alert('아이디를 입력해주세요');
			$('input#web_id').focus();
			return false;
		}
		if (b == '') {
			alert('이름을 입력해주세요');
			$('input#member_name').focus();
			return false;
		}
		if (c == '') {
			alert('휴대전화번호를 입력해주세요');
			$('input#cell_phone').focus();
			return false;
		}

		e.preventDefault();
		var wWidth = 360;
 		var wHight = 120;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;
		var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#certForm input[name=certType]').val($(this).attr('id'));
		$('form#certForm')[0].submit();
		certWindow.focus();
	});
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
	<input type="hidden" name="certType">
	<input type="hidden" name="mode" value="findpw">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-warning"></i> 아이디, 이름, 휴대전화번호 입력 후 본인인증을 통해 비밀번호 재설정이 가능합니다.</li>
					<li><i class="fa fa-warning"></i> 아이디, 이름, 휴대전화번호를 입력하신 후 본인인증 버튼을 클릭해 주세요.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="findId">
	</div>
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="setPwForm.do" method="post">
		<form:hidden path="menu_idx"/>
		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm">
			<tbody>
				<tr>
					<th>
						아이디(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="web_id" class="text"/>
					</td>
				</tr>
				<tr>
					<th>
						이름(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="member_name" class="text"/>
					</td>
				</tr>
				<tr>
					<th>
						휴대전화번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="cell_phone" class="text" maxlength="11" numberOnly="true"/> *숫자만 입력해주세요. ex) 01012345678
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>

	<div class="identi_select" style="margin-top: 20px;">
		<p class="identy_a">
			<a href="#" class="certtype" id="sms">
				<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
				<span>휴대폰 본인인증</span>
			</a>
		</p>
		<p class="identy_b">
			<a href="#" class="certtype" id="gpin">
				<img src="/resources/common/img/identy2.png" alt="공공 I-PIN(아이핀)인증"/>
				<span>공공 I-PIN(아이핀)인증</span>
			</a>
		</p>
	</div>
<!-- 	<div class="btn-wrap"> -->
<!-- 		<a href="#" id="save-btn" class="btn btn1">확인</a> -->
<%-- 		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a> --%>
<!-- 	</div> -->
	<br/>
</div>
