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
// 		$(".calAll").hide();
// 		$("#popup_layer").show();
		if ($('div#eventDescription'+key).length > 0) {
			$('span.eventDescription').html($('div#eventDescription'+key).html());
		} else {
			$('span.eventDescription').text('등록된 행사가 없습니다.');
		}
		$('a.showCal').removeClass('today');
		$(this).addClass('today');
		e.preventDefault();
	});

	$('.close').on('click', function(e) {
		$("#popup_layer").hide();
		$(".calAll").hide();
	});

	var currDate = '${currDate}';
	var today = parseInt(currDate.split('.')[2])+'';
	$('a.showCal').each(function() {
		if ($(this).text() == today) {
			$(this).click();
			$(this).addClass('today');
			$(this).closest('ul').show();
		}
	});

});
</script>

<div id="calendar2">
	<div class="cal-func2">
		<a id="before-btn" href="#prev" class="btn prev" keyValue="${calendar.plan_date}"><img src="/resources/homepage/${homepage.context_path}/img/prev-cal-btn.png" alt=""><span class="blind">이전달</span></a>
		<b class="date"><span>${fn:split(calendar.plan_date, '-')[0]}.</span> <em>${fn:split(calendar.plan_date, '-')[1]}</em></b>
		<a id="next-btn" href="#next" class="btn next" keyValue="${calendar.plan_date}"><img src="/resources/homepage/${homepage.context_path}/img/next-cal-btn.png" alt=""><span class="blind">다음달</span></a>
	</div>


	<div class="inBox0">
		<div class="week-box">
			<ul>
				<c:forEach items="${calendarList}" var="i">
				<ul style="display: none;">
					<li class="sun">
						<a class="showCal" keyValue="${i.sun}">${i.sun}</a>
					</li>
					<li>
						<a class="showCal" keyValue="${i.mon}">${i.mon}</a>
					</li>
					<li>
						<a class="showCal" keyValue="${i.tue}">${i.tue}</a>
					</li>
					<li>
						<a class="showCal" keyValue="${i.wed}">${i.wed}</a>
					</li>
					<li>
						<a class="showCal" keyValue="${i.thu}">${i.thu}</a>
					</li>
					<li>
						<a class="showCal" keyValue="${i.fri}">${i.fri}</a>
					</li>
					<li class="sat">
						<a class="showCal" keyValue="${i.sat}">${i.sat}</a>
					</li>
				</ul>
			</c:forEach>
			</ul>
		</div>
		<div class="event-box">
			<span><h3 class="">오늘의<Br/>행&nbsp;&nbsp;&nbsp;사</h3></span>
			<span class="eventDescription">
				<ul>
					<li>등록된 행사가 없습니다.</li>
				</ul>
			</span>
		</div>
	</div>

	<div class="planView" style="display: none;">
	<div class="inbox" id="popup_layer" style="display:none;">
			<c:forEach var="i" items="${calendarResult}" varStatus="status">
				<div id="eventDescription${i.key}" class="calAll" style="display: none;">

					<c:set var="l" value="${fn:length(i.value)}"></c:set>
					<c:choose>
						<c:when test="${l == 0}">
						<ul>
							<li>
								등록된 행사가 없습니다.
							</li>
							<li>
							</li>
						</ul>
						</c:when>
						<c:otherwise>
						<ul>
						<c:if test="${l == 1}">
						<li><c:out value="${i.value[0]}"/></li>
						<li></li>
						</c:if>
						<c:if test="${l > 1}">
						<li><c:out value="${i.value[0]}"/></li>
						<li><c:out value="${i.value[1]}"/></li>
						</c:if>
						</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		<a href="#" class="close closePlanView"><i class="fa fa-close"></i></a>
	</div>
	</div>

	<div class="inBox1">
		<div class="title">
			<strong>이달의 휴관일</strong>
		</div>

		<dl class="info">
			<c:if test="${empty closeDayList.dd}">
				<dd>등록된 휴일이 없습니다.</dd>
			</c:if>
			<c:if test="${not empty closeDayList.dd}">
				<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>
				<dd>
					<c:forEach items="${dd}" var="i" begin="0" end="13" varStatus="status">
					<c:if test="${!status.last or fn:length(dd) == 1}">
					<span style="width: auto; height: auto;padding: 1px 10px;">${i}</span>
					</c:if>
					<c:if test="${status.last}">
					<span>...</span>
					</c:if>
					</c:forEach>
				</dd>
			</c:if>
		</dl>
	</div>
</div>


