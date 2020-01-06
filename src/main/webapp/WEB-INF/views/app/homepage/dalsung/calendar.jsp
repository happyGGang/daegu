<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
Date.prototype.format = function(f) {
			if (!this.valueOf())
				return " ";

			var weekName = [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ];
			var d = this;

			return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
				switch ($1) {
				case "yyyy":
					return d.getFullYear();
				case "yy":
					return (d.getFullYear() % 1000).zf(2);
				case "MM":
					return (d.getMonth() + 1).zf(2);
				case "dd":
					return d.getDate().zf(2);
				case "E":
					return weekName[d.getDay()];
				case "HH":
					return d.getHours().zf(2);
				case "hh":
					return ((h = d.getHours() % 12) ? h : 12).zf(2);
				case "mm":
					return d.getMinutes().zf(2);
				case "ss":
					return d.getSeconds().zf(2);
				case "a/p":
					return d.getHours() < 12 ? "오전" : "오후";
				default:
					return $1;
				}
			});
		};

		String.prototype.string = function(len) {
			var s = '', i = 0;
			while (i++ < len) {
				s += this;
			}
			return s;
		};
		String.prototype.zf = function(len) {
			return "0".string(len - this.length) + this;
		};
		Number.prototype.zf = function(len) {
			return this.toString().zf(len);
		};
/*
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
*/
	$('#before-btn').on(
			'click',
			function(e) {
				var plan_date = new Date($(this).attr('keyValue'));
				plan_date.setMonth(plan_date.getMonth() - 1);
				//plan_date.format('yyyy-MM')
				$('div.cal-box').load('calendar3.do',
						'plan_date=' + plan_date.format('yyyy-MM'));
				e.preventDefault();
			});
	$('#next-btn').on(
			'click',
			function(e) {
				var plan_date = new Date($(this).attr('keyValue'));
				plan_date.setMonth(plan_date.getMonth() + 1);
				$('div.cal-box').load('calendar3.do',
						'plan_date=' + plan_date.format('yyyy-MM'));
				e.preventDefault();
			});

	$('a.showCal').on('click', function(e) {
		var key = $(this).attr('keyValue');
		$(".calAll").hide();
		$("#popup_layer").show();
		$("#"+key).show();
		e.preventDefault();
	});

	$('.close').on('click', function(e) {
		$("#popup_layer").hide();
		$(".calAll").hide();
	});

});
</script>

<div id="calendar">
	<div class="cal-func">
		<a id="before-btn" href="#prev" class="btn prev" keyValue="${calendar.plan_date}"><img src="/resources/homepage/${homepage.context_path}/img/prev-cal-btn.png" alt=""><span class="blind">이전달</span></a>
		<b class="date"><span>${fn:split(calendar.plan_date, '-')[0]}.</span> <em>${fn:split(calendar.plan_date, '-')[1]}</em></b>
		<a id="next-btn" href="#next" class="btn next" keyValue="${calendar.plan_date}"><img src="/resources/homepage/${homepage.context_path}/img/next-cal-btn.png" alt=""><span class="blind">다음달</span></a>
	</div>


	<div class="inBox0">
		<div class="week-box">
			<ul>
				<li><a href="" class="today">6</a></li>
				<li><a href="">7</a></li>
				<li><a href="">8</a></li>
				<li><a href="">9</a></li>
				<li><a href="">10</a></li>
				<li><a href="">11</a></li>
				<li><a href="">12</a></li>
			</ul>
		</div>
		<div class="event-box">
			<span><h3 class="">휴관일<Br/>행&nbsp;&nbsp;&nbsp;사</h3></span>
			<span>
				<ul>
					<c:if test="${closeDayList.dd eq ''}">
						<li>등록된 휴일이 없습니다.</li>
					</c:if>
					<c:if test="${closeDayList.dd ne ''}">
						<li>1,2,3
						<!-- <c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
						<c:forEach items="${dd}" var="i">
						${i}
						</c:forEach> -->
						</li>
					</c:if>
					<li>[강좌] 초등겨울방학특강 외 1건</li>
				</ul>
			</span>
		</div>
	</div>


</div>


