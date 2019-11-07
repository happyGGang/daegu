<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/cms/css/container.css"/>
<style>
.sms_area{overflow:hidden}
.MD_sms{background:url('/resources/cms/smsSend/img/mobile.gif') no-repeat}
.MD_sms .title{font-weight:800;height:60px;text-align:center}
.MD_sms .title p{padding-top:15px;font-size:120%}
.MD_sms .title .color1{color:#038606}
.MD_sms .title .color2{color:#003fa1}
.MD_sms .mobile{padding:0 8px;height:438px}
.MD_sms .mobile textarea{position:relative;resize:none;background:#3162aa url('/resources/cms/smsSend/img/sms_txtbox_bg.gif') no-repeat 0 0;border:none;width:169px;height:212px;color:#fff;padding:8px;overflow-y:auto;border:1px solid #00236f}
.MD_sms .mobile .mobile_bot .info_byte{float:right;margin-right:20px}
.MD_sms .mobile .mobile_bot .info_byte strong.sms{color:#87ace7}
.MD_sms .mobile .mobile_bot .info_byte strong.mms{color:#FF5E00}
</style>

<script type="text/javascript">
var isMMS = false;
var msgTextareaInit = false;
$(function() {
	$('div#module-search-layer').load('search.do');
	
	$('div#member-list-layer').load('memberLayer.do');
	
	$('div#smsbox-list-layer').load('smsboxLayer.do');
	
	$('textarea#send_msg').on('keyup change', function(e) {
		calculateBytes($(this).val());
	});
	
	$('textarea#send_msg').on('focus', function(e) {
		if (!msgTextareaInit) {
			$(this).val('');
			msgTextareaInit = true;
		}
	});
	
	$('a#justSend').on('click', function(e) {
		
		if (!checkMsg()) {
			return false;
		}
		
		var type_str = "SMS";
		
		if ($('input#sendListCheck')) {
			$('input#sendListCheck').prop('checked', false);
			$('input#sendListCheck').click();
		}
		
		if($(":checkbox[class='checkOne']:checked").length < 1) {
			alert('발송 대상자를 1명 이상 선택하세요.');
			return;
		}
		
		if(isMMS) {
			type_str = "MMS";
		}
		
		if(confirm($(":checkbox[class='checkOne']:checked").length +" 명에게 "+ type_str + "발송을 하시겠습니까?")) {
			$('textarea#real_msg').val($('textarea#send_msg').val());
			
			var chked_val = "";
			$(":checkbox[class='checkOne']:checked").each(function(pi,po){
				chked_val += ","+po.value;
			});
			if(chked_val!="")chked_val = chked_val.substring(1);

			$('#user_phone').val(chked_val);

			$('#caller_cell_phone').val($('#caller_cell_phone1').val()+'-'+$('#caller_cell_phone2').val()+'-'+$('#caller_cell_phone3').val());
			$('form#smsSend #homepage_id_1').val($('form#smsSend #homepage_id').val());
			
			$('#smsSend').attr('action','send.do');
			
			if(doAjaxPost($('#smsSend'))) {
// 				location.reload();
// 				$('#smsSend').attr('action','index.do');
			}
		}
		e.preventDefault();
	});
});
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).val($(this).val().replace(/[^0-9]/gi, ""));
});

</script>

	
	<form:form modelAttribute="smsSend" action="save.do" method="post" onsubmit="return false;">		
<%-- 		<c:if test="${!member.admin}"> --%>
			<form:hidden id="homepage_id_1" path="homepage_id"/>
<%-- 		</c:if> --%>
<%-- 		<form:hidden path="editMode"/> --%>
<%-- 		<form:hidden path="status"/> --%>
<%-- 		<form:hidden path="tab_status"/> --%>
<%-- 		<form:hidden path="apply_status"/> --%>
		<form:hidden path="user_phone"/>
	
		<textarea id="real_msg" name="send_msg" style="display: none;" wrap="hard"></textarea>
		
		<!-- 각 모듈 검색 조건 -->
		<div id="module-search-layer"></div>
		
		<!-- 문자 전송 -->
		<div class="sms_area">
			<div class="MD_sms" style="width: 220px; float: left;">
				<!-- 휴대폰 -->
				<div class="mobile">
					<div class="title">
						<p>
							<span class="color1">문자</span>
							<span class="color2">메시지</span>
						</p>
					</div>
					<textarea id="send_msg" class="off" wrap="hard">여기에 메시지를 입력하세요.</textarea> 
					<div class="mobile_bot">
						<!-- 특수문자 -->
						<!--// 특수문자 -->
						<span class="info_byte"><strong id="currBytes" class="sms">0</strong> / <span id="maxBytes">2000</span> byte</span>
						<p style="margin-top: -20px; display: none;" id="reserve">
							<span>예약 : <input type="text" id="rsvt" name="rsvt_ymd" readonly="readonly"/></span>
						</p>
						<ul class="sendBtns">
							<li>
								<a href="#" id="justSend" class="btn btn2">즉시전송</a>
							</li>
							<li style="margin-top:5px;margin-left:9px">
								발신번호 <br/>
								<form:hidden path="caller_cell_phone"/>
								<form:input path="caller_cell_phone1" cssStyle="width:36px;" cssClass="text" maxlength="3" numberOnly="true"/> -
								<form:input path="caller_cell_phone2" cssStyle="width:36px;" cssClass="text" maxlength="4" numberOnly="true"/> -
								<form:input path="caller_cell_phone3" cssStyle="width:36px;" cssClass="text" maxlength="4" numberOnly="true"/>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- 발송 대상자 리스트 -->
			<div id="member-list-layer" style="float:left;width:700px">
			</div>
			<!-- 문자함-->
			<div id="smsbox-list-layer" style="float:left;width:565px">
			</div>
		</div>
		<!--// 문자 전송 -->
	</form:form>
		
<script>

function calculateBytes(str) {
	var length = getLength(str);
	$('strong#currBytes').text(length);
	if (isMMS) {
		if (length < 81) {
			isMMS = false;
			$('strong#currBytes').removeClass('mms');
			$('strong#currBytes').addClass('sms');
			return true;
		} else if (length > 2000) {
			isMMS = true;
			str = cutByte(str);
			$('strong#currBytes').removeClass('sms');
			$('strong#currBytes').addClass('mms');
			alert('2000바이트를 초과할 수 없습니다.');
			$('strong#currBytes').text( getLength(str));
			$('textarea#send_msg').val(str);
			return false;
		}
	} else {
		if (length < 81) {
			isMMS = false;
			$('strong#currBytes').removeClass('mms');
			$('strong#currBytes').addClass('sms');
			return true;
		} else {
			isMMS = true;
			$('strong#currBytes').removeClass('sms');
			$('strong#currBytes').addClass('mms');
			if (length > 2000) {
				isMMS = true;
				str = cutByte(str);
				$('strong#currBytes').removeClass('sms');
				$('strong#currBytes').addClass('mms');
				alert('2000바이트를 초과할 수 없습니다.');
				$('strong#currBytes').text( getLength(str));
				$('textarea#send_msg').val(str);
				return false;
			} else {
				alert('80바이트를 초과하여 MMS로 전환됩니다.');
				return true;
			}
		}
	}
}


function checkMsg() {
	var str = $('textarea#send_msg').val();
	var length = getLength(str);
	$('strong#currBytes').text(length);
	if (length > 2000) {
		isMMS = true;
		str = cutByte(str);
		$('strong#currBytes').removeClass('sms');
		$('strong#currBytes').addClass('mms');
		alert('2000바이트를 초과할 수 없습니다.');
		$('strong#currBytes').text( getLength(str));
		$('textarea#send_msg').val(str);
		return false;
	}
	return true;
}


var cutByte80 = function(str) {
	var l = 0;
	for (var i=0; i<str.length; i++) {
       l += (str.charCodeAt(i) > 128) ? 2 : 1;
       if (l > 80) {
    	   return str.substring(0,i);
       }
	}
	return str;
};

var cutByte = function(str) {
	var l = 0;
	for (var i=0; i<str.length; i++) {
       l += (str.charCodeAt(i) > 128) ? 2 : 1;
       if (l > 2000) {
    	   return str.substring(0,i);
       }
	}
	return str;
};

function getLength(s, b, i, c) {
	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
	return b;
}

</script>
