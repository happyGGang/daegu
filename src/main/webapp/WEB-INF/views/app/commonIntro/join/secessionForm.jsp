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
					<li><i class="fa fa-warning"></i> 도서관 서비스의 부정이용을 방지하고자 탈퇴한 회원은 재가입 하실 수 없습니다.</li>
					<li><i class="fa fa-warning"></i> 재가입을 원하시는 경우 도서관으로 문의 부탁드립니다.</li>
					<li><i class="fa fa-warning"></i> 회원 탈퇴를 하여도 해당 아이디로 등록된 게시물, 신청현황 등은 삭제되지 않고 남아있습니다.</li>
					<li><i class="fa fa-warning"></i> 탈퇴 후 작성 글에 대한 모든 권한을 잃게 되므로 게시물 삭제를 원하시면 반드시 탈퇴 전에 삭제하시기 바랍니다.</li>
					<li><i class="fa fa-warning"></i> 탈퇴 후 자료대출, 홈페이지 이용(강좌 신청 등), 전자도서관 대출 등 모든 도서관 서비스를 이용하실 수 없습니다.</li>
					<li><i class="fa fa-warning"></i> 탈퇴 시 미반납 도서가 있을 경우 탈퇴가 불가능 합니다.</li>
					<li><i class="fa fa-warning"></i> 책이음 회원의 경우 책이음을 먼저 탈퇴하셔야 회원 탈퇴가 가능하오니 도서관에 문의 바랍니다.</li>
					<li><i class="fa fa-warning"></i> 회원님의 정보를 안전하게 보호하기 위해 한 번 더 비밀번호를 입력해 주시기 바랍니다.</li>
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
