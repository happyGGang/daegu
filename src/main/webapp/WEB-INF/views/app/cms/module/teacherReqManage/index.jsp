<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#teacherListForm').submit();
	});
	
	
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
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&teacher_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 강사를 정말 삭제 하시겠습니까?') ) {
			$('#hiddenForm #editMode').val('DELETE');
			$('#hiddenForm #homepage_id').val($(this).attr('keyValue1'));
			$('#hiddenForm #teacher_idx').val($(this).attr('keyValue2'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}	
		}
	});
	
	$('a.confirm-btn').on('click', function(e) {
		$('#hiddenForm #editMode').val('CONFIRM');
		$('#hiddenForm #homepage_id').val($(this).attr('keyValue1'));
		$('#hiddenForm #teacher_idx').val($(this).attr('keyValue2'));
		$('#hiddenForm #confirm_yn').val($(this).attr('keyValue3'));
		if(doAjaxPost($('#hiddenForm'))) {
			location.reload();
		}
	});
	
	$('a#excelDownload').on('click', function(e) {
		$('#hiddenForm').attr('action', 'excelDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		$('#hiddenForm').attr('action', 'csvDownload.do').submit();
		$('#hiddenForm').attr('action', 'save.do');
		e.preventDefault();
	});
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#teacherListForm').submit();
		}
		
		e.preventDefault();
	});
	
	$('select#confirm_yn').change(function() {
		$('#teacherListForm').submit();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="teacher" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="teacher_idx"/>
<form:hidden path="confirm_yn"/>
</form:form>
<form:form id="teacherListForm"  modelAttribute="teacher" action="index.do" >
	<form:hidden id="homepage_id_1" path="homepage_id"/>
	
	<div class="infodesk">
		검색 결과 : 총 ${teacherListCount}건
		<div class="button">
			승인여부 : 
			<form:select class="selectmenu" path="confirm_yn">
				<form:option value="">전체</form:option>
				<form:option value="Y">승인</form:option>
				<form:option value="N">미승인</form:option>
			</form:select>
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="150" />
			<col width="50" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>강사명</th>	
				<th>성별</th>	
				<th>전화번호</th>
				<th>휴대전화번호</th>
				<th>(구)강사신청서</th>
				<th>상태</th>
				<th>신청일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${teacherList}">
				<tr>
					<td>${teacher.listRowNum - status.index}</td>
					<td>${i.teacher_name}</td>
					<td>${i.teacher_sex}</td>
					<td>${i.teacher_phone}</td>
					<td>${i.teacher_cell_phone}</td>
					<td class="left">
						<c:if test="${i.file_name ne null and i.file_name ne ''}">
							<a href="/cms/module/teacherReqManage/download/${i.homepage_id}/${i.teacher_idx}.do"><i class="fa fa-floppy-o"></i> ${i.file_name}<c:if test="${not empty i.file_extension}">.${i.file_extension}</c:if></a>
						</c:if>	
					</td>
					<td>
						${i.confirm_yn eq 'N' ? '신청중' : '승인완료'}
					</td>
					<td>${i.add_date}</td>
					<td>
						<c:if test="${i.confirm_yn eq 'N'}">
						<c:if test="${authC or authU}">
							<a href="" class="btn btn1 confirm-btn" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}" keyValue3="Y">승인</a>
						</c:if>
						</c:if>
						<c:if test="${i.confirm_yn eq 'Y'}">
						<c:if test="${authC or authU}">
							<a href="" class="btn btn1 confirm-btn" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}" keyValue3="N">승인 취소</a>
						</c:if>
						</c:if>
						<c:if test="${authU}">
						<a href="" class="btn dialog-modify" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
						<a href="" class="btn delete-btn" keyValue1="${i.homepage_id}" keyValue2="${i.teacher_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${teacherListCount eq 0}">
				<tr>
					<td colspan="10">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#teacherListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="TEACHER_NAME">강사명</form:option>
				<form:option value="TEACHER_SEX">성별</form:option>
				<form:option value="TEACHER_CELL_PHONE">휴대전화번호</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="강사 정보"></div>
<div id="dialog-2" class="dialog-common" title="강사 이력"></div>
