<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		var checkboxData = $('input:checkbox.homepage_id_list_1:checked').map(function() {
			return $(this).val();
		}).get();
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${memberAuth.homepage_id}', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('input#member_id_all').on('click', function(e) {
		if($(this).prop('checked')) {
			$('input:checkbox.member_id_list').prop('checked', true);	
		} else {
			$('input:checkbox.member_id_list').prop('checked', false);
		}
	});
	
	$('a#delete_btn').on('click', function(e) {
		if(confirm('삭제 하시겠습니까?')) {
			$.ajax({
				url : 'save.do',
				async : false,
				data : serializeObject($('#memberAuth')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						$('.dialog-common').remove();
						alert(data.result);
						$('#memberAuthLayer').load('memberAuth.do?editMode=MODIFY&homepage_id=${memberAuth.homepage_id}');
					}
				}
			});
		}
		
		e.preventDefault();
	});
});	
</script> 
<div id="editDisable" class="disableBox">
	<c:if test="${memberAuth.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<form:form modelAttribute="memberAuth" action="save.do">
	<form:hidden path="homepage_id"/>
	<input type="hidden" name="editMode" value="DELETE" />
	<div class="infodesk">
		검색 결과 : ${fn:length(memberList)}건, 홈페이지 ID : ${memberAuth.homepage_id}
		<div class="button btn-group inline">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>사용자 등록</span></a>
			<a href="" class="btn" id="delete_btn"><i class="fa fa-minus"></i><span>삭제</span></a>
		</div>
	</div>
	<div class="table-wrap">
		<div class="table-scroll">
			<table class="type1 center">
				<thead>
					<tr>
						<th width="22">
							<input type="checkbox" id="member_id_all"/>
						</th>
						<th width="80">사용자ID</th>
						<th width="120">사용자명</th>
						<th>사용자구분</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(memberList) < 1}">
					<tr style="height:100%">
						<td style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="i" varStatus="status" items="${memberList}">
					<tr>
						<th width="22">
							<form:checkbox path="member_id_list" value="${i.member_id}" cssClass="member_id_list"/>
						</th>
						<td width="80">${i.member_id}</td>
						<td width="120">${i.member_name}</td>
						<td>${i.member_type}</td>
					</tr>
				</c:forEach>						
				</tbody>
			</table>
		</div>
	</div>
	</form:form>
	
	<div id="dialog-1" class="dialog-common" title="사용자 정보">
	</div>
</div>