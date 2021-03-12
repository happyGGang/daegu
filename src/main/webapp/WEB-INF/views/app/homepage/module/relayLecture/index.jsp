<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#relayLecture').serialize());
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#lecture_idx').val($(this).data('key'));
		doGetLoad('view.do', serializeCustom($('form#relayLecture')));
	});
	
	$('a.apply_btn').on('click', function(e) {
		e.preventDefault();
		$('#lecture_idx').val($(this).data('key'));
		doGetLoad('step2.do', serializeCustom($('form#relayLecture')));
	});
	
});
</script>

<form:form modelAttribute="relayLecture" id="relayLecture" action="index.do" >
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="lecture_idx"/>
	
	<div class="infodesk">
		총 <b style="color:#ff0000;">${paging.totalDataCount}</b>건
		
		<form:select path="rowCount" cssClass="selectmenu new_select_box">
			<form:option value="10">10개씩보기</form:option>
			<form:option value="20">20개씩보기</form:option>
			<form:option value="30">30개씩보기</form:option>
			<form:option value="50">50개씩보기</form:option>
			<form:option value="100">100개씩보기</form:option>
			<form:option value="${paging.totalDataCount}">전체 보기</form:option>
		</form:select>
	</div>
	<div class="wrapper-bbs">
		<div class="table-wrap">
			<table class="bbs center" summary="릴레이강연">
				<caption>릴레이강연</caption>
				<colgroup>
					<col width="7%">
					<col width="">
					<col width="20%">
					<col width="18%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>행사명</th>
						<th>행사기간</th>
						<th>장소</th>
						<th>신청</th>
					</tr>
				</thead>
				<tbody id="board_tbody">
					<c:forEach var="i" varStatus="status" items="${relayLectureList}">
						<tr>
							<td>${paging.listRowNum - status.index}</td>
							<td class="left">
								<a href="#" class="view_btn" data-key="${i.lecture_idx}">
									${i.event_name}
								</a>
							</td>
							<td>${i.event_start_date}~${i.event_end_date}</td>
							<td>${i.event_place}</td>
							<td>
								<c:choose>
									<c:when test="${i.apply_status eq '0'}">
										<span class="btn btn4">신청대기</span>
									</c:when>
									<c:when test="${i.apply_status eq '1'}">
										<a href="#" class="btn btn1 apply_btn" data-key="${i.lecture_idx}">신청가능</a>
									</c:when>
									<c:when test="${i.apply_status eq '2'}">
										<span class="btn btn5">접수마감</span>
									</c:when>
									<c:when test="${i.apply_status eq '3'}">
										<span class="btn btn6">신청마감</span>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(relayLectureList) < 1}">
						<tr>
							<td class="dataEmpty" colspan="5">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#relayLecture"/>
		</jsp:include>
		
		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu new_select_box">
					<form:option value="event_name">행사명</form:option>
					<form:option value="event_place">장소</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
				<button id="search_btn" style="background:none;background-color:#2c75cb;border-color:#1962ba;padding:5px 10px 6px;"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
		
	</div>
</form:form>
