<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {

	$('a#join-btn').on('click', function(e) {
		e.preventDefault();
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {
			$('#memberAgreeForm').submit();
		}
		else {
			alert('약관 동의 하지 않았습니다.');
		}

	});

	$('a#notAgree').on('click', function(e) {
		e.preventDefault();
		alert('회원가입에는 이용약관 및 개인정보 수집·이용 동의가 필요합니다');
		return false;
	});

	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});

});
</script>
	<p class="blind">
		회원가입 단계
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1" >
					<img alt="" src="/resources/common/img/mem_prcs01.png">
				</td>
				<td class="joinText">
					<span>회원유형확인</span>
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg2">
					<img alt="" src="/resources/common/img/mem_prcs02_on.png">
				</td>
				<td class="active joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg3">
					<img alt="" src="/resources/common/img/mem_prcs03.png">
				</td>
				<td class="joinText">
					본인확인
				</td>
				<td class="joinText">
					<img alt="" src="/resources/common/img/mem_prcs_arrow.png"/>
				</td>
				<td class="joinImg4">
					<img alt="" src="/resources/common/img/mem_prcs04.png">
				</td>
				<td class="joinText">
					정보입력
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
		<ul class="con2">
			<li>경상북도교육청 도서관통합정보시스템 구축으로 도서관통합정보시스템 이용 기관(경상북도교육청 소속 공공도서관, 정보센터, 문화원)의 회원정보가 통합 운영됩니다. 따라서, 회원가입시 도서관 통합정보시스템을 이용하는 기관에 동시 가입됩니다.</li>
			<li>회원서비스를 이용하기 위해서는 아래의 <b>이용약관 및 개인정보수집·이용과 제공에 동의</b>하셔야 합니다</b></li>
		</ul>
	</div>

	<h4>
		경상북도교육청 공공도서관 통합안내
	</h4>

	<p class="txte">
		통합회원이 되시면 하나의 회원정보로 도서관통합정보시스템 이용 기관(경상북도교육청 소속 공공도서관, 정보센터, 문화원)의  홈페이지 서비스 및 자료대출 서비스 등을 이용할 수 있습니다.
	<div class="Box">
		<ul class="lib-list webList">

			<li>경상북도교육청 <br class="test"/>문화원</li>
			<li>경상북도교육청 <br class="test"/>영일도서관</li>
			<li>경상북도교육청 <br class="test"/>영덕도서관</li>

			<li>경상북도교육청 <br class="test"/>구미도서관</li>
			<li>경상북도교육청 <br class="test"/>외동도서관</li>
			<li>경상북도교육청 <br class="test"/>청도도서관</li>

			<li>경상북도교육청 <br class="test"/>안동도서관</li>
			<li>경상북도교육청 <br class="test"/>금호도서관</li>
			<li>경상북도교육청 <br class="test"/>고령도서관</li>

			<li>경상북도교육청 <br class="test"/>안동도서관용상분관</li>
			<li>경상북도교육청 <br class="test"/>점촌도서관</li>
			<li>경상북도교육청 <br class="test"/>성주도서관</li>

			<li>경상북도교육청 <br class="test"/>안동도서관풍산분관</li>
			<li>경상북도교육청 <br class="test"/>점촌도서관가은분관</li>
			<li>경상북도교육청 <br class="test"/>칠곡도서관</li>

			<li>경상북도교육청 <br class="test"/>상주도서관</li>
			<li>경상북도교육청 <br class="test"/>삼국유사군위도서관</li>
			<li>경상북도교육청 <br class="test"/>예천도서관</li>

			<li>경상북도교육청 <br class="test"/>상주도서관화령분관</li>
			<li>경상북도교육청 <br class="test"/>의성도서관</li>
			<li>경상북도교육청 <br class="test"/>봉화도서관</li>

			<li>경상북도교육청 <br class="test"/>영주선비도서관</li>
			<li>경상북도교육청 <br class="test"/>청송도서관</li>
			<li>경상북도교육청 <br class="test"/>울진도서관</li>

			<li>경상북도교육청 <br class="test"/>영주선비도서관풍기분관</li>
			<li>경상북도교육청 <br class="test"/>영양도서관</li>
			<li>경상북도교육청 <br class="test"/>울릉도서관</li>

		</ul>

		<ul class="lib-list mobileList">

			<li>경상북도교육청<br/>문화원</li><li>경상북도교육청<br/>삼국유사군위도서관</li>
			<li>경상북도교육청<br/>구미도서관</li><li>경상북도교육청<br/>의성도서관</li>
			<li>경상북도교육청<br/>안동도서관</li><li>경상북도교육청<br/>청송도서관</li>
			<li>경상북도교육청<br/>안동도서관용상분관</li><li>경상북도교육청<br/>영양도서관</li>
			<li>경상북도교육청<br/>안동도서관풍산분관</li><li>경상북도교육청<br/>영덕도서관</li>
			<li>경상북도교육청<br/>상주도서관</li><li>경상북도교육청<br/>청도도서관</li>
			<li>경상북도교육청<br/>상주도서관화령분관</li><li>경상북도교육청<br/>고령도서관</li>
			<li>경상북도교육청<br/>영주선비도서관</li><li>경상북도교육청<br/>성주도서관</li>
			<li>경상북도교육청<br/>영주선비도서관풍기분관</li><li>경상북도교육청<br/>칠곡도서관</li>
			<li>경상북도교육청<br/>영일도서관</li><li>경상북도교육청<br/>예천도서관</li>
			<li>경상북도교육청<br/>외동도서관</li><li>경상북도교육청<br/>봉화도서관</li>
			<li>경상북도교육청<br/>금호도서관</li><li>경상북도교육청<br/>울진도서관</li>
			<li>경상북도교육청<br/>점촌도서관</li><li>경상북도교육청<br/>울릉도서관</li>
			<li>경상북도교육청<br/>점촌도서관가은분관</li>

		</ul>
	</div>

<form:form modelAttribute="newMember" id="memberAgreeForm" action="step3.do" method="post">
<form:hidden path="ageType"/>
<form:hidden path="menu_idx"/>

	<h4>이용약관 동의</h4>
	<div class="Box" style="height:200px" tabindex="0" >
<font size="2">
<h4>이용약관 동의</h4>
<br/><h6>제 1 조 (목적)</h6>


<p class="mB20 mL10">본 약관은
<c:choose>
	<c:when test="${homepage.context_path eq 'geic'}">
	경상북도교육청정보센터
	</c:when>
	<c:when test="${homepage.context_path eq 'gm'}">
	경상북도교육청 구미도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ad'}">
	경상북도교육청 안동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'adys'}">
	경상북도교육청 안동도서관용상분관
	</c:when>
	<c:when test="${homepage.context_path eq 'adps'}">
	경상북도교육청 안동도서관풍산분관
	</c:when>
	<c:when test="${homepage.context_path eq 'sj'}">
	경상북도교육청 상주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjhr'}">
	경상북도교육청 상주도서관화령분관
	</c:when>
	<c:when test="${homepage.context_path eq 'yj'}">
	경상북도교육청 영주선비도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yjpg'}">
	경상북도교육청 영주선비도서관풍기분관
	</c:when>
	<c:when test="${homepage.context_path eq 'gbccs'}">
	경상북도교육청문화원
	</c:when>
	<c:when test="${homepage.context_path eq 'yd'}">
	경상북도교육청 영덕도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjl'}">
	경상북도교육청 성주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yy'}">
	경상북도교육청 영양도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'us'}">
	경상북도교육청 의성도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'uj'}">
	경상북도교육청 울진도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ul'}">
	경상북도교육청 울릉도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gw'}">
	경상북도교육청 삼국유사군위도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cd'}">
	경상북도교육청 청도도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cg'}">
	경상북도교육청 칠곡도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'od'}">
	경상북도교육청 외동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cs'}">
	경상북도교육청 청송도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yc'}">
	경상북도교육청 예천도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gr'}">
	경상북도교육청 고령도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'jc'}">
	경상북도교육청 점촌도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yi'}">
	경상북도교육청 영일도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'bh'}">
	경상북도교육청 봉화도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ycgh'}">
	경상북도교육청 금호도서관
	</c:when>
	<c:otherwise>
	경상북도교육청 통합도서관
	</c:otherwise>
</c:choose>
(이하 "당 사이트"라 함)가 제공하는 모든 서비스의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 기본적인 사항을 정함을 목적으로 한다.</p>
<br/><h6>제 2 조 (이용약관의 효력 및 변경)</h6>
<ul class="mB20 mL10">
  <li>① 본 약관은 당 사이트에 게시하여 공시함으로써 효력을 발생한다.</li>
  <li>② 당 사이트는 합리적인 사유가 발생할 경우에 이 약관을 변경할 수 있으며, 약관을 변경한 경우에는 지체 없이 이를 공시한다. </li>
  <li>③ 당 사이트에서 제공하는 모든 서비스가 무료서비스이며 회원 혹은 일반이용자는 변경된 약관에 동의하지 않으면 서비스 이용을 중단하고 이용계약을 해지할 수 있다. 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주한다.</li>
</ul>
<br/><h6>제 3 조 (약관의 적용)</h6>
<ul class="mB20 mL10">
  <li>① 이 약관은 정보센터가 제공하는 개별서비스에 관한 이용안내와 함께 적용한다.</li>
  <li>② 이 약관에 명시되지 아니한 사항에 대해서는 정보통신 관계법령 및 서비스별 안내의 취지에 따라 적용할 수 있다.</li>
</ul>
<br/><h6>제 4 조 (용어의 정의)</h6>
<p class="mB10">본 약관에서 사용하는 용어의 정의는 다음과 같다.</p>
<ul class="mB20 mL10">
  <li>1. 회원 : 본 약관에 동의하고 필요한 개인정보를 제공하여 회원등록을 한 자로서, 당 사이트의 정보 및 서비스를 이용할 수 있는 자</li>
  <li>2. 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 받는 자</li>
  <li>3. 이용계약 : 서비스 이용과 관련하여 당 사이트와 이용자 간에 체결하는 계약</li>
  <li>4. 회원ID : 회원의 식별과 회원의 서비스 이용을 위하여 이용자가 선정하고 당 사이트가 부여하는 문자와 숫자의 조합</li>
  <li>5. 비밀번호 : 회원이 부여 받은 회원ID와 일치된 회원임을 확인하고 회원의 권익보호를 위하여 회원이 선정한 문자와 숫자의 조합</li>
  <li>6. 본 약관에서 정의하지 않은 용어는 관계법령 및 서비스별 안내에서 정하는 바에 의한다.</li>
</ul>
<h2 class="center">제 2 장 이용계약의 성립 및 해지</h2>
<br/><h6>제 5 조 (이용 계약의 성립)</h6>
<ul class="mB20 mL10">
  <li>① 이용계약은 이용자가 본 이용약관 내용에 대한 동의와 가입신청 서식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립된다.</li>
  <li>② 본 이용약관에 대한 동의는 이용신청 당시 당 사이트의 약관에 ‘동의함' 버튼을 누름으로써 의사표시를 한다.</li>
</ul>
<br/><h6>제 6 조 (회원가입 및 탈퇴)</h6>
<ul class="mB20 mL10">
  <li>① 회원가입자격</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 대한민국 국민</li>
      <li>2. 만14세 미만 아동 중 법정대리인의 승낙을 득한 자</li>
    </ul>
  </li>
  <li>② 회원가입은 신청자가 온라인으로 당 사이트에서 제공하는 소정의 가입신청 서식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립된다.</li>
  <li>③ 당 사이트는 다음 각 호에 해당하는 경우에 가입을 취소할 수 있다. </li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 타인의 주민등록번호 또는 정보로 가입한 경우</li>
      <li>2. 회원가입 신청서의 내용을 허위로 기재하였거나 허위서류를 첨부하여 신청하였을 경우</li>
      <li>3. 사회의 안보, 질서 또는 미풍양속을 저해할 목적으로 신청하였거나 그러한 행위를 하였을 경우</li>
      <li>4. 다른 이용자의 당 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 경우</li>
      <li>5. 당 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우</li>
      <li>6. 회원으로서의 부적절한 행위를 할 우려가 있다고 인정되는 경우</li>
      <li>7. 기타 당 사이트가 정한 회원가입요건이 미비할 경우</li>
    </ul>
  </li>
  <li>④ 당 사이트는 다음 각 항에 해당하는 경우 그 사유가 해소될 때까지 이용계약 성립을 유보할 수 있다.</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 서비스 관련 제반 용량이 부족한 경우</li>
      <li>2. 기술상 장애 사유가 있는 경우</li>
      <li>3. 기타 당 사이트가 필요하다고 인정한 경우</li>
      <li>4. 기존 회원의 서비스 이용에 장애가 되는 경우</li>
    </ul>
  </li>
  <li>⑤ 회원은 당 사이트에서 제공하는 서비스를 제공받을 의사가 없는 경우 언제든지 회원탈퇴(해지)를 할 수 있다.</li>
  <li>⑥ 회원은 2년을 주기로 재동의 절차를 거치지 않은 경우 회원의 자격을 상실할 수 있다.</li>
</ul>
<br/><h6>제 7 조 (회원ID 부여 및 변경 등)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 회원에 대하여 약관에 정하는 바에 따라 회원ID를 부여한다.</li>
  <li>② 회원ID는 원칙적으로 변경이 불가하며, 부득이한 사유로 인하여 변경 하고자 하는 경우에는 해당 회원ID를 해지하고 재가입해야 한다.</li>
  <li>③ 회원ID는 다음 각 호에 해당하는 경우에는 이용자 또는 정보센터의 요청으로 변경할 수 있다.</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 회원ID가 이용자의 전화번호 또는 주민등록번호 등으로 등록되어 사생활침해가 우려되는 경우</li>
      <li>2. 타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우</li>
      <li>3. 한글 ID, 대문자 사용 ID, 첫 글자가 영소문자가 아닌 ID, 특수문자 포함 ID, 5글자미만, 15글자 초과 ID</li>
      <li>4. 기타 합리적인 사유가 있는 경우</li>
    </ul>
  </li>
  <li>④ 회원ID 및 비밀번호의 관리책임은 이용자에게 있다. 관리소홀로 인하여 발생하는 서비스 이용 상의 손해 또는 제3자에 의한 부정이용 등에 대한 책임은 이용자에게 있으며, 당 사이트는 그에 대한 책임을 일체 지지 않는다.</li>
  <li>⑤ 기타 이용자 개인정보 관리 및 변경 등에 관한 사항은 당 사이트가 정하는 바에 의한다.</li>
</ul>
<br/><h6>제 8 조 (회원정보 사용에 대한 동의)</h6>
<ul class="mB20 mL10">
  <li>① 회원의 개인정보에 대해서는 당 사이트의 개인정보보호정책이 적용된다. </li>
  <li>② 당 사이트의 회원 정보는 다음과 같이 수집, 사용, 관리, 보호된다. </li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 개인정보의 수집 : 당 사이트 서비스 가입 시 이용자가 제공하는 정보를 통하여 회원의 정보를 수집한다.</li>
      <li>
        <ul class="mB20 mL20">
          <li>- 필수항목 : 이름, 집주소, 휴대폰 번호, 생년월일, 아이디, 비밀번호, 성별, 본인확인코드, 소속도서관<br/>
 ※휴대폰 번호(나이스평가정보에서 인증 받은 휴대폰 번호)</li>
          <li>- 선택항목 : 집전화번호, 이메일</li>
        </ul>
      </li>
      <li>2. 개인정보의 사용 : 당 사이트는 당 사이트 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않는다. 단, 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우, 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 이용자가 당 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그렇지 않다.</li>
      <li>3. 개인정보의 관리 : 회원은 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 회원의 개인정보를 수정/삭제할 수 있다. 수신되는 정보 중 불필요하다고 생각되는 부분도 변경/조정할 수 있다.</li>
      <li>4. 개인정보의 보호 : 회원의 개인정보는 오직 본인만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 회원ID와 비밀번호에 의해 관리되고 있다. 따라서 타인에게 회원ID와 비밀번호를 알려주어서는 안 되며, 작업 종료 시에는 반드시 로그아웃 하고, 웹 브라우저의 창을 닫아야 한다.</li>
      <li>5. 서비스 이용과정에서 자동 생성되어 수집되는 정보</li>
      <li>
        <ul class="mB20 mL20">
          <li>- IP 주소, 쿠키, 방문 일시, 서비스 이용 기록</li>
        </ul>
      </li>
    </ul>
  </li>
  <li>③ 회원이 당 사이트의 본 약관에 따라 이용신청을 하는 것은 당 사이트가 본 약관에 따라 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주한다.</li>
</ul>
<br/><h6>제 9 조 (사용자의 정보 보안)</h6>
<ul class="mB20 mL10">
  <li>① 가입 신청자가 당 사이트 서비스 가입 절차를 완료하는 순간부터 가입 신청자는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있다.</li>
  <li>② 회원ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있으며, 회원ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 당 사이트에 신고하여야 한다. 신고를 하지 않음으로 인해 발생하는 모든 책임은 회원 본인에게 있다. </li>
  <li>③ 이용자는 당 사이트 서비스의 사용 종료 시마다 정확히 로그아웃(Log-out)해야 하며, 로그아웃하지 아니하여 제3자가 회원에 관한 정보를 도용하는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 당 사이트는 책임지지 않는다.</li>
</ul>
<h2 class="center">제 3 장 서비스의 이용</h2>
<br/><h6>제 10 조 (서비스 이용시간)</h6>
<ul class="mB20 mL10">
  <li>① 서비스 이용시간은 당 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 한다. </li>
  <li>② 제1항의 이용시간 중 정기점검 등의 필요로 인하여 당 사이트가 정한 날 또는 시간은 예외로 한다. </li>
</ul>
<br/><h6>제 11 조 (서비스의 중지 및 중지에 대한 공지)</h6>
<ul class="mB20 mL10">
  <li>① 회원은 당 사이트 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 당 사이트의 관리 범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 당 사이트는 관련 책임을 지지 않는다.</li>
  <li>② 당 사이트가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일 전에 홈페이지에 서비스 중지사유 및 일시를 공지한 후 서비스를 중지할 수 있으며, 이 기간 동안 이용자가 공지내용을 인지하지 못한 데 대하여 당 사이트는 책임을 지지 않는다. 부득이한 사정이 있을 경우 위 사전 공지기간은 감축되거나 생략될 수 있다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 당 사이트는 책임을 지지 않는다.</li>
  <li>③ 당 사이트의 사정으로 서비스를 영구적으로 중단하여야 할 경우에는 제 2 항에 의거한다. 다만, 이 경우 사전 공지기간은 1개월로 한다. </li>
  <li>④ 당 사이트는 사전 공지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 귀하 또는 제3자에게 어떠한 책임도 지지 않는다.</li>
  <li>⑤ 당 사이트는 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고 없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 당 사이트가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있다.</li>
  <li>⑥ 당 사이트는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있다. 다만 이 경우 그 사유 및 기간 등을 이용자에게 사전 또는 사후에 공지한다.</li>
  <li>⑦ 당 사이트는 당 사이트가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의·과실 없는 디스크장애, 시스템다운 등)에 사전통지가 불가능하며, 타인(통신회선제공사업자 등)의 고의·과실로 인한 시스템중단 등의 경우에는 통지하지 않는다.</li>
  <li>⑧ 당 사이트는 서비스를 특정범위로 분할하여 각 범위별로 이용가능시간을 별도로 지정할 수 있다.</li>
  <li>⑨ 당 사이트는 회원이 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지하거나 회원의 동의 없이 이용계약을 해지할 수 있다.  이 경우 당 사이트는 위 이용자의 접속을 금지할 수 있다. </li>
</ul>
<br/><h6>제 12 조 (정보 제공 및 홍보물 게재)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 서비스를 운영함에 있어서 각종 정보를 홈페이지에 게재하는 방법, 전자우편이나 서신우편 발송, 필요하다고 인정되는 다양한 정보를 제공할 수 있다. </li>
  <li>② 당 사이트는 서비스에 적절하다고 판단되거나 공익성이 있는 홍보물을 게재할 수 있다.</li>
</ul>
<br/><h6>제 13 조 (당 사이트 게시물의 관리,운영)</h6>
<ul class="mB20 mL10">
  <li>① 회원이 게시한 게시물의 내용에 대한 권리는 회원에게 있다.</li>
  <li>② 당 사이트는 게시된 내용을 사전 통지 없이 편집, 이동할 수 있는 권리를 보유하며, 다음의 경우 사전 통지 없이 삭제할 수 있다.</li>
  <li>
    <ul class="mB20 mL20">
      <li>1. 본 서비스 약관에 위배되거나 상용 또는 불법, 음란, 저속하다고 판단되는 게시물을 게시한 경우</li>
      <li>2. 다른 회원 또는 제 3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우</li>
      <li>3. 공공질서 및 미풍양속에 위반되는 내용인 경우</li>
      <li>4. 범죄적 행위에 결부된다고 인정되는 내용일 경우</li>
      <li>5. 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
      <li>6. 기타 관계 법령에 위배되는 경우.</li>
    </ul>
  </li>
  <li>③ 회원의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 회원이 부담해야 한다.</li>
</ul>
<br/><h6>제 14 조 (서비스 이용제한)</h6>
<ul class="mB20 mL10">
  <li>① 회원이 제공하는 정보의 내용이 허위인 것으로 판명되거나, 허위가 있다고 의심할 만한 합리적인 사유가 발생할 경우 당 사이트는 회원의 본 서비스 사용을 일부 또는 전부 중지할 수 있으며, 이로 인해 발생하는 불이익에 대해 책임을 지지 아니한다. </li>
  <li>② 당 사이트는 회원이 본 약관 제16조(회원의 의무)등 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있다. 이 경우 당 사이트는 귀하의 접속을 금지할 수 있다.</li>
</ul>
<h2 class="center">제 4 장 의무 및 책임</h2>
<br/><h6>제 15 조 (당 사이트의 의무)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 지속적 안정적으로 서비스를 제공하기 위해 노력할 의무가 있다.</li>
  <li>② 당 사이트는 회원의 개인신상정보를 본인의 승낙 없이 타인에게 누설, 배포하지 않는다. 다만, 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그렇지 않다.</li>
  <li>③ 당 사이트는 이용자의 귀책사유로 인한 서비스 이용 장애에 대하여 책임을 지지 않는다. </li>
</ul>
<br/><h6>제 16 조 (회원의 의무)</h6>
<ul class="mB05 mL10">
  <li>① 회원 가입시에 요구되는 정보는 정확하게 기입해야 한다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 회원ID 및 비밀번호를 제3자가 이용하게 해서는 안된다.</li>
  <li>② 회원은 당 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없다. </li>
  <li>③ 회원은 당 사이트 서비스를 이용하여 얻은 정보를 당 사이트의 사전승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다. </li>
  <li>④ 회원은 당 사이트 서비스 이용과 관련하여 다음 각 호의 행위를 하여서는 안 된다. </li>
</ul>
<ul class="mB20 mL20">
  <li>1. 다른 회원의 회원ID와 비밀번호를 도용하여 부정 사용하는 행위</li>
  <li>2. 저속, 음란, 모욕적, 위협적이거나 타인의 사생활을 침해할 수 있는 내용을 전송, 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>3. 서비스를 통하여 전송된 내용의 출처를 위장하는 행위</li>
  <li>4. 법률, 계약에 의해 이용할 수 없는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>5. 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>6. 당 사이트의 승인을 받지 아니한 광고, 판촉물, 스팸메일, 행운의 편지, 피라미드 조직 기타 다른 형태의 권유를 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위</li>
  <li>7. 다른 사용자의 개인정보를 수집 또는 저장하는 행위</li>
  <li>8. 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위</li>
  <li>9. 선량한 풍속, 기타 사회질서를 해하는 행위</li>
  <li>10. 타인의 명예를 훼손하거나 모욕하는 행위</li>
  <li>11. 타인의 지적재산권 등의 권리를 침해하는 행위</li>
  <li>12. 해킹행위 또는 컴퓨터바이러스의 유포행위</li>
  <li>13. 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위</li>
  <li>14. 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위</li>
  <li>15. 당 사이트에 게시된 정보의 변경</li>
  <li>16. 기타 관계법령에 위배되는 행위</li>
</ul>
<h2 class="center">제 5 장 기 타</h2>
<br/><h6>제 17 조 (당 사이트의 소유권)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는 당 사이트에 소유권이 있다.</li>
  <li>② 이용자는 당 사이트가 명시적으로 승인한 경우를 제외하고는 전항의 소정의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권 설정 행위, 상업적 이용행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없다.</li>
</ul>
<br/><h6>제 18 조 (양도금지)</h6>
<p class="mB20 mL10">회원이 서비스의 이용권한, 기타 이용계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없다.</p>
<br/><h6>제 19 조 (손해배상)</h6>
<p class="mB20 mL10">당 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 당 사이트가 고의로 행한 범죄행위를 제외하고는 이에 대하여 책임을 부담하지 않는다.</p>
<br/><h6>제 20 조 (면책조항)</h6>
<ul class="mB20 mL10">
  <li>① 당 사이트는 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제된다.</li>
  <li>② 당 사이트는 통신회선제공사업자가 인터넷 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제된다.</li>
  <li>③ 당 사이트는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제된다.</li>
  <li>④ 당 사이트는 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않는다.</li>
  <li>⑤ 당 사이트는 서비스에 표출된 어떠한 의견이나 정보에 대해 확신이나 대표할 의무가 없으며 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않는다. 당 사이트는 어떠한 경우라도 귀하가 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없다. </li>
  <li>⑥ 당 사이트는 회원 간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 지지 않고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 지지 않는다. </li>
  <li>⑦ 당 사이트는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도 등의 내용에 관하여는 책임을 지지 않는다.</li>
  <li>⑧ 당 사이트는 서비스 이용과 관련하여 귀하에게 발생한 손해 중 귀하의 고의, 과실에 의한 손해에 대하여 책임을 지지 않는다. </li>
  <li>⑨ 당 사이트는 당 사이트가 제공한 서비스가 아닌 가입자 또는 기타 유관기관이 제공하는 서비스의 내용상의 정확성, 완전성 및 질에 대하여 보장하지 않는다. 따라서 당 사이트는 이용자가 위의 내용을 이용함으로  인하여 입게 된 모든 종류의 손실이나 손해에 대하여 책임을 지지 않는다. 또한 당 사이트는 이용자가 서비스를 이용하며 타 이용자로 인해 입게 되는 정신적 피해에 대하여 보상할 책임을 지지 않는다.</li>
</ul>
<br/><h6>제 21 조 (관할법원)</h6>
<p class="mB20 mL10">본 서비스 이용과 관련하여 발생한 분쟁에 대해 소송이 제기될 경우 대구지방법원을 관할 법원으로 한다.</p>
<br/><h6>부 칙</h6>
<p class="mB20 mL10">① (시행일) 이 약관은 2005년 3월 14일부터 시행한다.</p>
<br/><h6>부 칙</h6>
<p class="mB20 mL10"> ① (시행일) 이 약관은 2009년 3월 13일부터 시행한다.</p>
<p class="mB10 mL10">* 본 약관에 대한 저작권은
<c:choose>
	<c:when test="${homepage.context_path eq 'geic'}">
	경상북도교육청정보센터
	</c:when>
	<c:when test="${homepage.context_path eq 'gm'}">
	경상북도교육청 구미도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ad'}">
	경상북도교육청 안동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'adys'}">
	경상북도교육청 안동도서관용상분관
	</c:when>
	<c:when test="${homepage.context_path eq 'adps'}">
	경상북도교육청 안동도서관풍산분관
	</c:when>
	<c:when test="${homepage.context_path eq 'sj'}">
	경상북도교육청 상주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjhr'}">
	경상북도교육청 상주도서관화령분관
	</c:when>
	<c:when test="${homepage.context_path eq 'yj'}">
	경상북도교육청 영주선비도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yjpg'}">
	경상북도교육청 영주선비도서관풍기분관
	</c:when>
	<c:when test="${homepage.context_path eq 'gbccs'}">
	경상북도교육청문화원
	</c:when>
	<c:when test="${homepage.context_path eq 'yd'}">
	경상북도교육청 영덕도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'sjl'}">
	경상북도교육청 성주도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yy'}">
	경상북도교육청 영양도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'us'}">
	경상북도교육청 의성도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'uj'}">
	경상북도교육청 울진도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ul'}">
	경상북도교육청 울릉도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gw'}">
	경상북도교육청 삼국유사군위도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cd'}">
	경상북도교육청 청도도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cg'}">
	경상북도교육청 칠곡도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'od'}">
	경상북도교육청 외동도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'cs'}">
	경상북도교육청 청송도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yc'}">
	경상북도교육청 예천도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'gr'}">
	경상북도교육청 고령도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'jc'}">
	경상북도교육청 점촌도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'yi'}">
	경상북도교육청 영일도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'bh'}">
	경상북도교육청 봉화도서관
	</c:when>
	<c:when test="${homepage.context_path eq 'ycgh'}">
	경상북도교육청 금호도서관
	</c:when>
	<c:otherwise>
	경상북도교육청 통합도서관
	</c:otherwise>
</c:choose>
에 귀속되며 무단복제, 배포, 전송, 기타 저작권 침해행위를 엄금한다.</p>


</font>
	</div>
	<div class="agree_codes">
		<div class="checkbox">
			<input id="agree_codes1" name="agree_codes" req="0001" type="checkbox" value="1" style="opacity: inherit;" ><label style="position: static !important;" for="agree_codes1">이용약관 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>

	<h4>개인정보의 수집·이용 동의</h4>
	<div class="Box" style="height:200px" tabindex="0" >

<font size="2">
<h5>1.개인정보의 수집·이용 목적</h5>
<p>&nbsp;&nbsp;&nbsp;· 경상북도교육청 통합도서관 홈페이지의 회원제 서비스 운영</p>
<p>&nbsp;&nbsp;&nbsp;· 자료대출 서비스 제공</p>
<br>

<h5>2.수집하는 개인정보 항목</h5>
<p>&nbsp;&nbsp;&nbsp;가. 정보주체<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 필수: 아이디, 비밀번호, 이름, 생년월일, 성별, 본인확인인증정보, 소속도서관, 휴대전화번호, 주소<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 선택: 집전화번호, 이메일, 대출회원증번호, 대출회원증비밀번호, 직장명, 직장연락처, 직장주소
</p>
<p>&nbsp;&nbsp;&nbsp;나. 법정대리인<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 필수: 이름, 연락처, 본인확인인증정보<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp· 선택: 없음
</p>
<br>
<h5>3.개인정보의 보유 및 이용 기간</h5>
<p>&nbsp;&nbsp;&nbsp;· 회원탈퇴시까지(2년 주기 재동의)</p>
<br>

<h5>4.개인정보 수집·이용에 대한 동의를 거부할 권리</h5>
<p>&nbsp;&nbsp;&nbsp;· 개인정보 수집‧이용을 거부할 수 있으며, 미동의 시 도서관통합정보시스템 회원가입이 제한됩니다.</p>
<!--<p>이용자는 개인정보 수집·이용에 동의하지 않으실 수 있습니다. 다만, 필수항목 제공의 동의 거부 시 회원가입이 불가능하며, 선택항목 거부 시 서비스가 일부 제한 될 수 있습니다.</p>-->
</font>
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="agree_codes2" name="agree_codes" req="0001" type="checkbox" value="2" style="opacity: inherit;"><label  style="position: static !important;" for="agree_codes2">개인정보의 수집·이용 동의</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>

</form:form>

	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">
			동의합니다
		</a>
		<a href="#" id="notAgree" class="btn">
			동의하지 않습니다
		</a>
	</div>

</div>

