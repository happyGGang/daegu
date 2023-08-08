<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('a#allChk').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('input[name="library_check_arr"]').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('input[name="library_check_arr"]').prop('checked', false);
		}
	});
	
	$('a#delete-chk').on('click', function(e) {
		e.preventDefault();
		if(confirm('선택한 장서점검기들을 삭제하시겠습니까?')) {
			$('#editMode').val('DELETE_ALL');
			$('form#libraryCheck').attr('action', 'save.do');
			$('form#libraryCheck').attr('method', 'POST');
			if(doAjaxPost($('form#libraryCheck'))) {
				location.reload();
			}
		}
	});
	
	$('a.request-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&library_check_idx='+$(this).attr('keyValue') + '&library_check_number='+$(this).attr('keyValue2') + '&request_status='+$(this).attr('keyValue3');
		doGetLoad('loanEdit.do', formData);
	});
	
	$('select#loan_status').on('change', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#libraryCheck').serialize());
	});
	
	$('select#content').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#libraryCheck').serialize());
	});
	
});

function view(library_check_idx) {
		var ajaxData = {
				'library_check_idx' : library_check_idx
		};
		
		modal_layer_add('dialog_layer');
		
		$.ajax({
			type: "POST",
			url: "view.do",
			data: ajaxData,
			success: function(html){
				$('#dialog_layer').html(html);
			},error: function(html){
	 			alert('장서점검기의 정보를 불러오기에 실패 하셨습니다.\n관리자에게 문의해 주세요.');
			}
		});
		
		$('#dialog_layer').dialog({ //모달창 기본 스크립트 선언
			resizable: false,
			modal: true,
			title: '장서점검기 정보 상세보기',
			open: function(){
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function(){
			},
			buttons: [
				{
					text: "닫기",
					"class": 'btn btn_round btn_gray',
					click: function() {
						$(this).dialog('close');
					}
				}
			]
		});

		$("#dialog_layer").dialog({
			width: 400,
			height: 285
		});
}

function libraryCheckloanList(library_check_idx, library_check_number) {
	if(confirm('장서점검기' + library_check_number + '의 예약현황을 확인하시겠습니까?')) {
		var ajaxData = {
				'library_check_idx' : library_check_idx,
				'menu_idx' : 148
		};
		
		modal_layer_add('dialog_layer');
		
		$.ajax({
			type: "POST",
			url: "libraryCheckloanList.do",
			data: ajaxData,
			success: function(html){
				$('#dialog_layer').html(html);
			},error: function(html){
	 			alert('예약현황 불러오기에 실패 하셨습니다.\n관리자에게 문의해 주세요.');
			}
		});
		
		$('#dialog_layer').dialog({
			resizable: false,
			modal: true,
			title: '장서점검기'+ library_check_number +' 예약 리스트',
			open: function(){
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function(){
			},
			buttons: [
				{
					text: "닫기",
					"class": 'btn btn_round btn_gray',
					click: function() {
						$(this).dialog('close');
					}
				}
			]
		});

		$("#dialog_layer").dialog({
			width: 400,
			height: 285
		});
	}
}
</script>
<link rel="stylesheet" href="/resources/common/css/pictureBook.css" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="libraryCheck" action="index.do" method="GET">
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<div class="infodesk">
	<form:select path="content" cssClass="selectmenu">
		<form:option value="">전체보기</form:option>
		<form:option value="DT-970">DT-970</form:option>
		<form:option value="싱클라운 북체커">싱클라운 북체커</form:option>
	</form:select>
</div>
<div>
	<c:forEach items="${libraryCheckList}" var="i">
	<div class="group-box">
	<div class="img-box">
	<a href="javascript:void(0)" class="view-btn" keyValue="${i.library_check_idx}" onclick="view('${i.library_check_idx}');"></span>
	<c:choose>
		<c:when test="${not empty i.server_file_name}">
		<img alt="장서점검기 이미지" src="${getContextPath}/data/libraryCheck/${i.server_file_name}">
		</c:when>
		<c:otherwise>
		<img src="/resources/common/img/noimg-gall.png" alt="no-image">
		</c:otherwise>
	</c:choose>
	</a>
	</div>
	<div class="content-box">
		<div class="subject">
			<c:choose>
				<c:when test="${i.request_status == 6}">
					<a href="javascript:void(0)" class="alert-btn" title="수리중인 기기입니다." onclick="alert('현재 수리중으로 예약이 불가능한 기기입니다.');"><h4>장서점검기${i.library_check_number}</h4></a>
				</c:when>
				<c:otherwise>
				   <a href="javascript:void(0)" class="loanView-btn" title="예약확인하기" onclick="libraryCheckloanList('${i.library_check_idx}', '${i.library_check_number}');"><h4>장서점검기${i.library_check_number}</h4></a>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<ul class="pub_info">
			</ul>
			<div class="book-desc">${i.content}</div>
		</div>
	</div>
	<div class="btn-box">
		<c:choose>
			<c:when test="${i.request_status == 6}">
				<a href="javascript:void(0)">수리중</a>
			</c:when>
			<c:otherwise>
				<a href="javascript:void(0)" class="request-btn loan" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="1">예약하기</a>
			</c:otherwise>
		</c:choose>

	</div>
	</div>
	</c:forEach>
	<c:if test="${fn:length(libraryCheckList) < 1}">
	  <div align="center">
	    <h3>등록된 장서점검기가 없습니다.</h3>
	  </div>
	</c:if>
</div>	
<c:if test="${member.admin or loginSupport.auth_group eq '1'}">
	<a href="javascript:void(0)" class="btn" id="allChk" keyValue="N">전체 선택/해제</a> 
	<a href="javascript:void(0)" class="btn" id="delete-chk">선택 게시글 삭제</a>
</c:if>
</form:form>