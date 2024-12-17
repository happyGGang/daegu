<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">

$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('#memberInfo'), 'div.findId');
	});
	$('a.certtype').on('click', function(e) {
		e.preventDefault();
		var tmp_id = $('input#member_id_tmp').val().trim();
		if (!tmp_id) {
			alert('아이디를 입력해주세요.');
			$('input#member_id_tmp').focus();
			return false;
		}
		if (tmp_id.length < 6 || tmp_id.length > 20) {
			alert('아이디는 6자 이상 20자 이내입니다.');
			$('input#member_id_tmp').focus();
			return false;
		}
		$('input[name=member_id]').val(tmp_id);

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
	<input type="hidden" name="member_id">
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-warning"></i> 아이디 입력 후 본인인증을 통해 비밀번호 재설정이 가능합니다.</li>
					<li><i class="fa fa-warning"></i> 아이디를 입력하신 후 본인인증 버튼을 클릭해 주세요.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="findId">
	</div>
	<form:form modelAttribute="memberInfo" action="changePwForm.do" method="post">
		<form:hidden path="menu_idx"/>
		<div style="text-align: right;margin-bottom:10px;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm" style="border-top:2px solid #ccc;border-bottom:1px solid #ddd;">
			<tbody>
				<tr>
					<th>
						아이디(<span style="color: red;">*</span>)
					</th>
					<td>
						<input type="text" id="member_id_tmp" class="text" />
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
	<br/>
</div>
