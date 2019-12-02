<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script language="JavaScript" type="text/javascript" src="/resources/common/js/encrypt.js?now=<%=System.currentTimeMillis()%>"></script>
<script type="text/javascript">
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		if ($('input#member_pw').val() == '') {
			alert('비밀번호를 입력해주세요.');
			$('input#member_pw').focus();
			return false;
		}
		if (confirm('정말로 탈퇴하시겠습니까?')) {
			$('input#security_pw').val(encrypt($('input#member_pw').val()));
			doAjaxPost($('#memberInfoForm'));
		}
	});



});
</script>

<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-warning"></i> 회원 탈퇴를 하시면 아이디를 포함한 모든 개인정보가 영구적으로 삭제되어 복구되지 않으며, 동일 ID로 재가입할 수 없습니다.</li>
					<li><i class="fa fa-warning"></i> 회원 탈퇴를 하시면 해당 아이디로 등록된 게시물이나 신청현황은 삭제되지 않고 그대로 남아 있습니다.</li>
					<li><i class="fa fa-warning"></i> 탈퇴 후에는 작성한 글에 대한 모든 권한(수정, 삭제 등)을 잃게 되므로, 게시물 삭제를 원하시면 반드시 탈퇴 전 삭제하시기 바랍니다.</li>
					<li><i class="fa fa-warning"></i> 탈퇴 후에는 자료대출, 홈페이지 이용, 전자도서관 이용 등 모든 도서관 서비스를 이용하실 수 없습니다.</li>
					<li><i class="fa fa-warning"></i> 탈퇴 시 미처리 업무(미반납 도서 등)가 있을 경우 탈퇴가 불가능합니다.</li>
					<li><i class="fa fa-warning"></i> 회원님의 정보를 안전하게 보호하기 위해 한번 더 비밀번호를 입력해 주시기 바랍니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="seccession">
	</div>
	<form:form modelAttribute="memberInfo" id="memberInfoForm" method="post" action="/${homepage.context_path}/intro/join/secession.do" onsubmit="return false;">
		<form:password path="member_pw" id="security_pw" style="display:none;"/>
		<table id="memberForm">
			<tbody>
				<tr>
					<th>
						비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<input type="password" id="member_pw" class="text">
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">탈퇴</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
