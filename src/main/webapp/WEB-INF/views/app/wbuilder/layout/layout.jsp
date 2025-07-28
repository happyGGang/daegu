<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>SJS - 도서관통합관리프로그램</title>
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
</head>
<body style="background: #fff; ">
<div id="wrap" class="left-sidebar">
	<div class="aside">
		<div id="header">
			<h1><a href="/wbuilder/index.do">SJS</a></h1>
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
			</div>
		</div>
		<ul>
			<li id="memberGroup">
				<a href="javascript:void(0);" class="code2"><i class="fa fa-desktop"></i><span>사용자 관리</span></a>
				<ul>
					<li><a href="/wbuilder/memberGroup/index.do" >그룹관리</a></li>
					<li><a href="/wbuilder/member/index.do" >사용자관리</a></li>
					<li><a href="/wbuilder/accountLock/index.do" >계정 잠금 관리</a></li>
					<li><a href="/wbuilder/loginLog/index.do" >로그인 기록 관리</a></li>
				</ul>
			</li>
			<li id="memberGroupAuth">
				<a href="javascript:void(0);" class="code2"><i class="fa fa-desktop"></i><span>권한 관리</span></a>
				<ul>
					<li><a href="/wbuilder/memberGroupAuth/index.do" >그룹권한 관리</a></li>
				</ul>
			</li>
			<li id="cmsManage">
				<a href="javascript:void(0);" class="code2"><i class="fa fa-desktop"></i><span>CMS 관리</span></a>
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
	<div class="wrapper wrapper-white" >
		<tiles:insertAttribute name="body" />
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		const currentPath = window.location.pathname;

		// 현재 경로에 해당하는 메뉴 활성화
		$('.aside a').each(function () {
			const linkPath = $(this).attr('href');
			if (linkPath && currentPath === linkPath) {
				const $li = $(this).closest('li');
				$li.addClass('active');
				$li.parents('ul').show();
				$li.parents('li').addClass('active');
			}
		});

		function activateMenu() {
			const href = location.href;

			if (href.indexOf('memberGroupAuth') >= 0) {
				$('li#memberGroupAuth').addClass('active');
			} else if (href.indexOf('member') >= 0 || href.indexOf('accountLock') >= 0 || href.indexOf('loginLog') >= 0) {
				$('li#memberGroup').addClass('active');
			} else if (href.indexOf('adminMenu') === -1 && !href.includes('/wbuilder/index.do')) {
				$('li#cmsManage').addClass('active');
			}
		}

		// 테이블 셀 첫/마지막에 클래스 부여
		function applyTableClass() {
			$('table tr:first-child').addClass('first');
			$('table tr').each(function() {
				$(this).children('th:first-child, td:first-child').addClass('first');
				$(this).children('th:last-child, td:last-child').addClass('last');
			});
		}

		// 체크박스 클릭 시 행 하이라이팅
		function highlightRowOnCheckbox() {
			$('table.type1 tbody tr').on('click', function() {
				$(this).toggleClass('highlight', $(this).find('input[type="checkbox"]').is(':checked'));
			});
		}

		// 사이드 메뉴 토글 처리
		function setupAsideMenuToggle() {
			$('.aside > ul > li').each(function() {
				const $li = $(this);

				if ($li.find('ul').length > 0) {
					$li.children('a').on('click', function(e) {
						e.preventDefault();
						const isActive = $li.hasClass('active');
						$('.aside > ul > li > ul').slideUp(80);
						$('.aside > ul > li').removeClass('active');
						if (!isActive) {
						$li.children('ul').slideDown(80);
						$li.addClass('active');
						}
					});
					if ($li.find('li.active').length > 0) $li.addClass('active');
				} else {
					$li.addClass('s');
				}
			});

			$('.aside > ul > li > ul > li').each(function() {
				const $li = $(this);
				if ($li.find('ul').length > 0) {
					$li.children('a').on('click', function(e) {
						e.preventDefault();

						const isActive = $li.hasClass('active');

						$('.aside > ul > li > ul > li > ul').slideUp(80);
						$('.aside > ul > li > ul > li').removeClass('active');

						if (!isActive) {
							$li.children('ul').slideDown(80);
							$li.addClass('active');
						}
					});
				} else {
					$li.addClass('s');
				}
			});
		}

		activateMenu();
		applyTableClass();
		highlightRowOnCheckbox();
		setupAsideMenuToggle();
	});
</script>
</body>
</html>

