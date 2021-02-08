<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#blackListForm').submit();
	});
	
	
	$('a#dialog-add').on('click', function(e) {
		
		if($('#homepage_id').val() == "") {
			alert('홈페이지를 선택해주세요.');
			return false;
		}
// 		if($('#type_1').val() == "") {
// 			alert('블랙리스트 구분을 선택해주세요.');
// 			return false;
// 		}
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() , function( response, status, xhr ) {
			$('#dialog-1').dialog({
				width: 500,
				height: 250
			});	
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&black_idx=' + $(this).attr('keyValue') , function( response, status, xhr ) {
			$('#dialog-1').dialog({
				width: 500,
				height: 250
			});
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if (confirm("해당 아이디를 블랙리스트 목록에서 삭제하시겠습니까?")) {
			$('form#blackListForm').attr('action', 'save.do');
			$('input#black_idx').val($(this).attr('keyValue'));
			$('input#editMode').val('DELETE');
			
			if(doAjaxPost($('#blackListForm'))) {
				location.reload();
			}
		}
	});
	
	$('select#homepage_id').on('change', function(e) {
		if($(this).val() != '') {
			$('#blackListForm').submit();
		}
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		
		if('${fn:length(list)}' > 0) {
			$('#blackListForm').attr('action', 'excelDownload.do').submit();
			$('#blackListForm').attr('action', 'index.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(list)}' > 0) {
			$('#blackListForm').attr('action', 'csvDownload.do').submit();
			$('#blackListForm').attr('action', 'index.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		e.preventDefault();
	});
});
</script>
<form:form id="blackListForm"  modelAttribute="blackList" action="index.do">
	<form:hidden path="black_idx"/>
	<form:hidden path="editMode" />
	<c:if test="${!member.admin}">
		<form:hidden path="homepage_id"/>
	</c:if>
	
	<c:if test="${member.admin}">
		<div class="search">
			<fieldset>
				<label class="blind">검색</label>				
				<form:select class="selectmenu-search" style="width:250px" path="homepage_id">
					<form:option value="" label="홈페이지를 선택하세요." />
					<form:options itemValue="homepage_id" itemLabel="homepage_name" items="${homepageList}"/>
				</form:select> 
			</fieldset>
		</div>
	</c:if>
	<div class="infodesk">
		검색 결과 : 총 ${fn:length(list)}건
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="10%" />
			<col width="10%" />
			<col width="20%" />
			<col width="100" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>블랙리스트ID</th>
				<th>블랙 구분</th>
				<th>사유</th>
				<th>등록일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${list}">
				<tr>
					<td class="num">${status.count}</td>
					<td>${i.member_id}</td>
					<td>
						<c:forEach items="${fn:split(i.black_type, ',')}" var="oneType" varStatus="status">
							${blackTypeList[oneType]}<c:if test="${!status.last}">, </c:if>
						</c:forEach>
					</td>
					<td>${i.reason}</td>
					<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" /></td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.black_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.black_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(list) < 1}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
 	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#blackListForm"/>
	</jsp:include>
	
 	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="member_id">사용자ID</form:option>
				<form:option value="reason">사유</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
<!-- 			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a> -->
<!-- 			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a> -->
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="블랙리스트 정보"></div>
