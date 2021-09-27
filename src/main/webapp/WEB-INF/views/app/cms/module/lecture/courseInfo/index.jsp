<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	// 보여지는 정보 개수 변경
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#courseInfo').serialize());
	});

	// 등록 버튼 클릭
	$('a#dialog-add').on('click', function(e){
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	/*$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#book_report_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#courseInfo')));
	});
	
	$('select.approval_status').on('change', function(e) {
		e.preventDefault();
		$('form#courseInfo').attr('action', 'statusChange.do');
		$('#book_report_idx').val($(this).data('key'));
		$('#approval_status').val($(this).val());
		doAjaxPost($('form#courseInfo'));
	});*/

	// 삭제 버튼 클릭
	$('a.delete_btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('정말로 삭제하시겠습니까?\n\n삭제된 신청은 복구가 불가능합니다.\n\n※과정에 강의가 등록되어있다면 삭제 불가.')) {
			$('form#courseInfo').attr('action', 'delete.do');
			$('#course_id').val($(this).data('key'));
			$('#editMode').val('DELETE');
			doAjaxPost($('form#courseInfo'));
			location.reload();
		}
	});

	// 수정 버튼 클릭
	$('a.modify_btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('edit.do?editMode=UPDATE&course_id='+$(this).data('key'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});

	// 검색 버튼 클릭
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#courseInfo')));
	});

	// 액셀 버튼 클릭
	$('a#excelDownload').on('click', function(e) {
		$('#courseInfo').attr('action', 'excelDownload.do').submit();
		$('#courseInfo').attr('action', 'save.do');
		e.preventDefault();
	});

	// csv 버튼 클릭
	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		$('#courseInfo').attr('action', 'csvDownload.do').submit();
	});
	
});
</script>

<form:form modelAttribute="courseInfo">
<form:hidden path="editMode"/>
<form:hidden path="course_id"/>
<form:hidden path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		
		<form:select path="rowCount" cssClass="selectmenu">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
		
		<div class="button">
			<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	<div>
		<table class="type1 center">
			<colgroup>
				<col width="12%" />  <%--과정고유번호--%>
				<col width=24%" /> <%--과정명--%>
				<col width="10%" /> <%--과정노출시작기간--%>
				<col width="10%" /> <%--과정노출종료기간--%>
				<col width="6%" /> <%--사용여부--%>
				<col width="10%" /> <%--등록일--%>
				<col width="10%" /> <%--등록ID--%>
				<col width="10%" /> <%--등록IP--%>
				<col width="" /> <%--기능--%>
			</colgroup>
			<thead>
				<tr>
					<th>과정고유번호</th>
					<th>과정명</th>
					<th>과정노출시작기간</th>
					<th>과정노출종료기간</th>
					<th>사용여부</th>
					<th>등록일</th>
					<th>등록ID</th>
					<th>등록IP</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${courseInfoList}">
					<tr>
						<%--과정 고유 번호--%>
						<td>${i.course_id}</td>
						<%--과정명--%>
						<td>${i.course_title}</td>
						<%--과정노출시작기간--%>
						<td>
							${i.view_start_date}
						</td>
						<%--과정노출종료기간--%>
						<td>${i.view_end_date}</td>
						<%--사용여부--%>
						<td>${i.use_yn}</td>
						<%--등록일--%>
						<fmt:formatDate var="formatRegDate" value="${i.add_date}" pattern="yyyy-MM-dd"/>
							<td>${formatRegDate}</td>
						<%--등록ID--%>
						<td>
							${i.add_id}
						</td>
						<%--등록IP--%>
						<td>
							${i.add_ip}
						</td>
						<%--기능--%>
						<td>
							<a href="#" class="btn modify_btn" data-key="${i.course_id}">수정</a>
							<a href="#" class="btn delete_btn" data-key="${i.course_id}">삭제</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(courseInfoList) < 1}">
					<tr>
						<td colspan="9">등록된 강좌 과정이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#courseInfo"/>
		</jsp:include>
		
		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu">
					<form:option value="course_id">과정번호</form:option>
					<form:option value="course_title">과정명</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
			</fieldset>
		</div>
		
	</div>
	
</form:form>

<div id="dialog-1" class="dialog-common" title="강좌 과정 등록"></div>
<div id="dialog-2" class="dialog-common" title="강좌 과정 수정"></div>
