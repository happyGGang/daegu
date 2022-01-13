<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<link rel="stylesheet" type="text/css" href="/resources/common/css/login/login.css">
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>
<script>
$(function() {
	$('input#user_no').focus();
});


</script>


<p class="blind">회원가입 단계</p>
<table class="joinNoline">
	<tbody>
		<tr>
			<td class="joinImg1 center active">
				<div class="en">STEP 01</div>
				<div class="ko">정보확인</div>
			</td>

			<td class="joinImg2 center">
				<div class="en">STEP 02</div>
				<div class="ko">이용약관동의</div>
			</td>

			<td class="joinImg3 center">
				<div class="en">STEP 03</div>
				<div class="ko">본인확인</div>
			</td>

			<td class="joinImg4 center">
				<div class="en">STEP 04</div>
				<div class="ko">정보입력</div>
			</td>
		</tr>
		<tr>
			<td class="joinLine center active">
				<div style="width:27px;border-radius:33px;background:#fab001;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>

			<td class="joinLine center">
				<div style="width:27px;border-radius:33px;background:#000;margin:0 auto">&nbsp;</div>
			</td>
		</tr>
	</tbody>
</table>

<div class="login-box" style="margin-top:6%">
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">

				<dt class="blind">통합도서관 로그인</dt>

				<div class="loginBox1">
				<dd class="login">
					<fieldset>
						<legend class="blind">로그인</legend>

						<form:form modelAttribute="newMember" action="integration1.do" method="post">
						<input type="hidden" id="returnURL" name="returnURL" value=""/>
						<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
						<div class="login-type">
						</div>
						<div class="form-box">
							<p class="idtype" ><label for="user_no">대출자번호</label>
							<input type="text" id="user_no" name="user_no" value="" class="txt" maxlength="20"  autocorrect="off" autocapitalize="none" autocomplete="off" placeholder="대출자번호(회원번호)를 입력해주세요"/>
							</p>
							<p id="pwp" class="idtype" >
							<label for="member_name">이름</label>
							<input type="input" id="member_name" name="member_name" maxlength="30" class="txt" value="" placeholder="이름을 입력해주세요" style="ime-mode:active;" autocorrect="off" autocapitalize="none" autocomplete="off"/>
							</p>

						</div>
						<button>
							<span>로그인</span>
						</button>

						</form:form>

					</fieldset>
				</dd>
				</div>
			</dl>
		</div>
	</div>
</div>

