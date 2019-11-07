<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<ul class="num">
	<li><fmt:formatNumber value="${webpageAccessResult[0].total_count}" type="number"/></li>
	<li><fmt:formatNumber value="${(webpageAccessResult[0].total_count / 6) * 5}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(webpageAccessResult[0].total_count / 6) * 4}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(webpageAccessResult[0].total_count / 6) * 3}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(webpageAccessResult[0].total_count / 6) * 2}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(webpageAccessResult[0].total_count / 6) * 1}" pattern="0"/></li>
	<li>0</li>
</ul>
<div class="graphWrap">
	<ul class="graph">
		<c:forEach var="i" varStatus="status" items="${webpageAccessResult}">
			<li>
				<div class="chart-info">
					<div class="barWrap">
						<div class="gauge" style="height:${i.result_count / webpageAccessResult[0].total_count * 100}%;">
							<div class="gauge_ly"><p><em>${i.result_count}</em> 회</p></div>
						</div>
					</div>
					<c:choose>
						<c:when test="${webpageAccess.date_type == 'TIME'}">
							<p class="txt">
								${status.index}시  
								<c:choose>
									<c:when test="${webpageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${webpageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose> 
							</p>
						</c:when>
						<c:when test="${webpageAccess.date_type == 'DAY'}">
							<p class="txt">
								${i.result_date}
								<c:choose>
									<c:when test="${webpageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${webpageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose> 
							</p>
						</c:when>
						<c:when test="${webpageAccess.date_type == 'MONTH'}">
							<p class="txt">
								${i.result_date}
								<c:choose>
									<c:when test="${webpageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${webpageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose> 
							</p>
						</c:when>
						<c:when test="${webpageAccess.date_type == 'YEAR'}">
							<p class="txt">
								${i.result_date}
								<c:choose>
									<c:when test="${webpageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${webpageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose> 
							</p>
						</c:when>
					</c:choose>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
