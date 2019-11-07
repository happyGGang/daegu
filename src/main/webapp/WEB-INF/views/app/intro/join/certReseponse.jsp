<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="membername" value="${member.member_name}"></c:set>
<c:set var="memberci" value="${member.ci_value}"></c:set>
<%
	if (request.getRemoteAddr().equals("220.81.69.22") || request.getRemoteAddr().equals("121.182.43.205")) {
		//System.out.println("@@@@@@@@@@@@@@@@ member_name : " + (String)pageContext.getAttribute( "membername" ));
		//System.out.println("@@@@@@@@@@@@@@@@ member_ci : " + (String)pageContext.getAttribute( "memberci" ));
	}
%>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript">
$(function() {
	var isEng = '';
	try {
		window.opener.$('input#langMode').val() == 'eng';
	} catch(e) {
	}
	if ('${certFailed}' == 'true') {
		alert('인증에 실패하였습니다. 다시 시도해주세요. 오류 코드: 008');
		window.close();
		return false;
	} else {
		if (window.opener.location.href.indexOf('integration1.do') > -1) {
			window.opener.$('form#certForm').attr('action', 'integration2.do');
			window.opener.$('form#certForm').attr('target', '');
			window.opener.$('form#certForm').submit();
		} else if ('${changeName1}' == 'true') {
			alert('인증에 실패하였습니다. 다시 시도해주세요. 오류 코드: 009');
			window.close();
			return false;
		} else if ('${changeName2}' == 'true') {
			alert('개명하신 성명이 아닙니다. 확인 후 다시 시도해주세요.');
			window.close();
			return false;
		} else if ('${changeName}' == 'true') {
			window.opener.location.href = 'https://www.gbelib.kr/${changeNameContextPath}/intro/join/changeName.do?menu_idx=${changeNameMenuIdx}';
			window.close();
			return false;
		}
	}


	if ('${dupCheck}' == 'true') {
		if (window.opener.location.href.indexOf('gbelib.kr/intro') == -1) {
			if (("${unAgreeFlag eq '0001'}" == 'true' || "${unAgreeFlag eq '0002'}" == 'true') && "${empty member.web_id}" == "true") {
				if (isEng) {
					alert('There is another user overlapped.\n\nwill move to the page for login.');
				} else {
					alert('기존 회원 가입 내역이 있습니다.\n\n확인 버튼을 눌러주시기 바랍니다.');
				}
// 				alert('중복된 이용자가 있습니다.\n\n로그인 페이지로 이동합니다.');
// 				window.opener.location.href = 'https://www.gbelib.kr/${homepage.context_path}/intro/login/index.do?menu_idx=${loginMenuIdx}';
				window.opener.$('form#loginForm').submit();
				window.close();
				return false;
			} else {
				if (isEng) {
					alert('There is another user overlapped.\n\nt will move to the page for change to integrated member.');
				} else {
					alert('중복된 이용자가 있습니다.\n\n통합회원 전환 페이지로 이동합니다.');
				}
				window.opener.$('form#certForm').attr('action', 'integration2.do');
				window.opener.$('form#certForm').attr('target', '');
				window.opener.$('form#certForm').submit();
				window.close();
				return false;
			}
		} else {
			if (("${unAgreeFlag eq '0001'}" == 'true' || "${unAgreeFlag eq '0002'}" == 'true') && "${empty member.web_id}" == "true") {
				if (isEng) {
					alert('There is another user overlapped.\n\nwill move to the page for login.');
				} else {
					alert('기존 회원 가입 내역이 있습니다.\n\n확인 버튼을 눌러주시기 바랍니다.');
				}
// 				alert('중복된 이용자가 있습니다.\n\n로그인 페이지로 이동합니다.');
// 				window.opener.location.href = 'https://www.gbelib.kr/${homepage.context_path}/intro/login/index.do?menu_idx=${loginMenuIdx}';
				window.opener.$('form#loginForm').submit();
				window.close();
				return false;
			} else {
				if (isEng) {
					alert('There is another user overlapped.\n\nt will move to the page for change to integrated member.');
				} else {
					alert('중복된 이용자가 있습니다.\n\n통합회원 전환 페이지로 이동합니다.');
				}
				window.opener.$('form#certForm').attr('action', 'integration2.do');
				window.opener.$('form#certForm').attr('target', '');
				window.opener.$('form#certForm').submit();
				window.close();
				return false;
			}
// 			if (isEng) {
// 				alert('There is another user overlapped.');
// 			} else {
// 				alert('중복된 이용자가 있습니다.');
// 			}
		}
		window.close();
		return false;
	}
	
	if ('${findPw}' == 'true') {
		if ('${dupCheck2}' == 'true') {
			alert('통합회원 전환 진행을 하지 않았거나 존재하지 않는 회원입니다.');
			window.close();
			return false;
		}
		window.opener.document.getElementById('memberInfoForm').submit();
		window.close();
		return false;
	} else {
		if ('${parent}' == 'true') {
			var certType = '${certType}';
			if ("${member.age ne '7'}" == 'true') {
				alert('보호자(법정대리인)은 20세 이상이어야 합니다.');
				window.close();
				return false;
			}
			var idx1 = certType.toLowerCase().indexOf('sms') > -1 ? 'a' : 'b';
			if (certType != '' && !window.opener.$('p.identy_'+idx1).eq(0).hasClass('success')) {
				window.opener.$('p.identy_'+idx1).eq(0).addClass('success');
				var txt = window.opener.$('p.identy_'+idx1).eq(0).find('span').text();
				window.opener.$('p.identy_'+idx1).eq(0).find('span').html('<i class="fa fa-check"></i> ' + txt + ' 완료');
			}
			window.opener.$('td#parentCert').text($(this).find('span').text() + '완료');
			window.opener.$('td#parentName > input').val('${member.member_name}');
			window.opener.$('input#parentagree').prop('checked', true);
			window.opener.$('table#memberForm').show();
			window.opener.$('table#memberForm').show();
			window.opener.$('div#memberCert').show();

		} else {
			var certType = '${certType}';
			console.log('@@@@@@@@@@@@@ certType : ' + certType);
// 			if (window.opener.$('td#parentName > input').val() != '') {
// 				if (parseInt('${member.age}') > 2) {
// 					alert('14세 미만만 가능합니다.');
// 					window.close();
// 					return false;
// 				}
// 			}

			if ( '${empty member.ci_value}' == 'true' ) {
				alert('인증에 실패했습니다. 다시 시도해주세요. 오류코드: 010');
				window.close();
				return false;
			}
			
			var idx1 = certType.toLowerCase().indexOf('sms') > -1 ? 'a' : 'b';
			if (certType != '' && !window.opener.$('p.identy_'+idx1).eq(1).hasClass('success')) {
				window.opener.$('p.identy_'+idx1).eq(1).addClass('success');
				var txt = window.opener.$('p.identy_'+idx1).eq(1).find('span').text();
				window.opener.$('p.identy_'+idx1).eq(1).find('span').html('<i class="fa fa-check"></i> ' + txt + ' 완료');
			}
			window.opener.$('input#certType').val(certType);
			window.opener.$('form#memberJoinForm').submit();
	// 		window.close();
		}
	}






	window.close();
});
</script>
