<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div style="width: 100%;">
	<div style="width: 45%; float: left; text-align: center;">
		<h1>
			자료수
			<if test="${not empty param.search_sdt}">
			${fn:escapeXml(param.search_sdt)}
			</if>
			<if test="${not empty param.search_edt}">
			~ ${fn:escapeXml(param.search_edt)}
			</if>
		</h1>
		<br/>
		<table class="type1 center" id="data-table1">
	<%--
			<colgroup>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
			</colgroup>
	--%>
			<thead>
				<tr>
					<th>구분</th>
					<th>성별</th>
					<th>전자책</th>
					<th>오디오북</th>
					<th>온라인강좌</th>
					<th>온라인자료</th>
					<th>소계</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="3">어린이</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.남'] + elibStatisticsSummary['오디오북.어린이.남'] + elibStatisticsSummary['온라인강좌.어린이.남'] + elibStatisticsSummary['전자저널.어린이.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.여'] + elibStatisticsSummary['오디오북.어린이.여'] + elibStatisticsSummary['온라인강좌.어린이.여'] + elibStatisticsSummary['전자저널.어린이.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.불명'] + elibStatisticsSummary['오디오북.어린이.불명'] + elibStatisticsSummary['온라인강좌.어린이.불명'] + elibStatisticsSummary['전자저널.어린이.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.어린이.남'] + elibStatisticsSummary['전자책.어린이.여'] + elibStatisticsSummary['전자책.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.어린이.남'] + elibStatisticsSummary['오디오북.어린이.여'] + elibStatisticsSummary['오디오북.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.어린이.남'] + elibStatisticsSummary['온라인강좌.어린이.여'] + elibStatisticsSummary['온라인강좌.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.어린이.남'] + elibStatisticsSummary['전자저널.어린이.여'] + elibStatisticsSummary['전자저널.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자책.어린이.남'] + elibStatisticsSummary['오디오북.어린이.남'] + elibStatisticsSummary['온라인강좌.어린이.남'] + elibStatisticsSummary['전자저널.어린이.남'] +
							elibStatisticsSummary['전자책.어린이.여'] + elibStatisticsSummary['오디오북.어린이.여'] + elibStatisticsSummary['온라인강좌.어린이.여'] + elibStatisticsSummary['전자저널.어린이.여'] +
							elibStatisticsSummary['전자책.어린이.불명'] + elibStatisticsSummary['오디오북.어린이.불명'] + elibStatisticsSummary['온라인강좌.어린이.불명'] + elibStatisticsSummary['전자저널.어린이.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr>
					<td rowspan="3">청소년</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.남'] + elibStatisticsSummary['오디오북.청소년.남'] + elibStatisticsSummary['온라인강좌.청소년.남'] + elibStatisticsSummary['전자저널.청소년.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.여'] + elibStatisticsSummary['오디오북.청소년.여'] + elibStatisticsSummary['온라인강좌.청소년.여'] + elibStatisticsSummary['전자저널.청소년.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.불명'] + elibStatisticsSummary['오디오북.청소년.불명'] + elibStatisticsSummary['온라인강좌.청소년.불명'] + elibStatisticsSummary['전자저널.청소년.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.청소년.남'] + elibStatisticsSummary['전자책.청소년.여'] + elibStatisticsSummary['전자책.청소년.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.청소년.남'] + elibStatisticsSummary['오디오북.청소년.여'] + elibStatisticsSummary['오디오북.청소년.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.청소년.남'] + elibStatisticsSummary['온라인강좌.청소년.여'] + elibStatisticsSummary['온라인강좌.청소년.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.청소년.남'] + elibStatisticsSummary['전자저널.청소년.여'] + elibStatisticsSummary['전자저널.청소년.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자책.청소년.남'] + elibStatisticsSummary['오디오북.청소년.남'] + elibStatisticsSummary['온라인강좌.청소년.남'] + elibStatisticsSummary['전자저널.청소년.남'] +
							elibStatisticsSummary['전자책.청소년.여'] + elibStatisticsSummary['오디오북.청소년.여'] + elibStatisticsSummary['온라인강좌.청소년.여'] + elibStatisticsSummary['전자저널.청소년.여'] +
							elibStatisticsSummary['전자책.청소년.불명'] + elibStatisticsSummary['오디오북.청소년.불명'] + elibStatisticsSummary['온라인강좌.청소년.불명'] + elibStatisticsSummary['전자저널.청소년.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr>
					<td rowspan="3">성인</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.남'] + elibStatisticsSummary['오디오북.성인.남'] + elibStatisticsSummary['온라인강좌.성인.남'] + elibStatisticsSummary['전자저널.성인.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.여'] + elibStatisticsSummary['오디오북.성인.여'] + elibStatisticsSummary['온라인강좌.성인.여'] + elibStatisticsSummary['전자저널.성인.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.불명'] + elibStatisticsSummary['오디오북.성인.불명'] + elibStatisticsSummary['온라인강좌.성인.불명'] + elibStatisticsSummary['전자저널.성인.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.성인.남'] + elibStatisticsSummary['전자책.성인.여'] + elibStatisticsSummary['전자책.성인.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.성인.남'] + elibStatisticsSummary['오디오북.성인.여'] + elibStatisticsSummary['오디오북.성인.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.성인.남'] + elibStatisticsSummary['온라인강좌.성인.여'] + elibStatisticsSummary['온라인강좌.성인.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.성인.남'] + elibStatisticsSummary['전자저널.성인.여'] + elibStatisticsSummary['전자저널.성인.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자책.성인.남'] + elibStatisticsSummary['오디오북.성인.남'] + elibStatisticsSummary['온라인강좌.성인.남'] + elibStatisticsSummary['전자저널.성인.남'] +
							elibStatisticsSummary['전자책.성인.여'] + elibStatisticsSummary['오디오북.성인.여'] + elibStatisticsSummary['온라인강좌.성인.여'] + elibStatisticsSummary['전자저널.성인.여'] +
							elibStatisticsSummary['전자책.성인.불명'] + elibStatisticsSummary['오디오북.성인.불명'] + elibStatisticsSummary['온라인강좌.성인.불명'] + elibStatisticsSummary['전자저널.성인.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr>
					<td rowspan="3">불명</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.남'] + elibStatisticsSummary['오디오북.불명.남'] + elibStatisticsSummary['온라인강좌.불명.남'] + elibStatisticsSummary['전자저널.불명.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.여'] + elibStatisticsSummary['오디오북.불명.여'] + elibStatisticsSummary['온라인강좌.불명.여'] + elibStatisticsSummary['전자저널.불명.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.불명'] + elibStatisticsSummary['오디오북.불명.불명'] + elibStatisticsSummary['온라인강좌.불명.불명'] + elibStatisticsSummary['전자저널.불명.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자책.불명.남'] + elibStatisticsSummary['전자책.불명.여'] + elibStatisticsSummary['전자책.불명.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['오디오북.불명.남'] + elibStatisticsSummary['오디오북.불명.여'] + elibStatisticsSummary['오디오북.불명.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['온라인강좌.불명.남'] + elibStatisticsSummary['온라인강좌.불명.여'] + elibStatisticsSummary['온라인강좌.불명.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsSummary['전자저널.불명.남'] + elibStatisticsSummary['전자저널.불명.여'] + elibStatisticsSummary['전자저널.불명.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자책.불명.남'] + elibStatisticsSummary['오디오북.불명.남'] + elibStatisticsSummary['온라인강좌.불명.남'] + elibStatisticsSummary['전자저널.불명.남'] +
							elibStatisticsSummary['전자책.불명.여'] + elibStatisticsSummary['오디오북.불명.여'] + elibStatisticsSummary['온라인강좌.불명.여'] + elibStatisticsSummary['전자저널.불명.여'] +
							elibStatisticsSummary['전자책.불명.불명'] + elibStatisticsSummary['오디오북.불명.불명'] + elibStatisticsSummary['온라인강좌.불명.불명'] + elibStatisticsSummary['전자저널.불명.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr class="strong">
					<th>합계</th>
					<th>-</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자책.어린이.남'] + elibStatisticsSummary['전자책.어린이.여'] + elibStatisticsSummary['전자책.어린이.불명'] +
							elibStatisticsSummary['전자책.청소년.남'] + elibStatisticsSummary['전자책.청소년.여'] + elibStatisticsSummary['전자책.청소년.불명'] +
							elibStatisticsSummary['전자책.성인.남'] + elibStatisticsSummary['전자책.성인.여'] + elibStatisticsSummary['전자책.성인.불명'] +
							elibStatisticsSummary['전자책.불명.남'] + elibStatisticsSummary['전자책.불명.여'] + elibStatisticsSummary['전자책.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['오디오북.어린이.남'] + elibStatisticsSummary['오디오북.어린이.여'] + elibStatisticsSummary['오디오북.어린이.불명'] +
							elibStatisticsSummary['오디오북.청소년.남'] + elibStatisticsSummary['오디오북.청소년.여'] + elibStatisticsSummary['오디오북.청소년.불명'] +
							elibStatisticsSummary['오디오북.성인.남'] + elibStatisticsSummary['오디오북.성인.여'] + elibStatisticsSummary['오디오북.성인.불명'] +
							elibStatisticsSummary['오디오북.불명.남'] + elibStatisticsSummary['오디오북.불명.여'] + elibStatisticsSummary['오디오북.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['온라인강좌.어린이.남'] + elibStatisticsSummary['온라인강좌.어린이.여'] + elibStatisticsSummary['온라인강좌.어린이.불명'] +
							elibStatisticsSummary['온라인강좌.청소년.남'] + elibStatisticsSummary['온라인강좌.청소년.여'] + elibStatisticsSummary['온라인강좌.청소년.불명'] +
							elibStatisticsSummary['온라인강좌.성인.남'] + elibStatisticsSummary['온라인강좌.성인.여'] + elibStatisticsSummary['온라인강좌.성인.불명'] +
							elibStatisticsSummary['온라인강좌.불명.남'] + elibStatisticsSummary['온라인강좌.불명.여'] + elibStatisticsSummary['온라인강좌.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자저널.어린이.남'] + elibStatisticsSummary['전자저널.어린이.여'] + elibStatisticsSummary['전자저널.어린이.불명'] +
							elibStatisticsSummary['전자저널.청소년.남'] + elibStatisticsSummary['전자저널.청소년.여'] + elibStatisticsSummary['전자저널.청소년.불명'] +
							elibStatisticsSummary['전자저널.성인.남'] + elibStatisticsSummary['전자저널.성인.여'] + elibStatisticsSummary['전자저널.성인.불명'] +
							elibStatisticsSummary['전자저널.불명.남'] + elibStatisticsSummary['전자저널.불명.여'] + elibStatisticsSummary['전자저널.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsSummary['전자책.어린이.남'] + elibStatisticsSummary['전자책.어린이.여'] + elibStatisticsSummary['전자책.어린이.불명'] +
							elibStatisticsSummary['전자책.청소년.남'] + elibStatisticsSummary['전자책.청소년.여'] + elibStatisticsSummary['전자책.청소년.불명'] +
							elibStatisticsSummary['전자책.성인.남'] + elibStatisticsSummary['전자책.성인.여'] + elibStatisticsSummary['전자책.성인.불명'] +
							elibStatisticsSummary['전자책.불명.남'] + elibStatisticsSummary['전자책.불명.여'] + elibStatisticsSummary['전자책.불명.불명'] +
							elibStatisticsSummary['오디오북.어린이.남'] + elibStatisticsSummary['오디오북.어린이.여'] + elibStatisticsSummary['오디오북.어린이.불명'] +
							elibStatisticsSummary['오디오북.청소년.남'] + elibStatisticsSummary['오디오북.청소년.여'] + elibStatisticsSummary['오디오북.청소년.불명'] +
							elibStatisticsSummary['오디오북.성인.남'] + elibStatisticsSummary['오디오북.성인.여'] + elibStatisticsSummary['오디오북.성인.불명'] +
							elibStatisticsSummary['오디오북.불명.남'] + elibStatisticsSummary['오디오북.불명.여'] + elibStatisticsSummary['오디오북.불명.불명'] +
							elibStatisticsSummary['온라인강좌.어린이.남'] + elibStatisticsSummary['온라인강좌.어린이.여'] + elibStatisticsSummary['온라인강좌.어린이.불명'] +
							elibStatisticsSummary['온라인강좌.청소년.남'] + elibStatisticsSummary['온라인강좌.청소년.여'] + elibStatisticsSummary['온라인강좌.청소년.불명'] +
							elibStatisticsSummary['온라인강좌.성인.남'] + elibStatisticsSummary['온라인강좌.성인.여'] + elibStatisticsSummary['온라인강좌.성인.불명'] +
							elibStatisticsSummary['온라인강좌.불명.남'] + elibStatisticsSummary['온라인강좌.불명.여'] + elibStatisticsSummary['온라인강좌.불명.불명'] + 
							elibStatisticsSummary['전자저널.어린이.남'] + elibStatisticsSummary['전자저널.어린이.여'] + elibStatisticsSummary['전자저널.어린이.불명'] +
							elibStatisticsSummary['전자저널.청소년.남'] + elibStatisticsSummary['전자저널.청소년.여'] + elibStatisticsSummary['전자저널.청소년.불명'] +
							elibStatisticsSummary['전자저널.성인.남'] + elibStatisticsSummary['전자저널.성인.여'] + elibStatisticsSummary['전자저널.성인.불명'] +
							elibStatisticsSummary['전자저널.불명.남'] + elibStatisticsSummary['전자저널.불명.여'] + elibStatisticsSummary['전자저널.불명.불명']
						}" pattern="#,###" />
					</th>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div style="width: 45%; float: right; text-align: center;">
		<h1>
			이용자수
			<if test="${not empty param.search_sdt}">
			${fn:escapeXml(param.search_sdt)}
			</if>
			<if test="${not empty param.search_edt}">
			~ ${fn:escapeXml(param.search_edt)}
			</if>
		</h1>
		<br/>
		<table class="type1 center" id="data-table2">
	<%--
			<colgroup>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
				<col width="100"/>
			</colgroup>
	--%>
			<thead>
				<tr>
					<th>구분</th>
					<th>성별</th>
					<th>전자책</th>
					<th>오디오북</th>
					<th>온라인강좌</th>
					<th>온라인자료</th>
					<th>소계</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td rowspan="3">어린이</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.어린이.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.남'] + elibStatisticsUniqueSummary['오디오북.어린이.남'] + elibStatisticsUniqueSummary['온라인강좌.어린이.남'] + elibStatisticsUniqueSummary['전자저널.어린이.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.어린이.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.여'] + elibStatisticsUniqueSummary['오디오북.어린이.여'] + elibStatisticsUniqueSummary['온라인강좌.어린이.여'] + elibStatisticsUniqueSummary['전자저널.어린이.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.어린이.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.불명'] + elibStatisticsUniqueSummary['오디오북.어린이.불명'] + elibStatisticsUniqueSummary['온라인강좌.어린이.불명'] + elibStatisticsUniqueSummary['전자저널.어린이.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.어린이.남'] + elibStatisticsUniqueSummary['전자책.어린이.여'] + elibStatisticsUniqueSummary['전자책.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.어린이.남'] + elibStatisticsUniqueSummary['오디오북.어린이.여'] + elibStatisticsUniqueSummary['오디오북.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.어린이.남'] + elibStatisticsUniqueSummary['온라인강좌.어린이.여'] + elibStatisticsUniqueSummary['온라인강좌.어린이.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.어린이.남'] + elibStatisticsUniqueSummary['전자저널.어린이.여'] + elibStatisticsUniqueSummary['전자저널.어린이.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자책.어린이.남'] + elibStatisticsUniqueSummary['오디오북.어린이.남'] + elibStatisticsUniqueSummary['온라인강좌.어린이.남'] + elibStatisticsUniqueSummary['전자저널.어린이.남'] +
							elibStatisticsUniqueSummary['전자책.어린이.여'] + elibStatisticsUniqueSummary['오디오북.어린이.여'] + elibStatisticsUniqueSummary['온라인강좌.어린이.여'] + elibStatisticsUniqueSummary['전자저널.어린이.여'] +
							elibStatisticsUniqueSummary['전자책.어린이.불명'] + elibStatisticsUniqueSummary['오디오북.어린이.불명'] + elibStatisticsUniqueSummary['온라인강좌.어린이.불명'] + elibStatisticsUniqueSummary['전자저널.어린이.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr>
					<td rowspan="3">청소년</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.청소년.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.남'] + elibStatisticsUniqueSummary['오디오북.청소년.남'] + elibStatisticsUniqueSummary['온라인강좌.청소년.남'] + elibStatisticsUniqueSummary['전자저널.청소년.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.청소년.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.여'] + elibStatisticsUniqueSummary['오디오북.청소년.여'] + elibStatisticsUniqueSummary['온라인강좌.청소년.여'] + elibStatisticsUniqueSummary['전자저널.청소년.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.청소년.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.불명'] + elibStatisticsUniqueSummary['오디오북.청소년.불명'] + elibStatisticsUniqueSummary['온라인강좌.청소년.불명'] + elibStatisticsUniqueSummary['전자저널.청소년.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.청소년.남'] + elibStatisticsUniqueSummary['전자책.청소년.여'] + elibStatisticsUniqueSummary['전자책.청소년.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.청소년.남'] + elibStatisticsUniqueSummary['오디오북.청소년.여'] + elibStatisticsUniqueSummary['오디오북.청소년.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.청소년.남'] + elibStatisticsUniqueSummary['온라인강좌.청소년.여'] + elibStatisticsUniqueSummary['온라인강좌.청소년.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.청소년.남'] + elibStatisticsUniqueSummary['전자저널.청소년.여'] + elibStatisticsUniqueSummary['전자저널.청소년.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자책.청소년.남'] + elibStatisticsUniqueSummary['오디오북.청소년.남'] + elibStatisticsUniqueSummary['온라인강좌.청소년.남'] + elibStatisticsUniqueSummary['전자저널.청소년.남'] +
							elibStatisticsUniqueSummary['전자책.청소년.여'] + elibStatisticsUniqueSummary['오디오북.청소년.여'] + elibStatisticsUniqueSummary['온라인강좌.청소년.여'] + elibStatisticsUniqueSummary['전자저널.청소년.여'] +
							elibStatisticsUniqueSummary['전자책.청소년.불명'] + elibStatisticsUniqueSummary['오디오북.청소년.불명'] + elibStatisticsUniqueSummary['온라인강좌.청소년.불명'] + elibStatisticsUniqueSummary['전자저널.청소년.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr>
					<td rowspan="3">성인</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.성인.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.남'] + elibStatisticsUniqueSummary['오디오북.성인.남'] + elibStatisticsUniqueSummary['온라인강좌.성인.남'] + elibStatisticsUniqueSummary['전자저널.성인.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.성인.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.여'] + elibStatisticsUniqueSummary['오디오북.성인.여'] + elibStatisticsUniqueSummary['온라인강좌.성인.여'] + elibStatisticsUniqueSummary['전자저널.성인.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.성인.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.불명'] + elibStatisticsUniqueSummary['오디오북.성인.불명'] + elibStatisticsUniqueSummary['온라인강좌.성인.불명'] + elibStatisticsUniqueSummary['전자저널.성인.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.성인.남'] + elibStatisticsUniqueSummary['전자책.성인.여'] + elibStatisticsUniqueSummary['전자책.성인.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.성인.남'] + elibStatisticsUniqueSummary['오디오북.성인.여'] + elibStatisticsUniqueSummary['오디오북.성인.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.성인.남'] + elibStatisticsUniqueSummary['온라인강좌.성인.여'] + elibStatisticsUniqueSummary['온라인강좌.성인.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.성인.남'] + elibStatisticsUniqueSummary['전자저널.성인.여'] + elibStatisticsUniqueSummary['전자저널.성인.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자책.성인.남'] + elibStatisticsUniqueSummary['오디오북.성인.남'] + elibStatisticsUniqueSummary['온라인강좌.성인.남'] + elibStatisticsUniqueSummary['전자저널.성인.남'] +
							elibStatisticsUniqueSummary['전자책.성인.여'] + elibStatisticsUniqueSummary['오디오북.성인.여'] + elibStatisticsUniqueSummary['온라인강좌.성인.여'] + elibStatisticsUniqueSummary['전자저널.성인.여'] +
							elibStatisticsUniqueSummary['전자책.성인.불명'] + elibStatisticsUniqueSummary['오디오북.성인.불명'] + elibStatisticsUniqueSummary['온라인강좌.성인.불명'] + elibStatisticsUniqueSummary['전자저널.성인.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr>
					<td rowspan="3">불명</td>
					<td>남</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.불명.남']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.남'] + elibStatisticsUniqueSummary['오디오북.불명.남'] + elibStatisticsUniqueSummary['온라인강좌.불명.남'] + elibStatisticsUniqueSummary['전자저널.불명.남']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>여</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.불명.여']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.여'] + elibStatisticsUniqueSummary['오디오북.불명.여'] + elibStatisticsUniqueSummary['온라인강좌.불명.여'] + elibStatisticsUniqueSummary['전자저널.불명.여']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<td>불명</td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.불명.불명']}" pattern="#,###" /></td>
					<td><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.불명'] + elibStatisticsUniqueSummary['오디오북.불명.불명'] + elibStatisticsUniqueSummary['온라인강좌.불명.불명'] + elibStatisticsUniqueSummary['전자저널.불명.불명']}" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>소계</th>
					<th>-</th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자책.불명.남'] + elibStatisticsUniqueSummary['전자책.불명.여'] + elibStatisticsUniqueSummary['전자책.불명.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['오디오북.불명.남'] + elibStatisticsUniqueSummary['오디오북.불명.여'] + elibStatisticsUniqueSummary['오디오북.불명.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['온라인강좌.불명.남'] + elibStatisticsUniqueSummary['온라인강좌.불명.여'] + elibStatisticsUniqueSummary['온라인강좌.불명.불명']}" pattern="#,###" /></th>
					<th><fmt:formatNumber value="${0 + elibStatisticsUniqueSummary['전자저널.불명.남'] + elibStatisticsUniqueSummary['전자저널.불명.여'] + elibStatisticsUniqueSummary['전자저널.불명.불명']}" pattern="#,###" /></th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자책.불명.남'] + elibStatisticsUniqueSummary['오디오북.불명.남'] + elibStatisticsUniqueSummary['온라인강좌.불명.남'] + elibStatisticsUniqueSummary['전자저널.불명.남'] +
							elibStatisticsUniqueSummary['전자책.불명.여'] + elibStatisticsUniqueSummary['오디오북.불명.여'] + elibStatisticsUniqueSummary['온라인강좌.불명.여'] + elibStatisticsUniqueSummary['전자저널.불명.여'] +
							elibStatisticsUniqueSummary['전자책.불명.불명'] + elibStatisticsUniqueSummary['오디오북.불명.불명'] + elibStatisticsUniqueSummary['온라인강좌.불명.불명'] + elibStatisticsUniqueSummary['전자저널.불명.불명']
						}" pattern="#,###" />
					</th>
				</tr>
				<tr class="strong">
					<th>합계</th>
					<th>-</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자책.어린이.남'] + elibStatisticsUniqueSummary['전자책.어린이.여'] + elibStatisticsUniqueSummary['전자책.어린이.불명'] +
							elibStatisticsUniqueSummary['전자책.청소년.남'] + elibStatisticsUniqueSummary['전자책.청소년.여'] + elibStatisticsUniqueSummary['전자책.청소년.불명'] +
							elibStatisticsUniqueSummary['전자책.성인.남'] + elibStatisticsUniqueSummary['전자책.성인.여'] + elibStatisticsUniqueSummary['전자책.성인.불명'] +
							elibStatisticsUniqueSummary['전자책.불명.남'] + elibStatisticsUniqueSummary['전자책.불명.여'] + elibStatisticsUniqueSummary['전자책.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['오디오북.어린이.남'] + elibStatisticsUniqueSummary['오디오북.어린이.여'] + elibStatisticsUniqueSummary['오디오북.어린이.불명'] +
							elibStatisticsUniqueSummary['오디오북.청소년.남'] + elibStatisticsUniqueSummary['오디오북.청소년.여'] + elibStatisticsUniqueSummary['오디오북.청소년.불명'] +
							elibStatisticsUniqueSummary['오디오북.성인.남'] + elibStatisticsUniqueSummary['오디오북.성인.여'] + elibStatisticsUniqueSummary['오디오북.성인.불명'] +
							elibStatisticsUniqueSummary['오디오북.불명.남'] + elibStatisticsUniqueSummary['오디오북.불명.여'] + elibStatisticsUniqueSummary['오디오북.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['온라인강좌.어린이.남'] + elibStatisticsUniqueSummary['온라인강좌.어린이.여'] + elibStatisticsUniqueSummary['온라인강좌.어린이.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.청소년.남'] + elibStatisticsUniqueSummary['온라인강좌.청소년.여'] + elibStatisticsUniqueSummary['온라인강좌.청소년.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.성인.남'] + elibStatisticsUniqueSummary['온라인강좌.성인.여'] + elibStatisticsUniqueSummary['온라인강좌.성인.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.불명.남'] + elibStatisticsUniqueSummary['온라인강좌.불명.여'] + elibStatisticsUniqueSummary['온라인강좌.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자저널.어린이.남'] + elibStatisticsUniqueSummary['전자저널.어린이.여'] + elibStatisticsUniqueSummary['전자저널.어린이.불명'] +
							elibStatisticsUniqueSummary['전자저널.청소년.남'] + elibStatisticsUniqueSummary['전자저널.청소년.여'] + elibStatisticsUniqueSummary['전자저널.청소년.불명'] +
							elibStatisticsUniqueSummary['전자저널.성인.남'] + elibStatisticsUniqueSummary['전자저널.성인.여'] + elibStatisticsUniqueSummary['전자저널.성인.불명'] +
							elibStatisticsUniqueSummary['전자저널.불명.남'] + elibStatisticsUniqueSummary['전자저널.불명.여'] + elibStatisticsUniqueSummary['전자저널.불명.불명']
						}" pattern="#,###" />
					</th>
					<th>
						<fmt:formatNumber value="${0 + 
							elibStatisticsUniqueSummary['전자책.어린이.남'] + elibStatisticsUniqueSummary['전자책.어린이.여'] + elibStatisticsUniqueSummary['전자책.어린이.불명'] +
							elibStatisticsUniqueSummary['전자책.청소년.남'] + elibStatisticsUniqueSummary['전자책.청소년.여'] + elibStatisticsUniqueSummary['전자책.청소년.불명'] +
							elibStatisticsUniqueSummary['전자책.성인.남'] + elibStatisticsUniqueSummary['전자책.성인.여'] + elibStatisticsUniqueSummary['전자책.성인.불명'] +
							elibStatisticsUniqueSummary['전자책.불명.남'] + elibStatisticsUniqueSummary['전자책.불명.여'] + elibStatisticsUniqueSummary['전자책.불명.불명'] +
							elibStatisticsUniqueSummary['오디오북.어린이.남'] + elibStatisticsUniqueSummary['오디오북.어린이.여'] + elibStatisticsUniqueSummary['오디오북.어린이.불명'] +
							elibStatisticsUniqueSummary['오디오북.청소년.남'] + elibStatisticsUniqueSummary['오디오북.청소년.여'] + elibStatisticsUniqueSummary['오디오북.청소년.불명'] +
							elibStatisticsUniqueSummary['오디오북.성인.남'] + elibStatisticsUniqueSummary['오디오북.성인.여'] + elibStatisticsUniqueSummary['오디오북.성인.불명'] +
							elibStatisticsUniqueSummary['오디오북.불명.남'] + elibStatisticsUniqueSummary['오디오북.불명.여'] + elibStatisticsUniqueSummary['오디오북.불명.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.어린이.남'] + elibStatisticsUniqueSummary['온라인강좌.어린이.여'] + elibStatisticsUniqueSummary['온라인강좌.어린이.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.청소년.남'] + elibStatisticsUniqueSummary['온라인강좌.청소년.여'] + elibStatisticsUniqueSummary['온라인강좌.청소년.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.성인.남'] + elibStatisticsUniqueSummary['온라인강좌.성인.여'] + elibStatisticsUniqueSummary['온라인강좌.성인.불명'] +
							elibStatisticsUniqueSummary['온라인강좌.불명.남'] + elibStatisticsUniqueSummary['온라인강좌.불명.여'] + elibStatisticsUniqueSummary['온라인강좌.불명.불명'] + 
							elibStatisticsUniqueSummary['전자저널.어린이.남'] + elibStatisticsUniqueSummary['전자저널.어린이.여'] + elibStatisticsUniqueSummary['전자저널.어린이.불명'] +
							elibStatisticsUniqueSummary['전자저널.청소년.남'] + elibStatisticsUniqueSummary['전자저널.청소년.여'] + elibStatisticsUniqueSummary['전자저널.청소년.불명'] +
							elibStatisticsUniqueSummary['전자저널.성인.남'] + elibStatisticsUniqueSummary['전자저널.성인.여'] + elibStatisticsUniqueSummary['전자저널.성인.불명'] +
							elibStatisticsUniqueSummary['전자저널.불명.남'] + elibStatisticsUniqueSummary['전자저널.불명.여'] + elibStatisticsUniqueSummary['전자저널.불명.불명']
						}" pattern="#,###" />
					</th>
				</tr>
			</tbody>
		</table>
	</div>
	
	<br/>
	<br/>
	
</div>
<div style="clear:both"></div>
<br/>
<br/>
<div style="background-color: #ced8da; height: 5px;"></div>
	
