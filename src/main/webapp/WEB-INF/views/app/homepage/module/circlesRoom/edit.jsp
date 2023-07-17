<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld"%>

<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String todays = sf.format(now);
%>
<c:set var="now" value="<%=todays%>"/>

<link rel="stylesheet" type="text/css" href="/resources/common/css/circleroom.css"/>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		var code_list_str = '${circlesRoomReqList}';
		var code_list = code_list_str.substring(1, code_list_str.length-1).split(', ');
		for(var i=0; i<code_list.length; i++) {
			$('input[name=visit_time_list]').each(function() {
				if(this.value == code_list[i]) {
					console.log(code_list[i] + '=' + this.value);
					this.disabled = 'disabled';
				}
			});
		}

		$('select#circles_div').on('change', function() {
			var formData = 'homepage_id='+$('#homepage_id').val() + '&visit_date='+$('#visit_date').val() + '&circles_div=' + $(this).val();

			$.ajax({
				url: 'divByTime.do',
				type: 'POST',
				data: formData,
				dataType: 'json',
				success: function(response) {
					if(response.valid) {
						$('input[name=visit_time_list]').prop('disabled', false);

						var code_list = response.data;
						for(var i=0; i<code_list.length; i++) {
							$('input[name=visit_time_list]').each(function() {
								if(this.value == code_list[i]) {
									console.log(code_list[i] + '=' + this.value);
									this.disabled = 'disabled';
								}
							});
						}
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown + ', ' + jqXHR.status);
				}
			});
		});

		$('input#zip_code').on('click', function(e) {
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
					$('#zip_code').val(data.zonecode);//5자리 새우편번호 사용
					$('#address').val(fullAddr);
					$('#address').focus();
				}
			}).open();
		});

		$('a#list').on('click', function() {
			history.back();
		});

		$('input[name=visit_time_list]').on('click', function(e) {
			var chk_length = $('input[name=visit_time_list]:checked').length;
			if(chk_length > 3) {
				alert('이용 시간은 3시간까지 입니다.');
				e.preventDefault();
			}
		});


		$('a#save').on('click', function(e) {
			e.preventDefault();

			if(!$('input#agree1').is(':checked')) {
				alert('약관에 동의하여야 신청 가능합니다.');
				$('input#agree1').focus();
				return false;
			}
			if(!$('input#agree2').is(':checked')) {
				alert('약관에 동의하여야 신청 가능합니다.');
				$('input#agree2').focus();
				return false;
			}
			if($('input#circles_title').val() == '') {
				alert('동아리명은 반드시 입력하셔야합니다.');
				$('input#circles_title').focus();
				return false;
			}
			if($('input#phone1').val() == '') {
				alert('연락처는 반드시 입력하셔야합니다.');
				$('input#phone1').focus();
				return false;
			}
			if($('input#phone2').val() == '') {
				alert('연락처는 반드시 입력하셔야합니다.');
				$('input#phone2').focus();
				return false;
			}
			if($('input#phone3').val() == '') {
				alert('연락처는 반드시 입력하셔야합니다.');
				$('input#phone3').focus();
				return false;
			}
// 		if($('input#zip_code').val() == '') {
// 			alert('주소는 반드시 입력하셔야합니다.');
// 			$('input#zip_code').focus();
// 			return false;
// 		}
// 		if($('input#address').val() == '') {
// 			alert('주소는 반드시 입력하셔야합니다.');
// 			$('input#address').focus();
// 			return false;
// 		}

			if($('input#visit_num').val() == '') {
				alert('신청인원은 반드시 입력하셔야합니다.');
				$('input#visit_num').focus();
				return false;
			}
			if($('input#visit_date').val() == '') {
				alert('사용 희망일은 반드시 입력하셔야합니다.');
				$('input#visit_date').focus();
				return false;
			}
			if($('input[name=visit_time_list]:checked').length == 0) {
				alert('사용시간을 선택하셔야합니다..');
				$('input#visit_time_list').focus();
				return false;
			}
			if($('textarea#etc').val() == '') {
				alert('사용목적을 반드시 입력하셔야합니다.');
				$('textarea#etc').focus();
				return false;
			}

			if($("#circles_file").val() == '') {
				$("#circles_file").focus();
				alert("토론회 계획서 파일은 필수 첨부 입니다.")
				return false;
			}

			var selectedValue = $("#circles_div option:selected").val();
			switch (selectedValue) {
				case "1" :
					if($('input#visit_num').val() > 14) {
						alert("소담방1실 최대인원은 14명입니다.")
						return false;
					}
				case "2" :
					if($('input#visit_num').val() > 14) {
						alert("소담방2실 최대인원은 14명입니다.")
						return false;
					}
					break;
				case "3" :
					if($('input#visit_num').val() > 8) {
						alert("소담방3실 최대인원은 8명입니다.")
						return false;
					}
					break;
				case "4" :
					if($('input#visit_num').val() > 10) {
						alert("소담방4실 최대인원은 10명입니다.")
						return false;
					}
					break;
				case "5" :
					if($('input#visit_num').val() > 20) {
						alert("소담방5~6실 최대인원은 20명입니다.")
						return false;
					}
					break;
				case "7" :
					if($('input#visit_num').val() > 5) {
						alert("소담방7실 최대인원은 5명입니다.")
						return false;
					}
					break;
			}

			var file = $("#circles_file").val();
			if(!file){
				$("#circles_file").remove();
			}

			var phone = $('input#phone1').val() + "-" + $('input#phone2').val() + "-" + $('input#phone3').val();
			var tel = $('input#tel1').val() + "-" + $('input#tel2').val() + "-" + $('input#tel3').val();
			var addr = "(" + $('input#zip_code').val() + ") " + $('input#address').val();

			$('input#user_phone').val(phone);
			$('input#user_tel').val(tel);
			$('input#user_addr').val(addr);

			$('input#editMode').val('ADD');

			// doAjaxPost($('form#circlesRoom'));
			var option = {
				url : 'save.do',
				type : 'POST',
				success : function(response) {
					if(response.valid) {
						alert(response.message);
						doGetLoad(response.url, response.data);
					} else {
						$('td.realFile').append(file);
						if ( response.message != null ) {
							alert(response.message);
						} else {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								break;
							}
						}
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				}
			}

			$('form#circlesRoom').ajaxSubmit(option);
		});

		// 화면시작시 option 추가
		for (let i = 5; i <= 14; i++) {
			$("#visit_num").append("<option value=" + i + ">"+ i +"</option>");
		}

		<c:choose>
			<c:when test="${202303010000 <= now && now <= 20230606235959}">
			$('select#circles_div option[value="6"]').remove();
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	});

	function checkOnlyOne(element) {
		const checkboxes = document.getElementsByName("visit_time_list");
		checkboxes.forEach(function(checkbox) {
			checkbox.checked = false;
		})
		element.checked = true;
	}

	function ChangeUserCount(obj) {
		let roomNumber = $(obj).children("option:selected").val();
		let userCount = 0;
		switch (roomNumber) {
			case "1" : userCount = 14;
				break;
			case "2" : userCount = 14
				break;
			case "3" : userCount = 8;
				break;
			case "4" : userCount = 10;
				break;
			case "5" : userCount = 20
				break;
			case "6" : userCount = 5;
				break;
			default :
		}
		let startNumber = roomNumber != 5 ? 5 : 11;

		$("#visit_num option").remove();
		for (let i = startNumber; i <= userCount; i++) {
			$("#visit_num").append("<option value=" + i + ">" + i + "</option>");
		}
	}

</script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<h4>개인정보 수집 및 이용 동의</h4>
<div class="warn-txt">
    <ul class="con">
	<li><strong>개인정보 수집.이용 목적 :</strong> 도서관 홈페이지를 이용하여 동아리방 사용을 신청하시는 분들의 본인 확인, 동아리방 신청 승인을 위해 수집하며, 수집된 정보는 관련 업무에만 이용됩니다.</li>
	<li><strong>수집하려는 개인정보의 항목 :</strong> 필수항목 - 신청자의 이름, 휴대폰 연락처, 주소, 신청인원, 사용희망일, 사용시간, 사용목적 / 선택항목 - 신청자의 유선 연락처</li>
	<li><strong>보유 및 이용기간 :</strong> 수집한 개인정보는 1년 동안 보유하며, 요청 시 모든 개인정보를 즉시 삭제합니다.</li>
	<li><strong>동의거부 권리 및 불이익 :</strong> 동의를 거부할 권리가 있으며, 거부 시 동아리방 신청 서비스에 제한이 따를 수 있습니다</li>
	</ul>
</div>
<div class="mg10t"></div>
&nbsp;<input type="checkbox" id="agree1"><label for="agree1"> 본인은 위 내용을 숙지하였으며 이에 동의합니다.</label>

<br />
<br />

<h4>신청요건</h4>
<div class="warn-txt">
    <ul class="con">
	<li><strong>신청인원 :</strong> 5 ~ 20명</li>
	<li><strong>신청방법 :</strong> 홈페이지 사전신청(사용 7일전까지 신청하여야 승인 가능)</li>
	<li><strong>이용기간 :</strong> 1. 1주당 1회, 1개월에 3회, 1회당 2시간까지 이용가능</li>
	<li class="red">친목도모, 영리행위, 종교활동, 정치활동을 위한 동아리방 사용은 제한됩니다.</li>
</div>
<div class="mg10t"></div>
&nbsp;<input type="checkbox" id="agree2"><label for='agree2'> 본인은 위 내용을 숙지하였으며 이에 동의합니다.</label>

<br />
<br />

<form:form modelAttribute="circlesRoom" action="save.do" method="post" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="user_id"/>
	<form:hidden path="user_ci"/>
	<form:hidden path="user_phone"/>
	<form:hidden path="user_tel"/>
	<form:hidden path="user_addr"/>
	<table class="circle-tbl">
		<colgroup>
			<col style="width:18%"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th>동아리 구분</th>
				<td>
					<form:select path="circles_div" cssClass="selectmenu" onchange="ChangeUserCount(this)">
						<form:options items="${circlesDivCode}" itemLabel="code_name" itemValue="code_id"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>동아리명</th>
				<td>
					<form:input path="circles_title"/>
				</td>
			</tr>
			<tr>
				<th><span class="point">*</span>이름</th>
				<td><form:input path="user_name"/></td>
			</tr>
			<tr>
				<th><span class="point">*</span>휴대폰</th>
				<td>
					<input type="text" id="phone1" maxlength="3" class="text-short">&nbsp;-&nbsp;
					<input type="text" id="phone2" maxlength="4" class="text-short">&nbsp;-&nbsp;
					<input type="text" id="phone3" maxlength="4" class="text-short">
				</td>
			</tr>
			<tr>
				<th>유선전화</th>
				<td>
					<input type="text" id="tel1" maxlength="3" class="text-short">&nbsp;-&nbsp;
					<input type="text" id="tel2" maxlength="4" class="text-short">&nbsp;-&nbsp;
					<input type="text" id="tel3" maxlength="4" class="text-short">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" id="zip_code" class="text-short"><a href="#" id="findPostCode" class="btn">우편번호 찾기</a><br>
					<input type="text" id="address" class="text-long">
				</td>
			</tr>
			<tr>
				<th><span class="point">*</span>신청인원</th>
				<td>
					<form:select path="visit_num" cssClass="selectmenu"></form:select>
				</td>
			</tr>
			<tr>
				<th><span class="point">*</span>사용희망일</th>
				<td><form:input path="visit_date" readonly="readonly"/>
				<p>※신청일이 현재날짜보다 7일 정도 여유있게 신청해주셔야 승인됩니다.</p>
				</td>
			</tr>
			<tr>
				<th><span class="point">*</span>사용기간</th>
				<td>
					<form:checkboxes items="${reqTimeCode}" path="visit_time_list" itemLabel="code_name" itemValue="code_id" onclick='checkOnlyOne(this)'/>
					<p>※한번 신청하실때 1-TIME까지만 신청이 가능합니다. </p>
				</td>
			</tr>
			<tr>
				<th><span class="point">*</span>사용목적</th>
				<td>
					<form:input path="etc" cssStyle="width:60%"/>
					<p>※입력 예 : 독서토론 모임 </p>
				</td>
			</tr>
			<tr>
				<th><span class="point">*</span>동아리소개서 및<br> 토론회 계획서</th>
				<td class="fileTd" id="circles_file_td">
					<input type="file" id="circles_file" name="circles_file" title="파일선택"> <a href="https://library.busan.go.kr/board/boardFile/download/604/73171068/119792.do" class="btn btn5">동아리 소개서 및 토론회 계획서 다운로드</a>
					<p>※ 문서파일만 업로드 가능합니다.</p>
				</td>
			</tr>
		</tbody>
	</table>
    <div class="mg20t"></div>
	<div class="center">
		<a href="#" id="save" class="save">확인</a>
		<a href="#" id="list" class="cancel">취소</a>
	</div>

</form:form>
