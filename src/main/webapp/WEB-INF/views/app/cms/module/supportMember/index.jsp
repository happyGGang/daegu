<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	var $form = $('form#supportMember');
	
	$('#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.modify-btn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&support_member_idx='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('.delete-btn').on('click', function(e) {
		e.preventDefault();
		if(confirm('삭제하시겠습니까?')) {
			$form.attr('action', 'save.do');
			$form.attr('method', 'POST');
			$('#editMode').val('DELETE');
			$('#support_member_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	<%--그룹설정--%>
	$('a.grouping').on('click', function(e) {
		e.preventDefault();
		$('#dialog-2').load('grouping.do?member_id=' + $(this).attr('keyValue') + '&support_member_idx=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
	});
	
	$('#allCheck').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('.member-check').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('.member-check').prop('checked', false);
		}
	});
	
	$('#check-delete').on('click', function(e) {
		e.preventDefault();
		if(confirm('선택 항목들을 삭제하시겠습니까?')) {
			$form.attr('action', 'save.do');
			$form.attr('method', 'POST');
			$('#editMode').val('DELETE_CHECK');
			if(doAjaxPost($form)) {
				location.reload();
			}
		}
	});
	
	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#supportMember').serialize());
	});

	$('a#excelDownload').on('click', function(e) {
		e.preventDefault();
		doGetLoad('excelDownload.do', $('form#supportMember').serialize());
	});
});

function excelUpload() {
	modal_layer_add('dialog_layer');

	$.ajax({
		url: 'excelUpload.do',
		method: 'POST',
		success: function(html){
			$('#dialog_layer').html(html);
		},error: function(html){
		}
	});

	$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
		resizable: false,
		modal: true,
		title: '228회원관리 엑셀등록',
		open: function(){
			$('.ui-widget-overlay').addClass('custom-overlay');
		},
		close: function(){
		},
		buttons: [
			{
				text : '등록하기',
				'class' : 'btn btn1',
				click : function() {
					excelUploadSave();
				}
			},
			{
				text: "닫기",
				"class": 'btn btn_round btn_gray',
				click: function() {
					$(this).dialog('close');
				}
			}
		]
	});

	$("#dialog_layer").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 210
	});
}
</script>
<form:form modelAttribute="supportMember" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="support_member_idx"/>

<div class="infodesk">
	검색 결과 : 총 ${paging.totalDataCount}건
	<div class="button">
		<a href="javascript:void(0)" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀등록양식</span></a>
		<a href="javascript:void(0)" id="excelUpload" class="btn btn1" onclick="excelUpload();"><i class="fa fa-plus"></i><span>엑셀등록</span></a>
		<a href="javascript:void(0)" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
	</div>
	<form:select path="rowCount" cssClass="selectmenu">
		<form:option value="10">10개씩보기</form:option>
		<form:option value="20">20개씩보기</form:option>
		<form:option value="30">30개씩보기</form:option>
		<form:option value="50">50개씩보기</form:option>
		<form:option value="100">100개씩보기</form:option>
		<form:option value="${paging.totalDataCount}">전체 보기</form:option>
	</form:select>
</div>
<div>
	<table class="type1 center">
		<colgroup>
			<col width="5%" />
			<col width="10%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col />
			<col width="12%"/>
			<col width="12%"/>
			<col width="15%"/>
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>그룹</th>
				<th>최근접속일</th>
				<th>가입일</th>
				<th>보기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${supportMemberList}" var="i" varStatus="status">
			<tr>
				<td>
					<form:checkbox path="support_member_arr" cssClass="member-check" value="${i.support_member_idx}"/>
				</td>
				<td class="num">${paging.listRowNum - status.index}</td>
				<td>${i.member_id }</td>
				<td>${i.school_name}</td>
				<td>
					<c:choose>
						<c:when test="${i.auth_group eq '1'}">총관리자</c:when>
						<c:when test="${i.auth_group eq '2'}">비회원</c:when>
						<c:when test="${i.auth_group eq '3'}">학교기관</c:when>
						<c:when test="${i.auth_group eq '4'}">도서선정위원</c:when>
					</c:choose>
				</td>
				<td><fmt:formatDate value="${i.last_connect}" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
				<td>
					<a href="#" class="btn modify-btn" keyValue="${i.support_member_idx}">수정</a>
					<a href="#" class="btn delete-btn" keyValue="${i.support_member_idx}">삭제</a>
					<a href="#" class="btn btn3 grouping" keyValue="${i.member_id}" keyValue2="${i.support_member_idx}">그룹설정</a>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(supportMemberList) < 1}">
			<tr>
				<td colspan="8">등록된 회원정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<div class="button">
		<a href="#" id="allCheck" class="btn" keyValue="N">전체 선택/해제</a>
		<a href="#" id="check-delete" class="btn btn3">선택 회원삭제</a>
	</div>
	<br>
	<div class="ui-state-highlight">
		<em>* 일괄 회원 등록을 하시기 위해서는 엑셀등록양식을 다운받으시고 양식에 맞춰 데이터를 입력해주세요.</em><br/>
		<em>* 엑셀등록 양식에 맞게 데이터를 입력하신뒤에는 엑셀등록 버튼으로 한번에 회원 등록이 가능하십니다.</em><br/>
		<em>* 엑셀등록시 학교기관으로 그룹이 자동으로 지정이 됩니다.</em><br>
	</div>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#supportMember"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="member_id">아이디</form:option>
				<form:option value="school_name">학교명</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="회원관리 "></div>
<div id="dialog-2" class="dialog-common" title="그룹설정"></div>