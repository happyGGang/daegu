<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.board_tab_b {margin-bottom: 50px;}	
	.board_con_tab {display: inline-block; width: 100%; font-family: 'NotoKrR'; font-size: 15px;}
	.board_con_tab ul.no5 li {width: 20%;float:left;}
	.baard_con_tab ul li {float: left; margin-left: -1px;}
	.board_con_tab ul li a.on, .board_con_tab ul li a:hover {border: 1px solid #222; background: #fff; color: #222; font-weight: normal; font-family: 'NotoKrB'; z-index: 10;}
	.board_con_tab ul li a {position: relative;display: block;height: 53px;font-size: 15px;line-height: 53px;text-align: center;font-weight: 600px;color: #666;border: 1px solid #dfdfdf;background: #fff;}
	ul, li {list-style: none;}
	#cont_head {display: inline-block; padding-bottom: 35px; width: 100%; font-size:25px;}
	#cont_head h3 {font-weight:normal;}
</style>
<script>
$(function(){
	$('a#view').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('view');
		$('input#contest_idx').val($(this).attr('keyValue'));
		doGetLoad('edit.do', serializeCustom($('form#marathonApplicant')));
	});
	
	$('a#printCompleteDocument').on('click', function(e) {
		$('#dialog-2').load('certificate.do?homepage_id='+$(this).attr('keyValue')+'&contest_idx='+$(this).attr('keyValue2')+'&contest_type_idx='+$(this).attr('keyValue3')+'&applicant_idx='+$(this).attr('keyValue4'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		e.preventDefault();
	});
});
</script>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="marathonApplicant" action="index.do" method="GET" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="contest_idx"/>
	<form:hidden path="applicant_idx"/>
	<form:hidden path="selectedType"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<div id="cont_head" style="padding-bottom:0;">
		<h3 style="font-weight:bold;">참가신청 현황</h3>
	</div>
			
	<div class="infodesk">
		<table class="type1 center">
			<thead>
				<tr>
					<th>대회명</th>
					<th>참가종목</th>
					<th>달성률</th>
					<th>신청일</th>
					<th>상세 정보</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="now" value="<%=new java.util.Date()%>" />
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm" var="today"/>
				<c:forEach items="${marathonApplicantList}" varStatus="status" var="i">
					<tr>
						<td>
							${i.contest_name}
							<form:hidden path="contest_idx" value="${i.contest_idx}"/>
						</td>
						<td>${i.contest_type}(<fmt:formatNumber value="${i.page_count}" pattern="#,###"/>쪽)</td>
						<td>
							<fmt:formatNumber value="${i.read_page_count_total}" pattern="#,###"/> / <fmt:formatNumber value="${i.page_count}" pattern="#,###"/>
							(<fmt:formatNumber value="${(i.read_page_count_total / i.page_count)*100.0}" pattern="##.##"/>%)
							<c:if test="${i.process_status eq 1 && today > i.finish_day }">
								<a href="#" class="btn btn1" id="printCompleteDocument" keyValue="${i.homepage_id}" keyValue2="${i.contest_idx}" keyValue3="${i.contest_type_idx}" keyValue4="${i.applicant_idx}">인쇄</a>
							</c:if>
						</td>
						<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
						<td><a href="#" id="view" class="btn btn1" keyValue="${i.contest_idx}">보기</a></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(marathonApplicantList) < 1}">
					<tr>
						<td colspan="5">신청 내역이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#marathonApplicant"/>
	</jsp:include>
</form:form>

<div id="dialog-2" class="dialog-common" title="완주증서">
</div>