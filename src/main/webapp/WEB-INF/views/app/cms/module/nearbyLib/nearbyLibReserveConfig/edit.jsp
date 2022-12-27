<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
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
					var startTime = $('#reserve_start_time1').val() + $('#reserve_start_time2').val();
					var endTime = $('#reserve_end_time1').val() + $('#reserve_end_time2').val();
					if(startTime >= endTime){
						$('#tomorrow_end_day_yn').val("Y");
					}
					if(startTime < endTime){
						$('#tomorrow_end_day_yn').val("N");
					}					
 					 if ( doAjaxPost($('#reserveAdd')) ) {
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
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 400,
		height: 500
	});
	
});

</script>
<!-- 내집앞도서관 운영장비 등록 form -->
<form:form id="reserveAdd" modelAttribute="nearbyLibReserveConfig" method="post" action="save.do" >
<form:hidden path="editMode" value="${reserveConfig.editMode}"/>
<form:hidden path="reserve_config_idx" value="${reserveConfig.reserve_config_idx}"/>
<form:hidden path="tomorrow_end_day_yn"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>예약시작시간//${reserveConfig.tomorrow_end_day_yn }</th>
	         	<td>
	         		<form:select path="reserve_start_time1" class="selectmenu-search" cssStyle="width:30%">
  						<c:forEach var="hour" varStatus="status" begin="0" end="23">
	         				<c:choose>	         						         			
	         					<c:when test="${hour < 10 }">
	         						<form:option value="0${hour}" selected="${(reserveConfig.editMode eq 'MODIFY') and (hour eq fn:substring(reserveConfig.reserve_start_time, 0 ,2))? 'selected':'' }"/>        					
	         					</c:when>
	         					<c:otherwise>
	         						<form:option value="${hour}" selected="${(reserveConfig.editMode eq 'MODIFY') and (hour eq fn:substring(reserveConfig.reserve_start_time, 0 ,2))? 'selected':'' }"/>
	         					</c:otherwise>
	         				</c:choose>	         				         			
	         			</c:forEach>	         					         				         
	         		</form:select>
	         		&nbsp;:&nbsp;
	         		<form:select path="reserve_start_time2" class="selectmenu-search" cssStyle="width:30%">
	         			<c:forEach var="min" varStatus="status" begin="0" end="59">
	         				<c:choose>
	         					<c:when test="${min < 10 }">
	         						<form:option value="0${min}" selected="${(reserveConfig.editMode eq 'MODIFY') and (min eq fn:substring(reserveConfig.reserve_start_time, 2 ,4))? 'selected':'' }"/>
	         					</c:when>
	         					<c:otherwise>
	         						<form:option value="${min}" selected="${(reserveConfig.editMode eq 'MODIFY') and (min eq fn:substring(reserveConfig.reserve_start_time, 2 ,4))? 'selected':'' }"/>
	         					</c:otherwise>
	         				</c:choose>	         				         			
	         			</c:forEach>
	         		</form:select>
	         	</td>
	        </tr>
	        <tr>
	         	<th>예약종료시간</th>
	         	<td>
	         		<form:select path="reserve_end_time1" class="selectmenu-search" cssStyle="width:30%">
	         			<c:forEach var="hour" varStatus="status" begin="0" end="23">
	         				<c:choose>
	         					<c:when test="${hour < 10 }">
	         						<form:option value="0${hour}" selected="${(reserveConfig.editMode eq 'MODIFY') and (hour eq fn:substring(reserveConfig.reserve_end_time, 0 ,2))? 'selected':'' }"/>
	         					</c:when>
	         					<c:otherwise>
	         						<form:option value="${hour}" selected="${(reserveConfig.editMode eq 'MODIFY') and (hour eq fn:substring(reserveConfig.reserve_end_time, 0 ,2))? 'selected':'' }"/>
	         					</c:otherwise>
	         				</c:choose>	         				         			
	         			</c:forEach>
	         		</form:select>
	         		&nbsp;:&nbsp;
	         		<form:select path="reserve_end_time2" class="selectmenu-search" cssStyle="width:30%">
	         			<c:forEach var="min" varStatus="status" begin="0" end="59">
	         				<c:choose>
	         					<c:when test="${min < 10 }">
	         						<form:option value="0${min}" selected="${(reserveConfig.editMode eq 'MODIFY') and (min eq fn:substring(reserveConfig.reserve_end_time, 2 ,4))? 'selected':'' }"/>
	         					</c:when>
	         					<c:otherwise>
	         						<form:option value="${min}" selected="${(reserveConfig.editMode eq 'MODIFY') and (min eq fn:substring(reserveConfig.reserve_end_time, 2 ,4))? 'selected':'' }"/>
	         					</c:otherwise>
	         				</c:choose>	         				         			
	         			</c:forEach>
	         		</form:select>
	         		<div class="ui-state-highlight">
						<em style="font-size:12px;">* 예약 종료시간은 시작시간부터 최대 24시간 입니다.<br/>
						* ex) 09시 ~  09시까지로 저장 했다면 09시 ~ 다음날 08시 59분 59초까지 신청이 가능합니다. </em>
					</div>
	         	</td>
	        </tr>
<%-- 	        <tr>
	         	<th>다음날예약종료여부</th>
	         	<td>
	         		<form:select path="tomorrow_end_day_yn">
	         			<form:option value="N" label="미사용" selected="${reserveConfig.tomorrow_end_day_yn eq 'N'? 'selected':'' }"/>
	         			<form:option value="Y" label="사용" selected="${reserveConfig.tomorrow_end_day_yn eq 'Y'? 'selected':'' }"/>
	         		</form:select>
	         		<div class="ui-state-highlight">
						<em style="font-size:12px;">*예약종료 시간이 00시를 넘어 다음날로 넘어가는경우 '사용'을 선택. </em>
					</div>
	         	</td>
	        </tr> --%>
	        <tr>
	         	<th>취거기간</th>
	         	<td>
	         		<form:input path="take_term" class="text" cssStyle="width:20%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="1"/>일
	         		<div class="ui-state-highlight">
						<em style="font-size:12px;">* 사물함에 도서가 투입된 시점부터 대출 신청자가 도서를 가지고 가야 할 최대 기간. </em>
					</div>
	         	</td>	         	
	        </tr>	 
	        <tr>
	        	<th>예약만기일수</th>
	         	<td>
	         		<form:input path="expire_date_cnt" class="text" cssStyle="width:20%" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/>일
	         		<div class="ui-state-highlight">
						<em style="font-size:12px;">* 예약상태로 유지되는 최대 기간. </em>
					</div>
	         	</td>
	        </tr>       
		</tbody>
	</table>
</form:form>
