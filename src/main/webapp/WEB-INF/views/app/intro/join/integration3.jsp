<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>

<script type="text/javascript">
$(function() {
	$('th.th1').css('width', '30%');
	$('th.th1').css('text-align', 'right');

	$('a.certtype').on('click', function(e) {
		e.preventDefault();
		var parent = $(this).parent('div').find('p.success').length;
		if (parent > 0) { return false; }
		var wWidth = 360;
 		var wHight = 120;
 		var wX = (window.screen.width - wWidth) / 2;
 		var wY = (window.screen.height - wHight) / 2;
		var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
		$('form#certForm input[name=certType]').val($(this).attr('id'));
		$('form#certForm')[0].submit();
		certWindow.focus();
	});

	<c:if test="${empty integrationMember or empty integrationMember.INTEGRATION_ORDER or integrationMember.INTEGRATION_ORDER eq 0}">
	alert('잘못된 경로로 접근하였습니다.');
	location.href = '/intro/${homepage.context_path}/login/logout.do';
	</c:if>
});
</script>

<p class="blind">회원가입 단계</p>
<table class="joinNoline">
	<tbody>
		<tr>
			<td class="joinImg1 center">
				<div class="en">STEP 01</div>
				<div class="ko">회원유형</div>
			</td>

			<td class="joinImg2 center">
				<div class="en">STEP 02</div>
				<div class="ko">이용약관동의</div>
			</td>

			<td class="joinImg3 center active">
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
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="join-wrap">
<c:if test="${param.ageType eq 'under'}">
<c:set var="parentNameTag" value="보호자 "></c:set>
<c:set var="childNameTag" value="14세미만 "></c:set>
</c:if>
	<div class="info">
   	 &nbsp; <b>I-PIN 신규발급 [<a href="http://www.vno.co.kr/ipin3/personal/personal01_01.asp" target="_blank">신규발급바로가기</a>]</b>
	</div>
	<form id="loginForm" action="/intro/${homepage.context_path}/login/index.do">
	</form>
	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="mode" value="integration">
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
		<input type="hidden" name="auth_homepage_type" value="2">
	</form>
	<form:form id="memberInfo" modelAttribute="newMember" action="integration4.do">
		<form:hidden path="editMode"/>
		<form:hidden path="certType"/>

		<div id="parentCert" class="identi_select" style="display:none;">
			<table class="center joinSelect">
				<colgroup>
					<col width="50%"/>
					<col width="50%"/>
				</colgroup>
				<tr>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy1.jpg" alt="휴대폰 본인인증"  class="joinAdult"/>
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">보호자<br/>휴대폰 본인인증</div>
								<div class="joinText2">본인 명의의 휴대폰으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="parentSms">인증하기</a></div>
							</div>
						</div>
					</td>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy2.jpg" alt="아이핀 본인인증" class="joinChild">
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">보호자<br/>I-PIN(아이핀)인증</div>
								<div class="joinText2">발급받은 아이핀(I-PIN)으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="parentGpin">인증하기</a></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<table id="parentTable" class="editTbl" style="margin-bottom:50px; display:none;">
			<tbody>
				<tr>
					<th>
						보호자(법정대리인) 본인인증
					</th>
					<td id="parentCert">
						* 본인인증방법을 선택해 주세요.
					</td>
				</tr>
				<tr>
					<th>
						보호자(법정대리인) 확인
					</th>
					<td id="parentName">
						<input type="text" class="text" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<th>
						보호자(법정대리인) 동의
					</th>
					<td>
						<input type="checkbox" id="parentagree" style="vertical-align: middle; cursor: pointer;"/>
						<label for="parentagree" style="cursor: pointer;"><strong>14세미만 어린이/아동회원의 보호자(법정대리인)임을 확인합니다.</strong></label>
					</td>
				</tr>
			</tbody>
		</table>

		<div id="memberCert" class="identi_select">
			<table class="center joinSelect">
				<colgroup>
					<col width="50%"/>
					<col width="50%"/>
				</colgroup>
				<tr>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy1.jpg" alt="휴대폰 본인인증"  class="joinAdult"/>
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">휴대폰 본인인증</div>
								<div class="joinText2">본인 명의의 휴대폰으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="certSms">인증하기</a></div>
							</div>
						</div>
					</td>
					<td class="yearSelect">
						<div class="yearSelectAlign">
							<div class="joinImages">
								<img src="/resources/common/img/identy2.jpg" alt="아이핀 본인인증" class="joinChild">
							</div>
							<div class="joinBtnTxt">
								<div class="joinText1">I-PIN(아이핀)인증</div>
								<div class="joinText2">발급받은 아이핀(I-PIN)으로 본인여부를 확인합니다.</div>
								<div><a href="#" class="certtype btn btn01" id="certGpin">인증하기</a></div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

	</form:form>
	<br/>
</div>
