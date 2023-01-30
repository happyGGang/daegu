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
<title>WBuilder - 더블유빌더</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/aside.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/container.css"/>

<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript" src="/resources/cms/js/design.js"></script>

<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/ie-old.css"/>
<![endif]-->
</head>
<body style="background: #fff; ">
<div id="wrap" style="width: 300px; float: left; height: 100%; background: #293649">
	<div class="aside">
		<div id="header">
			<h1><b>W</b>Builder</h1>
			<div>
				<p><b>(${sessionScope.member.member_name})</b>님 로그인 중입니다.</p>
				<p>
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
				<p>
					
				</p>
			</div>
		</div>
		<ul>
			<li id="memberGroup">
				<a href="" class="code2"><i class="fa fa-desktop"></i><span>사용자 관리</span></a>
				<ul>
					<li><a href="/wbuilder/memberGroup/index.do" >그룹관리</a></li>
					<li><a href="/wbuilder/member/index.do" >사용자관리</a></li>
					<li><a href="/wbuilder/accountLock/index.do" >계정 잠금 관리</a></li>
					<li><a href="/wbuilder/loginLog/index.do" >로그인 기록 관리</a></li>
				</ul>
			</li>
			<li id="memberGroupAuth">
				<a href="" class="code2"><i class="fa fa-desktop"></i><span>권한 관리</span></a>
				<ul>
					<li><a href="/wbuilder/memberGroupAuth/index.do" >그룹권한 관리</a></li>
				</ul>
			</li>
			<li id="cmsManage">
				<a href="" class="code2"><i class="fa fa-desktop"></i><span>CMS 관리</span></a>
				<ul>
					<li><a href="/wbuilder/accessIp/index.do" >접근가능 IP</a></li>
					<li><a href="/wbuilder/limitedIp/index.do" >홈페이지 접근불가능 IP</a></li>
					<li><a href="/wbuilder/code/cms/index.do" >공통코드 관리</a></li>
					<li><a href="/wbuilder/moduleMngt/index.do" >모듈관리</a></li>
				</ul>
			</li>
			<li>
				<a href="/wbuilder/adminMenu/index.do" class="code1" ><i class="fa fa-folder-open"></i><span>CMS관리자 메뉴</span></a>
			</li>
		</ul>
	</div>

</div>
<div id="container"style="float: left; clear: none; width: 80%;">
	<div class="page-subtitle">
		<h3>
			${topMenuName}
<!-- 			<a href="#" class="help" title="도움말"><i class="fa fa-question-circle"></i><span class="sr-only">안내</span></a> -->
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




<script type="text/javascript">
$(document).ready(function(){
	
	if (location.href.indexOf('memberGroupAuth') > 0) {
		$('li#memberGroupAuth').addClass('active');
	} else if (location.href.indexOf('member') > 0 || location.href.indexOf('accountLock') > 0 || location.href.indexOf('loginLog') > 0) {
		$('li#memberGroup').addClass('active');
	} else if (location.href.indexOf('adminMenu') == -1) {
		$('li#cmsManage').addClass('active');
	} 
	
	var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/resources/common/img/viewLoading.gif" />').appendTo(document.body).hide();
	
	$(window).ajaxStart(function(){
		loading.show();
	}).ajaxStop(function(){
		loading.hide();
	}).ajaxComplete(function(){
		loading.hide();
	});

	//테이블 공통 (tr,th,td 처음과 끝 요소 클래스명 부여)
	$('table tr:first-child').addClass('first');
	$('table tr').each(function(){
		$(this).children('th:first-child,td:first-child').addClass('first');
		$(this).children('th:last-child,td:last-child').addClass('last');
	});

	//달력
	
	//셀렉트 메뉴
	$('.selectmenu-search').select2({
		//셀렉트 메뉴에 검색 기능 사용
	});
	$('.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용 안함
		minimumResultsForSearch: Infinity
	});

	//type1 테이블에서 체크박스 체크 시 highlight
	$('table.type1 tbody tr').each(function(){
		$(this).on('click',function(){
			if($(this).find('input[type="checkbox"]').is(':checked')){
				$(this).addClass('highlight');
			}else{
				$(this).removeClass('highlight');
			}
		});
	});
	
	//메뉴 유형 선택 시 추가 옵션 (cont2.jsp)
	$('.menuType').each(function(i){
		var i = i+1;
		$(this).attr('id','menuType'+i);
	});
	$('.menuTypeBox .radio input').each(function(i){
		var i = i+1;
		$(this).on('click',function(){
			$('.menuType').hide();
			$('#menuType'+i).show();
		});
		if($(this).prop('checked')){
			$('.menuType').hide();
			$('#menuType'+i).show();
		}
	});
	
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
	
	$('.selectmenu').select2({
		//셀렉트 메뉴에 검색 기능 사용 안함
		minimumResultsForSearch: Infinity
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
</body>
</html>

