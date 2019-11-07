<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(function() {
	$('div#dialog-2.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > .ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#memberOrgaForm'))) {
						$(this).dialog('destroy');
						$('#memberLayer').load('memberOrga.do?homepage_id=${memberOrga.homepage_id}&orga_idx=${memberOrga.orga_idx}');
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
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 600
	});
	
	$('#checkAll').on('click', function() {
		$('[name="member_id_list"]').prop('checked', $(this).prop('checked'));
	});
	
	$('#member-search-btn').on('click', function() {
		$('#dialog-2').load('editMemberOrga.do?editMode=ADD&homepage_id=${memberOrga.homepage_id}&orga_idx=${memberOrga.orga_idx}&search_text='+encodeURIComponent($('#member-search_text').val()));
	});
	
});

</script>

<form:form id="memberOrgaForm" modelAttribute="memberOrga" action="saveMemberOrga.do" method="post" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode" />
	<form:hidden path="orga_idx" />

	<div class="search">
		<label class="blind">검색</label>
		<form:input id="member-search_text" path="search_text" type="text" class="text"/>
		<button id="member-search-btn"><i class="fa fa-search"></i><span>검색</span></button>
	</div>
	
	
	<table class="type2 center">
		<colgroup>
			<col width="50"/>
			<col width="*"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th ><input id="checkAll" type="checkbox"></th>
				<th>ID</th>
				<th>이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberList}" var="i">
				<tr>
					<td>
						<form:checkbox path="member_id_list" value="${i.member_id }"/>
					</td>
					<td class="left">${i.member_id}</td>
					<td class="left">${i.member_name}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</form:form>