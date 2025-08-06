<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        //모달창 링크 버튼
        $('a#dialog-add').on('click', function (e) {
            if ($('#homepage_id_1').val() == '') {
                alert('홈페이지정보가 없습니다.');
            } else {
                $('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${popupZone.homepage_id}', function (response, status, xhr) {
                    $('#dialog-1').dialog('open');
                });
            }

            e.preventDefault();
        });

        $('a#dialog-modify').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${popupZone.homepage_id}&popup_zone_idx=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a#delete').on('click', function (e) {
            if (confirm('선택된 팝업존을 삭제 하시겠습니까?')) {
                var ajaxData = {
                    'popup_zone_idx': $(this).attr('keyValue'),
                    'homepage_id': $('#homepage_id_1').val()
                };

                $.ajax({
                    url: 'delete.do',
                    async: false,
                    data: ajaxData,
                    method: 'POST',
                    success: function (data) {
                        if (data.valid) {
                            alert(data.message);
                            location.reload();
                        }
                    }
                });
            }

            e.preventDefault();
        });

        $('select#homepage_id_1').on('change', function (e) {
            if ($(this).val() != '') {
                $('input#homepage_id_1').val($(this).val());
                doGetLoad('index.do', serializeCustom($('#popup_zone_1')));
            }

            e.preventDefault();
        });

        $('button#search_btn').on('click', function (e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', serializeCustom($('#popup_zone_1')));
        });

        $('select#use_yn, select#rowCount').on('change', function (e) {
            $('#viewPage').val(1);
            doGetLoad('index.do', serializeCustom($('#popup_zone_1')));
        });

        $('a.mod_print').on('click', function (e) {
            e.preventDefault();
            $('input#popup_zone_idx_print').val($(this).data('idx'));
            $('input#print_seq_print').val($(this).data('printseq'));
            doAjaxPost($('form#popup_zone_print_seq'));
        });
    });

    function savePrintSeq(popup_zone_idx, print_seq, index, homepage_id) {

        var ajaxData = {
            'popup_zone_idx': popup_zone_idx,
            'print_seq': $('input#print_seq' + index).val(),
            'homepage_id': $('#homepage_id_1').val()
        };

        $.ajax({
            type: "POST",
            url: 'printSeq.do',
            data: ajaxData,
            success: function (response) {
                alert('수정 되었습니다.');
                location.reload();
            },
            error: function () {
                alert('수정에 실패했습니다.\n\n관리자에게 문의해 주세요.');
            }
        });
    }
</script>
<div class="container-box">
    <form:form id="popup_zone_print_seq" modelAttribute="popupZone" method="POST" action="printSeq.do">
        <form:hidden path="homepage_id" id="homepage_id_print" value="${homepage.homepage_id}"/>
        <form:hidden path="popup_zone_idx" id="popup_zone_idx_print"/>
        <form:hidden path="print_seq" id="print_seq_print"/>
    </form:form>

    <form:form id="popup_zone_1" modelAttribute="popupZone" method="POST" action="save.do" onsubmit="return false;">
        <form:hidden id="editMode_1" path="editMode"/>
        <form:hidden id="popup_zone_idx_1" path="popup_zone_idx"/>
        <form:hidden id="homepage_id_1" path="homepage_id"/>
        <div id="editDisable" class="disableBox">
            <div class="page-header">
                <div>팝업존 관리</div>
            </div>

            <div class="main-content" style="flex-direction: column">
                <c:if test="${popupZone.editMode eq 'FIRST'}">
                    <div class="mask"></div>
                </c:if>

                <div class="table-action-wrapper">
                    <div class="center">
                        <p class="total-count">총 ${paging.totalDataCount}건, 홈페이지 ID : ${popupZone.homepage_id}</p>
                        <div class="btn-wrapper">
                            <form:select path="use_yn" class="custom-filter">
                                <option value="">사용여부선택</option>
                                <form:option value="Y">사용함</form:option>
                                <form:option value="N">사용안함</form:option>
                            </form:select>
                            <form:select path="rowCount" class="selectmenu" style="width:120px;">
                                <form:option value="10">10개씩 보기</form:option>
                                <form:option value="20">20개씩 보기</form:option>
                                <form:option value="30">30개씩 보기</form:option>
                                <form:option value="100">100개씩 보기</form:option>
                                <form:option value="200">200개씩 보기</form:option>
                            </form:select>
                        </div>
                    </div>

                    <c:if test="${authC}">
                        <a href="" class="icon-btn nav" id="dialog-add"><i class="fa fa-plus"></i><span>팝업존등록</span></a>
                    </c:if>
                </div>
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th>순번</th>
                            <th></th>
                            <th>팝업존명</th>
                            <th>사용여부</th>
                            <th>게시기간</th>
                            <th>출력순서</th>
                            <th>등록일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${fn:length(popupZoneList) < 1}">
                        <tr>
                            <td colspan="8">데이터가 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="i" varStatus="status" items="${popupZoneList}">
                        <tr>
                            <td>${popupZone.listRowNum - status.index}</td>
                            <td>
                                <div class="item">
                                    <a href="${i.link_url}" target="_blank">
                                        <c:if test="${i.org_file_name eq null}">
                                            <img src="/resources/cms/img/noimg_135_42.gif" alt="이미지 미리보기 입니다.">
                                        </c:if>
                                        <c:if test="${i.org_file_name ne null}">
                                            <img width="45%" height="80px"
                                                 src="${getContextPath}/data/popupZone/${i.homepage_id}/${i.server_file_name}"
                                                 alt="${i.server_file_name}">
                                        </c:if>
                                    </a>
                                </div>
                            </td>
                            <td>${i.popup_zone_name}</td>
                            <td>${i.use_yn eq 'Y' ? '사용함' : '사용안함'}</td>
                            <td>${i.start_date} ~ ${i.end_date}</td>
                            <td>
                                <div class="btn-wrapper" style="justify-content: center">
                                    <a href="#" class="custom-btn mod_print" data-idx="${i.popup_zone_idx}"
                                       data-printseq="${i.print_seq - 1}">↑</a>
                                    <form:input cssClass="custom-input" path="print_seq" id="print_seq${status.index}" value="${i.print_seq}" cssStyle="width: 10%" />
                                    <a href="#" class="custom-btn mod_print" data-idx="${i.popup_zone_idx}"
                                       data-printseq="${i.print_seq + 1}">↓</a>
                                    <a href="javascript:void(0);" class="custom-btn sky" onclick="savePrintSeq('${i.popup_zone_idx}','${i.print_seq}','${status.index}', '${homepage.homepage_id}');">저장</a>
                                </div>
                            </td>
                            <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                            <td>
                                <c:if test="${authU}">
                                    <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.popup_zone_idx}">수정</a>
                                </c:if>
                                <c:if test="${authD}">
                                    <a href="" class="custom-btn" id="delete" keyValue="${i.popup_zone_idx}">삭제</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                    <jsp:param name="formId" value="#popup_zone_1"/>
                </jsp:include>

                <div class="table-search-bar">
                    <fieldset class="search-bar">
                        <form:select path="search_type" cssClass="custom-filter">
                            <form:option value="popup_zone_name">팝업존명</form:option>
                        </form:select>
                        <form:input path="search_text" cssClass="custom-search"/>
                        <div id="search_btn" class="icon-btn black">
                            <img alt="" src="/resources/cms/img/main/search.svg">
                            <div>검색</div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </form:form>
</div>

<div id="dialog-1" class="dialog-common" title="팝업존 정보">
</div>