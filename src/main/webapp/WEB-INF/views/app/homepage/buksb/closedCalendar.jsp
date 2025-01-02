<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
	$(function () {
		Date.prototype.format = function (f) {
			if (!this.valueOf()) return ' ';

			var weekName = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
			var d = this;

			return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function ($1) {
				switch ($1) {
					case 'yyyy':
						return d.getFullYear();
					case 'yy':
						return (d.getFullYear() % 1000).zf(2);
					case 'MM':
						return (d.getMonth() + 1).zf(2);
					case 'dd':
						return d.getDate().zf(2);
					case 'E':
						return weekName[d.getDay()];
					case 'HH':
						return d.getHours().zf(2);
					case 'hh':
						return ((h = d.getHours() % 12) ? h : 12).zf(2);
					case 'mm':
						return d.getMinutes().zf(2);
					case 'ss':
						return d.getSeconds().zf(2);
					case 'a/p':
						return d.getHours() < 12 ? '오전' : '오후';
					default:
						return $1;
				}
			});
		};

		String.prototype.string = function (len) {
			var s = '',
					i = 0;
			while (i++ < len) {
				s += this;
			}
			return s;
		};
		String.prototype.zf = function (len) {
			return '0'.string(len - this.length) + this;
		};
		Number.prototype.zf = function (len) {
			return this.toString().zf(len);
		};

		$('#before-btns').on('click', function (e) {
			console.log('이전달');
			var plan_date = new Date($(this).attr('keyValue'));
			plan_date.setMonth(plan_date.getMonth() - 1);
			$('div#holiday-box').load('calendar2.do', 'plan_date=' + plan_date.format('yyyy-MM'));
			e.preventDefault();
		});
		$('#next-btns').on('click', function (e) {
			console.log('다음달');
			var plan_date = new Date($(this).attr('keyValue'));
			plan_date.setMonth(plan_date.getMonth() + 1);
			$('div#holiday-box').load('calendar2.do', 'plan_date=' + plan_date.format('yyyy-MM'));
			e.preventDefault();
		});
	});
</script>

<%--<div class='holiday_area'>--%>
<%--	<div class='holiday_header'>--%>
<%--		<div class='holiday__title'>${fn:split(calendar.plan_date, '-')[1]}월 휴관일</div>--%>
<%--		<div class='holiday__navigation'>--%>
<%--			<div id="before-btns"><img src="/resources/homepage/${homepage.context_path}/img/green_arrow.png" alt="이전달" keyValue="${calendar.plan_date}"/></div>--%>
<%--			<div id="next-btns"><img src="/resources/homepage/${homepage.context_path}/img/green_arrow.png" alt="다음달" keyValue="${calendar.plan_date}"/></div>--%>
<%--			<div>--%>
<%--				<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36">--%>
<%--					<img src="/resources/homepage/${homepage.context_path}/img/green_plus.png" alt="더보기" />--%>
<%--				</a>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--	</div>--%>
<%--		<c:if test="${empty closeDayList.dd}">--%>
<%--			<div>등록된 휴관일이 없습니다.</div>--%>
<%--		</c:if>--%>
<%--		<c:if test="${not empty closeDayList.dd}">--%>
<%--			<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>--%>
<%--				<c:forEach items="${dd}" var="i">--%>
<%--				<div>${i}</div>--%>
<%--				</c:forEach>--%>
<%--		</c:if>--%>
<%--	<div class='holiday_caption'>서변숲도서관은 1·3째 월요일과 법정 공휴일에 휴관합니다.</div>--%>
<%--</div>--%>

<!--휴관일 없을 때 -->
<c:if test="${empty closeDayList.dd}">
	<div class="class='holiday_area'">
		<div class="holiday_header">
			<div class="holiday__title">${fn:split(calendar.plan_date, '-')[0]}년 ${fn:split(calendar.plan_date, '-')[1]}월</div>
			<div class="week_navigation">
				<img id="before-btns" src="/resources/homepage/center/img/closed_day_arrow.svg" alt="지난주" role="button" keyValue="${calendar.plan_date}" />
				<img id="next-btns" src="/resources/homepage/center/img/closed_day_arrow.svg" alt="다음주" role="button" keyValue="${calendar.plan_date}" />
				<div>
					<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36">
						<img src="/resources/homepage/${homepage.context_path}/img/green_plus.png" alt="더보기" />
					</a>
				</div>
			</div>
		</div>
		<ul class="week_area">
			<div class="date" style="font-weight: 400 !important">등록된 휴관일이 없습니다.</div>
			<div class='holiday_caption'>서변숲도서관은 1·3째 월요일과 법정 공휴일에 휴관합니다.</div>
		</ul>
	</div>
</c:if>
<!--휴관일 있을 때 -->
<c:if test="${not empty closeDayList.dd}">
	<c:set var="dd" value="${fn:split(closeDayList.dd, ',')}"></c:set>

	<div class="holiday_area">
		<div class="holiday_header"></div>
			<div class="holiday__title">${fn:split(calendar.plan_date, '-')[0]}년 ${fn:split(calendar.plan_date, '-')[1]}월</div>
			<div class="week_navigation">
				<img id="before-btns" src="/resources/homepage/center/img/closed_day_arrow.svg" alt="지난주" role="button" keyValue="${calendar.plan_date}" />
				<img id="next-btns" src="/resources/homepage/center/img/closed_day_arrow.svg" alt="다음주" role="button" keyValue="${calendar.plan_date}" />
				<div>
					<a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=36">
						<img src="/resources/homepage/${homepage.context_path}/img/green_plus.png" alt="더보기" />
					</a>
				</div>
			</div>
	</div>
	<ul class="week_area">
		<c:forEach items="${dd}" var="i">
			<li>${i}</li>
		</c:forEach>
	</ul>
	<div class='holiday_caption'>서변숲도서관은 1·3째 월요일과 법정 공휴일에 휴관합니다.</div>
</c:if>
