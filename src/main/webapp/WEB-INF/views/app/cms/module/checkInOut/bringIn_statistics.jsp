<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="bringInData" class="type1 center">
	<thead>
		<tr>
			<th rowspan="3">구분</th>
			<th rowspan="3">성별</th>
			<th colspan="10">생일연도</th>
			<th colspan="2">합계</th>
		</tr>
		<tr>
			<th colspan="2">2009</th>
			<th colspan="2">2010</th>
			<th colspan="2">2011</th>
			<th colspan="2">2012</th>
			<th colspan="2">2013</th>
			<th rowspan="2">이용자수<br>(명)</th>
			<th rowspan="2">이용시간<br>(분)</th>
		</tr>
		<tr>
			<th>이용자수<br>(명)</th>
			<th>이용시간<br>(분)</th>
			<th>이용자수<br>(명)</th>
			<th>이용시간<br>(분)</th>
			<th>이용자수<br>(명)</th>
			<th>이용시간<br>(분)</th>
			<th>이용자수<br>(명)</th>
			<th>이용시간<br>(분)</th>
			<th>이용자수<br>(명)</th>
			<th>이용시간<br>(분)</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="3">평일</td>
			<td>남</td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2009.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2009_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2010.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2010_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2011.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2011_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2012.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2012_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2013.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2013_남']}" pattern="#,###"/></td>
			<td>
				<c:set var="m_week_bringIn_user_count_all" value="${0 + bringInUsers['평일.2009.남'] + bringInUsers['평일.2010.남'] + bringInUsers['평일.2011.남'] + bringInUsers['평일.2012.남'] + bringInUsers['평일.2013.남']}"/>
				<fmt:formatNumber value="${m_week_bringIn_user_count_all}" pattern="#,###"/>
			</td>
			<td>
				<c:set var="m_week_bringIn_usage_hours_all" value="${0 + bringInUsageHours['평일_2009_남'] + bringInUsageHours['평일_2010_남'] + bringInUsageHours['평일_2011_남'] + bringInUsageHours['평일_2012_남'] + bringInUsageHours['평일_2013_남']}"/>
				<fmt:formatNumber value="${m_week_bringIn_usage_hours_all}" pattern="#,###"/>
			</td>
		</tr>
		<tr>
			<td>여</td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2009.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2009_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2010.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2010_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2011.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2011_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2012.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2012_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2013.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2013_여']}" pattern="#,###"/></td>
			<td>
				<c:set var="w_week_bringIn_user_count_all" value="${0 + bringInUsers['평일.2009.여'] + bringInUsers['평일.2010.여'] + bringInUsers['평일.2011.여'] + bringInUsers['평일.2012.여'] + bringInUsers['평일.2013.여']}"/>
				<fmt:formatNumber value="${w_week_bringIn_user_count_all}" pattern="#,###"/>		
			</td>
			<td>
				<c:set var="w_week_bringIn_usage_hours_all" value="${0 + bringInUsageHours['평일_2009_여'] + bringInUsageHours['평일_2010_여'] + bringInUsageHours['평일_2011_여'] + bringInUsageHours['평일_2012_여'] + bringInUsageHours['평일_2013_여']}"/>
				<fmt:formatNumber value="${w_week_bringIn_usage_hours_all}" pattern="#,###"/>
			</td>
		</tr>
		<tr>
			<td>합계</td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2009.남'] + bringInUsers['평일.2009.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2009_남'] + bringInUsageHours['평일_2009_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2010.남'] + bringInUsers['평일.2010.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2010_남'] + bringInUsageHours['평일_2010_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2011.남'] + bringInUsers['평일.2011.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2011_남'] + bringInUsageHours['평일_2011_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2012.남'] + bringInUsers['평일.2012.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2012_남'] + bringInUsageHours['평일_2012_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2013.남'] + bringInUsers['평일.2013.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2013_남'] + bringInUsageHours['평일_2013_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_week_bringIn_user_count_all + w_week_bringIn_user_count_all}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_week_bringIn_usage_hours_all + w_week_bringIn_usage_hours_all}" pattern="#,###"/></td>
		</tr>
		<tr>
			<td rowspan="3">주말</td>
			<td>남</td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2009.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2009_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2010.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2010_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2011.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2011_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2012.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2012_남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2013.남']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2013_남']}" pattern="#,###"/></td>
			<td>
				<c:set var="m_weekend_bringIn_user_count_all" value="${0 + bringInUsers['주말.2009.남'] + bringInUsers['주말.2010.남'] + bringInUsers['주말.2011.남'] + bringInUsers['주말.2012.남'] + bringInUsers['주말.2013.남']}"/>
				<fmt:formatNumber value="${m_weekend_bringIn_user_count_all}" pattern="#,###"/>
			</td>
			<td>
				<c:set var="m_weekend_bringIn_usage_hours_all" value="${0 + bringInUsageHours['주말_2009_남'] + bringInUsageHours['주말_2010_남'] + bringInUsageHours['주말_2011_남'] + bringInUsageHours['주말_2012_남'] + bringInUsageHours['주말_2013_남']}"/>
				<fmt:formatNumber value="${m_weekend_bringIn_usage_hours_all}" pattern="#,###"/>
			</td>
		</tr>
		<tr>
			<td>여</td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2009.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2009_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2010.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2010_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2011.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2011_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2012.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2012_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2013.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2013_여']}" pattern="#,###"/></td>
			<td>
				<c:set var="w_weekend_bringIn_user_count_all" value="${0 + bringInUsers['주말.2009.여'] + bringInUsers['주말.2010.여'] + bringInUsers['주말.2011.여'] + bringInUsers['주말.2012.여'] + bringInUsers['주말.2013.여']}"/>
				<fmt:formatNumber value="${w_weekend_bringIn_user_count_all}" pattern="#,###"/>		
			</td>
			<td>
				<c:set var="w_weekend_bringIn_usage_hours_all" value="${0 + bringInUsageHours['주말_2009_여'] + bringInUsageHours['주말_2010_여'] + bringInUsageHours['주말_2011_여'] + bringInUsageHours['주말_2012_여'] + bringInUsageHours['주말_2013_여']}"/>
				<fmt:formatNumber value="${w_weekend_bringIn_usage_hours_all}" pattern="#,###"/>
			</td>
		</tr>
		<tr>
			<td>합계</td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2009.남'] + bringInUsers['주말.2009.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2009_남'] + bringInUsageHours['주말_2009_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2010.남'] + bringInUsers['주말.2010.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2010_남'] + bringInUsageHours['주말_2010_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2011.남'] + bringInUsers['주말.2011.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2011_남'] + bringInUsageHours['주말_2011_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2012.남'] + bringInUsers['주말.2012.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2012_남'] + bringInUsageHours['주말_2012_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['주말.2013.남'] + bringInUsers['주말.2013.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['주말_2013_남'] + bringInUsageHours['주말_2013_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_weekend_bringIn_user_count_all + w_weekend_bringIn_user_count_all}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_weekend_bringIn_usage_hours_all + w_weekend_bringIn_usage_hours_all}" pattern="#,###"/></td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<th colspan="2">전체합계</th>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2009.남'] + bringInUsers['평일.2009.여'] + bringInUsers['주말.2009.남'] + bringInUsers['주말.2009.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2009_남'] + bringInUsageHours['평일_2009_여'] + bringInUsageHours['주말_2009_남'] + bringInUsageHours['주말_2009_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2010.남'] + bringInUsers['평일.2010.여'] + bringInUsers['주말.2010.남'] + bringInUsers['주말.2010.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2010_남'] + bringInUsageHours['평일_2010_여'] + bringInUsageHours['주말_2010_남'] + bringInUsageHours['주말_2010_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2011.남'] + bringInUsers['평일.2011.여'] + bringInUsers['주말.2011.남'] + bringInUsers['주말.2011.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2011_남'] + bringInUsageHours['평일_2011_여'] + bringInUsageHours['주말_2011_남'] + bringInUsageHours['주말_2011_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2012.남'] + bringInUsers['평일.2012.여'] + bringInUsers['주말.2012.남'] + bringInUsers['주말.2012.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2012_남'] + bringInUsageHours['평일_2012_여'] + bringInUsageHours['주말_2012_남'] + bringInUsageHours['주말_2012_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsers['평일.2013.남'] + bringInUsers['평일.2013.여'] + bringInUsers['주말.2013.남'] + bringInUsers['주말.2013.여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${0 + bringInUsageHours['평일_2013_남'] + bringInUsageHours['평일_2013_여'] + bringInUsageHours['주말_2013_남'] + bringInUsageHours['주말_2013_여']}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_week_bringIn_user_count_all + w_week_bringIn_user_count_all + m_weekend_bringIn_user_count_all + w_weekend_bringIn_user_count_all}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${m_week_bringIn_usage_hours_all + w_week_bringIn_usage_hours_all + m_weekend_bringIn_usage_hours_all + w_weekend_bringIn_usage_hours_all}" pattern="#,###"/></td>
		</tr>
	</tfoot>
</table>