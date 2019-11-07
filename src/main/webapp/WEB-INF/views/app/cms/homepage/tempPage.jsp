<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#tempPage'))) {
						$(this).dialog('destroy');
						location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 400
	});
	
	//달력
	$('.ui-calendar').each(function(){
		$(this).datepicker({
			//기본달력
		});
	});
});

</script>
<form:form id="tempPage" modelAttribute="homepage" action="modifyTempPage.do" method="post" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody> 
		<tr>
			<th>홈페이지ID</th>
			<td>${homepage.homepage_id}</td>
		</tr>
		<tr>
			<th>임시페이지 사용</th>
			<td>
				<form:radiobutton path="temp_use_yn" value="Y" /> <label for="temp_use_yn1" style="cursor:pointer;"> 사용함</label>
				<form:radiobutton path="temp_use_yn" value="N" /> <label for="temp_use_yn2" style="cursor:pointer;"> 사용안함</label>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>사용함일 경우 시작시간, 종료시간을 필수로 입력해야  합니다.<br/>사용안함일 경우 시작시간, 종료시간 데이터가 삭제됩니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>시작시간  <em>*</em></th>
			<td>
				<form:input path="temp_start_date_1" cssClass="text ui-calendar"/>
				<form:select path="temp_start_date_2" cssClass="selectmenu">
					<form:option value="">시</form:option>
					<form:options items="${hourList}"/>
				</form:select>
				<form:select path="temp_start_date_3" cssClass="selectmenu">
					<form:option value="">분</form:option>
				<c:forEach var="i" begin="0" end="50" step="10">
					<form:option value="${i}">${i}</form:option>
				</c:forEach>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>종료시간  <em>*</em></th>
			<td>
				<form:input path="temp_end_date_1" cssClass="text ui-calendar"/>
				<form:select path="temp_end_date_2" cssClass="selectmenu">
					<form:option value="">시</form:option>
					<form:options items="${hourList}"/>
				</form:select>
				<form:select path="temp_end_date_3" cssClass="selectmenu">
					<form:option value="">분</form:option>
				<c:forEach var="i" begin="0" end="50" step="10">
					<form:option value="${i}">${i}</form:option>
				</c:forEach>
				</form:select>
			</td>
		</tr>
	</tbody>
</table>
</form:form>