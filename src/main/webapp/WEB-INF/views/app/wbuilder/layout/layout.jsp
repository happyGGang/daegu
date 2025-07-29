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
<link rel="stylesheet" type="text/css" href="/resources/cms/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/font.css"/>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/side.css"/>
<!--<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery-ui-1.12.0.min.css"/>-->
<!--<link rel="stylesheet" type="text/css" href="/resources/common/css/select2.min.css"/>-->
<!--<link rel="stylesheet" type="text/css" href="/resources/cms/survey/css/container.css"/>-->

<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/cms/js/cms/side.js"></script>
<!--<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>-->
<!--<script type="text/javascript" src="/resources/common/js/common.css"></script>-->
<!--<script type="text/javascript" src="/resources/cms/js/design.js"></script>-->
</head>
<body>
<div class="cms-container">

  <div class="side-menu">
    <div class="side-menu-toggle-btn">
      <img src="/resources/cms/img/sideMenu/toggle.svg" alt="">
    </div>
    <img class="logo" src="/resources/cms/img/sideMenu/logo.png" alt="">
    <div class="user-name"><span>${sessionScope.member.member_name}</span>님 반갑습니다.</div>
    <div class="action-wrapper">
      <a href="/cms/login/logout.do" target="_parent">
        <img src="/resources/cms/img/sideMenu/logout.svg" alt="">
        <div>로그아웃</div>
      </a>
      <a href="/cms/index.do">
        <img src="/resources/cms/img/sideMenu/setting.svg" alt="">
        <div>사이트관리 이동</div>
      </a>
    </div>
    <div class="menu-list">
      <div id="memberGroup" class="one-depth">
        <div class="one-depth-btn">
          <div>
            <img src="/resources/cms/img/sideMenu/user.svg" alt="">
            <div>사용자 관리</div>
          </div>
          <img src="/resources/cms/img/sideMenu/expansion.svg" alt="">
        </div>
        <ul>
          <li><a href="/wbuilder/memberGroup/index.do" >· 그룹관리</a></li>
          <li><a href="/wbuilder/member/index.do" >· 사용자관리</a></li>
          <li><a href="/wbuilder/accountLock/index.do" >· 계정 잠금 관리</a></li>
          <li><a href="/wbuilder/loginLog/index.do" >· 로그인 기록 관리</a></li>
        </ul>
      </div>
      <div id="memberGroupAuth" class="one-depth">
        <div class="one-depth-btn">
          <div>
            <img src="/resources/cms/img/sideMenu/right.svg" alt="">
            <div>권한 관리</div>
          </div>
          <img src="/resources/cms/img/sideMenu/expansion.svg" alt="">
        </div>
        <ul>
          <li><a href="/wbuilder/memberGroupAuth/index.do" >· 그룹권한 관리</a></li>
        </ul>
      </div>
      <div id="cmsManage" class="one-depth">
        <div class="one-depth-btn">
          <div>
            <img src="/resources/cms/img/sideMenu/cms-manage.svg" alt="">
            <div>CMS 관리</div>
          </div>
          <img src="/resources/cms/img/sideMenu/expansion.svg" alt="">
        </div>
        <ul>
          <li><a href="/wbuilder/accessIp/index.do" >· 접근가능 IP</a></li>
          <li><a href="/wbuilder/limitedIp/index.do" >· 홈페이지 접근불가능 IP</a></li>
          <li><a href="/wbuilder/code/cms/index.do" >· 공통코드 관리</a></li>
          <li><a href="/wbuilder/moduleMngt/index.do" >· 모듈관리</a></li>
        </ul>
      </div>
      <div class="one-depth" onclick="location.href='/wbuilder/adminMenu/index.do'">
        <div class="one-depth-btn">
          <div>
            <img src="/resources/cms/img/sideMenu/cms-admin.svg" alt="">
            <div>CMS 관리자 메뉴</div>
          </div>
          <img src="" alt="" style="display: none">
        </div>
      </div>
    </div>
  </div>

  <tiles:insertAttribute name="body" />
</div>
</body>
</html>

