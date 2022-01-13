<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function() {
	//$('input#user_no').focus();
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div class="login-body">
	<div class="tab">
		<dl class="tcon t1">
			<dt class="blind">통합도서관 로그인</dt>
			<div class="loginBox1">
			<dd class="login">
				<div class="loginImgBox">
					<img src="/resources/common/img/mem_loginimg.png" alt="" class="loginImg">
				</div>
				<fieldset>
					<legend class="blind">로그인</legend>
					<form:form modelAttribute="newMember" action="integration1.do" method="post">
					<form:hidden path="menu_idx"/>
						<div class="form-box">
							<label class="blind" for="user_no">대출자번호</label>
							<input type="text" id="user_no" name="user_no" class="txt" placeholder="대출자번호(회원번호)를 입력해주세요" title="대출자번호(회원번호)를 입력해주세요" maxlength="20" /></p>
							<label for="member_name" class="blind" >이름</label>
							<input type="text" id="member_name" name="member_name" class="txt" placeholder="이름을 입력해주세요" title="이름을 입력해주세요" maxlength="20"/></p>
						</div>
						<button id="save-btn">
							<i class="fa fa-unlock-alt"></i>
							<span>로그인</span>
						</button>
					</form:form>
				</fieldset>
			</dd>
			</div>
		</dl>
	</div>
</div>
