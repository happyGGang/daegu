<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
$(function() {
	$('#dialog-2.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	        $('button.cancel-btn').focus();
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "담당자 삭제",
				"class": 'btn btn5',
				click: function() {
					if ( confirm('해당 업무의 담당자를 정말 삭제하시겠습니까?') ) {
						$('#manageForm #editMode').val('DELETE');
						if ( doAjaxPost($('#manageForm')) ) {
							location.reload();
						}
					}
					$(this).dialog('destroy');
				}
			}, {
				text: "취소",
				"class": 'btn cancel-btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 450,
		height: 500
	});
	
	$('a.select-btn').on('click', function(e) {
		$('#manageForm #member_id').val($(this).attr('keyValue'));
		if ( doAjaxPost($('#manageForm')) ) {
			location.reload();
		}
	});
	
});

</script>
<form:form id="manageForm" modelAttribute="taskManage" method="post" action="saveManager.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="task_idx"/>
	<form:hidden path="member_id"/>
	<form:hidden path="manage_type"/>
	<form:hidden path="editMode" value="ADD"/>
</form:form>									
	<table class="type1 center">
		<colgroup>
			<col width="50" />
	       	<col width="130" />
	       	<col width="130" />
	       	<col width="60"/>
       	</colgroup>
       	<thead>
       		<tr>
       			<th>번호</th>
       			<th>사용자 ID</th>
       			<th>사용자 명</th>
       			<th>기능</th>
       		</tr>
       	</thead>
       	<tbody>
       		<c:choose>
       			<c:when test="${fn:length(memberList) > 0}">
       				<c:forEach items="${memberList}" var="i" varStatus="status">
	       				<tr>
	       					<td>${status.count}</td>
				         	<td>${i.member_id}</td>
				         	<td>${i.member_name}</td>
				         	<td><a class="btn btn1 select-btn" keyValue="${i.member_id}">선택</a></td>
				        </tr>
       				</c:forEach>
       			</c:when>
       			<c:otherwise>
       				<tr>
			         	<td colspan="4">조회된 정보가 없습니다.</td>
			        </tr>
       			</c:otherwise>
       		</c:choose>
		</tbody>
	</table>
