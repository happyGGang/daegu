<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
.starR1 {position: relative;display: inline-block;float: left;width: 17.5px;height: 30px;font-size: 35px;color:#ccc;overflow: hidden;z-index: 2;}
.starR2 {position: relative;display: inline-block;float: left;right: 17.5px;width: 30px;height: 30px;font-size: 35px;color:#ccc;margin-right: -18px;z-index: 1;}
.starR1.on {color: red;}
.starR2.on {color: red;}
.ellipsis {width: 200px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}

#search_text_module {background-color: #ffffff;}
#pagingCount {position: relative;bottom: 5px;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	$('a.review-btn').on('click', function(e) {
		e.preventDefault();
		var vLoca = $(this).attr('vLoca');
		var vCtrl = $(this).attr('vCtrl');
		var vImg = $(this).attr('vImg');
		var isbn = $(this).attr('isbn');
		var menuIdx = $(this).attr('keyValue');
		
		var url = '/'+$(this).attr('keyValue2')+'/intro/search/detail.do';
		var formDate = 'vLoca='+vLoca + '&vCtrl='+vCtrl + '&vImg='+vImg + '&isbn='+isbn + '&menu_idx='+menuIdx;
		
		doGetLoad(url, formDate);
	});
	
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		var param = serializeCustom($('form#bookReview'));
		doGetLoad('history.do', param);
	});
	
	$('input#search_text_module').keyup(function(e) {
		e.preventDefault();
		if(e.keyCode == 13) {
			$('#viewPage').attr('value', '1');
			var param = serializeCustom($('form#bookReview'));
			doGetLoad('history.do', param);
		}
	});
	
	$('input#search_start_date').datepicker({
		maxDate: $('input#search_end_date').val(),
		onClose: function(selectedDate){
			$('input#search_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#search_end_date').datepicker({
		minDate: $('input#search_start_date').val(),
		onClose: function(selectedDate){
			$('input#search_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a.excel-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm').attr('action', 'excelDownload.do');
		$('#excelDownForm').submit();
	});
	
	$('a.csv-btn').on('click', function(e) {
		e.preventDefault();
		$('#excelDownForm').attr('action', 'csvDownload.do');
		$('#excelDownForm').submit();
	});
	
});
</script>
<%-- <c:choose> --%>
<%-- <c:when test="${homepage.context_path eq 'app'}"> --%>
<%-- </c:when> --%>
<%-- <c:otherwise> --%>

<%-- <c:if test="${fn:length(bookReviewAll) > 0}"> --%>
<!-- 	<div style="text-align: right"> -->
<!-- 		<a class="btn btn2 excel-btn">엑셀 저장</a> -->
<!-- 		<a class="btn btn2 csv-btn">CSV 저장</a> -->
<%-- 		<form:form id="excelDownForm" modelAttribute="bookReview" action="excelDownload.do" method="POST"> --%>
<%-- 		</form:form> --%>
<!-- 	</div> -->
<%-- </c:if> --%>

<%-- </c:otherwise> --%>
<%-- </c:choose> --%>

<form:form id="excelDownForm" modelAttribute="bookReview" action="excelDownload.do" method="POST">
</form:form>

<form:form modelAttribute="bookReview" action="index.do" method="GET" onsubmit="return false;">
<form:hidden path="menu_idx"/>

<div id="libraryList" class="bbs-notice" style="margin-top:10px;margin-bottom:20px;" >
	소장처&nbsp;:&nbsp;
	<form:select path="search_loca" cssClass="selectmenu" cssStyle="width:290px;">
		<form:option value="">전체</form:option>
		<c:forEach items="${homepageList}" var="i">
			<c:if test="${not empty i.homepage_code}">
			<form:option value="${i.homepage_code}" label="${i.homepage_name}" />
			</c:if>
		</c:forEach>
	</form:select>
	조회 기간&nbsp;:&nbsp;
	<form:input path="search_start_date" cssClass="text ui-calendar" title="조회할 시작 날짜 선택"/><label for="search_start_date" class="blind">시작일</label> ~
	<form:input path="search_end_date" cssClass="text ui-calendar" title="조회할 끝 날짜 선택"/><label for="search_end_date" class="blind">종료일</label>
	<div style="padding-top: 10px;">
		서평&nbsp;:&nbsp;
		<form:input path="search_text" id="search_text_module" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" size="42"/>
		<label for="search_text_board" class="blind">검색어</label>
		
		<a href="#" id="search-btn" class="btn btn1">조회</a>
		<c:choose>
		<c:when test="${homepage.context_path eq 'app'}">
		</c:when>
		<c:otherwise>
			<c:if test="${fn:length(bookReviewAll) > 0}">
			<a class="btn btn2 excel-btn">엑셀 저장</a>
			<a class="btn btn2 csv-btn">CSV 저장</a>
			</c:if>
		</c:otherwise>
		</c:choose>
	</div>
</div>

<div id="pagingCount" align="right">
	서평 작성 총 ${paging.totalDataCount}건
</div>
<div class="book-list">
	<c:if test="${fn:length(bookReviewAll) < 1 }"><h3>조회된 서평내역이 없습니다.</h3></c:if>
	<c:if test="${fn:length(bookReviewAll) > 0 }">
	<table summary="신청정보">
		<colgroup>
			<col>
			<col width="20%">
			<col width="15%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th>서명</th>
				<th>별점</th>
				<th>소장처</th>
				<th>등록일</th>
			</tr>
			<tr>
				<th colspan="4">서평</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bookReviewAll}" var="i" varStatus="status">
			<tr class="view-detail">
<%-- 				<td class="center" rowspan="2">${paging.listRowNum - status.index}</td> --%>
				<td class="left">
					<div class="ellipsis">${i.dsItemDetail.TITLE}</div>
				</td>
				<td>
					<div style="display: inline-block;">
						<span class="starR1 <c:if test="${i.br_score >= 0.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${i.br_score >= 1}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${i.br_score >= 1.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${i.br_score >= 2}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${i.br_score >= 2.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${i.br_score >= 3}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${i.br_score >= 3.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${i.br_score >= 4}">on</c:if>">★</span>
						<span class="starR1 <c:if test="${i.br_score >= 4.5}">on</c:if>">★</span>
						<span class="starR2 <c:if test="${i.br_score >= 5}">on</c:if>">★</span>
					</div>
				</td>
				<td>${i.dsItemDetail.LOCA_NAME}</td>
				<td><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd HH:mm" /></td>
			</tr>
			<tr>
				<td class="left" colspan="4">
					<div class="ellipsis" style="width: 800px;">
						<a href="#" class="review-btn" vLoca="${i.dsItemDetail.LOCA}" vCtrl="${i.dsItemDetail.CTRLNO}" vImg="${i.dsItemDetail.IMAGE_URL}" isbn="${i.dsItemDetail.ISBN}" keyValue="${i.menu_idx}" keyValue2="${i.dsItemDetail.context_path}">${i.br_content}</a>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="6">
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/app/homepage/module/bookReview/paging.jsp"></jsp:include>
</form:form>