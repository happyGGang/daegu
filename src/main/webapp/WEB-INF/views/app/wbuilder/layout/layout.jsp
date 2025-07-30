<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="cmsTag" uri="/WEB-INF/config/tld/cmsTag.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta content="${_csrf.token}" id="_csrf" name="_csrf"/>
    <meta content="${_csrf.headerName}" id="_csrf_header" name="_csrf_header"/>
    <title>SJS - 도서관통합관리프로그램</title>
    <link href="/resources/cms/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/cms/css/font.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/cms/css/side.css" rel="stylesheet" type="text/css"/>
    <!--<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>-->
    <!--<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>-->
    <!--<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/container.css"/>-->

    <script src="/resources/common/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="/resources/cms/js/cms/side.js" type="text/javascript"></script>
    <!--<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>-->
    <!--<script type="text/javascript" src="/resources/common/js/common.css"></script>-->
    <!--<script type="text/javascript" src="/resources/cms/js/design.js"></script>-->
</head>
<body>
<div class="cms-container">
    <div class="side-menu">
        <div class="side-menu-toggle-btn">
            <img alt="" src="/resources/cms/img/sideMenu/toggle.svg">
        </div>
        <img alt="" class="logo" src="/resources/cms/img/sideMenu/logo.png">
        <div class="user-name"><span>${sessionScope.member.member_name}</span>님 반갑습니다.</div>
        <div class="action-wrapper">
            <a href="/cms/login/logout.do" target="_parent">
                <img alt="" src="/resources/cms/img/sideMenu/logout.svg">
                <div>로그아웃</div>
            </a>
            <a href="/cms/index.do">
                <img alt="" src="/resources/cms/img/sideMenu/setting.svg">
                <div>사이트관리 이동</div>
            </a>
        </div>
        <div class="menu-list">
            <div class="one-depth" id="memberGroup">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/user.svg">
                        <div>사용자 관리</div>
                    </div>
                    <img alt="" src="/resources/cms/img/sideMenu/expansion.svg">
                </div>
                <ul>
                    <li><a href="/wbuilder/memberGroup/index.do">· 그룹관리</a></li>
                    <li><a href="/wbuilder/member/index.do">· 사용자관리</a></li>
                    <li><a href="/wbuilder/accountLock/index.do">· 계정 잠금 관리</a></li>
                    <li><a href="/wbuilder/loginLog/index.do">· 로그인 기록 관리</a></li>
                </ul>
            </div>
            <div class="one-depth" id="memberGroupAuth">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/right.svg">
                        <div>권한 관리</div>
                    </div>
                    <img alt="" src="/resources/cms/img/sideMenu/expansion.svg">
                </div>
                <ul>
                    <li><a href="/wbuilder/memberGroupAuth/index.do">· 그룹권한 관리</a></li>
                </ul>
            </div>
            <div class="one-depth" id="cmsManage">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/cms-manage.svg">
                        <div>CMS 관리</div>
                    </div>
                    <img alt="" src="/resources/cms/img/sideMenu/expansion.svg">
                </div>
                <ul>
                    <li><a href="/wbuilder/accessIp/index.do">· 접근가능 IP</a></li>
                    <li><a href="/wbuilder/limitedIp/index.do">· 홈페이지 접근불가능 IP</a></li>
                    <li><a href="/wbuilder/code/cms/index.do">· 공통코드 관리</a></li>
                    <li><a href="/wbuilder/moduleMngt/index.do">· 모듈관리</a></li>
                </ul>
            </div>
            <div class="one-depth" onclick="location.href='/wbuilder/adminMenu/index.do'">
                <div class="one-depth-btn">
                    <div>
                        <img alt="" src="/resources/cms/img/sideMenu/cms-admin.svg">
                        <div>CMS 관리자 메뉴</div>
                    </div>
                    <img alt="" src="" style="display: none">
                </div>
            </div>
        </div>
    </div>
    <tiles:insertAttribute name="body"/>
</div>
</body>
</html>

