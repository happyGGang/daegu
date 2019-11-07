<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
<c:when test="${not empty memberInfo.WEB_ID}">
<table>
	<tr>
		<th>성명</th>
		<th>아이디</th>
	</tr>
	<tr>
		<td>${memberInfo.USER_NAME}</td>
		<td>${memberInfo.WEB_ID}</td>
	</tr>
</table>
<br/>
<br/>
</c:when>


<c:otherwise>
<table>
	<tr>
		<th>성명</th>
		<th>아이디</th>
	</tr>
	<tr>
		<td>${memberInfo.USER_NAME}</td>
		<td width="80%;">
			생성된 웹 아이디가 없습니다. 신규 회원가입 후 통합회원 전환 과정을 통해 아이디 생성하시기 바랍니다.
		</td>
	</tr>
</table>
<br/>
<br/>
</c:otherwise>
</c:choose>




