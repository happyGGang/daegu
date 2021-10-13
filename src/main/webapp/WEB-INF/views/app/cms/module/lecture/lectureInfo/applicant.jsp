<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

    let applicants = ${lectureRequestList};

    //
    function initAppliItems() {
        $('#tbody').empty();

        if(applicants == null || applicants == '') {
            $('#tbody').append(`
            <tr>
                <td colspan="7">등록된 신청이 없습니다.</td>
            </tr>
            `);
            return;
        }

        applicants.forEach(applicant => {
            $('#tbody').append(applicantItem(applicant));
        });
    }

    $(function() {

        initAppliItems();

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
            buttons: [{
                    text: "닫기",
                    "class": 'btn',
                    click: function() {
                        $(this).dialog('destroy');
                    }
                }
            ]
        });

        $('#dialog-4').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 1050
        });

        // 정렬 방식 select 변경
        $('#sortSelect').on('change', function() {
            let selected = $(this).val();

            if(selected == 0) {
                applicants.sort(function(a,b) {
                    if(a.request_name > b.request_name) return 1;
                    if(a.request_name < b.request_name) return -1;
                    if(a.request_name === b.request_name) return 0;
                });
            } else {
                applicants.sort(function(a,b) {
                    if(new Date(a.add_date) > new Date(b.add_date)) return 1;
                    if(new Date(a.add_date) < new Date(b.add_date)) return -1;
                    if(new Date(a.add_date) == new Date(b.add_date)) return 0;
                });
            }

            initAppliItems();
        });

    });

    // 예약 취소 버튼
    function btnCancel(object) {
        if(!confirm("정말 예약을 취소하시겠습니까?")) return;

        let request_id = $(object).data('key');

        var ajaxData = {
            'request_id' : request_id,
            'editMode' : 'DELETE'
        };

        $.ajax({
            url : '../lectureRequest/delete.do',
            type : 'POST',
            data : ajaxData,
            success: function(response) {
                if(response.valid) {
                    alert(response.message);
                    $('#dialog-4').dialog('destroy');
                    //열려있는 다이얼로그를 삭제한다.(중복방지)
                    $('.dialog-common').remove();
                    location.reload();
                } else {
                    if ( response.message != null ) {
                        alert(response.message);
                    } else{
                        alert("관리자에게 문의하세요");
                    }
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
            }
        });
    }

    // 예약 완료 버튼
    function btnCompletion(object) {
        if(!confirm("정말 예약완료 상태로 변경하시겠습니까?")) return;

        let dataArr = $(object).data('key').split(",");
        let request_id = dataArr[0];
        let lecture_id = dataArr[1];

        var ajaxData = {
            'lecture_id' : lecture_id,
            'request_id' : request_id,
            'editMode' : 'UPDATE',
            'request_status' : '예약완료'
        };

        changeStatus(ajaxData);
    }

    // 예약 대기 버튼
    function btnWait(object) {
        if(!confirm("정말 예약대기 상태로 변경하시겠습니까?\n(추첨제는 추첨대기 상태로 변경)")) return;

        let dataArr = $(object).data('key').split(",");
        let request_id = dataArr[0];
        let lecture_id = dataArr[1];

        var ajaxData = {
            'lecture_id' : lecture_id,
            'request_id' : request_id,
            'editMode' : 'UPDATE',
            'request_status' : '예약대기'
        };

        changeStatus(ajaxData);
    }

    // 상태 변화 ajax 전송
    function changeStatus(ajaxData) {
        $.ajax({
            url : '../lectureRequest/changeStatus.do',
            type : 'POST',
            data : ajaxData,
            success: function(response) {
                if(response.valid) {
                    alert(response.message);
                    $('#dialog-4').dialog('destroy');
                    //열려있는 다이얼로그를 삭제한다.(중복방지)
                    $('.dialog-common').remove();
                    location.reload();
                } else {
                    if ( response.message != null ) {
                        alert(response.message);
                    } else{
                        alert("관리자에게 문의하세요");
                    }
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
            }
        });
    }

    // 신청자 정보 row 템플릿
    function applicantItem(obj) {

        let row = `
            <tr>
                <td><a href="#" class="view_btn" data-key="`+obj.request_id+`">`+addId(obj.add_id)+`</a></td>
                <td><a href="#" class="view_btn" data-key="`+obj.request_id+`">`+obj.request_name+`</a></td>
                <td>`+obj.birthday+`(`+genderKr(obj.gender)+`)</td>
                <td>`+obj.phone_number+`<br>`+emailText(obj.email)+`</td>
                <td>`+addDateFormat(obj.add_date)+`</td>
                <td>`+obj.request_status+`</td>
                <td>`+btnItem(obj.request_status, obj.request_type, obj.request_id, obj.lecture_id, obj.info_request_type)+
                   `<a href="#" class="btn cancel_btn" onclick="btnCancel(this)" data-key="`+obj.request_id+`">예약취소</a>
                </td>
            </tr>`

        return row;
    }

    // 예약완료, 예약대기 버튼 템플릿
    function btnItem(request_status, request_type, request_id, lecture_id, info_request_type) {
        if(request_status == '예약대기' && request_type == '온라인' && info_request_type == '선착순') {
            return `<a href="#" class="btn completion_btn" onclick="btnCompletion(this)" data-key="`+request_id+`,`+lecture_id+`">예약완료</a>`;
        } else if (request_status == '예약완료' && request_type == '온라인' && info_request_type == '선착순') {
            return `<a href="#" class="btn wait_btn" onclick="btnWait(this)" data-key="`+request_id+`,`+lecture_id+`">예약대기</a>`
        } else {
            return ``;
        }
    }

    // 성별 한글로 출력
    function genderKr(gender) {
        if(gender == '0')
            return '남';
        return '여';
    }

    // email 있을때, 없을때 표시
    function emailText(email) {
        if(email == null || email == '')
            return '이메일없음';
        return email;
    }

    // 날짜 포멧 변경
    function addDateFormat(add_date) {
        let date = new Date(add_date);

        let year = date.getFullYear();
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let time = date.getHours();
        let min = date.getMinutes();
        let sec = date.getSeconds();

        if (month < 10) month = "0"+month;
        if (day < 10) day = "0"+day;
        if (time < 10) time = "0"+time;
        if (min < 10) min = "0"+min;
        if (sec < 10) sec = "0"+sec;

        return year+"-"+month+"-"+day+"<br>"+time+":"+min+":"+sec;
    }

    // 아이디 변경
    function addId(add_id) {
        if(add_id == null || add_id == '') {
            return '(오프라인신청)';
        }
        return add_id;
    }

</script>

<style>
    #edit-modal {
        height: 80vh;
        overflow-y: auto;
    }
</style>

<div id="edit-modal">
    <span>정렬기준 : </span>
    <select id="sortSelect" name="sortSelect">
        <option value="0">이름</option>
        <option value="1">등록일</option>
    </select>
    <table class="type1 center">
        <colgroup>
            <col width="15%" /> <%--신청자 id--%>
            <col width="15%" /> <%--신청자이름--%>
            <col width="15%" /> <%--생년월일--%>
            <col width="20%" /> <%--휴대전화 / 이메일--%>
            <col width="15%" /> <%--등록일--%>
            <col width=10%" /> <%--예약상태--%>
            <col width="" /> <%--관리--%>
        </colgroup>
        <thead>
        <tr>
            <th>신청자ID</th>
            <th>신청자이름</th>
            <th>생년월일(성별)</th>
            <th>휴대전화 /<br> 이메일</th>
            <th>등록일</th>
            <th>예약상태</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody id="tbody">
        </tbody>
    </table>
</div>

