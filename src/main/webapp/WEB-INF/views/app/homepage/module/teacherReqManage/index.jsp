<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>
<script type="text/javascript">
$(function() {
	$('a.modify-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('detail.do', 'teacher_idx=' + $(this).attr('keyValue2') + '&menu_idx=' + $('#teacherListForm #menu_idx').val());
// 		$(location).attr('href', )
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
	
	$('select#teacher_location_code').on('change', function() {
		$('#viewPage').val(1);
		doGetLoad('index.do', $('#teacherListForm').serialize());
	});
});
</script>
<form:form id="teacherListForm" modelAttribute="teacher" action="index.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="menu_idx"/>
	<div class="button btn-group inline" style="float: left; margin-bottom: 20px;">
		<span class="bbs-result">과목 계열 : </span>
		<label for="largeSubjectCode" />
		<form:select path="largeSubjectCode" cssClass="selectmenu" cssStyle="width:150px;">
			<form:option value="" label="전체"></form:option>
			<form:option value="Z" label="미지정"></form:option>
			<form:options items="${largeCodeList}" itemValue="code_id" itemLabel="code_name"/>
		</form:select>
		<label for="smallSubjectCode" />
		<form:select path="smallSubjectCode" cssClass="selectmenu" cssStyle="width:150px;">
			<form:option value="" label="전체"></form:option>
			<form:options items="${smallCodeList}" itemValue="code_id" itemLabel="code_name"/>
		</form:select>
		&nbsp;<span class="bbs-result">지역 : </span>
   		<form:select path="teacher_location_code" cssClass="selectmenu">
   			<form:option value="" label="없음"></form:option>
   			<form:options items="${locationCodeList}" itemLabel="code_name" itemValue="code_id"/>
   		</form:select>
	</div>
	<div class="button btn-group inline" style="float: right;">
	<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
		<label for="rowCount" />
		<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;">
		<c:forEach var="i" begin="10" end="50" step="10">
			<form:option value="${i}">${i}개씩 보기</form:option>
		</c:forEach>
		</form:select>
	</div>
	<div class="auto-scroll" style="clear: both;">
		<table class="bbs center">
			<thead>
				<tr>
					<th width="50">번호</th>
					<th class="important">강사명</th>
					<th >성별</th>
					<th>지역</th>
					<th>과목계열</th>
					<th class="important" width="200">과목명</th>
					<th>강의계획서</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${teacherListCount > 0 }">
						<c:forEach items="${teacherList}" var="i" varStatus="status">
							<tr>
								<td width="50" class="num">${paging.listRowNum - status.index}</td>
								<td class="important">${i.teacher_name}</td>
								<td class="num">${i.teacher_sex}</td>
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
<c:if test="${homepage.homepage_id eq 'h28'}">
									<script>
									var teacher_open_files = '${tag:escapeJS(i.teacher_open_files)}'
									try {
										var json_teacher_open_files = JSON.parse(teacher_open_files);
										for(var i=0; i < json_teacher_open_files.length; ++i) {
											var file = json_teacher_open_files[i];
											var num = i == 0 ? '' : (i+1) + '';
											document.write('<a href="/${homepage.context_path}/module/teacherReqManage/download2/${teacher.homepage_id}/${i.teacher_idx}/' + file.file_hash + '.do"><i class="fa fa-floppy-o"></i> ' + '[다운로드' + num + ']</a><br>');
										}
									} catch(e) {
										
									}
									</script>
</c:if>
								</td> 
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
					<tr>
						<td colspan="7">데이터가 존재하지 않습니다.</td>
					</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#teacherListForm"/>
		</jsp:include>

		<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
			<fieldset>
				<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
					<form:option value="TEACHER_NAME">강사명</form:option>
					<form:option value="TEACHER_SEX">성별</form:option>
				</form:select>
				<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
				<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			</fieldset>
		</div>
	</div>
</form:form>
