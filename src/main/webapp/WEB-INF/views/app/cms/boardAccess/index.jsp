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

        $('select#dateType').change(function (e) {
            var dateType = this.value;
            $('#dateStart').show();
            $('#tilde').show();
            $('#dateEnd').show();
            $('#startMonthBox').show();
            $('#endMonthBox').show();
            $('#startYearBox').hide();
            $('#endYearBox').hide();
            $('#monthBox').hide();

            if (dateType === 'DAY') {
                $('#startYearBox').hide();
                $('#endYearBox').hide();
                $('#monthBox').hide();
            } else if (dateType === 'MONTH') {
                $('#dateStart').hide();
                $('#tilde').hide();
                $('#dateEnd').hide();
                $('#endYearBox').hide();
                $('#startYearBox').show();
                $('#monthBox').show();
            } else if (dateType === 'YEAR') {
                $('#monthBox').hide();
                $('#dateStart').hide();
                $('#tilde').hide();
                $('#dateEnd').hide();
                $('#startYearBox').show();
                $('#endYearBox').show();
            }
        });

        $('select#dateType').trigger('change');

        $('a#excelDownload').on('click', function (e) {
            e.preventDefault();
            if ($('#homepageId').val() == '') {
                alert('홈페이지를 선택해 주세요');
                return false;
            }

            if ($('select#homepage_id')) {
                $('input#homepageName').val($('select#homepage_id option:selected').text());
            } else {
            }

            $('#boardAccess').attr('action', 'excelDownload.do');
            $('#boardAccess').submit();
            $('#boardAccess').attr('action', 'index.do');
        });

        $('a#csvDownload').on('click', function (e) {
            e.preventDefault();
            if ($('#homepageId').val() == '') {
                alert('홈페이지를 선택해 주세요');
                return false;
            }

            if ($('select#homepage_id')) {
                $('input#homepageName').val($('select#homepage_id option:selected').text());
            } else {
            }

            $('#boardAccess').attr('action', 'csvDownload.do');
            $('#boardAccess').submit();
            $('#boardAccess').attr('action', 'index.do');
        });

        $('button#searchBtn').on('click', function (e) {

            if ($('#homepageId').val() == '') {
                alert('홈페이지를 선택해 주세요');
                return false;
            }

            doGetLoad('index.do', $('form#boardAccess').serialize());
        });

    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>게시판 게시글 통</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form modelAttribute="boardAccess" action="index.do" method="post" cssClass="btn-wrapper">
                <form:hidden id="homepageName" path="homepage_name"/>

                <c:choose>
                    <c:when test="${member.admin}">
                        <form:select path="homepage_id" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                            <form:option value="">홈페이지 전체</form:option>
                            <form:options itemLabel="homepage_name" itemValue="homepage_id" items="${homepageList}"/>
                        </form:select>
                    </c:when>
                    <c:otherwise>
                        <form:hidden path="homepage_id" value="${boardAccess.homepage_id}"/>
                    </c:otherwise>
                </c:choose>
                <form:select path="board_type" cssClass="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                    <form:option value="">게시판 유형 전체</form:option>
                    <form:options itemLabel="remark" itemValue="code_name" items="${boardTypes}"/>
                </form:select>
                <form:select id="dateType" path="date_type" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                    <form:option value="DAY">일간별</form:option>
                    <form:option value="MONTH">월간별</form:option>
                    <form:option value="YEAR">연간별</form:option>
                </form:select>
                <div class="btn-wrapper">
                    <form:input type="text" id="dateStart" path="start_date" class="custom-date ui-calendar"/>
                    <p id="yearTilde" class="caption">~</p>
                    <form:input type="text" id="dateEnd" path="end_date" class="custom-date ui-calendar"/>
                </div>
                <div id="startYearBox">
                    <form:select path="start_year" class="custom-date" style="width:80px"></form:select>
                </div>
                <div id="endYearBox" class="btn-wrapper">
                    <p id="yearTilde" class="caption">~</p>
                    <form:select path="end_year" class="custom-date" style="width:80px"></form:select>
                </div>
                <div id="monthBox">
                    <form:select path="start_month" cssClass="custom-select" cssStyle="width:150px;">
                        <form:option value="01">1월 통계</form:option>
                        <form:option value="02">2월 통계</form:option>
                        <form:option value="03">3월통계</form:option>
                        <form:option value="04">4월 통계</form:option>
                        <form:option value="05">5월 통계</form:option>
                        <form:option value="06">6월 통계</form:option>
                        <form:option value="07">7월 통계</form:option>
                        <form:option value="08">8월 통계</form:option>
                        <form:option value="09">9월 통계</form:option>
                        <form:option value="10">10월 통계</form:option>
                        <form:option value="11">11월 통계</form:option>
                        <form:option value="12">11월 통계</form:option>
                    </form:select>
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

        <br>
        <div class="tree-area-title">
            <img alt="" src="/resources/cms/img/main/tag.png">
            <div>게시판 현황</div>
        </div>
        <table id="accessTableData" class="chartData custom-table">
            <thead>
                <tr>
                    <th>홈페이지명</th>
                    <th>게시판 유형</th>
                    <th>글등록수</th>
                    <th>백분율</th>
                </tr>
            </thead>
            <c:forEach var="i" varStatus="status" items="${boardList}">
                <tr>
                    <td>${i.homepage_name}</td>
                    <td>${i.board_name}</td>
                    <td>${i.count}</td>
                    <td>
                        <c:if test="${i.count == 0}">
                            0
                        </c:if>
                        <c:if test="${i.count != 0}">
                            <fmt:formatNumber value="${i.count / total_count * 100}" pattern="0.00"/>
                        </c:if>
                        %
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <th colspan="2">합계</th>
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

