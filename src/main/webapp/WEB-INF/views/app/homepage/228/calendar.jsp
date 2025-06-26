<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
	$(function () {
		Date.prototype.format = function (f) {
			if (!this.valueOf())
				return " ";

			var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
			var d = this;

			return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function ($1) {
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

		String.prototype.string = function (len) {
			var s = '', i = 0;
			while (i++ < len) {
				s += this;
			}
			return s;
		};
		String.prototype.zf = function (len) {
			return "0".string(len - this.length) + this;
		};
		Number.prototype.zf = function (len) {
			return this.toString().zf(len);
		};

		$('a#before-btn').on('click', function (e) {
			var plan_date = new Date($(this).attr('keyValue'));
			plan_date.setMonth(plan_date.getMonth() - 1);
			$('div.calendar').load('calendar3.do', 'plan_date=' + plan_date.format('yyyy-MM'));
			e.preventDefault();
		});

		$('a#next-btn').on('click', function (e) {
			var plan_date = new Date($(this).attr('keyValue'));
			plan_date.setMonth(plan_date.getMonth() + 1);
			$('div.calendar').load('calendar3.do', 'plan_date=' + plan_date.format('yyyy-MM'));
			e.preventDefault();
		});

		$('a.showCal').on('click', function (e) {
			var key = $(this).attr('keyValue');
			$(".calAll").hide();
			$("#popup_layer").show();
			$("#" + key).show();
			e.preventDefault();
		});

		$('a.closePlanView').on('click', function (e) {
			e.preventDefault();
			$("#popup_layer").hide();
			$(".calAll").hide();
		});
	});
</script>

<div id="calendar2">
	<a class="go-to-calendar" href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63">
		<img src="/resources/homepage/${homepage.context_path}/img/culture/calendar-more.svg" alt="">
	</a>
	<div class="calendar-controller">
		<a id="before-btn" href="#prev" keyValue="${calendar.plan_date}">
			<img src="/resources/homepage/${homepage.context_path}/img/culture/calendar-left-arrow.svg" alt="">
		</a>
		<div class="current-month">
			<div>${fn:split(calendar.plan_date, '-')[0]}</div>
			<div>${fn:split(calendar.plan_date, '-')[1] + 0}</div>
		</div>
		<a id="next-btn" href="#next" keyValue="${calendar.plan_date}">
			<img src="/resources/homepage/${homepage.context_path}/img/culture/calendar-right-arrow.svg" alt="">
		</a>
	</div>
	<table>
		<thead>
		<tr>
			<th class="day">SUN</th>
			<th class="day">MON</th>
			<th class="day">TUE</th>
			<th class="day">WED</th>
			<th class="day">THU</th>
			<th class="day">FRI</th>
			<th class="day">SAT</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${calendarList}" var="i">
			<tr>
				<td class="sun">
					<fmt:formatNumber value="${i.sun}" pattern="#" var="daySun"/>
					<c:choose>
						<c:when test="${calendarResult[i.sun] eq null}">
							${daySun}
						</c:when>
						<c:otherwise>
							<c:set var="one" value="${(i.sun.length() < 2 ? '0' : '')}${i.sun}"/>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1}">
									<a class="type-e showCal" keyValue="${i.sun}">${daySun}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.sun}">${daySun}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<fmt:formatNumber value="${i.mon}" pattern="#" var="dayMon"/>
					<c:choose>
						<c:when test="${calendarResult[i.mon] eq null}">${dayMon}</c:when>
						<c:otherwise>
							<c:set var="one" value="${fn:length(i.mon) < 2 ? '0' : '' }${i.mon}"></c:set>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
									<a class="type-e showCal" keyValue="${i.mon}">${dayMon}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.mon}">${dayMon}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<fmt:formatNumber value="${i.tue}" pattern="#" var="dayTue"/>
					<c:choose>
						<c:when test="${calendarResult[i.tue] eq null}">${dayTue}</c:when>
						<c:otherwise>
							<c:set var="one" value="${fn:length(i.tue) < 2 ? '0' : '' }${i.tue}"></c:set>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
									<a class="type-e showCal" keyValue="${i.tue}">${dayTue}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.tue}">${dayTue}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<fmt:formatNumber value="${i.wed}" pattern="#" var="dayWed"/>
					<c:choose>
						<c:when test="${calendarResult[i.wed] eq null}">${dayWed}</c:when>
						<c:otherwise>
							<c:set var="one" value="${fn:length(i.wed) < 2 ? '0' : '' }${i.wed}"></c:set>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
									<a class="type-e showCal" keyValue="${i.wed}">${dayWed}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.wed}">${dayWed}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<fmt:formatNumber value="${i.thu}" pattern="#" var="dayThu"/>
					<c:choose>
						<c:when test="${calendarResult[i.thu] eq null}">${dayThu}</c:when>
						<c:otherwise>
							<c:set var="one" value="${fn:length(i.thu) < 2 ? '0' : '' }${dayThu}"></c:set>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
									<a class="type-e showCal" keyValue="${i.thu}">${dayThu}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.thu}">${dayThu}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<fmt:formatNumber value="${i.fri}" pattern="#" var="dayFri"/>
					<c:choose>
						<c:when test="${calendarResult[i.fri] eq null}">${dayFri}</c:when>
						<c:otherwise>
							<c:set var="one" value="${fn:length(i.fri) < 2 ? '0' : '' }${dayFri}"></c:set>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
									<a class="type-e showCal" keyValue="${i.fri}">${dayFri}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.fri}">${dayFri}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
				<td class="sat">
					<fmt:formatNumber value="${i.sat}" pattern="#" var="daySat"/>
					<c:choose>
						<c:when test="${calendarResult[i.sat] eq null}">${daySat}</c:when>
						<c:otherwise>
							<c:set var="one" value="${fn:length(i.sat) < 2 ? '0' : '' }${daySat}"></c:set>
							<c:choose>
								<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
									<a class="type-e showCal" keyValue="${i.sat}">${daySat}</a>
								</c:when>
								<c:otherwise>
									<a class="type-r showCal" keyValue="${i.sat}">${daySat}</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>


	<div class="planView">
		<div class="inbox" id="popup_layer" style="display:none;">
			<c:forEach var="i" items="${calendarResult}" varStatus="status">
				<div id="${i.key}" class="calAll">
					<div class="calendar-header">
						<c:set var="year" value="${fn:split(calendar.plan_date, '-')[0]}"/>
						<c:set var="monthStr" value="${fn:split(calendar.plan_date, '-')[1]}"/>
						<c:set var="month" value="${monthStr + 0}"/>
						<c:set var="day" value="${i.key + 0}"/>
						<div>
							${year}년 ${month}월 ${day}일
						</div>
						<a href="#" class="close closePlanView">
							<img src="/resources/homepage/${homepage.context_path}/img/culture/calendar-popup-close.svg" alt="">
						</a>
					</div>
					<div class="calendar-content">
						<c:forEach var="count" begin="0" end="${fn:length(i.value)}">
							<c:choose>
								<c:when test="${fn:length(i.value[count]) > 19}">
									<c:out value="${fn:substring(i.value[count], 0, 19)}"/>...
								</c:when>
								<c:otherwise>
									<c:out value="${i.value[count]}"/>
								</c:otherwise>
							</c:choose>
							<c:if test="${count < fn:length(i.value)}">
								<br>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<div class="calendar-caption">
		<div>휴관</div>
		<div>행사</div>
	</div>
</div>
