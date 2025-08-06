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
<!--<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>-->
<!--<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome.min.css"/>-->
<!--<link rel="stylesheet" type="text/css" href="/resources/cms/css/aside.css"/>-->

<!--[if IE 7]>
<!--<link rel="stylesheet" type="text/css" href="/resources/common/css/fontawesome-ie7.min.css"/>-->
<![endif]-->
<!--[if lte IE 8]>
<!--<link rel="stylesheet" type="text/css" href="/resources/cms/css/ie-old.css"/>-->
<![endif]-->
<script src="/resources/common/js/jquery-1.12.4.min.js"></script>
<!--<script type="text/javascript" src="/resources/cms/js/design.js"></script>-->
<script>
$(function(){
	
	var h = '${sessionScope.passwordExpiry}';
	if (h != '') {
		window.open(h, '_blank');
	}
	
});
</script>
</head>
<body>
<div id="wrap">
	<div class="aside">
		<div id="header">
			<h1><b>W</b>Builder</h1>
			<div>
				<p><b>(${member.member_name})</b>님 로그인 중입니다ㄴㅇㅎㄶㅇㄴㅇㅎ.</p>
				<p>
					<a href="/cms/login/logout.do" target="_parent">
						<em>로그아웃</em>
					</a>
					<span>|</span>
					<a class="pass-change-btn" href="">
						<em>비밀번호 변경</em>
					</a>
				</p>
				<p>
					<select id="siteList" class="selectmenu" style="width:200px;">
						<c:forEach items="${sessionScope.member.authorityHomepageList}" var="i" varStatus="status">
						<c:if test="${i.homepage_id ne 'c0' and i.homepage_id ne 'c1' and i.homepage_id ne 'h27'}">
						<option value="${i.homepage_id}" label="${i.homepage_name}"<c:if test="${i.homepage_id eq adminMenu.homepage_id}"> selected="selected"</c:if>></option>
						</c:if>
						</c:forEach>
					</select>
				</p>
				<c:if test="${member.admin}">
				<p>
					<a class="caption" href="" onclick="javascript:parent.location.href='/wbuilder/adminMenu/index.do'; return false;">[WBuilder관리 이동]</a>
				</p>
				</c:if>
			</div>
		</div>
		<cmsTag:asideMenu adminMenuList="${adminMenuList}"/>
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
<input type=hidden value="false" id="passChangeEvent" />
<input type=hidden value="${member.member_id}" id="passChangeEventValue" />
<form id="asideForm" action="" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}">
<input type="hidden" id="aside_homepage_id" name="homepage_id" value="${adminMenu.homepage_id}" />
</form>
</body>
</html>