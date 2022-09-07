<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('form#bookReportClubView').serialize());
	});
	
});
</script>

<form:form modelAttribute="bookReportClub" id="bookReportClubView" >
<form:hidden path="homepage_id"/>
<form:hidden path="book_club_idx"/>
<form:hidden path="editMode"/>

	<table class="type1">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody>
			<tr>
				<th>참가분야</th>
				<td>
					<c:choose>
						<c:when test="${getBookReportClub.participation_field eq '0'}">소년부(초등~중등)</c:when>
						<c:when test="${getBookReportClub.participation_field eq '1'}">장년부(고등~일반)</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>동아리명</th>
				<td>${getBookReportClub.club_name}</td>
			</tr>
			<tr>
				<th>대표자명</th>
				<td>${getBookReportClub.rep_name}</td>
			</tr>
			<tr>
				<th>휴대폰(제1 연락처)</th>
				<td>${getBookReportClub.user_phone}</td>
			</tr>
			<tr>
				<th>휴대폰(제2 연락처)</th>
				<td>${getBookReportClub.user_phone2}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${getBookReportClub.user_email}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(${getBookReportClub.postcode}) ${getBookReportClub.address_base} ${getBookReportClub.address_detailed} </td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<c:choose>
						<c:when test="${getBookReportClub.approval_status eq '0'}">신청</c:when>
						<c:when test="${getBookReportClub.approval_status eq '1'}">승인</c:when>
						<c:when test="${getBookReportClub.approval_status eq '2'}">취소</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>첨부파일1</th>
				<td>
					<c:if test="${getBookReportClub.server_file_name ne NULL}">
						<a href="/cms/module/bookReportClub/download/${getBookReportClub.homepage_id}/${getBookReportClub.book_club_idx}.do"><i class="fa fa-floppy-o"></i>${getBookReportClub.org_file_name}.${getBookReportClub.file_extension}</a>
					</c:if>
					<c:if test="${getBookReportClub.server_file_name eq NULL}">
						첨부파일이 없습니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<th>첨부파일2</th>
				<td>
					<c:if test="${getBookReportClub.server_file_name2 ne NULL}">
						<a href="/cms/module/bookReportClub/download/${getBookReportClub.homepage_id}/${getBookReportClub.book_club_idx}2.do"><i class="fa fa-floppy-o"></i>${getBookReportClub.org_file_name2}.${getBookReportClub.file_extension2}</a>
					</c:if>
					<c:if test="${getBookReportClub.server_file_name2 eq NULL}">
						첨부파일이 없습니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<th>첨부파일3</th>
				<td>
					<c:if test="${getBookReportClub.server_file_name3 ne NULL}">
						<a href="/cms/module/bookReportClub/download/${getBookReportClub.homepage_id}/${getBookReportClub.book_club_idx}3.do"><i class="fa fa-floppy-o"></i>${getBookReportClub.org_file_name3}.${getBookReportClub.file_extension3}</a>
					</c:if>
					<c:if test="${getBookReportClub.server_file_name3 eq NULL}">
						첨부파일이 없습니다.
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

