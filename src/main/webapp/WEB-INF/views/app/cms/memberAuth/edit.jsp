<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
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
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#memberAuth_edit'))) {
						alert('등록 되었습니다.');
						$(this).dialog('destroy');
						$('.dialog-common').remove();
						$('#memberAuthLayer').load('memberAuth.do?editMode=MODIFY&homepage_id=${memberAuth.homepage_id}');
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 750
	});
	
	$('input#member_id_list_all_2').on('click', function(e) {
		if($(this).prop('checked')) {
			$('input:checkbox.member_id_list_2').prop('checked', true);	
		} else {
			$('input:checkbox.member_id_list_2').prop('checked', false);
		}
	});
});
</script>
<form:form id="memberAuth_edit" modelAttribute="memberAuth" method="POST" action="save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<%-- <div class="search">
	<form>
		<fieldset>
			<label class="blind">검색</label>
			<select class="selectmenu" style="width:120px;">
				<option>사용자명</option>
				<option>사용자ID</option>
			</select>
			<input type="text" class="text" id="menu-tags"/>
			<button><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</form>
</div> --%>
<table class="type2">
	<tbody> 
		<tr>
			<th><input type="checkbox" id="member_id_list_all_2"/></th>
			<th>사용자ID</th>
			<th>사용자명</th>
			<th>사용자구분</th>
		</tr>
		<c:forEach var="i" varStatus="status" items="${memberList}">
		<tr> 
			<td>
				<form:checkbox path="member_id_list" value="${i.member_id}" cssClass="member_id_list_2"/>
			</td>
			<td>${i.member_id}</td>
			<td>${i.member_name}</td>
			<td>${i.member_type}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
<!-- <div class="dataTables_paginate">
	<a class="paginate_button previous disabled">이전</a>
	<span>
		<a class="paginate_button current">1</a>
		<a class="paginate_button">2</a>
	</span>
	<a class="paginate_button next">다음</a>
</div> -->
</form:form>