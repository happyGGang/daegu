<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	/* $('#dialog-1.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
					jQuery.ajaxSettings.traditional = true;
					var memberPhone = $('#schoolSupportForm #member_phone1').val() + '-' + $('#schoolSupportForm #member_phone2').val() + '-' + $('#schoolSupportForm #member_phone3').val();
					var memberCellPhone = $('#schoolSupportForm #member_cell_phone1').val() + '-' + $('#schoolSupportForm #member_cell_phone2').val() + '-' + $('#schoolSupportForm #member_cell_phone3').val();
					$('#schoolSupportForm #member_phone').val(memberPhone);
					$('#schoolSupportForm #member_cell_phone').val(memberCellPhone);
					if ( doAjaxPost($('#schoolSupportForm')) ) {
						//location.reload();
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('close');
				}
			}
			
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 900,
		height: 800
	}); */
	
	$('input#first_start_date').datepicker({
		maxDate: $('input#first_end_date').val(), 
		onClose: function(selectedDate){
			$('input#first_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#first_end_date').datepicker({
		minDate: $('input#first_start_date').val(), 
		onClose: function(selectedDate){
			$('input#first_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('input#second_start_date').datepicker({
		maxDate: $('input#second_end_date').val(), 
		onClose: function(selectedDate){
			$('input#second_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#second_end_date').datepicker({
		minDate: $('input#second_start_date').val(), 
		onClose: function(selectedDate){
			$('input#second_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	
	$('a.save-btn').on('click', function(e) {
		e.preventDefault();
		jQuery.ajaxSettings.traditional = true;
		var memberPhone = $('#schoolSupportForm #member_phone1').val() + '-' + $('#schoolSupportForm #member_phone2').val() + '-' + $('#schoolSupportForm #member_phone3').val();
		var memberCellPhone = $('#schoolSupportForm #member_cell_phone1').val() + '-' + $('#schoolSupportForm #member_cell_phone2').val() + '-' + $('#schoolSupportForm #member_cell_phone3').val();
		$('#schoolSupportForm #member_phone').val(memberPhone);
		$('#schoolSupportForm #member_cell_phone').val(memberCellPhone);
		if ( doAjaxPost($('#schoolSupportForm')) ) {
			history.back();
		}
	});
	
	$('a.cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.back();
	});
	
});

</script>
<form:form id="schoolSupportForm" modelAttribute="schoolSupport" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="support_idx"/>			
	<form:hidden path="editMode"/>
	<table class="type2 center">
       	<tr>
	     	<th colspan="6"><b >학 교 도 서 관 현 황</b></th>
	    </tr>
	    <tr>
	     	<th>총장서수</th>
	     	<th>도서관리<br/>프로그램명</th>
	     	<th>자료<br/>전산화현황</th>
	     	<th>도서관 도우미<br/>조직현황</th>
	     	<th colspan="2">학교도서관 담당자</th>
	    </tr>
       	<tr>
       		<td rowspan="2"><form:input path="total_book_count" cssClass="text" cssStyle="width:60px"/> 권</td>
       		<td rowspan="2"><form:input path="program_name" cssClass="text"/></td>
       		<td rowspan="2">구축율<br/>( <form:input path="percent" cssClass="text" cssStyle="width:60px"/> % )</td>
       		<td rowspan="2">
       			학 부 모 : <form:input path="parent_count" cssClass="text" cssStyle="width:30px"/> 명<br/>
       			도서부원 : <form:input path="staff_count" cssClass="text" cssStyle="width:30px"/> 명
       		</td>
       		<th>인원</th>
       		<td><form:input path="manager_count" cssClass="text" cssStyle="width:30px"/> 명</td>
       	</tr>
       	<tr>
       		<th>구성</th>
       		<td class="left">
       			<c:set var="managerTypeArr" value="${fn:split(schoolSupport.manager_type, ',')}"/>
       			<c:forEach items="${managerTypeList}" var="oneType" varStatus="status">
       				<c:set var="check" value=""/>
       				<c:forEach items="${managerTypeArr}" var="checkType">
       					<c:if test="${checkType eq oneType.code_id}">
       						<c:set var="check" value="checked"/>
       					</c:if> 
       				</c:forEach>
       				<form:checkbox path="manager_type" label="${oneType.code_name}" value="${oneType.code_id}" checked="${check}"/>
       				<c:if test="${status.count % 2 == 0}">
       				<br/>
       				</c:if>
       			</c:forEach>
       		</td>
       	</tr>
       	<tr>
       		<th colspan="6"><b>지 원 요 청 내 용</b></th>
       	</tr>
       	<tr>
       		<th rowspan="4">지원<br/>요청<br/>내용</th>
       		<th>1순위</th>
       		<td colspan="4"><form:input path="support_req_first" cssClass="text" cssStyle="width:96%"/></td>
       	</tr>
       	<tr>
       		<th>2순위</th>
       		<td colspan="4"><form:input path="support_req_second" cssClass="text" cssStyle="width:96%"/></td>
       	</tr>
       	<tr>
       		<th></th>
       		<td colspan="5" class="left">
       			<div class="ui-state-highlight">
					* 지원내용(자세한 사항은 운영계획 참조)<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;1. 학교도서관 컨설팅 지원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. DLS 자료입력 및 교육 지원<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;3. 장서점검 지원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. 자원봉사자(학부모, 도서부원)교육
				</div>
			</td>
       	</tr>
       	<tr>
       		<th>지원신청이유</th>
       		<td colspan="4" class="left">
       			<form:textarea path="support_req_desc" cssStyle="width:100%"/>
       			<div class="ui-state-error">※ 지원대상교 선정시 참고사항이므로 ‘신청 이유 및 담당자의 도서관 운영 의지’ 등 <br/>&nbsp;&nbsp;&nbsp;&nbsp;상세히 기술해 주시기 바랍니다.</div>
       		</td>
       	</tr>
       	<tr>
       		<th rowspan="2">지원희망 요청일</th>
       		<th>1순위</th>
       		<td colspan="4" class="left">
       			<form:input path="first_start_date" class="text ui-calendar"/> ~ <form:input path="first_end_date" class="text ui-calendar"/>
       		</td>
       	</tr>
       	<tr>
       		<th>2순위</th>
       		<td colspan="4" class="left">
       			<form:input path="second_start_date" class="text ui-calendar"/> ~ <form:input path="second_end_date" class="text ui-calendar"/>
       		</td>
       	</tr>
       	<tr>
       		<th colspan="2">해당지역</th>
       		<td>
       			<form:select path="area_code" cssClass="selectmenu" cssStyle="width:100%">
       				<form:options items="${areaList}" itemLabel="code_name" itemValue="code_id"/>
       			</form:select>
       		</td>
       		<th colspan="2">학교명</th>
       		<td>
       			<form:input path="school_name" cssClass="text" cssStyle="width:96%"/>
       		</td>
       	</tr>
       	<tr>
       		<th rowspan="2">담당자</th>
       		<th>직위</th>
       		<td><form:input path="member_position" cssClass="text" cssStyle="width:96%"/></td>
       		<th colspan="2">성 명</th>
       		<td><form:input path="member_name" cssClass="text" cssStyle="width:96%"/></td>
       	</tr>
       	<tr>
       		<th>전화번호</th>
       		<td>
       			<form:hidden path="member_phone"/>
				<form:input path="member_phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
				<form:input path="member_phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
				<form:input path="member_phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
       		</td>
       		<th colspan="2">휴대전화번호</th>
       		<td>
       			<form:hidden path="member_cell_phone"/>
				<form:input path="member_cell_phone1" style="width:40px;" class="text" maxlength="3" numberonly="true" /> -
				<form:input path="member_cell_phone2" style="width:50px;" class="text" maxlength="4" numberonly="true" /> -
				<form:input path="member_cell_phone3" style="width:50px;" class="text" maxlength="4" numberonly="true" />
       		</td>
       	</tr>
	</table>
</form:form>

<div class="center" style="margin-top:20px">
	<a href="#" class="btn btn1 save-btn">신청하기</a>
	<a href="" class="btn cancel-btn">뒤로가기</a>
</div>