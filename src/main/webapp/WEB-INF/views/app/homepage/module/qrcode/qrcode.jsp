<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<script type="text/javascript" src="${conPath}/js/common.js"></script>
<script type="text/javascript" src="${conPath}/js/util/prototype.js"></script>
<script type="text/javascript" src="${conPath}/js/util/datePicker.js"></script>
<script type="text/javascript" src="${conPath}/js/util/timePicker.js"></script>
<script type="text/javascript" src="${conPath}/js/util/moneyPicker.js"></script>
<script type="text/javascript" src="${conPath}/js/util/floating-window.js"></script>
<script type="text/javascript" src="${conPath}/js/util/paging.js"></script>
<script type="text/javascript" src="${conPath}/js/util/menu.js"></script>
<script type="text/javascript" src="${conPath}/js/util/util.js"></script>
<script type="text/javascript" src="${conPath}/DGE_sys/js/common.js"></script>
<script type="text/javascript" src="${conPath}/js/jquery-latest.js"></script>
<script type="text/javascript" language="javascript">
function $RF(el, radioGroup) {
	if($(el).type && $(el).type.toLowerCase() == 'radio') {
		var radioGroup = $(el).name;
		var el = $(el).form;
	} else if ($(el).tagName.toLowerCase() != 'form') {
		return false;
	}
	var checked = $(el).getInputs('radio', radioGroup).find(
			function(re) {return re.checked;}
		);
	return (checked) ? $F(checked) : null;
}


function complete(){
	var title     =   $('title').value;
	var name      =   $('name').value;
	var company   =   $('company').value;
	var tel       =   $('tel').value;
	var email     =   $('email').value;
	var addr      =   $('addr').value;
	var home_pg   =   $('home_pg').value;
	var memo      =   $('memo').value;

	var text1 = 'MECARD:TITLE:'+title+';N:'+name+';TEL:'+ tel +';EMAIL:'+email+';ADR:'+addr+company+';URL:'+home_pg+';NOTE:'+memo+';';

	var width = $RF('form', 'width');
	//$('image').width = width;
	//$('image').height = width;

	//$('form').submit();
	//$('image').src = 'QRImage.do?text1='+text1+'&width='+width;

	var text_enc = encodeURIComponent(text1);
	$j("#result").html("");
	
	$j("#result").html("<img alt='QR코드입니다.' src='http://chart.apis.google.com/chart?cht=qr&chof=gif&chl="+text_enc+"&choe=UTF-8&chld=H|2&chs="+width+"'>");

	

}

function pre(){
	if($('qrCodeDiv').value == 'A'){
		$('form').action = 'qrCodeB.do';
	}else{
		$('form').action = 'qrCodeC.do';
	}
	$('form').submit();
}

function cancel(){
	$('form').action = 'qrCodeA.do';
	$('form').submit();
}

</script>
</head>
<body>
	<div class="popupQrCode">
		<!--form action=""-->
		<form:form id="form" commandName="qrcode" action="QRImage.do">
			<form:hidden path="qrCodeDiv"/>
			<h3><img src="/data-public/files/contentimage/tit_qrcode.gif" width="97" height="19" alt="QR코드 생성"/></h3>
			<ol class="steps step3">
				<li class="step1_label"><span class="blind">Step1.정보입력 선택</span></li>
				<li class="step2_label"><span class="blind">Step2.기본정보 입력</span></li>
				<li class="step3_label"><span class="blind">Step3.추가 정보 입력</span></li>
			</ol>
			<div class="stepCont brd_none">
				<div class="brd_write">
					<p class="write1">
						<label class="tit" for="text1">코드제목</label>
						<form:input path="title" cssStyle="width:300px" cssClass="txt1"/>
					</p>
					<p class="write1">
						<label class="tit" for="name">이름</label>
						<form:input path="name" cssStyle="width:300px" cssClass="txt1"/>
					</p>
					<p class="write1">
						<label class="tit" for="company">회사</label>
						<form:input path="company" cssStyle="width:300px" cssClass="txt1"/>
					</p>
					<p class="write1">
						<label class="tit" for="tel">연락처</label>
						<fst:tel id="tel" name="tel" value="${qrcode.tel}" telType="2" cssStyle="ime-mode:Disabled;" cssClass="txt1" />
					</p>
					<p class="write1">
						<label class="tit" for="email">이메일</label>
						<form:input path="email" cssStyle="width:300px" cssClass="txt1"/>
					</p>
					<p class="write1">
						<label class="tit" for="addr">주소</label>
						<form:input path="addr" cssStyle="width:300px" cssClass="txt1"/>
					</p>
					<p class="write1">
						<label class="tit" for="home_pg">홈페이지</label>
						<form:input path="home_pg" cssStyle="width:300px" cssClass="txt1"/>
					</p>
					<p class="write1" style="height:60px">
						<label class="tit" for="memo">메모</label>
						<form:input path="memo" cssStyle="width:300px; height:50px;" cssClass="txt1"/>
					</p>
					<p class="write1">
						<label class="tit" for="width">사이즈</label>
						<form:radiobutton id="bigSize" path="width" value="367" />9.7cm x 9.7cm
						<form:radiobutton id="midSize" path="width" value="235" />6.2cm x 6.2cm
						<form:radiobutton id="smaSize" path="width" value="138" />3.7cm x 3.7cm
				</div>
			</div>
			<form:hidden path="text1"/>
		</form:form>
		<div class="img_qrcode" id="result">  
			<img src="/images/board/noimg_138_108.gif" alt="noImage">
		</div>
		<div class="stepBtns">
		    <a href="#p" class="btn_prev fltL" onclick="pre();" title="클릭하시면 이전단계로 되돌아갑니다."><img src="/data-public/files/contentimage/btn_prevStep.gif" width="94" height="38" alt="이전단계"></a>
			<a href="#p" class="btn_complete fltL" onclick="complete();" title="클릭하시면 작성이 완료됩니다."><img src="/data-public/files/contentimage/btn_writeOk.gif" width="94" height="38" alt="작성완료"></a>
			<a href="#p" class="btn_cancel" onclick="cancel();" title="클릭하시면 작성하던 내용이 취소됩니다."><img src="/data-public/files/contentimage/btn_writeCancel.gif" width="94" height="38" alt="작성취소"></a>
           </div>
	</div>
</body>
</html>