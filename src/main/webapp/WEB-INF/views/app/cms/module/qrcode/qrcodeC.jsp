<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="header.jsp"%>
<script type="text/javascript">
$(function(){
	$('a#step3-next-btn').on('click', function(e) {
		var width 	= $('[name="width"]:checked').val();
		var url 	= $('#url').val();
		var contents = '';
		if ( $('#qrCodeDiv').val() != 'A' ) {
			contents = url;
		}
		else {
			var title     =   $('#title').val();
			var name      =   $('#name').val();
			var tel       =   $('#tel').val();
			var email     =   $('#email').val();
			var addr      =   $('#addr').val();
			var home_pg   =   $('#home_pg').val();
			var memo      =   $('#memo').val();

			var text1 = 'MECARD:TITLE:'+title+';N:'+name+';TEL:'+ tel +';EMAIL:'+email+';ADR:'+addr+';URL:'+home_pg+';NOTE:'+memo+';';
			contents = text1;
		}
		contents = encodeURIComponent(contents);
		
		$('div.qrView').html('');
		
		var src = 'http://chart.apis.google.com/chart?cht=qr&chof=gif&chl='+contents+'&choe=UTF-8&chld=H|2&chs='+width; 
		
		$("div.qrView").html('<img alt="QR코드" src="' + src + '">');
		e.preventDefault();
	});
	
	$('a#back-step').on('click', function(e) {
		$('#form3').attr('action', 'qrcodeB.do');
		$('#form3').submit();
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
<form:form id="form3" modelAttribute="qrcode" action="qrcodeC.do">
	<form:hidden path="qrCodeDiv"/>
	<form:hidden path="title"/>
	<div class="qrCodeCreat">
		<h1>QR코드 생성하기</h1>
		<ol>
			<li><b>Step1.</b> <span>정보 입력 선택</span></li>
			<li class="bar"><i class="fa fa-angle-right"></i></li>
			<li><b>Step2.</b> <span>기본 정보 입력</span></li>
			<li class="bar"><i class="fa fa-angle-right"></i></li>
			<li class="active"><b>Step3.</b> <span>추가 정보 입력</span></li>
		</ol>
	
		<div class="step3">
			<table class="bbs">
				<tbody>
					<tr>
						<th>코드제목</th>
						<td><form:input path="title" type="text" class="txt"/></td>
					</tr>
					<c:if test="${ qrcode.qrCodeDiv == 'A' }">
						<tr>
							<th>이름</th>
							<td><form:input path="name" type="text" class="txt"/></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><form:input path="tel" type="text" class="txt"/></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><form:input path="email" type="text" class="txt"/></td>
						</tr>
						<tr>
							<th>주소</th>
							<td><form:input path="addr" type="text" class="txt"/></td>
						</tr>
						<tr>
							<th>홈페이지 URL</th>
							<td><form:input path="home_pg" type="text" class="txt"/></td>
						</tr>
						<tr>
							<th>메모</th>
							<td><form:input path="memo" type="text" class="txt"/></td>
						</tr>
					</c:if>
					
					<c:if test="${ qrcode.qrCodeDiv == 'B' }">
						
						<tr>
							<th>URL입력</th>
							<td><form:input path="url" type="text" class="txt"/></td>
						</tr>
					</c:if>
					
					<tr>
						<th>사이즈</th>
						<td class="hand">
							<form:radiobutton id="bigSize" path="width" value="367" />9.7cm x 9.7cm 
							<form:radiobutton id="midSize" path="width" value="235" />6.2cm x 6.2cm 
							<form:radiobutton id="smaSize" path="width" value="138" />3.7cm x 3.7cm 
						</td>
					</tr>
				</tbody>
			</table>
			<div class="qrView">
				<img src="/resources/common/img/noimg-gall.png" alt="이미지 없음"/>
			</div>
		</div>
	
		<div class="btn-area txt-center">
			<a href="" class="fl btn" id="back-step"><i class="fa fa-angle-left"></i> <span>이전단계</span></a>
			<a href="" class="fl btn btn1" id="step3-next-btn"><span>작성완료</span></a>
			<a href="" class="fr btn" id="btn-cancel"><i class="fa fa-close"></i> <span>작성취소</span></a>
		</div>
	</div>
</form:form>