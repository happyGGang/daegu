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
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

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
			<!-- <div class="info">
				<ul class="con2">
					<li>"대구통합도서관 허브시스템" 구축으로 대구통합도서관(공립 공공도서관 및 공립 작은도서관) 회원은 하나의 회원번호로 통합 운영됩니다. 대구시 통합회원으로 전환 후 이용하시기 바랍니다.</li>
				</ul>
			</div> -->
			<h4>대구광역시 도서관 통합회원 이용약관</h4>
			<div class="Box" style="height:200px">
			  <p><strong>제1장 총칙<br><br>
			  제1조 (목적)</strong><br />
			  본 약관은 『대구광역시 도서관 통합 허브시스템』을 구축(이하 ‘통합시스템’이라 함)에 따라 대구광역시 공립 공공도서관 및 공립 작은도서관(이하 ‘도서관’ 이라 한다.) 회원 정보를 통합 운영함에 있어 이용자와 도서관간의 이용조건 및 절차, 이용에 관한 권리와 의무 등 제반사항을 규정함을 목적으로 한다.<br>
			  <br>
			  <strong>제2조 (용어의 정의)</strong><br />
			  ① 본 약관에서 사용하는 용어의 정의는 다음과 같다.<br />
			  <span class="siz12"> 1. 서비스 : 온라인사이트 이용 및 오프라인도서관 이용 모두를 의미<br />
			  2. 사이트 : 도서관에서 운영하는 홈페이지<br />
			  3. 통합회원 : 도서관 회원 가입에 동의하고 본인확인절차를 통해 회원번호 부여 및 회원카드가 발급된 회원으로 자료의 관외대출이 가능한 회원 또는 통합인증을 통해 통합회원으로 자격이 부여된 회원이며 책이음 이용정보제공이용약관에 동의하면 책이음회원으로 자격을 부여 한다.<br />
			  4. 통합인증 : 통합회원, 책이음회원으로의 자격을 부여받는 절차를 의미하며 통합인증을 받지 않으면 일부 서비스의 제약을 받을 수 있다.<br />
			  5. 아이디(ID) : 회원 식별과 서비스 이용을 위하여 이용자가 생성한 영문자 또는 기타 문자로 조합된 부호<br />
			  6. 비밀번호(PASSWORD) : 회원의 정보 보호를 위해 이용자 자신이 설정한 문자와 숫자, 특수문자 등으로 조합된 부호<br />
			  </span>② 본 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스 별 안내에서 정하는 바에 의한다.<br>
			  <br>
			  <strong>제3조 (약관의 효력 및 변경)</strong><br />
			  ① 본 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공시되며, 이를 동의한 이용자가 서비스에 가입함으로써 효력이 발생한다.<br />
			  ② 합리적인 사유가 발생할 경우 도서관은 관련 법령에 위배되지 않는 범위 안에서 개정할 수 있다. 개정된 약관은 사이트 등을 통해 공지함으로써 효력이 발생한다.<br />
			  ③ 회원은 정기적으로 사이트를 방문하여 약관의 변경사항을 확인하여야 하며 회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있다. 변경된 약관에 대한 정보를 알지 못해 발생하는 회원의 피해는 도서관에서 책임지지 않는다. <br />
			  ④ 도서관의 자료대출 및 좌석예약 실적이 2년 이상 없고 계속 사용에 대한 동의를 하지 않은 경우 회원 효력이 상실된다.<br />
			  ⑤ 도서관은 필요한 경우 개별 서비스에 대하여 이용규정을 정할 수 있으며, 본 약관과 서로 상충되는 경우에는 서비스별 이용규정의 내용을 우선하여 적용한다.<br />
			  ⑥ 본 약관에 명시되지 않은 사항에 대해서는 관련 법령의 규정에 의한다.<br>
			  <br>
			  <br>
			  </span>
			  
			  <strong>제2장 서비스 이용계약<br>
			  <br>
			  제4조 (이용계약의 성립)</strong><br />
			  ① 이용계약은 이용자의 약관내용 및 개인정보 제공에 대한 동의와 이용자의 이용신청에 대한 도서관 관리자의 승낙으로 성립한다.<br>
			  ② 이용계약에 대한 동의는 이용 신청 당시 사이트의 ‘동의함’ 버튼을 누름으로써 의사표시를 한다. <br>
			  <br>

			  <strong>제5조 (회원 자격) 회원은 다음 각 호의 어느 하나에 해당하는 경우 그 자격을 가진다.</strong><br />
			  <span class="siz12">
			  &nbsp;&nbsp;1. 대구광역시(경산시, 칠곡군 포함)에 주민등록이 되어 있는 자<br>
			  &nbsp;&nbsp;2. 대구광역시 소재 직장에 재직하는 자<br>
			  &nbsp;&nbsp;3. 대구광역시(경산시, 칠곡군 포함)소재 학교에 재학하는 자<br>
			  &nbsp;&nbsp;4. 대구광역시에 거주하는 재외동포 국내거소 신고자 및 외국인 등록자<br>
			  &nbsp;&nbsp;5. 그밖에 관장이 필요하다고 인정하는 자<br>
			  </span><br>
			  <br>
			  
			  <strong>제6조 (회원 가입 및 탈퇴)</strong><br />
			  ① 이용자는 도서관에서 제공하는 홈페이지에서 개인정보 수집 및 정보 제공을 동의한 후 회원가입을 신청할 수 있다.<br><br/>
			  <div>
			<div style="text-align:center;">
				<도서관 통합회원 개인정보 수집 정보, 목적 및 보유기간>
			</div>
			<table>
			  <tr>
				<th style="text-align:Center">구분</th>
				<th colspan="2" style="text-align:Center">항목</th>
				<th style="text-align:Center">수집목적</th>
				<th style="text-align:Center">보유기간</th>
			  </tr>
			  <tr>
				<td rowspan="3" style="width:10%">필수</td>
				<td style="width:15%">14세 이상</td>
				<td style="width:35%">아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호 또는 전화번호(자택), 주소, 도서회원번호, CI값, 도서대출내역, SMS수신여부</td>
				<td rowspan="2" style="width:20%">도서대출 및
					 반납 등 
				  도서관 서비스</td>
				<td rowspan="5" style="width:20%">2년
					(회원 탈퇴시
				  까지)</td>
			  </tr>
			  <tr>
				<td>14세 미만</td>
				<td>아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호 또는 전화번호(자택), 주소, 도서회원번호, CI값, 도서대출내역 법정대리인 성명 및 연락처, SMS수신여부</td>
			  </tr>
			  <tr>
				<td colspan="2">법정대리인 성명, 연락처</td>
				<td>만 14세 미만
					신청자</td>
			  </tr>
			  <tr>
				<td rowspan="2">선택</td>
				<td colspan="2">근무처(학교명), 근무지(학교)연락처, 근무지(학교)주소</td>
				<td>타지역 거주 도서 회원 가입</td>
			  </tr>
			  <tr>
				<td colspan="2">이메일, 이메일수신여부</td>
				<td>서비스 안내</td>
			  </tr>
			</table>
			  </div>
			  <p>※ 휴대폰 번호는 나이스평가정보에서 인증 받은 휴대폰 번호를 사용 하고 있습니다.(단, 핸드폰 인증만 국한)</p>
			  <br/>

			  ② 회원 가입과 동시에 공공도서관 책이음 회원으로 가입된다.<br>
			  ③ 도서관 관리자는 제6조 ①항에서 정한 사항을 정확히 기재하여 이용신청을 하였을 경우 특별한 사정이 없는 한 서비스 이용신청을 승낙하여야 한다. 단, 다음의 경우 회원 가입을 취소할 수 있다.<br>
			  <span class="siz12">
			  &nbsp;&nbsp;1. 본인의 실명으로 신청하지 않았을 때<br>
			  &nbsp;&nbsp;2. 다른 사람의 명의를 사용하여 신청하였을 때<br>
			  &nbsp;&nbsp;3. 신청서의 내용을 허위로 기재하였을 때<br>
			  &nbsp;&nbsp;4. 14세 미만 아동이 법정대리인(부모 등)의 동의를 얻지 아니한 경우<br>
			  &nbsp;&nbsp;5. 사회의 안녕 질서 또는 미풍양속을 저해할 목적으로 신청하였을 때  <br>
			  &nbsp;&nbsp;6. 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 경우<br>
			  &nbsp;&nbsp;7. 서비스를 이용함에 법령과 본 약관이 금지하는 행위를 하는 경우<br>
			  &nbsp;&nbsp;8. 기타 도서관이 정한 신청 요건이 미비 되었을 때<br>
			  </span><br>
			  ④ 회원이 이용계약을 해지하고자 할 때에는 홈페이지 또는 도서관을 직접 방문하여 본인확인절차를 거친 후 탈퇴 신청을 하여야 한다.<br />
			  ⑤ 회원탈퇴 시 해당 회원과 관련된 모든 개인정보는 보유기간이 만료되므로 삭제된다.<br />
			  <br>
			  

			  <strong>제7조 (회원 정보 관리)</strong><br />
			  ① 회원은 홈페이지 회원정보관리 및 도서관에 직접 방문하여 정보를 열람하고 수정할 수 있다. <br />
			  ② 회원의 개인정보에 대한 관리책임은 회원에게 있다. 이를 소홀히 관리하여 발생하는 서비스 이용상의 손해 또는 제3자에 의한 부정 이용 등에 대한 책임은 모두 회원에게 있으며 도서관은 그에 대해 책임지지 않는다.<br>
			  ③ 도서관은 보안 및 아이디 정책, 서비스의 원활한 제공 등과 같은 이유로 회원 아이디 및 비밀번호 변경을 요구할 수 있다.<br>
			  <br>

			  <strong>제8조 (회원 자격 상실 및 회원정보 삭제)</strong><br />
			  ① 회원은 개인정보보호법 제21조 및 동법 시행령 제16조에 의거하여 다음의 경우 회원 자격을 상실하며, 개인정보도 삭제된다.<br />
			  &nbsp;&nbsp;1. 본인이 탈퇴를 원하는 경우<br />
			  &nbsp;&nbsp;2. 회원의 법령 또는 약관의 위반을 포함하여 부정행위 확인 등의 정보보호 업무를 위해 필요한 경우<br />
			  ② 다음의 경우 탈퇴 신청은 제한되며, 개인정보 또한 삭제되지 않는다. 단, 제한사유가 소멸되면 즉시 탈퇴할 수 있다. <br />
			  &nbsp;&nbsp;1. 도서관으로 반납할 자료가 있거나 대출정지 중인 경우<br />
			  &nbsp;&nbsp;2. 대출 자료를 분실 혹은 훼손하고 변상하지 않은 경우<br />
			  &nbsp;&nbsp;3. 기타 회원탈퇴 제한이 필요하다고 도서관장이 인정하는 경우<br />
			  <br>
			  
			  <strong>제9조 (개인정보의 보호 및 사용)</strong><br />
				① 도서관은 회원정보를『개인정보보호법』에 의해 보호한다.<br>
				② 회원의 개인정보는 오직 본인만이 열람/수정/삭제 하는 것을 원칙으로 하되,  비밀번호 등이 타인에게 노출되지 않도록 철저히 관리해야한다.<br>
				③ 도서관은 서비스 제공과 관련해서 수집된 회원의 개인정보를 본인의 동의 없이 제3자에게 제공되지 않는다. 다만, 개인정보보호법 제18조에 의거 제3자에게 제공할 수 있다.<br>
				  &nbsp;&nbsp;1. 수사기관이나 기타 다른 정부기관으로부터 정보제공을 요청 받은 경우<br>
				  &nbsp;&nbsp;2. 회원의 법령 또는 약관의 위반을 포함하여 부정행위 확인 등의 정보보호 업무를 위해 필요한 경우<br>
				  &nbsp;&nbsp;3. 기타 법률에 의해 요구되는 경우<br>
			  <br>

			  <strong>제3장 서비스 제공 및 이용<br>
			  <br>
			  제10조 (서비스의 제공)</strong><br />
				① 도서관 관리자는 회원의 이용신청을 승낙한 때부터 서비스를 개시한다. 단, 일부 서비스의 경우에는 지정된 일자부터 서비스를 개시할 수 있다.<br>
				② 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 사이트에 공지하거나 회원에게 이를 통지한다.<br>
				③ 도서관은 긴급한 시스템 점검, 교체, 설비의 장애, 서비스 이용의 폭주, 국가비상사태, 정전 등 부득이한 사유가 발생한 경우 사전 예고없이 일시적으로 서비스의 전부 또는 일부를 중단할 수 있다.<br>
				④ 도서관은 서비스 개편 등 서비스 운영 상 필요한 경우 회원에게 사전 예고 후 서비스의 전부 또는 일부의 제공을 중단 할 수 있다.<br>
			  <br>
			  
			  <strong>제11조 (서비스의 변경)</strong><br />
			  ① 도서관은 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 서비스를 변경할 수 있다.<br>
			  ② 도서관은 정책 및 운영의 필요에 따라 사전공지를 통해 무료로 제공되는 서비스의 일부 또는 전부를 수정, 중단, 변경할 수 있으며, 이용회원에게는 별도의 보상을 하지 않는다.<br>
			  <br>

			  <strong>제11조 (정보의 제공)</strong><br />
			  회원에게 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서는 전자우편 및 휴대폰 문자메시지 등의 방법으로 제공할 수 있다. 다만, 회원은 정보수신을 원치 않을 경우에는 거부할 수 있다.<br>
			  <br>

			  
			  <strong>제12조 (정보의 제공)</strong><br />
			  회원에게 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서는 전자우편 및 휴대폰 문자메시지 등의 방법으로 제공할 수 있다. 다만, 회원은 정보수신을 원치 않을 경우에는 거부할 수 있다.<br><br>
			  <br>

			  <strong>제4장 계약 당사자의 의무<br>
			  <br>

			  제13조 (도서관의 의무)</strong><br />
				① 도서관은 회원이 희망한 서비스 제공 개시일에 특별한 사정이 없는 한 서비스를 이용할 수 있도록 하여야 한다.<br>
				② 도서관은 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 멸실된 때에는 부득이한 사유가 없는 한 지체 없이 이를 수리 또는 복구해야 한다.<br>
				③ 도서관은 회원이 안전하게 서비스를 이용할 수 있도록 개인정보보호를 위한 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수하여야 한다.<br>
				④ 도서관은 회원으로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 한다. 다만, 즉시 처리가 곤란한 경우는 회원에게 그 사유와 처리일정을 통보하여야 한다.<br>
			  <br>
			  

			  <strong>제14조 (회원의 의무)</strong><br />
				① 회원은 회원가입 신청 또는 회원정보 변경 시 모든 사항을 사실에 근거하여 본인의 정확한 정보로 작성하여야 하며, 허위 또는 타인의 정보를 등록할 경우 이와 관련된 모든 권리를 주장할 수 없다.<br>
				② 회원은 관계 법령, 본 약관의 규정, 이용 안내 및 도서관이 공지한 주의사항, 도서관이 통지하는 사항 등을 준수하여야 한다.<br>
				③ 회원은 본인의 회원ID와 비밀번호를 제3자에게 이용하게 해서는 안 되며, 이용계약사항이 변경된 경우에 해당 절차를 거쳐 이를 도서관에 즉시 알려야 한다.<br>
				④ 회원은 도서관의 명시적 동의가 없는 한 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며 이를 담보로 제공할 수 없다.<br>
				⑤ 회원은 도서관 서비스를 이용하여 얻은 정보를 도서관의 사전승낙 없이 복사, 복제, 변경, 번역, 출판·방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.<br>
				⑥ 회원은 도서관 및 제 3자의 지적 재산권을 포함한 제반 권리를 침해하거나 다음 각 호의 행위를 하여서는 안 됩니다.<br>
				   &nbsp;&nbsp;1. 다른 회원의 ID를 부정 사용하는 행위<br>
				   &nbsp;&nbsp;2. 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위<br>
				   &nbsp;&nbsp;3. 선량한 풍속, 기타 사회질서를 해하는 행위<br>
				   &nbsp;&nbsp;4. 타인의 명예를 훼손하거나 모욕하는 행위<br>
				   &nbsp;&nbsp;5. 타인의 지적재산권 등의 권리를 침해하는 행위<br>
				   &nbsp;&nbsp;6. 해킹행위 또는 컴퓨터바이러스의 유포행위<br>
				   &nbsp;&nbsp;7. 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위<br>
				   &nbsp;&nbsp;8. 서비스의 안전적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위<br>
			  <br>
			  <br>
			  
			  <strong>제5장 손해배상 및 기타<br>
			  <br>
			  제15조 (양도금지)</strong><br />
			  회원은 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없다.<br>
			  <br>
			  
			  <strong>제16조 (손해배상)</strong><br />
			  도서관은 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 이에 대하여 책임을 지지 않는다. 다만, 중대한 과실에 의한 경우에는 그러하지 아니한다.<br>
			  <br>
			  
			  <strong>제17조 (면책조항)</strong><br />
				① 도서관은 천재지변, 전쟁, 기간통신사업자의 서비스 중지 및 기타 이에 준하는 불가항력으로 인하여 서 비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제된다..<br>
				② 도서관은 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제된다..<br>
				③ 도서관은 회원의 컴퓨터 오류 등 회원의 귀책사유로 인한 서비스 이용 장애에 대해서는 책임을 지지 않는다..<br>
				④ 도서관은 회원이 서비스를 이용하여 기대하는 이익이나 서비스를 통해 얻은 자료로 인한 손해는 책임을 지지 않는다. .<br>
				⑤ 도서관은 회원이 서비스에 게재한 각종 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 대하여 책임을 지지 않으며, 회원 상호간 및 회원과 제 3자 상호 간에 서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없고, 이로 인한 손해를 배상할 책임도 없다..<br>
				⑥ 도서관은 회원의 게시물을 등록 전에 사전심사 하거나 상시적으로 게시물의 내용을 확인 또는 검토하여야 할 의무가 없으며, 그 결과에 대한 책임을 지지 않는다.<br>
			  <br>
			  
			  <strong>제18조 (관할법원)</strong><br />
				본 서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 대구지방법원을 관할 법원으로 한다.<br>
			  <br>

			  <br>
			  <strong>&lt;부 칙&gt;</strong> <br>
			  본 약관은 2019년 12월 19일부터 적용한다. </p><br><br>
			</div>
			<div class="agree_codes">
				<input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1"><label for="agree_codes1">통합회원 이용약관에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>

<!--
			<h4>대구광역시 도서관 통합회원 개인정보 수집 ‧ 이용 및 제공 동의</h4>

			<div class="Box" style="height:200px">
				<strong>개인정보 수집·이용 내역</strong><br><br>

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
					<td>구분</td>
					<td colspan="2">항목</td>
					<td>수집목적</td>
					<td>보유기간</td>
					</tr>
				  </thead>
				  <tbody>
					<tr>
					<td rowspan="3">필수</td>
					<td>14세 이상</td>
					<td>아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, 도서회원번호, CI값, 도서대출내역, SMS수신여부, E-mail수신여부</td>
					<td rowspan="2">도서대출 및 반납 등 
					  도서관 서비스</td>
					<td rowspan="4">회원 탈퇴시까지</td>
					</tr>
					<tr>
					<td>14세 미만</td>
					<td>아이디, 비밀번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, 도서회원번호, CI값, 도서대출내역 법정대리인 성명 및 연락처, SMS수신여부, E-mail수신여부</td>
					</tr>
					<tr>
					<td colspan="2">성명, 연락처</td>
					<td>만 14세 미만 신청자 관련 안내</td>
					</tr>
					<tr>
					<td>선택</td>
					<td colspan="2">이메일, 전화번호(자택)</td>
					<td>도서관 서비스 안내</td>
					</tr>
				  </tbody>
				</table>

				<br>
				※ 휴대폰번호는 나이스평가정보에서 인증 받은 휴대폰 번호를 사용 하고 있습니다.
				<br/>
				<br/>
			</div>

			<div class="agree_codes">
				<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2"><label for="agree_codes2">개인정보 수집·이용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>
-->
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
					<td>공동이용 기관</td>
					<td>공동이용 목적</td>
					<td>공동이용 항목</td>
					<td>공동이용 기간</td>
				  </tr>
				  </thead>
				  <tbody>
				  <tr>
					<td>대구광역시 공립 도서관</td>
					<td>하나의 회원번호로 대구광역시 모든 공립 도서관 이용</td>
					<td>아이디, 비밀번호, 도서회원번호, 성명, 생년월일, 성별, 휴대폰번호, 주소, CI값, 도서대출내역, 법정대리인 성명 및 연락처, 이메일, 전화번호(자택), 근무처(학교명), 근무지(학교)연락처, 근무지(학교)주소</td>
					<td>회원<br/>탈퇴시까지</td>
				  </tr>
				  <tr>
					<td colspan="4">개인정보 제3자 제공에 거부할 권리가 있습니다. 다만 동의를 거부 할 경우 책이음서비스 회원가입이 되지 않으며, 도서관에서 제공하는 서비스 이용에 제한이 있을 수 있습니다.</td>
				  </tr>
				  </tbody>
				</table>

				<br/>
			</div>

			<div class="agree_codes">
				<input id="agree_codes3" name="agree_codes" req="0001" type="checkbox" value="2"><label for="agree_codes3">개인정보 공동이용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
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

			<div class="agree_codes">
				<input id="agree_codes4" name="agree_codes" req="0001" type="checkbox" value="3"><label for="agree_codes4">개인정보 제3자 제공에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
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
