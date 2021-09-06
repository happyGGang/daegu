<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	$(function() {
		//모달창 링크 버튼
		$('a#dialog-add').on('click', function(e) {
			if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ""){
				alert("홈페이지를 선택해 주세요.");
				return false;
			}
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${marathon.homepage_id}', function(response, status, xhr) {
				$('#dialog-1').dialog('open');
			});

			e.preventDefault();
		});

		$('a.dialog-modify').on('click', function(e) {
			if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ""){
				alert('홈페이지를 선택해 주세요.');
				return false;
			}
			$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${marathon.homepage_id}&contest_idx=' + $(this).attr('keyValue'), function(response, status, xhr){
				$('#dialog-1').dialog('open');
			});

			e.preventDefault();
		});
		
		$('a.delete').on('click', function(e) {
			if(confirm('선택된 대회를 삭제 하시겠습니까?')){
				$('input#contest_idx_1').val($(this).attr('keyValue'));
				$('input#editMode_1').val('DELETE');
				
				$.ajax({
					url : 'save.do',
					async : false,
					data : serializeObject($('#marathonForm')),
					method : 'POST',
					success : function(data){
						if(data.valid){
							alert(data.message);
							location.reload();
						}
					}
				});
			}
		});
		
 		$('button#search_btn').on('click', function(e) {
 			e.preventDefault();
 			$('#viewPage').val(1);
 			doGetLoad('index.do', serializeCustom($('#marathonForm')));
 		});
	});
</script>
<form:form modelAttribute="marathon" id="marathonForm" action="index.do" method="GET">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
	<form:hidden id="contest_idx_1" path="contest_idx"/>
	<form:hidden id="editMode_1" path="editMode"/>
	
	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<div class="button">
			<c:if test="${authC}">
				<a href="#" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	
	
	<table class="type1 center">
		<thead>
			<tr>
				<th>대회번호</th>			
				<th>대회명</th>
				<th>접수기간</th>
				<th>대회기간</th>
				<th>완주확정일</th>
				<th>사용여부</th>
				<th>등록일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${marathonContestList}" var="i">
				<tr>
					<td>${i.contest_idx}</td>
					<td>${i.contest_name}</td>
					<td>${i.application_start_day} ~ ${i.application_end_day}</td>
					<td>${i.contest_start_day} ~ ${i.contest_end_day}</td>
					<td>${i.finish_day}</td>
					<td>${fn:contains(i.use_yn, 'Y') ? '예':'아니오'}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>
						<a href="#" class="btn dialog-modify" keyValue="${i.contest_idx}">수정</a>
						<c:if test="${authD}">
							<a href="#" class="btn delete" keyValue="${i.contest_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(marathonContestList) < 1}">
				<tr>
					<td colspan="10">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#marathonForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!--  하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="contest_name">대회명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="독서마라톤대회 등록">
</div>
