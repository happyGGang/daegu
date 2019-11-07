<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
<c:if test="${isDlsMember}">
alert('DLSC 인증이 완료되었습니다. 재 로그인하여 정회원으로 이용가능합니다.');
window.opener.location.href = '/${homepage.context_path}/intro/login/logout.do?relogin=true';
</c:if>

<c:if test="${!isDlsMember}">
alert('DLSC 인증에 실패하였습니다. 다시 시도하시기 바랍니다.');
</c:if>
window.close();
</script>
