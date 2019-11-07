<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	$(function() {

	});
</script>

<div class="expiry_box" style="margin:20px auto">
	<p class="expiry_t1">회원님께서는 동일한 비밀번호를 3개월 동안 사용하고 계십니다.</p>

	<div class="expiry_t2">
		<p>개인정보를 안전하게 보호하기 위해</p>
		<p class="f_r">비밀번호를 변경해 주시기 바랍니다.</p>
	</div>

	<div class="btn-wrap">
		<a href="changePwForm.do?menu_idx=${param.menu_idx}" class="btn btn1">비밀번호 변경</a>
		<a href="/${homepage.context_path}/index.do" class="btn">다음에 변경하기</a>
	</div>
</div>