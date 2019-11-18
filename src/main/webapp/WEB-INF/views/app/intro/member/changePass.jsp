<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>

<!-- 비밀번호 찾기 전용 [START] -->
<div id="contents-title">
	<h2>
		본인 확인이 완료되었습니다. 
		</br>
		<span style="font-weight:300; color:#fab000">비밀번호를 변경해 주십시요.</span>
	</h2>
</div>			
					
<div class="login-box">
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">회원 비밀번호 변경</dt>
				<div class="loginBox1">
					<dd class="login">
						<fieldset>
							<legend class="blind">비밀번호 변경</legend>

							<form id="findMemberPwForm" name="findMemberPwForm" method="post">
							<input type="hidden" id="userkey" name="userkey" value="9102616011"/>	
							<input type="hidden" id="ipin_hash" name="ipin_hash" value="Q7LLc259i3+Am+ggTScIB2fYG1bjX4qPviXQsgz/lHnSJxGxY7WSQ4xespI1ebrtfSMD/YdgEQBa1zKWt6jYXw=="/>			
							<div class="login-type">
							</div>
							<div class="form-box">
								<p id="pwp" class="idtype" >
								<label for="member_pw_tmp">신규비밀번호</label>
								<input type="password" id="password" name="password" maxlength="20" class="txt" value="" placeholder="새비밀번호를 입력해 주십시요." />
								</p>
								<p id="pwp" class="idtype" >
								<label for="member_pw_tmp">신규비밀번호확인</label>
								<input type="password" id="re_password" name="re_password" maxlength="20" class="txt" value="" placeholder="새비밀번호 확인을 입력해 주십시요." />
								</p>
							</div>
							
							<button id="pw-change-btn">
								<span>변경</span>
							</button>

							</form>

						</fieldset>

						<div class="highlight">
						<span id="">* 비밀번호는 영문(대소문자구분),숫자,특수문자(!@#$%^&*만 허용)를 혼용하여 8~20자이내</span>
						</div>
					</dd>
				</div>
			</dl>
		</div>
	</div>
</div>
<!-- 비밀번호 찾기 전용 [ END ] -->