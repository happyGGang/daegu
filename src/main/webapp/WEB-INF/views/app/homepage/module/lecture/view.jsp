<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>

<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">

    /**
     * 수강신청 버튼 클릭
     * */
    function lectureRequest(lecture_id) {
        $('#dialog-1').load('edit.do?editMode=ADD&lecture_id='+lecture_id+'&request_type=온라인', function( response, status, xhr ) {
            $('#dialog-1').dialog('open');
        });
    }

    function goIndex() {
        $('#lectureInfo').attr('action', 'index.do');
        $('#lectureInfo').submit();
    }

    $(function() {
        // 수강신청 버튼 클릭
        $('.btn_apply_lecture').on('click', function(e) {
            e.preventDefault();
            let lecture_id = $(this).data('key');

            $('#dialog-1').load('edit.do?editMode=ADD&lecture_id='+lecture_id+'&request_type=온라인', function( response, status, xhr ) {
                $('#dialog-1').dialog('open');
            });
        });
    });

</script>

<style>
    .tit {
        display: inline-block;
        margin-right: 20px;
    }

    .cotnt {
        display: inline-block;
    }

    .btn-inline {
        display: inline-block;
    }

    .lecture_tit {
        color: #2e9901;
    }

    .lecture_tit:hover {
        color: #0d75c4;
    }
</style>
<form:form modelAttribute="lectureInfo" method="GET" action="index.do">
    <input type="hidden" name="menu_idx" value="${param.menu_idx}" />
    <form:hidden path="viewPage"/>
    <form:hidden path="lecture_id"/>
    <form:hidden path="edu_school"/>
    <form:hidden path="searching_edu_status"/>
    <form:hidden path="searching_request_type"/>
    <form:hidden path="request_start_date"/>
    <form:hidden path="request_end_date"/>
    <form:hidden path="search_text"/>
    <form:hidden path="request_type" value="온라인"/>
</form:form>
<h1 style="font-size: 20pt">강좌정보</h1>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div id="apply">
    <!-- 강좌정보 -->
    <div class="lec_list dis_table col2">
        <ul class="one">
            <li class="table">
                <p class="tit">강좌명</p>
                <p class="suj cotnt">${lectureInfo.lecture_title}</p>
            </li>
        </ul>
        <ul>
            <li class="table">
                <p class="cell th tit">교육기간</p>
                <div class="cell td cotnt">
                    <span class="les_no">${lectureInfo.edu_start_date} ~ ${lectureInfo.edu_end_date}</span>
                </div>
            </li>
            <li class="table">
                <p class="cell th tit">교육시간</p>
                <div class="cell td cotnt">
                    <span class="les_no">${lectureInfo.edu_start_time} ~ ${lectureInfo.edu_end_time}</span>
                </div>
            </li>
        </ul>
        <ul>
            <li class="table">
                <p class="cell th tit">접수기간</p>
                <div class="cell td cotnt">
                    <span class="les_no cotnt">${lectureInfo.request_start_date} ~ ${lectureInfo.request_end_date}</span>
                </div>
            </li>
        </ul>
        <ul>
            <li class="table">
                <p class="cell th tit">접수방식</p>
                <div class="cell td cotnt">
                    ${lectureInfo.request_type}
                </div>
            </li>
            <li class="table">
                <p class="cell th tit">모집인원</p>
                <div class="cell td cotnt">
                    <c:if test="${lectureInfo.request_type eq '선착순'}">
                        <label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.online_request_count + lectureInfo.offline_request_count}</strong>/
                    </c:if>
                    <label class="hidden">정원</label>${lectureInfo.online_person_count + lectureInfo.offline_person_count}</span>
                </div>
            </li>
        </ul>
        <ul>
            <li class="table">
                <p class="cell th tit">접수현황</p>
                <div class="cell td cotnt">
                    <c:choose>
                        <c:when test="${lectureInfo.request_type eq '선착순'}">
                            온라인 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.online_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.online_person_count})</span>,
                            오프라인 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.offline_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.offline_person_count})</span>,
                            대기 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.wait_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.wait_person_count})</span>
                        </c:when>
                        <c:when test="${lectureInfo.request_type eq '추첨제'}">
                            추첨대기 <span class="les_no">(<label class="hidden">현원</label><strong class="txt_color4">${lectureInfo.wait_request_count}</strong>/<label class="hidden">정원</label>${lectureInfo.wait_person_count})</span>
                        </c:when>
                    </c:choose>
                </div>
            </li>
            <li class="table">
                <p class="cell th tit">교육장소</p>
                <div class="cell td cotnt">
                    <span class="txt_color1">${lectureInfo.edu_school}</span>
                    <c:if test="${!empty lectureInfo.edu_second_school}">
                        <span class="st2">${lectureInfo.edu_second_school}</span>
                    </c:if>
                    <c:if test="${!empty lectureInfo.edu_school_map}">
                        <a href="${lectureInfo.edu_school_map}" class="map app_btn small new_win" target="_blank" title="새창열림">위치</a>
                    </c:if>
                </div>
            </li>
        </ul>
        <ul>
            <li class="table">
                <p class="cell th tit">강사명</p>
                <div class="cell td cotnt">
                    ${lectureInfo.teacher_name}
                    <c:if test="${!empty lectureInfo.teacher_tel}">
                        <span class="les_no">(${lectureInfo.teacher_tel})</span>
                    </c:if>
                </div>
            </li>
            <li class="table">
                <p class="cell th tit">담당자</p>
                <div class="cell td cotnt">
                    ${lectureInfo.supporter_name}
                    <c:if test="${!empty lectureInfo.supporter_tel}">
                        <span class="les_no">(${lectureInfo.supporter_tel})</span>
                    </c:if>
                </div>
            </li>
        </ul>
    </div>
    <!--// 강좌정보 -->

    <div class="bott_box">
        <p class="tit">강좌상태</p>
        <p class="state_list cotnt">
            <c:choose>
                <c:when test="${lectureInfo.lecture_status1 eq '모집예정'}">
                    <span class="lec_state state1">모집예정</span>
                </c:when>
                <c:when test="${lectureInfo.lecture_status1 eq '정원마감'}">
                    <span class="lec_state state1">정원마감</span>
                </c:when>
                <c:when test="${lectureInfo.lecture_status1 eq '모집중'}">
                    <c:if test="${lectureInfo.online_person_count <= lectureInfo.online_request_count and lectureInfo.wait_person_count <= lectureInfo.wait_request_count}">
                        <span class="lec_state state3 tit">온라인신청정원초과</span>
                    </c:if>
                    <c:if test="${lectureInfo.online_person_count > lectureInfo.online_request_count or lectureInfo.wait_person_count > lectureInfo.wait_request_count}">
                        <span class="lec_state state3 tit">모집중</span>
                    </c:if>
                </c:when>
                <c:when test="${lectureInfo.lecture_status1 eq '모집마감'}">
                    <span class="lec_state state4">모집마감</span>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${lectureInfo.lecture_status2 eq '교육중'}">
                    <span class="lec_state state3">교육중</span>
                </c:when>
                <c:when test="${lectureInfo.lecture_status2 eq '교육마감'}">
                    <span class="lec_state state5">교육마감</span>
                </c:when>
            </c:choose>
        </p>
        <c:if test="${lectureInfo.lecture_status1 eq '모집중'}">
            <c:if test="${lectureInfo.online_person_count <= lectureInfo.online_request_count and lectureInfo.wait_person_count <= lectureInfo.wait_request_count}">
            </c:if>
            <c:if test="${lectureInfo.online_person_count > lectureInfo.online_request_count or lectureInfo.wait_person_count > lectureInfo.wait_request_count}">
                <c:if test="${empty lectureRequest}">
                    <div class="search btn-inline" style="display: inline-block; margin: 0; padding: 0;">
                        <fieldset style="display: inline-block; margin: 0; padding: 0;">
                            <button class="app_btn app_color3 check btn-inline btn_apply_lecture" type="button" data-key="${lectureInfo.lecture_id}" style="margin:0;">수강신청</button>
                        </fieldset>
                    </div>
                </c:if>
            </c:if>
        </c:if>
    </div>

    <br>
    <h4 class="caption">교육내용</h4>
    <!-- 강좌정보 -->
    <div class="tbl_wrap tbl_view">
        <table class="tbl_basic tbl_all_td_left tbl_all_th_left">
            <caption><span>교육내용을 교육소개 및 강의내용, 첨부파일로 나타낸 표</span></caption>
            <colgroup>
                <col style="width:20%;">
                <col style="">
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">교육소개 및 강의내용</th>
                <td>
                    <div class="int_box textarea">${fn:replace(lectureInfo.lecture_content, crlf, '<br/>')}</div>
                </td>
            </tr>
            <c:if test="${!empty file}">
                <tr>
                    <th scope="row">첨부파일</th>
                    <td>
                        <div class="int_box file">
                            <span class="block"><a href="/${homepage.context_path}/module/lecture/download/${file.homepage_id}/${file.file_server_name}.do" class="ico_file" title="다운로드">${file.file_original_name}</a></span>
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <div class="bott_btn_box">
        <a href="javascript:history.back();">뒤로가기</a>
    </div>

</div><!-- apply End -->

<div id="dialog-1" class="dialog-common" title="수강신청"></div>