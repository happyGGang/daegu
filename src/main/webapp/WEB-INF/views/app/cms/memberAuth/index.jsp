<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	$('a#delete').on('click', function(e) {
		if(confirm('해당 사용자(' + $(this).attr('keyValue') + ')를 정보를 삭제 하시겠습니까?')) {
			$('input#editMode_index').val('DELETE');
			$('input#member_id_index').val($(this).attr('keyValue'));
			if(doAjaxPost($('#member_index'))) {
				location.reload();
			}	
		}
		
		e.preventDefault();
	});
	
	$('input#homepage_id_all').on('click', function(e) {
		if($(this).prop('checked')) {
			$('input:checkbox.homepage_id_list_1').prop('checked', true);	
		} else {
			$('input:checkbox.homepage_id_list_1').prop('checked', false);
		}
	});
	
	$('button#homepage_btn').on('click', function(e) {
		$('.dialog-common').remove();
		$('#memberAuthLayer').load('memberAuth.do?editMode=MODIFY&homepage_id=' + $(this).val());
		
		e.preventDefault();
	});
	
	$('#memberAuthLayer').load('memberAuth.do?editMode=FIRST');
});	 
</script>
<form:form id="memberAuth_index" modelAttribute="memberAuth">
<div class="wrapper wrapper-white">
	<div class="column ban">
		<div class="areaL">
			<div class="infodesk">
				검색 결과 : ${fn:length(homepageList)}건
			</div>
			<div class="table-wrap">
				<div class="table-scroll">
					<table class="type1 center">
						<thead>
							<tr>
								<th width="80">홈페이지ID</th>
								<th width="200">홈페이지명</th>
								<th width="300">도메인</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="i" varStatus="status" items="${homepageList}">
							<tr>
								<td width="80">${i.homepage_id}</td>
								<td width="200">${i.homepage_name}</td>
								<td width="300">${i.domain}</td>
								<td><button class="btn" id="homepage_btn" value="${i.homepage_id}">선택</button></td>
							</tr>
						</c:forEach>
						</tbody> 
					</table>
				</div> 
			</div>
		</div>
		<div id="memberAuthLayer" class="areaR">
			
		</div>
	</div>
</div>
</form:form>