<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 통계 -->

<script type="text/javascript">
    $(function () {
        var now = new Date();
        //달력(통계 기간 선택 오류 방지)
        $('input#start_date').datepicker({
            maxDate: $('input#end_date').val(),
            onClose: function (selectedDate) {
                $('input#end_date').datepicker('option', 'minDate', selectedDate);
            }
        }).datepicker('setDate', new Date(now.getUTCFullYear(), (now.getUTCMonth()), 1));
        $('input#end_date').datepicker({
            minDate: $('input#start_date').val(),
            onClose: function (selectedDate) {
                $('input#start_date').datepicker('option', 'maxDate', selectedDate);
            }
        }).datepicker('setDate', new Date(now.getUTCFullYear(), (now.getUTCMonth() + 1), 0));

        $('#searchBtn').on('click', function (e) {
            $('div#resultTableLayer').load('statistics.do', serializeCustom($('#searchForm')));

            e.preventDefault();
        });


        $('select#large_category_idx').on('change', function () {
            if ($(this).val() > 0) {
                $.get('/cms/module/category/getCategoryGroupList.do?homepage_id=' + $('#homepage_id').val() + '&large_category_idx=' + $(this).val(), function (response) {
                    $('select#group_idx option').remove();
                    $('select#group_idx').append('<option value="0">전체</option>');
                    $.each(response, function (i, v) {
                        $('select#group_idx').append('<option value="' + v.group_idx + '">' + v.group_name + '</option>');
                    });
                });
            } else {
                $('select#group_idx option').remove();
                $('select#group_idx').append('<option value="0">전체</option>');
                $('select#category_idx option').remove();
                $('select#category_idx').append('<option value="0">전체</option>');
                // 0일때는 강좌 전체를 가져온다.
                $.get('/cms/module/teach/getTeachList.do?homepage_id=' + $('#homepage_id').val() + '&large_category_idx=' + $('select#large_category_idx').val(), function (response) {
                    $('select#teach_idx option').remove();
                    $('select#teach_idx').append('<option keyValue1="0" keyValue2="0" keyValue3="0" value="0">선택</option>');
                    $.each(response.teachList, function (i, v) {
                        $('select#teach_idx').append('<option keyValue1="' + v.group_idx + '" keyValue2="' + v.category_idx + '" keyValue3="' + v.large_category_idx + '" value="' + v.teach_idx + '">' + v.teach_name + '</option>');
                    });
                });
            }
            $('select#teach_idx option').remove();
            $('select#teach_idx').append('<option keyValue1="0" keyValue2="0" value="0">전체</option>');
        }).trigger('change');


        $('select#group_idx').change(function () {
            $.get('/cms/module/category/getCategoryList.do?homepage_id=' + $('#homepage_id').val() + '&group_idx=' + $(this).val() + '&large_category_idx=' + $('select#large_category_idx').val(), function (response) {
                $('select#category_idx option').remove();
                $('select#category_idx').append('<option value="0" >전체</option>');
                if (response.categoryList.length > 0) {
                    $.each(response.categoryList, function (i, v) {
                        $('select#category_idx').append('<option value="' + v.category_idx + '">' + v.category_name + '</option>');
                    });
                }
            });
        }).trigger('change');

        $('a#excelDownload').on('click', function (e) {
            $('#searchForm').attr('action', 'excelDownload.do').submit();
            $('#searchForm').attr('action', 'index.do')
            e.preventDefault();
        });

        $('a#csvDownload').on('click', function (e) {
            $('#searchForm').attr('action', 'csvDownload.do').submit();
            $('#searchForm').attr('action', 'index.do')
            e.preventDefault();
        });

        $('select#homepage_id').change(function () {
            $('#searchForm').submit();
        });

    });
</script>

<div class="container-box">
    <div class="page-header">
        <div>독서/문화 강좌 통계</div>
    </div>

    <div class="main-content" style="flex-direction: column">
        <div class="search table-action-wrapper">
            <form:form id="searchForm" modelAttribute="teachStatistics" action="index.do" cssClass="btn-wrapper">
                <c:choose>
                    <c:when test="${fn:length(subHomepageList) > 0}">
                        <p class="total-count">도서관</p>
                        <form:select id="homepage_id" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
                    </c:when>
                    <c:otherwise>
                        <form:hidden path="homepage_id"/>
                    </c:otherwise>
                </c:choose>

                <p class="total-count">기간</p>
                <form:input path="start_date" class="custom-date ui-calendar"/>
                <p class="total-count">~</p>
                <form:input path="end_date" class="custom-date ui-calendar"/>
                <p class="total-count">대분류</p>
                <form:select path="large_category_idx" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                <form:option class="all" value="0" label="전체"/>
                <form:options itemValue="teach_code" itemLabel="code_name" items="${teachLargeCategoryList}"/>
            </form:select>
                <p class="total-count">중분류</p>
                <form:select path="group_idx" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;">
                <form:option value="0" label="전체"/>
                <form:options items="${groupList}" itemValue="group_idx" itemLabel="group_name"/>
            </form:select>
                <p class="total-count">소분류</p>
                <form:select path="category_idx" class="custom-select" style="width:200px; padding: 10px 43px 10px 12px;"></form:select>
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

        <div id="resultTableLayer"></div>
    </div>
</div>
