<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>CMS 관리자 로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/resources/cms/css/reset.css">
  <link rel="stylesheet" href="/resources/cms/css/font.css">
  <link rel="stylesheet" href="/resources/cms/css/login.css">
</head>

<body>
<div class="container">
  <div class="login">
    <div class="header">
      <img src="/resources/cms/img/login/logo.png" alt="로고" class="logo" />
      <h1>도서관 통합 허브시스템</h1>
      <div>사용자 로그인</div>
    </div>
    <form:form modelAttribute="login" action="login.do" method="post" autocomplete="off">
      <div class="input id">
        <img src="/resources/cms/img/login/id.svg" alt="">
        <form:input path="member_id" maxlength="25" placeholder="ID" />
      </div>
      <div class="input password">
        <img src="/resources/cms/img/login/password.svg" alt="">
        <form:password path="member_pw" maxlength="25" placeholder="PASSWORD" />
      </div>
      <button type="submit">로그인</button>
    </form:form>
    <div class="copyright">ⓒ 2023. SJC all rights reserved. v 1.0</div>
  </div>
</div>
</body>
</html>
