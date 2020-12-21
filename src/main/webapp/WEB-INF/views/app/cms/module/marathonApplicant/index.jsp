<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ''){
			alert('홈페이지를 선택해 주세요.');
			return false;
		}
		<c:if test="${fn:length(marathonList) < 1}">
			alert('등록된 독서마라톤대회가 없습니다. 대회를 등록해 주세요.');
			return false;
		</c:if>
		<c:if test="${fn:length(marathonTypeList) < 1}">
			alert('등록된 독서마라톤종목이 없습니다. 종목을 등록해 주세요.');
			return false;
		</c:if>
		var param = $('select#contest_idx').serialize();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${marathonApplicant.homepage_id}&' + param, function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
	});

	$('tbody>tr>td>a.applicant').on('click', function(e) {
		e.preventDefault();
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ''){
			alert('홈페이지를 선택해 주세요.');
			return false;
		}
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${marathonApplicant.homepage_id}&contest_idx=' + $(this).attr('keyValue') + '&contest_type_idx=' + $(this).attr('keyValue2') + '&applicant_idx=' + $(this).attr('keyValue3'), function(response, status, xhr) {
			$('#dialog-1').dialog('open');
		});
	});

	$('tbody>tr>td>a.record').on('click', function(e) {
		e.preventDefault();
		if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ''){
			alert('홈페이지를 선택해 주세요.');
			return false;
		}
		$('#dialog-2').load('viewRecord.do?homepage_id=${marathonApplicant.homepage_id}&contest_idx=' + $(this).attr('keyValue') + '&contest_type_idx=' + $(this).attr('keyValue2') + '&applicant_idx=' + $(this).attr('keyValue3'), function(response, status, xhr) {
			$('#dialog-2').dialog('open');
		});
	});

	$('select#contest_idx').on('change', function(e) {
		if($(this).val() == 0){
			return false;
		}
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#marathonApplicantForm')));
	});
	$('select#contest_type_idx').on('change', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#marathonApplicantForm')));
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#marathonApplicantForm')));
	});
	
	$('button#checkAll').on('click', function(e) {
		e.preventDefault();
		if($('input:checkbox[name = applicant_idx_arr]').eq(0).is(':checked')){
			for(var i = 0; i < $('input:checkbox[name = applicant_idx_arr]').length; i++){
				$('input:checkbox[name = applicant_idx_arr]').eq(i).prop('checked', false);
			}
		}else{
			for(var i = 0; i < $('input:checkbox[name = applicant_idx_arr]').length; i++){
				$('input:checkbox[name = applicant_idx_arr]').eq(i).prop('checked', true);
			}
		}
	});
	
	$('button#deleteSelected').on('click', function(e) {
		e.preventDefault();
		$('#editMode_1').val('DELETE');
		if(confirm('선택한 게시물을 삭제하시겠습니까?')){
			var checkboxarr = $('input:checkbox[name = applicant_idx_arr]:checked');
			var contest_type_idx_arr = new Array();
			var contest_idx_arr = new Array();
			checkboxarr.each(function(i) {
				contest_type_idx_arr.push($(this).siblings('input[name = contest_type_idx_1]').val());
				contest_idx_arr.push($(this).siblings('input[name = contest_idx_1]').val());
			});
			$('input#contest_type_idx_arr').val(contest_type_idx_arr);
			$('input#contest_idx_arr').val(contest_idx_arr);

			$('form#marathonApplicantForm').attr('action', 'save.do');
			if(doAjaxPost($('form#marathonApplicantForm'))){
				location.reload();
			}
		}
	});

	$('button#updateStatus').on('click', function(e) {
		e.preventDefault();
		$('#editMode_1').val('MODIFYSTATUS');
		if(confirm('선택한 게시글의 정보를 변경하시겠습니까?')){
			var checkboxarr = $('input:checkbox[name = applicant_idx_arr]:checked');
			var contest_type_idx_arr = new Array();
			var page_count_arr = new Array();
			var read_page_count_total_arr = new Array();
			checkboxarr.each(function(i) {
				contest_type_idx_arr.push($(this).siblings('input[name = contest_type_idx_1]').val());
				page_count_arr.push($(this).siblings('input[name = page_count_1]').val());
				read_page_count_total_arr.push($(this).siblings('input[name = read_page_count_total_1]').val());
			});
			$('input#contest_type_idx_arr').val(contest_type_idx_arr);
			$('input#page_count_arr').val(page_count_arr);
			$('input#read_page_count_total_arr').val(read_page_count_total_arr);

			$('form#marathonApplicantForm').attr('action', 'save.do');
			if(doAjaxPost($('form#marathonApplicantForm'))){
				location.reload();
			}
		}
	});

	$('a.excelDown').on('click', function(e) { //1명의 참가자 엑셀 다운 ( 참가자 정보, 일지)
		e.preventDefault();
		$('select#contest_idx').val($(this).attr('keyValue'));
		$('select#contest_type_idx').val($(this).attr('keyValue2'));
		$('input#applicant_idx').val($(this).attr('keyValue3'));
		doGetLoad('viewApplicantRecordOneExcelDown.do', serializeCustom($('form#marathonApplicantForm')));
	});

	$('a#applicantExcelDownload').on('click', function(e) { //참가자 엑셀 다운 ( 참가자 정보 )
		e.preventDefault();
		doGetLoad('viewApplicantListExcelDown.do', serializeCustom($('form#marathonApplicantForm')));
	});

	$('a#recordExcelDownload').on('click', function(e) { //일지 엑셀 다운 ( 참가자 정보, 일지 )
		e.preventDefault();
		doGetLoad('viewApplicantRecordListExcelDown.do', serializeCustom($('form#marathonApplicantForm')));
	});

	$('a#recordExcelSuccessDownload').on('click', function(e) { //완주자 정보, 일지
		e.preventDefault();
		doGetLoad('viewRecordSuccessExcelDown.do', serializeCustom($('form#marathonApplicantForm')));
	});

	$('a#recordExcelSuccessEditDownload').on('click', function(e) { //완주자 편집 정보, 일지
		e.preventDefault();
		doGetLoad('viewRecordSuccessEditExcelDown.do', serializeCustom($('form#marathonApplicantForm')));
	});
});
</script>
<form:form modelAttribute="marathonApplicant" id="marathonApplicantForm" action="index.do" method="GET">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
	<form:hidden id="editMode_1" path="editMode"/>
	<form:hidden path="contest_type_idx_arr"/>
	<form:hidden path="page_count_arr"/>
	<form:hidden path="read_page_count_total_arr"/>
	<form:hidden path="contest_idx_arr"/>
	<form:hidden path="applicant_idx"/>
	<form:hidden path="menu_idx"/>

	<div class="infodesk">
		검색 결과 : 총  ${paging.totalDataCount}건
		<span style="padding-left: 1%;">대회명 :</span>
		<form:select path="contest_idx" class="selectmenu">
			<form:option value="0" label="대회명"/>
			<form:options itemValue="contest_idx" itemLabel="contest_name" items="${marathonList}"/> 
		</form:select>
		<span style="padding-left: 1%;">대회종목 :</span>
		<form:select path="contest_type_idx" class="selectmenu">
			<form:option value="0" label="전체"/>	
			<form:options itemValue="contest_type_idx" itemLabel="contest_type" items="${marathonTypeList}"/>
		</form:select>
		<div class="button">
			<a href="#" id="applicantExcelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i>
				<span>${marathonApplicant.contest_type} 참가자 엑셀</span>
			</a>
			<c:if test="${marathonApplicant.contest_type_idx != 0}">
				<a href="#" id="recordExcelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i>
					<span>${marathonApplicant.contest_type} 일지 엑셀</span>
				</a>
			</c:if>
			<a href="#" id="recordExcelSuccessDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i>
				<span>${marathonApplicant.contest_type} 일지 엑셀(완주자)</span>
			</a>
			<a href="#" id="recordExcelSuccessEditDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i>
				<span>${marathonApplicant.contest_type} 일지 엑셀(완주자편집용)</span>
			</a>
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	※ 참가자정보를 클릭해서 수정할 수 있습니다.

	<table class="type1 center">
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>휴대전화번호</th>
				<th>참가종목</th>
				<th>달성률</th>
				<th>등록일</th>
				<th>상태</th>
				<th>일지</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${marathonApplicantList}" varStatus="status" var="i">
				<tr>
					<td>
						<input type="hidden" name="contest_type_idx_1" value="${i.contest_type_idx}"/>
						<input type="hidden" name="page_count_1" value="${i.page_count}"/>
						<input type="hidden" name="read_page_count_total_1" value="${i.read_page_count_total}"/>
						<input type="hidden" name="contest_idx_1" value="${i.contest_idx}"/>
						<form:checkbox path="applicant_idx_arr" cssClass="text" value="${i.applicant_idx}"/>
					</td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">${paging.listRowNum - status.index }</a></td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">${i.member_id}</a></td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">${i.member_name}</a></td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">${i.telephone}</a></td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">${i.cellphone}</a></td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">${i.contest_type} (<fmt:formatNumber value="${i.page_count}" pattern="#,###"/>쪽)</a></td>
					<td><a href="" class="applicant" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}"><fmt:formatNumber value="${i.read_page_count_total}" pattern="#,###"/> / <fmt:formatNumber value="${i.page_count}" pattern="#,###"/>
					(<fmt:formatNumber value="${(i.read_page_count_total/i.page_count)*100.0}" pattern="##.##"/>%)</a></td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></td>
					<td>
						<c:choose>
							<c:when test="${i.process_status eq 0}">
								심사대기
							</c:when>
							<c:when test="${i.process_status eq 1}">
								<span style="color:blue;">완주완료</span>
							</c:when>
							<c:when test="${i.process_status eq 2}">
								<span style="color:red;">완주실패</span>
							</c:when>
						</c:choose>
					</td>
					<td>
						<a class="btn record" class="btn" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">보기</a>
						<a class="btn excelDown" class="btn" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}" keyValue3="${i.applicant_idx}">엑셀</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(marathonApplicantList) < 1}">
				<tr>
					<td colspan="11">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
		<button id="checkAll" class="btn btn3">전체 선택/해제</a>
		<button id="deleteSelected" class="btn btn3">선택 게시글 삭제</button>
		선택한 참가자를 
		<form:select path="process_status" cssClass="selectmenu">
			<form:option value="0">심사대기</form:option>
			<form:option value="1">완주완료</form:option>
			<form:option value="2">완주실패</form:option>
		</form:select>
		로 <button id="updateStatus" class="btn btn3">변경</button>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#marathonApplicantForm"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="member_id">아이디</form:option>
				<form:option value="member_name">이름</form:option>
				<form:option value="telephone">전화번호</form:option>
				<form:option value="cellphone">휴대전화번호</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="독서마라톤신청자 등록 및 수정"></div>
<div id="dialog-2" class="dialog-common" title="독서마라톤신청자 정보"></div>