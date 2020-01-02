<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=view&library_check_idx='+$(this).attr('keyValue');
		doGetLoad('view.do', formData);
	});
	
	$('a#allChk').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('input[name="library_check_arr"]').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('input[name="library_check_arr"]').prop('checked', false);
		}
	});
	
	$('a#delete-chk').on('click', function(e) {
		e.preventDefault();
		if(confirm('선택한 장서점검기들을 삭제하시겠습니까?')) {
			$('#editMode').val('DELETE_ALL');
			$('form#libraryCheck').attr('action', 'save.do');
			$('form#libraryCheck').attr('method', 'POST');
			if(doAjaxPost($('form#libraryCheck'))) {
				location.reload();
			}
		}
	});
	
	$('a.dialog-req').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&library_check_idx='+$(this).attr('keyValue') + '&library_check_number='+$(this).attr('keyValue2')
			+ '&request_status='+$(this).attr('keyValue3');
		$('#dialog-2').load('loanEdit.do?'+formData, function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
});
</script>
<style>
.group-box {display:inline-block;width: 150px;text-align: center;padding: 20px;}
.content-box h3 {display: inline-block;}
div.img-box {position: relative;display:inline-block;border: 1px solid #ccc;}
div.img-box span.num {position: absolute;top: 30px;right: 22px;width: 18px;height: 18px;padding: 4px 4px;font-family: 'Montserrat',sans-serif;font-weight: 700;text-align: center;line-height: 17px;color: #fff;background-color: red;border-radius: 50%;}
</style>
<form:form modelAttribute="libraryCheck" action="index.do" method="GET">
<form:hidden path="editMode"/>

	<form:select path="loan_status" cssClass="selectmenu">
		<form:option value="">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select>

	<div>
		<c:forEach items="${libraryCheckList}" var="i">
		<div class="group-box">
			<div class="img-box">
				<a href="#" class="view-btn" keyValue="${i.library_check_idx}">
					<span class="num">${i.library_check_number}</span>
					<c:choose>
						<c:when test="${not empty i.server_file_name}">
						<img alt="장서점검기 이미지" src="${getContextPath}/data/libraryCheck/${i.server_file_name}">
						</c:when>
						<c:otherwise>
						<img src="/resources/common/img/noimg-gall.png" alt="no-image">
						</c:otherwise>
					</c:choose>
				</a>
			</div>
			<div class="content-box">
				<form:checkbox path="library_check_arr" value="${i.library_check_idx}"/>
				<a href="#" class="view-btn" keyValue="${i.library_check_idx}">
					<h3>장서점검기${i.library_check_number}</h3>
				</a>
				<div>
					<c:choose>
						<c:when test="${i.lender_count < 1}">
						<a href="#" class="dialog-req" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="0">신청하기</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty i.loan_start_date and empty i.loan_end_date}">
								<a href="#" class="dialog-req" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="1">예약하기</a>
								</c:when>
								<c:otherwise>
								<a href="#" class="dialog-req" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="1">
									예약중<br/>${i.loan_start_date}~${i.loan_end_date}
								</a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>
		</div>
		</c:forEach>
		<c:if test="${fn:length(libraryCheckList) < 1}">
		<div align="center">
			<h3>등록된 장서점검기가 없습니다.</h3>
		</div>
		</c:if>
	</div>
	<a href="#" class="btn" id="allChk" keyValue="N">전체 선택/해제</a>
	<a href="#" class="btn" id="delete-chk">선택 게시글 삭제</a>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#libraryCheck"/>
	</jsp:include>
	
	<div class="infodesk">
		<div class="button">
			<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="장기점검기  등록"></div>
<div id="dialog-2" class="dialog-common" title="장기점검기 신청"></div>