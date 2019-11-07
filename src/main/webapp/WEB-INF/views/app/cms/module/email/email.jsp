<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
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
.MD_sms .mobile .mobile_bot .info_byte strong{color:#87ace7}
</style>

<script type="text/javascript">
var isMMS = true;
var oEditors = [];
var prevEditorDisplay = '';
$(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "/resources/common/smart_editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {
			
		},
		fCreator: "createSEditor2"
	});
	
	try {
		prevEditorDisplay = $('.bbs-textarea iframe').css('display');
	} catch(e) { }
	$(window).on('resize', function(e) {
		try {
			var currEditorDisplay = $('.bbs-textarea iframe').css('display');
			if(prevEditorDisplay != currEditorDisplay) {
				prevEditorDisplay = currEditorDisplay;
				if(currEditorDisplay == 'none') {
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
				} else {
					oEditors.getById["content"].exec("LOAD_CONTENTS_FIELD");
				}
			}
		} catch(e) {
			
		}
	});
	
	$('div#module-search-layer').load('search.do');
	
	$('div#member-list-layer').load('memberLayer.do');
	
// 	$('div#emailbox-list-layer').load('emailboxLayer.do');
	
	$('a#sendMail').on('click', function(e) {
		
		var type_str = "EMAIL";
		
		if($(":checkbox[class='checkOne']:visible:checked").length < 1) {
			alert('EMAIL발송 대상자를 1명 이상 선택하세요.');
			return false;
		}
		
		if(confirm($(":checkbox[class='checkOne']:visible:checked").length +"명에게 발송을 하시겠습니까?")) {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
// 			$('textarea#real_msg').val($('textarea#send_msg').val());
			
			var chked_val = "";
			$(":checkbox[class='checkOne']:checked").each(function(pi,po){
				chked_val += ","+po.value;
			});
			if(chked_val!="")chked_val = chked_val.substring(1);

			$('#user_phone').val(chked_val);

			$('#caller_cell_phone').val($('#caller_cell_phone1').val()+'-'+$('#caller_cell_phone2').val()+'-'+$('#caller_cell_phone3').val());
			$('form#emailSend #homepage_id_1').val($('form#emailSend #homepage_id').val());
			
			$('#emailSend').attr('action','send.do');
			
			if(doAjaxPost($('#emailSend'))) {
// 				location.reload();
				$('#emailSend').attr('action','index.do');
			}
		}
		e.preventDefault();
	});
});
</script>

	<form:form modelAttribute="emailSend" action="save.do" method="post" onsubmit="return false;">		
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
			<div class="MD_sms" style="width: 700px; float: left; background: none;">
				<h4>EMAIL 작성</h4>
				<table class="bbs-edit">
					<tbody>
						<tr>
							<th>제목</th>
							<td>
								<form:input path="title" cssClass="text" cssStyle="width:90%" maxlength="100" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="editor">
								<div class="bbs-textarea">
									<form:textarea path="content" rows="15" cols="80" cssStyle="width:90%;"/>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 휴대폰 -->
				<div class="mobile" style="display: none;">
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
						<span class="info_byte"><strong id="currBytes">0</strong> / <span id="maxBytes">4000</span> byte</span>
						<p style="margin-top: -20px; display: none;" id="reserve">
							<span>예약 : <input type="text" id="rsvt" name="rsvt_ymd" readonly="readonly"/></span>
						</p>
						<ul class="sendBtns">
							<li><a href="#" id="justSend" class="btn btn2">메일 전송</a></li>
							<li style="margin-top:5px;margin-left:9px">
								<form:hidden path="caller_cell_phone"/>
								<form:input path="caller_cell_phone1" cssStyle="width:36px;" cssClass="text" maxlength="3"/> -
								<form:input path="caller_cell_phone2" cssStyle="width:36px;" cssClass="text" maxlength="4"/> -
								<form:input path="caller_cell_phone3" cssStyle="width:36px;" cssClass="text" maxlength="4"/>
							</li>
						</ul>
					</div>
				</div>
				<div class="button bbs-btn center">
					<a href="" class="btn" id="sendMail" keyValue="${i.member_key}">메일전송</a>
				</div>
			</div>
			<!-- 발송 대상자 리스트 -->
			<div id="member-list-layer" style="float:left;width:700px">
			</div>
			<!-- 문자함-->
			<div id="emailbox-list-layer" style="float:left;width:700px">
			</div>
		</div>
		<!--// 문자 전송 -->
	</form:form>
