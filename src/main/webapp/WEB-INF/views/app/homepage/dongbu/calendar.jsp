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

	$('a#before-btn').on('click', function(e) {
		var plan_date = new Date($(this).attr('keyValue'));
		plan_date.setMonth(plan_date.getMonth() - 1);
		$('div.lt1').load('calendar2.do', 'plan_date='+plan_date.format('yyyy-MM'));
		e.preventDefault();
	});
	$('a#next-btn').on('click', function(e) {
		var plan_date = new Date($(this).attr('keyValue'));
		plan_date.setMonth(plan_date.getMonth() + 1);
		$('div.lt1').load('calendar2.do', 'plan_date='+plan_date.format('yyyy-MM'));
		e.preventDefault();
	});
});
</script>

<div class="inBox1">
	<div class="title">
		<strong>휴관일</strong>
	</div>

	<div class="bt-controls">
		<a id="before-btn" class="bt-prev" href="" keyValue="${calendar.plan_date}">Prev</a>
		<b>${fn:split(calendar.plan_date, '-')[0]}.${fn:split(calendar.plan_date, '-')[1]}</b>
		<a id="next-btn" class="bt-next" href="" keyValue="${calendar.plan_date}">Next</a>
	</div>

	<dl class="info">
		<c:if test="${closeDayList.dd eq ''}">
			<dd>등록된 휴일이 없습니다.</dd>
		</c:if>
		<c:if test="${closeDayList.dd ne ''}">
			<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
			<dd>
				<c:forEach items="${dd}" var="i">
				<span>${i}</span>
				</c:forEach>
			</dd>
		</c:if>
	</dl>
</div>

