<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
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


	$('th.th1').css('width', '20%');
	$('th.th1').css('text-align', 'right');

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


});
</script>

<p class="blind">
	회원가입 단계
</p>
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

			<td class="joinImg3 center">
				<div class="en">STEP 03</div>
				<div class="ko">본인확인</div>
			</td>

			<td class="joinImg4 center active">
				<div class="en">STEP 04</div>
				<div class="ko">정보입력</div>
			</td>
		</tr>
		<tr>
			<td class="joinLine center ">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="join-wrap">

	<form:form id="checkForm" modelAttribute="newMember" action="check.do" onsubmit="return false;">
		<form:hidden path="member_id"/>
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form:form>
	<form:form id="memberJoinForm" modelAttribute="newMember" action="save.do" onsubmit="return false;">
		<form:hidden path="editMode"/>
		<form:hidden path="certType"/>

		<div style="text-align: right;">
			(<span style="color: red; font-weight: bold;">*</span>) 항목은 필수 입력값입니다.
		</div>
		<table id="memberForm" class="editTbl">
			<colgroup>
				<col width="10%">
				<col>
			</colgroup>
			<tbody>

				<tr>
					<th>
						소속도서관(<span style="color: red;">*</span>)
					</th>
					<td>
						<c:choose>
						<c:when test="${context_path eq 'bukgs'}">
						구수산도서관<input type="hidden" id="" name="manage_code" value="BA" />
						</c:when>
						<c:when test="${context_path eq 'bukdh'}">
						대현도서관<input type="hidden" id="" name="manage_code" value="BB" />
						</c:when>
						<c:when test="${context_path eq 'buktj'}">
						태전도서관<input type="hidden" id="" name="manage_code" value="BC" />
						</c:when>
						<c:when test="${context_path eq 'buks'}">
							<select name="manage_code">
								<option value="GP">노원동 작은도서관</option>
								<option value="HD">노원행복도서관</option>
								<option value="GM">북구영어작은도서관</option>
								<option value="GL">산격1동 작은도서관</option>
								<option value="HB">서변동작은도서관</option>
								<option value="GN">침산1동 작은도서관</option>
								<option value="GJ">태전1동 작은도서관</option>	
								<option value="HE">한강공원부키도서관</option>
							</select>
						</c:when>

						<c:when test="${context_path eq 'beomeo'}">
						범어도서관<input type="hidden" id="" name="manage_code" value="BD" />
						</c:when>
						<c:when test="${context_path eq 'yonghak'}">
						용학도서관<input type="hidden" id="" name="manage_code" value="BE" />
						</c:when>
						<c:when test="${context_path eq 'gosan'}">
						고산도서관<input type="hidden" id="" name="manage_code" value="BF" />
						</c:when>
						<c:when test="${context_path eq 'bookforest'}">
						책숲길도서관<input type="hidden" id="" name="manage_code" value="BG" />
						</c:when>
						<c:when test="${context_path eq 'mulmangi'}">
						물망이도서관<input type="hidden" id="" name="manage_code" value="BH" />
						</c:when>
						<c:when test="${context_path eq 'padong'}">
						파동도서관<input type="hidden" id="" name="manage_code" value="BJ" />
						</c:when>
						<c:when test="${context_path eq 'muhaksup'}">
						무학숲도서관<input type="hidden" id="" name="manage_code" value="BK" />
						</c:when>
						<c:when test="${context_path eq 'sawol'}">
						사월작은도서관<input type="hidden" id="" name="manage_code" value="FG" />
						</c:when>

						<c:when test="${context_path eq 'junggu'}">
							<select name="manage_code">
								<option value="FF">남산4동작은도서관</option>
								<option value="FQ">동인 느티나무 도서관</option>
								<option value="FS">대구중구영어도서관</option>
								<option value="FY">중구청교양정보실</option>
								<option value="GG">대신동작은도서관</option>
								<option value="HA">삼덕마루 작은도서관</option>
								<option value="HF">대봉2동작은도서관</option>
							</select>
						</c:when>

						<c:when test="${context_path eq 'seogulib'}">
						서구어린이도서관<input type="hidden" id="" name="manage_code" value="BL" />
						</c:when>
						<c:when test="${context_path eq 'bisan'}">
						비산도서관<input type="hidden" id="" name="manage_code" value="BQ" />
						</c:when>
						<c:when test="${context_path eq 'seoguenglish'}">
						서구영어도서관<input type="hidden" id="" name="manage_code" value="BP" />
						</c:when>
						<c:when test="${context_path eq 'biwon'}">
						비원도서관<input type="hidden" id="" name="manage_code" value="BM" />
						</c:when>
						<c:when test="${context_path eq 'wongogae'}">
						원고개도서관<input type="hidden" id="" name="manage_code" value="BN" />
						</c:when>
						<c:when test="${context_path eq 'seogumini'}">
							<select name="manage_code">
								<option value="FH">새마을문고대구서구지부작은도서관</option>
								<option value="FT">서구청 작은도서관</option>
								<option value="FU">내당4동어린이도서관</option>
								<option value="FZ">비산7동 작은도서관</option>
								<option value="GQ">내당2,3동 드림도서관</option>
								<option value="HC">달성토성마을 다락방 작은도서관</option>
							</select>
						</c:when>
						<c:when test="${context_path eq 'dalseonglib'}">
							<select name="manage_code">
								<option value="BR">달성군립도서관</option>
							</select>
						</c:when>
						<c:when test="${context_path eq 'dalseongsmall'}">
							<select name="manage_code">
								<option value="FR">가창면 참꽃작은도서관</option>
								<option value="GA">화원읍작은도서관</option>
								<option value="GB">논공읍작은도서관</option>
								<option value="GC">구지면작은도서관</option>
								<option value="GD">다사읍서재작은도서관</option>
								<option value="GE">하빈면작은도서관</option>
								<option value="GF">유가읍작은도서관</option>
								<option value="GH">옥포읍작은도서관</option>
								<option value="FJ">달성군청도서관"</option>
								<option value="FN">달성군청소년센터</option>
								<option value="HG">다사읍작은도서관"</option>
							</select>
						</c:when>
						<c:when test="${context_path eq 'namdm'}">
						대명어울림도서관<input type="hidden" id="" name="manage_code" value="BS" />
						</c:when>
						<c:when test="${context_path eq 'namic'}">
						이천어울림도서관<input type="hidden" id="" name="manage_code" value="BT" />
						</c:when>
						<c:when test="${context_path eq 'dalseolib'}">
						도원도서관<input type="hidden" id="" name="manage_code" value="BW" />
						</c:when>
						<c:when test="${context_path eq 'kids'}">
						달서어린이<input type="hidden" id="" name="manage_code" value="BV" />
						</c:when>
						<c:when test="${context_path eq 'seongseo'}">
						성서도서관<input type="hidden" id="" name="manage_code" value="BU" />
						</c:when>
						<c:when test="${context_path eq 'bolli'}">
						본리도서관<input type="hidden" id="" name="manage_code" value="BX" />
						</c:when>
						<c:when test="${context_path eq 'family'}">
						달서가족문화도서관<input type="hidden" id="" name="manage_code" value="BY" />
						</c:when>
						<c:when test="${context_path eq 'english'}">
						달서영어도서관<input type="hidden" id="" name="manage_code" value="BZ" />
						</c:when>
						<c:when test="${context_path eq 'dssmalllib'}">
						<select name="manage_code">
							<option value="FA">이곡2동공립작은도서관</option>
							<option value="FB">용산1동작은도서관</option>
							<option value="FC">장기동작은도서관</option>
							<option value="FD">죽전동공립작은도서관</option>
							<option value="FW">달서아트센터 도서관</option>
							<option value="FX">행정정보문고센터</option>
							<option value="GK">학산작은도서관</option>
						</select>
						</c:when>
						<c:when test="${context_path eq 'donggu'}">
						안심도서관<input type="hidden" id="" name="manage_code" value="CA" />
						</c:when>
						<c:when test="${context_path eq 'sincheon'}">
						신천도서관<input type="hidden" id="" name="manage_code" value="CB" />
						</c:when>
						<c:when test="${context_path eq 'donggusm'}">
						<select name="manage_code">
							<option value="GR">신암2동 작은도서관</option>
							<option value="GS">신암3동 작은도서관</option>
							<option value="HJ">신암5동 작은도서관</option>
							<option value="FK">신천3동 작은도서관</option>
							<option value="GT">효목1동 작은도서관</option>
							<option value="FP">효목2동 작은도서관</option>
							<option value="FL">도평동 작은도서관</option>
							<option value="GU">불로어울림 작은도서관</option>
							<option value="GV">지저동 작은도서관</option>
							<option value="GW">동촌역사 작은도서관</option>
							<option value="GY">해안동 작은도서관</option>
							<option value="FM">반야월역사 작은도서관</option>
							<option value="GZ">동구청 작은도서관</option>
							<option value="HK">늘푸른 도서관</option>
							<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
							<!-- <option value="HL">초록우산도서관</option> -->
							<option value="HM">꿈날자 문고</option>
							<option value="HN">행복도서관</option>
							<option value="GX">방촌동 작은도서관</option>
							<option value="HP">율하5주민도서관</option>
							<option value="HQ">방촌어린이 작은도서관</option>
						</select>
						</c:when>


						<c:when test="${context_path eq 'jungang'}">
						중앙도서관<input type="hidden" id="" name="manage_code" value="AD" />
						</c:when>
						<c:when test="${context_path eq 'dongdu'}">
						동부도서관<input type="hidden" id="" name="manage_code" value="AH" />
						</c:when>
						<c:when test="${context_path eq 'seobu'}">
						서부도서관<input type="hidden" id="" name="manage_code" value="AF" />
						</c:when>
						<c:when test="${context_path eq 'nambu'}">
						남부도서관<input type="hidden" id="" name="manage_code" value="AG" />
						</c:when>
						<c:when test="${context_path eq 'bukbu'}">
						북부도서관<input type="hidden" id="" name="manage_code" value="AC" />
						</c:when>
						<c:when test="${context_path eq 'duryu'}">
						두류도서관<input type="hidden" id="" name="manage_code" value="AB" />
						</c:when>
						<c:when test="${context_path eq '228'}">
						228기념학생도서관<input type="hidden" id="" name="manage_code" value="AA" />
						</c:when>
						<c:when test="${context_path eq '228lib'}">
						228민주운동<input type="hidden" id="" name="manage_code" value="AL" />
						</c:when>
						<c:when test="${context_path eq 'suseong'}">
						수성도서관<input type="hidden" id="" name="manage_code" value="AE" />
						</c:when>
						<c:when test="${context_path eq 'dalseong'}">
						달성도서관<input type="hidden" id="" name="manage_code" value="AJ" />
						</c:when>
						<c:when test="${context_path eq 'std'}">
						대구학생문화센터<input type="hidden" id="" name="manage_code" value="AK" />
						</c:when>
						<c:when test="${context_path eq 'dmsl'}">
						시청작은도서관<input type="hidden" id="" name="manage_code" value="FV" />
						</c:when>
						<c:when test="${context_path eq 'dgoti'}">
						공무원연수원<input type="hidden" id="" name="manage_code" value="HH" />
						</c:when>
						<c:when test="${context_path eq 'daegu'}">
						대구시청<input type="hidden" id="" name="manage_code" value="ZA" />
						</c:when>


						<c:when test="${context_path eq 'with'}">
						더불어숲<input type="hidden" id="" name="manage_code" value="NA" />
						</c:when>
						<c:when test="${context_path eq 'dotory'}">
						도토리도서관<input type="hidden" id="" name="manage_code" value="NB" />
						</c:when>
						<c:when test="${context_path eq 'dongil'}">
						동일도서관<input type="hidden" id="" name="manage_code" value="NC" />
						</c:when>
						<c:when test="${context_path eq 'vision'}">
						비전도서관<input type="hidden" id="" name="manage_code" value="NF" />
						</c:when>
						<c:when test="${context_path eq 'saebut'}">
						새벗도서관<input type="hidden" id="" name="manage_code" value="NE" />
						</c:when>
						<c:when test="${context_path eq 'art'}">
						아트도서관<input type="hidden" id="" name="manage_code" value="NK" />
						</c:when>
						<c:when test="${context_path eq 'yeonam'}">
						연암도서관<input type="hidden" id="" name="manage_code" value="ND" />
						</c:when>						
						<c:when test="${context_path eq 'daegubraillelibrary'}">
						점자도서관<input type="hidden" id="" name="manage_code" value="NG" />
						</c:when>
						<c:when test="${context_path eq 'wasabi'}">
						푸른초장도서관<input type="hidden" id="" name="manage_code" value="NH" />
						</c:when>
						<c:when test="${context_path eq 'handle'}">
						한들마을도서관<input type="hidden" id="" name="manage_code" value="NJ" />
						</c:when>

						<c:otherwise>
							<select name="manage_code">
								<option value="AD">중앙도서관</option>
								<option value="AH">동부도서관</option>
								<option value="AF">서부도서관</option>
								<option value="AG">남부도서관</option>
								<option value="AC">북부도서관</option>
								<option value="AB">두류도서관</option>
								<option value="AA">228기념학생도서관</option>
								<option value="AL">228민주운동</option>
								<option value="AE">수성도서관</option>
								<option value="AJ">달성도서관</option>
								<option value="AK">대구학생문화센터</option>
								<option value="FV">시청작은도서관</option>

								<option value="BA">구수산도서관</option>
								<option value="BB">대현도서관</option>
								<option value="BC">태전도서관</option>

								<option value="GP">노원동 작은도서관</option>
								<option value="HD">노원행복도서관</option>
								<option value="GM">북구영어작은도서관</option>
								<option value="GL">산격1동 작은도서관</option>
								<option value="HB">서변동작은도서관</option>
								<option value="GN">침산1동 작은도서관</option>
								<option value="GJ">태전1동 작은도서관</option>	
								<option value="HE">한강공원부키도서관</option>

								<option value="BD">범어도서관</option>
							</select>
						</c:otherwise>
						</c:choose>
					</td>
				</tr>

				<tr>
					<th>
						아이디(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:input path="member_id" class="text" maxlength="20"/> <a href="#" id="check-btn" class="btn">중복확인</a>
						<div class="ui-state-highlight" style="margin-top:7px">
							<span>* 아이디는 영문 또는 숫자만 가능하며 6자 이상 20자 이내만 가능합니다.</span>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text" maxlength="20"/>
						<div class="ui-state-highlight">
							<span id="pwdcheck">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 9~20자이내</span>
						</div>

					</td>
				</tr>
				<tr>
					<th>
						비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
				<tr>
					<th>
						성명(<span style="color: red;">*</span>)
					</th>
					<td>
						${newMember.member_name}
					</td>
				</tr>
				<tr>
					<th>
						성별(<span style="color: red;">*</span>)
					</th>
					<td>
						${newMember.sex eq '0' ? '남' : '여' }
					</td>
				</tr>
				<tr>
					<th>
						생년월일(<span style="color: red;">*</span>)
					</th>
					<td >
						${newMember.birth_day}
					</td>
				</tr>
				<tr>
					<th>
						휴대폰 번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<div id="cell_phone_div">
						<c:if test="${not empty newMember.cell_phone}">
						${newMember.cell_phone}
						<form:input path="cell_phone1" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 0, 3)}"/>
						<form:input path="cell_phone2" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 3, 7)}" />
					 	<form:input path="cell_phone3" class="text" cssStyle="width:60px; display:none;" numberOnly="true" value="${fn:substring(newMember.cell_phone, 7, 20)}" />
						</c:if>
						<c:if test="${empty newMember.cell_phone}">
					 	<form:input path="cell_phone1" class="text" cssStyle="width:60px;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="cell_phone2" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="cell_phone3" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
						</c:if>
					 	<form:checkbox path="sms_service_yn" value="Y" label="SMS 수신여부" checked="true"/>
						</div>
						<div class="ui-state-highlight">
							* 도서관련 알림 및 행사 안내를 받으실 수 있습니다
						</div>
					</td>
				</tr>
				<tr>
					<th>
						주소(<span style="color: red;">*</span>)
					</th>
					<td>
						<div class="line2">
							<p>
								<!-- <form:input path="zipcode" class="text" readonly="true" cssStyle="width: 80px;"/> --> <form:input path="zipcode" class="text" cssStyle="width: 80px;"/><a href="#" id="findPostCode" class="btn">우편번호 찾기</a>
							</p>
							<p>
								<form:input path="address1" class="text" style="width:80%;" />
								<form:input path="address2" class="text" style="width:80%;" />
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
						<form:input path="phone1" class="text" cssStyle="width:60px;" maxlength="3" numberOnly="true"/>
					 	- <form:input path="phone2" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
					 	- <form:input path="phone3" class="text" cssStyle="width:60px;" maxlength="4" numberOnly="true"/>
					</td>
				</tr>
				<tr>
					<th>
						이메일
					</th>
					<td>
						<form:input path="email1" class="text"/> @
						<form:input path="email2" class="text"/>
						<select id="email2_temp" name="email2_temp" class="selectmenu" style="width:150px;">
							<option value="" >--직접입력--</option>
							<option value="naver.com" >naver.com</option>
							<option value="daum.net" >daum.net</option>
							<option value="gmail.com" >gmail.com</option>
							<option value="korea.kr" >korea.kr</option>
						</select>
						<br/>
						<form:checkbox path="email_service_yn" value="Y" label="EMAIL 수신여부"/>
					</td>
				</tr>

			</tbody>
		</table>

		<div class="btn-wrap">
			<a href="/intro/${context_path}/index.do" id="cancel-btn" class="btn btn02">취소</a>
			<a href="#" id="save-btn" class="btn btn03">회원가입</a>
		</div>

	</form:form>
	<br/>
</div>
