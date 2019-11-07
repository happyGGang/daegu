<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/support/index.do';
		var formData = serializeParameter(['menu_idx']);
		if($('#pageType').val() == 'ajax') {
			$('#tabCon1').load('/${homepage.context_path}/module/support/index.do?menu_idx=' + $('#menu_idx').val()+'&pageType=ajax');
		} else {
			doGetLoad(url, formData);	
		}
	});
});
</script>
<form:form modelAttribute="support" id="rsupport_result" action="result.do" method="post">
<form:hidden path="editMode"/>
<form:hidden path="plan_date" value="${fn:substring(calendarManage.start_date,0,7)}"/>
<form:hidden path="homepage_id"/>
<form:hidden path="seq"/>
<form:hidden path="menu_idx"/>
<form:hidden path="pageType"/>
<em><strong>신청내역</strong></em>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>신청기관명</th>
			<td>${support.req_name}</td>
		</tr>
		<tr>
			<th>신청자성명</th>
			<td>${support.requer_name}</td>
		</tr>
		<tr>
			<th>신청자휴대폰</th>
			<td>${support.requer_tel}</td>
		</tr>
		<tr>
			<th>지원희망일자</th>
			<td>${support.hope_req_dt}</td>			
		</tr>
		<tr>
			<th>*제목</th>
			<td>${support.req_title}</td>
		</tr>
		<tr>
			<th>신청내용</th>
			<td>${support.req_content}</td>
		</tr>		
	</tbody>
</table>
<br/>
<em><strong>현장지원결과등록</strong></em>
<table class="type2">
	<colgroup>
		<col width="140"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>*지원구분</th>
			<td>
				<c:if test="${support.support_div eq '1' }">
					방문지원				
				</c:if>
				<c:if test="${support.support_div eq '2' }">
					원격지원
				</c:if>
				<c:if test="${support.support_div eq '3' }">
					전화지원
				</c:if>
			</td>
		</tr>
		<tr>
			<th>*지원자</th>
			<td>${support.supporter }</td>			
		</tr>
		<tr>
			<th>협력업체</th>
			<td>${support.subcontractor }</td>
		</tr>
		<tr>
			<th>*지원내용</th>
			<td>${support.support_content }</td>
		</tr>		
	</tbody>
</table>
</form:form>
<div class="txt-right">	
	<button id="cancel-btn" class="btn btn5">목록으로</button>
</div>