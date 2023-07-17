<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/circleroom.css"/>
<script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$('select#circles_div').on('change', function() {
		doGetLoad('view.do', serializeCustom($('form#circlesRoomView')));
	});
	
});
</script>

<form:form modelAttribute="circlesRoom" id="circlesRoomView">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="plan_date"/>
<form:hidden path="visit_date"/>

<form:select path="circles_div" cssClass="selectmenu">
	<form:options items="${circlesDivCode}" itemValue="code_id" itemLabel="code_name"/>
</form:select>
</form:form>

<div class="date-time">
	<c:set value="${circlesRoom.visit_date}" var="today" />
	※ <span class="">${fn:substring(today,0,4)}</span>년 <span class="">${fn:substring(today,5,7)}</span>월 <span class="">${fn:substring(today,8,10)}</span>일 신청현황
</div>
<div>
	<ul>
		<c:forEach items="${reqTimeCode}" var="i">
		<li class="circlesTime">
			<p>${i.code_name}</p>
			<c:forEach items="${circlesRoomReqList}" var="j">
				<c:if test="${i.code_id eq j.visit_time}">
				<p>${j.user_name }</p>
				<p>${j.circles_title }</p>
				<p>${j.etc }</p>
				<span>신청완료</span>
				</c:if>
			</c:forEach>
		</li>
		</c:forEach>
	</ul>
</div>
