<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function () {
        var $form = $('form#menuRating');

        $('button#searchBtn').on('click', function (e) {
            e.preventDefault();
            $('#search-table').load('searchTable.do?' + $form.serialize());
        });

        $('#excelDownload').on('click', function (e) {
            e.preventDefault();
            $('form#menuRatingExcel').attr('action', 'excelDownload.do');
            $('form#menuRatingExcel').attr('method', 'POST');
            $('#homepage_id_excel').val($('#homepage_id').val());
            excelDataSerialize();
            $('form#menuRatingExcel').submit();
        });

        $('#csvDownload').on('click', function (e) {
            e.preventDefault();
            $('form#menuRatingExcel').attr('action', 'csvDownload.do');
            $('form#menuRatingExcel').attr('method', 'POST');
            $('#homepage_id_excel').val($('#homepage_id').val());
            excelDataSerialize();
            $('form#menuRatingExcel').submit();
        });

        var currYear = new Date().getUTCFullYear();
        // 연도 초기화
        for (var i = currYear; i >= 2019; i--) {
            $('select.start_date, select.end_date').append('<option value="' + i + '">' + i + '</option>');
        }

        $('input#start_date_day').datepicker({
            maxDate: $('input#end_date_day').val(),
            onClose: function (selectedDate) {
                $('input#end_date_day').datepicker('option', 'minDate', selectedDate);
            }
        });

        $('input#end_date_day').datepicker({
            minDate: $('input#start_date_day').val(),
            onClose: function (selectedDate) {
                $('input#start_date_day').datepicker('option', 'maxDate', selectedDate);
            }
        });

    });

    function excelDataSerialize() {
// 	var date_type = $('#search_date_type').val();
        var start_date;
        var end_date;
// 	if(date_type == 'DAY') {
        start_date = $('#start_date_day').val();
        end_date = $('#end_date_day').val();

// 	$('#date_type_excel').val(date_type);
        $('#start_date_excel').val(start_date);
        $('#end_date_excel').val(end_date);
    }
</script>

<div class="container-box">
    <div class="page-header">
        <div>메뉴 만족도 통계</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <form:form modelAttribute="menuRating" id="menuRatingExcel" action="excelDownload.do" method="POST">
            <form:hidden path="homepage_id" id="homepage_id_excel"/>
            <form:hidden path="search_date_type" id="date_type_excel"/>
            <form:hidden path="search_start_date" id="start_date_excel"/>
            <form:hidden path="search_end_date" id="end_date_excel"/>
        </form:form>

        <form:form modelAttribute="menuRating" action="index.do" method="GET" onsubmit="return false;" cssStyle="width: 100%">
            <div class="infodesk btn-wrapper">
                <form:select class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;" path="homepage_id">
                    <form:option value="" label="홈페이지를 선택하세요."/>
                    <form:options items="${homepageList}" itemValue="homepage_id" itemLabel="homepage_name"/>
                </form:select>

                <div id="select-date-day" class="btn-wrapper">
                    <form:input path="search_start_date" id="start_date_day" cssClass="start_date custom-date ui-calendar"/>
                    <p id="tilde" class="total-count">~</p>
                    <form:input path="search_end_date" id="end_date_day" cssClass="end_date custom-date ui-calendar"/>
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
            </div>
        </form:form>

        <div id="search-table"></div>
    </div>
</div>