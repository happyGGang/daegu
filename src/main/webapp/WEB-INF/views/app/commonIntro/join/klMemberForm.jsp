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
		if ( $('input[name="kl_member_yn"]:checked').length == $('input[name="kl_member_yn"]').length ) {
			doAjaxPost($('#memberAgreeForm'));
		} else {
			<c:if test="${member.langMode ne 'eng'}">
			alert('약관 동의 하지 않았습니다.');
			</c:if>
			<c:if test="${member.langMode eq 'eng'}">
			alert('You must agree to the terms.');
			</c:if>
			$('input#agree_codes3').focus();
		}

	});

	$('#all-agree').change(function() {
		$('input:checkbox').prop('checked', $(this).prop('checked'));
	});

});
</script>

<c:set var="engMode" value="${member.langMode eq 'eng'}"></c:set>
<c:if test="${engMode}">
<style>
.join-step li { margin: 0% 3%;}
</style>
</c:if>
<!--
<div class="join-step" style="position: inherit;">
	<p class="blind">
		<c:if test="${engMode}">Join Process</c:if>
		<c:if test="${!engMode}">회원가입 단계</c:if>
	</p>
	<ul>
		<li class="step2 active"><span>2</span>
			<c:if test="${engMode}"><em style="letter-spacing: 0px;">Consent to users agreement</em></c:if>
			<c:if test="${!engMode}"><em style="letter-spacing: 0px;">책이음 회원전환을 위한 이용약관 및 개인정보 수집&middot;이용 재동의</em></c:if>
		</li>
	</ul>
</div>
-->


<div class="join-wrap" style="padding: 0">
<!--
	<h4 style="padding-top: 25px;">
		<c:if test="${engMode}">
		Guide on integration of public libraries in the Gyeongsangbuk-do Office of Education
		</c:if>
		<c:if test="${!engMode}">
		책이음 회원전환을 위한 이용약관 및 개인정보 수집&middot;이용 재동의 안내
		</c:if>
	</h4>

	<p class="txte" style="padding-bottom: 25px;">
		<c:if test="${engMode}">
		- Member information is integrated and operated through construction of integrated system of public libraries in the Gyeongsangbuk-do Office of Education<br/>
		- In order to use member services, you must give consent to collection and use of personal information below. </b><br/>
		</c:if>
		<c:if test="${!engMode}">
<%-- 		- 회원님의 개인정보 동의 기간은 <b>${sessionScope.member.agree_date_str}</b>입니다. <br/> --%>
<%-- 		- <b>${sessionScope.member.agree_date_str}</b> 이후에는 약관에 의거 <b>개인정보가 삭제</b>됩니다. <br/> --%>
		- 회원서비스를 이용하기 위해서는 <b>아래의 이용약관 및 개인정보수집&middot;이용에 재동의하셔야 합니다.</b><br/>
		</c:if>
	</p>
-->

<form:form modelAttribute="newMember" id="memberAgreeForm" action="klMemberSave.do" method="post">
<form:hidden path="menu_idx"/>
<form:hidden path="langMode"/>

	<h4 style="padding-top: 25px;">
		<c:if test="${engMode}">
		Guide on integration of public libraries in the Gyeongsangbuk-do Office of Education
		</c:if>
		<c:if test="${!engMode}">
		1. 경상북도교육청 공공도서관 책이음서비스 회원관리규정
		</c:if>
	</h4>

	<div class="rules-wrap">

	<br/><h3>제 1 조 (목적)</h3>
	<p class="mB20 mL10">이 규정은 공공도서관 책이음서비스의 원활한 운영을 위하여 책이음 회원 관리에 필요한 세부적인 사항에 대하여 규정함을 목적으로 한다.</p>
	<br/><h3>제 2 조 (정의)</h3>
	<ul class="mB20 mL10">
	  <li>이 규정에서 사용하는 용어의 정의는 다음과 같다. </li>
	  <li>1. "공공도서관 책이음서비스"(이하 "서비스"라 한다)란 서비스에 참여하는 공공도서관에서 전 국민이 하나의 이용증으로 이용할 수 있도록 운영하는 시스템을 말한다.</li>
	  <li>2. "통합센터"란 서비스에 필요한 IT 기반 환경을 구축 운영하고, 서비스를 총괄하는 국립중앙도서관을 말한다. </li>
	  <li>3. "지역센터"란 시․도 지역의 책이음서비스를 총괄하는 지역대표도서관 또는 시․구․군 지역을 대표하는 참여 도서관으로 경상북도교육청정보센터를 말한다.</li>
	  <li>4. "참여 도서관"이란 서비스 지역을 총괄하는 지역센터 역할의 공공도서관과 서비스 이용에 동의하고, 정보를 공유하는 해당 지역의 공공도서관을 말한다.</li>
	  <li>5. "책이음 회원"이란 참여 도서관에 가입한 회원 중에서 서비스 통합회원으로 등록된 자를 의미한다.</li>
	  <li>6. "책이음 이용증"이란 서비스 통합회원에게 발급한 이용증을 말한다.</li>
	</ul>
	<br/><h3>제 3 조 (적용범위) </h3>
	<ul class="mB20 mL10">
	  <li>이 규정은 서비스를 사용하는 참여 도서관 회원 중 책이음 회원에 한정하여 적용한다.</li>
	</ul>
	<br/><h3>제 4 조 (책이음회원 자격)</h3>
	<p class="mB10">본 약관에서 사용하는 용어의 정의는 다음과 같다.</p>
	<ul class="mB20 mL10">
	  <li>① 모든 국민은 참여 도서관의 회원자격 규정에 따라 책이음 회원에 가입할 수 있다.</li>
	  <li>② 외국인의 경우 영주권자 또는 국내에 일정한 주소를 두고 거주하는 자에 한하여 책이음 회원에 가입할 수 있다.</li>
	</ul>
	<br/><h3>제 5 조 (책이음 이용증 및 정보공유)</h3>
	<ul class="mB20 mL10">
	  <li>① 참여 도서관은 회원이 요청할 경우 책이음 회원 등록 및 책이음이용증을 발급해야 하며, 이용증은 "책이음 디자인표준길잡이"를 준용하여 참여도서관에서 제작한다.</li>
	  <li>② 책이음 회원의 인적사항, 대출권수, 연체여부 등 서비스 이용정보는 참여 도서관에서 공유할 수 있다. </li>
	  <li>③ 책이음 회원 정보는 서비스 이용 관련 업무 외에는 사용할 수 없다. </li>
	</ul>
	<br/><h3>제 6 조 (책이음회원 가입) </h3>
	<ul class="mB20 mL10">
	  <li>① 책이음 회원은 참여 도서관에 가입한 회원 중에서 서비스를 이용하기 위해 본인의 개인정보 공유에 동의한 회원으로 실명인증 및 책이음 회원 등록절차를 수행하고, 책이음 이용증을 발급받음으로써 회원 자격을 가진다. </li>
	</ul>
	<br/><h3>제 7 조 (대출의 제한) </h3>
	<ul class="mB20 mL10">
	  <li>다음 각 호에 해당하는 자료 등은 참여 도서관이 정한 규정에 따라 책이음 회원에게 대출을 제한할 수 있다.</li>
	  <li>1. 귀중자료(고서, 희귀본 등)</li>
	  <li>2. 참고자료, 연속간행물(신문, 잡지) 등</li>
	  <li>3. 시청각자료, 마이크로형태자료 등 깨어지거나 잃어버리기 쉬운 자료</li>
	  <li>4. 그 밖에 해당 기관장이 제한할 필요가 있다고 인정하는 자료 </li>
	</ul>
	<br/><h3>제 8 조 (대출 및 반납)</h3>
	<ul class="mB20 mL10">
	  <li>① 대출은 본인에 한하며, 반드시 책이음 이용증을 제시하여야 한다. 단, 어린이 회원(14세 미만)은 보호자가 대신하여 대출할 수 있다.</li>
	  <li>② 지역별 참여 도서관의 대출자료 수는 20권내에서 자유롭게 정할 수 있으며, 1인당 대출자료 수는 최대 20권까지로 한다.</li>
	  <li>③ 대출기간은 대출일을 포함하여 15일간으로 하며, 대출자료 반납일이 휴관일인 경우에는 그 다음날로 한다.</li>
	  <li>④ 대출한 자료의 반납일을 위반할 시에는 연체일수 만큼 대출을 정지하며, 이는 참여도서관 전체에 적용된다.</li>
	</ul>
	<br/><h3>제 9 조 (대여금지) </h3>
	<ul class="mB20 mL10">
	  <li>책이음 회원은 대출받은 자료를 타인에게 대여할 수 없다.</li>
	</ul>
	<br/><h3>제 10 조 (책이음 회원 자격상실) </h3>
	<ul class="mB20 mL10">
	  <li>책이음 회원은 다음 각 호에 해당되는 경우 그 자격이 상실된다.</li>
	  <li>1. 자료의 분실, 훼손을 보상하지 않거나, 장기 연체(1년 이상)에 책임을 지지 않는 자 </li>
	  <li>2. 참여 도서관의 회원가입 시 고의로 사실과 다르게 가입내용을 작성한 경우</li>
	  <li>3. 본인이 책이음 회원 탈퇴를 원할 경우. 단, 제8조제4항에 따른 대출 정지 기간에는 탈퇴할 수 없다.</li>
	  <li>4. 그 밖에 회원관리상 필요하다고 해당 기관장이 인정한 경우</li>
	</ul>
	<br/><h3>제 11 조 (책이음 회원 재가입)</h3>
	<ul class="mB20 mL10">
	  <li>①제11조 1항과 2항에 의거하여 자격상실 사유가 소멸된 책이음 회원에 한해 상실한 날로부터 1년이 경과하거나, 참여 도서관에서 재가입에 대한 승인을 받으면 책이음 회원 자격을 취득할 수 있다.</li>
	  <li>②책이음 회원 자격상실 사유가 책이음 회원 본인의 과실이 아닌 경우에는 즉시 책이음 회원 자격이 주어진다.</li>
	</ul>
	<br/><h3>제 12 조 (책이음 회원 의무)</h3>
	<ul class="mB20 mL10">
	  <li>① 책이음 회원은 개인 인적사항 등에 대하여 변동이 있거나 책이음 이용증을 분실하였을 경우에는 반드시 참여 도서관에 통보하여야 한다.  </li>
	  <li>② 책이음 회원이 책이음 이용증을 부주의하게 관리하거나 타인에게 양도하여 발생하는 모든 책임은 책이음 회원에게 있다.</li>
	</ul>
	<br/><h3>제 13 조 (변상)</h3>
	<ul class="mB20 mL10">
	  <li>① 대출한 자료의 분실 또는 훼손 시에는 책이음 회원이 동일 자료로 변상하여야 한다.</li>
	  <li>② 변상할 동일 자료가 품절 및 절판되어 구하기 어려운 경우에는 해당 자료의 현 시가로 변상하여야 한다. </li>
	</ul>
	<br/><h3>제 14 조 (위임규정)</h3>
	<ul class="mB20 mL10">
	  <li>규정 이외의 책이음 회원 관리에 필요한 사항은 참여 도서관에서 별도로 정할 수 있다. </li>
	</ul>

	<br/><h3>부 칙</h3>
	<p class="mB20 mL10">이 규정은 2018년  8월 1일부터 시행한다.</p>

	</div>

	<div class="agree_codes" style="padding:20px 0 0 0">
		<div class="checkbox center">
<!-- 			<input id="agree_codes2" name="agree_codes5" req="0001" type="checkbox" value="2"> -->
<!-- 			<label for="agree_codes2">개인정보의 수집·이용 동의</label><input type="hidden" name="_agree_codes" value="on"> -->
			<input id="agree_codes3" name="kl_member_yn" type="checkbox" value="Y" style="opacity: inherit;">
			<label for="agree_codes3" style="position: static;">위와 같이 책이음서비스 회원관리규정에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			<br>
		</div>
	</div>



<c:if test="${!engMode}">

<h4 style="padding-top: 40px;">2. 책이음서비스 개인정보 제3자 제공 동의서</h4>
	<div class="Box" style="height:250px;border-radius:5px">
		<h1 style="font-size:20px; font-weight: bold">책이음서비스 개인정보 제3자 제공 동의서</h1><br>
<font size="2">

<p>1. 개인정보를 제공 받는자 </p>
  <ul>
    <li>· 국립중앙도서관, 지역대표도서관, 책이음서비스 참여도서관</li>
  </ul>
<br>

<!--
<p>2. 개인정보 제공 시점</p>
  <ul>
    <li> 가. 국립중앙도서관, 지역대표도서관: 가입도서관에서 개인정보 수집 후 책이음회원(전환) 시</li>
    <li> 나. 참여도서관: 책이음 회원 가입 후 타 참여도서관을 방문하여 이용하려는 경우<br/>※ 개인정보가 제공 된 도서관 현황은 책이음 홈페이지(http://book.nl.go.kr)에서 확인 할 수 있습</li>
  </ul>
<br>
-->
<p>2. 개인정보를 제공받는 자의 개인정보 이용 목적</p>
  <ul>
    <li>· 책이음 서비스 제공을 위한 회원 식별 및 관리, 기타 정보 전달</li>
  </ul>
<br>

<p>3. 제공하는 개인정보의 항목</p>
  <ul>
    <li>· 이름, 생년월일, 성별, 본인확인인증정보, 주소, 휴대전화번호, 집전화번호, 이메일, 직장명, 직장전화번호, 직장주소, 대출회원증번호</li>
  </ul>
<br>

<p>4. 제공받는 자의 보유·이용 기간</p>
  <ul>
    <li>· 회원탈퇴시까지</li>
  </ul>
<br>

<p>5. 개인정보 제3자 제공에 대한 동의를 거부할 권리</p>
  <ul>
    <li>· 개인정보 제3자 제공을 거부할 수 있으며, 미동의 시 책이음 회원가입이 제한됩니다.</li>
  </ul>

<br>

</font>
	</div>
	<div class="agree_codes">
		<div class="checkbox center">
<!-- 			<input id="agree_codes2" name="agree_codes5" req="0001" type="checkbox" value="2"> -->
<!-- 			<label for="agree_codes2">개인정보의 수집·이용 동의</label><input type="hidden" name="_agree_codes" value="on"> -->
			<input id="agree_codes3" name="kl_member_yn" type="checkbox" value="Y" style="opacity: inherit;">
			<label for="agree_codes3" style="position: static;">위와 같이 책이음서비스 이용을 위한 개인정보 제 3자 제공에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			<br>
		</div>
	</div>

</c:if>
</form:form>

	<div class="btn-wrap">
		<a href="#" id="join-btn" class="btn btn1">
			<c:if test="${engMode}">I agree</c:if>
			<c:if test="${!engMode}">동의합니다</c:if>
		</a>
		<a href="/${homepage.context_path}/index.do" class="btn">
			<c:if test="${engMode}">I don't agree</c:if>
			<c:if test="${!engMode}">동의하지 않습니다</c:if>
		</a>
	</div>

</div>

