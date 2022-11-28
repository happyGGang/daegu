<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});	
		e.preventDefault();		
	});
	
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&device_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if ( confirm($(this).attr('keyValue2') + ' 를(을) 삭제 하시겠습니까?')) {
			$('#deleteDevice #device_idx').val($(this).attr('keyValue1'));
			if(doAjaxPost($('#deleteDevice'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$('a#locker-edit').on('click', function(e) {
		console.log($(this).attr('keyValue3'));
		$('#dialog-2').load('/cms/module/neighborhoodLibraryLocker/edit.do?editMode=ADD&device_idx=' + $(this).attr('keyValue1') + '&device_code=' + $(this).attr('keyValue2') + '&device_name=' + $(this).attr('keyValue3'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		e.preventDefault();
	});

	$('a#locker-detail').on('click', function(e) {
		$('#dialog-3').load('/cms/module/neighborhoodLibraryLocker/detail.do?device_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog('open');
		});
		e.preventDefault();
	});
	
	$('a#locker-index').on('click', function(e) {
			var win = window.open('/cms/module/neighborhoodLibraryLocker/index.do?editMode=ADD&device_idx=' + $(this).attr('keyValue1') + '&device_name=' + $(this).attr('keyValue2'), '_blank');
	        win.focus();					
		e.preventDefault();
	});
	
});
</script>
<form:form id="deleteDevice" modelAttribute="neighborhoodLibraryDevice" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="device_idx"/>
</form:form>
<form:form  modelAttribute="neighborhoodLibraryDevice" id="Device">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>

<!--
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<form:select class="selectmenu-search" style="width:200px" id="" path="">
				<option value="">운영장비를 선택하세요</option>
				<c:forEach var="i" varStatus="status" items="">
					<option value="">장비1</option>
				</c:forEach>
			</form:select>
		</fieldset>
	</div>
-->

	<div class="infodesk">
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
		<span>(페이지 ${paging.viewPage}/${paging.totalPageCount})</span>
		<div class="button">
<!-- 				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp; -->
<!-- 				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>&nbsp;&nbsp;						 -->
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>운영장비 등록</span></a>			
		</div>
	</div>
	<!-- 운영장비관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="50" />			
			<col width="120" />
			<col width="220" />
			<col width="170" />
			<col width="60" />
			<col width="80" />
			<col width="90" />
			<col width="80" />
			<col width="90" />
			<col width="90" />
			<col width="90" />
			<col width="90" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>장비코드</th>				
				<th>장비명</th>
				<th>장비장소</th>
				<th>장비위치</th>
				<th>사용유무</th>
				<th>등록날짜</th>
				<th>등록ID</th>
				<th>수정날짜</th>
				<th>수정ID</th>
				<th>사물함설정</th>
				<th>사물함보기</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${deviceList }">
				<tr>
					<td>${device.listRowNum - status.index}</td>
					<td>${i.device_code }</td>					
					<td>${i.device_name }</td>
					<td>${i.device_place }</td>
					<td>${i.device_area }</td>
					<td>
						<c:choose>
							<c:when test="${i.use_yn eq 'Y'}">
								사용
							</c:when>
							<c:otherwise>
								미사용
							</c:otherwise>
						</c:choose>					
					</td>				
					<td>
						<fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" />		
					</td>
					<td>${i.add_id }</td>
					<td>
						<c:choose>
							<c:when test="${i.modify_date ne null and i.modify_date ne ''}">
								<fmt:formatDate value="${i.modify_date}" pattern="yyyy.MM.dd" />
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>	
						</c:choose>						
					</td>
					<td>
						<c:choose>
							<c:when test="${i.modify_id ne null and i.modify_id ne ''}">
								${i.modify_id }
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>	
						</c:choose>								
					</td>
					<td>
						<c:choose>
							<c:when test="${i.device_add_yn eq 'Y' }">
								<a href="#" class="btn btn2" id="locker-detail" keyValue="${i.device_idx }">사물함정보</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn btn5" id="locker-edit" keyValue1="${i.device_idx }" keyValue2="${i.device_code }" keyValue3="${i.device_name }">사물함등록</a>								
							</c:otherwise>
						</c:choose>						
					</td>
					<td>
						<c:choose>
							<c:when test="${i.device_add_yn eq 'Y' }">						
								<a href="#" class="btn btn4" id="locker-index" keyValue1="${i.device_idx }" keyValue2="${i.device_name }">사물함보기</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn" id="" >사물함미등록</a>
							</c:otherwise>	
						</c:choose>
					</td>
					<td>						
						<a href="#" class="btn" id="dialog-modify" keyValue="${i.device_idx }">수정</a>											
						<a href="#" class="btn" id="delete-btn" keyValue1="${i.device_idx }" keyValue2="${i.device_name }">삭제</a>						
					</td>
				</tr>
			</c:forEach>
			<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="12">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value=""/>
	</jsp:include>
</form:form>

<div id="dialog-1" class="dialog-common" title="운영장비 등록"></div>
<div id="dialog-2" class="dialog-common" title="사물함 등록"></div>
<div id="dialog-3" class="dialog-common" title="사물함 보기"></div>
