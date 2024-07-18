<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="allData" class="type1 center">
	<thead>
		<tr>
			<th rowspan="3">구분</th>
			<th rowspan="3">성별</th>
			<th colspan="5">생일연도</th>
			<th colspan="2">합계</th>
		</tr>
		<tr>
			<th>2009</th>
			<th>2010</th>
			<th>2011</th>
			<th>2012</th>
			<th>2013</th>
			<th></th>
		</tr>
		<tr>
			<th>이용자수(명)</th>
			<th>이용자수(명)</th>
			<th>이용자수(명)</th>
			<th>이용자수(명)</th>
			<th>이용자수(명)</th>
			<th>이용자수(명)</th>
		</tr>
	</thead>
	<tbody>

	<c:set var="total2009All" value="0" />
	<c:set var="total2010All" value="0" />
	<c:set var="total2011All" value="0" />
	<c:set var="total2012All" value="0" />
	<c:set var="total2013All" value="0" />

	<c:forEach var="i" varStatus="status" items="${questionList}">
		<tr>
			<c:set var="key2009m" value="${i.checkinout_survey_question_title}.2009.남" />
			<c:set var="key2010m" value="${i.checkinout_survey_question_title}.2010.남" />
			<c:set var="key2011m" value="${i.checkinout_survey_question_title}.2011.남" />
			<c:set var="key2012m" value="${i.checkinout_survey_question_title}.2012.남" />
			<c:set var="key2013m" value="${i.checkinout_survey_question_title}.2013.남" />

			<td rowspan="3">${i.checkinout_survey_question_title}</td>
			<td>남</td>
			<td><fmt:formatNumber value="${0 + allUsers[key2009m]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2010m]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2011m]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2012m]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2013m]}" pattern="#,###"/></td>
			<td>
				<c:set var="m_week_user_count_all" value="${0 + allUsers[key2009m] + allUsers[key2010m] + allUsers[key2011m] + allUsers[key2012m] + allUsers[key2013m]}"/>
				<fmt:formatNumber value="${m_week_user_count_all}" pattern="#,###"/>
			</td>
		</tr>
		<tr>
			<c:set var="key2009w" value="${i.checkinout_survey_question_title}.2009.여" />
			<c:set var="key2010w" value="${i.checkinout_survey_question_title}.2010.여" />
			<c:set var="key2011w" value="${i.checkinout_survey_question_title}.2011.여" />
			<c:set var="key2012w" value="${i.checkinout_survey_question_title}.2012.여" />
			<c:set var="key2013w" value="${i.checkinout_survey_question_title}.2013.여" />

			<td>여</td>
			<td><fmt:formatNumber value="${0 + allUsers[key2009w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2010w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2011w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2012w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2013w]}" pattern="#,###"/></td>
			<td>
				<c:set var="w_week_user_count_all" value="${0 + allUsers[key2009w] + allUsers[key2010w] + allUsers[key2011w] + allUsers[key2012w] + allUsers[key2013w]}"/>
				<fmt:formatNumber value="${w_week_user_count_all}" pattern="#,###"/>		
			</td>
		</tr>
		<tr>
			<td>합계</td>
			<td><fmt:formatNumber value="${0 + allUsers[key2009m] + allUsers[key2009w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2010m] + allUsers[key2010w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2011m] + allUsers[key2011w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2012m] + allUsers[key2012w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + allUsers[key2013m] + allUsers[key2013w]}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_week_user_count_all + w_week_user_count_all}" pattern="#,###"/></td>
		</tr>

		<c:set var="total2009All" value="${total2009All + allUsers[key2009m] + allUsers[key2009w]}" />
		<c:set var="total2010All" value="${total2010All + allUsers[key2010m] + allUsers[key2010w]}" />
		<c:set var="total2011All" value="${total2011All + allUsers[key2011m] + allUsers[key2011w]}" />
		<c:set var="total2012All" value="${total2012All + allUsers[key2012m] + allUsers[key2012w]}" />
		<c:set var="total2013All" value="${total2013All + allUsers[key2013m] + allUsers[key2013w]}" />
	</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<th colspan="2">전체합계</th>
			<td><fmt:formatNumber value="${total2009All}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${total2010All}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${total2011All}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${total2012All}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${total2013All}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${total2009All + total2010All + total2011All + total2012All + total2013All}" pattern="#,###"/></td>
		</tr>
	</tfoot>
</table>