<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#lockerForm').submit();
	});


	$('a#dialog-add').on('click', function(e) {
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		if ( $(this).attr('keyValue') == 0 ) {
			alert('기본 설정을 선택해주세요.');
			return false;
		}

		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() + '&locker_pre_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&locker_idx=' + $(this).attr('keyValue') + '&locker_pre_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	<%--기본설정--%>
	$('a#check_pre').on('click', function(e) {
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		$('#dialog-2').load('/cms/module/locker/pre/index.do?homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		e.preventDefault();
	});

	$('a#delete-btn2').on('click', function(e) {
		if ( confirm('해당 사물함을 삭제 하시겠습니까?') ) {
			$('#hiddenForm #locker_idx').val($(this).attr('keyValue'));
			$('#hiddenForm #locker_pre_idx').val($(this).attr('keyValue2'));
			if(doAjaxPost($('#hiddenForm'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});

	$('a#excelDownload').on('click', function(event) {
		event.preventDefault();

		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}

		$('#lockerForm').attr('action','excelDownload.do').submit();
		$('#lockerForm').attr('action','save.do');
	});
	
	$('a#csvDownload').on('click', function(event) {
		event.preventDefault();
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}

		$('#lockerForm').attr('action','csvDownload.do').submit();
		$('#lockerForm').attr('action','save.do');
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#lockerForm').submit();
		}

		e.preventDefault();
	});

	$('select#locker_pre_idx_1').on('change', function(e) {
		if($(this).val() != '') {
			$('#lockerForm #locker_pre_idx').val($(this).val());
			$('#lockerForm').submit();
		}

		e.preventDefault();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="locker" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="locker_idx"/>
<form:hidden path="locker_pre_idx" id="locker_pre_idx"/>
</form:form>
<form:form  modelAttribute="locker" id="lockerForm" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>
<form:hidden path="locker_pre_idx"/>
<div class="search">
	<fieldset>
		<label class="blind">검색</label>
		<form:select class="selectmenu-search" style="width:200px" id="locker_pre_idx_1" path="locker_pre_idx">
			<option value="">기본설정을 선택하세요.</option>
			<c:forEach var="i" varStatus="status" items="${lockerPreList}">
				<option value="${i.locker_pre_idx}" <c:if test="${i.locker_pre_idx eq locker.locker_pre_idx }">selected="selected"</c:if>>${i.locker_pre_name}</option>
			</c:forEach>
		</form:select>
	</fieldset>
</div>

	<div class="infodesk">
		검색 결과 : 총 ${lockerCount}건
		<div class="button">
				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp;
				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>&nbsp;&nbsp;
			<c:if test="${authC}">
				<a href="" class="btn btn4 left" id="check_pre"><i class="fa fa-plus"></i><span>신청가능일 관리</span></a>
				<a href="" class="btn btn5 left" id="dialog-add" keyValue="${locker.locker_pre_idx}"><i class="fa fa-plus"></i><span>사물함 등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 사물함관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="200" />
			<col width="" />
			<col width="200" />
			<col width="150" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>사물함명</th>
				<th>설명</th>
				<th>상태</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${lockerList}">
				<tr>
					<td>${locker.listRowNum - status.index}</td>
					<td>${i.locker_name}</td>
					<td>${i.locker_desc}</td>
					<td>
						${i.status eq '1'? '비어있음' : '신청완료'}
					</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.locker_idx}" keyValue2="${locker.locker_pre_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn2" keyValue="${i.locker_idx}" keyValue2="${locker.locker_pre_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${lockerCount eq 0}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#lockerForm"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			상태 :
			<form:select path="status" cssClass="selectmenu">
				<form:option value="">=전체=</form:option>
				<form:option value="1">비어있음</form:option>
				<form:option value="2">신청완료</form:option>
			</form:select>
			사물함명 :
			<form:input path="search_text" cssClass="text" cssStyle="width:150px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div class="ui-state-highlight">
	* 홈페이지 사물함 신청 메뉴는 기본설정중 가장 최근에 등록한 설정이 적용됩니다.
</div>
<div id="dialog-1" class="dialog-common" title="사물함 관리"></div>
<div id="dialog-2" class="dialog-common" title="사물함 기본설정"></div>
