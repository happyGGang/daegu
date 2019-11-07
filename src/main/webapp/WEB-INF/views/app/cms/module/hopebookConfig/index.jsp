<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(document).ready(function() {
	
	$('a#dialog-add').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-modify').on('click',  function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-delete').on('click', function(e) {
		e.preventDefault();
		
		var chkYN = $(this).attr('keyValue');
		var message = '';
		if(chkYN == 1) {
			message = '희망도서의 신청기능 제한이 적용 중입니다.\n삭제시, 신청기능 제한이 미적용 됩니다.\n삭제하시겠습니까?';
		} else {
			message = '삭제하시겠습니까?';
		}
		
		if(confirm(message)) {
			doAjaxPost($('form#hopebookConfigDel'));
		}
		
	});
	
});
</script>
<style type="text/css">
	div.ilusReqBox {margin-top: 20px;}
	div#ilusReqBox1 {margin-top: 0px;}
	td.font-red {color: red;}
	td.date-box p {display: inline-block;vertical-align: middle;}
</style>
<form:form modelAttribute="hopebookConfig" id="hopebookConfigDel" action="delete.do" method="POST">
	<form:hidden path="homepage_id" id="homeapge_id_del"/>
</form:form>
<form:form  modelAttribute="hopebookConfig" action="index.do">
	<form:hidden path="homepage_id"/>
	<div class="infodesk">
		<div class="button">
			<c:if test="${fn:length(hopebookConfigList) < 1}">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="250">
			<col>
			<col width="100">
			<col width="150">
		</colgroup>
		<thead>
			<tr>
				<th>소장위치</th>
				<th>기간</th>
				<th>사용여부</th>
				<th>기타</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${hopebookConfigList}" var="i" varStatus="chkCnt">
				<tr>
					<td <c:if test="${i.date_chk == 1}">class="font-red"</c:if>>
						${homepage.homepage_name}
					</td>
					<td class="date-box <c:if test="${i.date_chk == 1}">font-red</c:if>">
						<p>${i.str_date}<br>(${i.str_time})</p>
						<p>~</p>
						<p>${i.end_date}<br>(${i.end_time})</p>
					</td>
					<td <c:if test="${i.date_chk == 1}">class="font-red"</c:if>>
						${i.use_yn}
					</td>
					<td>
						<a href="#" class="btn dialog-modify">수정</a>
						<a href="#" class="btn dialog-delete" keyValue="${i.date_chk}">삭제</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(hopebookConfigList) < 1}">
			<tr>
				<td colspan="4">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<div class="ui-state-highlight">
		<em>* 현재 기능 제한을 적용중이면 붉은색으로 표시가 됩니다.</em><br>
		<em>* 현재 일자가 사용기간이지만 사용여부가 'N'으로 설정시, 기능제한이 적용되지 않습니다.(우선순위1: 사용여부, 우선순위2 : 기간)</em>
	</div>
</form:form>

<div id="dialog-1" class="dialog-common" title="희망도서신청"></div>
