<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#facilityReqListForm').submit();
	});
	
	
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&facility_idx=' + $(this).attr('keyValue') + '&req_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if ( confirm('해당 신청 정보를 삭제 하시겠습니까?') ) {
			$('#hiddenForm #facility_idx').val($(this).attr('keyValue'));
			$('#hiddenForm #req_idx').val($(this).attr('keyValue2'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	
	$('a#btn_apply').on('click', function(e) {
		if($(this).attr('keyValue3') == 'Y') {
			$('#dialog-2').load('reason.do?homepage_id=' + $('#homepage_id').val() + '&facility_idx=' + $(this).attr('keyValue') + '&req_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			});
			
			e.preventDefault();
// 			if ( confirm('해당 신청 정보 승인취소 하시겠습니까?') ) {
// 				$('#hiddenForm #facility_idx').val($(this).attr('keyValue'));
// 				$('#hiddenForm #req_idx').val($(this).attr('keyValue2'));
// 				$('#hiddenForm #apply_state').val($(this).attr('keyValue3'));
// 				$('form#hiddenForm').attr('action', 'apply.do');
// 				if(doAjaxPost($('#hiddenForm'))) {
// 					location.reload();
// 				}	
// 			}	
		} else if($(this).attr('keyValue3') == 'N') {
			if ( confirm('해당 신청 정보 승인 하시겠습니까?') ) {
				$('#hiddenForm #facility_idx').val($(this).attr('keyValue'));
				$('#hiddenForm #req_idx').val($(this).attr('keyValue2'));
				$('#hiddenForm #apply_state').val($(this).attr('keyValue3'));
				$('form#hiddenForm').attr('action', 'apply.do');
				if(doAjaxPost($('#hiddenForm'))) {
					location.reload();
				}	
			}
		}
			
		
		
		e.preventDefault();
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#facilityReqListForm').submit();
		}
		
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		if('${facilityReqListCount}' > 0) {
			$('#hiddenForm').attr('action', 'excelDownload.do').submit();
			$('#hiddenForm').attr('action', 'save.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		
		e.preventDefault();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="facilityReq" action="save.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="req_idx"/>
	<form:hidden path="apply_state"/>
</form:form>
<form:form id="facilityReqListForm"  modelAttribute="facilityReq" action="index.do" >
	<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${facilityReqListCount}건
		<div class="button">
			<c:if test="${member.auth_id <= 200}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="100" />
			<col width="150" />
			<col width="200" />
			<col width="150" />
			<col width="150" />
			<col width="200" />
			<col width="150" />
			<col width="150" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>신청자</th>
				<th>신청자ID</th>
				<th>시설물명</th>
				<th>전화번호</th>
				<th>휴대전화번호</th>
				<th>신청이용일</th>
				<th>신청이용시간</th>
				<th>미승인사유</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${facilityReqList}">
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>${i.req_name}</td>
					<td>${i.apply_id}</td>
					<td>${i.facility_name}</td>
					<td>${i.phone}</td>
					<td>${i.cell_phone}</td>
					<td>${i.start_date} ~ ${i.end_date}</td>
					<td>${i.start_time} ~ ${i.end_time}</td>
					<td>${i.reason}</td>
					<td>
						<c:if test="${member.auth_id <= 200}">
							<c:if test="${i.apply_state eq 'Y' }">
								<a href="" class="btn btn1" id="btn_apply" keyValue="${i.facility_idx}" keyValue2="${i.req_idx}" keyValue3="${i.apply_state}">승인취소</a>
							</c:if>
							<c:if test="${i.apply_state eq 'N' }">
								<a href="" class="btn btn1" id="btn_apply" keyValue="${i.facility_idx}" keyValue2="${i.req_idx}" keyValue3="${i.apply_state}">승인</a>
							</c:if>							
							<a href="" class="btn" id="dialog-modify" keyValue="${i.facility_idx}" keyValue2="${i.req_idx}">수정</a>
							<a href="" class="btn" id="delete-btn" keyValue="${i.facility_idx}" keyValue2="${i.req_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${facilityListCount eq 0}">
				<tr>
					<td colspan="8">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#facilityReqListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="REQ_NAME">신청자</form:option>
				<form:option value="PHONE">전화번호</form:option>
				<form:option value="CELL_PHONE">휴대전화번호</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="시설물신청 정보"></div>
<div id="dialog-2" class="dialog-common" title="미승인사유"></div>