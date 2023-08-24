<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld"%>
<style>

input[type="button"] { cursor: pointer; }
input[type="text"], input[type="password"], select, .input, textarea {font-size: 15px; border: solid 1px #bcbcbc; border-radius: 3px; background: #fff; padding: 0 6px; margin: 2px; box-sizing: border-box;-moz-box-sizing: border-box;-webkit-box-sizing: border-box;letter-spacing: -0.04em;}
input[type="text"], input[type="password"], select, .input { height: 34px; line-height: 1em; }
textarea {overflow:auto; padding:10px; line-height: 1.3em;font-family:'Pretendard', 'Malgun Gothic', sans-serif;font-family: 'NanumSquare', sans-serif;font-size:15px;font-size: 14px;}
</style>
<script charset="UTF-8" type="text/javascript" src="//t1.daumcdn.net/postcode/api/core/190107/1546836247227/190107.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#user_id").val("");

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if($('input#user_id').val() == '') {
						alert('사용자 ID는 반드시 입력하셔야합니다.');
						$('input#user_id').focus();
						return false;
					}
					if($('input#user_name').val() == '') {
						alert('이름은 반드시 입력하셔야합니다.');
						$('input#user_name').focus();
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
					// if($('input#zip_code').val() == '') {
					// 	alert('주소는 반드시 입력하셔야합니다.');
					// 	$('input#zip_code').focus();
					// 	return false;
					// }
					// if($('input#address').val() == '') {
					// 	alert('주소는 반드시 입력하셔야합니다.');
					// 	$('input#address').focus();
					// 	return false;
					// }
					if($('input#visit_num').val() == '') {
						alert('신청인원은 반드시 입력하셔야합니다.');
						$('input#visit_num').focus();
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
/*
					var selectedValue = $("#circles_div_edit option:selected").val();
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
*/
					var phone = $('input#phone1').val() + "-" + $('input#phone2').val() + "-" + $('input#phone3').val();
					// var tel = $('input#tel1').val() + "-" + $('input#tel2').val() + "-" + $('input#tel3').val();
					var addr = "(" + $('input#zip_code').val() + ") " + $('input#address').val();
					// var visit_date = $('select#circlesRoom_year').val() + "-" + $('select#circlesRoom_month').val() + "-" + $('select#circlesRoom_day').val();
					
					$('input#user_phone').val(phone);
					// $('input#user_tel').val(tel);
					$('input#user_addr').val(addr);
					// $('input#visit_date').val(visit_date);
					
					$('input#editMode').val('ADD');

					var option = {
						url : 'save.do',
						type : 'POST',
						success : function(response) {
							if(response.valid) {
								alert(response.message);
								location.reload();
							} else {
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
					$('form#circlesRoom_add').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 600
	});
	
	var sysDate = new Date();
	var year = sysDate.getFullYear();
	var month = sysDate.getMonth()+1;
	var date = sysDate.getDate();
	var lastDate = new Date(sysDate.getYear(), sysDate.getMonth()+1, 0).getDate(); 
	for (var i=0; i<3; i++) {
		var optionYear = (year - i);
		var selectedAttr = '';
		
		if ( optionYear == year ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#circlesRoom_year').append('<option ' + selectedAttr + ' value="' + optionYear + '">' + optionYear + '년</option>');
	}
	// 월 초기화 
	for ( var j = 1; j < 13; j ++ ) {
		var valueMonth = '0'+j;
		var selectedAttr = '';
		valueMonth = valueMonth.substr(valueMonth.length - 2, valueMonth.length);
		
		if ( j == month ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#circlesRoom_month').append('<option ' + selectedAttr + ' value="' + valueMonth + '">' + j + '월</option>');
	}
	// 일 초기화 
	for ( var j = 1; j < lastDate+1; j ++ ) {
		var valueDay = '0'+j;
		var selectedAttr = '';
		valueDay = valueDay.substr(valueDay.length - 2, valueDay.length);
		
		if ( j == date ) {
			selectedAttr = 'selected="selected"';
		}
		
		$('#circlesRoom_day').append('<option ' + selectedAttr + ' value="' + valueDay + '">' + j + '일</option>');
	}
	
	$('input#zip_code').on('click', function(e) {
		e.preventDefault();
		$('a#findPostCode').click();
	});

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
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                $('#zip_code').val(data.zonecode);//5자리 새우편번호 사용
                $('#address').val(fullAddr);
                $('#address').focus();
            }
        }).open();
	});

	$('input#visit_date').datepicker({
		maxDate: $('input#visit_date').val(),
		onClose: function(selectedDate){
			$('input#visit_date').datepicker('option', 'minDate', selectedDate);
		}
	});


	// 화면시작시 option 추가
	for (let i = 5; i <= 14; i++) {
		$("#visit_num1").append("<option value=" + i + ">"+ i +"</option>");
	}

	$('input[name=visit_time_list]').on('click', function(e) {
		var chk_length = $('input[name=visit_time_list]:checked').length;
		if(chk_length > 3) {
			alert('이용 시간은 3시간까지 입니다.');
			e.preventDefault();
		}
	});
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

	$("#visit_num1 option").remove();
	for (let i = startNumber; i <= userCount; i++) {
		$("#visit_num1").append("<option value=" + i + ">" + i + "</option>");
	}
}
</script>
<form:form modelAttribute="circlesRoom" id="circlesRoom_add" action="save.do" method="post">
	<form:hidden path="homepage_id"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="user_ci"/>
	<form:hidden path="user_phone"/>
	<form:hidden path="user_tel"/>
	<form:hidden path="user_addr"/>
<%--	<form:hidden path="visit_date"/>--%>
	<table>
		<colgroup>
			<col width="25%">
			<col>
		</colgroup>
		<tr>
			<th>구분</th>
			<td>
				<form:select path="circles_div" id="circles_div_edit" onchange="ChangeUserCount(this)">
					<form:options items="${circlesDivCode}" itemLabel="code_name" itemValue="code_id"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>*사용자 ID</th>
			<td>
				<form:input path="user_id" />
			</td>
		</tr>
		<tr>
			<th>*이름</th>
			<td><form:input path="user_name"/></td>
		</tr>
		<tr>
			<th>*휴대폰</th>
			<td>
				<input type="text" id="phone1" maxlength="3">&nbsp;-&nbsp;
				<input type="text" id="phone2" maxlength="4">&nbsp;-&nbsp;
				<input type="text" id="phone3" maxlength="4">
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input type="text" id="zip_code"><a href="#" id="findPostCode" class="btn">우편번호 찾기</a><br>
				<input type="text" id="address" style="width:90%">
			</td>
		</tr>
		<tr>
			<th>*희망일</th>
			<td>
				<form:input path="visit_date" class="text ui-calendar" readonly="true"/>
			</td>
		</tr>
		<tr>
			<th>*시간</th>
			<td>
				<form:checkboxes items="${reqTimeCode}" path="visit_time_list" itemLabel="code_name" itemValue="code_id" onclick='checkOnlyOne(this)'/>&nbsp;
			</td>
		</tr>
		<tr>
			<th><span class="point">*</span>비고</th>
			<td>
				<form:input path="etc" cssStyle="width:90%"/>
			</td>
		</tr>
		<!-- <tr>
			<th>동아리명</th>
			<td>
				<form:input path="circles_title"/>
			</td>
		</tr>

		<tr>
			<th>유선전화</th>
			<td>
				<input type="text" id="tel1" maxlength="3">&nbsp;-&nbsp;
				<input type="text" id="tel2" maxlength="4">&nbsp;-&nbsp;
				<input type="text" id="tel3" maxlength="4">
			</td>
		</tr>

		<tr>
			<th><span class="point">*</span>신청인원</th>
			<td>
				<form:select path="visit_num" id="visit_num1" cssClass="selectmenu"></form:select>
			</td>
		</tr>
		<tr>
			<th>동아리소개서 및<br> 토론회 계획서</th>
			<td class="fileTd" id="circles_file_td">
				<input type="file" id="circles_file" name="circles_file" title="파일선택">
				<p>※ 문서파일만 업로드 가능합니다.</p>
			</td>
		</tr>
 -->
	</table>
</form:form>
