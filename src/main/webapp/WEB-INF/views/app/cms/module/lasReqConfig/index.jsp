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
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id='+$('#homepage_id').val()+'&sub_loca_code='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
	});
	
	$('a.dialog-delete').on('click', function(e) {
		e.preventDefault();
		
		var tdv = $(this).parent().siblings('td[keyname]');
		var strArr = [];
		var message = "";
		
		tdv.each(function(i, v) {
			strArr[i] = $(this).attr('keyname');
		});
		
		if(strArr.length > 0) {
			message = strArr.join(',') + '의 신청기능 제한이 적용 중입니다.\n삭제시, 신청기능 제한이 미적용 됩니다.\n삭제하시겠습니까?';
		} else {
			message = '정말 삭제하시겠습니까?';
		}
		
		if(confirm(message)) {
			$('input#sub_loca_code_del').val($(this).attr('keyValue'));
			doAjaxPost($('form#lasReqConfigDel'));
		}
	});
	
});
</script>
<style type="text/css">
	div.lasReqBox {margin-top: 20px;}
	div#lasReqBox1 {margin-top: 0px;}
	td.font-red {color: red;}
	td.date-box p {display: inline-block;vertical-align: middle;}
	
	table thead th {border-top-color: rgb(206, 216, 218);}
</style>
<form:form modelAttribute="lasReqConfig" id="lasReqConfigDel" action="delete.do" method="POST">
	<form:hidden path="homepage_id" id="homeapge_id_del"/>
	<form:hidden path="sub_loca_code" id="sub_loca_code_del"/>
</form:form>
<form:form  modelAttribute="lasReqConfig" action="index.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="las_req_code"/>
	<div class="infodesk">
		<div class="button">
			<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="120">
			<col width="80">
			<c:forEach items="${lasReqCode}" var="i">
			<col width="120">
			<col width="30">
			</c:forEach>
			<col width="80">
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2">소장위치</th>
				<th rowspan="2">자료실명</th>
				<c:forEach items="${lasReqCode}" var="i">
				<th colspan="2">${i.code_name} 기능 제한</th>
				</c:forEach>
				<th rowspan="2">기타</th>
			</tr>
			<tr>
				<c:forEach items="${lasReqCode}" var="i">
				<th>기간</th>
				<th>사용여부</th>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${lasReqConfigList}" var="i" varStatus="status">
				<tr>
					<td>${i.loca_name}</td>
					<td>
						<c:forEach items="${subLocation}" var="one">
							<c:if test="${fn:contains(i.sub_loca_code, one.CODE)}">
								${one.DESCRIPTION}<br>
							</c:if>
						</c:forEach>
					</td>
					<td class="date-box <c:if test="${i.reservation.date_chk == 1}">font-red</c:if>">
						<c:if test="${not empty i.reservation.str_date}">
						<p>${i.reservation.str_date}<br>(${i.reservation.str_time})</p>
						<p>~</p>
						<p>${i.reservation.end_date}<br>(${i.reservation.end_time})</p>
						</c:if>
					</td>
					<td <c:if test="${i.reservation.date_chk == 1}">class="font-red" keyName="예약신청"</c:if>>
						${i.reservation.use_yn}
					</td>
					<td class="date-box <c:if test="${i.extension.date_chk == 1}">font-red</c:if>">
						<c:if test="${not empty i.extension.str_date}">
						<p>${i.extension.str_date}<br>(${i.extension.str_time})</p>
						<p>~</p>
						<p>${i.extension.end_date}<br>(${i.extension.end_time})</p>
						</c:if>
					</td>
					<td <c:if test="${i.extension.date_chk == 1}">class="font-red" keyName="연기신청"</c:if>>
						${i.extension.use_yn}
					</td>
					<td class="date-box <c:if test="${i.night.date_chk == 1}">font-red</c:if>">
						<c:if test="${not empty i.night.str_date}">
						<p>${i.night.str_date}<br>(${i.night.str_time})</p>
						<p>~</p>
						<p>${i.night.end_date}<br>(${i.night.end_time})</p>
						</c:if>
					</td>
					<td <c:if test="${i.night.date_chk == 1}">class="font-red" keyName="야간대출"</c:if>>
						${i.night.use_yn}
					</td>
					<td class="date-box <c:if test="${i.unmanned.date_chk == 1}">font-red</c:if>">
						<c:if test="${not empty i.unmanned.str_date}">
						<p>${i.unmanned.str_date}<br>(${i.unmanned.str_time})</p>
						<p>~</p>
						<p>${i.unmanned.end_date}<br>(${i.unmanned.end_time})</p>
						</c:if>
					</td>
					<td <c:if test="${i.unmanned.date_chk == 1}">class="font-red" keyName="무인대출"</c:if>>
						${i.unmanned.use_yn}
					</td>
					<td>
						<a href="#" class="btn dialog-modify" keyValue="${i.sub_loca_code}">수정</a>
						<a href="#" class="btn dialog-delete" keyValue="${i.sub_loca_code}">삭제</a>
<%-- 						<a href="#" class="btn dialog-delete" keyValue="${i.sub_loca_code}" keyStatus="${lasReqConfigList[status.index]}">삭제</a> --%>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(lasReqConfigList) < 1}">
			<tr>
				<td colspan="11">등록된 정보가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<br>
	<div class="ui-state-highlight">
		<em>* 현재 기능 제한을 적용중인 자료실에 대해서는 붉은색으로 표시가 됩니다.</em><br>
		<em>* 현재 일자가 사용기간이지만 사용여부가 'N'으로 설정시, 기능제한이 적용되지 않습니다.(우선순위1: 사용여부, 우선순위2 : 기간)</em>
	</div>
</form:form>


<div id="dialog-1" class="dialog-common" title="기능제한 등록/수정"></div>
