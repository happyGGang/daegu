<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
<c:if test="${isDlsMember}">
alert('DLSC 인증이 완료되었습니다');
window.opener.$('div#dlsForm').text('인증완료');
window.close();
</c:if>

<c:if test="${!isDlsMember}">
<% request.getSession().setAttribute("dls_id", null); %>
alert('DLSC 인증에 실패하였습니다. 아이디 또는 비밀번호를 확인해주세요.');
window.close();
</c:if>
</script>
