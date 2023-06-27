<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
<c:if test="${!authMBA and !authMBRE and !fn:contains(asideHomepageId, 'h')}">
	alert('잘못된 경로로 접근하였습니다.');
	location.href="/cms/index.do";
// location.href="/pms/board/index.do?menu_idx=2&manage_idx=563&category1=0000";

</c:if>
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/edit/script.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/edit/terms.jsp" flush="false" />
<form:form modelAttribute="board" action="save.do" method="post" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="parent_idx"/>
<c:if test="${board.editMode eq 'REPLY'}">
<form:hidden path="group_depth"/>
<form:hidden path="category1"/>
<c:if test="${!member.admin}">
<hidden id="category2" value="${member_homepage_id}"/>
</c:if>
</c:if>
<div class="wrapper-bbs">
	<c:if test="${board.editMode eq 'REPLY'}">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
			<dl>
				<dt>${requestBoard.title}</dt>
				<dd class="info">
					<div class="panel-left">
						<i>작성자</i><span>${requestBoard.user_name}</span>
						<i>작성일</i><span><fmt:formatDate value="${requestBoard.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
						<c:if test="${requestBoard.user_ip ne null and requestBoard.user_ip ne ''}">
							<c:set value="${fn:split(requestBoard.user_ip, '.')}" var="user_ip"></c:set>
							<c:choose>
								<c:when test="${authMBA}">
						<i>IP</i><span>board.user_ip</span>
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
						<i>조회수</i><span><fmt:formatNumber value="${requestBoard.view_count}" pattern="#,###"/></span>
					</div>
				</dd>
			</dl>
		</div>
		<div class="bbs-view-body">
			${fn:replace(requestBoard.content, crlf, '<br/>')}
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
				<c:if test="${fn:length(boardFile) > 0}">
				<dd class="file">
					<ul>
					<c:forEach var="i" varStatus="status" items="${requestBoardFile}">
						<li><a href="${getContextPath}/board/boardFile/download/${requestBoard.manage_idx}/${i.board_idx}/${i.file_idx}.do"><i class="fa <boardTag:file_ext file_ext="${i.file_ext_name}"/>"></i><span>${i.file_name}</span></a></li>
					</c:forEach>
					</ul>
				</dd>
				</c:if>
			</dl>
		</div>
		<div class="bbs-comment" id="bbs-comment">

		</div>
	</div>
	</c:if>
	<table class="bbs-edit">
		<tbody>
			<c:if test="${board.editMode ne 'REPLY'}">
			<c:if test="${board.category1 eq '0000' }">
			<form:hidden path="category1"/>
			<form:hidden path="category2" value="0"/>
			</c:if>
			<c:if test="${fn:length(category1List) > 0 && board.category1 ne '0000'}">
			<tr>
				<th>구분</th>
				<td colspan="3">
					<c:forEach items="${category1List}" var="i" varStatus="status" >
						<c:choose>
							<c:when test="${status.first}">
								<c:if test="${member.admin}">
						<form:radiobutton path="category1" cssStyle="width:40px;" value="${i.code_id}" label="${i.code_name}"/>
								</c:if>
							</c:when>
							<c:otherwise>
						<form:radiobutton path="category1" cssStyle="width:40px;" value="${i.code_id}" label="${i.code_name}"/>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</td>
			</tr>
			</c:if>
			<c:choose>
			<c:when test="${fn:length(category2List) > 0 && member.loginType eq 'CMS' && member.admin && board.category1 ne '0000'}">
			<tr>
				<th>요청홈페이지</th>
				<td colspan="3">
					<form:select path="category2" cssStyle="width:260px;" cssClass="selectmenu">
						<c:forEach var="i" varStatus="status" items="${category2List}">
							<c:if test="${i.code_id ne 'h27'}">
						<form:option value="${i.code_id}" label="${i.code_name }" />
							</c:if>
						</c:forEach>
					</form:select>
				</td>
			</tr>
			</c:when>
			<c:when test="${empty asideHomepageId}">
			<form:hidden path="category2" value="h28"/>
			</c:when>
			<c:otherwise>
			<form:hidden path="category2" value="${asideHomepageId}"/>
			</c:otherwise>
			</c:choose>
			</c:if>
			<c:if test="${board.category1 ne '0000' and board.category1 ne '0040'}">
			<tr>
				<th>접수형태</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${member.admin}">
					<form:select path="request_state" cssClass="selectmenu" cssStyle="width:160px;" items="${request_state_list}" itemLabel="code_name" itemValue="code_id"/>
						</c:when>
						<c:otherwise>
					요청
					<form:hidden path="request_state" value="0"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:if>
			<%-- </c:if> --%>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<form:input path="title" cssClass="text" cssStyle="width:90%" maxlength="100" />
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${member.member_name}</td>
				<th>작성일</th>
				<c:choose>
          <c:when test="${homepage.context_path eq 'gw'}">
            <td><form:input path="add_date_sample" cssClass="text" cssStyle="width:30%" maxlength="100" /></td>
              <th>작성자아이디</th>
            <td><form:input path="add_id" cssClass="text" cssStyle="width:30%" maxlength="100" /></td>
          </c:when>
          <c:otherwise>
            <td><fmt:formatDate value="${board.editMode eq 'ADD' ? getToday : board.add_date}" pattern="yyyy-MM-dd"/></td>
          </c:otherwise>
        </c:choose>
			</tr>
			<c:if test="${boardManage.secret_use_yn eq 'Y'}">
			<tr>
				<th>비밀글 여부</th>
				<td colspan="3">
					<form:radiobutton path="secret_yn" id="secret_yn_yes" value="Y"/>
					<label for="secret_yn_yes">예</label>
					<form:radiobutton path="secret_yn" id="secret_yn_no" value="N" />
					<label for="secret_yn_no">아니오</label>
				</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="4" class="editor">
					<div class="bbs-textarea">
						<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;${boardManage.editor_use_yn eq 'Y'?' display:none':''}"/>
					</div>
				</td>
			</tr>
			<c:if test="${boardManage.file_use_yn eq 'Y'}">
			<tr>
				<td colspan="4" class="file_attach">
					<jsp:include page="/WEB-INF/views/app/board/common/edit/jqueryFileUpload.jsp" flush="false">
						<jsp:param name="formId"  value="#board"/>
					</jsp:include>
				</td>
			</tr>
			</c:if>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/board/common/edit/button.jsp" flush="false" />
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>
