<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
    $(function () {
        $('a#delete').on('click', function (e) {
            if (confirm('해당 사용자(' + $(this).attr('keyValue') + ')를 정보를 삭제 하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#member_id_index').val($(this).attr('keyValue'));
                if (doAjaxPost($('#member_index'))) {
                    location.reload();
                }
            }

            e.preventDefault();
        });

        $('button#homepage_btn').on('click', function (e) {
            $('.dialog-common').remove();
            $('#boardManageLayer').load('boardManage.do?editMode=MODIFY&homepage_id=' + $(this).val());
            e.preventDefault();
        });

        $('#boardManageLayer').load('boardManage.do?editMode=FIRST');
    });
</script>
<div class="container-box">
    <div class="page-header">
        <div>게시판 관리</div>
    </div>
    <div class="main-content" style="flex-direction: column">
        <div class="table-action-wrapper">
            <p class="total-count">총 ${fn:length(homepageList)}건</p>
        </div>

        <div class="table-wrap">
            <div class="table-scroll">
                <table class="custom-table">
                    <thead>
                    <tr>
                        <th>홈페이지ID</th>
                        <th>홈페이지명</th>
                        <th>선택</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="i" varStatus="status" items="${homepageList}">
                        <tr>
                            <td>${i.homepage_id}</td>
                            <td>${i.homepage_name}</td>
                            <td>
                                <button class="custom-btn" id="homepage_btn" value="${i.homepage_id}">선택</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${fn:length(homepageList) < 1}">
                        <tr style="height:100%">
                            <td style="background:#f8fafb">관리가 가능한 게시판 목록이 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="boardManageLayer" class="areaR" style="width:75%;"></div>