<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/cmsTag.tld" %>

<script type="text/javascript">
$(function(){
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
					var from = $('input#from_date').val();
					var to = $('input#to_date').val();
					
					if(doAjaxPost($('#expReservation_edit'))) {
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
			},{ 
				text: "삭제",
				"class": 'btn btn1',
				"id": 'del_btn',
				click: function() {
					if ( confirm("해당 프로그램의 신청 정보도 모두 삭제됩니다.\n정말 삭제하시겠습니까?") ) {
						$('input#editMode').val('DELETE');
						if(doAjaxPost($('#expReservation_edit'))) {
							$(this).dialog('destroy');
							location.reload();
						}	
					}
				}
			}
		]
	});
	if($('input#editMode').val() == 'ADD'){
		$('#del_btn').hide();
	} else {
		$('#del_btn').show();
	}
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 620
	});
	
	$('input#reservation_date').datepicker({
		
	});
	//from_date ~ to_date까지
	$('input#from_date').datepicker({
		maxDate: $('input#to_date').val(), 
		onClose: function(selectedDate){
			$('input#to_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#to_date').datepicker({
		minDate: $('input#from_date').val(), 
		onClose: function(selectedDate){
			$('input#from_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#checkAll').on('click', function() {
		if ($(this).prop("checked")) {
			 $("input[name=weeks]").prop("checked", true);
		} else {
			 $("input[name=weeks]").prop("checked", false);
		}
	});
	
	
	
	if( $('input:radio[name = reservation_type]:checked').length < 1 ) {
		$('tr.hidden').hide();
	}
	
	if( $('input:radio[name = reservation_type]:checked').val() == 'individual' ) {
		$('tr.hidden').hide();
	}else if( $('input:radio[name = reservation_type]:checked').val() == 'team') {
		$('tr.hidden').show();
	}
	
	$('input:radio[id = "reservation_type1"]').on('click', function(e) {
		$('tr.hidden').hide();
	});
	
	$('input:radio[id = "reservation_type2"]').on('click', function(e) {
		$('tr.hidden').show();
	});
	
	// 총신청인원 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
});
</script>
<form:form modelAttribute="expReservation" id="expReservation_edit" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="program_list_idx"/>
<form:hidden path="reservation_type_original" value="${expReservation.reservation_type}"/>
<table class="type2">
	<colgroup>
		<col width="150"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>프로그램명(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="program_name"  cssClass="text" />
			</td>
		</tr>
		<tr>
			<th>비회원 신청여부(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:radiobutton path="member_yn" value="Y"/> <label for="member_yn1" style="cursor:pointer;">Y</label>&nbsp;
				<form:radiobutton path="member_yn" value="N"/> <label for="member_yn2" style="cursor:pointer;">N</label>
				<div class="ui-state-highlight">
					<em>* Y 일 경우 해당 강좌는 비회원도 신청 가능합니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>신청구분(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:radiobutton path="reservation_type" value="individual"/> <label for="reservation_type1" style="cursor:pointer;">개인신청</label>&nbsp;
				<form:radiobutton path="reservation_type" value="team"/> <label for="reservation_type2" style="cursor:pointer;">단체신청</label>
			</td>
		</tr>
		<tr>
			<th>예약일(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<c:if test="${expReservation.editMode eq 'ADD'}">
					<form:input path="from_date" class="text ui-calendar"/>
					<span id="tilde" style="font-size:12px">~</span>
					<form:input path="to_date" class="text ui-calendar"/>
					<div style="margin-top: 5px;">
						<form:checkbox path="weeks" id="checkAll" value="0" label="전체"/>&nbsp;
						<form:checkbox path="weeks" value="1" label="일"/>&nbsp;
						<form:checkbox path="weeks" value="2" label="월"/>&nbsp;
						<form:checkbox path="weeks" value="3" label="화"/>&nbsp;
						<form:checkbox path="weeks" value="4" label="수"/>&nbsp;
						<form:checkbox path="weeks" value="5" label="목"/>&nbsp;
						<form:checkbox path="weeks" value="6" label="금 "/>&nbsp;
						<form:checkbox path="weeks" value="7" label="토"/>
					</div>
					<div class="ui-state-highlight">
						<em>* 요일 체크시 설정한 시작일 ~ 종료일 기간 사이 해당하는 요일만 등록됩니다.</em>
					</div>
				</c:if>
				<c:if test="${expReservation.editMode eq 'MODIFY'}">
					<fmt:parseDate value="${expReservation.reservation_date}" pattern="yyyyMMdd" var="reservationDate" />
					<fmt:formatDate value="${reservationDate}" pattern="yyyy-MM-dd"  var="reservation_date"/>
					<form:input type="text" path="reservation_date" class="text ui-calendar" value="${reservation_date}"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>이용시간(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="use_time" maxlength="11" cssClass="text" placeholder="10:00~12:00" />
				<em class="ui-state-highlight">* ex) 10:00~12:00</em>
			</td>
		</tr>
		<tr>
			<th>공지사항(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:textarea path="notice" cssStyle="width: 420px; height: 100px;"/>
			</td>
		</tr>
		<tr>
			<th>이용동의안내(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:textarea path="usage_agreement" cssStyle="width: 420px; height: 100px;"/>
			</td>
		</tr>
		<tr>
			<th>총신청인원(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="total_people" class="text" cssStyle="width:30px"  numberOnly="true" />
				<em class="ui-state-highlight">* 총신청인원에 제한이 없다면 0을 입력해주세요.</em>
			</td>
		</tr>
		<tr class="hidden">
			<th>신청가능팀수(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="enable_number_of_team" class="text" cssStyle="width:30px;" numberOnly="true"/>
				<em class="ui-state-highlight">* 신청가능팀수에 제한이 없다면 0을 입력해주세요.</em>
			</td>
		</tr>
		<tr class="hidden">
			<th>팀별 최대신청 <br/>인원수(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="maximum_people_of_team" class="text" cssStyle="width:30px;" numberOnly="true"/>
				<em class="ui-state-highlight">* 팀별 최대신청 인원수에 제한이 없다면 0을 입력해주세요.</em>
			</td>
		</tr>
	</tbody>
</table>

</form:form>
