<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	$(function() {
		//모달창 링크 버튼
		$('a#dialog-add').on('click', function(e) {
			if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ''){
				alert('홈페이지를 선택해 주세요.');
				return false;
			}
			<c:if test="${fn:length(marathonList) < 1}">
				alert('등록된 독서마라톤대회가 없습니다. 대회를 등록해 주세요.');
				return false;
			</c:if>
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${marathonType.homepage_id}', function(response, status, xhr){
				$('#dialog-1').dialog('open');
			});
			
			e.preventDefault();
		});
		
		$('a.dialog-modify').on('click', function(e) {
			if($('#homepage_id_1').val() == null || $('#homepage_id_1').val() == ''){
				alert('홈페이지를 선택해 주세요.');
				return false;
			}
			$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${marathonType.homepage_id}&contest_idx=' + $(this).attr('keyValue') + '&contest_type_idx=' + $(this).attr('keyValue2'), function(response, status, xhr){
				$('#dialog-1').dialog('open');
			});
		});
		
		$('a.delete').on('click', function(e) {
			if(confirm('선택된 대회종목을 삭제 하시겠습니까?')){
				$('#contest_idx').val($(this).attr('keyValue'));
				$('input#contest_type_idx_1').val($(this).attr('keyValue2'));
				$('input#editMode_1').val('DELETE');
				
				$.ajax({
					url : 'save.do',
					async : false,
					data : serializeObject($('#marathonTypeForm')),
					method : 'POST',
					success : function(data){
						if(data.valid){
							alert(data.message);
							location.reload();
						}
					}
				})
			}
		});
		
		$('select#contest_idx').on('change', function(e) {
			e.preventDefault();
			$('#viewPage').val(1);
			doGetLoad('index.do', serializeCustom($('form#marathonTypeForm')));
		});
		
		$('button#search_btn').on('click', function(e) {
 			e.preventDefault();
 			$('#viewPage').val(1);
 			doGetLoad('index.do', serializeCustom($('#marathonTypeForm')));
 		});
	});
</script>
<form:form modelAttribute="marathonType" id="marathonTypeForm" action="index.do" method="GET">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
	<form:hidden id="contest_type_idx_1" path="contest_type_idx"/>
	<form:hidden id="editMode_1" path="editMode"/>
	 
	
	<div class="infodesk">
		검색 결과 : 총 ${paging.totalDataCount}건
		<span style="padding-left: 1%;">대회명 :</span>
		<form:select path="contest_idx" class="selectmenu">
			<form:option value="0" label="전체"/>
			<form:options itemValue="contest_idx" itemLabel="contest_name" items="${marathonList}"/>
		</form:select>
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
				<th>대회종목번호</th>
				<th>대회종목</th>
				<th>쪽수</th>
				<th>대상</th>
				<th>등록일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${marathonTypeList}" var="i">
				<tr>
					<td>${i.contest_idx}</td>
					<td>${i.contest_name}</td>
					<td>${i.contest_type_idx}</td>
					<td>${i.contest_type}</td>
					<td>${i.page_count}쪽</td>
					<td>
						<c:choose>
							<c:when test="${i.application_subject eq 'ele_low'}">
								초등1~3학년
							</c:when>
							<c:when test="${i.application_subject eq 'ele_high'}">
								초등4~6학년
							</c:when>
							<c:when test="${i.application_subject eq 'middle,high,adult'}">
								중학생 이상, 일반인
							</c:when>
							<c:when test="${i.application_subject eq 'all'}">
								초등생~성인
							</c:when>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
					<td>
						<a href="#" class="btn dialog-modify" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}">수정</a>
						<c:if test="${authD}">
							<a href="#" class="btn delete" keyValue="${i.contest_idx}" keyValue2="${i.contest_type_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(marathonTypeList) < 1}">
				<tr>
					<td colspan="8">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#marathonTypeForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="contest_name">대회명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="독서마라톤종목 등록"></div>