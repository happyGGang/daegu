<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<script>
$(document).ready(function() {
    <%-- 답변 수정하기 --%>
    $('a#board_reply_edit_btn').on('click', function(e) {
    	$('#editMode').val('MODIFY');
    	$('#board_idx').val($(this).attr('keyValue'));
		var url = 'edit.do';
		var formData = serializeCustom($('#board'));
		doGetLoad(url, formData);
		e.preventDefault();
	});

    <%-- 답변 삭제하기 --%>
    $('a#board_reply_delete_btn').on('click', function(e) {
    	e.preventDefault();
    	$('#board_idx').val($(this).attr('keyValue'));
    	if(confirm('답변을 삭제 하시겠습니까?')) {
    		$('#board').attr('action', 'delete.do');
    		doAjaxPost($('#board'));
    	}
	});
});
</script>
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
<form:hidden path="user_password"/>
<form:hidden path="boardIdxArray"/>
</form:form>
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
			<dl>
				<dt>${board.title}</dt>
				<dd class="info">
					<div class="panel-left">
<%--						<i>답변상태</i><span>${board.request_state_str}</span> --%>
						<c:choose>
						<c:when test="${board.notice_yn eq 'Y'}">
						<c:set var="user_name" value="${board.user_name}"/>
						</c:when>
						<c:when test="${boardManage.anonymize_yn eq 'Y' and not authMBA and not supportAdmin}">
						<c:set var="user_name" value="${fn:substring(board.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${board.user_name}"/>
						</c:otherwise>
						</c:choose>
						<i>작성자</i><span>${user_name}<c:if test="${authMBA or supportAdmin}">(${board.add_id})</c:if></span>
						<c:if test="${board.secret_yn eq 'Y' and not empty board.user_phone}">
						<i>연락처</i><span>${board.user_phone}</span>
						</c:if>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
						<c:if test="${board.user_ip ne null and board.user_ip ne ''}">
							<c:set value="${fn:split(board.user_ip, '.')}" var="user_ip"></c:set>
							<c:choose>
								<c:when test="${authMBA or supportAdmin}">
						<i>IP</i><span>${board.user_ip}</span>
								</c:when>
								<c:otherwise>
									<c:if test="${fn:length(user_ip) == 4}">
						<i>IP</i><span>*.*.*.${user_ip[3]}</span>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="panel-right">
						<a href="#bbs-comment">
						<i>댓글</i><span>0</span></a>
						<i>조회수</i><span><fmt:formatNumber value="${board.view_count}" pattern="#,###"/></span>
					</div>
				</dd>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(board.content, crlf, '<br/>')}
<!-- 			<dl class="share"> -->
<!-- 				<dt>공유하기</dt> -->
<!-- 				<dd> -->
<!-- 					<a href="" class="facebook"><i class="fa fa-facebook"></i> <span>페이스북</span></a> -->
<!-- 					<a href="" class="twitter"><i class="fa fa-twitter"></i> <span>트위터</span></a> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
</div>

<c:forEach var="j" varStatus="status" items="${boardQnaList}">
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<dl>
				<dt>${j.title}</dt>
				<dd class="info">
					<div class="panel-left">
						<i>작성자</i><span>${j.user_name}<c:if test="${authMBA or supportAdmin}">(${j.add_id})</c:if></span>
						<i>작성일</i><span><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
						<c:if test="${not empty j.user_ip}">
							<c:set value="${fn:split(j.user_ip, '.')}" var="user_ip"></c:set>
							<c:choose>
								<c:when test="${authMBA or supportAdmin}">
						<i>IP</i><span>${j.user_ip}</span>
								</c:when>
								<c:otherwise>
									<c:if test="${fn:length(user_ip) == 4}">
						<i>IP</i><span>*.*.*.${user_ip[3]}</span>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
				</dd>
				<c:if test="${fn:length(j.boardFile) > 0}">
				<dd class="file">
					<ul>
					<c:forEach var="i" varStatus="status" items="${j.boardFile}">
						<li><a href="${getContextPath}/board/boardFile/download/${j.manage_idx}/${i.board_idx}/${i.file_idx}.do"><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>${i.org_file_name}</span></a></li>
					</c:forEach>
					</ul>
				</dd>
				</c:if>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(j.content, crlf, '<br/>')}
		</div>
	</div>
	<div class="button bbs-btn right">
	<c:choose>
	<c:when test="${board.delete_yn  eq 'Y'}">
		<a href="" class="btn btn5" id="board_recovery_btn">게시물복구</a>
	</c:when>
	<c:otherwise>

	<c:if test="${fn:length(boardQnaList) > 0 and authMBA and supportAdmin}">
		<a href="" class="btn modify" id="board_reply_edit_btn" keyValue="${boardQnaList[0].board_idx}"><i class="fa fa-pencil-square-o"></i><span>답변수정</span></a>
		<a href="" class="btn delete" id="board_reply_delete_btn" keyValue="${boardQnaList[0].board_idx}"><i class="fa fa-trash-o"></i><span>답변삭제</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
	</div>
</div>
</c:forEach>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>
<c:if test="${boardManage.board_type eq 'QNA'}">
<div id="dialog-1"></div>
</c:if>