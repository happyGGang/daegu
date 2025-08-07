<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function () {
        $('#dialog-3').dialog({ //모달창 기본 스크립트 선언
            autoOpen: false,
            resizable: false,
            modal: true,
            open: function () {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function () {
                $('.ui-widget-overlay').removeClass('custom-overlay');
                $('body > div.ui-dialog').remove();
            },
            buttons: [
                {
                    text: "닫기",
                    "class": 'btn',
                    click: function () {
                        $(this).dialog('destroy');
                    }
                }
            ]
        });

        $("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 800,
            height: 700
        });

        $('input#search_start_date').datepicker({
            maxDate: $('input#search_end_date').val(),
            onClose: function (selectedDate) {
                $('input#search_end_date').datepicker('option', 'minDate', selectedDate);
            }
        });

        $('input#search_end_date').datepicker({
            minDate: $('input#search_start_date').val(),
            onClose: function (selectedDate) {
                $('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
            }
        });

        $('a.search-btn').on('click', function (e) {
            e.preventDefault();
            $('#dialog-3').load('getTeachCertificateListByDate.do?' + serializeCustom($('#certStudentSearchForm')));
        });

        $('button.sort').on('click', function () {
            $('button.sort').removeClass('btn1');
            $(this).addClass('btn1');
            var key = $(this).attr('keyValue');
            if (key == 0) {
                $('table#certificateTable tr.sort').show();
            } else {
                $('table#certificateTable tr.sort').hide();
                $('table#certificateTable tr.certificate_' + key).show();
            }
        });

    });
</script>
<form:form action="getTeachCertificateListByDate.do" id="certStudentSearchForm" modelAttribute="student"
           onsubmit="return false;">
    <form:hidden path="editMode" value="SEARCH"/>
    <form:hidden path="homepage_id"/>
    <div class="infodesk">
        <div>
            <button class="btn btn1 sort" keyValue="0">전체</button>
            <button class="btn sort" keyValue="1">수료</button>
            <button class="btn sort" keyValue="2">미수료</button>
        </div>
        조회 기간 :
        <form:input class="text ui-calendar" path="search_start_date"/>
        ~
        <form:input class="text ui-calendar" path="search_end_date"/>
        <a class="btn btn1 search-btn">조회</a>
    </div>
    <table class="type1 center" id="certificateTable">
        <colgroup>
            <col width="50"/>
            <col width="100"/>
            <col width="100"/>
            <col width="100"/>
            <col width="100"/>
            <col width=""/>
        </colgroup>
        <thead>
        <tr>
            <th>순번</th>
            <th>수료여부</th>
            <th>수강생명</th>
            <th>생년월일</th>
            <%--
            <th>나이</th>
            --%>
            <th>주소</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${fn:length(certStudentList) > 0}">
                <c:forEach items="${certStudentList}" var="i" varStatus="status">
                    <tr class="sort certificate_${i.student_status}">
                        <td>${status.count}</td>
                        <td>${i.student_status eq 1 ? '수료' : '미수료'}</td>
                        <td>${i.student_name}</td>
                        <td>${i.student_birth}</td>
                        <%--
                        <td>${i.student_old}</td>
                        --%>
                        <td class="left">${i.student_address} ${i.student_address_detail != null and
                            i.student_address_detail != 'null' ? i.student_address_detail : ''}
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6">조회된 수료자가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>

        </tbody>
    </table>
</form:form>