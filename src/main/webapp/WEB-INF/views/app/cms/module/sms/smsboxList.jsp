<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {	
	
	$('a#select_box').on('click', function(e) {
		$('#send_msg').val($('#smsText'+$(this).attr('keyValue2')).text());
		
		$('table tr td').css("background-color","");
		$('table tr#smsBoxSelect'+$(this).attr('keyValue2') + ' td').css("background-color","gray");
		
		e.preventDefault();
	});
	
});
</script>

<div style="float:left;width:80%">
	<font color="blue;">※문자함은 좌측 SMS문자함 메뉴에서 관리 하실 수 있습니다.</font>
</div>
<div style="float:left;width:19%" align="right">
	총 : ${smsBoxCnt} 건
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
						<td style="width:200px;" id="smsText${status.index}">${i.imsi_v_3 }</td>
						<td style="width:65px;"><a href="#" class="btn" id="select_box" keyValue="" keyValue2="${status.index}">선택</a></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(smsboxList) < 1}">
					<tr>
						<td colspan="4" style="height:100%">조회된 데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<form:form modelAttribute="smsSend" id="smsSendForm_paging" action="index.do" method="post" onsubmit="return false;">
		<jsp:include page="/WEB-INF/views/app/cms/common/paging_ajax.jsp" flush="false">
			<jsp:param name="formId" value="form#smsSendForm_paging"/>
			<jsp:param name="layerId" value="div#smsbox-layer"/>
			<jsp:param name="pagingUrl" value="smsboxList.do"/>
		</jsp:include>
		</form:form>
	</div>
</div>
