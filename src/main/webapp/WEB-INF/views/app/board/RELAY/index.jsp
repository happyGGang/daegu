<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<div class="infodesk">
	<c:if test="${authMBA}">
		<c:if test="${fn:length(category1List) > 0}">
		학교 : 
		<label for="category1"></label>
		<form:select path="category1" cssStyle="width:160px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
		</form:select>
		</c:if>
	</c:if>
		<c:if test="${fn:length(category2List) > 0}">
		도서명 :
		<label for="category2"></label> 
		<form:select path="category2" cssStyle="width:180px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
		</form:select>
		</c:if>
		<div class="button btn-group inline">
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
			<label for="rowCount" />
			<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;">
			<c:if test="${boardManage.board_type eq 'GALLERY' or boardManage.board_type eq 'BOOK'}">
			<c:forEach var="i" begin="8" end="16" step="4">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</c:if>
			<c:if test="${boardManage.board_type ne 'GALLERY'}">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</c:if>
			</form:select>
		</div>
	</div>
	<div class="table-wrap">
		<table class="bbs center" summary="일반 게시판">
			<caption>일반게시판</caption>
			<colgroup>
				<c:if test="${board.delete_yn eq 'Y'}">
				<col width="5%">
				</c:if>
				<col width="8%">
				<c:if test="${authMBA}">
				<col width="15%">
				</c:if>
				<col width="10%">
				<col>
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<c:if test="${board.delete_yn eq 'Y'}">
					<th><input type="checkbox" id="checkAll"> </th>
					</c:if>
					<th>번호</th>
					<c:if test="${authMBA}">
					<th>학교명</th>
					</c:if>
					<th class="important">도서명</th>
					<th class="important">제목</th>
					<!-- <th>처리상태</th> -->
					<th class="mmm2">작성자</th>
					<th class="important">작성일</th>
					<th class="mmm1">조회수</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardNoticeList}">
				<tr class="notice">
					<c:if test="${board.delete_yn eq 'Y'}">
					<td></td>
					</c:if>
					<td class="num notice"><span>공지</span></td>
					<c:if test="${authMBA}">
					<td class="">
						${i.category1_name}
					</td>
					</c:if>
					<td class="important" style="border-bottom:none; overflow: hidden; width: 80px; text-overflow: ellipsis; white-space: nowrap; <c:if test="${not empty i.category2_name}">display: inline-block;</c:if>">
						${i.category2_name}
					</td> 
					<td class="important left">
						<a href="" keyValue="${i.board_idx}">
							<span>${i.title}</span>
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="mmm2">${i.secret_yn ne 'Y'? i.user_name:'비공개'}</td>
					<td class="important num"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
					<c:if test="${board.delete_yn eq 'Y'}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<c:if test="${authMBA}">
					<td class="">
						${i.category1_name}
					</td>
					</c:if>
					<td class="important" style="border-bottom:none; overflow: hidden; width: 80px; text-overflow: ellipsis; white-space: nowrap; <c:if test="${not empty i.category2_name}">display: inline-block;</c:if>">
						<span alt="${i.category2_name}" title="${i.category2_name}">${i.category2_name}</span>
					</td>
					<td class="important left" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<a href="" keyValue="${i.board_idx}" title="${i.title}" alt="${i.title}">
						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
							<span>${i.title}</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<c:choose>
					<c:when test="${boardManage.anonymize_yn eq 'Y'}">
					<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
					</c:when>
					<c:otherwise>
					<c:set var="user_name" value="${i.user_name}"/>
					</c:otherwise>
					</c:choose>
					<td class="mmm2">${i.secret_yn ne 'Y'? user_name:'비공개'}</td>
					<td class="important num"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${fn:length(boardList) < 1}">
		<table class="bbs center">
			<tr>
				<td class="dataEmpty">등록된 게시물이 없습니다.</td>
			</tr>
		</table>
		</c:if>
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
	<c:if test="${member.admin or authMBA}">
	<div class="button bbs-btn right" style="clear: both;">
		<script>
		$(document).ready(function() {
			$('a#board_excel_btn').on('click', function(e) {
				e.preventDefault();
				$('form#excelDownForm input#excelYear').val($('select#tmpExcelYear').val());
				$('form#excelDownForm').submit();
				location.href='/${homepage.context_path}/board/relayExcelDownload.do?excelYear='+$('select#tmpExcelYear').val();
			});
		});
		</script>
		
		<jsp:useBean id="toDay" class="java.util.Date"></jsp:useBean>
		<fmt:formatDate var="toDate" value="${toDay}" pattern="yyyy"/>
		<c:set var="gap" value="${toDate - 2014 }"></c:set>
		<select class="selectmenu" style="width:100px;" id="tmpExcelYear">
		<c:forEach begin="0" end="${gap}" step="1" var="i" varStatus="status">
			<option value="${toDate - i}" label="${toDate - i}">${toDate - i}년도</option>
		</c:forEach>
		</select>
		<a href="" class="btn btn2" id="board_excel_btn"></i><span>엑셀저장</span></a>
	</div>
	</c:if>
	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>

<form id="excelDownForm" name="excelDownForm" action="/${homepage.context_path}/board/relayExcelDownload.do" method="get">
<input type="hidden" name="excelYear" id="excelYear">
</form>