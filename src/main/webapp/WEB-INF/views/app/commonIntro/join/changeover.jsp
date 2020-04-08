<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	table.integration2Table tbody th, table.integration2Table tbody td {text-align: center;padding:6px 0px!important;}
</style>

<script type="text/javascript">
$(function() {

});
</script>

<div class="">

	<!-- <h4>DLS 추가인증 전환에 대한 안내</h4> -->

	<!-- <div class="Box" style="height:120px">
		<p style="line-height:210%;">
		독서교육 종합지원시스템(DLS)에 가입 된 회원은 추가인증을 통해 비대면 회원가입으로 전자도서관을 이용가능 합니다. 아래의 '인증하기' 버튼을 누르면 추가인증 페이지로 이동합니다.<br>
		일반 이용자분들은 추후 비대면 인증 회원가입 서비스가 도입될 예정이오니 '메인으로' 버튼을 눌러 주세요.
		<br>
		</p>
	</div> -->
	<div class="">
		<img src="/resources/common/img/dls_info.jpg" alt="DLS전환안내" />
	</div>
	<div class="btn-wrap" style="text-align:center;padding:20px 0">
		<a href="dls.do?menu_idx=${param.menu_idx}" class="btn btn01" style="background:#0071f1;border:1px solid #1d62af;color:#fff;">인증하기</a>
		<a href="/${homepage.context_path}/index.do" class="btn btn02">메인으로</a>
	</div>
</div>
