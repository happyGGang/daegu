<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('select#rowCount').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#bestPracticesContest').serialize());
	});
	
	$('a.view_btn').on('click', function(e){
		e.preventDefault();
		$('#best_practices_idx').val($(this).data('key'));
		doGetLoad('viewPw.do', serializeCustom($('form#bestPracticesContest')));
	});
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#bestPracticesContest')));
	});
	
	$('button#search_btn').on('click', function(e){
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#bestPracticesContest')));
	});
	
});
</script>

<form:form modelAttribute="bestPracticesContest">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="best_practices_idx"/>

	<div class="button bbs-btn fl_right_btn">
		<a href="#" id="apply_btn" class="btn btn1">참여신청</a>
	</div>
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
			<table class="bbs center" summary="독서릴레이 우수사례공모">
				<caption>독서릴레이 우수사례공모</caption>
				<colgroup>
					<col width="8%">
					<col width="">
					<col width="12%">
					<col width="12%">
					<col width="8%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>조회</th>
					</tr>
				</thead>
				<tbody id="board_tbody">
					<c:forEach var="i" varStatus="status" items="${bestPracticesContestList}">
						<tr>
							<td>${paging.listRowNum - status.index}</td>
							<td class="left">
								<a href="#" class="view_btn" data-key="${i.best_practices_idx}">
									${i.title}
								</a>
							</td>
							<c:choose>
								<c:when test="${authMBA or member.admin}">
									<c:set var="user_name" value="${i.user_name}"/>
								</c:when>
								<c:otherwise>
									<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
								</c:otherwise>
							</c:choose>
							<td>${user_name}</td>
							<td>
								<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd" />
							</td>
							<td>${i.view_count}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(bestPracticesContestList) < 1}">
						<tr>
							<td class="dataEmpty" colspan="5">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		
		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#bestPracticesContest"/>
		</jsp:include>
		
		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu new_select_box">
					<form:option value="title">제목</form:option>
					<form:option value="contents">내용</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
				<button id="search_btn" style="background:none;background-color:#2c75cb;border-color:#1962ba;padding:5px 10px 6px;"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
		
	</div>
</form:form>
