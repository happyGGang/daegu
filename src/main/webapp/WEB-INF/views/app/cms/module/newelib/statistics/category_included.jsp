<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<table class="type1 center" id="data-table">
		<colgroup>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
			<col width="80"/>
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" colspan="1">구분</th>
				<th rowspan="2" colspan="1">카테고리</th>
				<th rowspan="2" colspan="1">PC 대출 수</th>
				<th rowspan="1" colspan="4">스마트폰 대출 수</th>
				<th rowspan="2" colspan="1">기타(불명) 대출 수</th>
				<th rowspan="2" colspan="1">소계</th>
			</tr>
			<tr>
				<th>Android</th>
				<th>iOS</th>
				<th>(구 스마트폰 대출 수)</th>
				<th>스마트폰 합계</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(elibStatisticsMapList) < 1}">
				<tr style="height:100%">
					<td colspan="9" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:set var="prevType" value="EBK"/>
			<c:set var="subpCnt" value="0"/>
			<c:set var="subsCnt" value="0"/>
			<c:set var="subaCnt" value="0"/>
			<c:set var="subiCnt" value="0"/>
			<c:set var="subsaiCnt" value="0"/>
			<c:set var="subeCnt" value="0"/>
			<c:set var="subtotalCnt" value="0"/>
			<c:set var="pCnt" value="0"/>
			<c:set var="sCnt" value="0"/>
			<c:set var="aCnt" value="0"/>
			<c:set var="iCnt" value="0"/>
			<c:set var="saiCnt" value="0"/>
			<c:set var="eCnt" value="0"/>
			<c:set var="totalCnt" value="0"/>
			<c:if test="${fn:length(elibStatisticsMapList) > 0}">
			<c:forEach var="i" varStatus="status" items="${categories}">
				<c:if test="${prevType ne i.type}">
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + subpCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subaCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subiCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subsCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subsaiCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subeCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subtotalCnt}" pattern="#,###" /></th>
					<c:set var="subpCnt" value="0"/>
					<c:set var="subsCnt" value="0"/>
					<c:set var="subaCnt" value="0"/>
					<c:set var="subiCnt" value="0"/>
					<c:set var="subsaiCnt" value="0"/>
					<c:set var="subeCnt" value="0"/>
					<c:set var="subtotalCnt" value="0"/>
					<c:set var="prevType" value="${i.type}"/>
				</tr>
				</c:if>
				<c:set var="P" value="${i.type}.${i.cate_id}.P"/>
				<c:set var="A" value="${i.type}.${i.cate_id}.A"/>
				<c:set var="I" value="${i.type}.${i.cate_id}.I"/>
				<c:set var="S" value="${i.type}.${i.cate_id}.S"/>
				<c:set var="E" value="${i.type}.${i.cate_id}.E"/>
				<c:set var="type_name" value="${i.type eq 'EBK' ? '전자책' : (i.type eq 'ADO' ? '오디오북' : (i.type eq 'WEB' ? '온라인강좌' : '기타')) }"/>
				<tr>
					<td>${type_name}</td>
					<td>${i.cate_name}</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[P]}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[A]}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[I]}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[S]}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[S] + elibStatisticsMap[A] + elibStatisticsMap[I]}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[E]}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsMap[P] + elibStatisticsMap[S] + elibStatisticsMap[A] + elibStatisticsMap[I] + elibStatisticsMap[E]}" pattern="#,###" /></td>
					<c:set var="pCnt" value="${0 + pCnt + elibStatisticsMap[P]}"/>
					<c:set var="aCnt" value="${0 + aCnt + elibStatisticsMap[A]}"/>
					<c:set var="iCnt" value="${0 + iCnt + elibStatisticsMap[I]}"/>
					<c:set var="sCnt" value="${0 + sCnt + elibStatisticsMap[S]}"/>
					<c:set var="saiCnt" value="${0 + saiCnt + (elibStatisticsMap[S] + elibStatisticsMap[A] + elibStatisticsMap[I])}"/>
					<c:set var="eCnt" value="${0 + eCnt + elibStatisticsMap[e]}"/>
					<c:set var="totalCnt" value="${0 + totalCnt + (elibStatisticsMap[P] + elibStatisticsMap[S] + elibStatisticsMap[A] + elibStatisticsMap[I] + elibStatisticsMap[E])}"/>
					<c:set var="subpCnt" value="${0 + subpCnt + elibStatisticsMap[P]}"/>
					<c:set var="subaCnt" value="${0 + subaCnt + elibStatisticsMap[A]}"/>
					<c:set var="subiCnt" value="${0 + subiCnt + elibStatisticsMap[I]}"/>
					<c:set var="subsCnt" value="${0 + subsCnt + elibStatisticsMap[S]}"/>
					<c:set var="subsaiCnt" value="${0 + subsaiCnt + (elibStatisticsMap[S] + elibStatisticsMap[A] + elibStatisticsMap[I])}"/>
					<c:set var="subeCnt" value="${0 + subeCnt + elibStatisticsMap[e]}"/>
					<c:set var="subtotalCnt" value="${0 + subtotalCnt + (elibStatisticsMap[P] + elibStatisticsMap[S] + elibStatisticsMap[A] + elibStatisticsMap[I] + elibStatisticsMap[E])}"/>
				</tr>
			</c:forEach>
			</c:if>
				<c:if test="${fn:length(elibStatisticsMapList) > 0}">
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + subpCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subaCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subiCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subsCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subsaiCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subeCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + subtotalCnt}" pattern="#,###" /></th>
				</tr>
				<tr>
					<th>합계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + pCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + aCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + iCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + sCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + saiCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + eCnt}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + totalCnt}" pattern="#,###" /></th>
				</tr>
				</c:if>
		</tbody>
	</table>