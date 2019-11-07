<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@ include file="header.jsp"%> --%>
<jsp:include page="/WEB-INF/views/app/homepage/module/qrcode/header.jsp" flush="false" />
<script type="text/javascript">
$(function(){
	$('a#step1-next-btn').on('click', function(e) {
		$('#form1').submit();
		e.preventDefault();
	});
});	
</script>
<form:form id="form1" modelAttribute="qrcode" action="qrcodeB.do">
	<div class="qrCodeCreat">
		<h1>QR코드 생성하기</h1>
		<ol>
			<li class="active"><b>Step1.</b> <span>정보 입력 선택</span></li>
			<li class="bar"><i class="fa fa-angle-right"></i></li>
			<li><b>Step2.</b> <span>기본 정보 입력</span></li>
			<li class="bar"><i class="fa fa-angle-right"></i></li>
			<li><b>Step3.</b> <span>추가 정보 입력</span></li>
		</ol>
	
		<div class="step1">
			<div class="radio1">
				<label for="qrCodeDiv1">
					<span class="radioWrap">
						<form:radiobutton path="qrCodeDiv" value="A"/>
						<span class="choice">나만의 정보담기 선택</span>
						<em>개인정보를 코드에 저장할 수 있습니다.</em>
					</span>
				</label>
			</div>
			<div class="radio2">
				<label for="qrCodeDiv2">
					<span class="radioWrap">
						<form:radiobutton path="qrCodeDiv" value="B"/>
						<span class="choice">링크로 이동 선택</span>
						<em>특정 사이트에 바로 이동시킬 수 있습니다.</em>
					</span>
				</label>
			</div>
		</div>
	
		<div class="btn-area txt-right">
			<a href="" class="btn btn1" id="step1-next-btn"><span>다음단계</span> <i class="fa fa-angle-right"></i></a>
		</div>
	</div>
</form:form>