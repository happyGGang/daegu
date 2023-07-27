<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<c:choose>
<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 1) 
	{
		location.href = "/${homepage.context_path}/intro/login/kioskLogout.do?before_url=/${homepage.context_path}/kiosk/boardIndex.do";
    }
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });
});
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
var idleTime = 0;
function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime >= 1)
	{
		location.href = "/${homepage.context_path}/kiosk/boardIndex.do";
    }
	console.log(idleTime);
}

$(document).ready(function() {
    var idleInterval = setInterval(timerIncrement, 60000);
    $(this).mousemove(function (e) {
        idleTime = 0;
    });
    $(this).keypress(function (e) {
        idleTime = 0;
    });
});
</script>
</c:otherwise>
</c:choose>