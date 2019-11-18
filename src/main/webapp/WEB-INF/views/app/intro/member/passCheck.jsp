<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>

<!-- contents-title-->
<div id="contents-title">
	<h2>회원정보수정</h2>
	<h1><span style="font-weight:300">회원정보 조회를 위해 비밀번호를 입력해주세요.</span></h1>
</div>
<!-- /contents-title-->

<div class="login-box">
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">회원정보 조회를 위해 비밀번호를 입력바랍니다.</dt>
				<div class="loginBox1">
				<dd class="login">
					<fieldset>
						<legend class="blind">비밀번호 입력</legend>

						<form id="loginform" name="loginform" method="post">
						<input type="hidden" id="returnURL" name="returnURL" value=""/>

						<div class="login-type">
						</div>
						<div class="form-box">
							<p id="pwp" class="idtype" >
							<label for="member_pw_tmp" class="blind">비밀번호</label>
							<input type="password" id="password" name="password" maxlength="20" class="txt" value="" placeholder="비밀번호를 입력해주세요" onkeydown="enter();"/>
							</p>

						</div>
						<button id="" class="btn_check">
							<span>확인</span>
						</button>

						</form>

					</fieldset>
				</dd>
				</div>
			</dl>
		</div>
	</div>
</div>