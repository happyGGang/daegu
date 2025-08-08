<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<ul class="num">
	<li><fmt:formatNumber value="${homepageAccessResult[0].total_count}" type="number"/></li>
	<li><fmt:formatNumber value="${(homepageAccessResult[0].total_count / 6) * 5}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(homepageAccessResult[0].total_count / 6) * 4}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(homepageAccessResult[0].total_count / 6) * 3}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(homepageAccessResult[0].total_count / 6) * 2}" pattern="0"/></li>
	<li><fmt:formatNumber value="${(homepageAccessResult[0].total_count / 6) * 1}" pattern="0"/></li>
	<li>0</li>
</ul>
<div class="graphWrap">
	<ul class="graph">
		<c:forEach var="i" varStatus="status" items="${homepageAccessResult}">
			<li>
				<div class="chart-info">
					<div class="barWrap">
						<div class="gauge" style="height:${i.result_count / homepageAccessResult[0].total_count * 100}%;">
							<div class="gauge_ly"><p><em>${i.result_count}</em> 명</p></div>
						</div>
					</div>
					<c:choose>
						<c:when test="${homepageAccess.date_type == 'TIME'}">
							<p class="txt">
								${status.index}시
								<c:choose>
									<c:when test="${homepageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${homepageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose>
							</p>
						</c:when>
						<c:when test="${homepageAccess.date_type == 'DAY'}">
							<p class="txt">
								${i.result_date}
								<c:choose>
									<c:when test="${homepageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${homepageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose>
							</p>
						</c:when>
						<c:when test="${homepageAccess.date_type == 'MONTH'}">
							<p class="txt">
								${i.result_date}
								<c:choose>
									<c:when test="${homepageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${homepageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose>
							</p>
						</c:when>
						<c:when test="${homepageAccess.date_type == 'YEAR'}">
							<p class="txt">
								${i.result_date}
								<c:choose>
									<c:when test="${homepageAccess.search_type eq 'OS'}"><br/> ${i.operating_system}</c:when>
									<c:when test="${homepageAccess.search_type eq 'BROWSER'}"><br/> ${i.browser_type}</c:when>
								</c:choose>
							</p>
						</c:when>
					</c:choose>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>

<div style="clear:both">&nbsp;</div><br/>

<table id="accessTableData" class="chartData custom-table">
    <thead>
        <tr>
            <c:choose>
                <c:when test="${homepageAccess.date_type == 'TIME'}">
                    <th width="200">시간</th>
                </c:when>
                <c:when test="${homepageAccess.date_type == 'DAY'}">
                    <th width="200">일</th>
                </c:when>
                <c:when test="${homepageAccess.date_type == 'MONTH'}">
                    <th width="200">월</th>
                </c:when>
                <c:when test="${homepageAccess.date_type == 'YEAR'}">
                    <th width="200">년</th>
                </c:when>
            </c:choose>
            <th>접속자 수</th>
        </tr>
    </thead>
    <tbody>
        <c:set var="totalCount" value="${homepageAccessResult[0].total_count}"/>
            <c:forEach var="i" varStatus="status" items="${homepageAccessResult}">
                <tr>
                    <td>${i.result_date}
                        <c:choose>
                            <c:when test="${homepageAccess.search_type eq 'OS'}"> / ${i.operating_system}</c:when>
                            <c:when test="${homepageAccess.search_type eq 'BROWSER'}"> / ${i.browser_type}</c:when>
                            <c:when test="${homepageAccess.search_type eq 'DEVICE'}"> / ${i.access_system}</c:when>
                        </c:choose>
                    </td>
                    <td style="width:250px" class="ratioBar">
                        <c:choose>
                            <c:when test="${i.result_count ne 0}">
                                <div class="bar" style="width:${(i.result_count / totalCount) * 100}%">
                                    ${i.result_count} (<fmt:formatNumber value="${(i.result_count / totalCount) * 100}" pattern="0"/>%)
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="caption">0 (0%)</div>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        <tr>
            <th>합계</th>
            <td colspan="2">${totalCount}<em>${totalCount eq 0 ? ' (0%)' : ' (100%)'}</em></td>
        </tr>
    </tbody>
</table>