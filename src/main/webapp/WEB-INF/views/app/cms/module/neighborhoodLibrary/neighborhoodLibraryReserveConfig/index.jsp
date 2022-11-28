<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(function() {
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});	
		e.preventDefault();		
	});
	
	$('a#reserveConfig-edit').on('click', function(e) {
		$('#dialog-1').load('/cms/module/neighborhoodLibraryReserveConfig/edit.do?editMode=MODIFY' + 
				'&reserve_config_idx=' + $(this).attr('keyValue1') +
				'&reserve_start_time=' + $(this).attr('keyValue2') +
				'&reserve_end_time=' + $(this).attr('keyValue3') +
				'&take_term=' + $(this).attr('keyValue4') +
				'&tomorrow_end_day_yn=' + $(this).attr('keyValue5') +
				'&expire_date_cnt=' + $(this).attr('keyValue6'),
				function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		e.preventDefault();
	});
});
</script>

<form:form  modelAttribute="neighborhoodLibraryReserveConfig" id="reserveConfig">
	<form:hidden path="reserve_start_time"/>
	<form:hidden path="reserve_end_time"/>
	<div class="infodesk">
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
		<span>(페이지 ${paging.viewPage}/${paging.totalPageCount})</span>
		<div class="button">
<!-- 				<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>&nbsp;&nbsp; -->
<!-- 				<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>&nbsp;&nbsp;						 -->				
			<c:if test="${fn:length(reserveConfigList) <= 0 }">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>예약설정 등록</span></a>
			</c:if>							
		</div>
	</div>
	<!-- 운영장비관리 table -->
	<table class="type1 center">
		<colgroup>
<%-- 			<col width="30" /> --%>
			<col width="30" />
			<col width="30" />
			<col width="40" />
			<col width="30" />
			<col width="30" />
			<col width="30" />
			<col width="30" />
			<col width="30" />
			<col width="30" />
			<col width="30" />
		</colgroup>
		<thead>
			<tr>
<!-- 				<th>번호</th> -->
				<th>예약시작시간</th>				
				<th>예약종료시간</th>
				<th>다음날예약종료여부</th>
				<th>취거기간</th>
				<th>예약만기일수</th>
				<th>등록날짜</th>
				<th>등록ID</th>
				<th>수정날짜</th>
				<th>수정ID</th>
				<th>기능</th>				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${reserveConfigList}">
				<tr>
<%-- 					<td>${reserveConfig.listRowNum - status.index}</td> --%>
					<td>${fn:substring(i.reserve_start_time, 0, 2)} : ${fn:substring(i.reserve_start_time, 2,4 )}</td>					
					<td>${fn:substring(i.reserve_end_time, 0, 2)} : ${fn:substring(i.reserve_end_time, 2, 4)}</td>
					<td>
						<c:choose>
							<c:when test="${i.tomorrow_end_day_yn eq 'Y'}">
								사용								
							</c:when>
							<c:otherwise>
								미사용
							</c:otherwise>
						</c:choose>
					</td>
					<td>${i.take_term }</td>
					<td>${i.expire_date_cnt }</td>
					<td>
						<fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" />
					</td>
					<td>${i.add_id}</td>
					<td>
						<c:choose>
							<c:when test="${(i.modify_date ne null) and (i.modify_date ne '' )}">
								<fmt:formatDate value="${i.modify_date}" pattern="yyyy.MM.dd" />
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>						
					</td>
					<td>
						<c:choose>
							<c:when test="${(i.modify_id ne null) and (i.modify_id ne '' )}">
								${i.modify_id }
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a href="" class="btn btn5" id="reserveConfig-edit" keyValue1="${i.reserve_config_idx }" keyValue2="${i.reserve_start_time }" keyValue3="${i.reserve_end_time }" keyValue4="${i.take_term }" keyValue5="${i.tomorrow_end_day_yn }" keyValue6="${i.expire_date_cnt}">수정</a>
					</td>					
				</tr>					
			</c:forEach>
			<c:if test="${paging.totalDataCount <= 0}">
				<tr>
					<td colspan="12">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value=""/>
	</jsp:include>
</form:form>

<div id="dialog-1" class="dialog-common" title="예약설정 등록"></div>

