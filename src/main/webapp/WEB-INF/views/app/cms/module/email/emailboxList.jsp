<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {	
	
	$('a#select_box').on('click', function(e) {
		
		$('#send_msg').val($(this).attr("keyValue"));
		
		$('table tr td').css("background-color","");
		$('table tr#smsBoxSelect'+$(this).attr('keyValue2') + ' td').css("background-color","gray");
		
		e.preventDefault();
	});
	
});
</script>
<div align="right">
	총 : ${fn:length(smsboxList)} 건
</div>
<div class="table-wrap">
	<div class="table-scroll">
		<table id="table2" class="type1 center">
			<thead>
				<tr>
					<th style="width:30px;">번호</th>
					<th style="width:100px;">제목</th>
					<th style="width:200px;">내용</th>
					<th style="width:65px;">선택</th>	
				</tr>
			</thead>
			
			<tbody style="height:360px">
				<c:forEach var="i" varStatus="status" items="${smsboxList}">
					<tr id="smsBoxSelect${status.index}">
						<td style="width:30px;">${paging.listRowNum - status.index}</td>
						<td style="width:100px;">${i.imsi_v_2}</td>
						<td style="width:200px;">${i.imsi_v_3 }</td>
						<td style="width:65px;"><a href="#" class="btn" id="select_box" keyValue="${i.imsi_v_3}" keyValue2="${status.index}">선택</a></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(smsboxList) < 1}">
					<tr>
						<td colspan="4" style="height:100%">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
