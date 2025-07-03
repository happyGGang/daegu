<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
            var plan_date = new Date($(this).attr('keyValue'));
            plan_date.setMonth(plan_date.getMonth() - 1);
            $('div#holiday-area').load('calendar2.do', 'plan_date=' + plan_date.format('yyyy-MM'));
            e.preventDefault();
        });

        $('#next-btns').on('click', function (e) {
            var plan_date = new Date($(this).attr('keyValue'));
            plan_date.setMonth(plan_date.getMonth() + 1);
            $('div#holiday-area').load('calendar2.do', 'plan_date=' + plan_date.format('yyyy-MM'));
            e.preventDefault();
        });
    });
</script>

<c:set var="dd" value="${not empty closeDayList.dd ? fn:split(closeDayList.dd, ',') : null}"/>

<div class="holiday-area-title">휴관일</div>
<div class="holiday-area-controller">
    <a href="#" id="before-btns" role="button" keyValue="${calendar.plan_date}">
        <img src="/resources/homepage/${homepage.context_path}/img/main/holiday-left-arrow.svg" alt="지난달"/>
    </a>
    <div>
        ${fn:split(calendar.plan_date, '-')[0]}.<span>${fn:split(calendar.plan_date, '-')[1]}</span>
    </div>
    <a href="#" id="next-btns" role="button" keyValue="${calendar.plan_date}">
        <img src="/resources/homepage/${homepage.context_path}/img/main/holiday-right-arrow.svg" alt="다음달"/>
    </a>
</div>

<div class="holiday-list">
    <c:choose>
        <c:when test="${empty dd}">
            <div class="no-data">등록된 휴관일이 없습니다.</div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${dd}" var="day" end="5">
                <div>${day}</div>
            </c:forEach>
            <c:if test="${fn:length(dd) > 6}">
                <a href="/${homepage.context_path}/module/calendarManage/index.do?menu_idx=63" class="go-to-holiday">
                    <img src="/resources/homepage/${homepage.context_path}/img/main/go-to-holiday.svg" alt="">
                </a>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

