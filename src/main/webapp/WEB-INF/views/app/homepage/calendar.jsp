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
	
	$('#before-btn').on('click', function(e) {
		var plan_date = new Date($(this).attr('keyValue'));
		plan_date.setMonth(plan_date.getMonth() - 1); 
		//plan_date.format('yyyy-MM')
		$('div#calendar').load('calendar.do', 'plan_date='+plan_date.format('yyyy-MM'));
		e.preventDefault();
	});
	$('#next-btn').on('click', function(e) {
		var plan_date = new Date($(this).attr('keyValue'));
		plan_date.setMonth(plan_date.getMonth() + 1);
		$('div#calendar').load('calendar.do', 'plan_date='+plan_date.format('yyyy-MM'));
		e.preventDefault();
	});
});
</script>
<div class="cal-func">
	<div class="cal-func">
		<a id="before-btn" href="#prev" class="btn prev" keyValue="${calendar.plan_date}"><i class="fa fa-angle-left"></i><span class="blind">이전달</span></a>
		<b class="date"><span>${fn:split(calendar.plan_date, '-')[0]}/</span><em>${fn:split(calendar.plan_date, '-')[1]}</em></b>
		<a id="next-btn" href="#next" class="btn next" keyValue="${calendar.plan_date}"><i class="fa fa-angle-right"></i><span class="blind">다음달</span></a>
	</div>
	
	<table class="cal-tbl">
		<thead>
			<tr>
				<th class="sun">SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th class="sat">SAT</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${calendarResult}" var="i">
				<tr>
					<td class="sun"><div>${i.sun}</div></td>
					<td><div>${i.mon}</div></td>
					<td><div>${i.tue}</div></td>
					<td><div>${i.wed}</div></td>
					<td><div>${i.thu}</div></td>
					<td><div>${i.fri}</div></td>
					<td class="sat"><div>${i.sat}</div></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
<!-- 	<div id="planList">오늘의 일정이 없습니다. </div> -->
</div>