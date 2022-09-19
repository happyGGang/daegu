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

		$('a#before-btn').on('click',function(e) {
			var plan_date = new Date($(this).attr('keyValue'));
			plan_date.setMonth(plan_date.getMonth() - 1);
			//plan_date.format('yyyy-MM')
			$('div#calendar-box').load('calendar3.do','plan_date=' + plan_date.format('yyyy-MM') + '&homepage_id=' + $('select#dongguCalendar option:selected').val());
			e.preventDefault();
		});

		$('a#next-btn').on('click',function(e) {
			var plan_date = new Date($(this).attr('keyValue'));
			plan_date.setMonth(plan_date.getMonth() + 1);
			$('div#calendar-box').load('calendar3.do','plan_date=' + plan_date.format('yyyy-MM') + '&homepage_id=' + $('select#dongguCalendar option:selected').val());
			e.preventDefault();
		});

		$('select#dongguCalendar').on('change', function() {
			$('div#calendar-box').load('calendar3.do','plan_date=${calendar.plan_date}&homepage_id=' + $(this).val());
		});

		$('a.showCal').on('click', function(e) {
			var key = $(this).attr('keyValue');
			$(".calAll").hide();
			$("#popup_layer").show();
			$("#"+key).show();
			e.preventDefault();
		});

		$('a.closePlanView').on('click', function(e) {
			e.preventDefault();
			$("#popup_layer").hide();
			$(".calAll").hide();
		});

});
</script>

<div id="calendar2">
	<div class="calendar_select_box_wrap">
		<select name="" id="dongguCalendar" class="calendar_select_box">
			<option value="h73" ${calendar.homepage_id eq 'h73' ? 'selected' : ''}>안심도서관</option>
			<option value="h59" ${calendar.homepage_id eq 'h59' ? 'selected' : ''}>신천도서관</option>
			<option value="h60" ${calendar.homepage_id eq 'h60' ? 'selected' : ''}>작은도서관</option>
		</select>
		<a href="module/calendarManage/index.do?menu_idx=142&homepage_id=${calendar.homepage_id}" class="btn-more more-more cal-more">
			<img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기">
		</a>
	</div>
	<div class="cal-box">
		<div class="cal-today">
			<a id="before-btn" href="#prev" class="btn cal-today-btn prev" keyValue="${calendar.plan_date}">
				<img src="/resources/homepage/${homepage.context_path}/img/cal_prev_btn.png" alt="이전달"><span class="blind">이전달</span>
			</a>
			<span class="cal-n1">${fn:split(calendar.plan_date, '-')[0]}.</span>
			<span class="cal-date">${fn:split(calendar.plan_date, '-')[1]}</span>
			<a id="next-btn" href="#next" class="btn cal-today-btn next" keyValue="${calendar.plan_date}">
				<img src="/resources/homepage/${homepage.context_path}/img/cal_next_btn.png" alt="다음달"><span class="blind">다음달</span>
			</a>
		</div>

		<div class="cal-cal">
			<table class="cal-tbl">
				<thead>
					<tr>
						<th class="sun"><span class="">SUN</span></th>
						<th><span class="">MON</span></th>
						<th><span class="">TUE</span></th>
						<th><span class="">WED</span></th>
						<th><span class="">THU</span></th>
						<th><span class="">FRI</span></th>
						<th class="sat"><span class="">SAT</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${calendarList}" var="i">
						<tr>
							<td class="sun">
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.sun] eq null}">${i.sun}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.sun) < 2 ? '0' : '' }${i.sun}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.sun}">${i.sun}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.sun}">${i.sun}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td>
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.mon] eq null}">${i.mon}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.mon) < 2 ? '0' : '' }${i.mon}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.mon}">${i.mon}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.mon}">${i.mon}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td>
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.tue] eq null}">${i.tue}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.tue) < 2 ? '0' : '' }${i.tue}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.tue}">${i.tue}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.tue}">${i.tue}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td>
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.wed] eq null}">${i.wed}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.wed) < 2 ? '0' : '' }${i.wed}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.wed}">${i.wed}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.wed}">${i.wed}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td>
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.thu] eq null}">${i.thu}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.thu) < 2 ? '0' : '' }${i.thu}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.thu}">${i.thu}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.thu}">${i.thu}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td>
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.fri] eq null}">${i.fri}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.fri) < 2 ? '0' : '' }${i.fri}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.fri}">${i.fri}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.fri}">${i.fri}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
							<td class="sat">
								<div>
									<c:choose>
										<c:when test="${calendarResult[i.sat] eq null}">${i.sat}</c:when>
										<c:otherwise>
											<c:set var="one" value="${fn:length(i.sat) < 2 ? '0' : '' }${i.sat}"></c:set>
											<c:choose>
												<c:when test="${fn:indexOf(closeDayList.dd, one) > -1 }">
													<a class="type-e showCal" keyValue="${i.sat}">${i.sat}</a>
												</c:when>
												<c:otherwise>
													<a class="type-r showCal" keyValue="${i.sat}">${i.sat}</a>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="end"></div>

		<div class="calendar-info">
			<span class="hu">휴관</span>
			<span class="ev">행사</span>
		</div>
	</div>

	<div class="planView">
		<div class="inbox">
			<c:forEach var="i" begin="1" end="31" varStatus="status">
				<c:set var="key" value="${i < 10 ? '0':''}${i}"></c:set>
				<c:set var="idx" value="${i < 10 ? '':''}${i}"></c:set>
				<c:forEach var="j" items="${calendarResult[idx]}">
					<c:set var="ty" value="${fn:split(j, ']')}"></c:set>
					<div class="planList">
						<p class="datetime">${calendar.plan_date}-${key}</p>
						<p class="title"><em>${ty[0]}${fn:length(ty) > 1 ? ']' : (fn:startsWith(ty[1], '[') ? ']' : '')}</em>
							<c:choose>
								<c:when test="${fn:startsWith(ty[1], '[')}">
									${ty[1]}]${ty[2]}
								</c:when>
								<c:otherwise>
									${ty[1]}]
								</c:otherwise>
							</c:choose>	
						</p>
					</div>
				</c:forEach>
			</c:forEach>
		</div>
	</div>

</div>

