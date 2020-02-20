<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

	$('a#prevEvent').on('click', function(e) {
		var plan_date = new Date($(this).attr('keyValue'));
		plan_date.setDate(plan_date.getDate() - 1);
		$('div.event-box').load('calendar4.do', 'plan_day='+plan_date.format('yyyy-MM-dd'));
		e.preventDefault();
	});
	$('a#nextEvent').on('click', function(e) {
		var plan_date = new Date($(this).attr('keyValue'));
		plan_date.setDate(plan_date.getDate() + 1);
		$('div.event-box').load('calendar4.do', 'plan_day='+plan_date.format('yyyy-MM-dd'));
		e.preventDefault();
	});
});
</script>

<ul>
	<li>
		<div class="box">
			<h3>행사일</h3>
			<span>${fn:replace(calendar.plan_day, '-', '.')}</span>
		</div>
		<div class="list-box">
			<ul>
				<c:if test="${empty calendarResult}">
					<li><a href="#">등록된 일정이 없습니다.</a></li>
				</c:if>
				<c:if test="${not empty calendarResult}">
					<c:forEach items="${calendarResult}" var="i">
					<li>
						<a href="#">${i}</a>
					</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</li>
</ul>

<div class="bx-controls-direction">
	<a id="prevEvent" class="bx-prev" href="" keyValue="${calendar.plan_day}">Prev</a>
	<a id="nextEvent" class="bx-next" href="" keyValue="${calendar.plan_day}">Next</a>
</div>