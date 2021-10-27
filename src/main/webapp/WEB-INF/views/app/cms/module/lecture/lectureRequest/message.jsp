<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>

<script>

    $(function() {

        $('.dialog-common').dialog({ //모달창 기본 스크립트 선언
            autoOpen: false,
            resizable: false,
            modal: true,
            open: function(){
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function(){
                $('.ui-widget-overlay').removeClass('custom-overlay');
            },
            buttons: [
                {
                    text: "전송",
                    "class": 'btn btn1',
                    click: function() {

                        if(!confirm("정말 전송하시겠습니까?")) return;

                        jQuery.ajaxSettings.traditional = true;
                        var option = {
                            url : 'sendMessage.do',
                            type : 'POST',
                            data : $('#lectureRequestEdit').serialize(),
                            success: function(response) {
                                if(response.valid) {
                                    alert(response.message);
                                    $('#dialog-3').dialog('destroy');
                                    //열려있는 다이얼로그를 삭제한다.(중복방지)
                                    $('.dialog-common').remove();
                                    location.reload();
                                } else {
                                    if ( response.message != null ) {
                                        alert(response.message);
                                    }
                                    else {
                                        for(var i =0 ; i < response.result.length ; i++) {
                                            alert(response.result[i].code);
                                            $('#'+response.result[i].field).focus();
                                            break;
                                        }
                                    }
                                }
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
                            }
                        };
                        $('#lectureRequestEdit').ajaxSubmit(option);
                    }
                },{
                    text: "취소",
                    "class": 'btn',
                    click: function() {
                        // 작성중인 문자가 있다면 취소전 경고
                        if($('#message_content').val().trim() != "" || $('#phone_number').val().trim() != "") {
                            if(!confirm("정말 취소하시겠습니까?\n작성중인 내용은 사라집니다.")) return;
                        }
                        $(this).dialog('destroy');
                    }
                }
            ]
        });

        $('#dialog-3').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 450
        });

    });

</script>

<style>
    .sms_top {
        width: 100%;
        max-height: 300px;
        overflow-y: auto;
    }
    .sms_bottom {
        width: 100%;
    }
</style>

<form:form modelAttribute="lectureRequest" id="lectureRequestEdit" action="save.do">
    <form:hidden path="homepage_id"/>
    <form:hidden path="editMode"/>
    <div>
        <h3 style="font-size: 13pt">받는 사람</h3>
        <div class="sms_top">
            <table class="type1 center">
                <colgroup>
                    <col width="20%" /> <%--순번--%>
                    <col width="30%" /> <%--이름--%>
                    <col width="50%" /> <%--전화번호--%>
                </colgroup>
                <thead>
                <tr>
                    <th>순번</th>
                    <th>이름</th>
                    <th>전화번호</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="i" varStatus="status" items="${lectureRequestList}">
                    <tr>
                        <td>${i.rownum_forward}</td>
                        <td>${i.request_name}</td>
                        <td>${i.phone_number}</td>
                    </tr>
                </c:forEach>
                <c:if test="${fn:length(lectureRequestList) < 1}">
                    <tr>
                        <td colspan="3">선택된 사람이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <br>
        <div class="sms_bottom">
            <h3 style="font-size: 13pt">보내는 번호</h3>
            <form:input path="phone_number" cssClass="text"/>
            <span style="font-size: 10pt"> ※ 예) 010-1234-5678</span>
            <h3 style="font-size: 13pt">전송 내용</h3>
            <form:textarea path="message_content" cssClass="text" cssStyle="width: 100%;" rows="5"/>
        </div>
    </div>

</form:form>

