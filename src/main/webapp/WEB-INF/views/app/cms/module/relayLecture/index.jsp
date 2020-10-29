<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#relayLecture').serialize());
	});
	
	$('a#dialog-add').on('click', function(e){
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-view').on('click', function(e){
		e.preventDefault();
		$('#dialog-2').load('/cms/module/relayLecture/relayLectureApply/index.do?homepage_id='+$('#homepage_id').val() + '&lecture_idx=' + $(this).data('key'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#lecture_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#relayLecture')));
	});
	
	$('select.exposure_status').on('change', function(e) {
		e.preventDefault();
		$('form#relayLecture').attr('action', 'statusChange.do');
		$('#lecture_idx').val($(this).data('key'));
		$('#exposure_status').val($(this).val());
		doAjaxPost($('form#relayLecture'));
	});
	
	$('a.delete_btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('정말로 삭제하시겠습니까?\n\n삭제된 신청은 복구가 불가능합니다.')) {
			$('form#relayLecture').attr('action', 'delete.do');
			$('#lecture_idx').val($(this).data('key'));
			$('#editMode').val('DELETE');
			doAjaxPost($('form#relayLecture'));
			location.reload();
		}
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#relayLecture')));
	});
	
});
</script>

<form:form modelAttribute="relayLecture" >
<form:hidden path="homepage_id"/>
<form:hidden path="lecture_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="exposure_status"/>
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
				<col width="5%" />
				<col width="12%"/>
				<col width=""/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="5%"/>
				<col width="5%"/>
				<col width="7%"/>
				<col width="5%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>행사일자</th>
					<th>행사명</th>
					<th>신청정보</th>
					<th>장소</th>
					<th>상태</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" varStatus="status" items="${relayLectureList}">
					<tr>
						<td>${paging.listRowNum - status.index}</td>
						<td>${i.event_start_date} ~ ${i.event_end_date}</td>
						<td class="left">
							<a href="#" class="view_btn" data-key="${i.lecture_idx}">
								${i.event_name}
							</a>
						</td>
						<td>
							<a href="#" class="btn btn1 dialog-view" data-key="${i.lecture_idx}">신청보기(${i.apply_count}/${i.recruitment_number})</a>
						</td>
						<td>${i.event_place}</td>
						<td>
							<select class="exposure_status" data-key="${i.lecture_idx}">
								<option value="Y" ${i.exposure_status eq 'Y' ? 'selected' : ''}>노출</option>
								<option value="N" ${i.exposure_status eq 'N' ? 'selected' : ''}>비노출</option>
							</select>
						</td>
						<td>${i.add_id}</td>
						<td>
							<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
						</td>
						<td>${i.view_count}</td>
						<td>
							<a href="#" class="btn delete_btn" data-key="${i.lecture_idx}">삭제</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(relayLectureList) < 1}">
					<tr>
						<td colspan="10">등록된 회원정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#relayLecture"/>
		</jsp:include>
		
		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu">
					<form:option value="event_name">행사명</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
		
	</div>
	
</form:form>

<div id="dialog-1" class="dialog-common" title="릴레이강연 등록"></div>
<div id="dialog-2" class="dialog-common" title="릴레이강연 신청정보 보기"></div>
