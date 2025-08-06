<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}

		e.preventDefault();
	});

	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue') + '&popup_idx=' + $(this).attr('keyValue1'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a#delete').on('click', function(e) {
		if(confirm('선택된 팝업을 삭제 하시겠습니까?')) {
			$('input#homepage_id_1').val($(this).attr('keyValue'));
			$('input#popup_idx_1').val($(this).attr('keyValue1'));

			$.ajax({
				url : 'delete.do',
				async : false,
				data : serializeObject($('#popup_1')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
					else {
						if ( data.message != null ) {
							alert(data.message);
						}
						else {
							alert(data.result);
						}
					}
				}
			});
		}

		e.preventDefault();
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#popup_1').attr('action', 'index.do');
			doGetLoad('index.do', serializeCustom($('#popup_1')));
		}

		e.preventDefault();
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#popup_1')));
	});

	$('select#link_target, select#use_yn, select#sortType, select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#popup_1')));
	});

});
</script>
<div class="container-box">
    <form:form id="popup_1" modelAttribute="popup" method="POST" action="save.do" onsubmit="return false;">
    <form:hidden id="editMode_1" path="editMode"/>
    <form:hidden id="popup_idx_1" path="popup_idx"/>
    <form:hidden id="homepage_id_1" path="homepage_id"/>

        <div id="editDisable" class="disableBox">
            <div class="page-header">
                <div>모듈관리</div>
            </div>
            <div class="main-content" style="flex-direction: column">
                <div class="table-action-wrapper">
                    <c:if test="${popup.editMode eq 'FIRST'}">
                        <div class="mask"></div>
                    </c:if>
                    <div class="center">
                        <p class="total-count">총 ${paging.totalDataCount}건, 홈페이지 ID : ${popup.homepage_id}</p>

                        <div class="btn-wrapper">
                            <form:select path="link_target" class="custom-filter">
                                <option value="">링크타겟선택</option>
                                <form:option value="CURRENT">현재창</form:option>
                                <form:option value="BLANK">새창</form:option>
                            </form:select>
                            <form:select path="use_yn" class="custom-filter">
                                <option value="">사용여부선택</option>
                                <form:option value="Y">사용함</form:option>
                                <form:option value="N">사용안함</form:option>
                            </form:select>
                            <form:select path="rowCount" class="custom-filter" style="width:120px;">
                                <form:option value="10">10개씩 보기</form:option>
                                <form:option value="20">20개씩 보기</form:option>
                                <form:option value="30">30개씩 보기</form:option>
                                <form:option value="100">100개씩 보기</form:option>
                                <form:option value="200">200개씩 보기</form:option>
                            </form:select>
                        </div>
                    </div>

                    <c:if test="${authC}">
                        <a href="" class="icon-btn navy" id="dialog-add">
                            <img src="/resources/cms/img/main/plus.svg" alt="">
                            <div>팝업 등록</div>
                        </a>
                    </c:if>
                </div>

                <table class="custom-table">
                    <thead>
                    <tr>
                        <th>순번</th>
                        <th>이미지</th>
                        <th>팝업명</th>
                        <th>링크타겟</th>
                        <th>사용여부</th>
                        <th>게시일</th>
                        <th>출력순서</th>
                        <th>등록일</th>
                        <th>기능</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${fn:length(popupList) < 1}">
                        <tr>
                            <td colspan="9" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="i" varStatus="status" items="${popupList}">
                        <tr>
                            <td>${popup.listRowNum - status.index}</td>
                            <td width="200">
                                <div class="item">
                                    <a href="${i.link_url}" target="_blank">
                                        <c:if test="${i.org_file_name eq null}">
                                            <img src="/resources/cms/img/noimg_135_42.gif" alt="이미지 미리보기 입니다.">
                                        </c:if>
                                        <c:if test="${i.org_file_name ne null}">
                                            <img width="45%" height="80px" src="${getContextPath}/data/popup/${i.homepage_id}/${i.server_file_name}" alt="${i.server_file_name}">
                                        </c:if>
                                    </a>
                                </div>
                            </td>
                            <td>${i.popup_name}</td>
                            <td>${i.link_target eq 'CURRENT' ? '현재창' : '새창'}</td>
                            <td width="50">${i.use_yn eq 'Y' ? '사용함' : '사용안함'}</td>
                            <td>${i.start_date} ~ ${i.end_date}</td>
                            <td>${i.print_seq}</td>
                            <td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
                            <td>
                                <div class="btn-wrapper">
                                    <c:if test="${authU}">
                                        <a href="" class="custom-btn" id="dialog-modify" keyValue="${i.homepage_id}" keyValue1="${i.popup_idx}">수정</a>
                                    </c:if>
                                    <c:if test="${authD}">
                                        <a href="" class="custom-btn" id="delete" keyValue="${i.homepage_id}" keyValue1="${i.popup_idx}">삭제</a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
                    <jsp:param name="formId" value="#popup_1"/>
                </jsp:include>

                <div class="table-search-bar">
                    <fieldset class="search-bar">
                        <form:select path="search_type" cssClass="custom-filter">
                            <form:option value="popup_name">팝업명</form:option>
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

<div id="dialog-1" class="dialog-common" title="팝업 정보">
</div>