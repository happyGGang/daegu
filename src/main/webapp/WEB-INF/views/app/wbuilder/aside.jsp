<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>WBuilder - 더블유빌더</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/aside.css"/>

<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/ie-old.css"/>
<![endif]-->
<script src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/cms/js/design.js"></script>
</head>
<body>
<div id="wrap">
	<div class="aside">
		<div id="header">
			<h1><b>W</b>Builder</h1>
			<div>
				<p><b>(${member.member_name})</b>님 로그인 중입니다.</p>
				<p>
					<a href="/cms/login/logout.do" target="_parent">
						<i class="fa fa-sign-out"></i>
						<em>로그아웃</em>
					</a>
					<span>|</span>
					<a class="pass-change-btn" href="">
						<i class="fa fa-gear"></i>
						<em>비밀번호 변경</em>
					</a>
				</p>
				<p>
					<select id="siteList" class="selectmenu" style="width:200px;">
						<c:forEach items="${sessionScope.member.authorityHomepageList}" var="i" varStatus="status">
						<option value="${i.homepage_id}" label="${i.homepage_name}"<c:if test="${i.homepage_id eq adminMenu.homepage_id}"> selected="selected"</c:if>></option>
						</c:forEach>
					</select>
				</p>
			</div>
		</div>
		<cmsTag:asideMenu adminMenuList="${adminMenuList}"/>
		<ul>
			<c:if test="${member.admin}">
			<li>
				<a href="/cms/adminMenu/index.do" class="code1" target="container"><i class="fa fa-folder-open"></i><span>CMS관리자 메뉴</span></a>
			</li>
			</c:if>
		</ul>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	//왼쪽메뉴
	$('.aside > ul > li').each(function(){
		if($(this).find('ul').length > 0){
			$(this).children('a').on('click',function(){
				if($(this).parent().hasClass('active')){
					$('.aside > ul > li > ul').slideUp(80);
					$('.aside > ul > li').removeClass('active');
					$(this).parent().removeClass('active');
				}else{
					$('.aside > ul > li > ul').slideUp(80);
					$('.aside > ul > li').removeClass('active');
					$(this).parent().children('ul').slideDown(80);
					$(this).parent().addClass('active');
				}
				return false;
			});
			if($(this).find('li').hasClass('active')){
				$(this).addClass('active');
			}
		}else{
			$(this).addClass('s');
		}
	});
	$('.aside > ul > li > ul > li').each(function(){
		if($(this).find('ul').length > 0){
			$(this).children('a').on('click',function(){
				if($(this).parent().hasClass('active')){
					$('.aside > ul > li > ul > li > ul').slideUp(80);
					$('.aside > ul > li > ul > li').removeClass('active');
					$(this).parent().removeClass('active');
				}else{
					$('.aside > ul > li > ul > li > ul').slideUp(80);
					$('.aside > ul > li > ul > li').removeClass('active');
					$(this).parent().children('ul').slideDown(80);
					$(this).parent().addClass('active');
				}
				return false;
			});
		}else{
			$(this).addClass('s');
		}
	});
	
	$('a.pass-change-btn').on('click', function(e) {
		e.preventDefault();
		$('input#passChangeEvent').val(true);
		parent.container.location.hash = "test";
		parent.container.location.href ="/cms/member/index.do";
		//var btn = parent.container.document.getElementById('dialog-modify-${member.member_id}');
	});
	
	$('.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용 안함
		minimumResultsForSearch: Infinity
	});
	
	$('select#siteList').on('change', function() {
		$('input#aside_homepage_id').val($(this).val());
		$('form#asideForm').submit();
		parent.container.location.href='ready.do';
	});
	
	parent.container.location.href=$('div.aside ul a[href*=cms]:first').attr('href');
	
});
</script>

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

</body>
</html>