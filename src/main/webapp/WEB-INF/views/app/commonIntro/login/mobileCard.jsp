<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/common/js/jquery-barcode.js"></script>
<script type="text/javascript">
$(function(){

	var settings = {
		barWidth: 2,
		barHeight: 70,
		fontSize : 12,
		output : 'bmp'
	};

	$("#barcodeTarget").barcode('${sessionScope.member.user_no}', "code128", settings);
	$("#barcodeTarget").css("margin","0 auto");

});
</script>
<div style="text-align:center;padding:0 0 10px 0;font-size:27px;font-weight:bold">${sessionScope.member.member_name}</div>

<div id="barcodeTarget" class="barcodeTarget" style="padding:0px;overflow:auto;"></div>
<div style="text-align:center">${sessionScope.member.user_no}</div>

<div class="loanNum" style="padding-top:20px;text-align:center">
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일   HH:mm:ss" />
</div>


<!-- 컨트롤러에서 체크되어야 하는 부분 : 로그인 여부 체크 후, 로그인 상태에서는 대출번호 있는 회원인지 체크 ${sessionScope.member.user_no} 가 있나 없나 판단-->