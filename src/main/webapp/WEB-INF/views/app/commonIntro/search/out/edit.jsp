<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
$(function() {
	$('a.apply').on('click', function(e) {
		e.preventDefault();
		if (!confirm('상호대차 신청하겠습니까?')) {
			return false;
		}
		
		$('#outReqEditForm #editMode').val('ADD');

		if ( doAjaxPost($('#outReqEditForm')) ) {}
	});
	
	$('a#cancel').on('click', function(e) {
		e.preventDefault();
		location.href = '/${homepage.context_path}/intro/search/detail.do?vLoca=${fn:escapeXml(librarySearch.vLoca)}&vCtrl=${fn:escapeXml(librarySearch.vCtrl)}&vImg=${fn:escapeXml(librarySearch.vImg)}&isbn=${fn:escapeXml(librarySearch.isbn)}&tid=${fn:escapeXml(librarySearch.tid)}&menu_idx=${fn:escapeXml(librarySearch.menu_idx)}';
	});
	
});
</script>

<style>
	th, td {font-size:14px;}
</style>

<form:form id="outReqEditForm" modelAttribute="librarySearch" action="save.do">
	<form:hidden path="editMode"/>
	<input type="hidden" name="vItemLoca" value="${fn:escapeXml(librarySearch.vLoca)}">
	<input type="hidden" name="title" value="${fn:escapeXml(librarySearch.title)}">
	<input type="hidden" name="vAccNo" value="${fn:escapeXml(librarySearch.vAccNo)}">
	<input type="hidden" name="vCtrl" value="${fn:escapeXml(librarySearch.vCtrl)}">
	<input type="hidden" name="tid" value="${fn:escapeXml(librarySearch.tid)}"/>
	<input type="hidden" name="vImg" value="${fn:escapeXml(librarySearch.vImg)}">
	<input type="hidden" name="isbn" value="${fn:escapeXml(librarySearch.isbn)}">
	<input type="hidden" name="menu_idx" value="${fn:escapeXml(librarySearch.menu_idx)}">
</form:form>

<h3>상호대차 정보 입력</h3>
<div class="showFoldDiv" style="padding-top: 20px;">
		<table summary="상호대차 정보 입력">
						<tr>
							<th>신청인</th>
							<td>
								${member.member_name}
							</td>
						</tr>
						<tr>
							<th>제공도서관</th>
							<td>
								<c:choose>
									<c:when test="${librarySearch.vLoca eq '00147105'}">
									고령도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147003'}">
									구미도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147004'}">
									삼국유사군위도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147006'}">
									점촌도서관가은분관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147007'}">
									봉화도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147008'}">
									상주도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147009'}">
									성주도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147010'}">
									안동도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147011'}">
									안동도서관 용상분관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147012'}">
									영양도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147013'}">
									영일도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147014'}">
									금호도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147015'}">
									예천도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147016'}">
									외동도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147017'}">
									울릉도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147018'}">
									울진도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147019'}">
									의성도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147020' or librarySearch.vLoca eq '00147006'}">
									점촌도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147021'}">
									청도도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147022'}">
									청송도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147023'}">
									칠곡도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147024'}">
									영주선비도서관풍기분관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147031'}">
									영덕도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147032'}">
									영주선비도서관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147039'}">
									안동도서관풍산분관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147040'}">
									상주도서관화령분관
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147046'}">
									경상북도교육청정보센터
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00147105'}">
									경상북도교육청문화원
									</c:when>
									<c:when test="${librarySearch.vLoca eq '00347034'}">
									경상북도교육청연수원
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>수령도서관</th>
							<td>
								${member.loca_name} <br/>
								<span style="color:red">* 소속도서관에서만 수령가능합니다.</span>
							</td>
						</tr>
						<tr>
							<th>도서명</th>
							<td>${librarySearch.title}</td>
						</tr>
						<tr>
							<th>도서등록번호</th>
							<td>${librarySearch.vAccNo}</td>
						</tr>
		</table>
		
	</div>
	<div style="text-align: center; padding-top: 25px;"> 
		<a href="#" class="btn btn1 apply">신청</a>
		<a href="#" id="cancel" class="btn">취소</a>
	</div>
