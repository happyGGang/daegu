<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- <link rel="stylesheet" href="${getContextPath}/resources/cms/smsSend/css/common.css" type="text/css" title="style" /> --%>
<link rel="stylesheet" href="${getContextPath}/resources/cms/smsSend/css/sms.css" type="text/css" title="style" />
<script type="text/javascript">
var isMMS = true;
$(function() {
	$('div.wrapper-white').css('height', 500);
	<%--메세지작성--%>
	$('textarea#send_msg').on('keyup', function(e) {
		calculateBytes($(this).val());
	});
	
	$('a.dialog-add').on('click', function(e) {
		e.preventDefault();
		
		if($('#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			return false;
		}
		
		$('input#yearmonth').val($(this).attr('keyValue'));
		var formData = 'edit.do?' + serializeParameter(['manage_idx', 'homepage_id', 'editMode', 'yearmonth']);
		$('#dialog-1').load(formData, function( response, status, xhr ) {
			$('#dialog-1').dialog({
				width: 600,
				height: 300
			});	
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-modify').on('click', function(e) {
		e.preventDefault();
		$('input#yearmonth').val($(this).attr('keyValue'));
		$('input#editMode').val('MODIFY');
		var formData = 'edit.do?' + serializeParameter(['manage_idx', 'homepage_id', 'editMode', 'yearmonth']);
		$('#dialog-1').load(formData, function( response, status, xhr ) {
			$('#dialog-1').dialog({
				width: 600,
				height: 300
			});
			$('#dialog-1').dialog('open');
		});
	});
	
	$('div.tab1 a').on('click', function(e) {
		e.preventDefault();

		$('#tab_status').val($(this).attr('keyValue'));
			
		if($('#tab_status').val() == 'table1') {
			$('#apply_status').val('1');
		} else if($('#tab_status').val() == 'table2') {
			$('#apply_status').val('2');
		} else if($('#tab_status').val() == 'table3') {
			$('#apply_status').val('3');
		}
		
		$('div.tab1 li').each(function() {
			$(this).removeClass('active');
		});
		$(this).parent('li').addClass('active');
		
		doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		
	});
	
	$('div.tab1 li').removeClass('active');
	$('li#' + $('#tab_status').val()).addClass('active');
	
	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	/* 상단 콤보박스 제어 */
	$('a.search_btn').on('click', function(e) {
		$('#status').val('1');
		doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		e.preventDefault();
	});
	
	$('select#homepage_id').on('change', function(e) {
		if($(this).val() != '') {
			$('select#codeList_1').val("");
			$('select#codeList_2').val("");
			$('select#codeList_3').val("");
			$('select#codeList_4').val("");
			$('#status').val("");
			$('#tab_status').val("table1");
			
			doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		}
		e.preventDefault();
	});
	
	$('select#codeList_1').on('change', function(e) {
		
		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}
		
		if($(this).val() != '') {
			$('select#codeList_2').val("");
			$('select#codeList_3').val("");
			$('select#codeList_4').val("");
			$('#status').val("");
			
			doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		}
		e.preventDefault();
	});
	
	//select box 제어
	if($('select#codeList_1').val() == '1') {
		$('div.selectBox').css('display','none');

		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		
		$('#table1 > a > font').text('참여');
		$('#table2 > a > font').text('후보');
		$('#table3 > a > font').text('취소');
		
	} else if($('select#codeList_1').val() == '2') {
		$('div.selectBox').css('display','none');
		
		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		$('#div_select_list5').css('display','inline');
		
		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('대기');
		$('li#table3').css('display','none');
		
	} else if($('select#codeList_1').val() == '3') {
		$('div.selectBox').css('display','none');
		
		$('#div_select_list2').css('display','inline');
		$('#div_select_list3').css('display','inline');
		$('#div_select_list4').css('display','inline');
		
		$('#table1 > a > font').text('완료');
		$('#table2 > a > font').text('접수');
		$('li#table3').css('display','none');
		
	} else if($('select#codeList_1').val() == '4') {
		$('div.selectBox').css('display','none');
		
		$('#div_select_list2').css('display','inline');
		
		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');
		
	} else if($('select#codeList_1').val() == '5') {
		$('div.selectBox').css('display','none');
		
		$('#div_select_list2').css('display','inline');
		
		$('#table1 > a > font').text('배정완료');
		$('#table2 > a > font').text('대기자');
		$('li#table3').css('display','none');
		
	} else if($('select#codeList_1').val() == '6') {
		$('div.selectBox').css('display','none');		
		
		$('#div_datepicker').css('display','inline');
		
		$('#table1 > a > font').text('승인');
		$('#table2 > a > font').text('미승인');
		$('li#table3').css('display','none');
	} else {
		$('div.selectBox').css('display','none');
	}
	
	$('select#codeList_2').on('change', function(e) {
		
		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}
		
		if($(this).val() != '') {
			doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		}
		e.preventDefault();
	});
	
	$('select#codeList_3').on('change', function(e) {
		
		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}
		
		if($(this).val() != '') {
			doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		}
		e.preventDefault();
	});
	
	$('select#codeList_4').on('change', function(e) {
		
		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}
		
		if($(this).val() != '') {
			doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		}
		e.preventDefault();
	});
	
	$('select#codeList_5').on('change', function(e) {
		
		if($('select#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			$('select#codeList_1').val("");
			return false;
		}
		
		if($(this).val() != '') {
			doGetLoad('index.do', serializeCustom($('form#smsSendForm')));
		}
		e.preventDefault();
	});
	
	//체크박스 이벤트
	
	$('.checkAll').on('click', function(e) {
		if($(".checkAll").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false); 
		}
		e.preventDefault();
	});
	
	$('a#justSend').on('click', function(e) {
		var type_str = "SMS";
		
		if($(":checkbox[name='checkbox']:checked").length < 1) {
			alert('SMS발송 대상자를 1명 이상 선택하세요.');
			return;
		}
		
		if(isMMS) {
			type_str = "MMS";
		}
		
		if(confirm($(":checkbox[name='checkbox']:checked").length +"명에게"+ type_str + "발송을 하시겠습니까?")) {
			
			$('textarea#real_msg').val($('textarea#send_msg').val());
			
			var chked_val = "";
			$(":checkbox[name='checkbox']:checked").each(function(pi,po){
				chked_val += ","+po.value;
			});
			if(chked_val!="")chked_val = chked_val.substring(1);
			
			$('#user_phone').val(chked_val);

			$('#caller_cell_phone').val($('#caller_cell_phone1').val()+'-'+$('#caller_cell_phone2').val()+'-'+$('#caller_cell_phone3').val());
			
			$('#smsSendForm').attr('action','send.do');
			
			if(doAjaxPost($('#smsSendForm'))) {
				location.reload();
				$('#smsSendForm').attr('action','index.do');
			}
		}
		e.preventDefault();
	});
	
	
	
});

function calculateBytes(str) {
	var length = getLength(str);
	$('strong#currBytes').text(length);

	if (length < 81) {
		isMMS = false;
	} else {
		isMMS = true;
	}
	
	if (isMMS) {
		if (length < 81) {
// 			type = mmsPoint;
		} else if (length > 4000) {
			str = cutByte(str);
			alert('4000바이트를 초과할 수 없습니다.');
			$('strong#currBytes').text( getLength(str));
			$('textarea#send_msg').val(str);
			return false;
		} else {
// 			type = mmsPoint;
		}
	} else {
		if (length < 81) {
			isMMS = false;
			$('span#maxBytes').text('80');
		} else {
 			$('span#maxBytes').text('80');
 			str = cutByte80(str);
 			alert('80바이트를 초과할 수 없습니다.');
			$('strong#currBytes').text( getLength(str));
			$('textarea#send_msg').val(str);
		}
	}
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
       if (l > 4000) {
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
	
<form:form modelAttribute="smsSend" id="smsSendForm" action="index.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="status"/>
<form:hidden path="tab_status"/>
<form:hidden path="apply_status"/>
<form:hidden path="user_phone"/>

<form:textarea path="send_msg" id="real_msg" cssStyle="display: none;" wrap="hard"/>
	<c:if test="${!member.admin}">
		<form:hidden path="homepage_id"/>
	</c:if>
	<c:if test="${member.admin}">
		<div class="search">
			<fieldset>
				<label class="blind">검색</label>				
				<form:select class="selectmenu-search" style="width:300px" path="homepage_id">
					<form:option value="" label="홈페이지를 선택하세요." />
					<form:options itemValue="homepage_id" itemLabel="homepage_name" items="${homepageList}"/>
				</form:select> 
			</fieldset>
		</div>
	</c:if>
	<div class="search">
		<fieldset>
				메뉴구분 : 
				<label class="blind">메뉴구분</label>
				<form:select path="codeList_1" cssStyle="height:24px;">									
					<option value="">===선택===</option>
					<c:forEach var="i" varStatus="status" items="${menuType}">
						<option value="${i.code_id}" <c:if test="${i.code_id eq smsSend.codeList_1}">selected="selected"</c:if>>${i.code_name}</option>
					</c:forEach>
				</form:select>
				
				<div id="div_select_list2" class="selectBox" style="display:inline;">
					모듈2 :<label class="blind">모듈</label>
					<form:select path="codeList_2" cssStyle="height:24px;">									
						<option value="">===선택===</option>
						<c:forEach var="i" varStatus="status" items="${codeList_2}">
							<c:if test="${!smsSend.code_type_2}">
								<option value="${i.code_id_2}" <c:if test="${i.code_id_2 eq smsSend.codeList_2}">selected="selected"</c:if>>${i.code_name_2}</option>
							</c:if>
							<c:if test="${smsSend.code_type_2}">
								<option value="${i.code_id}" <c:if test="${i.code_id eq smsSend.codeList_2}">selected="selected"</c:if>>${i.code_name}</option>
							</c:if>
						</c:forEach>
					</form:select>
				</div>
				
				<div id="div_select_list3" class="selectBox" style="display:inline;">
					모듈3 : <label class="blind">모듈</label>
					<form:select path="codeList_3" cssStyle="height:24px;">									
						<option value="">===선택===</option>
						<c:forEach var="i" varStatus="status" items="${codeList_3}">
							<c:if test="${!smsSend.code_type_3}">
								<option value="${i.code_id_3}" <c:if test="${i.code_id_3 eq smsSend.codeList_3}">selected="selected"</c:if>>${i.code_name_3}</option>
							</c:if>
							<c:if test="${smsSend.code_type_3}">
								<option value="${i.code_id}" <c:if test="${i.code_id eq smsSend.codeList_3}">selected="selected"</c:if>>${i.code_name}</option>
							</c:if>
						</c:forEach>
					</form:select>
				</div>
				
				<div id="div_select_list4" class="selectBox" style="display:inline;">
					모듈4 :<label class="blind">모듈</label>
					<form:select path="codeList_4" cssStyle="height:24px;">									
						<option value="">===선택===</option>
						<c:forEach var="i" varStatus="status" items="${codeList_4}">
							<c:if test="${!smsSend.code_type_4}">
								<option value="${i.code_id_4}" <c:if test="${i.code_id_4 eq smsSend.codeList_4}">selected="selected"</c:if>>${i.code_name_4}</option>
							</c:if>
							<c:if test="${smsSend.code_type_4}">
								<option value="${i.code_id}" <c:if test="${i.code_id eq smsSend.codeList_4}">selected="selected"</c:if>>${i.code_name}</option>
							</c:if>
						</c:forEach>
					</form:select>
				</div>
				
				<div id="div_select_list5" class="selectBox" style="display:inline;">
					모듈5 :<label class="blind">모듈</label>
					<form:select path="codeList_5" cssStyle="height:24px;">									
						<option value="">===선택===</option>
						<c:forEach var="i" varStatus="status" items="${codeList_5}">
							<c:if test="${!smsSend.code_type_5}">
								<option value="${i.code_id_5}" <c:if test="${i.code_id_5 eq smsSend.codeList_5}">selected="selected"</c:if>>${i.code_name_5}</option>
							</c:if>
							<c:if test="${smsSend.code_type_5}">
								<option value="${i.code_id}" <c:if test="${i.code_id eq smsSend.codeList_5}">selected="selected"</c:if>>${i.code_name}</option>
							</c:if>
						</c:forEach>
					</form:select>
				</div>
				
				<div id="div_datepicker" class="selectBox" style="display:none;">
					신청일자 :<form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
				</div>
				
				<a class="btn search_btn">검색</a>
		</fieldset>
	</div>	
		<!-- 문자 전송 -->
		<div class="MD_sms" style="width: 220px; float: left;">
			<!-- 휴대폰 -->
			<div class="mobile">
				<textarea id="send_msg" class="off" wrap="hard" style="overflow-y: scroll; resize:none; top:61px;">여기에 메시지를 입력하세요.</textarea> 
				<div class="mobile_bot" style="margin-top: 64px;">
					<!-- 특수문자 -->
					
					<!--// 특수문자 -->
					<span class="info_byte"><strong id="currBytes">0</strong> / <span id="maxBytes">4000</span> byte</span>
					<p style="margin-top: -20px; display: none;" id="reserve">
						<span>예약 : <input type="text" id="rsvt" name="rsvt_ymd" readonly="readonly"/></span>
					</p>
					<p>
						<span>발신자</span>						
					</p>
					<p>
						<form:hidden path="caller_cell_phone"/>
<%-- 						<form:select path="caller_cell_phone1" cssStyle="width:60px;height:28px;"> --%>
<%-- 							<form:options items="${cellPhoneCode}" itemLabel="code_name" itemValue="code_id"/> --%>
<%-- 						</form:select> - --%>
						<form:input path="caller_cell_phone1" cssStyle="width:36px;" cssClass="text" maxlength="3"/> -
						<form:input path="caller_cell_phone2" cssStyle="width:36px;" cssClass="text" maxlength="4"/> -
						<form:input path="caller_cell_phone3" cssStyle="width:36px;" cssClass="text" maxlength="4"/>
					</p>
					<br/>
					<div align="center">
						<a href="#" id="justSend"><img src="${getContextPath}/resources/cms/smsSend/img/btn_sendNow.gif" width="90" height="38" alt="즉시전송" /></a>
					</div>				
				</div>
			</div>
		</div>
		<!--// 문자 전송 -->
		<div style="float:left; ">
			<div class="tabmenu tab1" style="padding: 0px;">
				<ul>
					<li class="active" id="table1"><a href="#" keyValue="table1" style="height:20px; width: 30px;"><font size="2">참여</font></a></li>
					<li class="" id="table2"><a href="#" keyValue="table2" style="height:20px; width: 30px;"><font size="2">후보</font></a></li>
					<li class="" id="table3"><a href="#" keyValue="table3" style="height:20px; width: 30px;"><font size="2">취소</font></a></li>
				</ul>
				<div align="right">
					건수 : ${fn:length(applyList)} 명
				</div>				
			
			</div>

			<table id="table1" style="display:block;">
				<thead style="display: block;">
					<tr>
						<th style="width:10px;"><input type="checkbox" id="checkAll" class="checkAll"/></th>
						<th style="width:65px;">이름</th>
						<th style="width:100px;">전화번호</th>
						<th style="width:200px;">기타</th>
					</tr>
					
				</thead>
				
				<tbody style="overflow: auto; display: block;">					
					<c:forEach var="i" varStatus="status" items="${applyList}">
						<tr>
							<td style="width:10px;">
								<input type="checkbox" id="c${i}" name="checkbox" value="${i.member_phone }" /></label>
							</td>
							<td style="width:65px;">
								<label for="c${i}">${i.member_name}</label>
							</td>
							<td style="width:100px;">
								${i.member_phone }
							</td>
							<td style="width:200px;">
								${i.imsi_v_1}
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>	
<!-- 			<table id="table2" style="display:none; height: 370px; "> -->
<!-- 				<thead style="display: block;"> -->
<!-- 					<tr> -->
<!-- 						<th style="width:10px;"><input type="checkbox" id="checkAll2"/></th> -->
<!-- 						<th style="width:65px;">이름</th> -->
<!-- 						<th style="width:100px;">전화번호</th> -->
<!-- 						<th style="width:200px;">기타</th> -->
<!-- 					</tr> -->
					
<!-- 				</thead> -->
				
				
<!-- 				<tbody style="overflow: auto; height: 300px; display: block;">					 -->
<%-- 					<c:forEach var="i" varStatus="status" items="${notApplyList}"> --%>
<!-- 						<tr> -->
<!-- 							<td style="width:10px;"> -->
<%-- 								<input type="checkbox" id="c${i}" /></label> --%>
<!-- 							</td> -->
<!-- 							<td style="width:65px;"> -->
<%-- 								<label for="c${i}">${i.member_name}</label> --%>
<!-- 							</td> -->
<!-- 							<td style="width:100px;"> -->
<%-- 								${i.member_phone } --%>
<!-- 							</td> -->
<!-- 							<td style="width:200px;"> -->
<%-- 								${i.imsi_v_1} --%>
<!-- 							</td> -->
<!-- 						</tr> -->
<%-- 					</c:forEach>						 --%>
<!-- 				</tbody> -->
<!-- 			</table>	 -->
			
			
		</div>
	
</form:form>
		
</div>