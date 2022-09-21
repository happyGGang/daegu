<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<table class="type1 center" id="data-table">
		<thead>
			<tr>
				<th rowspan="2" colspan="1">구분</th>
				<th rowspan="2" colspan="1">공급사</th>
				<th rowspan="2" colspan="1" style="border-right: solid 2px silver;">소장자료수</th>
				<th rowspan="2" colspan="1">PC 대출 수</th>
				<th rowspan="1" colspan="4">스마트폰 대출 수</th>
				<th rowspan="2" colspan="1">기타(불명) 대출 수</th>
				<th rowspan="2" colspan="1">대출소계</th>
			</tr>
			<tr>
				<th>Android</th>
				<th>iOS</th>
				<th>(구 스마트폰 대출 수)</th>
				<th>스마트폰 합계</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td rowspan="6">전자책</td>
				<td>교보문고</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.KYOB.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.KYOB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.P'] + elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.KYOB.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>영풍문고</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.Y2BK.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.Y2BK.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.Y2BK.P'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.Y2BK.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>북큐브</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.FXLI.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.FXLI.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.FXLI.P'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.FXLI.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>YES24</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.YESB.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.YESB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.YESB.P'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.YESB.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>ECO</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.ECO.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.ECO.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.ECO.P'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.ECO.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>OPMS</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.OPMS.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.A'] + elibStatisticsMap['EBK.OPMS.I'] + elibStatisticsMap['EBK.OPMS.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.OPMS.P'] + elibStatisticsMap['EBK.OPMS.A'] + elibStatisticsMap['EBK.OPMS.I'] + elibStatisticsMap['EBK.OPMS.S'] + elibStatisticsMap['EBK.OPMS.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<th>소계</th>
				<th>-</th>
				<th style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EBK.KYOB.-'] + elibStatisticsMap2['EBK.Y2BK.-'] + elibStatisticsMap2['EBK.FXLI.-'] + elibStatisticsMap2['EBK.YESB.-'] + elibStatisticsMap2['EBK.ECO.-'] + elibStatisticsMap2['EBK.OPMS.-']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.P'] + elibStatisticsMap['EBK.Y2BK.P'] + elibStatisticsMap['EBK.FXLI.P'] + elibStatisticsMap['EBK.YESB.P'] + elibStatisticsMap['EBK.ECO.P'] + elibStatisticsMap['EBK.OPMS.P']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.OPMS.A']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.OPMS.I']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.OPMS.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.OPMS.A'] + elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.OPMS.I'] + elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.OPMS.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.E'] + elibStatisticsMap['EBK.Y2BK.E'] + elibStatisticsMap['EBK.FXLI.E'] + elibStatisticsMap['EBK.YESB.E'] + elibStatisticsMap['EBK.ECO.E'] + elibStatisticsMap['EBK.OPMS.E']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EBK.KYOB.P'] + elibStatisticsMap['EBK.Y2BK.P'] + elibStatisticsMap['EBK.FXLI.P'] + elibStatisticsMap['EBK.YESB.P'] + elibStatisticsMap['EBK.ECO.P'] + elibStatisticsMap['EBK.OPMS.P'] + elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.OPMS.A'] + elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.OPMS.I'] + elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.OPMS.S'] + elibStatisticsMap['EBK.KYOB.E'] + elibStatisticsMap['EBK.Y2BK.E'] + elibStatisticsMap['EBK.FXLI.E'] + elibStatisticsMap['EBK.YESB.E'] + elibStatisticsMap['EBK.ECO.E'] + elibStatisticsMap['EBK.OPMS.E']}" pattern="#,###" /></th>
			</tr>
			<tr>
				<td rowspan="3">오디오북</td>
				<td>북큐브</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['ADO.FXLI.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.FXLI.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.P'] + elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.FXLI.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>오디언</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['ADO.HANS.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.HANS.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.HANS.P'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.HANS.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>컨텐츠포탈</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['ADO.CONT.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.A'] + elibStatisticsMap['ADO.CONT.I'] + elibStatisticsMap['ADO.CONT.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.CONT.P'] + elibStatisticsMap['ADO.CONT.A'] + elibStatisticsMap['ADO.CONT.I'] + elibStatisticsMap['ADO.CONT.S'] + elibStatisticsMap['ADO.CONT.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<th>소계</th>
				<th>-</th>
				<th style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['ADO.FXLI.-'] + elibStatisticsMap2['ADO.HANS.-'] + elibStatisticsMap2['ADO.CONT.-']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.P'] + elibStatisticsMap['ADO.HANS.P'] + elibStatisticsMap['ADO.CONT.P']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.CONT.A']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.CONT.I']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.CONT.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.CONT.A'] + elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.CONT.I'] + elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.CONT.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.E'] + elibStatisticsMap['ADO.HANS.E'] + elibStatisticsMap['ADO.CONT.E']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['ADO.FXLI.P'] + elibStatisticsMap['ADO.HANS.P'] + elibStatisticsMap['ADO.CONT.P'] + elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.CONT.A'] + elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.CONT.I'] + elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.CONT.S'] + elibStatisticsMap['ADO.FXLI.E'] + elibStatisticsMap['ADO.HANS.E'] + elibStatisticsMap['ADO.CONT.E']}" pattern="#,###" /></th>
			</tr>
			<tr>
				<td rowspan="7">온라인강좌</td>
				<td>아트앤스터디</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.ARTN.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ARTN.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.P'] + elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ARTN.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>ECS미디어</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.ECSM.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.ECSM.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ECSM.P'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.ECSM.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>YBM시사</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.YBMN.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.YBMN.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YBMN.P'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.YBMN.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>컨텐츠포탈</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.CONT.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.CONT.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.CONT.P'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.CONT.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>글로벌21</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.GLOB.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.GLOB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.GLOB.P'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.GLOB.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>에듀윌</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.EDUW.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.EDUW.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.EDUW.P'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.EDUW.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<td>YES24북러닝</td>
				<td style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.YESB.-']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.A'] + elibStatisticsMap['WEB.YESB.I'] + elibStatisticsMap['WEB.YESB.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.YESB.P'] + elibStatisticsMap['WEB.YESB.A'] + elibStatisticsMap['WEB.YESB.I'] + elibStatisticsMap['WEB.YESB.S'] + elibStatisticsMap['WEB.YESB.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<th>소계</th>
				<th>-</th>
				<th style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['WEB.ARTN.-'] + elibStatisticsMap2['WEB.ECSM.-'] + elibStatisticsMap2['WEB.YBMN.-'] + elibStatisticsMap2['WEB.CONT.-'] + elibStatisticsMap2['WEB.GLOB.-'] + elibStatisticsMap2['WEB.EDUW.-'] + elibStatisticsMap2['WEB.YESB.-']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.P'] + elibStatisticsMap['WEB.ECSM.P'] + elibStatisticsMap['WEB.YBMN.P'] + elibStatisticsMap['WEB.CONT.P'] + elibStatisticsMap['WEB.GLOB.P'] + elibStatisticsMap['WEB.EDUW.P'] + elibStatisticsMap['WEB.YESB.P']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.YESB.A']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.YESB.I']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.YESB.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.YESB.A'] + elibStatisticsMap['WEB.YESB.I'] + elibStatisticsMap['WEB.YESB.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.E'] + elibStatisticsMap['WEB.ECSM.E'] + elibStatisticsMap['WEB.YBMN.E'] + elibStatisticsMap['WEB.CONT.E'] + elibStatisticsMap['WEB.GLOB.E'] + elibStatisticsMap['WEB.EDUW.E'] + elibStatisticsMap['WEB.YESB.E']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['WEB.ARTN.P'] + elibStatisticsMap['WEB.ECSM.P'] + elibStatisticsMap['WEB.YBMN.P'] + elibStatisticsMap['WEB.CONT.P'] + elibStatisticsMap['WEB.GLOB.P'] + elibStatisticsMap['WEB.EDUW.P'] + elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.ARTN.E'] + elibStatisticsMap['WEB.ECSM.E'] + elibStatisticsMap['WEB.YBMN.E'] + elibStatisticsMap['WEB.CONT.E'] + elibStatisticsMap['WEB.GLOB.E'] + elibStatisticsMap['WEB.EDUW.E'] + elibStatisticsMap['WEB.YESB.P'] + elibStatisticsMap['WEB.YESB.A'] + elibStatisticsMap['WEB.YESB.I'] + elibStatisticsMap['WEB.YESB.S'] + elibStatisticsMap['WEB.YESB.E']}" pattern="#,###" /></th>
			</tr>
			<tr>
				<td>온라인자료</td>
				<td>모아진</td>
				<td style="border-right: solid 2px silver;">-</td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap2['EXT.MOAZ.P']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.A']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.I']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.A'] + elibStatisticsMap['EXT.MOAZ.I'] + elibStatisticsMap['EXT.MOAZ.S']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.E']}" pattern="#,###" /></td>
				<td><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.P'] + elibStatisticsMap['EXT.MOAZ.A'] + elibStatisticsMap['EXT.MOAZ.I'] + elibStatisticsMap['EXT.MOAZ.S'] + elibStatisticsMap['EXT.MOAZ.E']}" pattern="#,###" /></td>
			</tr>
			<tr>
				<th>소계</th>
				<th>-</th>
				<th style="border-right: solid 2px silver;"><fmt:formatNumber value="${0 + elibStatisticsMap2['EXT.MOAZ.-']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.P']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.A']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.I']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.A'] + elibStatisticsMap['EXT.MOAZ.I'] + elibStatisticsMap['EXT.MOAZ.S']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.E']}" pattern="#,###" /></th>
				<th><fmt:formatNumber value="${0 + elibStatisticsMap['EXT.MOAZ.P'] + elibStatisticsMap['EXT.MOAZ.A'] + elibStatisticsMap['EXT.MOAZ.I'] + elibStatisticsMap['EXT.MOAZ.S'] + elibStatisticsMap['EXT.MOAZ.E']}" pattern="#,###" /></th>
			</tr>
			<tr class="strong">
				<th>합계</th>
				<th>-</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap2['EBK.KYOB.-'] + elibStatisticsMap2['EBK.Y2BK.-'] + elibStatisticsMap2['EBK.FXLI.-'] +
						elibStatisticsMap2['EBK.YESB.-'] + elibStatisticsMap2['EBK.ECO.-'] + elibStatisticsMap2['EBK.OPMS.-'] +
						elibStatisticsMap2['ADO.FXLI.-'] + elibStatisticsMap2['ADO.HANS.-'] + elibStatisticsMap2['ADO.CONT.-'] +
						elibStatisticsMap2['WEB.ARTN.-'] + elibStatisticsMap2['WEB.ECSM.-'] + elibStatisticsMap2['WEB.YBMN.-'] +
						elibStatisticsMap2['WEB.CONT.-'] + elibStatisticsMap2['WEB.GLOB.-'] + elibStatisticsMap2['WEB.EDUW.-'] +
						elibStatisticsMap2['WEB.YESB.-']
					}" pattern="#,###" />
				</th>
				<th  style="border-right: solid 2px silver;">
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.P'] + elibStatisticsMap['EBK.Y2BK.P'] + elibStatisticsMap['EBK.FXLI.P'] + elibStatisticsMap['EBK.YESB.P'] + elibStatisticsMap['EBK.ECO.P'] + elibStatisticsMap['EBK.OPMS.P'] +
						elibStatisticsMap['ADO.FXLI.P'] + elibStatisticsMap['ADO.HANS.P'] + elibStatisticsMap['ADO.CONT.P'] +
						elibStatisticsMap['WEB.ARTN.P'] + elibStatisticsMap['WEB.ECSM.P'] + elibStatisticsMap['WEB.YBMN.P'] + elibStatisticsMap['WEB.CONT.P'] + elibStatisticsMap['WEB.GLOB.P'] + elibStatisticsMap['WEB.EDUW.P'] + elibStatisticsMap['WEB.YESB.P'] +
						elibStatisticsMap['EXT.MOAZ.P']
					}" pattern="#,###" />
				</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.OPMS.A'] +
						elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.CONT.A'] +
						elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.YESB.A'] +
						elibStatisticsMap['EXT.MOAZ.A']
					}" pattern="#,###" />
				</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.OPMS.I'] +
						elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.CONT.I'] +
						elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.YESB.I'] +
						elibStatisticsMap['EXT.MOAZ.I']
					}" pattern="#,###" />
				</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.OPMS.S'] +
						elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.CONT.S'] +
						elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.YESB.S'] +
						elibStatisticsMap['EXT.MOAZ.S']
					}" pattern="#,###" />
				</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.OPMS.A'] +
						elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.CONT.A'] +
						elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.YESB.A'] +
						elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.OPMS.I'] +
						elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.CONT.I'] +
						elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.YESB.I'] +
						elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.OPMS.S'] +
						elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.CONT.S'] +
						elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.YESB.S'] +
						elibStatisticsMap['EXT.MOAZ.A'] + elibStatisticsMap['EXT.MOAZ.I'] + elibStatisticsMap['EXT.MOAZ.S']
					}" pattern="#,###" />
				</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.E'] + elibStatisticsMap['EBK.Y2BK.E'] + elibStatisticsMap['EBK.FXLI.E'] + elibStatisticsMap['EBK.YESB.E'] + elibStatisticsMap['EBK.ECO.E'] + elibStatisticsMap['EBK.OPMS.E'] +
						elibStatisticsMap['ADO.FXLI.E'] + elibStatisticsMap['ADO.HANS.E'] + elibStatisticsMap['ADO.CONT.E'] +
						elibStatisticsMap['WEB.ARTN.E'] + elibStatisticsMap['WEB.ECSM.E'] + elibStatisticsMap['WEB.YBMN.E'] + elibStatisticsMap['WEB.CONT.E'] + elibStatisticsMap['WEB.GLOB.E'] + elibStatisticsMap['WEB.EDUW.E'] + elibStatisticsMap['WEB.YESB.E'] +
						elibStatisticsMap['EXT.MOAZ.E']
					}" pattern="#,###" />
				</th>
				<th>
					<fmt:formatNumber value="${0 +
						elibStatisticsMap['EBK.KYOB.P'] + elibStatisticsMap['EBK.Y2BK.P'] + elibStatisticsMap['EBK.FXLI.P'] + elibStatisticsMap['EBK.YESB.P'] + elibStatisticsMap['EBK.ECO.P'] + elibStatisticsMap['EBK.OPMS.P'] +
						elibStatisticsMap['ADO.FXLI.P'] + elibStatisticsMap['ADO.HANS.P'] + elibStatisticsMap['ADO.CONT.P'] +
						elibStatisticsMap['WEB.ARTN.P'] + elibStatisticsMap['WEB.ECSM.P'] + elibStatisticsMap['WEB.YBMN.P'] + elibStatisticsMap['WEB.CONT.P'] + elibStatisticsMap['WEB.GLOB.P'] + elibStatisticsMap['WEB.EDUW.P'] + elibStatisticsMap['WEB.YESB.P'] +
						elibStatisticsMap['EBK.KYOB.A'] + elibStatisticsMap['EBK.Y2BK.A'] + elibStatisticsMap['EBK.FXLI.A'] + elibStatisticsMap['EBK.YESB.A'] + elibStatisticsMap['EBK.ECO.A'] + elibStatisticsMap['EBK.OPMS.A'] +
						elibStatisticsMap['ADO.FXLI.A'] + elibStatisticsMap['ADO.HANS.A'] + elibStatisticsMap['ADO.CONT.A'] +
						elibStatisticsMap['WEB.ARTN.A'] + elibStatisticsMap['WEB.ECSM.A'] + elibStatisticsMap['WEB.YBMN.A'] + elibStatisticsMap['WEB.CONT.A'] + elibStatisticsMap['WEB.GLOB.A'] + elibStatisticsMap['WEB.EDUW.A'] + elibStatisticsMap['WEB.YESB.A'] +
						elibStatisticsMap['EBK.KYOB.I'] + elibStatisticsMap['EBK.Y2BK.I'] + elibStatisticsMap['EBK.FXLI.I'] + elibStatisticsMap['EBK.YESB.I'] + elibStatisticsMap['EBK.ECO.I'] + elibStatisticsMap['EBK.OPMS.I'] +
						elibStatisticsMap['ADO.FXLI.I'] + elibStatisticsMap['ADO.HANS.I'] + elibStatisticsMap['ADO.CONT.I'] +
						elibStatisticsMap['WEB.ARTN.I'] + elibStatisticsMap['WEB.ECSM.I'] + elibStatisticsMap['WEB.YBMN.I'] + elibStatisticsMap['WEB.CONT.I'] + elibStatisticsMap['WEB.GLOB.I'] + elibStatisticsMap['WEB.EDUW.I'] + elibStatisticsMap['WEB.YESB.I'] +
						elibStatisticsMap['EBK.KYOB.S'] + elibStatisticsMap['EBK.Y2BK.S'] + elibStatisticsMap['EBK.FXLI.S'] + elibStatisticsMap['EBK.YESB.S'] + elibStatisticsMap['EBK.ECO.S'] + elibStatisticsMap['EBK.OPMS.S'] +
						elibStatisticsMap['ADO.FXLI.S'] + elibStatisticsMap['ADO.HANS.S'] + elibStatisticsMap['ADO.CONT.S'] +
						elibStatisticsMap['WEB.ARTN.S'] + elibStatisticsMap['WEB.ECSM.S'] + elibStatisticsMap['WEB.YBMN.S'] + elibStatisticsMap['WEB.CONT.S'] + elibStatisticsMap['WEB.GLOB.S'] + elibStatisticsMap['WEB.EDUW.S'] + elibStatisticsMap['WEB.YESB.S'] +
						elibStatisticsMap['EBK.KYOB.E'] + elibStatisticsMap['EBK.Y2BK.E'] + elibStatisticsMap['EBK.FXLI.E'] + elibStatisticsMap['EBK.YESB.E'] + elibStatisticsMap['EBK.ECO.E'] + elibStatisticsMap['EBK.OPMS.E'] +
						elibStatisticsMap['ADO.FXLI.E'] + elibStatisticsMap['ADO.HANS.E'] + elibStatisticsMap['ADO.CONT.E'] +
						elibStatisticsMap['WEB.ARTN.E'] + elibStatisticsMap['WEB.ECSM.E'] + elibStatisticsMap['WEB.YBMN.E'] + elibStatisticsMap['WEB.CONT.E'] + elibStatisticsMap['WEB.GLOB.E'] + elibStatisticsMap['WEB.EDUW.E'] + elibStatisticsMap['WEB.YESB.E'] +
						elibStatisticsMap['EXT.MOAZ.P'] + elibStatisticsMap['EXT.MOAZ.A'] + elibStatisticsMap['EXT.MOAZ.I'] + elibStatisticsMap['EXT.MOAZ.S'] + elibStatisticsMap['EXT.MOAZ.E']
					}" pattern="#,###" />
				</th>
			</tr>
		</tbody>
	</table>
