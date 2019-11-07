<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="header.jsp"%>
<script type="text/javascript">
$(function(){
	$('a#step2-next-btn').on('click', function(e) {
		if( $('#title').val() == null || $('#title').val() == '' ) {
			alert("코드제목을 입력하여 주세요.");
		}
		$('#form2').submit();
		e.preventDefault();
	});
	
	$('a#back-step').on('click', function(e) {
		$('#form2').attr('action', 'qrcodeA.do');
		$('#form2').submit();
		e.preventDefault();
	});
	
	
	$('input#title').on('keydown', function() {
		var strLength = this.value.length;
		$('#curLen').text(strLength);
	});
	
	$('a#btn-cancel').on('click', function(e) {
		$('#form3').attr('action', 'qrcodeA.do');
		$('#form3').submit();
		e.preventDefault();
	});
});	
</script>
<form:form id="form2" modelAttribute="qrcode" action="qrcodeC.do" method="post">
	<form:hidden path="qrCodeDiv"/>
	<div class="qrCodeCreat">
		<h1>QR코드 생성하기</h1>
		<ol>
			<li><b>Step1.</b> <span>정보 입력 선택</span></li>
			<li class="bar"><i class="fa fa-angle-right"></i></li>
			<li class="active"><b>Step2.</b> <span>기본 정보 입력</span></li>
			<li class="bar"><i class="fa fa-angle-right"></i></li>
			<li><b>Step3.</b> <span>추가 정보 입력</span></li>
		</ol>
	
		<div class="step2">
			<h2>코드제목</h2>
			<div class="field">
				<form:input path="title" type="text" maxlength="20"/>
			</div>
			<p class="txt-right"><span id="curLen">0</span> / 20자 <em>(필수 입력 사항)</em></p>
		</div>
	
		<div class="btn-area txt-center">
			<a href="" class="fl btn" id="back-step"><i class="fa fa-angle-left"></i> <span>이전단계</span></a>
			<a href="" class="fl btn btn1" id="step2-next-btn"><span>다음단계</span> <i class="fa fa-angle-right"></i></a>
			<a href="" class="fr btn" id="btn-cancel"><i class="fa fa-close"></i> <span>작성취소</span></a>
		</div>
	</div>
</form:form>