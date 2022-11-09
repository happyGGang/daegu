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
<script type="text/javascript">
	$(function() {
		var homepage_id = $("#homepage_id").val();
		var manage_idx = ${boardManage.manage_idx};
		console.log(homepage_id);
		console.log(manage_idx);
		if(homepage_id == "h10" && manage_idx == "993"){ //로컬 328
			$(document).bind("contextmenu", function (e) {
				alert("우측 마우스를 사용할 수 없습니다.");
				e.preventDefault();
				return false;
			});
		}
	});		
</script>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
<input type="hidden" id ="homepage_id" value ="${homepage.homepage_id}"/>
</form:form>
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
			<dl>
				<dt>${board.title}</dt>
				<dd class="info">
					<div class="panel-left">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y' and not authMBA}">
						<c:set var="user_name" value="${fn:substring(board.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${board.user_name}"/>
						</c:otherwise>
						</c:choose>
						<i>작성자</i><span>${user_name}<c:if test="${authMBA}">(${board.add_id})</c:if></span>
						<i>축제기간</i>
						<span>
							<c:set var = "months" value = "${fn:replace(board.imsi_v_1, 'JAN', '1')}" />
							<c:set var = "months" value = "${fn:replace(months, 'FED', '2')}" />
							<c:set var = "months" value = "${fn:replace(months, 'MAR', '3')}" />
							<c:set var = "months" value = "${fn:replace(months, 'APR', '4')}" />
							<c:set var = "months" value = "${fn:replace(months, 'MAY', '5')}" />
							<c:set var = "months" value = "${fn:replace(months, 'JUN', '6')}" />
							<c:set var = "months" value = "${fn:replace(months, 'JUL', '7')}" />
							<c:set var = "months" value = "${fn:replace(months, 'AUG', '8')}" />
							<c:set var = "months" value = "${fn:replace(months, 'SEP', '9')}" />
							<c:set var = "months" value = "${fn:replace(months, 'OCT', '10')}" />
							<c:set var = "months" value = "${fn:replace(months, 'NOV', '11')}" />
							<c:set var = "months" value = "${fn:replace(months, 'DEC', '12')}" />
							${months}월 중
						</span>
						<i>주소</i><span>${board.imsi_v_2}</span><br/>
						<i>전화번호</i><span>${board.imsi_v_3}</span>
						<i>홈페이지</i><span><a href="${board.imsi_v_4}" target="_blank">${board.imsi_v_4}</a></span><br/>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
						<c:if test="${board.user_ip ne null and board.user_ip ne ''}">
							<c:set value="${fn:split(board.user_ip, '.')}" var="user_ip"></c:set>
							<c:choose>
								<c:when test="${authMBA}">
									<!-- <i>IP</i><span>${board.user_ip}</span> -->
								</c:when>
								<c:otherwise>
									<c:if test="${fn:length(user_ip) == 4}">
										<!-- <i>IP</i><span>*.*.*.${user_ip[3]}</span> -->
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
			<c:set value="${fn:replace(board.content, crlf, '<br/>')}" var="content"></c:set>
			${content}
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
		<div class="bbs-comment" id="bbs-comment">
			
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/view/beforeNext.jsp" flush="false" />
	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>