<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=1024" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>서점 관리자페이지</title>
<link media="screen" rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/store/css/all.css"  />
<link media="screen" rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/jquery-ui.css"  />
</head>
<body>
<link media="screen" rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/store/css/login.css"  />
	<div id="login_wrapper">
		<form method="post" action="storeLoginProc.do">
			<input type="hidden" name="_csrf" value="${_csrf.token}">
			<fieldset>
				<h1 id="logo"><a href="#">서점 관리 서비스</a><span>관리자 로그인</span></h1>
				<div class="formular">
					<div class="formular_inner">
						<label>
							<label for="wd_id" class="item"><strong>아이디 :</strong></label>
							<span class="input_wrapper"><input type="text" name="s_id" id="wd_id" /></span>
						</label>
						<label>
							<label for="wd_pw" class="item"><strong>비밀번호 :</strong></label>
							<span class="input_wrapper"><input type="password" name="s_pw" id="wd_pw" /></span>
						</label>
						<ul class="form_menu">
							<li><span class="button"><span><span>로그인</span></span><input type="submit" name="loginSubmit" value="로그인" /></span></li>
						</ul>
					</div>
				</div>
			</fieldset>
		</form>
	</div>

				</div>
			</div>
		</div>
	</div>
	<div id="footer">
		<div id="footer_inner">
			<dl class="copy">
				<dt><strong>새 책 드림 서비스 - 서점관리자</strong> </dt>
				<dd>Copyright &copy; 2015 ANDONG LIBRARY. All rights reserved.</dd>
			</dl>
		</div>
</div>

</body>
</html>