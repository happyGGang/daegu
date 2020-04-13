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

		if ($('input#jumin1').val() == '') {
			alert('주민등록번호 앞 6자리를 입력하세요.');
			$('input#jumin1').focus();
			return false;
		}

		if ($('input#jumin2').val() == '') {
			alert('주민등록번호 뒤 7자리를 입력하세요.');
			$('input#jumin1').focus();
			return false;
		}

		doAjaxPost($('form#memberJoinForm'));
	});

	$('th.th1').css('width', '15%');
	$('th.th1').css('text-align', 'right');

});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>

<div class="join-wrap" style="padding: 0">

	<h4>개인정보 제3자 제공 동의(대구시민인증)</h4>

	<div class="Box" style="height:300px">
		<br>

		<ul class="con1">
			<li> 관련근거
				<ul class="con2">
					<li> 전자정부법 제8조(구비서류의 전자적 확인 등)</li>
					<li> 전자정부법 제9조(방문에 의하지 아니하는 민원처리)</li>
					<li> 전자정부법 제12조(행정정보의 전자적 제공)</li>
					<li> 전자정부법 제36조(행정정보의 효율적 관리 및 이용)</li>
					<li> 전자정부법 시행령 제90조(민감정보 및 고유식별정보의 처리) 개인정보보호법</li>
					<li> 제18조(개인정보의 목적 외 이용·제공 제한)</li>
				</ul>
			</li>
			<li> 수집기관 : 자격 대상 서비스 정보 보유기관</li>
			<li> 수집항목 : 이름, 주민등록번호 등</li>
			<li> 보유기간 : 자격여부 확인 후 즉시 파기</li>
		</ul>

		<br>
	</div>

	<div class="agree_codes" style="margin-bottom: 20px;">
		<input id="agree_codes4" name="agree_codes" req="0001" type="checkbox" value="3"><label for="agree_codes4">대구시민 자격 확인 조회를 위하여 개인정보를 처리하는 것에 동의 합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
	</div>
	<form:form id="memberJoinForm" modelAttribute="member" action="untactCheck.do" method="post" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>

		<div style="border-top:2px solid #ccc">
		<table id="memberForm">
			<caption>대구시민인증</caption>
			<tbody>
				<tr>
					<th>
						대구시민인증
					</th>
					<td>
						<div style="padding-top: 5px; padding-bottom: 5px; " id="dlsForm">
							<p>성명 : ${sessionScope.member.member_name}</p>
							<p>주민등록번호 : <input type="text" id="jumin1" name="jumin1" class="text" style="width: 120px;" title="주민등록번호 앞 6자리 입력" maxlength="6" numberOnly="true" autocomplete="off"> -
										<input type="password" id="jumin2" name="jumin2" class="text" style="width: 120px;" title="주민등록번호 뒤 7자리 입력" maxlength="7" numberOnly="true" autocomplete="off"></p>
						</div>
						<div id="dlsCmt" class="ui-state-highlight">
							* 준회원일 경우에만 인증을 통해 정회원으로 등록하시기 바랍니다.
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
	<br/>
</div>
