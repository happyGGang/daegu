<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true, 
	    open: function() {
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function() {
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
		    {
// 		    	text: "미리보기",
// 				"class": 'btn btn3',
// 				click: function() {
// 					alert('미리보기');
// 				}
// 		    },{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	}); 
	
	$("#dialog_BOARD").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 800
	});
	
	$('a#boardManageUse').on('click', function(e) {
		$('input#manage_idx').val($(this).attr('keyValue'));
		$('td#edit_manageIdx').html($(this).attr('keyValue'));
		$('td#edit_boardName').html($(this).attr('boardName'));
		$('td#edit_boardType').html($(this).attr('boardType'));
		$("#dialog_BOARD").dialog('destroy');
		e.preventDefault();
	});
});	
</script>
<form:form modelAttribute="boardManage" action="save_board.do" method="POST" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<!-- <div class="search"> -->
<!-- 	<label>게시판명</label> -->
<!-- 	<input type="text" class="text"/> -->
<!-- 	<button>검색</button> -->
<!-- </div> -->
<table class="type2 menuType-data">
	<colgroup>
		<col width="50"/>
		<col width="*"/>
		<col width="*"/>
		<col width="80"/>
	</colgroup>
	<thead>
		<tr>
			<th>게시판 번호</th>
			<th>게시판명</th>
			<th>게시판 유형</th>
			<th>기능</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="i" varStatus="status" items="${boardManageList}">
		<tr>
			<td>${i.manage_idx}</td>
			<td>${i.board_name}</td>
			<td>${i.board_type}</td>
			<td>
				<a href="#" class="btn" id="boardManageUse" keyValue="${i.manage_idx}" boardName="${i.board_name}" boardType="${i.board_type}">사용</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</form:form>