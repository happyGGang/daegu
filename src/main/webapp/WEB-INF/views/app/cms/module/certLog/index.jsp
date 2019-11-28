<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){

});
</script>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="10px;" />
			<col width="80px;" />
			<col width="20px;" />
			<col width="20px;" />
			<col width="30px;" />
			<col width="50px;" />
			<col width="60px;" />
			<col width="50px;" />
			<col width="200px;" />
			<col width="50px;" />
		</colgroup>
		<thead>
			<tr>
				<th>IDX</th>
				<th>DATE</th>
				<th>MODE</th>
				<th>TYPE</th>
				<th>NAME</th>
				<th>BIRTHDAY</th>
				<th>CELL PHONE</th>
				<th>CI</th>
				<th>MSG</th>
				<th>IP</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(homepageList) < 1}">
			<tr>
				<td colspan="10">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${certLogList}">
			<tr>
				<td>${i.log_idx}</td>
				<td>${i.log_date}</td>
				<td>${i.cert_mode}</td>
				<td>${i.cert_type}</td>
				<td>${i.name}</td>
				<td>${i.birthday}</td>
				<td>${i.cell_phone}</td>
				<td class="left">${i.ci}</td>
				<td class="left">${i.msg}</td>
				<td>${i.ip}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
