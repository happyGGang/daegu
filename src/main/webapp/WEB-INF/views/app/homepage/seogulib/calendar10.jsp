<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(function() {
	Date.prototype.format = function(f) {
	    if (!this.valueOf()) return " ";

	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	    var d = this;

	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
	        switch ($1) {
	            case "yyyy": return d.getFullYear();
	            case "yy": return (d.getFullYear() % 1000).zf(2);
	            case "MM": return (d.getMonth() + 1).zf(2);
	            case "dd": return d.getDate().zf(2);
	            case "E": return weekName[d.getDay()];
	            case "HH": return d.getHours().zf(2);
	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
	            case "mm": return d.getMinutes().zf(2);
	            case "ss": return d.getSeconds().zf(2);
	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
	            default: return $1;
	        }
	    });
	};

	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	Number.prototype.zf = function(len){return this.toString().zf(len);};

	$('a#before-btn').on('click', function(e) {
		var plan_date = new Date($(this).data('c'));
		plan_date.setDate(plan_date.getDate() - 1);
		$('div.sec01-3').load('calendar10.do', 'plan_date='+plan_date.format('yyyy-MM-dd'));
		e.preventDefault();
	});
	$('a#next-btn').on('click', function(e) {
		var plan_date = new Date($(this).data('c'));
		plan_date.setDate(plan_date.getDate() + 1);
		$('div.sec01-3').load('calendar10.do', 'plan_date='+plan_date.format('yyyy-MM-dd'));
		e.preventDefault();
	});
});
</script>
<div class="title">
	<span>
		<strong>오늘의 도서관 일정</strong>을 확인하세요!
	</span>
	<a href="module/calendarManage/index.do?menu_idx=36">전체일정</a>
</div>

<div class="date">
	<fmt:parseDate var="toDay_D" value="${calendarManage.plan_date}" pattern="yyyy-MM-dd" />
	<a href="#" id="before-btn" data-c="${calendarManage.plan_date}"><img src="/resources/homepage/seogulib/img/date_prev.png"></a>
	<span>${fn:split(calendarManage.plan_date, '-')[1]}.${fn:split(calendarManage.plan_date, '-')[2]} (<fmt:formatDate value="${toDay_D}" pattern="E"/>)</span>
	<a href="#" id="next-btn" data-c="${calendarManage.plan_date}"><img src="/resources/homepage/seogulib/img/date_next.png"></a>
</div>

<div class="event">
	<div class="tit"><span>행사</span></div>
	<c:forEach items="${eventList}" var="i">
		<div>
			<span>
				<c:choose>
					<c:when test="${i eq 'h77'}">어린이</c:when>
					<c:when test="${i eq 'h61'}">비산</c:when>
					<c:when test="${i eq 'h62'}">영어</c:when>
					<c:when test="${i eq 'h63'}">비원</c:when>
					<c:when test="${i eq 'h64'}">원고개</c:when>
					<c:when test="${i eq 'h96'}">New평리</c:when>
				</c:choose>
			</span>
		</div>
	</c:forEach>
	<c:if test="${fn:length(eventList) < 1 }">
		<div>
			<span>없음</span>
		</div>
	</c:if>
</div>

<!--<div class="movie">
	<div class="tit"><span>영화</span></div>
	<c:forEach items="${movieList}" var="i">
		<div><span>${i}</span></div>
	</c:forEach>
	<c:if test="${fn:length(movieList) < 1 }">
		<div>
			<span>없음</span>
		</div>
	</c:if>
</div>-->

<div class="closed">
	<div class="tit"><span>휴관</span></div>
	<c:forEach items="${closeList}" var="i">
		<div>
			<span>
				<c:choose>
					<c:when test="${i eq 'h77'}">어린이</c:when>
					<c:when test="${i eq 'h61'}">비산</c:when>
					<c:when test="${i eq 'h62'}">영어</c:when>
					<c:when test="${i eq 'h63'}">비원</c:when>
					<c:when test="${i eq 'h64'}">원고개</c:when>
					<c:when test="${i eq 'h96'}">New평리</c:when>
				</c:choose>
			</span>
		</div>
	</c:forEach>
	<c:if test="${fn:length(closeList) < 1 }">
		<div>
			<span>없음</span>
		</div>
	</c:if>
</div>
