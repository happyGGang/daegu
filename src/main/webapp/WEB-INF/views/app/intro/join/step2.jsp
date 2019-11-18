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
			$('#memberAgreeForm').submit();
		} else {
			alert('약관 동의 하지 않았습니다.');
		}
	});

	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});
});
</script>

<div class="join-wrap">

	<form:form modelAttribute="newMember" id="memberAgreeForm" action="step3.do" method="post">
	<form:hidden path="ageType"/>

	<p class="blind">회원가입 단계</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1 center">
					<div class="en">STEP 01</div>
					<div class="ko">회원유형</div>
				</td>

				<td class="joinImg2 center active">
					<div class="en">STEP 02</div>
					<div class="ko">이용약관동의</div>
				</td>

				<td class="joinImg3 center">
					<div class="en">STEP 03</div>
					<div class="ko">본인확인</div>
				</td>

				<td class="joinImg4 center">
					<div class="en">STEP 04</div>
					<div class="ko">정보입력</div>
				</td>
			</tr>
			<tr>
				<td class="joinLine center active">
					<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
				</td>

				<td class="joinLine center">
					<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
				</td>

				<td class="joinLine center">
					<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
				</td>

				<td class="joinLine center">
					<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="join-wrap" style="padding:18px 0">
			<div class="info">
				<ul class="con2">
					<li>"대구통합도서관 허브시스템" 구축으로 대구통합도서관(공립 공공도서관 및 공립 작은도서관) 회원은 하나의 회원번호로 통합 운영됩니다. 대구시 통합회원으로 전환 후 이용하시기 바랍니다.</li>
				</ul>
			</div>
			<h4>대구통합도서관 허브시스템 통합회원 이용약관</h4>
			<div class="Box" style="height:200px">
			  <p><strong>제1장 총칙<br>
				<br>
			  제1조 (목적)</strong><br />
			  본 약관은 대구시 공립 공공도서관 및 공립 작은도서관(이하 ‘대구통합도서관’ 이라 한다.)을 통해서 제공하는 각종 통합회원 서비스를 이용함에 있어 이용자와 도서관간의 권리·의무 및 책임사항과 기타 필요한 사항을 규정함을 목적으로 한다.<br>
			  <br>
			  <strong>제2조 (용어의 정의)</strong><br />
			  ① 본 약관에서 사용하는 용어의 정의는 다음과 같다.<br />
			  <span class="siz12"> 1. 서비스 : 온라인 및 오프라인으로 도서관에서 제공하는 서비스<br />
			  2. 사이트 : 대구통합도서관에서 운영하는 홈페이지<br />
			  3. 가  입 : 대구통합도서관 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위<br />
			  4. 통합회원 : 대구통합도서관 회원 가입에 동의하고 본인확인절차를 통해 회원번호 부여 및 회원카드가 발급된 회원으로 자료의 관외대출이 가능한 회원<br />
			  5. 아이디(ID) : 회원 식별과 회원의 서비스 이용을 위하여 이용자가 생성한 영문자 또는 기타 문자로 조합된 부호<br />
			  6. 비밀번호(PASSWORD) : 회원의 정보 보호를 위해 이용자 자신이 설정한 문자와 숫자, 특수문자 등으로 조합된 부호<br />
			  7. 탈퇴 : 회원이 서비스 이용계약을 종료시키는 의사표시<br>
			  </span>② 본 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스 별 안내에서 정하는 바에 의한다. <br>
			  <br>
			  <strong>제3조 (약관의 효력 및 변경)</strong><br />
			  <span class="siz12"> ① 본 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공시되며, 이를 동의한 이용자가 서비스에 가입함으로써 효력이 발생한다.<br />
			  ② 합리적인 사유가 발생할 경우 도서관은 관련 법령에 위배되지 않는 범위 안에서 개정할 수 있다. 개정된 약관은 사이트 등을 통해 공지함으로써 효력이 발생한다.<br />
			  ③ 회원은 정기적으로 사이트를 방문하여 약관의 변경사항을 확인하여야 하며 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있다. 변경된 약관에 대한 정보를 알지 못해 발생하는 회원의 피해는 도서관에서 책임지지 않는다. <br />
			  ④ 대구통합도서관의 자료대출 및 좌석예약 실적이 2년 이상 없고 계속 사용에 대한 동의를 하지 않은 경우 회원 효력이 상실된다.<br />
			  ⑤ 대구통합도서관은 필용한 경우 개별 서비스에 대하여 이용규정을 정할 수 있으며, 본 약관과 서로 상충되는 경우에는 서비스별 이용규정의 내용을 우선하여 적용한다.<br />
			  ⑥ 본 약관에 명시되지 않은 사항에 대해서는 관련 법령의 규정에 의한다.<br>
			  <br>
			  <br>
			  </span><strong>제2장 서비스 이용계약<br>
			  <br>
			  제4조 (이용계약의 성립)</strong><br />
			  <span class="siz12"> 이용계약은 이용자의 약관내용 및 개인정보 제공에 대한 동의와 이용자의 이용신청에 대한 도서관 관리자의 승낙으로 성립한다.<br>
			  <br>
			  </span><strong>제5조 (이용신청)</strong><br />
			  <span class="siz12"> 이용신청은 홈페이지 또는 도서관 내의 회원가입PC의 회원가입신청 양식에 개인의 신상정보 입력 및 정보 제공을 동의하는 방식으로 신청한다.<br>
			  <br>
			  </span><strong>제6조 (이용신청의 승낙)</strong><br />
			  <span class="siz12"> ① 도서관 관리자는 제5조에서 정한 사항을 정확히 기재하여 이용신청을 하였을 경우 특별한 사정이 없는 한 서비스 이용신청을 승낙하여야 한다.<br />
			  ② 도서관 관리자는 다음 각 항목에 해당하는 경우에 대하여는 회원 가입을 취소할 수 있다.<br />
			  &nbsp;&nbsp;1. 본인의 실명으로 신청하지 않았을 때<br />
			  &nbsp;&nbsp;2. 다른 사람의 명의를 사용하여 신청하였을 때<br />
			  &nbsp;&nbsp;3. 신청서의 내용을 허위로 기재하였을 때<br />
			  &nbsp;&nbsp;4. 14세 미만 아동이 법정대리인(부모 등)의 동의를 얻지 아니한 경우<br />
			  &nbsp;&nbsp;5. 사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때<br />
			  &nbsp;&nbsp;6. 기타 도서관이 정한 신청 요건이 미비 되었을 때<br>
			  <br>
			  </span><strong>제7조 (회원정보 관리)</strong><br />
			  <span class="siz12"> ① 도서관 관리자는 제5조에서 정한 사항을 정확히 기재하여 이용신청을 하였을 경우 특별한 사정이 없는 한 서비스 이용신청을 승낙하여야 한다.<br />
			  ② 도서관 관리자는 다음 각 항목에 해당하는 경우에 대하여는 회원 가입을 취소할 수 있다.<br />
			  &nbsp;&nbsp;1. 본인의 실명으로 신청하지 않았을 때<br />
			  &nbsp;&nbsp;2. 다른 사람의 명의를 사용하여 신청하였을 때<br />
			  &nbsp;&nbsp;3. 신청서의 내용을 허위로 기재하였을 때<br />
			  &nbsp;&nbsp;4. 14세 미만 아동이 법정대리인(부모 등)의 동의를 얻지 아니한 경우<br />
			  &nbsp;&nbsp;5. 사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때<br />
			  &nbsp;&nbsp;6. 기타 도서관이 정한 신청 요건이 미비 되었을 때<br>
			  <br>
			  </span><strong>제8조 (회원탈퇴 및 이용제한)</strong><br />
			  <span class="siz12"> ① 회원이 이용계약을 해지하고자 할 때에는 회원 본인이 직접 사이트를 통해 탈퇴 신청을 하거나, 도서관을 직접 방문하여 본인확인절차를 거친 후 탈퇴 신청을 하여야 한다.<br />
			  ② 회원탈퇴 시 해당 개인정보는 보유기간이 만료되므로 회원과 관련된 모든 정보는 삭제된다.<br />
			  ③ 도서관은 보안 및 아이디 정책, 서비스의 원활한 제공 등과 같은 이유로 회원 아이디 및 비밀번호 변경을 요구할 수 있다. <br />
			  ④ 아래의 경우 도서관 관리자는 회원 가입을 취소할 수 있다.<br />
			  &nbsp;&nbsp;1. 범죄적 행위에 관련되는 경우<br />
			  &nbsp;&nbsp;2. 국익 또는 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우<br />
			  &nbsp;&nbsp;3. 회원이 제공한 데이터가 허위임이 판명된 경우 <br />
			  &nbsp;&nbsp;4. 타인의 서비스 아이디 및 비밀번호를 도용한 경우<br />
			  &nbsp;&nbsp;5. 타인의 명예를 손상시키거나 불이익을 주는 경우<br />
			  &nbsp;&nbsp;6. 같은 사용자가 다른 아이디로 이중 등록을 한 경우<br />
			  &nbsp;&nbsp;7. 서비스에 위해를 가하는 등 서비스의 건전한 이용을 저해하는 경우<br />
			  &nbsp;&nbsp;8. 기타 관련법령이나 도서관이 정한 이용조건에 위배되는 경우<br>
			  <br>
			  <br>
			  </span><strong>제3장 서비스 제공 및 이용<br>
			  <br>
			  제9조 (서비스 이용 및 변경)</strong><br />
			  <span class="siz12"> ① 도서관 관리자는 회원의 이용신청을 승낙한 때부터 서비스를 개시한다. 단, 일부 서비스의 경우에는 지정된 일자부터 서비스를 개시할 수 있다.<br />
			  ② 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 사이트에 공지하거나 회원에게 이를 통지한다.<br />
			  ③ 도서관은 정책 및 운영의 필요에 따라 서비스의 일부 또는 전부를 수정, 중단, 변경할 수 있으며, 사전에 7일 이상 사이트 등을 통해 공지한다.<br>
			  <br>
			  </span><strong>제10조 (정보의 제공)</strong><br />
			  <span class="siz12"> 회원에게 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서는 전자우편 및 휴대폰 문자메시지 등의 방법으로 제공할 수 있다. 다만, 회원은 정보수신을 원치 않을 경우에는 거부할 수 있다.<br>
			  <br>
			  <br>
			  </span><strong>제4장 계약 당사자의 의무<br>
			  <br>
			  제11조 (회원의 의무 및 정보보안)</strong><br />
			  <span class="siz12"> ① 회원은 서비스 이용을 위해 가입할 경우 현재의 사실과 일치하는 완전한 정보를 제공해야 한다. 또한 가입정보가 변경된 경우 즉시 갱신 또는 도서관에 통보하여야 한다.<br />
			  ② 회원은 서비스 사용을 위한 가입절차를 통해 아이디와 비밀번호를 설정할 수 있다.<br />
			  ③ 회원은 사이트 접속 종료 시 로그아웃을 해야 하며 본인의 승인 없이 아이디, 비밀번호가 사용되는 문제가 발생되면 즉시 이용도서관의 관리 책임 부서에 신고하여야 한다.<br>
			  <br>
			  </span><strong>제12조 (도서관의 의무)</strong><br />
			  <span class="siz12"> ① 도서관은 회원이 희망한 서비스 제공 개시일에 특별한 사정이 없는 한 서비스를 이용할 수 있도록 하여야 한다.<br />
			  ② 도서관은 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 멸실된 때에는 부득이한 사유가 없는 한 지체 없이 이를 수리 또는 복구해야 한다.<br />
			  ③ 도서관은 회원이 안전하게 서비스를 이용할 수 있도록 개인정보보호를 위한 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수하여야 한다.<br />
			  ④ 도서관은 회원으로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 한다. 다만, 즉시 처리가 곤란한 경우는 회원에게 그 사유와 처리일정을 통보하여야 한다.<br />
			  ⑤ 도서관은 회원의 귀책사유로 인한 서비스 이용 장애에 대해서는 책임을 지지 않는다.<br>
			  <br>
			  <br>
			  </span><strong>제5장 기타<br>
			  <br>
			  제13조 (양도금지)</strong><br />
			  <span class="siz12"> 회원은 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없다.<br>
			  <br>
			  </span><strong>제14조 (손해배상)</strong><br />
			  <span class="siz12"> 도서관은 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 이에 대하여 책임을 지지 않는다. 다만, 중대한 과실에 의한 경우에는 그러하지 아니한다.<br>
			  <br>
			  </span><strong>제15조 (면책조항)</strong><br />
			  <span class="siz12"> ① 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제된다.<br />
			  ② 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않는다.<br />
			  ③ 회원이 서비스를 이용하여 기대하는 이익이나 서비스를 통해 얻은 자료로 인한 손해는 책임 지지 않는다.<br />
			  ④ 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임 지지 않는다.<br>
			  <br>
			  <br>
			  </span><strong>&lt;부 칙&gt;</strong> <br>
			  본 약관은 2018년 10월 30일부터 적용한다. </p>
			</div>
			<div class="agree_codes">
				<input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1"><label for="agree_codes1">통합회원 이용약관에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>

			<h4>대구통합도서관 허브시스템 통합회원 개인정보 수집‧이용 및 제공 동의</h4>

			<div class="Box" style="height:200px">
				<p class="joinPoint">하나의 회원카드로 대구통합도서관(공공도서관 및 공립 작은도서관)을 모두 이용할 수 있는 대구시 통합회원 서비스를 위하여  아래와 같이 개인정보를 수집하여 대구통합도서관에서 공동 이용합니다.<br>

				<strong><br>
				개인정보 수집·이용 내역</strong><br><br>

				<table class="t_list tac" summary="개인정보 수집·이용 내역">
				  <caption class="disnone">
				  개인정보 수집·이용 내역
				  </caption>
				  <colgroup>
				  <col width="10%"/>
				  <col width="10%"/>
				  <col width=""/>
				  <col width="15%"/>
				  <col width="10%"/>
				  </colgroup>
				  <thead>
					<tr>
					  <th scope="col">구분</th>
					  <th colspan="2" scope="col">항목</th>
					  <th scope="col">수집목적</th>
					  <th class="brn" scope="col">보유용기간</th>
					</tr>
				  </thead>
				  <tbody>
					<tr>
					  <th rowspan="3">필수</th>
					  <td class="cn"> 14세이상 </td>
					  <td align="left">아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, 도서회원번호, CI값, 도서대출내역, SMS수신여부, E-mail수신여부</td>
					  <td rowspan="2">도서대출 및 반납 등 도서관 서비스</td>
					  <td rowspan="4" class="brn cn">회원 탈퇴시까지</td>
					</tr>
					<tr>
					  <td class="cn"> 14세미만 </td>
					  <td align="left">아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, 도서회원번호, CI값, 도서대출내역 법정대리인 성명 및 연락처, SMS수신여부, E-mail수신여부</td>
					</tr>
					<tr>
					  <td class="cn" colspan="2"> 성명, 연락처 </td>
					  <td>만14세 미만 신청자 관련 안내</td>
					</tr>
				   <tr>
					  <th>선택</th>
					  <td colspan="2" class="cn"> 이메일, 전화번호(자택) </td>
					  <td>도서관 서비스 안내</td>
					</tr>
				  </tbody>
				</table>
				<br>
				1. 개인정보의 수집·이용목적에 대한 동의를 거부할 수 있으며, 필수 항목 동의를 거부할 경우 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다. 선택 항목은 동의를 거부하셔도 회원가입은 하실 수 있습니다.
				<br/>
				2. 휴대폰번호는 나이스평가정보에서 인증 받은 휴대폰 번호를 사용 하고 있습니다.
				<br/>
				</p>
			</div>

			<div class="agree_codes">
				<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2"><label for="agree_codes2">개인정보 수집·이용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>

			<h4>개인정보 공동이용(제공) 내역</h4>
			<div class="Box" style="height:200px">

				<br>
				<table class="t_list tac" summary="개인정보 처리 및 위탁에 관한 안내표">
				  <caption class="disnone">
				  개인정보 처리 및 위탁에 관한 안내
				  </caption>
				  <colgroup>
				  <col width="15%"/>
				  <col width="30%"/>
				  <col width=""/>
				  <col width="15%"/>
				  </colgroup>
				  <thead>
					<tr>
					  <th scope="col">공동이용 기관</th>
					  <th scope="col">공동이용 목적</th>
					  <th scope="col">공동이용 항목</th>
					  <th scope="col" class="brn">공동이용 기간</th>
					</tr>
				  </thead>
				  <tbody>
					<tr>
					  <th>대구통합도서관</th>
					  <td class="cn">하나의 회원번호로<br>대구시 모든 공립 도서관 이용</td>
					  <td>아이디, 비밀번호, 도서회원번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, CI값, 도서대출내역, 법정대리인 성명 및 연락처, 이메일, 전화번호(자택), 근무처, 근무지연락처, 근무지주소, 학교명, 학년, 반, 번호</td>
					  <td class="brn cn">회원 탈퇴시까지</td>
					</tr>
				  </tbody>
				</table>
				<br>
				개인정보 공동이용에 거부할 권리가 있습니다. 다만 동의를 거부 할 경우 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다.
				</p>
				<br/>
			</div>

			<div class="agree_codes">
				<input id="agree_codes3" name="agree_codes" req="0001" type="checkbox" value="3"><label for="agree_codes3">개인정보 공동이용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>


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
							<th scope="col">제공받는 기관</th>
							<th scope="col">제공목적</th>
							<th scope="col">제공항목</th>
							<th scope="col" class="brn">보유기간</th>
						</tr>
					</thead>
					<tbody>
					<tr>
						<th>국립중앙도서관 및 지역센터</th>
						<td class="cn">책이음서비스 이용</td>
						<td>도서회원번호, 성명, 출생년도, 성별, 휴대폰번호, CI값, 도서대출내역</td>
						<td class="brn cn">회원 탈퇴시까지</td>
					</tr>
					<tr>
						<th>책이음서비스 참여 도서관</th>
						<td class="cn">책이음서비스를 통한 회원가입</td>
						<td>아이디, 비밀번호, 도서회원번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, CI값, 도서대출내역 법정대리인 성명 및 연락처, 이메일, 전화번호(자택), 근무처, 근무지연락처, 근무지주소, 학교명, 학년, 반, 번호</td>
						<td class="brn cn">회원 탈퇴시까지</td>
					</tr>
					</tbody>
				</table>
				<br>
				개인정보 제3자 제공에 거부할 권리가 있습니다. 다만 동의를 거부 할 경우 책이음서비스 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다.</p>
				<br>
			</div>

			<div class="agree_codes">
				<input id="agree_codes4" name="agree_codes" req="0001" type="checkbox" value="4"><label for="agree_codes4">개인정보 제3자 제공에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>

			<div class="center">
				<input id="all-agree" type="checkbox"><label for="all-agree"> 모든 약관에 동의 합니다.</label>
			</div>
	</div>

	</form:form>

	<div class="btn-wrap">
		<a href="javascript:history.back();" class="btn btn02">취소</a>
		<a href="#" id="join-btn" class="btn btn03">다음</a>
	</div>
</div>
