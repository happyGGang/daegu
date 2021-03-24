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
			doGetLoad('edit.do', serializeCustom($('form#bookRelayGroupStep')));
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
	.tbl-type01 thead tr td{background:#fafafa;font-weight:bold;}
	.tbl-type01 tbody tr td{background:#fafafa;font-size:13px;text-align:left;}

	.join-wrap{padding: 0px !important;width:100%;}
	
	@media (max-width: 1024px) {
		.join-wrap{padding:0 20px;width:calc(100% - 40px);}
	}
</style>
<div class="join-wrap">
	<form:form modelAttribute="bookRelayGroup" id="bookRelayGroupStep" action="edit.do">
	<form:hidden path="menu_idx"/>
	<div>
		<h2>개인정보 수집 이용 동의서</h2>
		<div class="Box" style="height:400px;">	
			<h5>2021 수성인문학제 독서릴레이 신청을 위한 개인정보 수집 및 이용 동의서</h5>
			<p>2021 수성인문학제 독서릴레이 신청을 위하여 아래와 같이 개인정보를 수집·이용하고자 합니다. 내용을 자세히 읽으신 후 동의 여부를 결정하여 주시기 바랍니다.</p>
			
			<br/>
			
			<h5>개인정보 수집·이용 내역</h5>
			<table class="tbl-type01 t_list tac" summary="개인정보 수집·이용 내역">
				<caption class="disnone">개인정보 수집·이용 내역</caption>
				<colgroup>
				<col width="35%"/>
				<col width="35%"/>
				<col width=""/>
				</colgroup>
				
				<thead>
					<tr>
						<td>항목</td>
						<td>수집·이용 목적</td>
						<td>보유기간</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>성명, 연락처(휴대전화), E-mail, 주소, 활동사진·영상</td>
						<td>독서릴레이 신청 및 운영, 홍보 및 기록자료(자료집)에 활용</td>
						<td><u>2021 수성인문학제 사업 종료 시까지</u></td>
					</tr>
					<tr>
						<td colspan="4">
							※ 독서릴레이 참여자를 대상으로 활동사진 등 촬영하며, 본인의 초상이 사진 및 영상물에 기록될 경우 수성구립(범어‧용학‧고산)도서관 행사홍보자료로 활용, 기록자료(자료집) 제작에 활용될 수 있습니다.<br/>
							※ 도서관의 독서·문화프로그램 홍보를 위하여 회원님의 연락처를 이용, 차후 행사관련 문자를 발송할 수 있습니다. 원치 않는 경우, 범어도서관(☎053-668-1600)으로 연락하시면 안전하게 파기하도록 하겠습니다.<br/>
							※ 위의 개인정보 수집·이용에 대한 동의를 거부할 권리가 있습니다.그러나 동의를 거부할 경우 독서릴레이 신청이 불가능합니다.
						</td>
					</tr>
					<tr>
						<td colspan="4">본인은 위 내용을 충분이 이해하였으며, 수성구립도서관(범어‧용학‧고산)이 개인정보보호법 등 관련 법규에 의거하여 본인이 개인정보를 수집 및 활용하는 것에 동의합니다.</td>
					</tr>
				</tbody>
			</table>
				
			<br/>
			
			<h5>만 14세 미만 아동의 개인정보처리</h5>
			<p>만 14세 미만 아동의 개인정보를 처리하기 위하여 그 법정대리인의 동의를 받아야 합닌다. 법정대리인의 최소한의 정보는 법정대리인의 동의없이 해당 아동으로부터 직접 수집할 수 있습니다.</p>
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
