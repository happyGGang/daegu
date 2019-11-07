<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
var pwCheck = false;
var pwCheck2 = false;
$(function() {
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		
		var pw = $('input#memberNewPw').val();
		var pw2 = $('input#member_pw').val();
		var pw3 = $('input#member_pw_confirm').val();
		if (pw2 == '') {
			alert('기존 비밀번호를 입력해주세요.');
			$('input#memberNewPw').focus();
			return false;
		}
		
		if (pwCheck && pwCheck2) {
			doAjaxPost($('#memberInfoForm'));
		} else if (!pwCheck2) {
			alert('신규 비밀번호는 영문, 숫자, 특수문자 조합으로 9자이상 20자이내로 입력해주세요.');
			return false;
		} else if (!pwCheck) {
			alert('입력한 신규 비밀번호가 일치하지 않습니다.');
			return false;
		}
	});
	
	$('input#memberNewPw').blur(function(e) {
		e.preventDefault();
		pwdcheck = false;
		var pw = $(this).val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[^\da-zA-Z]/gi);
		if(pw.length < 9 || pw.length > 20){
// 			alert('4자리 ~ 20자리 이내로 입력해주세요.');
			$('span#pwdcheck').css('color', 'red');
			return false;
		}
		if(pw.search(/\s/) != -1){
// 			alert("비밀번호는 공백없이 입력해주세요.");
			$('span#pwdcheck').css('color', 'red');
			return false;
		} 
		if(num < 0 || eng < 0 || spe < 0 ){
			$('span#pwdcheck').css('color', 'red');
// 			alert("비밀번호는 공백없이 입력해주세요.");
			return false;
		}
		$('span#pwdcheck').css('color', 'black');
		pwCheck2 = true;
		return true;
	});
	
	$('input#member_pw_confirm').blur(function(e) {
		e.preventDefault();
		if (pwCheck2) {
			if ( $('#member_pw_confirm').val().length > 0 ) {
				if ( $('#memberNewPw').val() == $('#member_pw_confirm').val() ) {
					pwCheck = true;	
					$('#pw_confirm_message').text('일치합니다.');
				} else {
					pwCheck = false;	
					$('#pw_confirm_message').text('');
				}	
			} else {
				pwCheck = false;
				$('#pw_confirm_message').text('');
			}
		}
	});
	
	
});
</script>

<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
<div style="padding:18px;box-sizing:border-box">
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>
<div class="join-wrap" style="padding: 0;">
	<div class="txt-box" style="margin-bottom: 20px;">
		<div id="txt_box_wrapper02">
			<div id="txt_box_wrap02">
				<ul>
					<li><i class="fa fa-warning"></i> 비밀번호 변경을 위해 기존 비밀번호를 입력해주세요.</li>
					<li><i class="fa fa-warning"></i> 비밀번호 변경시 다음 로그인 부터는 변경된 비밀번호로 로그인 가능합니다.</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="seccession">
	</div>
	<form:form modelAttribute="memberInfo" id="memberInfoForm" action="changePw.do">
		<form:hidden path="member_id"/>
		<form:hidden path="user_id"/>
		<table id="memberForm" style="${param.ageType eq 'under' ? 'display:none;':''}">
			<colgroup>
				<col width="20%"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>
						기존 비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="member_pw" class="text"/>
					</td>
				</tr>
				<tr>
					<th>
						신규 비밀번호(<span style="color: red;">*</span>)
					</th>
					<td>
						<form:password path="memberNewPw" class="text"/>
						<span id="pwdcheck">영문, 숫자, 특수문자 조합으로 9자이상 20자이내</span>
					</td>
				</tr>
				<tr>
					<th>
						신규 비밀번호 확인(<span style="color: red;">*</span>)
					</th>
					<td>
						<input id="member_pw_confirm" type="password" class="text"> <b id="pw_confirm_message"></b>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<div class="btn-wrap">
		<a href="#" id="save-btn" class="btn btn1">비밀번호 변경</a>
		<a href="/${homepage.context_path}/index.do" id="cancel-btn" class="btn">취소</a>
	</div>
	<br/>
</div>
<c:choose>
<c:when test="${homepage.context_path eq 'app'}">
</div>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>