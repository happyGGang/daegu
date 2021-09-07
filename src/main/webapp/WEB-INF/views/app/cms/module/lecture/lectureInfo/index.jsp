<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>

    function search() {
        $('#viewPage').attr('value', 1);
        var formData = serializeCustom($('#lectureInfo'));
        doGetLoad('index.do', formData);
    }

    function editForm(lecture_id, editMode) {
        $('#lecture_id').val(lecture_id);
        $('#editMode').val(editMode);
        var url = 'edit.do';
        var formData = serializeCustom($('#lectureInfo'));
        doGetLoad(url, formData);
    }

    function deleteForm(lecture_id) {
        $('#lecture_id').val(lecture_id);
        $('#lectureInfo').attr('action', 'delete.do');
        if(confirm('강좌를 삭제 하시겠습니까?')) {
            if(confirm('강좌 및 수강생 정보는 복구 할 수 없습니다.\n\n정말로 삭제 하시겠습니까?')) {
                if(doAjaxPost($('#lectureInfo'))){
                    location.reload();
                };
            }
        }
    }

    function link(ord_cd, lecture_id) {
        window.open('/tong/lectureInfo/view.do?menu_idx=18&ord_cd='+ord_cd+'&lecture_id='+lecture_id, '대구평생교육진흥원');
    }

    function excelDownload() {
        $('#lectureInfo').attr('action', 'excel.do');
        $('#lectureInfo').submit();
        $('#lectureInfo').attr('action', 'index.do');
    }

    function excelUploadForm() {
        modal_layer_add('dialog_layer');

        $.ajax({
            url: 'excelUploadForm.do',
            method: 'GET',
            success: function(html){
                $('#dialog_layer').html(html);
            },error: function(html){
            }
        });

        $('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
            resizable: false,
            modal: true,
            title: '오프라인강좌 엑셀등록',
            open: function() {
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function() {
                $('#dialog_layer').remove();
            },
            buttons: [
                {
                    text: "저장",
                    "class": 'btn btn_round btn_save',
                    click: function() {
                        save();
                    }
                },{
                    text: "취소",
                    "class": 'btn btn_round btn_gray',
                    click: function() {
                        $(this).dialog('close');
                    }
                }
            ]
        });

        $("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 700,
            height: 500
        });
    }

    function excelDown() {
        $('#lectureRequestForm').attr('action', 'requestInfoExcel.do');
        $('#lectureRequestForm').submit();
        $('#lectureRequestForm').attr('action', 'requestInfo.do');
    }

    function viewStudent(ord_cd, lecture_id) {
        modal_layer_add('dialog_layer');

        var ajaxData = {
            'ord_cd' : ord_cd,
            'lecture_id' : lecture_id
        };

        $.ajax({
            url: 'viewStudent.do',
            data: ajaxData,
            method: 'GET',
            success: function(html){
                $('#dialog_layer').html(html);
            },error: function(html){
            }
        });

        $('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
            resizable: false,
            modal: true,
            title: '신청자 보기',
            open: function(){
                $('.ui-widget-overlay').addClass('custom-overlay');
            },
            close: function(){
            },
            buttons: [
                {
                    text : '엑셀출력',
                    'class' : 'btn btn_round btn_sky',
                    click : function() {
                        location.href = 'requestInfoExcel.do?ord_cd=' + ord_cd + '&lecture_id=' + lecture_id;
                    }
                },
                {
                    text: "닫기",
                    "class": 'btn btn_round btn_gray',
                    click: function() {
                        $(this).dialog('close');
                    }
                }
            ]
        });

        $("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
            width: 1100,
            height: 800
        });
    }

    $(function() {
        $('input#search_request_start_date').datepicker({
            onClose: function(selectedDate) {
                $('input#search_request_end_date').val(selectedDate);
                $('input#search_request_end_date').datepicker('option', 'minDate', selectedDate);
            }
        });

        $('input#search_request_end_date').datepicker({
            minDate: $('input#search_request_start_date').val()
        });
    });
</script>
<form:form modelAttribute="lectureInfo" action="index.do" method="GET">
    <form:hidden path="editMode"/>
    <form:hidden path="lecture_id"/>
    <div id="content">
        <div class="content_header">
            <h3 class="floatL">강좌관리</h3>
            <div class="btn_wrap">
                <a href="javascript:void(0);" onclick="editForm('', 'ADD');" class="btn btn_round">강좌등록</a>
            </div>
        </div>
        <fieldset>
            <legend><span>강좌관리 폼</span></legend>
            <div class="content">
                <div class="bbs_search">

                    <div class="mgT10">
                        <span class="title">교육장소</span>
                        <form:select path="search.edu_school" title="시설분류">
                            <form:option value="">전체</form:option>
                            <form:options itemLabel="school_name" itemValue="school_name" items="${codeSchoolList}"/>
                        </form:select>

                        <span class="title mgL20">예약상태</span>
                        <form:select path="search.edu_target">
                            <form:option value="">전체</form:option>
                            <form:options itemLabel="code_name" itemValue="code_id" items="${codeEduTargetList}"/>
                        </form:select>

                        <span class="title mgL20">교육분류</span>
                        <form:select path="search.edu_category">
                            <form:option value="">전체</form:option>
                            <form:options itemLabel="code_name" itemValue="code_id" items="${codeEduCategoryList}"/>
                        </form:select>

                        <span class="title mgL20">교육상태</span>
                        <form:select path="search.search_edu_status">
                            <form:option value="">전체</form:option>
                            <form:option value="TYPE_1">교육대기</form:option>
                            <form:option value="TYPE_2">교육중</form:option>
                            <form:option value="TYPE_3">교육마감</form:option>
                        </form:select>

                        <span class="title mgL20">접수방법</span>
                        <form:select path="search.search_request_type">
                            <form:option value="">전체</form:option>
                            <form:option value="TYPE_1">선착순</form:option>
                            <form:option value="TYPE_2">추첨제</form:option>
                        </form:select>
                    </div>
                    <div class="mgT10">
                        <span class="title">접수기간</span>
                        <span class="datepicker">
					<form:input id="search_request_start_date" path="search.request_start_date" class="size150" readonly="readonly" />
					</span>
                        <span> ~ </span>
                        <span class="datepicker">
						<form:input id="search_request_end_date" path="search.request_end_date" class="size150" readonly="readonly" />
					</span>
                        <span class="title mgL20">검색</span>
                        <form:input path="search_text" cssClass="size200" maxlength="100"/>
                        <button type="button" class="btn btn_small btn_search" onclick="search();">검색</button>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="bbs_info">
                    <div class="floatL pdT10">총 <em>${paging.totalDataCount}</em>건 (<em>${paging.viewPage}</em>/ ${paging.totalPageCount}페이지)</div>
                    <div class="floatR">
                        <form:select path="rowCount" onchange="search();">
                            <c:forEach var="i" begin="10" end="50" step="10">
                                <form:option value="${i}">${i}개씩 보기</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>
                <div class="tbl_wrap">
                    <table>
                        <caption><span>강좌관리 목록</span></caption>

                        <colgroup>
                            <col width="4%"/>
                            <col width="*"/>
                            <col width="6%"/>
                            <col width="13%"/>
                            <col width="6%"/>
                            <col width="6%"/>
                            <col width="6%"/>
                            <col width="15%"/>
                            <col width="6%"/>
                            <col width="7%"/>
                            <col width="6%"/>
                        </colgroup>

                        <thead>
                        <tr>
                            <th scope="col" class="alignC">순번</th>
                            <th scope="col" class="alignC">강좌명</th>
                            <th scope="col" class="alignC">접수방법</th>
                            <th scope="col" class="alignC">접수기간/<br>교육기간 </th>
                            <th scope="col" class="alignC">온라인<br>모집인원</th>
                            <th scope="col" class="alignC">오프라인<br>모집인원</th>
                            <th scope="col" class="alignC">대기자<br>모집인원</th>
                            <th scope="col" class="alignC">교육장</th>
                            <th scope="col" class="alignC">강사명</th>
                            <th scope="col" class="alignC">등록일</th>
                            <th scope="col" class="alignC">관리</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i"  varStatus="status" items="${lectureInfoList}">
                            <tr>
                                <td class="alignC">${paging.listRowNum - status.index}</td>
                                <td class="alignC">${i.lecture_title}</td>
                                <td class="alignC">${i.request_type}</td>
                                <td class="alignC">
                                        ${i.request_start_date}~${i.request_end_date}<br>
                                        ${i.edu_start_date}~${i.edu_end_date}
                                </td>
                                <td class="alignC"><em>${i.online_request_count}</em>/${i.online_person_count}명</td>
                                <td class="alignC"><em>${i.offline_request_count}</em>/${i.offline_person_count}명</td>
                                <td class="alignC"><em>${i.wait_request_count}</em>/${i.wait_person_count}명</td>
                                <td class="alignC">
                                        ${i.edu_school}
                                    <c:if test="${!empty i.edu_second_school}"> > ${i.edu_second_school}</c:if>
                                </td>
                                <td class="alignC">${i.teacher_name}</td>
                                <td class="alignC">
                                    <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td class="alignC">
                                    <a href="javascript:void(0);" class="btn btn_gray btn_xsmall" onclick="editForm('${i.lecture_id}', 'MODIFY');">수정</a>
                                    <br>
                                    <a href="javascript:void(0);" class="btn btn_gray btn_xsmall" onclick="deleteForm('${i.lecture_id}');">삭제</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${fn:length(lectureInfoList) < 1}">
                    <div class="no_data">
                        <p>데이터가 존재하지 않습니다.</p>
                    </div>
                </c:if>
                <div>

                    <div class="btn_wrap">

                    </div>
                </div>
            </div>
        </fieldset>
    </div>
</form:form>