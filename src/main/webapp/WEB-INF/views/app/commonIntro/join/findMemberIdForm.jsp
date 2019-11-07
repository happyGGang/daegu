<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		doAjaxPost($('#memberInfoForm'), 'div.findId');
	});
	
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-warning"></i> 이름, 생년월일, 휴대전화번호 입력으로 아이디/대출회원번호를 찾을 수 있습니다.</li>
					<li><i class="fa fa-warning"></i> 이름, 생년월일, 휴대전화번호를 입력하신 후 '확인' 버튼을 클릭해 주세요.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="findId">
	</div>
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="findMemberId.do">
		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm">
			<tbody>
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
						생년월일(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="birth_day" class="text" maxlength="8" numberOnly="true"/> *숫자만 입력해주세요. ex)19990101
					</td>
				</tr>
				<tr>
					<th>
						휴대전화번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="cell_phone" class="text" maxlength="11" numberOnly="true"/> *숫자만 입력해주세요. ex)01012345678
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">확인</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
