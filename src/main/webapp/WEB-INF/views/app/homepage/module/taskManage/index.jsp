<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="org-wrap">

	${html.html}
	
	<div class="tabmenu on tab1">
		<ul>
			<c:forEach items="${taskTypeList}" var="i" varStatus="status">
				<li ${status.first eq true ? 'class="active"' : '' } ><a href="#tabCon${status.count}"><span>${i.dept_name}</span></a></li>
			</c:forEach>
		</ul>
	</div>
	
	<c:forEach items="${taskTypeList}" var="oneType" varStatus="typeStatus">
		<div class="tabCon auto-scroll ${typeStatus.first ?'active':'' }" id="tabCon${typeStatus.count}">
			<table class="center" summary="총무담당 담당자 및 담당업무를 안내해드립니다.">
				<caption>총무담당 담당자 및 담당업무</caption>
				<colgroup>
					<col width="130"/>
					<col width="130"/>
					<col width="130"/>
					<col/>
					<col width="100"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">직위</th>
						<th scope="col">성명</th>
						<th scope="col">전화번호</th>
						<th scope="col">업무분장</th>
						<th scope="col">비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${taskRepo[oneType.dept_name]}" var="oneManage">
						<tr>
							<td>${oneManage.rank_name}</td>
							<td>${oneManage.manager_name}</td>
							<td>${oneManage.phone}</td>
							<td class="left">${oneManage.task_desc}</td>
							<td>&nbsp;</td>
						</tr>												
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:forEach>
</div>