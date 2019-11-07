<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/default.css"/>
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<style>

.marcTitle {background: #384447;width: 100%;height: 60px;padding: 0px 30px;border-bottom: 5px solid #5aa7a3;margin-bottom: 25px;}
.marcTitle div:first-child {font-size: 20px;font-weight: bold;margin-top: 13px;float: left;color:#fff;}
.marcTitle div a {color: #fff;float: right;margin-top: 12px;margin-right: 43px;border: 1px solid;padding: 5px 10px;font-size: 20px;}

div#marchDiv {padding: 0px 20px;margin-bottom: 20px;}

table {border-top: 3px solid #5aa7a3;}
table caption {display: none;}
table.marcLeaderTable {margin-bottom: 20px;}
table.marcLeaderTable thead tr th, table.marcInfoTable thead tr th {background: #f9f9f9;}
table.marcLeaderTable thead tr td {border-right: none;}
table thead tr th {border-left: none;border-right: none;}
table.marcInfoTable tbody tr td {border-top: none;border-left: none;border-right: none;}

</style>
<script type="text/javascript">

	$(function() {
		
		<%-- 닫기 --%>
		$('a#closeMarc').on('click', function(){
			window.close(); // 일반적인 현재 창 닫기
			//window.open('about:blank','_self').self.close();  // IE에서 묻지 않고 창 닫기
		});
		
	});

</script>
<div class="marcTitle">
	<div>
		MARC 보기
	</div>
	<div>
		<a href="#" id="closeMarc">닫기</a>
	</div>
</div>

<div id="marchDiv">
	<table class="marcLeaderTable">
		<caption>MARC 리더</caption>
		<thead>
			<tr>
				<th>리더</th>
				<td>${marcList[0].FIELD}</td>
			</tr>
		</thead>
	</table>
	
	<table class="marcInfoTable">
		<caption>MARC 보기</caption>
		<col width="50">
  		<col width="50">
  		<col width="300">
		<thead>
			<tr>
				<th>TAG</th>
				<th>IND</th>
				<th>내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${marcList}" var="i" varStatus="status">
				<c:if test="${status.index != 0}">
				<tr>
					<td>${i.TAG}</td>
					<td>${i.IND}</td>
					<td>${i.FIELD}</td>
				</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</div>

