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
<script>
	function getCookie(cookieName) {
		let cookieData = document.cookie;
		let cookieValue = "";
		let start = cookieData.indexOf(cookieName);

		if (start !== -1) {
			start += cookieName.length;
			let end = cookieData.indexOf(";", start);
			if (end === -1) end = cookieData.length;
			cookieValue = cookieData.substring(start+1, end);
		}

		return cookieValue;
	}

$(function(){
	var h = '${sessionScope.passwordExpiry}';
	if (h != '') {
		window.open(h, '_blank');
	}

	if (getCookie('status') == 'Y') {
		if (getCookie('now_homepage_id') != '') {
			if (getCookie('now_homepage_id') == getCookie('back_homepage_id')) {
				$('input#aside_homepage_id').val(getCookie('now_homepage_id'));
				$('form#asideForm').submit();
				document.cookie = 'now_homepage_id=';
			}
		}  else {
			document.cookie = 'now_homepage_id = ' + getCookie('back_homepage_id') ;
		}
	}


});

	function siteList() {

		var siteList  = document.getElementById("siteList");
		var value = (siteList.options[siteList.selectedIndex].value);

		parent.container.doGetLoad('/cms/homepage/index.do');
		$('input#aside_homepage_id').val(value);
		$('form#asideForm').submit();

		document.cookie = 'now_homepage_id = ' + value +';';
		document.cookie = 'back_homepage_id = ' + getCookie('now_homepage_id') +';';
		document.cookie = 'status = N;';


	}

</script>
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
					<select id="siteList" class="selectmenu" style="width:200px;" onchange="siteList();">
						<c:forEach items="${sessionScope.member.authorityHomepageList}" var="i" varStatus="status">
						<c:if test="${i.homepage_id ne 'c0' and i.homepage_id ne 'c1' and i.homepage_id ne 'h27'}">
						<option value="${i.homepage_id}" label="${i.homepage_name}"<c:if test="${i.homepage_id eq asideHomepageId}"> selected="selected"</c:if>></option>
						</c:if>
						</c:forEach>
					</select>
				</p>
				<c:if test="${member.admin}">
				<p>
					<a href="" onclick="javascript:parent.location.href='/wbuilder/adminMenu/index.do'; return false;">[WBuilder관리 이동]</a>
				</p>
				</c:if>
			</div>
		</div>
		<cmsTag:asideMenu adminMenuList="${adminMenuList}"/>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	//console.log(getCookie('url'));
	if (getCookie('url') != '' && getCookie('status') != 'N') {
		$('a[href="'+getCookie('url')+'"]').parents('li > ul > li').addClass('active');
	}
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

	if (getCookie('url') != '' && getCookie('status') != 'N') {
		$('a[href="'+getCookie('url')+'"]').closest('li').removeClass('active');
	}



	$('a.pass-change-btn').on('click', function(e) {
		e.preventDefault();
		$('input#passChangeEvent').val(true);
		parent.container.location.hash = "test";
		parent.container.location.href ="/cms/member/index.do";
		//var btn = parent.container.document.getElementById('dialog-modify-${member.member_id}');
	});



	/*$('select#siteList').on('change', function(e) {
		e.preventDefault();
		var siteList  = document.getElementById("siteList");
		var value = (siteList.options[siteList.selectedIndex].value);

		$('input#aside_homepage_id').val(value);
		$('form#asideForm').submit();
		parent.container.location.href='ready.do';
		document.cookie = 'homepage_id = ' + value;
	});*/



	//$('select#siteList').trigger('change');

	document.cookie = 'status = Y;';
});
</script>
<input type=hidden value="false" id="passChangeEvent" />
<input type=hidden value="${member.member_id}" id="passChangeEventValue" />
<form id="asideForm" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input type="hidden" id="aside_homepage_id" name="homepage_id" value="${adminMenu.homepage_id}" />
</form>
</body>
</html>