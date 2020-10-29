<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
<script type="text/javascript">
$(function() {

	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {
			doGetLoad('edit.do', serializeCustom($('form#relayLectureStep')));
		} else {
			alert('개인정보 수집 및 활용에 동의해주셔야 합니다.');
		}
	});

	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});
});
</script>

<style>
	
</style>
<div class="join-wrap" style="padding: 0px !important;">
	<form:form modelAttribute="relayLecture" id="relayLectureStep" action="edit.do">
	<form:hidden path="menu_idx"/>
	<form:hidden path="lecture_idx"/>
	
	<div>
		<h4>개인정보 수집 활용 동의서</h4>
		<p>(신청서 작성자용)</p>
		
		<div class="Box" style="height:400px;">	
			<p>범어도서관은 「개인정보보호법」에 의거, 사업신청 및 선정과 관련 하여 귀하의 개 인 (신상)정보를 아래와 같이 수집 활용하고자 합니다. 충분히 읽어 보신 후, 동의 여 부를 체크하여 주시기 바랍니다.</p>
			<br/>
			
			<h5>1. 개인정보 수집·활용 목적</h5>
			<ul>
				<li>(1) 범어도서관은 다음 목적으로 신청자의 개인정보를 수집합니다. - 신청서 접수 여부 및 행사 안내 - 수료증 발급 본인확인 정보</li>
				<li>(2) 범어도서관은 법률상 의무이행을 제외하고는 상기 목적 외 다른 목적으로 개인 정보를 활용하거나 제3자에게 제공, 공개하지 않습니다.</li>
			</ul>
			<br/>
			
			<h5>2. 수집·활용 개인정보</h5>
			<p>[필수 정보]</p>
			<table class="t_list tac" summary="수집·활용 개인정보">
				<caption class="disnone">수집·활용 개인정보</caption>
				<colgroup>
				<col width="35%"/>
				<col width=""/>
				</colgroup>
				<tbody>
					<tr>
						<td>대상</td>
						<td>수집·활용 정보</td>
					</tr>
					<tr>
						<td>신청자</td>
						<td>성명, 성별, 연령대, 연락처(휴대폰번호)</td>
					</tr>
				</tbody>
			</table>
			<br/>
			
			<h5>3. 개인정보 보유·활용 기간</h5>
			<ul>
				<li>(1) 개인정보는 정보제공자가 개인정보 수집·이용에 대해 동의한 날로부터 보유하 며, 동의를 철회 또는 행사 종료 후 해당 개인정보는 관련 법규에 의거하여 지체 없 이 안전하게 파기됩니다. (개인정보보호법 시행령 제16조)</li>
				<li>(2) 타 법령상 의무이행, 민원처리 등에 필요한 경우에는 보존기간을 초과하여 보 유·이용될 수 있습니다.</li>
			</ul>
			<br/>
			
			<h5>4. 동의 거부 권리 및 거부할 경우의 불이익</h5>
			<ul>
				<li>(1) 귀하는 개인정보 수집·이용을 거부할 권리가 있습니다.</li>
				<li>(2) 동의 거부에 따른 불이익 : 상기 개인정보는 행사 접수과정에 반드시 필요한 정보이므로 <span style="color: red;">수집 ·활용을 거부하실 경우 행사 접수가 불가능함</span>을 알려 드립니다.</li>
			</ul>
			<br/>
			
			<p>본인은 이 동의서의 내용을 충분히 이해하였으며, 범어도서관이 개인정보보호법 등 관련 법규에 의거하여 본인의 개인정보를 수집 및 활용하는 것에 동의합니다.</p>
		</div>

		<div class="agree_codes">
			<input id="agree_codes3" name="agree_codes" req="0001" type="checkbox" value="2"><label for="agree_codes3">개인정보 수집 및 활용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>

	</form:form>

	<div class="btn-wrap">
		<a href="javascript:history.back();" class="btn btn02">취소</a>
		<a href="#" id="join-btn" class="btn btn03">다음단계로</a>
	</div>
</div>
