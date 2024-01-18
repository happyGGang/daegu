<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>SJC - 에스제이씨</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>

<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/container.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/all.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/style.css"/>
<!-- <link rel="stylesheet" type="text/css" href="/resources/cms/css/styles.css"/> -->

<script type="text/javascript" src="/resources/cms/js/all.min.js"></script>

<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/cms/js/design.js"></script>
<script type="text/javascript" src="/resources/cms/js/off-canvas.js"></script>
<script type="text/javascript" src="/resources/cms/js/template.js"></script>
<script type="text/javascript" src="/resources/cms/js/hoverable-collapse.js"></script>
<script type="text/javascript" src="/resources/cms/js/bootstrap/bootstrap.min.js"></script>

</head>
<body style="background: #fff; ">

<div id="wrap">

	<div class="navbar" style="width: 300px;">
		<div class="aside navbar-brand-wrapper d-flex justify-content-center sidebar sidebar-offcanvas" id="sidebar">
			<div id="header">
				<h1>
				<img src="/resources/cms/img/logo_wh.png" alt="logo" class="logo_big">
				<button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
				<img src="/resources/cms/img/logo_wh.png" alt="logo" class="logo_sm"> 
				<i class="fa-solid fa-outdent"></i>
				</button>
				</h1>
				 
				<div class="item_pofile">
					<p class="login_img"><b>(${sessionScope.member.member_name})</b>님 로그인 중입니다.</p>
					<p class="login_txt">
						<a href="/cms/login/logout.do" target="_parent">
							<i class="fa fa-sign-out"></i>
							<em>로그아웃</em>
						</a>
						<span>|</span>
						<a class="pass-change-btn" href="/cms/index.do">
							<i class="fa fa-gear"></i>
							<em>사이트관리 이동</em>
						</a>
						
					</p>
				</div>
			</div>
			
			<ul class="nav">
				<li class="nav-item">
					<a href="#ui-system" class="code2 nav-link" data-toggle="collapse" aria-expanded="true" aria-controls="ui-system">
						<i class="fa-solid fa-gear menu-icon"></i><span class="menu-title">사용자 관리</span>
					</a>
					<div class="collapse" id="ui-system">
						<ul class="nav flex-column sub-menu">
							<li class="nav-item"><a class="nav-link" href="/wbuilder/memberGroup/index.do" >그룹관리</a></li>
							<li class="nav-item"><a class="nav-link" href="/wbuilder/member/index.do" >사용자관리</a></li>
							<li class="nav-item"><a class="nav-link" href="/wbuilder/accountLock/index.do" >계정 잠금 관리</a></li>
							<li class="nav-item"><a class="nav-link" href="/wbuilder/loginLog/index.do" >로그인 기록 관리</a></li>
						</ul>
					</div>
				</li>
				<li class="nav-item">
					<a href="#ui-group" class="code2 nav-link" data-toggle="collapse" aria-expanded="false" aria-controls="ui-group">
						<i class="fa-solid fa-user menu-icon"></i><span class="menu-title">권한 관리</span>
						</a>
					<div class="collapse" id="ui-group">
						<ul class="nav sub-menu">
							<li class="nav-item"><a class="nav-link" href="/wbuilder/memberGroupAuth/index.do" >그룹권한 관리</a></li>
						</ul>
					</div>
				</li>
				<li id="cmsManage" class="nav-item">
					<a href="#ui-cmssystem" class="code2 nav-link" data-toggle="collapse"  aria-expanded="false" aria-controls="ui-cmssystem">
					<i class="fa fa-desktop"></i><span class="menu-title">CMS 관리</span></a>
					
					<div class="collapse" id="ui-cmssystem">
						<ul class="nav sub-menu">
							<li class="nav-item"><a class="nav-link" href="/wbuilder/accessIp/index.do" >접근가능 IP</a></li>
							<li class="nav-item"><a class="nav-link" href="/wbuilder/code/cms/index.do" >공통코드 관리</a></li>
							<li class="nav-item"><a class="nav-link" href="/wbuilder/moduleMngt/index.do" >모듈관리</a></li>
						</ul>
					</div>
				</li>
				<li class="nav-item">
					<a href="#ui-cmsadminmenu" class="code2 nav-link" data-toggle="collapse" aria-expanded="false" aria-controls="ui-cmsadminmenu">
					<i class="fa fa-folder-open"></i><span class="menu-title">CMS관리자 메뉴</span></a>
					<div class="collapse" id="ui-cmsadminmenu">
						<ul class="nav sub-menu">
							<li class="nav-item"><a class="nav-link" href="/wbuilder/adminMenu/index.do" >CMS관리자 메뉴</a></li>
						</ul>
					</div>
				</li>
			</ul>

		</div>
	</div>
	
	<div id="container"class="main-panel" style="">
		<div class="page-subtitle">
			<h3>
				${topMenuName}
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
		<div class="wrapper wrapper-white" >
			<tiles:insertAttribute name="body" />
		</div>
	</div>
	
</div>
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
</body>
</html>

