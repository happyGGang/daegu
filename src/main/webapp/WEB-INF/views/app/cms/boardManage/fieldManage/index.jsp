<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true,
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"id" : 'fieldManage_save',
				"style" : "display:none",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#fieldManage'))) {
						$('#dialog-2').load('/cms/boardManage/fieldManage/index.do?manage_idx=${fieldManage.manage_idx}');
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-2').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1500,
		height: 800
	});

	$('.scroll thead th.edit-btn').append('<p style="width:59px"></p>');

	$('a#fieldManage_modify').on('click', function(e) {
		$('#fieldManageEditLayer').load('/cms/boardManage/fieldManage/edit.do?editMode=MODIFY&manage_idx=${fieldManage.manage_idx}&board_column=' + $(this).attr('keyValue'), function() {
			$('button#fieldManage_save').show();
		});

		e.preventDefault();
	});

	$('a#fieldManage_delete').on('click', function(e) {
		if(confirm('컬럼을 삭제 하시겠습니까?')) {
			$.ajax({
				url : '/cms/boardManage/fieldManage/save.do?editMode=DELETE&manage_idx=${fieldManage.manage_idx}&board_column=' + $(this).attr('keyValue'),
				async : false,
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						$('#dialog-2').load('/cms/boardManage/fieldManage/index.do?manage_idx=${fieldManage.manage_idx}');
					}
				}
			});
		}
		e.preventDefault();
	});

	$('#fieldManageEditLayer').load('/cms/boardManage/fieldManage/edit.do?editMode=FIRST&manage_idx=${fieldManage.manage_idx}');
});
</script>
<div class="scroll" style="height:400px">
	<table class="type1 center">
		<thead>
			<tr>
				<th rowspan="2" class="ceGroup">순번</th>
				<th colspan="5" style="border-bottom-color:#ced8da">공통</th>
				<th colspan="5" style="border-bottom-color:#ced8da">글목록</th>
				<th colspan="5" style="border-bottom-color:#ced8da">글등록</th>
				<th colspan="2" style="border-bottom-color:#ced8da">검색</th>
				<th class="edit-btn"></th>
			</tr>
			<tr>
				<th>컬럼</th>
				<th>기본컬럼명</th>
				<th>항목명</th>
				<th>컬럼타입</th>
				<th>코드맵핑</th>
				<th>넓이</th>
				<th>최대표시길이</th>
				<th>순서</th>
				<th>사용</th>
				<th>본문링크</th>
				<th>항목넓이</th>
				<th>항목높이</th>
				<th>필수입력</th>
				<th>순서</th>
				<th>답변전용</th>
				<th>순서</th>
				<th>사용</th>
				<th class="edit-btn"></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="i" varStatus="status" items="${fieldManageList}">
			<tr>
				<td>${status.count}</td>
				<td>${i.board_column}</td>
				<td>${i.board_column_nm}</td>
				<td>${i.board_content}</td>
				<td>${i.column_type}</td>
				<td>${i.code_mapping}</td>
				<td>${i.list_width}</td>
				<td>${i.list_maxwidth}</td>
				<td>${i.list_seq}</td>
				<td>${i.list_use_yn}</td>
				<td>${i.content_link_yn}</td>
				<td>${i.write_width}</td>
				<td>${i.write_height}</td>
				<td>${i.write_req_cont}</td>
				<td>${i.write_seq}</td>
				<td>${i.admin_only}</td>
				<td>${i.search_seq}</td>
				<td>${i.search_use_yn}</td>
				<td class="edit-btn">
					<div>
						<a href="" class="btn m" id="fieldManage_modify" keyValue="${i.board_column}">수정</a>
						<a href="" class="btn d" id="fieldManage_delete" keyValue="${i.board_column}">삭제</a>
					</div>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(fieldManageList) < 1}">
			<tr>
				<td style="background:#f8fafb;" colspan="19">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>

<div class="column-edit" id="fieldManageEditLayer">
</div>