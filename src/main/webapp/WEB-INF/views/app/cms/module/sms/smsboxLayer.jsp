<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {	
	$('div#smsbox-layer').load('smsboxList.do', serializeCustom($('form#smsSendForm')));
	
});
</script>

<!--// 문자함 -->

<div style="float:left;width:480px">	
<!-- 	<h1>문자함</h1>	 -->
	<span class="tabmenu" style="padding:0px;">
		<ul>
			<li class=""><a>문자함</a></li>
		</ul>
	</span>
	<div id="smsbox-layer">
	
	</div>
</div>
