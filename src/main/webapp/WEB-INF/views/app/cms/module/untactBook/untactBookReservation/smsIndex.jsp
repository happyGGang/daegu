<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
function smsSend() {
		$.ajax({
			type: "POST",
			url: 'smsSend.do',
			data: $('input[name=request_number_arr]').serialize()+"&adminMessage="+$('#send_msg').val(),
			success: function(html) {
				alert('SMS발송에 성공하였습니다.');
				location.reload();
			},
			error : function() {
				alert('SMS발송에 실패했습니다.\n\n관리자에게 문의해 주세요.');
			}
		});
}
</script>
<div class="ui-state-highlight">
	<em>* 현재 선택되어있는 모든 사용자에게 SMS발송이 됩니다.</em>
</div>

<div class="table-scroll">
<table style="table-layout:auto;width:100%;table-layout: fixed;">
	<thead>
		<tr>
			<th width="20%">신청자아이디</th>
			<th width="20%">신청자명</th>
			<th width="60%">도서명</th>
		</tr>
	</thead>
	<tbody style="height:200px">
	<c:forEach var="i" varStatus="status" items="${sms}">
		<tr>
			<td width="20%">${i.member_id}</td>
			<td width="20%">${i.member_name}</td>
			<td width="60%">${i.book_name}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>
<%-- <form:textarea path="adminMessage"/> --%>
<textarea id="send_msg" name="adminMessage" wrap="hard" style="overflow-y: scroll; resize:none; top:61px; width:100%;height:160;" placeholder="여기에 메시지를 입력하세요."/>
<a href="#" class="btn btn1 btnuntact" onclick="smsSend();" style="float: right;">전송하기</a>