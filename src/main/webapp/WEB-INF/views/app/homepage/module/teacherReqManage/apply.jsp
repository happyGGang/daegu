<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<script type="text/javascript">
$(function() {
	$('a.view-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('view.do', 'teacher_idx=' + $(this).attr('keyValue') + '&menu_idx=' + $('#teacherListForm #menu_idx').val());
	});

	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('#teacherListForm').serialize());
// 		$(location).attr('href', 'index.do?'+$('#teacherListForm').serialize())
	});

	$('select#largeSubjectCode').on('change', function() {
		if ($(this).val() == '') {
			$('select#smallSubjectCode').val('');
		}
		$('#viewPage').val(1);
		doGetLoad('index.do', $('#teacherListForm').serialize());
	});

	$('select#smallSubjectCode').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('#teacherListForm').serialize());
	});
});
</script>
<form:form id="teacherListForm" modelAttribute="teacher" action="index.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="menu_idx"/>
	<div class="auto-scroll" style="clear: both;">
		<table class="bbs center">
			<thead>
				<tr>
					<th width="50">번호</th>
					<th class="important">기관</th>
<%--
					<th class="important">강사명</th>
					<th>성별</th>
--%>
					<th>지역</th>
					<th>과목계열</th>
					<th class="important" width="200">과목명</th>
					<th>강의계획서</th>
					<th>승인여부</th>
					<th width="100">수정일</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${teacherListCount > 0 }">
						<c:forEach items="${teacherList}" var="i" varStatus="status">
							<tr>
								<td width="50" class="num">${paging.listRowNum - status.index}</td>
								<td class="important">${i.homepage_name}</td>
<%--
								<td class="important">${i.teacher_name}</td>
								<td class="num">${i.teacher_sex}</td>
--%>
								<td class="file">${i.teacher_location_code_name}</td>
								<td >${i.subject_cd_name}</td>
								<td class="important left">${i.teacher_subject_name}</td>
								<td class="td_teacher_open_files">
<%--
<c:if test="${sessionScope.member.login and sessionScope.member.loginType eq 'CMS'}">
<c:if test="${not empty i.teacher_open_files}">
<p style="color: red;">* 관리자만 다운로드 버튼이 노출됩니다</p>
</c:if>
--%>
									<script>
									var teacher_open_files = '${tag:escapeJS(i.teacher_open_files)}'
									try {
										var json_teacher_open_files = JSON.parse(teacher_open_files);
										for(var i=0; i < json_teacher_open_files.length; ++i) {
											var file = json_teacher_open_files[i];
											var num = i == 0 ? '' : (i+1) + '';
											document.write('<a href="/${homepage.context_path}/module/teacherReqManage/download2/${i.homepage_id}/${i.teacher_idx}/' + file.file_hash + '.do"><i class="fa fa-floppy-o"></i> ' + '[다운로드' + num + ']</a><br>');
										}
									} catch(e) {
										
									}
									</script>
								</td>
								<td>${i.confirm_yn}</td>
								<td class="important">${i.mod_date}</td> 
								<td><a href="#" class="btn view-btn" keyValue="${i.teacher_idx}">상세보기</a></td> 
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
					<tr>
						<td colspan="9">데이터가 존재하지 않습니다.</td>
					</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#teacherListForm"/>
		</jsp:include>
	</div>
</form:form>
