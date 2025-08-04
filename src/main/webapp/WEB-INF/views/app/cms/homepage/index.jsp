<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(function () {
        //모달창 링크 버튼
        $('a#dialog-add').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=ADD', function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a#dialog-modify').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('a#delete').on('click', function (e) {
            if (confirm('해당 홈페이지 설정을 삭제 하시겠습니까?')) {
                $('input#editMode_index').val('DELETE');
                $('input#homepage_id_index').val($(this).attr('keyValue'));
                if (doAjaxPost($('#homepage_index'))) {
                    location.reload();
                }
            }

            e.preventDefault();
        });

        $('a#dialog-modify').on('click', function (e) {
            $('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue'), function (response, status, xhr) {
                $('#dialog-1').dialog('open');
            });

            e.preventDefault();
        });

        $('#rowCount').change(function (e) {
            doGetLoad('index.do', serializeCustom($('#homepage_index')));
        });

        /* $('a#dialog-tempPage').on('click', function(e) {
            $('#dialog-2').load('tempPage.do?homepage_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
                $('#dialog-2').dialog('open');
            });
            e.preventDefault();
        }); */
    });
</script>
<c:set var="getIp" value="<%=request.getRemoteAddr()%>"/>
<form:form id="homepage_index" modelAttribute="homepage" action="save.do" method="post" onsubmit="return false;">
    <form:hidden id="editMode_index" path="editMode"/>
    <form:hidden id="homepage_id_index" path="homepage_id"/>


    <div class="container-box">
        <div class="page-header">
            <div>홈페이지 기본설정</div>
        </div>
        <div class="main-content">
            <div class="table-action-wrapper">
                <div class="center">
                    <p class="total-count">총 ${homepageListCount}건</p>
                <form:select path="rowCount" class="custom-filter" style="width:150px;">
                    <form:option value="10">10개씩 보기</form:option>
                    <form:option value="20">20개씩 보기</form:option>
                    <form:option value="30">30개씩 보기</form:option>
                    <form:option value="${homepageListCount}">전체 보기</form:option>
                </form:select>
                </div>
                <c:if test="${authC}">
                    <a class="icon-btn navy" href="#" id="dialog-add">
                        <img src="/resources/cms/img/main/plus.svg" alt="">
                        <div>홈페이지 추가</div>
                    </a>
                </c:if>
            </div>


            <table class="custom-table">
                <thead>
                <tr>
                    <!-- <th>홈페이지ID</th> -->
                    <th>홈페이지명</th>
                    <!-- 					<th>홈페이지유형</th> -->
                    <th>도메인(domain)</th>
                    <th>컨텍스트</br>(contextPath)</th>
                    <th>폴더</th>
                    <th>검색대<br/>바로가기</th>
                    <th>홈페이지</br>바로가기</th>
                    <!-- 					<th>디지털좌석</br>예약관리시스템</br>바로가기</th> -->
                    <!-- <th>임시페이지사용</th> -->
                    <c:if test="${sessionScope.member.admin}">
                        <th>출력순서</th>
                    </c:if>
                    <th>기능</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${fn:length(homepageList) < 1}">
                    <tr>
                        <td colspan="8">데이터가 존재하지 않습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="i" varStatus="status" items="${homepageList}">
                    <tr>

                        <!--				<td class="num">${i.homepage_id}</td> --->
                        <td>${i.homepage_name}</td>
                        <!-- 					<td> -->
                            <%-- 						<c:forEach items="${homepageTypeList}" var="j"> --%>
                            <%-- 							<c:if test="${j.code_id eq i.homepage_type}"> --%>
                            <%-- 								${j.code_name} --%>
                            <%-- 							</c:if> --%>
                            <%-- 						</c:forEach> --%>
                        <!-- 					</td> -->
                        <td>${i.domain}</td>
                        <td>${i.context_path}</td>
                        <td>${i.folder}</td>
                        <td>
                            <a href="${i.domain}/intro/${i.context_path}/index.do" class="btn" id="site-go" target="_blank">바로가기</a>
                        </td>
                        <td>
                            <c:if test="${i.context_path eq null}">
                                <a href="${i.domain}/index.do" class="btn" id="site-go" target="_blank">바로가기</a>
                            </c:if>
                            <c:if test="${i.context_path ne null}">
                                <a href="${i.domain}/${i.context_path}/index.do" class="btn" id="site-go" target="_blank">바로가기</a>
                            </c:if>
                        </td>
                        <!-- 					<td> -->
                            <%-- 						<c:if test="${i.context_path ne null}"> --%>
                            <%-- 							<a href="http://117.111.136.230/${i.context_path}" class="btn" id="site-go" target="_blank">바로가기</a> --%>
                            <%-- 						</c:if> --%>
                        <!-- 					</td> -->
                            <%-- <td>
                                ${i.temp_use_yn eq 'Y'?'임시페이지사용':'사용안함'}
                            <c:if test="${i.temp_use_yn eq 'Y'}">
                                <br/>
                                (${i.temp_start_date} ~ ${i.temp_end_date})
                            </c:if>
                            </td> --%>
                        <c:if test="${sessionScope.member.admin}">
                            <td>
                                    ${i.print_seq}
                            </td>
                        </c:if>
                        <td>
                            <c:choose>
                                <c:when test="${member.admin}">
                                    <a href="" class="btn" id="dialog-modify" keyValue="${i.homepage_id}">수정</a>
                                    <a href="" class="btn" id="delete" keyValue="${i.homepage_id}">삭제</a>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${authU and asideHomepageId eq i.homepage_id}">
                                        <a href="" class="btn" id="dialog-modify" keyValue="${i.homepage_id}">수정</a>
                                    </c:if>
                                    <c:if test="${authD and asideHomepageId eq i.homepage_id}">
                                        <%-- 							<a href="" class="btn" id="delete" keyValue="${i.homepage_id}">삭제</a> --%>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                                <%-- <a href="" class="btn" id="dialog-tempPage" keyValue="${i.homepage_id}">임시 페이지</a> --%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                <jsp:param name="formId" value="#homepage_index"/>
            </jsp:include>
        </div>
    </div>

</form:form>
<div id="dialog-1" class="dialog-common" title="홈페이지 정보">
</div>
<div id="dialog-2" class="dialog-common" title="임시페이지 예약">
</div>