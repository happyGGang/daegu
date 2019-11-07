<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
<c:if test="${isDlsMember}">
if (confirm('DLSC 인증이 완료되었습니다. 재 로그인시 정회원으로 이용가능합니다.\n지금 재 로그인 하시겠습니까?')) {
	window.opener.location.href = '/${homepage.context_path}/intro/login/logout.do';
}
window.close();
</c:if>

<c:if test="${!isDlsMember}">
alert('DLSC 인증에 실패하였습니다.');
window.close();
</c:if>
</script>
