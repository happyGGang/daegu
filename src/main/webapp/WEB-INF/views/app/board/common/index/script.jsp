<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
	var $form = $('#board');

	<%-- 등록 --%>
	<c:choose>
	<c:when test="${boardManage.manage_idx == 563 or boardManage.manage_idx == 592}">
	$('a#board_edit_btn').on('click', function(e) {
		e.preventDefault();
		var url = 'edit.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
	</c:when>
	<c:otherwise>
	$('a#board_edit_btn').on('click', function(e) {
		e.preventDefault();
		var url = 'edit.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
	</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${boardManage.manage_idx == 521 or boardManage.manage_idx == 523}">
	<%-- 상세보기 --%>
	$('#board_tbody a').on('click', function(e) {
		e.preventDefault();
		if (!$(this).attr('keyValue2')) {
			$('#board_idx').val($(this).attr('keyValue'));
			var url = 'view.do';
			var formData = serializeCustom($form);
			doGetLoad(url, formData);
		} else {
			location.href = $(this).attr('keyValue2');
		}
	});

		<c:if test="${boardManage.manage_idx == 521 or boardManage.manage_idx == 523}">
		$('a#libSelect').on('click', function(e) {
		e.preventDefault();
		var url = 'index.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
		</c:if>
		</c:when>
		<c:otherwise>
	<%-- 상세보기 --%>
// 	$('#board_tbody a').on('click', function(e) {
// 		e.preventDefault();
// 		var is521 = $(this).attr('gbelib');
// 		if (is521) {
// 			doGetLoad($(this).attr('href'));
// 		} else {
// 			$('#board_idx').val($(this).attr('keyValue'));
// 			var url = 'view.do';
// 			var formData = serializeCustom($form);
// 			doGetLoad(url, formData);
// 		}
// 	});
		</c:otherwise>
	</c:choose>

	$('select#category1, select#category2, select#category3, select#category4, select#category5').on('change', function() {
		var url = 'index.do';
		$('#viewPage').attr('value', '1');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('select#sortField, select#sortType').on('change', function() {
		var url = 'index.do';
		$('#viewPage').attr('value', '1');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a#rowCountSelect').on('click', function() {
		var url = 'index.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a#monthSelect').on('click', function() {
		var planDate = $('#plan_year').val() + '-' + $('#plan_month').val();
		$('#plan_date').val(planDate);
		doGetLoad('index.do', serializeCustom($('#board')));
	});


	$('a#board_deleteRecovery_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		$('#board_mode').attr('value', 'admin');
		var url = '../boardDelete/index.do';

		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a#board_manage_btn').on('click', function(e) {
		e.preventDefault();
		var url = '../board/index.do';
		$('input#board_mode').val('admin');
		$('#viewPage').attr('value', '1');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});


	$('a#board_normal_btn').on('click', function(e) {
		e.preventDefault();
		var url = '../board/index.do';
		$('#viewPage').attr('value', '1');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	$('a#board_delete_btn').on('click', function(e) {
		e.preventDefault();
		var checkList = $('input[name=boardIdxArray]:checked').length;
		if (checkList < 1) {
			alert('선택된 게시물이 없습니다.');
			return false;
		}
		if(confirm('선택된 게시물을 완전 삭제 하시겠습니까?\n\n완전삭제된 게시물은 복구가 불가능하며 첨부파일도 함께 삭제 됩니다.')) {
    		$('#board').attr('action', 'drop.do');
    		doAjaxPost($('#board'));
    	}
	});

	<%-- 게시물 복구 --%>
	$('a#board_recovery_btn').on('click', function(e) {
		e.preventDefault();
		var checkList = $('input[name=boardIdxArray]:checked').length;
		if (checkList < 1) {
			alert('선택된 게시물이 없습니다.');
			return false;
		}
		if(confirm('게시물을 복구 하시겠습니까?')) {
    		$('#board').attr('action', 'recovery.do');
    		doAjaxPost($('#board'));
    	}
	});

	$('input#checkAll').on('click', function() {
		$('input[name=boardIdxArray]').prop('checked', $(this).is(':checked'));
	});

	$('input[name=boardIdxArray]').on('click', function() {
		$('input#checkAll').prop('checked', false);
	});

});
</script>