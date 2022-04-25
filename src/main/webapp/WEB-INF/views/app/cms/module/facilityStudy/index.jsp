<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${facilityStudy.homepage_id}', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${facilityStudy.homepage_id}&study_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete').on('click', function(e) {
		if(confirm('선택된 신청정보를 삭제 하시겠습니까?')) {
			$('input#study_idx_1').val($(this).attr('keyValue'));
			$('input#editMode_1').val('DELETE');

			$.ajax({
				url : 'save.do',
				async : false,
				data : serializeObject($('#facilityStudy_1')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
				}
			});
		}

		e.preventDefault();
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#facilityStudy_1')));
	});

	$('select#use_yn, select#rowCount').on('change', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#facilityStudy_1')));
	});

	$('select.changeStatus').on('change', function() {
		var idx = $(this).data('idx');
		var status = $(this).val();
		var editMode = '';
		if (status == '1') {
			editMode = 'APPROVE';
		} else if (status == '2') {
			$('#dialog-2').load('cancel.do?homepage_id=${facilityStudy.homepage_id}&study_idx=' + $(this).data('idx') + '&editMode=CANCEL_TXT', function( response, status, xhr ) {
				$('#dialog-2').dialog('open');
			});
			return false;
		} else if (status == '0') {
			editMode = 'READY';
		}
		$.ajax({
			type: "POST",
			url: 'save.do',
			data: {'study_idx':idx, 'apply_status':status, 'editMode':editMode},
			success: function(response) {
				if (response.valid) {
					alert('수정되었습니다.');
				}
			},
			error : function() {
				alert('수정에 실패했습니다.')
			}
		});
	});
	
	$('input#checkAll').on('click', function(e) {
		$('input[type = checkbox].study_idx_arr').prop('checked', $(this).is(':checked'));
	});
	
	$('a#dialog-delete').on('click', function(e) {

		if($('input:checkbox[name = study_idx_arr]:checked').length < 1) {
			alert('삭제할 신청 건을 선택해 주세요.');
			return false;
		}
		
		if(confirm('선택한 신청을 정말 삭제하시겠습니까?')) {
			$('#editMode_1').val('DELETE_ALL');
			if(doAjaxPost($('#facilityStudy_1'))) {
				location.reload();
			}
		}
		
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('form#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('form#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});
});
</script>

<form:form id="hiddenForm" modelAttribute="facilityStudy" action="save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="study_idx"/>
</form:form>

<form:form id="facilityStudy_1" modelAttribute="facilityStudy" method="POST" action="save.do" onsubmit="return false;">
<form:hidden id="editMode_1" path="editMode"/>
<form:hidden id="study_idx_1" path="study_idx"/>
<form:hidden id="homepage_id_1" path="homepage_id"/>
<div id="editDisable" class="disableBox">
	<div class="infodesk">
		검색 결과 : ${paging.totalDataCount}건
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
		<div class="button">
			<c:if test="${authD}">
				<a href="" class="btn btn5 left" id="dialog-delete"><i class="fa fa-minus"></i><span>선택삭제</span></a>
			</c:if>
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<thead>
			<tr>
				<th width="50"><input type="checkbox" id="checkAll"></th>
				<th width="50">순번</th>
				<th width="200">사용일자</th>
				<th width="200">사용시설</th>
				<th width="50">사용시간</th>
				<th width="100">모임명</th>
				<th width="100">신청자명</th>
				<th width="150">신청일</th>
				<th width="100">상태</th>
				<th width="100">기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(facilityStudyList) < 1}">
			<tr style="height:100%">
				<td colspan="10" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${facilityStudyList}">
			<tr>
				<td width="50"><form:checkbox path="study_idx_arr" value="${i.study_idx}" class="study_idx_arr"/></td>
				<td width="50">${paging.listRowNum - status.index}</td>
				<td width="200">${i.study_date}</td>
				<td width="200">
					<c:if test="${i.study_num eq 1}">301호실 스터디룸</c:if>
				</td>
				<td width="50">
					<c:if test="${i.study_time eq 1}">오전</c:if>
					<c:if test="${i.study_time eq 2}">오후</c:if>
					<c:if test="${i.study_time eq 3}">야간</c:if>
				</td>
				<td width="100">
					${i.study_name}
				</td>
				<td width="100">
					${i.apply_name}
				</td>
				<td width="150"><fmt:formatDate value="${i.apply_date}" pattern="yyyy-MM-dd"/></td>
				<td width="150">
					<select class="changeStatus" data-idx="${i.study_idx}">
						<option value="0" <c:if test="${i.apply_status eq '0'}">selected</c:if>>대기</option>
						<option value="1" <c:if test="${i.apply_status eq '1'}">selected</c:if>>승인</option>
						<option value="2" <c:if test="${i.apply_status eq '2'}">selected</c:if>>취소</option>
					</select>
				</td>
				<td width="120">
					<a href="" class="btn dialog-modify" keyValue="${i.study_idx}">수정</a>
					<c:if test="${authD}">
						<a href="" class="btn delete" keyValue="${i.study_idx}">삭제</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#facilityStudy_1"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="apply_name">신청자명</form:option>
				<form:option value="study_name">모임명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="그룹스터디 신청 정보">
</div>

<div id="dialog-2" class="dialog-common" title="그룹스터디 신청 취소">
</div>
