<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
    $(function () {
        var curYear = new Date().getUTCFullYear();
        // 연도 초기화
        for (var i = 0; i < 10; i++) {
            $('#start_year,#end_year').append('<option value="' + (curYear - i) + '">' + (curYear - i) + '</option>');
        }

        //달력(통계 기간 선택 오류 방지)
        $('input#dateStart').datepicker({
            maxDate: $('input#dateEnd').val(),
            onClose: function (selectedDate) {
                $('input#dateEnd').datepicker('option', 'minDate', selectedDate);
            }
        });
        $('input#dateEnd').datepicker({
            minDate: $('input#dateStart').val(),
            onClose: function (selectedDate) {
                $('input#dateStart').datepicker('option', 'maxDate', selectedDate);
            }
        });

        $('select#date_type').change(function (e) {
            var date_type = this.value;
            $('#dateStart').show();
            $('#tilde').show();
            $('#dateEnd').show();
            $('#startMonthBox').show();
            $('#endMonthBox').show();
            $('#startYearBox').show();
            $('#endYearBox').show();

            if (date_type == 'DAY') {
                $('#startYearBox').hide();
                $('#endYearBox').hide();
            } else if (date_type == 'MONTH') {
                $('#dateStart').hide();
                $('#tilde').hide();
                $('#dateEnd').hide();
                $('#endYearBox').hide();
            } else if (date_type == 'YEAR') {
                $('#monthBox').hide();
                $('#dateStart').hide();
                $('#tilde').hide();
                $('#dateEnd').hide();
            }
        });

        $('select#date_type').trigger('change');


        $('#calendarStatusSearch #searchBtn').on('click', function (e) {

            if ($('select#homepageId option:selected').val() == '0') {
                alert('홈페이지를 선택해주세요.');
                return false;
            }

            if ($('#date_type').val() === 'YEAR') {
                var yearCount = $('#end_year').val() == $('#start_year').val() ? 1 : $('#end_year').val() - $('#start_year').val();
                $('#year_count').val(yearCount);
            }

            if ($('#homepageId').val() != '') {
                $('#homepageName').val($('#homepageId option:selected').text());
                $('#calendarStatusSearch').submit();
            }
            e.preventDefault();
        });

        var type = $('#calendarStatusSearch #type').val();

        $('div#calendar').hide();
        $('div#teacher').hide();
        $('div#excursions').hide();
        $('div#support').hide();
        $('div#facility').hide();
        $('div#locker').hide();
        $('div#board').hide();

        if (type == 'calendar') {
            $('div#calendar').show();
        } else if (type == 'teacher') {
            $('div#teacher').show();
        } else if (type == 'excursions') {
            $('div#excursions').show();
        } else if (type == 'support') {
            $('div#support').show();
        } else if (type == 'facility') {
            $('div#facility').show();
        } else if (type == 'locker') {
            $('div#locker').show();
        } else if (type == 'board') {
            $('div#board').show();
        } else {
            if ('${calendarStatus.homepage_id}' != '') {
                $('div#calendar').show();
                $('div#teacher').show();
                $('div#excursions').show();
                $('div#support').show();
                $('div#facility').show();
                $('div#locker').show();
                $('div#board').show();
            }
        }

        $('div.tabmenu > ul > li > a').on('click', function (e) {
            e.preventDefault();
            if (!($(this).parent().hasClass('active'))) {
                $(this).parents('ul').children().removeClass('active');
                $(this).parent().parent().parent().parent().children('div.tabCon').removeClass('active');
                $(this).parent().addClass('active');
                var activeTab = $(this).attr('href');
                $(activeTab).addClass('active');
            }
        });

        $('a#excelDownload').on('click', function (e) {
            e.preventDefault();

            if ($('select#homepageId option:selected').val() == '0') {
                alert('홈페이지를 선택해주세요.');
                return false;
            }


            if ($('select#homepage_id')) {
                $('input#homepageName').val($('select#homepage_id option:selected').text());
            } else {
            }

            var param = $('form#calendarStatusSearch').serialize();
            $.get('excelDownloadTest.do?' + param, function (response) {
                if (!response.valid) {
                    alert(response.message);
                    return false;
                } else {
                    $('#calendarStatusSearch').attr('action', 'excelDownload.do');
                    $('#calendarStatusSearch').submit();
                    $('#calendarStatusSearch').attr('action', 'index.do');
                }
            });

        });

        $('a#csvDownload').on('click', function (e) {
            e.preventDefault();

            if ($('select#homepageId option:selected').val() == '0') {
                alert('홈페이지를 선택해주세요.');
                return false;
            }

            if ($('select#homepage_id')) {
                $('input#homepageName').val($('select#homepage_id option:selected').text());
            } else {
            }

            var param = $('form#calendarStatusSearch').serialize();
            $.get('excelDownloadTest.do?' + param, function (response) {
                if (!response.valid) {
                    alert(response.message);
                    return false;
                } else {
                    $('#calendarStatusSearch').attr('action', 'csvDownload.do');
                    $('#calendarStatusSearch').submit();
                    $('#calendarStatusSearch').attr('action', 'index.do');
                }
            });

        });
    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>이달의 행사</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form id="calendarStatusSearch" modelAttribute="calendarStatus" action="index.do" method="post" cssClass="btn-wrapper">
                <form:hidden id="homepageName" path="homepage_name"/>
                <form:hidden path="year_count"/>

                <c:choose>
                    <c:when test="${member.admin}">
                        <form:select id="homepageId" path="homepage_id" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                            <option value="0" disabled selected="selected">홈페이지 선택</option>
                            <c:forEach var="i" varStatus="status" items="${homepageList}">
                                <option value="${i.homepage_id}" <c:if test="${i.homepage_id eq calendarStatus.homepage_id }">selected="selected"</c:if>>${i.homepage_name}</option>
                            </c:forEach>
                        </form:select>
                    </c:when>
                    <c:otherwise>
                        <form:hidden id="homepageId" path="homepage_id" value="${calendarStatus.homepage_id}"/>
                    </c:otherwise>
                </c:choose>

                <form:select id="type" path="type" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                    <option value="">선택</option>
                    <option value="calendar" <c:if test="${'calendar' eq calendarStatus.type }">selected="selected"</c:if>>일정
                    </option>
                    <option value="teacher" <c:if test="${'teacher' eq calendarStatus.type }">selected="selected"</c:if>>독서/강좌
                    </option>
                    <option value="excursions" <c:if test="${'excursions' eq calendarStatus.type }">selected="selected"</c:if>>
                        견학
                    </option>
                    <option value="support" <c:if test="${'support' eq calendarStatus.type }">selected="selected"</c:if>>현장지원
                    </option>
                    <option value="facility" <c:if test="${'facility' eq calendarStatus.type }">selected="selected"</c:if>>시설물
                    </option>
                    <option value="locker" <c:if test="${'locker' eq calendarStatus.type }">selected="selected"</c:if>>사물함
                    </option>
                    <option value="board" <c:if test="${'board' eq calendarStatus.type }">selected="selected"</c:if>>영화상영
                    </option>
                </form:select>

                <form:select id="date_type" path="date_type" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                    <option disabled>날짜 분류 선택</option>
                    <option value="DAY" <c:if test="${'DAY' eq calendarStatus.date_type }">selected="selected"</c:if>>일간별
                    </option>
                    <option value="MONTH" <c:if test="${'MONTH' eq calendarStatus.date_type }">selected="selected"</c:if>>월간별
                    </option>
                    <option value="YEAR" <c:if test="${'YEAR' eq calendarStatus.date_type }">selected="selected"</c:if>>연간별
                    </option>
                </form:select>
                <div class="btn-wrapper">
                    <form:input type="text" id="dateStart" path="start_date" class="custom-date ui-calendar"/>
                    <p id="tilde" class="caption">~</p>
                    <form:input type="text" id="dateEnd" path="end_date" class="custom-date ui-calendar"/>
                </div>
                <div class="btn-wrapper">
                    <div id="startYearBox">
                        <form:select path="start_year" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;"></form:select>
                    </div>
                    <div id="endYearBox" class="btn-wrapper">
                        <p id="yearTilde" class="caption">~</p>
                        <form:select path="end_year" class="custom-date" cssStyle="width:100px;"></form:select>
                    </div>
                </div>

                <div id="searchBtn" class="icon-btn black">
                    <img src="/resources/cms/img/main/search.svg" alt="">
                    <div>검색</div>
                </div>
                <a href="#" id="excelDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/excel.svg" alt="">
                    <div>엑셀저장</div>
                </a>
                <a href="#" id="csvDownload" class="icon-btn green">
                    <img src="/resources/cms/img/main/csv.svg" alt="">
                    <div>CSV저장</div>
                </a>
            </form:form>
        </div>

<%--        <div class="tabmenu tab1" display: none;">--%>
<%--            <ul>--%>
<%--                <li class="active"><a href="#" keyValue="table1">행사일정</a></li>--%>
<%--                <li class=""><a href="#" keyValue="table2">대기자</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>

        <br>
        <div style="display:none;" id="calendar">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>행사일정</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                <tr>
                    <th width="50%;">기간</th>
                    <th>건수</th>
                    <th>백분율</th>
                </tr>
                </thead>
                <c:forEach var="i" varStatus="status" items="${calendarList}">
                    <c:if test="${status.first}">
                        <c:set var="total_count" value="${i.count }"/>
                    </c:if>
                    <c:if test="${!status.first}">
                        <tr>
                            <td>${i.start_date}</td>
                            <td>${i.count}</td>
                            <td>
                                <c:if test="${i.count == 0}">
                                    0
                                </c:if>
                                <c:if test="${i.count != 0}">
                                    <fmt:formatNumber value="${i.count / total_count * 100}" pattern="0"/>
                                </c:if>
                                %
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td><em>${total_count}</em></td>
                    <td>
                        <em>
                            <c:if test="${total_count == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display:none;" id="teacher">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>독서문화강좌</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                    <tr>
                        <th width="50%;">기간</th>
                        <th>건수</th>
                        <th>백분율</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>합계</th>
                        <td><em></em></td>
                        <td><em></em></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div style="display:none;" id="excursions">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>견학/체험</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                <tr>
                    <th width="50%;">기간</th>
                    <th>대기</th>
                    <th>불가</th>
                    <th>승인</th>
                    <th>건수</th>
                    <th>백분율</th>
                </tr>
                </thead>
                <c:forEach var="i" varStatus="status" items="${excursionsList}">
                    <c:if test="${status.first}">
                        <c:set var="total_count" value="${i.imsi_v1 }"/>
                        <c:set var="total_count2" value="${i.imsi_v2 }"/>
                        <c:set var="total_count3" value="${i.imsi_v3 }"/>
                        <c:set var="total_count4" value="${i.imsi_v4 }"/>
                        <c:set var="total_count5" value="${i.imsi_v5 }"/>
                    </c:if>
                    <c:if test="${!status.first}">
                        <tr>
                            <td>${i.start_date}</td>
                            <td>${i.imsi_v1}</td>
                            <td>${i.imsi_v2}</td>
                            <td>${i.imsi_v3}</td>
                            <td>${i.imsi_v4}</td>
                            <td>
                                <c:if test="${total_count5 == 0}">
                                    0
                                </c:if>
                                <c:if test="${total_count5 != 0}">
                                    <fmt:formatNumber
                                            value="${(i.imsi_v1 + i.imsi_v2 + i.imsi_v3 + i.imsi_v4) / total_count5 * 100}"
                                            pattern="0"/>
                                </c:if>
                                %
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td>
                        <em>
                            <c:if test="${total_count == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                        <em>
                            <c:if test="${total_count2 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count2 != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                        <em>
                            <c:if test="${total_count3 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count3 != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                        <em>
                            <c:if test="${total_count4 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count4 != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td></td>
                </tr>
            </table>
        </div>
        <div style="display:none;" id="support">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>현장지원</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                <tr>
                    <th width="50%;">기간</th>
                    <th>미처리</th>
                    <th>처리완료</th>
                    <th>건수</th>
                    <th>백분율</th>
                </tr>
                </thead>
                <c:forEach var="i" varStatus="status" items="${supportList}">
                    <c:if test="${status.first}">
                        <c:set var="total_count" value="${i.imsi_v1 }"/>
                        <c:set var="total_count2" value="${i.imsi_v2 }"/>
                        <c:set var="total_count3" value="${i.imsi_v3 }"/>
                    </c:if>
                    <c:if test="${!status.first}">
                        <tr>
                            <td>${i.start_date}</td>
                            <td>${i.imsi_v1}</td>
                            <td>${i.imsi_v2}</td>
                            <td>${i.imsi_v3}</td>
                            <td>
                                <c:if test="${total_count3 == 0}">
                                    0
                                </c:if>
                                <c:if test="${total_count3 != 0}">
                                    <fmt:formatNumber value="${(i.imsi_v1 + i.imsi_v2) / total_count3 * 100}" pattern="0"/>
                                </c:if>
                                %
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td>
                        <em>
                            <c:if test="${total_count == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                        <em>
                            <c:if test="${total_count2 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count2 != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                        <em>
                            <c:if test="${total_count3 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count3 != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display:none;" id="facility">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>시설물신청현황</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                <tr>
                    <th width="50%;">기간</th>
                    <th>신청현황</th>
                    <th>백분율</th>
                </tr>
                </thead>
                <c:forEach var="i" varStatus="status" items="${facilityList}">
                    <c:if test="${status.first }">
                        <c:set var="total_count" value="${i.imsi_v1}"/>
                    </c:if>

                    <c:if test="${!status.first}">
                        <tr>
                            <td>${i.start_date}</td>
                            <td>${i.imsi_v1}</td>
                            <td>
                                <c:if test="${i.imsi_v1 == 0}">
                                    0
                                </c:if>
                                <c:if test="${i.imsi_v1 != 0}">
                                    <fmt:formatNumber value="${i.imsi_v1 / total_count * 100}" pattern="0"/>
                                </c:if>
                                %
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td><em>${total_count}</em></td>
                    <td>
                        <em>
                            <c:if test="${total_count == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display:none;" id="locker">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>사물함신청현황</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                <tr>
                    <th width="50%;">기간</th>
                    <th>사물함 개수</th>
                    <th>신청현황</th>
                    <th>사용현황</th>
                    <th>신청률</th>
                    <th>사용률</th>
                </tr>
                </thead>
                <c:set var="total_count" value="0"/>
                <c:set var="total_count2" value="0"/>
                <c:set var="total_count3" value="0"/>
                <c:forEach var="i" varStatus="status" items="${lockerList}">
                    <c:if test="${ !status.first }">
                        <c:set var="total_count" value="${total_count + i.imsi_v1}"/>
                        <c:set var="total_count2" value="${total_count2 + i.imsi_v2}"/>
                        <c:set var="total_count3" value="${total_count3 + i.imsi_v3}"/>
                        <tr>
                            <td>${i.start_date}</td>
                            <td>${i.imsi_v1}</td>
                            <td>${i.imsi_v2}</td>
                            <td>${i.imsi_v3}</td>
                            <td>
                                <c:if test="${i.imsi_v2 == 0}">
                                    0
                                </c:if>
                                <c:if test="${i.imsi_v2 != 0}">
                                    <fmt:formatNumber value="${i.imsi_v2 / i.imsi_v1 * 100}" pattern="0"/>
                                </c:if>
                                %
                            </td>
                            <td>
                                <c:if test="${i.imsi_v3 == 0}">
                                    0
                                </c:if>
                                <c:if test="${i.imsi_v3 != 0}">
                                    <fmt:formatNumber value="${i.imsi_v3 / i.imsi_v1 * 100}" pattern="0"/>
                                </c:if>
                                %
                            </td>
                        </tr>
                    </c:if>

                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td><em>${total_count}</em></td>
                    <td><em>${total_count2}</em></td>
                    <td><em>${total_count2}</em></td>
                    <td>
                        <em>
                            <c:if test="${total_count2 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count2 != 0}">
                                <fmt:formatNumber value="${total_count2 / total_count * 100}" pattern="0"/>
                            </c:if>
                            %
                        </em>
                    </td>
                    <td>
                        <em>
                            <c:if test="${total_count3 == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count3 != 0}">
                                <fmt:formatNumber value="${total_count3 / total_count * 100}" pattern="0"/>
                            </c:if>
                            %
                        </em>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display:none;" id="board">
            <div class="tree-area-title">
                <img alt="" src="/resources/cms/img/main/tag.png">
                <div>영화상영</div>
            </div>
            <table id="accessTableData" class="chartData custom-table">
                <thead>
                <tr>
                    <th width="50%;">기간</th>
                    <th>건수</th>
                    <th>백분율</th>
                </tr>
                </thead>
                <c:forEach var="i" varStatus="status" items="${boardList}">
                    <c:if test="${status.first}">
                        <c:set var="total_count" value="${i.imsi_v1 }"/>
                    </c:if>
                    <c:if test="${!status.first}">
                        <tr>
                            <td>${i.start_date}</td>
                            <td>${i.imsi_v1}</td>
                            <td>
                                <c:if test="${i.imsi_v1 == 0}">
                                    0
                                </c:if>
                                <c:if test="${i.imsi_v1 != 0}">
                                    <fmt:formatNumber value="${i.imsi_v1 / total_count * 100}" pattern="0"/>
                                </c:if>
                                %
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                <tr>
                    <th>합계</th>
                    <td><em>${total_count}</em></td>
                    <td>
                        <em>
                            <c:if test="${total_count == 0}">
                                0
                            </c:if>
                            <c:if test="${total_count != 0}">
                                100
                            </c:if>
                            %
                        </em>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>