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
		barHeight: 80,
		fontSize : 12,
		output : 'bmp'
	};
	$("#barcodeTarget").barcode("${param.pass}", "code128", settings);	//''안에 비밀번호 셋팅
	$("#barcodeTarget").css("margin","0 auto");

});
</script>
<div style="text-align:center;padding:30px 0 10px 0;font-size:27px;font-weight:bold">${sessionScope.member.member_name}</div>

<div id="barcodeTarget" class="barcodeTarget" style="padding:0px;overflow:auto;"></div>
<div style="text-align:center"></div>

<div class="loanNum" style="padding-top:20px;text-align:center">
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일   HH:mm:ss" />
</div>
