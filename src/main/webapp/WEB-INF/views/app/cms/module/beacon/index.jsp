<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD&lib_code='+$('#lib_code_1').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});
	$('a.modify-btn').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&tid=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});
	$('select#lib_code_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#lib_code_1').val($(this).val());
			$('#beaconListForm').submit();
		}

		e.preventDefault();
	});

	$('#rowCount').change(function(e) {
		$('input#viewPage').val('1');
		$('#beaconListForm').submit();
	});

	$('a.delete-btn').on('click', function(e) {
		e.preventDefault();
		if (confirm('선택한 비콘을 삭제하시겠습니까?')) {
			$('#beaconListForm').attr('action', 'save.do');
			$('input#indexEditMode').val('DELETE');
			$('input#indexTid').val($(this).attr('keyValue'));
			if (doAjaxPost($('#beaconListForm'))) {
				$('input#indexEditMode').val('');
				$('input#indexTid').val('');
				location.reload();
			}
		}
	});
});
</script>
<form:form id="beaconListForm"  modelAttribute="beacon" action="index.do">
<form:hidden path="editMode" id="indexEditMode"/>
<form:hidden path="tid" id="indexTid"/>
		<form:hidden id="lib_code_1" path="lib_code"/>
	<c:if test="${!member.admin}">
	</c:if>
	<c:if test="${member.admin}">
<!-- 		<div class="search"> -->
<!-- 			<fieldset> -->
<!-- 				<label class="blind">검색</label> -->
<%-- 				<form:select class="selectmenu-search" style="width:250px" id="lib_code_1" path="lib_code"> --%>
<%-- 					<form:option value="admin" label="전체"/> --%>
<%-- 					<c:forEach var="i" varStatus="status" items="${homepageList}"> --%>
<%-- 						<option value="${i.homepage_code}" <c:if test="${(i.homepage_code ne null) and (i.homepage_code eq beacon.lib_code) }">selected="selected"</c:if>>${i.homepage_name}</option> --%>
<%-- 					</c:forEach> --%>
<%-- 				</form:select> --%>
<!-- 			</fieldset> -->
<!-- 		</div> -->
	</c:if>
	<div class="infodesk">
		검색 결과 : 총 ${beaconListCount}건
		<form:select path="rowCount" class="selectmenu" style="width:100px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="${beaconListCount}">전체 보기</form:option>
		</form:select>
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="200" />
			<col width="200" />
			<col width="100" />
			<col width="100" />
			<col width="" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>도서관</th>
				<th>비콘의 실별</th>
				<th>MAJOR</th>
				<th>MINOR</th>
				<th>내용</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${beaconList}">
				<tr>
					<td class="num">${beacon.listRowNum - status.index}</td>
					<td>${i.lib_name}</td>
					<td>${i.place_info}</td>
					<td>${i.major}</td>
					<td>${i.minor}</td>
					<td>${i.content}</td>
					<td>
						<c:if test="${i.lib_code eq fn:substring(beacon.lib_code,0,8) or member.admin }">
						<c:if test="${authU}">
							<a class="btn modify-btn" keyValue="${i.tid}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a class="btn delete-btn" keyValue="${i.tid}">삭제</a>
						</c:if>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(beaconList) < 1}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#beaconListForm"/>
	</jsp:include>

 	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="CONTENT">내용</form:option>
				<form:option value="MAJOR">MAJOR</form:option>
				<form:option value="MINOR">MINOR</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="비콘 정보"></div>
