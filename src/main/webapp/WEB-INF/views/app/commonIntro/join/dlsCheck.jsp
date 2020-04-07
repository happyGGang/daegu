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

	if ('${loginCheck}' == 'false') {
		alert('로그인 후 이용가능합니다.');
		window.close();
	}

	if ('${memberClass}' == 'false') {
		alert('이미 인증된 회원입니다.');
		window.close();
	}

	$('form#dlsForm').submit();
});
</script>


<form id="dlsForm" action="http://reading.edunavi.kr/r/reading/search/ebookView_dg_ck.jsp" method="post">
<input type="hidden" id="return_url" name="return_url" value="http://211.224.118.223:8010/${homepage.context_path}/intro/join/dlsCheckA.do" />
<input type="hidden" id="reading_id" name="reading_id" value="${dlsMember.member_id}" />
<input type="hidden" id="reading_pw" name="reading_pw" value="${dlsMember.member_pw}">
<input type="hidden" id="reading_name" name="reading_name" value="${dlsMember.member_name}">
</form>
