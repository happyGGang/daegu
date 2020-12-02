<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	$('a#findPostCode').on('click', function(e) {
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
				extraAddr = '(' + extraAddr + ')';
                $('input#zipcode').val(data.zonecode);//5자리 새우편번호 사용
                $('input#address_one').val(fullAddr);
                $('input#address_two').val(extraAddr);
            }
        }).open();
	});
	
	$('input:radio[name = age_type]').on('click', function(e) {
		$('select#contest_type_idx option').eq(0).prop('selected', true);
		if($(this).val() == 'ele_low'){
			$('select#contest_type_idx option').each(function(i) {
				var optionValue = $('select#contest_type_idx option').eq(i).data('subject');
				if (optionValue.indexOf('ele_low') > -1 || optionValue == 'all') {
					$('select#contest_type_idx option').eq(i).prop('disabled', false);
				} else {
					$('select#contest_type_idx option').eq(i).prop('disabled', true);
				}
			});
			$('input#school_class_one').prop('disabled', false);
			$('input#school_class_two').prop('disabled', false);
			$('input#school_name').prop('disabled', false);	
			$('input#school_class_one').css('background', "#fafafa");
			$('input#school_class_two').css('background', "#fafafa");
			$('input#school_name').css('background', "#fafafa");
		}else if($(this).val() == 'ele_high'){
			$('select#contest_type_idx option').each(function(i) {
				var optionValue = $('select#contest_type_idx option').eq(i).data('subject');
				if (optionValue.indexOf('ele_high') > -1 || optionValue == 'all') {
					$('select#contest_type_idx option').eq(i).prop('disabled', false);
				} else {
					$('select#contest_type_idx option').eq(i).prop('disabled', true);
				}
			});
			$('input#school_class_one').prop('disabled', false);
			$('input#school_class_two').prop('disabled', false);
			$('input#school_class_one').css('background', "#fafafa");
			$('input#school_class_two').css('background', "#fafafa");
			$('input#school_name').css('background', "#fafafa");
			$('input#school_name').prop('disabled', false);	
		}else if($(this).val() == 'middle' || $(this).val() == 'high' || $(this).val() == 'adult'){
			var selectedValue = $(this).val();
			$('select#contest_type_idx option').each(function(i) {
				var optionValue = $('select#contest_type_idx option').eq(i).data('subject');
				var optionArray = optionValue.split(",");

				Array.prototype.contains = function(element) {
					for (var i = 0; i < this.length; i++) {
						if (this[i] == element) {
							return true;
						}
					}
					return false;
				}

				if (optionArray.contains(selectedValue) || optionValue == 'all') {
					$('select#contest_type_idx option').eq(i).prop('disabled', false);
				} else {
					$('select#contest_type_idx option').eq(i).prop('disabled', true);
				}
			})
			$('input#school_class_one').css('background', "#fafafa");
			$('input#school_class_two').css('background', "#fafafa");
			$('input#school_name').css('background', "#fafafa");
			if($(this).val() == 'adult'){
				$('input#school_class_one').val('');
				$('input#school_class_two').val('');
				$('input#school_name').val('');
				$('input#school_class_one').prop('disabled', true);
				$('input#school_class_two').prop('disabled', true);
				$('input#school_name').prop('disabled', true);
				$('input#school_class_one').css('background', "rgb(238, 238, 238)");
				$('input#school_class_two').css('background', "rgb(238, 238, 238)");
				$('input#school_name').css('background', "rgb(238, 238, 238)");
			}
		}
	});
	
	$('select#address_dong').on('change', function(e) {
		if($(this).val() == 'write') {
			$('input#address_writeDong').prop('readonly', false);
			$('input#address_writeDong').val('');
		}else if($(this).val() == ''){
			$('input#address_writeDong').val('');
			$('input#address_writeDong').prop('readonly', true);
		}else{
			$('input#address_writeDong').val($('select#address_dong option:checked').text());
			$('input#address_writeDong').prop('readonly', true);
		}
	});
	function setDate(){
		var year = new Array();
		var month = new Array();
		var date = new Array();
		
		var sysDate = new Date();
		var now_year = sysDate.getFullYear();
		var now_year2 = sysDate.getFullYear();
		
		var birth_year = '${marathonApplicant.birthday_year}';
		var birth_month = '${marathonApplicant.birthday_month}';
		var birth_date = '${marathonApplicant.birthday_date}';

		for(var i = now_year2; i > now_year2 - 100; i--){
			year.push(now_year);
			now_year = now_year - 1;
		}
		for(var i = 1; i < 13; i++){
			if(i < 10){
				i = "0" + i;
			}
			month.push(i);
		}
		for(var i = 1; i < 32; i++){
			if(i < 10){
				i = "0" + i;
			}
			date.push(i);
		}
		for(var count = 0; count < year.length; count++){
			if(year[count] == birth_year){
				$('select#birthday_year').append("<option value='" + year[count] + "' + selected = 'selected'>" + year[count] + "</option>");
			}else{
				$('select#birthday_year').append("<option value='" + year[count] + "'>" + year[count] + "</option>");
			}
		}
		for(var count = 0; count < month.length; count++){
			if(month[count] == birth_month){
				$('select#birthday_month').append("<option value='" + month[count] + "' + selected = 'selected'>" + month[count] + "</option>");
			}else{
				$('select#birthday_month').append("<option value='" + month[count] + "'>" + month[count] + "</option>");
			}
		}
		for(var count = 0; count < date.length; count++){
			if(date[count] == birth_date){
				$('select#birthday_date').append("<option value='" + date[count] + "' + selected = 'selected'>" + date[count] + "</option>");
			}else{
				$('select#birthday_date').append("<option value='" + date[count] + "'>" + date[count] + "</option>");
			}
		}
	}
	setDate();
	
	$('button#back-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
	
	$('button#save-btn').on('click', function(e) {
		e.preventDefault();
		if($('input:checkbox[name = agree]:checked').length < 1){
			alert('달서독서마라톤 대회 참가자 완주기준을 동의하셔야 서비스 이용이 가능합니다.');
			$('input:checkbox[name = agree]').focus();
			return false;
		}
		if($('input#member_name').val() == ''){
			alert('이름을 입력해 주세요.');
			$('input#member_name').focus();
			return false;
		}
		if($('input:radio[name = age_type]:checked').length < 1){
			alert('분류를 선택해 주세요.');
			$('input:radio[name = age_type]').focus();
			return false;
		}
		if($('input:radio[name = age_type]:checked').val() != 'adult'){
			if($('input#school_name').val() == ''){
				alert('학교를 입력해 주세요.');
				$('input#school_name').focus();
				return false;
			}
			if($('input#school_class_one').val() == ''){
				alert('학년을 입력해 주세요.');
				$('input#school_class_one').focus();
				return false;
			}
			if($('input#school_class_two').val() == ''){
				alert('반을 입력해 주세요.');
				$('input#school_class_two').focus();
				return false;
			}
		}
		if($('select#address_dong').val() == '' && $('input#address_writeDong').val() == ''){
			alert('동(행정동)을 입력해 주세요.');
			$('select#address_dong').focus();
			return false;
		}
		if($('input#zipcode').val() == ''){
			alert('우편번호를 입력해 주세요.');
			$('input#zipcode').focus();
			return false;
		}
		if($('input#address').val() == ''){
			alert('주소를 입력해 주세요.');
			$('input#address').focus();
			return false;
		}
		if($('input#telephone_one').val() == ''){
			alert('전화번호 앞자리를 입력해 주세요.');
			$('input#telephone_one').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#telephone_one').val())){
			alert('전화번호에는 숫자만 입력해 주세요.');
			$('input#telephone_one').focus();
			return false;
		}
		if($('input#telephone_two').val() == ''){
			alert('전화번호 중간자리를 입력해 주세요.');
			$('input#telephone_two').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#telephone_two').val())){
			alert('전화번호에는 숫자만 입력해 주세요.');
			$('input#telephone_two').focus();
			return false;
		}
		if($('input#telephone_three').val() == ''){
			alert('전화번호 끝자리를 입력해 주세요.');
			$('input#telephone_three').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#telephone_three').val())){
			alert('전화번호에는 숫자만 입력해 주세요.');
			$('input#telephone_three').focus();
			return false;
		}
		if($('input#cellphone_one').val() == ''){
			alert("휴대전화번호 앞자리를 입력해 주세요.");
			$('input#cellphone_one').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#cellphone_one').val())){
			alert('휴대전화번호에는 숫자만 입력해 주세요.');
			$('input#cellphone_one').focus();
			return false;
		}
		if($('input#cellphone_two').val() == ''){
			alert('휴대전화번호 중간자리를 입력해 주세요.');
			$('input#cellphone_two').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#cellphone_two').val())){
			alert('휴대전화번호에는 숫자만 입력해 주세요.');
			$('input#cellphone_two').focus();
			return false;
		}
		if($('input#cellphone_three').val() == ''){
			alert('휴대전화번호 끝자리를 입력해 주세요.');
			$('input#cellphone_three').focus();
			return false;
		}
		var regexp = /^[0-9]/g;
		if(!regexp.test($('input#cellphone_three').val())){
			alert('휴대전화번호에는 숫자만 입력해 주세요.');
			$('input#cellphone_three').focus();
			return false;
		}
		if($('input:radio[name = gender]:checked').length < 1){
			alert('성별을 선택해 주세요.');
			$('input:radio[name = gender]').focus();
			return false;
		}
		if($('select#birthday_year').val() == ''){
			alert('생년월일 연도를 선택해 주세요.');
			$('select#birthday_year').focus();
			return false;
		}
		if($('select#birthday_month').val() == ''){
			alert('생년월일 월을 선택해 주세요.');
			$('select#birthday_month').focus();
			return false;
		}
		if($('select#birthday_date').val() == ''){
			alert('생년월일 일을 선택해 주세요.');
			$('select#birthday_date').focus();
			return false;
		}
		if($('select#contest_type_idx').val() == '0'){
			alert('참가종목을 선택해 주세요.');
			$('select#contest_type_idx').focus();
			return false;
		}
		if($('select#contest_type_idx option:selected').prop('disabled')){
			alert('선택한 분류는 해당 참가종목에 참여할 수 없습니다.');
			$('select#contest_type_idx').focus();
			return false;
		}
		if($('input:radio[name = finish_memorial]:checked').length < 1){
			alert('완주기념풍을 선택해 주세요.');
			$('input:radio[name = finish_memorial]').focus();
			return false;
		}
		if($('input:checkbox[name = agree1]:checked').length < 1){
			alert('개인정보 수집 및 이용에 동의하셔야 서비스 이용이 가능합니다.');
			$('input:checkbox[name = agree1]').focus();
			return false;
		}
		if($('input:checkbox[name = agree2]:checked').length < 1){
			alert('만 14세 미만 아동의 참가 신청에 동의하셔야 서비스 이용이 가능합니다.');
			$('input:checkbox[name = agree2]').focus();
			return false;
		}
		doAjaxPost($('form#marathonApplicant'));
	});
});
</script>
<style>
	table {border-bottom: 0px;}
	span.text2{font-style: normal;color: #888;font-size: 90%;margin: 0 5px;}
	#cont_wrap{padding: 20px 0 60px;font-size: 15px;font-weight: normal;font-family: 'NotoKrR';line-height: 160%;letter-spacing: -0.02em;}
	.bookrun {display: inline-block;width: 100%;border: 2px solid #ee005e;padding: 50px;box-sizing: border-box;margin-bottom: 35px;}
	.bookrun p.s_txt {text-align: center;font-size: 23px;font-weight: bold;font-family: 'NotoKrM';}
	.bookrun h3.tit {text-align: center;padding-top: 5px;color: #ee005e;font-weight: bold;font-family: 'NotoKrB',sans-serif;font-size: 30px;background:none;line-height: 1.2;letter-spacing: -0.05em;margin-bottom: 1em;}
	ul.list {}
	ol, ul, li {list-style: none;}
	ul.list li {padding-left: 13px;margin-bottom: 5px;font-size: 15px;font-weight: normal;font-family: 'NotoKrR';color: #222;line-height: 24px;background: url(/resources/board/img/bu_list.gif) no-repeat 0 7px;}
	.bookrun ul li .no_book {background: url(/resources/board/img/bu_list.gif) no-repeat 0 13px;}
	.bookrun ul li a.no_book_list {width:150px; margin-left: 15px;padding: 2px 15px;background: #e05480;line-height: 35px;text-align: center;color:#fff;}
	.bookrun ul li.blue {color: #2b62ff;}
	.bookrun p.ps {text-decoration: underline;font-weight: bold;}
	.bookrun .graybox{width: 82%;margin: 15px 0 15px 0;padding: 20px;box-sizing: border-box;background: #f5f5f5;border: 1px solid #dfdfdf;color: #2b62ff;}
	ul.list li ul.list2 {margin: 5px 0 10px 0;}
	ul.list2 li {font-weight: normal;font-family: 'NotoKrR';padding-left: 10px;margin-bottom: 3px;line-height: 22px;font-size: 14px;color:#666;background: url(/resources/board/img/bu_list02.gif) no-repeat left 8px;}
	ul.list3 li {background: 0;}
	strong {font-family: 'NotoKrB';}
	strong.st {font-size: 15px;text-decoration: underline;color: #000;}
	.bookrun .graybox p.no2 {color: #ff2b83;}
	.app_box div {margin-top: -6px;font-family: 'NotoKrR';background: #fff; clear: both;width: 100%;height: 140px;padding: 20px; border: 1px solid #dfdfdf;border-bottom: 0;overflow-y: scroll;font-size:13px;color: #666;line-height: 18px;box-sizing: border-box;}
</style>
<div id="cont_wrap">
	<div class="bookrun">
		<p class="s_txt">책으로 달리는 우리의 레이스!</p>
		<h3 class="tit">제 12회 달서독서마라톤 대회 참가자 완주기준체크!</h3>
		<ul class="list">
			<li>동일한 내용 반복 기재, 의미 없는 감탄사나 자 · 모음 나열로 작성된 일지는 기록 제외</li>
			<li>도서(원서 포함)의 <strong>일지 작성언어가 한국어</strong>인지 여부</li>
			<li><strong>책 제목, 쪽수</strong>등 도서정보의 <strong>정확한 기재</strong> 여부</li>
			<li><strong>달서구 소재 도서관(공공 · 대학 · 학교 · 작은도서관)소장도서</strong> 여부</li>
			<li class="no_book"><strong>제외도서로 작성된 일지는 기록에서 제외</strong><a class="no_book_list" href="/resources/board/img/mbook_list.jpg" target="_blank" alt="제외도서목록표">제외도서 보기</a></li>
			<li class="blue">본인 이외 대출 · 구입 도서로 작성한 경우 기록에서 제외
				<ul class="list2">
					<li><strong>초등생에 한하여 부모가 대출한 도서도 완주기록으로 인정</strong>됩니다
						<ul class="list3">
							<li style="list-style: none;">- 단, 가족 참가자 중 같은 도서를 기록했다면 1명만 인정(대출자 본인 우선)</li>
						</ul>
					</li>
					<li>
						<strong>가족이 구입한 도서는 완주기록으로 인정</strong>됩니다
						<ul class="list3">
							<li style="list-style: none;">- 단, 가족 참가자 중 같은 도서를 기록했다면 1명만 인정(구입자 본인 우선)</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
		<p class="ps">※ 필요시, 해당 참가자에게 증빙서류 제출 요청</p>
		<div class="graybox">
			<p class="no1"><strong>- 완주기준에 벗어나는 경우, 사전통보 없이 완주기록에서 제외됩니다.</strong></p>
			<p class="no2"><strong>- 독서마라톤홈페이지</strong>(대회진행, 완주심사,FAQ,공지사항 등)를 <strong>꼭 확인해 주세요!</strong>
		</div>
		<div class="check">
			<input name="agree" id="agree" type="checkbox" value="Y">
			<label for="agree">위 내용을 숙지하였으며 동의합니다.</label>
		</div>
	</div>
</div>
<c:choose>
	<c:when test="${ing eq false}">
		독서마라톤대회가 없습니다.
	</c:when>
	<c:otherwise>
		<form:form modelAttribute="marathonApplicant" action="save.do" method="POST">
			<form:hidden path="homepage_id"/>
			<form:hidden path="contest_idx"/>
			<form:hidden path="editMode"/>
			<table class="type2">
				<colgroup>
					<col width="160"/>
					<col width="*"/>
				</colgroup>
				<div style="text-align:right">
					*표시가 된 곳은 필수 항목입니다.
				</div>
				<tbody>
					<tr>
						<th colspan="2" style="background:#fff;">신청정보 입력</th>
					</tr>
					<tr>
						<th>신청일</th>
						<td><fmt:formatDate value="${marathonApplicant.add_date}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${marathonApplicant.member_id}</td>
					</tr>
					<tr>
						<th>이름*</th>
						<td>
							<form:input path="member_name" cssClass="text"/>
							<span class="text2">*30자 이내로 입력해 주세요.</span>
						</td>
					</tr>
					<tr>
						<th>분류*</th>
						<td>
							<form:radiobutton path="age_type" id="age_type_ele_low" value="ele_low"/>
							<label for="age_type_ele_low">초등(1~3)저학년</label>
							<form:radiobutton path="age_type" id="age_type_ele_high" value="ele_high"/>
							<label for="age_type_ele_high">초등(4~6)고학년</label>
							<form:radiobutton path="age_type" id="age_type_middle" value="middle"/>
							<label for="age_type_middle">중학생</label>
							<form:radiobutton path="age_type" id="age_type_high" value="high"/>
							<label for="age_type_high">고등학생</label>
							<form:radiobutton path="age_type" id="age_type_adult" value="adult"/>
							<label for="age_type_adult">일반인</label><br/>
							<span style="color:red;">*신청 후 수정이 불가능하니 신중하게 선택하시기 바랍니다.</span>
						</td>	
					</tr>
					<tr>
						<th>학교*</th>
						<td>
							<form:input path="school_name" cssClass="text"/>
							<span class="text2">*(예:00 초등학교)</span>
						</td>
					</tr>
					<tr>
						<th>학년*</th>
						<td>
							<form:input path="school_class_one" cssClass="text" size="4"/>학년
							<form:input path="school_class_two" cssClass="text" size="4"/>반
							<span class="text2">*일반인의 경우 학교 학년 기입하지 않으셔도 됩니다.</span>
						</td>
					</tr>
					<tr>
						<th>주소*</th>
						<td>
							<div style="margin-bottom:1%;">
								<form:select path="address_dong" cssClass="selectmenu">
									<form:option value="">동 선택</form:option>
									<form:options items="${dongList}" itemLabel="code_name" itemValue="code_id"/>
									<form:option value="write">기타 직접 입력</form:option>
								</form:select>
								<input type="text" id="address_writeDong" class="text" size="6" readonly="true"/><span class="text2"> *동명을 입력해 주세요.</span><br/>
							</div>
							<a href="" id="findPostCode" class="btn" style="background:#fff;font-size:14px;padding:5px 3px;">우편번호찾기</a><form:input path="zipcode" cssClass="text" readonly="true" cssStyle="width:80px;" maxLength="5"/><span class="text2"> *우편번호(숫자5자리)</span><br/>
							<form:input path="address_one" size="40" cssClass="text" style="margin-top:0.5px;" readonly="true"/><span class="text2"> *시도 + 시군구 + 도로명(50자리 이내로 입력해 주세요.)</span><br/>
							<form:input path="address_two" size="40" cssClass="text" style="margin-top:0.5px"/><span class="text2"> *건물번호 + 동·층·호 + (법정동,공동주택명)(50자리 이내로 입력해 주세요.)</span>
						</td>
					</tr>
					<tr>
						<th>전화번호*</th>
						<td>
							<form:input path="telephone_one" cssClass="text" size="4" maxlength="4"/>-<form:input path="telephone_two" cssClass="text" size="4" maxlength="4"/>-<form:input path="telephone_three" cssClass="text" size="4" maxlength="4"/>
							<span class="text2">*숫자만 입력해 주세요.</span>
						</td>
					</tr>
					<tr>
						<th>휴대전화번호*</th>
						<td>
							<form:input path="cellphone_one" cssClass="text" size="4" maxlength="4"/>-<form:input path="cellphone_two" cssClass="text" size="4" maxlength="4"/>-<form:input path="cellphone_three" cssClass="text" size="4" maxlength="4"/>
							<span class="text2">*숫자만 입력해 주세요.</span>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<form:input path="email" cssClass="text" size="30"/>
							<span class="text2">100자 이내로 @포함한 이메일주소를 입력해 주세요.</span>
						</td>
					</tr>
					<tr>
						<th>성별*</th>
						<td>
							<form:radiobutton path="gender" id="gender_man" value="M"/>
							<label for="gender_man">남</label>
							<form:radiobutton path="gender" id="gender_woman" value="F"/>
							<label for="gender_woman">여</label>
						</td>
					</tr>
					<tr>
						<th>생년월일*</th>
						<td>
							<form:select path="birthday_year" cssClass="selectmenu">
								<form:option value="">년도</form:option>
							</form:select>
							년
							<form:select path="birthday_month" cssClass="selectmenu">
								<form:option value="">월</form:option>
							</form:select>
							월
							<form:select path="birthday_date" cssClass="selectmenu">
								<form:option value="">일</form:option>
							</form:select>
							일
						</td>
					</tr>
					<tr>
						<th>참가종목*</th>
						<td>
							<form:select path="contest_type_idx" cssClass="selectmenu">
								<form:option value="0" data-subject="DONOTSELECT">참가종목</form:option>
								<c:forEach items="${marathonTypeList}" var="i" >
									<form:option value="${i.contest_type_idx}" data-subject="${i.application_subject}">${i.contest_type}</form:option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th>완주기념품*</th>
						<td>
							<form:radiobutton path="finish_memorial" id="finish_memorial_document" value="document"/>
							<label for="finish_memorial_document">완주증서</label>
							<form:radiobutton path="finish_memorial" id="finish_memorial_medal" value="medal"/>
							<label for="finish_memorial_medal">완주메달</label>
						</td>
					</tr>
					<tr>
						<th>각오한마디</th>
						<td>
							<form:textarea path="determination_talk" cssClass="text" cols="50" rows="4" style="padding:10px;"/>
						</td>
					</tr>
					<tr>
						<th colspan="2" style="padding:10px 0 5px 10px;border-bottom: 1px solid #dfdfdf;background: none;text-align: left;">
							<p style="vertical-align:middle;font-size:19px;padding-top:10px;">개인정보 수집 및 이용에 대한 안내</p>
						</th>
					</tr>
					<tr>
						<td colspan="2" style="padding: 0; padding-top: 5px;border-bottom:1px solid #dfdfdf;">
							<div class="app_box">
								<div readonly="readonly" title="이용약관">
									<ul>
										<li>*독서마라톤 참가 신청을 위하여 아래와 같이 개인정보를 수집 및 이용하고자 합니다.</li><br/>
										<li>
											<ul>
												<li>
													[수집하는 개인정보의 항목]<br/>
													ㆍ독서마라톤 신청을 위하여 아래와 같이 최소한의 개인정보를 필수항목으로 수집하고 있습니다.
												</li>
												<li>ㆍ필수항목 : 성명, 주소, 전화번호, 휴대전화, 성별, 이메일, 학교(해당시), 학년(해당시), 반(해당시)</li>
											</ul>
										</li>
										<br/>
										<li>
											<ul>
												<li>
													[수집하는 개인정보의 항목]<br/>
													ㆍ신청 시 수집되는 개인정보는 독서마라톤의 신청 및 운영, 통계 목적으로만 사용되고 다른 용도로 활용되지 않습니다.
												</li>
											</ul>
										</li>
										<br/>
										<li>
											<ul>
												<li>
													[개인정보의 보유 및 이용기간]<br/>
												<strong class="st">ㆍ개인정보는 대회 접수 마감일로부터 1년간 보유하며 이후 지체 없이 파기됩니다.</strong>
												</li>
												<li>
													ㆍ회원가입시 등록된 정보는 회원 탈퇴 시 지체 없이 파기됩니다.
												</li>
											</ul>
										</li>
										<br/>
										<li>
											<ul>
												<li>
													[동의거부권 및 동의 거부에 따른 불이익]<br/>
													ㆍ신청자는 개인정보 수집·이용에 대하여 거부할 수 있는 권리가 있습니다. 단, 이에 대한 동의를 거부할 경우에는 독서마라톤 신청이 불가능합니다.
												</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding: 0px;border: 1px solid #dbdbdb;">
							<div class="agree" style="background: #f4f4f4;padding: 15px;">
								<input type="checkbox" id="agree1" name="agree1" value="Y">
								<label for="agree1" style="font-weight: bold;">개인정보 수집 및 이용에 대한 안내를 숙지하고 동의합니다.</label>
							</div>
						</td>
					</tr>
					<tr>
						<th colspan="2" style="padding:10px 0 5px 10px;border-bottom: 1px solid #dfdfdf;background: none;text-align: left;">
							<p style="vertical-align:middle;font-size:19px;padding-top:5px;">만 14세 미만 아동의 참가 신청</p>
						</th>
					</tr>
					<tr>
						<td colspan="2" style="padding: 0; padding-top: 5px;border-bottom:1px solid #dfdfdf;">
							<div class="app_box">
								<div readonly="readonly" title="이용약관">
									<ul>
										<li>만 14세 미만 아동의 개인정보를 처리하기 위하여 그 법정대리인의 동의를 받아야 합니다.</li>
										<li>법정대리인의 최소한의 정보는 법정대리인의 동의 없이 해당 아동으로부터 직접 수집할 수 있습니다.</li>
									</ul>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding: 0px;border: 1px solid #dbdbdb;">
							<div class="agree" style="background: #f4f4f4;padding: 15px;">
								<input type="checkbox" id="agree2" name="agree2" value="Y">
								<label for="agree2" style="font-weight: bold;">동의합니다.</label>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form:form>
		<br/>
		<div class="button bbs-btn center">
			<button id="save-btn" class="btn btn5" title="신청하기">신청하기</button>
			<button id="back-btn" class="btn"><i class="fa fa-reorder" title="뒤로가기"></i><span>뒤로가기</span></button>
		</div>
	</c:otherwise>
</c:choose>