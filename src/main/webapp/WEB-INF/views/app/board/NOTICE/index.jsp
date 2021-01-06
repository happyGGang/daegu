<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<c:if test="${boardManage.manage_idx eq '282'}">
<style>
table.bbs tr.notice{background:#f5f6f7}
@media (max-width: 430px) and (min-width: 0px) {
	table.bbs col.col1 {
	    width : 1%
	}
	table.bbs col.col3 {
	    width : 1%
	}
	td.title{width: 100%;border-bottom: none;}
	td.username{display: table-cell !important;border-top: none;font-size: 12px !important;}
	td.adddate{display: table-cell !important;border-top: none;font-size: 12px !important;}
	td.viewCount{display: table-cell !important;border-top: none;font-size: 12px !important;}
	table.bbs tbody tr:hover {background:#f8f8f8}
	td.txtBar{display: inline-block;width: 1px;height: 10px;font-size: 0px;line-height: 0;text-indent: -9999px;vertical-align: top;margin: 3px 5px;background: rgb(217, 217, 217);}
}
</style>
</c:if>
<c:if test="${boardManage.manage_idx ne '282'}">
<style>
table.bbs tr.notice{background:#f5f6f7}
@media (max-width: 430px) and (min-width: 0px) {
	table.bbs col.col2 {
	    width : 1%
	}
	td.title{width: 100%;border-bottom: none;margin-bottom: -5px;}
	td.username{float:left;display: table-cell !important;border-top: none;font-size: 12px !important;}
	td.adddate{display: table-cell !important;border-top: none;font-size: 12px !important;}
	td.viewCount{float:left;display: table-cell !important;border-top: none;font-size: 12px !important;}
	table.bbs tbody tr:hover {background:#f8f8f8}
	td.txtBar{display: inline-block;width: 1px;height: 10px;font-size: 0px;line-height: 0;text-indent: -9999px;vertical-align: top;margin: 3px 5px;background: rgb(217, 217, 217);}
}
</style>
</c:if>
<c:if test="${boardManage.manage_idx eq '614' or boardManage.manage_idx eq '628' || boardManage.manage_idx eq '652'}">
<style>
.category span.ca.bg-0000 {background-color:#000000;color:#fff;}
.category span.ca.bg-0001 {background-color:#dda616;color:#fff;}
.category span.ca.bg-0002 {background-color:#8194b4;color:#fff;}
.category span.ca.bg-0003 {background-color:#f67205;color:#fff;}
.category span.ca.bg-0004 {background-color:#dda616;color:#fff;}
.category span.ca.bg-0005 {background-color:#8194b4;color:#fff;}
.category span.ca.bg-0006 {background-color:#f67205;color:#fff;}
.category span.ca.bg-0007 {background-color:#dda616;color:#fff;}
.category span.ca.bg-0008 {background-color:#8194b4;color:#fff;}
.category span.ca.bg-0009 {background-color:#f67205;color:#fff;}
</style>
</c:if>
<c:if test="${boardManage.manage_idx eq '740'}">
<style>
.category span.ca.bg-0000 {background-color:#777;color:#fff;}
.category span.ca.bg-0001 {background-color:#2f55d4;color:#fff;}
.category span.ca.bg-0002 {background-color:#089916;color:#fff;}
.category span.ca.bg-0003 {background-color:#a536d9;color:#fff;}
.category span.ca.bg-0004 {background-color:#ff2222;color:#fff;}
.category span.ca.bg-0005 {background-color:#edce00;color:#fff;}
.category span.ca.bg-0006 {background-color:#ff70ba;color:#fff;}
</style>
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">
		<table class="bbs center">
			<caption>게시물 목록(${fn:escapeXml(boardManage.board_name)})</caption>
			<colgroup>
			<%--	<c:if test="${board.delete_yn eq 'Y'}"> --%>
				<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
				<col width="5%">
				</c:if>
				<col width="7%">
				<c:if test="${boardManage.manage_idx eq '282' || boardManage.manage_idx eq '614' || boardManage.manage_idx eq '628' || boardManage.manage_idx eq '652' || boardManage.manage_idx eq '740'}">
				<col width="*">
				</c:if>
				<col>
				<col width="16%">
				<col width="8%">
				<col width="10%">
				<col width="7%">
			</colgroup>
			<thead>
				<tr>
<%-- 					<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<th><input type="checkbox" id="checkAll"> </th>
					</c:if>
					<th>번호</th>
					<c:if test="${boardManage.manage_idx eq '282' || boardManage.manage_idx eq '614' or boardManage.manage_idx eq '628'}">
					<th class="category">도서관</th>
					</c:if>
					<th class="">제목</th>
					<!-- <th>처리상태</th> -->
					<th class="mmm1">작성자</th>
					<th class="">작성일</th>
					<th class="mmm1">조회수</th>
					<th class="mmm1">파일</th>
				</tr>
			</thead>
			<tbody id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardNoticeList2}">
				<tr class="notice">
<%-- 					<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td></td>
					</c:if>
					<td class="num notice"><span>통합</span></td>
					<c:if test="${boardManage.manage_idx eq '282' || boardManage.manage_idx eq '614' or boardManage.manage_idx eq '628'}">
					<td class="category important td2 cate">
						<span class="ca bg-${i.imsi_v_19}">${i.imsi_v_20}</span>
					</td>
					</c:if>
					<td class="important left title">
						<a href="/dgportal/board/view.do?menu_idx=22&board_idx=${i.board_idx}&manage_idx=282" gbelib="true" >
							<span>${i.title}</span>
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="mmm1 username">${i.secret_yn ne 'Y'? i.user_name:'비공개'}</td>
					<td class=" num adddate"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardNoticeList}">
				<tr class="notice">
<%-- 					<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td></td>
					</c:if>
					<td class="num notice"><span>공지</span></td>
					<c:if test="${boardManage.manage_idx eq '282'}">
					<td class="category important td2">
						<span class="ca bg-${i.imsi_v_19}">통합</span>
					</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '614'}">
						<td class="category important td2">
							<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
						</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '628'}">
						<td class="category important td2">
							<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '공통'}</span>
						</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '652'}">
						<td class="category important td2">
							<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
						</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '740'}">
						<td class="category important td2">
							<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
						</td>
					</c:if>

					<td class="important left title">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<c:set var="portal" value=""></c:set>
						<c:if test="${boardManage.manage_idx eq '282'}">
						<c:set var="portal" value="/${i.imsi_v_19}/board/"></c:set>
						</c:if>
						<c:set var="viewUrl" value="${portal}view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}"></c:set>
						<a href="${viewUrl}" keyValue="${i.board_idx}">
							<span>
								<c:if test="${boardManage.manage_idx eq '652' and not empty i.category1_name}">
									[${i.category1_name}]
								</c:if>
								${i.title}
							</span>
							<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
							<c:if test="${i.comment_count > 0}">
							<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
							</c:if>
						</a>
					</td>
					<td class="mmm1 username">${i.secret_yn ne 'Y'? i.user_name:'비공개'}</td>
					<td class="num adddate"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" varStatus="status" items="${boardList}">
				<tr${i.group_depth > 0?' class="reply"':''}>
<%-- 					<c:if test="${board.delete_yn eq 'Y'}"> --%>
					<c:if test="${member.admin or authMBA or authMBS or portalAuth eq '2'}">
					<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
					</c:if>
					<td class="num">${paging.listRowNum - status.index}</td>
					<c:if test="${boardManage.manage_idx eq '282'}">
					<td class="category important td2">
						<span class="ca bg-${i.imsi_v_19}">${i.imsi_v_20}</span>
					</td>
					</c:if>
					<c:if test="${ boardManage.manage_idx eq '614'}">
					<td class="category important td2">
						<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
					</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '628'}">
					<td class="category important td2">
						<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '공통'}</span>
					</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '652'}">
					<td class="category important td2">
						<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
					</td>
					</c:if>
					<c:if test="${boardManage.manage_idx eq '740'}">
					<td class="category important td2">
						<span class="ca bg-${i.category1}">${not empty i.category1_name ? i.category1_name : '통합'}</span>
					</td>
					</c:if>
					<td class="important left title" style="padding-left:${(i.group_depth > 0 ? (i.group_depth-1)*15 : 0)+10}px;">
						<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>
						<c:set var="portal" value=""></c:set>
						<c:if test="${boardManage.manage_idx eq '282'}">
						<c:set var="portal" value="/${i.imsi_v_19}/board/"></c:set>
						</c:if>
						<c:if test="${boardManage.manage_idx eq '614' or boardManage.manage_idx eq '628'}">
						<c:set var="portal" value="/${homepage.context_path}/board/"></c:set>
						</c:if>
						<c:set var="viewUrl" value="${portal}view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}"></c:set>
						<a href="${viewUrl}" keyValue="${i.board_idx}">
						<c:if test="${i.group_depth > 0}">
							<i class="fa fa-reply"></i>
						</c:if>
							<span>
								<c:if test="${boardManage.manage_idx eq '652' and not empty i.category1_name}">
									[${i.category1_name}]
								</c:if>
									${i.title}
							</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
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
					<td class="mmm2 username">${i.secret_yn ne 'Y'? user_name:'비공개'}</td>
					<td class="num adddate"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
					<td class="num mmm1">${i.view_count}</td>
					<td class="file mmm1">
					<c:if test="${i.file_count > 0}">
						<i class="fa fa-floppy-o"></i>
					</c:if>
					</td>
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

	<jsp:include page="/WEB-INF/views/app/board/common/index/noticePaging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>