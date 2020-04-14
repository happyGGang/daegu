<%@ page language="java" pageEncoding="utf-8" %>

<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
<script type="text/javascript">
$(function() {

	if ('${certFailed}' == 'true') {
		alert('인증에 실패하였습니다.');
		window.close();
	} else {
		if ('${certResult}' == 'true') {
			alert('인증이 완료되었습니다.\r\n※ 재로그인 후 이용 가능하며, 현재 비대면 인증 회원은 전자도서관만 이용 가능합니다.');
			window.opener.location.href = '/${homepage.context_path}/intro/login/logout.do';
			window.close();
		} else {
			alert('인증에 실패하였습니다.');
			window.close();
		}
	}


});
</script>

