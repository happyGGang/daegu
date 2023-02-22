<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
					let name_list = new Array();
					let standard_list = new Array();
					let cnt_list = new Array();
                    let equipment_name_list = $('input[name=equipment_name]');
					let equipment_standard_list = $('input[name=equipment_standard]');
					let equipment_cnt_list = $('input[name=equipment_cnt]');
					let equipmentSize = $('.equipment').length
					if (equipment_name_list.eq(0).val()) {
						for (let i=0;i < equipmentSize;i++) {
							name_list.push(equipment_name_list.eq(i).val());
							standard_list.push(equipment_standard_list.eq(i).val());
							cnt_list.push(equipment_cnt_list.eq(i).val());
						}

						$('#equipment_name_list').val(name_list);
						$('#equipment_standard_list').val(standard_list);
						$('#equipment_cnt_list').val(cnt_list);
					}
					if ( doAjaxPost($('#facilityForm')) ) {
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
		width: 700,
		height: 700
	});

	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('input#apply_start_date').datepicker({
		maxDate: $('input#apply_end_date').val(),
		onClose: function(selectedDate){
			$('input#apply_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#apply_end_date').datepicker({
		minDate: $('input#apply_start_date').val(),
		onClose: function(selectedDate){
			$('input#apply_start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	$(document).on('click','.addBtn',function (e){
		e.preventDefault();
		var btn = `<a href="#" class="removeBtn btn btn5">삭제</a>`;
        var tr = `<tr class="equipment"><th>제공장비</th><td>이름 : <input type="text" name="equipment_name" class="text" style="width:150px;"/> 규격 :  <input type="text" name="equipment_standard" class="text" style="width:50px;"/>  수량 :   <input type="text" name="equipment_cnt" class="text" style="width:50px;"/> <a href="#" class="addBtn btn btn2">추가</a></td></tr>`
		$(this).parent().append(btn);
		$(this).parent().parent().parent().append(tr)
		$(this).remove();
	});

    $(document).on('click','.removeBtn',function (e){
		e.preventDefault();
        $(this).parent().parent().remove();
    });

	if ($('#equipment_name_list').val()){
		$('.equipment').remove();
		var nameStr = $('#equipment_name_list').val().split(',');
		var standardStr;
		var cntStr;
		if ($('#equipment_standard_list').val()){
			standardStr = $('#equipment_standard_list').val().split(',');
		}
		if ($('#equipment_cnt_list').val()){
			cntStr = $('#equipment_cnt_list').val().split(',');
		}
		for (var i=0;i<nameStr.length;i++){
			var tr;
			if (i == nameStr.length-1){
				tr = `<tr class="equipment"><th>제공장비</th><td>이름 : <input type="text" value="`+nameStr[i]+`" name="equipment_name" class="text" style="width:150px;"/> 규격 :  <input type="text" name="equipment_standard" value="`+standardStr[i]+`" class="text" style="width:50px;"/>  수량 :   <input type="text" name="equipment_cnt" class="text" value="`+cntStr[i]+`" style="width:50px;" maxlength="3" numberonly="true"/> <a href="#" class="addBtn btn btn2">추가</a></td></tr>`
			}else{
				tr = `<tr class="equipment"><th>제공장비</th><td>이름 : <input type="text" value="`+nameStr[i]+`" name="equipment_name" class="text" style="width:150px;"/> 규격 :  <input type="text" name="equipment_standard" value="`+standardStr[i]+`" class="text" style="width:50px;"/>  수량 :   <input type="text" name="equipment_cnt" class="text" value="`+cntStr[i]+`" style="width:50px;" maxlength="3" numberonly="true"/> <a href="#" class="removeBtn btn btn5">삭제</a></td></tr>`
			}

			$('#modal').append(tr);
		}
	}

// 	validation
	$(document).on('propertychange change paste input','input[name=equipment_standard]',function (e){
		if (!$(this).prev().val()){
			alert('제공장비 명을 먼저 작성해 주십시오.');
			$(this).val('');
			return false;
		}
	});
	$(document).on('propertychange change paste input','input[name=equipment_cnt]',function (e){
		if (!$(this).prev().prev().val()){
			alert('제공장비 명을 먼저 작성해 주십시오.');
			$(this).val('');
			return false;
		}
	});
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
});

</script>
<form:form id="facilityForm" modelAttribute="facility" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="facility_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="equipment_name_list"/>
	<form:hidden path="equipment_standard_list"/>
	<form:hidden path="equipment_cnt_list"/>
	<table class="type2">
		<colgroup>
	       <col width="150" />
	       <col width="*"/>
       	</colgroup>
       	<tbody id="modal">
       		<tr>
			<th>시설물 종류(<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<c:choose>
					<c:when test="${facility.editMode eq 'ADD'}">
						<form:select path="date_type" class="selectmenu">
							<form:options items="${dateTypeList}" itemValue="code_id" itemLabel="code_name"/>
						</form:select>
					</c:when>
					<c:otherwise>
						<c:forEach var="i" items="${dateTypeList}">
							<c:if test="${i.code_id eq facility.date_type}">${i.code_name}</c:if>
						</c:forEach>
							<form:hidden path="date_type"/>
						</c:otherwise>
				</c:choose>

			</td>
		</tr>
	        <tr>
	         	<th>시설물명 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="facility_name" class="text" cssStyle="width:100%" maxlength="15"/></td>
	        </tr>
	        <tr>
	         	<th>시설물설명</th>
	         	<td><form:textarea path="facility_desc" class="text" cssStyle="width:100%; height:150px;"/></td>
	        </tr>
	        <tr>
				<th>이용가능일 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<c:choose>
						<c:when test="${facility.editMode eq 'ADD'}">
							<form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
						</c:when>
						<c:otherwise>
							${facility.use_date}
						</c:otherwise>
					</c:choose>

				</td>
			</tr>
			<tr>
				<th>이용가능시간 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="start_time" class="text" style="width:50px;"/> ~ <form:input path="end_time" class="text" style="width:50px;"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
			<c:if test="${facility.editMode eq 'ADD'}">
			<tr>
				<th>사용 요일</th>
				<td>
					<form:checkbox path="use_day" value="1" label="일"/>
					<form:checkbox path="use_day" value="2" label="월"/>
					<form:checkbox path="use_day" value="3" label="화"/>
					<form:checkbox path="use_day" value="4" label="수"/>
					<form:checkbox path="use_day" value="5" label="목"/>
					<form:checkbox path="use_day" value="6" label="금"/>
					<form:checkbox path="use_day" value="7" label="토"/>
					<div class="ui-state-highlight">
						* 사용요일 체크시 입력한 사용 기간 중 해당하는 요일만 등록 됩니다.<br/>
						* 사용요일 체크 안할시 입력한 사용 기간 모두 등록 됩니다.
					</div>
				</td>
			</tr>
			</c:if>
			<tr>
				<th>신청가능시간 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="apply_start_date" class="text ui-calendar"/> <form:input path="apply_start_time" class="text" style="width:50px;"/> ~ <form:input path="apply_end_date" class="text ui-calendar"/> <form:input path="apply_end_time" class="text" style="width:50px;"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30<br/>* 설정된 기간에만 이용자가 신청을 할 수 있습니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>신청 제한 수 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="limit_count" class="text" style="width:50px;"/>
				</td>
			</tr>
			<tr>
	         	<th>홈페이지 게시여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton path="use_yn" class="Y" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" class="N" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
				</td>
	        </tr>
			<tr class="equipment">
				<th>제공장비</th>
				<td>
                    이름 : <input type="text" name="equipment_name" class="text" style="width:150px;"/> 규격 :  <input type="text" name="equipment_standard" class="text" style="width:50px;"/>  수량 :   <input type="text" name="equipment_cnt" class="text" style="width:50px;" maxlength="3" numberonly="true"/> <a href="#" class="addBtn btn btn2">추가</a>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
