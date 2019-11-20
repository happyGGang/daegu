<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/join/join.css"/>

<script type="text/javascript">

$(function() {

});
</script>


<!-- contents-title-->
<div id="contents-title">
	<h2>아이디 찾기</h2>
</div>
<!-- /contents-title-->

<div class="login-box">
	<div class="login-body">
		<div class="tab">
			<dl class="tcon t1">
				<dt class="blind">통합도서관 로그인</dt>
				<div class="loginBox1">
					<dd class="login">
						<fieldset>

							회원님의 ID는 xxx입니다.

						</fieldset>
					</dd>

					<div class="idpwSection" style="text-align:center;">
						<a href="/intro/${homepage.context_path}/join/index.do" class="btn btn01">신규회원가입</a>
						<a href="/intro/${homepage.context_path}/login/index.do" class="btn btn01">로그인</a>
						<a href="/intro/${homepage.context_path}/join/findPwForm.do" class="btn btn02">비밀번호찾기</a>
					</div>

				</div>
			</dl>
		</div>
	</div>
</div>

