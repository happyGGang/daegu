<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript">
$(function() {
	if ('${certFailed}' == 'true') {
		alert('인증에 실패하였습니다. 다시 시도해주세요.');
		window.close();
		return false;
	} else {
		if (window.opener.location.href.indexOf('integration1.do') > -1) {
			window.opener.$('form#certForm').attr('action', 'integration2.do');
			window.opener.$('form#certForm').attr('target', '');
			window.opener.$('form#certForm').submit();
		} else if ('${changeName1}' == 'true') {
			alert('인증에 실패하였습니다. 다시 시도해주세요.');
			window.close();
			return false;
		} else if ('${changeName2}' == 'true') {
			alert('개명하신 성명이 아닙니다. 확인 후 다시 시도해주세요.');
			window.close();
			return false;
		} else if ('${changeName}' == 'true') {
			window.opener.location.href = '/${changeNameContextPath}/intro/join/changeName.do?menu_idx=${changeNameMenuIdx}';
			window.close();
			return false;
		}
	}


	if ('${dupCheck}' == 'true') {
		if ('${dupUser.USER_CLASS}' == '3') {
			alert('탈퇴 회원입니다. 도서관으로 문의 바랍니다.');
		} else if ('${dupUser.USER_NO}' != '') {
			alert('중복된 이용자가 있습니다.\n\n대출번호는 ${dupUser.USER_NO}입니다.');
		} else {
			alert('준회원으로 가입되어 있습니다.');
		}

		window.close();
		return false;
	}

	if ('${board}' == 'true') {
		window.opener.document.getElementById('board').submit();
		window.close();
		return false;
	} else if ('${boardReply}' == 'true') {
		window.opener.document.getElementById('board').submit();
		window.close();
		return false;
	} else if ('${findPw}' == 'true') {
		if ('${dupCheck2}' == 'true') {
			alert('일치하는 회원이 없습니다');
			window.close();
			return false;
		}
		window.opener.document.getElementById('memberInfo').submit();
		window.close();
		return false;
	} else if ('${findId}' == 'true') {
		window.opener.document.getElementById('memberInfo').submit();
		window.close();
		return false;
	} else if ('${reCert}' == 'true') {
		alert('본인인증이 완료되었습니다. 재 로그인 후 이용가능합니다.');
		window.opener.document.getElementById('loginForm').submit();
		window.close();
		return false;
	} else if ('${integrationFailed2}' == 'true') {
		alert('선택하신 이용자 정보와 본인인증 데이터가 일치하지 않습니다.');
		window.close();
		return false;
	} else if ('${integrationFailed}' == 'true') {
		if ('${integrationFailedUserNo}' != '') {
			alert('해당 대출자 번호의 정보 보정 후 통합인증을 다시 진행해주시기 바랍니다.\n\n대출자 번호 : ${integrationFailedUserNo}');
		} else {
			alert('중복된 회원이 존재합니다. 도서관에 문의하시기 바랍니다.');
		}
		window.close();
		return false;
	} else if ('${integration}' == 'true') {
		if ('${needParentCert}' == 'true') {
			alert('회원님은 만14세미만 이용자입니다.\n보호자 본인인증이 필요합니다.');
			window.opener.$('div#parentCert').show();
			window.opener.$('table#parentTable').show();
			window.opener.$('div#memberCert').hide();
		} else {
			window.opener.document.getElementById('memberInfo').submit();
			window.close();
			return false;
		}
	} else {
		if ('${parent}' == 'true') {
			var certType = '${certType}';
			if ('${member.age}' != '7') {
				alert('보호자(법정대리인)은 20세 이상이어야 합니다.');
				window.close();
				return false;
			}
			window.opener.$('td#parentCert').text($(this).find('span').text() + '완료');
			window.opener.$('td#parentName > input').val('${member.member_name}');
			window.opener.$('input#parentagree').prop('checked', true);
			window.opener.$('div#memberCert').show();
			window.opener.$('a:last').focus();

		} else {
			var certType = '${certType}';
			if ( '${member.ci_value}' == '' ) {
				alert('인증에 실패했습니다. 다시 시도해주세요..');
				window.close();
				return false;
			}
			window.opener.$('input#certType').val(certType);
			window.opener.$('form#memberJoinForm').submit();

		}
	}






	window.close();
});
</script>
