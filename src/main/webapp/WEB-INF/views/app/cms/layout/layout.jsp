<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<tiles:insertAttribute name="header" />
<script type="text/javascript">
$(document).ready(function(){
	var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/resources/common/img/viewLoading.gif" />').appendTo(document.body).hide();
	
	$(window).ajaxStart(function(){
		loading.show();
	}).ajaxStop(function(){
		loading.hide();
	}).ajaxComplete(function(){
		loading.hide();
	});
});
</script>
<style>
/* 로딩*/
#loading {
	height: 100%;
	left: 0px;
	position: fixed;
	_position: absolute;
	top: 0px;
	width: 100%;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	opacity: 0.5;
}
.loading {
	background-color: white;
	z-index: 9999;
}
#loading_img {
	position: absolute;
	top: 50%;
	left: 50%;
	height: 35px;
	margin-top: -75px; 
	margin-left: -75px;
	z-index: 200;
}
#loading2 {
	height: 100%;
	left: 0px;
	position: fixed;
	_position: absolute;
	top: 0px;
	width: 100%;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	opacity: 0.5;
}
.loading2 {
	background-color: white;
	z-index: 9999;
}
#loading_img2 {
	position: absolute;
	top: 50%;
	left: 50%;
	height: 35px;
	margin-top: -75px; 
	margin-left: -75px;
	z-index: 200;
}
</style>
<div class="page-subtitle">
	<h3>
		${topMenuName}
		<a href="#" class="help" title="도움말"><i class="fa fa-question-circle"></i><span class="sr-only">안내</span></a>
	</h3>
	<p>${topMenuDesc}</p>
	<div class="location">
		<c:forEach var="i" varStatus="status" items="${topMenuFullPathName}">
			<c:if test="${!status.last}">
				<span>${i}</span>
				<em>&gt;</em>
			</c:if>
			<c:if test="${status.last}">
				<strong>${i}</strong>
			</c:if>
		</c:forEach>
	</div>
</div>
<div class="wrapper wrapper-white">
	<tiles:insertAttribute name="body" />
</div>
<tiles:insertAttribute name="footer" />