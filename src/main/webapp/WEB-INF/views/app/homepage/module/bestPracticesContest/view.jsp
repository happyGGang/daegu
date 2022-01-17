<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('a#modify_btn').on('click', function(e) {
		e.preventDefault();
		$('input#editMode').val('MODIFY');
		
		var passwordOk = $('#password_ok').val();
		var encodedPasswordOk = btoa(passwordOk);
		
		if (encodedPasswordOk == '${getBestPracticesContest.password}') {
			doGetLoad('edit.do', $('form#bestPracticesContestView').serialize());
		} else {
			alert('비밀번호가 일치하지 않습니다.');
			$('#password_ok').focus();
			$('#password_ok').val('');
		}
	});
	
	$('a#delete_btn').on('click', function(e) {
		e.preventDefault();
		if ($('#password_ok').val() == '${getBestPracticesContest.password}') {
			if (confirm('정말로 삭제하시겠습니까?\n\n삭제 후 복구가 불가능합니다.')) {
				$('form#bestPracticesContestView').attr('action', 'delete.do');
				$('#editMode').val('DELETE');
				doAjaxPost($('form#bestPracticesContestView'));
			}
		} else {
			alert('비밀번호가 일치하지 않습니다.');
			$('#password_ok').focus();
			$('#password_ok').val('');
		}
	});

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#bestPracticesContestView').serialize());
	});
	
});
</script>

<form:form modelAttribute="bestPracticesContest" id="bestPracticesContestView" >
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="menu_idx"/>
<form:hidden path="best_practices_idx"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th class="center" colspan="4">${getBestPracticesContest.title}</th>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${getBestPracticesContest.user_name}</td>
				<th>작성일</th>
				<td>
					<fmt:formatDate value="${getBestPracticesContest.add_date}" pattern="yyyy-MM-dd" />
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${getBestPracticesContest.user_phone}</td>
				<th>이메일</th>
				<td>${getBestPracticesContest.user_email}</td>
			</tr>
			<tr>
				<th>공모분야</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${getBestPracticesContest.contest_field eq '1'}">개인 &#124; 소년부(초등~중등)</c:when>
						<c:when test="${getBestPracticesContest.contest_field eq '2'}">개인 &#124; 장년부(고등~일반)</c:when>
						<c:when test="${getBestPracticesContest.contest_field eq '3'}">단체 &#124; 소년부(초등~중등)</c:when>
						<c:otherwise>단체 &#124; 장년부(고등~일반)</c:otherwise>
					</c:choose>
				</td>
			<tr>
				<th>주소</th>
				<td colspan="3">${getBestPracticesContest.user_address}</td>
			</tr>
			<tr>
				<td colspan="4" style="padding: 20px; height: 100px;">
				${getBestPracticesContest.contents}
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<c:if test="${getBestPracticesContest.server_file_name ne NULL}">
						<a href="/cms/module/bestPracticesContest/download/${getBestPracticesContest.homepage_id}/${getBestPracticesContest.best_practices_idx}.do"><i class="fa fa-floppy-o"></i>${getBestPracticesContest.org_file_name}.${getBestPracticesContest.file_extension}</a>
					</c:if>
					<c:if test="${getBestPracticesContest.server_file_name eq NULL}">
						첨부파일이 없습니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<c:if test="${getBestPracticesContest.server_file_name2 ne NULL}">
						<a href="/cms/module/bestPracticesContest/download/${getBestPracticesContest.homepage_id}/${getBestPracticesContest.best_practices_idx}2.do"><i class="fa fa-floppy-o"></i>${getBestPracticesContest.org_file_name2}.${getBestPracticesContest.file_extension2}</a>
					</c:if>
					<c:if test="${getBestPracticesContest.server_file_name2 eq NULL}">
						첨부파일이 없습니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<c:if test="${getBestPracticesContest.server_file_name3 ne NULL}">
						<a href="/cms/module/bestPracticesContest/download/${getBestPracticesContest.homepage_id}/${getBestPracticesContest.best_practices_idx}3.do"><i class="fa fa-floppy-o"></i>${getBestPracticesContest.org_file_name3}.${getBestPracticesContest.file_extension3}</a>
					</c:if>
					<c:if test="${getBestPracticesContest.server_file_name3 eq NULL}">
						첨부파일이 없습니다.
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="wrapper-bbs right">
		<span>※ 수정/삭제 시 비밀번호 입력 : </span>
		<input type="password" id="password_ok" cssClass="text" />
	</div>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="modify_btn" class="btn btn1">수정하기</a>
		<a href="#" id="delete_btn" class="btn btn5">삭제하기</a>
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

