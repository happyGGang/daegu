<%@ page language="java" pageEncoding="utf-8" %>

<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();

		var certCheck = true;

		if ($('input#certType').val() == '' ) {
			var certCheck = false;
		}

		if (!certCheck) {
			alert('본인 인증 후 가입 가능합니다.');
			return false;
		}

		if (!idCheck) {
			alert('아이디 중복확인 후 가능합니다.');
			$('#memberJoinForm #member_id').focus();
			return false;
		}

		if (!pwCheck2) {
			alert('비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력하셔야 합니다.');
			return false;
		}
		if (!pwCheck) {
			alert('비밀번호 확인 후 가능 합니다.');
			return false;
		}

		doAjaxPost($('#memberJoinForm'));
	});

	$('a#check-btn').on('click', function(e) {
		e.preventDefault();
		var id = $('#memberJoinForm #member_id').val();
		var reg = /[a-zA-Z0-9]/g;
		var spe = reg.test(id);
		if (!spe) {
			alert('아이디는 영문 또는 숫자만 입력가능합니다.');
			return false;
		}
		$('#checkForm #member_id').val($('#memberJoinForm #member_id').val());
		if ( doAjaxPost($('#checkForm')) ) {
			idCheck = true;
		}
	});

	$('select#email2_temp').on('change', function() {
		$('input#email2').val($(this).val());
		if ($(this).val() == '') {
			$('input#email2').focus();
		}
	});

	$('input#member_id').on('keyup', function(e) {
		e.preventDefault();
		idCheck = false;
	});
	$('input#member_id').on('change', function(e) {
		e.preventDefault();
		idCheck = false;
	});

	$('input#zipcode').on('click', function(e) {
		e.preventDefault();
		$('a#findPostCode').click();
	});

	$('a#findPostCode').on('click', function(e){
		e.preventDefault();
		new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                    fullAddr = data.roadAddress;
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                $('#zipcode').val(data.zonecode);//5자리 새우편번호 사용
                $('#address1').val(fullAddr);
                $('#address2').focus();
            }
        }).open();
	});

	<%-- 패스워드 일치 --%>
	$('input#member_pw_confirm').on('keyup', function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#member_pw').val() == $('#member_pw_confirm').val() ) {
					pwCheck = true;
					$('#pw_confirm_message').text('일치합니다.');
				} else {
					pwCheck = false;
					$('#pw_confirm_message').text('일치하지 않습니다.');
				}
			} else {
				pwCheck = false;
				$('#pw_confirm_message').text('');
			}
		}
	});
	$('input#member_pw').blur(function(e) {
		e.preventDefault();
		var pwdcheck = false;
		var pw = $(this).val();
		var passwordRules = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d$!@#$%^&*]{9,20}$/;
		if(!passwordRules.test(pw)){
			$('span#pwdcheck').css('color', 'red');
			return false;
		}
		$('#member_pw_confirm').val('');
		$('#pw_confirm_message').text('');
		$('span#pwdcheck').css('color', 'black');
		pwCheck = false;
		pwCheck2 = true;
		return true;

	});

	$('th.th1').css('width', '20%');
	$('th.th1').css('text-align', 'left');

});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});
</script>
	<p class="blind">
		회원가입 단계
	</p>
	<table class="joinNoline">
		<tbody>
			<tr>
				<td class="joinImg1">
					<img src="/resources/common/img/mem_prcs01.png" alt="" >
				</td>
				<td class="joinText">
					회원유형확인
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt="" />
				</td>
				<td class="joinImg2">
					<img src="/resources/common/img/mem_prcs02.png" alt="">
				</td>
				<td class="joinText">
					이용약관동의
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt="" />
				</td>
				<td class="joinImg3">
					<img src="/resources/common/img/mem_prcs03.png" alt="" >
				</td>
				<td class="joinText">
					본인확인
				</td>
				<td class="joinText">
					<img src="/resources/common/img/mem_prcs_arrow.png" alt="" />
				</td>
				<td class="joinImg4">
					<img src="/resources/common/img/mem_prcs04_on.png" alt="" >
				</td>
				<td class="active joinText">
					정보입력
				</td>
			</tr>
		</tbody>
	</table>

<div class="join-wrap" style="padding: 0">

	<div class="info">
<!-- 	* 행정자치부 공공I-PIN센터에서 발급받은 식별ID 및 비밀번호를 이용하여 본인확인을 하는 주민번호 대체수단 서비스 입니다.<br/> -->
<!--    	 &nbsp; <b>공공I-PIN 신규발급 [<a href="http://www.gpin.go.kr" target="_blank">http://www.gpin.go.kr</a>]</b> -->
	</div>
	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<form:hidden path="ageType"/>
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="certType">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	</form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="agree_codes"/>
		<form:hidden path="certType"/>
		<form:hidden path="before_url"/>
		<form:hidden path="menu_idx"/>
		
		<c:if test="${not empty newMember.bringIn}">
			<form:hidden path="bringIn"/>
		</c:if>
		
		<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

		<div style="text-align: right; ${param.ageType eq 'under' ? 'display:none;':''}; border-top:1px solid #ddd;padding:15px 0;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>

		<div>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''};border-top:none;">
			<caption>회원가입 정보입력. 아이디,비밀번호,성명,성별,생년월일,휴대폰 번호,주소,소속도서관,집전화번호,이메일 등을 입력</caption>
			<tbody>
				<tr>
				<th>
					<span style="color: red;">*</span> 소속도서관
				</th>
				<td>
				<c:if test="${homepage.context_path eq 'dgportal'}">
				<!--대구광역시립 중앙도서관<input type="hidden" name="manage_code" value='AD' />-->
				
				<select name='manage_code'>
					<option value="AD">국채보상운동기념도서관</option>
					<option value="AA">대구2ㆍ28기념학생도서관</option>
					<option value="AL">대구2ㆍ28민주운동기념회관</option>
					<option value="AG">대구광역시립 남부도서관</option>
					<option value="AJ">대구광역시립 달성도서관</option>
					<option value="AH">대구광역시립 동부도서관</option>
					<option value="AB">대구광역시립 두류도서관</option>
					<option value="AC">대구광역시립 북부도서관</option>
					<option value="AF">대구광역시립 서부도서관</option>
					<option value="AE">대구광역시립 수성도서관</option>
					<option value="AM">대구광역시교육청 삼국유사군위도서관</option>
					<option value="BA" >구수산도서관</option>
					<option value="BB" >대현도서관</option>
					<option value="BC" >태전도서관</option>
					<option value="BD" >범어도서관</option>
					<option value="BE" >용학도서관</option>
					<option value="BF" >고산도서관</option>
					<option value="FF">남산4동작은도서관</option>
					<option value="FQ">동인 느티나무 도서관</option>
					<option value="FS">대구중구영어도서관</option>
					<option value="FY">중구청교양정보실</option>
					<option value="GG">대신동작은도서관</option>
					<option value="HA">삼덕마루 작은도서관</option>
					<option value="HF">대봉2동작은도서관</option>
					<option value="BL">서구어린이도서관</option>
					<option value="BQ">비산도서관</option>
					<option value="BP">서구영어도서관</option>
					<option value="BM">비원도서관</option>
					<option value="BN">원고개도서관</option>
					<option value="BR">달성군립도서관</option>
					<option value="BS">대명어울림도서관</option>
					<option value="BT">이천어울림도서관</option>
					<option value="BW">도원도서관</option>
					<option value="BV">달서어린이</option>
					<option value="BU">성서도서관</option>
					<option value="BX">본리도서관</option>
					<option value="BY">달서가족문화도서관</option>
					<option value="BZ">달서영어도서관</option>
					<option value="CA">안심도서관</option>
					<option value="CB">신천도서관</option>
					<option value="FV">시청작은도서관</option>
					<option value="NA">더불어숲도서관</option>
					<option value="NB">도토리도서관</option>
					<option value="NC">동일도서관</option>
					<option value="NF">비전도서관</option>
					<option value="NE">새벗도서관</option>
					<option value="NK">아트도서관</option>
					<option value="ND">연암도서관</option>
					<option value="NG">점자도서관</option>
					<option value="NH">푸른초장공공도서관</option>
					<option value="NJ">한들마을도서관</option>
				</select>
				<div class="ui-state-highlight" style="margin-top:7px">
					<span>* 소속 도서관은 변경이 어려우니 신중하게 선택하여 주시기 바랍니다.</span>
				</div>
				</c:if>

				<c:if test="${homepage.context_path eq 'bukgs'}">
					구수산도서관<input type="hidden" id="" name="manage_code" value="BA" />
				</c:if>
				<c:if test="${homepage.context_path eq 'bukdh'}">
					대현도서관<input type="hidden" id="" name="manage_code" value="BB" />
				</c:if>
				<c:if test="${homepage.context_path eq 'buktj'}">
					태전도서관<input type="hidden" id="" name="manage_code" value="BC" />
				</c:if>

				<c:if test="${homepage.context_path eq 'beomeo'}">
					범어도서관<input type="hidden" id="" name="manage_code" value="BD" />
				</c:if>
				<c:if test="${homepage.context_path eq 'yonghak'}">
					용학도서관<input type="hidden" id="" name="manage_code" value="BE" />
				</c:if>
				<c:if test="${homepage.context_path eq 'gosan'}">
					고산도서관<input type="hidden" id="" name="manage_code" value="BF" />
				</c:if>

				<c:if test="${homepage.context_path eq 'junggu'}">
					<select name="manage_code">
						<option value="FF">남산4동작은도서관</option>
						<option value="FQ">동인 느티나무 도서관</option>
						<option value="FS">대구중구영어도서관</option>
						<option value="FY">중구청교양정보실</option>
						<option value="GG">대신동작은도서관</option>
						<option value="HA">삼덕마루 작은도서관</option>
						<option value="HF">대봉2동작은도서관</option>
					</select>
				</c:if>

				<c:if test="${homepage.context_path eq 'seogulib'}">
					<select name="manage_code">
						<option value="BL">서구어린이도서관</option>
						<option value="BQ">비산도서관</option>
						<option value="BP">서구영어도서관</option>
						<option value="BM">비원도서관</option>
						<option value="BN">원고개도서관</option>
						<option value="CC">New평리도서관</option>
					</select>
				</c:if>

				<c:if test="${homepage.context_path eq 'dalseonglib'}">
					<select name="manage_code">
						<option value="BR">달성군립도서관</option>
					</select>
				</c:if>

				<c:if test="${homepage.context_path eq 'namdm'}">
					대명어울림도서관<input type="hidden" id="" name="manage_code" value="BS" />
				</c:if>
				<c:if test="${homepage.context_path eq 'namic'}">
					이천어울림도서관<input type="hidden" id="" name="manage_code" value="BT" />
				</c:if>

				<c:if test="${homepage.context_path eq 'dalseolib'}">
					<select name="manage_code">
						<option value="BW">도원도서관</option>
						<option value="BV">달서어린이</option>
						<option value="BU">성서도서관</option>
						<option value="BX">본리도서관</option>
						<option value="BY">달서가족문화도서관</option>
						<option value="BZ">달서영어도서관</option>
					</select>
				</c:if>

				<c:if test="${homepage.context_path eq 'donggu'}">
					<select name="manage_code">
						<option value="CA">안심도서관</option>
						<option value="CB">신천도서관</option>
					</select>
				</c:if>

				<c:if test="${homepage.context_path eq 'dmsl'}">
					시청작은도서관<input type="hidden" id="" name="manage_code" value="FV" />
				</c:if>

				<c:if test="${homepage.context_path eq '228'}">
				대구2ㆍ28기념학생도서관<input type="hidden" name="manage_code" value='AA' />
				</c:if>
				<c:if test="${homepage.context_path eq '228lib'}">
				대구2ㆍ28민주운동기념회관<input type="hidden" name="manage_code" value='AL' />
				</c:if>
				<c:if test="${homepage.context_path eq 'nambu'}">
				대구광역시립 남부도서관<input type="hidden" name="manage_code" value='AG' />
				</c:if>
				<c:if test="${homepage.context_path eq 'dalseong'}">
				대구광역시립 달성도서관<input type="hidden" name="manage_code" value='AJ' />
				</c:if>
				<c:if test="${homepage.context_path eq 'dongbu'}">
				대구광역시립 동부도서관<input type="hidden" name="manage_code" value='AH' />
				</c:if>
				<c:if test="${homepage.context_path eq 'duryu'}">
				대구광역시립 두류도서관<input type="hidden" name="manage_code" value='AB' />
				</c:if>
				<c:if test="${homepage.context_path eq 'bukbu'}">
				대구광역시립 북부도서관<input type="hidden" name="manage_code" value='AC' />
				</c:if>
				<c:if test="${homepage.context_path eq 'seobu'}">
				대구광역시립 서부도서관<input type="hidden" name="manage_code" value='AF' />
				</c:if>
				<c:if test="${homepage.context_path eq 'suseong'}">
				대구광역시립 수성도서관<input type="hidden" name="manage_code" value='AE' />
				</c:if>
				<c:if test="${homepage.context_path eq 'jungang'}">
				대구광역시립 중앙도서관<input type="hidden" name="manage_code" value='AD' />
				</c:if>
				<c:if test="${homepage.context_path eq 'gukbo'}">
				국채보상운동기념도서관<input type="hidden" name="manage_code" value='AD' />
				</c:if>
				<c:if test="${homepage.context_path eq 'gw'}">
				대구광역시교육청 삼국유사군위도서관<input type="hidden" name="manage_code" value='AM' />
				</c:if>
				<!-- 대구사립도서관 -->
				<c:if test="${homepage.context_path eq 'with'}">
				더불어숲도서관<input type="hidden" name="manage_code" value='NA'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'dotory'}">
				도토리도서관<input type="hidden" name="manage_code" value='NB'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'dongil'}">
				동일도서관<input type="hidden" name="manage_code" value='NC'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'vision'}">
				비전도서관<input type="hidden" name="manage_code" value='NF'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'saebut'}">
				새벗도서관<input type="hidden" name="manage_code" value='NE'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'art'}">
				아트도서관<input type="hidden" name="manage_code" value='NK'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'yeonam'}">
				연암도서관<input type="hidden" name="manage_code" value='ND'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'daegubl'}">
				점자도서관<input type="hidden" name="manage_code" value='NG'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'wasabi'}">
				푸른초장공공도서관<input type="hidden" name="manage_code" value='NH'/>
				</c:if>
				<c:if test="${homepage.context_path eq 'handle'}">
				한들마을도서관<input type="hidden" name="manage_code" value='NJ'/>
				</c:if>
				</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 아이디
					</th>
					<td>
						<form:input path="member_id" class="text new_text01" title="아이디 입력" maxlength="20"/> <a href="#" id="check-btn" class="btn btn2" title="중복확인">중복확인</a>
						<div class="ui-state-highlight" style="margin-top:7px">
							<span>* 아이디는 영문 또는 숫자만 가능하며 6자 이상 20자 이내만 가능합니다.</span>
						</div>
					</td>
				</tr>
 				<tr>
					<th>
						<span style="color: red;">*</span> 비밀번호
					</th>
					<td>
						<form:password path="member_pw" class="text new_text01" title="신규 비밀번호 입력" maxlength="20"/>
						<div class="ui-state-highlight" style="margin-top:7px">
							<span id="pwdcheck">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
						</div>

					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 비밀번호 확인
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text new_text01" title="신규 비밀번호 확인을 위한 입력" > <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 성명
					</th>
					<td>
						${newMember.member_name}
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 성별
					</th>
					<td>
						${newMember.sex eq '0' ? '남' : '여' }
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 생년월일
					</th>
					<td >
						${newMember.birth_day}
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 휴대폰 번호
					</th>
					<td>
						<div id="cell_phone_div">
						<c:if test="${not empty newMember.cell_phone}">
						${newMember.cell_phone}&nbsp;
					 	<form:hidden path="cell_phone1" class="text" cssStyle="width:60px;" title="휴대폰 번호  첫번째 자리 입력" maxlength="3" numberOnly="true"/>
					 	<form:hidden path="cell_phone2" class="text" cssStyle="width:60px;" title="휴대폰 번호  중간 자리 입력" maxlength="4" numberOnly="true"/>
					 	<form:hidden path="cell_phone3" class="text" cssStyle="width:60px;" title="휴대폰 번호  끝 자리 입력"  maxlength="4" numberOnly="true"/>
						</c:if>
						<c:if test="${empty newMember.cell_phone}">
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;"   title="휴대폰 번호 첫번째 자리 입력" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" title="휴대폰 번호  중간 자리 입력" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" title="휴대폰 번호  끝 자리 입력"  maxlength="4" numberOnly="true"/>
						</c:if>
					 	<form:hidden path="cell_phone"/>
							<c:if test="${newMember.editMode eq 'ADD' }">
								<form:checkbox path="sms_service_yn" value="Y" label=" SMS 수신 여부" checked="true" cssStyle="vertical-align: middle; width: 20px; height: 20px;"/>
							</c:if>
							<c:if test="${newMember.editMode ne 'ADD' }">
								<form:checkbox path="sms_service_yn" value="Y" label=" SMS 수신 여부" cssStyle="vertical-align: middle; width: 20px; height: 20px;"/>
							</c:if>
						</div>
						<div class="ui-state-highlight" style="margin-top:7px">
							* 도서관련 알림(ex:예약도서, 반납예정일 등) 및 행사 안내를 받으실 수 있습니다.
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<span style="color: red;">*</span> 주소
					</th>
					<td>
						<div class="line2">
							<p>
								<form:input path="zipcode" class="text new_text01" title="우편번호" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode" class="btn btn2" title="새창열림">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="address1" class="text new_text01" style="width:80%;margin-bottom:5px;" title="상세 주소 입력" />
								<form:input path="address2" class="text new_text01" style="width:80%;" title="동이하 주소 입력"/>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						집전화번호
					</th>
					<td>
						<form:hidden path="phone"/>
						<form:input path="phone1" class="text new_text01" cssStyle="width:60px;" maxlength="3" numberOnly="true" title="전화번호 지역번호 입력"/>
					 	- <form:input path="phone2" class="text new_text01" cssStyle="width:60px;" maxlength="4" numberOnly="true" title="전화번호 중간번호 입력"/>
					 	- <form:input path="phone3" class="text new_text01" cssStyle="width:60px;" maxlength="4" numberOnly="true" title="전화번호 끝 번호 입력"/>
					</td>
				</tr>
				<tr>
					<th>
						이메일
					</th>
					<td>
						<form:hidden path="email"/>
						<form:input path="email1" class="text new_text01" title="이메일 아이디 입력" /> @
						<form:input path="email2" class="text new_text01" title="이메일주소 입력" />
						<select id="email2_temp" name="email2_temp" class="selectmenu new_select_box" title="이메일 주소 선택">
							<option value="" >--직접입력--</option>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gmail.com" >gmail.com</option>
							<option value="korea.kr" >korea.kr</option>
						</select>
						<p style="height:5px;"></p>
						<form:checkbox path="email_service_yn" value="Y" label="EMAIL 수신여부" class="new_input_btn01"/>
					</td>
				</tr>
			</tbody>
		</table>
		</div>

		<p class="txt-box-adv" style="margin-top:10px;">※ 경산시, 칠곡군 소재지인 주민들은 비대면 인증이 되지 않습니다. 도서관에 직접 방문하여 주시기 바랍니다.</p>

		<div class="btn-wrap">
			<c:if test="${newMember.editMode eq 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1" title="회원가입">회원가입</a>
			</c:if>
			<c:if test="${newMember.editMode ne 'ADD' }">
			<a href="#" id="save-btn" class="btn btn1"title="수정완료">수정완료</a>
			</c:if>
			<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn" title="취소">취소</a>
		</div>

	</form:form>
	<br/>
</div>
