<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table id="accessTableData" class="chartData">
	<thead>
		<tr>
			<th colspan="2">메뉴명</th>
			<th colspan="2">접속자 수</th>
			<th colspan="1">백분율</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="i" varStatus="status" items="${menuAccessResult}">	
			<%-- <tr<% if(j%2==0){ %> class="even"<% } %>> --%>
			<tr>
				<td class="left" colspan="2">
				<c:forEach var="j" begin="2" end="${i.menu_level}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
				${i.menu_name}</td>
				<td class="ratio left" colspan="2">${i.access_count}<%-- <em>(<fmt:formatNumber value="${i.result_count / homepageAccessResult[0].total_count * 100}" pattern="0"/>%)</em> --%></td>
				<td class="ratio left" colspan="1">
				<c:if test="${menuAccessResult[0].total_count == 0}">
					0
				</c:if>
				<c:if test="${menuAccessResult[0].total_count != 0}">
					<fmt:formatNumber value="${i.access_count / menuAccessResult[0].total_count * 100}" pattern="0"/>
				</c:if>
				%</td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th colspan="2">합계</th>
			<td colspan="2">${menuAccessResult[0].total_count}</td>
			<td colspan="1">
				<c:if test="${menuAccessResult[0].total_count == 0}">
					0
				</c:if>
				<c:if test="${menuAccessResult[0].total_count != 0}">
					100
				</c:if>
			%</td>
		</tr>
	</tfoot>
</table>