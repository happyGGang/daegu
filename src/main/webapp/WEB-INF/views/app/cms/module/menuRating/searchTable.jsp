<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="averageTable" class="chartData">
	<thead>
		<tr>
			<th>순서</th>
			<th>날짜</th>
			<th>홈페이지</th>
			<th>메뉴번호</th>
			<th>메뉴</th>
			<th>점수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${menuRatingAverageList}" var="i" varStatus="status">
		<tr>
			<td class="num">${paging.listRowNum - status.index}</td>
			<td>${i.result_date}</td>
			<td>
			<c:forEach items="${homepageList}" var="j">
				<c:if test="${i.homepage_id eq j.homepage_id}">
				${j.homepage_name}
				</c:if>
			</c:forEach>
			</td>
			<td>${i.menu_idx}</td>
			<td>${i.menu_name}</td>
			<td>${i.rating_average_score}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>