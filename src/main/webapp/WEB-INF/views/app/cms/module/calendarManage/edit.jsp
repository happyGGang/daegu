<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    $(function () {
        $('#dialog-1').dialog({ //모달창 기본 스크립트 선언
            autoOpen: false,
            resizable: false,
            modal: true,
            open: function () {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function () {
                $('.ui-widget-overlay').removeClass('custom-overlay');
            },
            buttons: [
                {
                    text: "저장",
                    "class": 'icon-btn navy',
                    click: function () {
                        if (doAjaxPost($('#calendarManage_edit'))) {
                            $(this).dialog('destroy');
                            location.reload();
                        }
                    }
                }, {
                    text: "취소",
                    "class": 'icon-btn custom-btn',
                    click: function () {
                        $(this).dialog('destroy');
                    }
                }, {
                    text: "삭제",
                    "class": 'btn btn1',
                    "id": 'del_btn',
                    click: function () {
                        if (confirm("정말 삭제 하시겠습니까?")) {
                            $('input#editMode').val('DELETE');
                            if (doAjaxPost($('#calendarManage_edit'))) {
                                $(this).dialog('destroy');
                                location.reload();
                            }
                        }
                    }
                }
            ]
        });

        if ($('input#editMode').val() == 'ADD') {
            $('input#weekdayArr1').prop('checked', true);
            $('#del_btn').hide();
        } else {
            var oneStartDate = '${calendarManage.start_date}';
            var oneStartTime = '${calendarManage.start_time}';
            var oneEndDate = '${calendarManage.end_date}';
            var oneEndTime = '${calendarManage.end_time}';
            var twoStartDate = '${calendarManage2.start_date}';
            var twoStartTime = '${calendarManage2.start_time}';
            var twoEndDate = '${calendarManage2.end_date}';
            var twoEndTime = '${calendarManage2.end_time}';

            $('input#start_date').val(twoStartDate);
            $('input#start_time').val(twoStartTime);
            $('input#end_date').val(twoEndDate);
            $('input#end_time').val(twoEndTime);

            $('#del_btn').show();
        }

        $('input[name=individual_yn]').on('click', function () {
            var val = $(this).val();

            if (val == 'Y') {
                $('input#start_date').val(oneStartDate);
                $('input#start_time').val(oneStartTime);
                $('input#end_date').val(oneEndDate);
                $('input#end_time').val(oneEndTime);
            } else {
                $('input#start_date').val(twoStartDate);
                $('input#start_time').val(twoStartTime);
                $('input#end_date').val(twoEndDate);
                $('input#end_time').val(twoEndTime);
            }


        });


        $("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 660,
            height: 650
        });

        $('input#start_date').datepicker({
            maxDate: $('input#end_date').val(),
            onClose: function (selectedDate) {
                $('input#end_date').datepicker('option', 'minDate', selectedDate);
            }
        });

        $('input#end_date').datepicker({
            minDate: $('input#start_date').val(),
            onClose: function (selectedDate) {
                $('input#start_date').datepicker('option', 'maxDate', selectedDate);
            }
        });

        $('input[name=weekdayArr]').on('click', function () {

            var idx = $('input[name=weekdayArr]').index($(this));

            if (idx == 0) {
                if ($(this).is(':checked')) {
                    $('input[name=weekdayArr]').slice(1).prop('checked', false);
                    $('input[name=weekdayArr]').slice(1).prop('disabled', true);
                } else {
                    $('input[name=weekdayArr]').slice(1).prop('checked', false);
                    $('input[name=weekdayArr]').slice(1).prop('disabled', false);
                }
            } else {
                var checkedLength = $('input[name=weekdayArr]:not(#weekdayArr1):checked').length;
                if ($(this).is(':checked')) {

                    if (checkedLength == 7) {
                        $('input[name=weekdayArr]').eq(0).prop('checked', true);
                        $('input[name=weekdayArr]').eq(0).prop('disabled', false);
                        $('input[name=weekdayArr]').slice(1).prop('checked', false);
                        $('input[name=weekdayArr]').slice(1).prop('disabled', true);
                    } else if (checkedLength > 0) {
                        $('input[name=weekdayArr]').eq(0).prop('checked', false);
                        $('input[name=weekdayArr]').eq(0).prop('disabled', true);
                    } else {
                        $('input[name=weekdayArr]').eq(0).prop('checked', false);
                        $('input[name=weekdayArr]').eq(0).prop('disabled', false);
                    }

                } else {
                    if (checkedLength > 0) {
                        $('input[name=weekdayArr]').eq(0).prop('checked', false);
                        $('input[name=weekdayArr]').eq(0).prop('disabled', true);
                    } else {
                        $('input[name=weekdayArr]').eq(0).prop('checked', false);
                        $('input[name=weekdayArr]').eq(0).prop('disabled', false);
                    }
                }
            }
        });


    });
</script>
<form:form action="save.do" id="calendarManage_edit" method="post" modelAttribute="calendarManage"
           onsubmit="return false;">
    <form:hidden path="editMode"/>
    <form:hidden path="plan_date" value="${fn:substring(calendarManage.start_date,0,7)}"/>
    <form:hidden path="homepage_id"/>
    <form:hidden path="cm_idx"/>
    <form:hidden path="group_idx"/>
    <table class="popup-table">
        <tbody>
        <tr>
            <th>일정종류</th>
            <td class="txt-left">
                <form:select class="custom-select" path="date_type">
                    <form:options itemLabel="code_name" itemValue="code_id" items="${dateTypeList}"/>
                </form:select>
            </td>
        </tr>
        <c:if test="${calendarManage.editMode ne 'ADD'}">
            <tr>
                <th>선택일자</th>
                <td>
                    ${calendarManage.start_date}
                </td>
            </tr>
        </c:if>
        <tr>
            <th>제목</th>
            <td class="txt-left">
                <form:input cssClass="text custom-input" cssStyle="width:320px;" maxlength="50" path="title"/>
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td class="txt-left">
                <form:textarea cssClass="text custom-textarea" cssStyle="width:90%;height:100px;" maxlength="100"
                               path="contents"/>
            </td>
        </tr>
        <tr>
            <th>링크URL</th>
            <td class="txt-left">
                <form:input cssClass="text custom-input" cssStyle="width:90%; margin-bottom: 8px;" maxlength="500"
                            path="link_url"/>
                <div class="ui-state-highlight guide-line">
                    <em>링크URL 입력시 상세보기로 이동하지 않고 해당 링크로 이동합니다.</em>
                    <em>해당페이지의 전체 URL을 입력해주세요.</em>
                </div>
            </td>
        </tr>
        <tr>
            <th>일정일자</th>
            <td class="txt-left">
                <div class="btn-wrapper">
                    <form:input class="text ui-calendar custom-date" id="start_date" path="start_date" type="text"/>
                    <form:input cssClass="text custom-search" cssStyle="width:50px; height: 36px;" maxlength="5"
                                path="start_time"/>
                    <span id="tilde" style="font-size:12px">~</span>
                    <form:input class="text ui-calendar custom-date" id="end_date" path="end_date" type="text"/>
                    <form:input cssClass="text custom-search" cssStyle="width:50px; height: 36px;" maxlength="5"
                                path="end_time"/>
                </div>
                <div class="ui-state-highlight" id="weekDayDiv" style="margin: 10px 0;">
                    매주 &nbsp;&nbsp;
                    <form:checkboxes cssStyle="margin: 0 5px; vertical-align: -2px;" itemLabel="code_name" itemValue="code_id" items="${weekdayList}"  path="weekdayArr"/>
                </div>
                <div class="ui-state-highlight guide-line">
                    <em>시간 입력 ex) 10:30</em>
                </div>
            </td>
        </tr>
        <c:if test="${calendarManage.group_count > 1}">
            <tr>
                <th>일괄수정</th>
                <td>
                    <form:radiobutton label="전체 반복일정 수정" path="individual_yn" value="N"/>&nbsp;
                    <form:radiobutton label="선택한 일정만 수정" path="individual_yn" value="Y"/>
                    <c:if test="${calendarManage.individual_yn ne 'Y'}">
                        <form:radiobutton label="개별수정된 일정 제외 전체수정" path="individual_yn" value="E"/>
                        <div class="ui-state-highlight">
                            <em>* 개별수정된 일정 제외 전체수정 : 개별로 수정된 일정을 제외한 나머지 반복일정을 수정합니다.</em>
                        </div>
                    </c:if>
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</form:form>