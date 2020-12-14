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
	<c:if test="${ing eq true}">
		<c:forEach begin="0" end="${fn:length(marathonTypeList) - 1}" var="i">
			$('ul#typeList').append("<li><a href='#' id=type${i + 1}>${marathonTypeList[i].contest_type}</a></li>");
			
			$('a#type${i + 1}').on('click', function(e) {
				e.preventDefault();
				$('#viewPage').val(1);
				$('input#contest_type').val($('a#type${i + 1}').text());
				$('input#selectedType').val('type${i + 1}');
				doGetLoad('index.do', serializeCustom($('form#marathonApplicant')));
			});
		</c:forEach>
	</c:if>
	
	$('a#type0').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		$('input#contest_type').val('');
		$('input#selectedType').val('');
		doGetLoad('index.do', serializeCustom($('form#marathonApplicant')));
	});
	
	<c:choose>
		<c:when test="${marathonApplicant.selectedType == 'type1'}">
			$('a#type1').attr({
				"class" : "on"
			});
		</c:when>
		<c:when test="${marathonApplicant.selectedType == 'type2'}">
			$('a#type2').attr({
				"class" : "on"
			});
		</c:when>
		<c:when test="${marathonApplicant.selectedType == 'type3'}">
			$('a#type3').attr({
				"class" : "on"
			});
		</c:when>
		<c:when test="${marathonApplicant.selectedType == 'type4'}">
			$('a#type4').attr({
				"class" : "on"
			});
		</c:when>
		<c:when test="${marathonApplicant.selectedType == '' || marathonApplicant.selectedType == null}">
			$('a#type0').attr({
				"class" : "on"
			});
		</c:when>
	</c:choose>
	
	$('button#my-btn').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('view');
		doGetLoad('edit.do', serializeCustom($('form#marathonApplicant')));
	});
});
</script>
<form:form modelAttribute="marathonApplicant" action="index.do" method="GET" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="contest_type"/>
	<form:hidden path="applicant_idx"/>
	<form:hidden path="selectedType"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<div id="cont_head">
		<h3>참가신청 현황</h3>
	</div>
	<c:choose>
		<c:when test="${ing eq true}">
			<div class="board_con_tab board_tab_b">
				<ul class="no5" id="typeList">
					<li><a href="#" id="type0">전체</a></li>
				</ul>
			</div>
			
			<div class="infodesk">
				<table class="type1 center">
					<thead>
						<tr>
							<th>이름</th>
							<th>참가종목</th>
							<th>달성률</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${marathonApplicantList}" varStatus="status" var="i">
							<tr>
								<td>
									<c:set var="member_name" value="${fn:substring(i.member_name, 0, 1)}"/>
									${member_name}**
									<c:remove var="member_name"/>
								</td>
								<td>${i.contest_type}(<fmt:formatNumber value="${i.page_count}" pattern="#,###"/>쪽)</td>
								<td>
									<fmt:formatNumber value="${i.read_page_count_total}" pattern="#,###"/> / <fmt:formatNumber value="${i.page_count}" pattern="#,###"/>
									(<fmt:formatNumber value="${(i.read_page_count_total / i.page_count)*100.0}" pattern="##.##"/>%)
								</td>
								<td><fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(marathonApplicantList) < 1}">
							<tr>
								<td colspan="4">조회된 참가자가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="button bbs-btn left">
				<button id="my-btn" class="btn btn5" title="내 신청 정보">내 신청 정보</button>
			</div>			
			<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
				<jsp:param name="formId" value="#marathonApplicant"/>
			</jsp:include>
		</c:when>
		<c:otherwise>
			<h3>독서마라톤대회가 없습니다.</h3>
		</c:otherwise>
	</c:choose>
</form:form>