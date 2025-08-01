<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    jQuery.fn.monthYearPicker = function (options) {
        options = $.extend({
            dateFormat: "yy-mm-dd",
            changeMonth: true,
            changeYear: true,
            showButtonPanel: false,
            showAnim: "",
            closeText: "선택",
            onChangeMonthYear: writeSelectedDate
        }, options);

        function writeSelectedDate(year, month, inst) {
            var thisFormat = jQuery(this).datepicker("option", "dateFormat");
            var d = jQuery.datepicker.formatDate(thisFormat, new Date(year, month - 1, 1));
            inst.input.val(d);
        }

        function hideDaysFromCalendar() {
            var thisCalendar = $(this);
            jQuery('.ui-datepicker-calendar').detach();
            jQuery('.ui-datepicker-close').click(function () {
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                thisCalendar.datepicker('setDate', new Date(year, month, 1));
                thisCalendar.datepicker("hide");
            });
        }

        jQuery(this).datepicker(options);
    }

    function formatDate(date, withoutDay) {
        var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        if (withoutDay)
            return [year, month].join('-');
        else
            return [year, month, day].join('-');
    }

    $(document).ready(function () {
        <%--검색-- % >
        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', $('form#loginLog').serialize());
        });

        <%--10개씩보기-- % >
        $('select#rowCount').change(function (e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', $('form#loginLog').serialize());
        });

        $('input#search_sdt').monthYearPicker();
        $('input#search_edt').monthYearPicker();

        $('a#search').on('click', function (e) {
            $('form#loginLog').submit();
        });
    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>로그인 기록 관리</div>
    </div>
    <div class="main-content">
        <form:form action="index.do" method="POST" modelAttribute="loginLog">
            <div class="table-action-wrapper">
                <div class="center">
                    <p class="total-count">총 <fmt:formatNumber pattern="#,###" value="${loginLogCnt}"/>건</p>
                    <form:select path="rowCount" class="custom-filter" style="width:130px;">
                        <form:option value="10">10개씩 보기</form:option>
                        <form:option value="20">20개씩 보기</form:option>
                        <form:option value="30">30개씩 보기</form:option>
                        <form:option value="50">50개씩 보기</form:option>
                        <form:option value="${loginLogCnt}">전체 보기</form:option>
                    </form:select>
                </div>

                <div class="search">
                    <fieldset>
                        <label class="blind">검색</label>
                        <form:input cssClass="text ui-calendar" path="search_sdt" placeholder="조회일 선택"/>
                        <form:input cssClass="text ui-calendar" path="search_edt" placeholder="조회종료일 선택"/>
                        <a class="btn" href="#" id="search"><span>조회</span></a>
                    </fieldset>
                </div>
            </div>

            <form:hidden id="member_id_index" path="member_id"/>
            <form:hidden id="editMode_index" path="editMode"/>
            <form:hidden path="menu_idx"/>
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>ID</th>
                        <th>접속 위치</th>
                        <th>기기</th>
                        <th>운영체제</th>
                        <th>브라우저</th>
                        <th>IP</th>
                        <th>일시</th>
                    </tr>
                </thead>
                <tbody id="board_tbody">
                <c:forEach items="${loginLogList}" var="i" varStatus="status">
                    <tr>
                        <td>${paging.listRowNum - status.index}</td>
                        <td>${i.member_id}</td>
                        <td>
                            <c:choose>
                                <c:when test="${i.login_type eq 'CMS'}">
                                    CMS
                                </c:when>
                                <c:otherwise>
                                    ${i.homepage_name}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${i.category}</td>
                        <td>${i.os}</td>
                        <td>${i.browser}</td>
                        <td>${i.ip}</td>
                        <td>${i.login_date}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${fn:length(loginLogList) < 1 }">
                <table class="custom-table">
                    <tr>
                        <td class="dataEmpty">접속 이력이 없습니다.</td>
                    </tr>
                </table>
            </c:if>

            <jsp:include flush="false" page="/WEB-INF/views/app/cms/common/paging.jsp">
                <jsp:param name="formId" value="#loginLog"/>
                <jsp:param name="pagingUrl" value="index.do"/>
            </jsp:include>

            <div class="table-search-bar">
                <fieldset class="search-bar">
                    <form:select path="search_type" cssClass="custom-filter">
                        <form:option value="MEMBER_ID">사용자ID</form:option>
                    </form:select>
                    <form:input path="search_text" cssClass="custom-search"/>
                    <div id="search_btn" class="icon-btn black">
                        <img alt="" src="/resources/cms/img/main/search.svg">
                        <div>검색</div>
                    </div>
                </fieldset>
            </div>
        </form:form>
    </div>
</div>


