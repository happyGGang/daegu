<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form:form id="paymentMember" modelAttribute="paymentMember" method="POST">
<table class="type2 table1">
	<colgroup>
		<col width="160" />
		<col width="60"/>
		<col width="150"/>
		<col width="100"/>
		<col width="*"/>
	</colgroup>
	<tbody>
	<tr>
		<th>이름</th>
		<th>성별</th>
		<th>연락처</th>
		<th>생년월일</th>
		<th>기타</th>
	</tr>
	<c:forEach var="i" items="${familyMemberList}" varStatus="status">
		<tr>
			<td>${i.family_name}</td>
			<td>
				<c:choose>
					<c:when test="${i.family_sex eq 'M'}">
						남
					</c:when>
					<c:otherwise>
						여
					</c:otherwise>
				</c:choose>
			</td>
			<td>${i.family_phone}</td>
			<td>${i.family_birth}</td>
			<td>
				<c:choose>
					<c:when test="${not empty i.family_etc}">
						<a href="javascript:void(0);" class="btn btn1" onclick="alert('${i.family_etc}');">보기</a>
					</c:when>
					<c:otherwise>
						없음
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</form:form>