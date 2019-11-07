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
	} 
	
	if ('${dupCheck}' == 'true') {
		alert('중복된 이용자가 있습니다.');
		window.close();
		return false;
	}
	
	if ('${findPw}' == 'true') {
		window.opener.location.href = 'setPwForm.do';
		window.close();
		return false;
	}
	
	if ('${}' == 'true') {
		<%-- 회원정보 수정시  --%>
		<%--
		var ci = window.opener.$('input#ci_value').val();
		if (ci != '') {
			
		} else {
			window.opener.$('input#certType').val(certType);
			window.opener.$('input#sci_result').val('${member.sci_result}');
			window.opener.$('input#di_value').val('${member.di_value}');
			window.opener.$('input#ci_value').val('${member.ci_value}');
		}
		--%>
		window.close();
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
			window.opener.$('table#memberForm').show();
			window.opener.$('table#memberForm').show();
			window.opener.$('div#memberCert').show();
			window.close();
		} else {
			var certType = '${certType}';
			if (window.opener.$('td#parentName > input').val() != '') {
				if (parseInt('${member.age}') > 2) {
					alert('14세 미만만 가능합니다.');
					window.close();
					return false;
				}
			}
			var idx1 = certType.toLowerCase().indexOf('sms') > -1 ? 'a' : 'b';
			if (certType != '' && !window.opener.$('p.identy_'+idx1).eq(1).hasClass('success')) {
				window.opener.$('p.identy_'+idx1).eq(1).addClass('success');
				var txt = window.opener.$('p.identy_'+idx1).eq(1).find('span').text();
				window.opener.$('p.identy_'+idx1).eq(1).find('span').html('<i class="fa fa-check"></i> ' + txt + ' 완료');
			}
			window.opener.$('input#certType').val(certType);
			window.close();		
		}
	}
	


	
	
	
	window.close();
});
</script>
