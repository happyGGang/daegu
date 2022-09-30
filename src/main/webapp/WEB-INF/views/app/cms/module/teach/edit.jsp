<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					jQuery.ajaxSettings.traditional = true;
					var limitUnit = $('[name="teach_join_limit_unit"]:checked').val();
					var limitChlidren = $('tr.limit_value').children();
					if ( limitUnit == 'SEX' ) {
						$('td.limit_OLD').remove();
					}
					else if ( limitUnit == 'OLD' ) {
						$('td.limit_SEX').remove();
					}
					else {
						$('td.limit_OLD').remove();
						$('td.limit_SEX').remove();
					}

					if ($('input#limit_hak_yn1').is(':checked')) {
						var fromHak = parseInt($('select#limit_hak').val());
						var toHak = parseInt($('select#limit_hak2').val());

						if (fromHak > toHak) {
							alert('학년제한 설정이 잘못되었습니다.');
							focus($('select#limit_hak'));
							return false;
						}
					}
					
					var sjt1 = $('input#start_join_time1').val();
					if($('input#start_join_time1').val().length < 2){
						$('input#start_join_time1').focus();
						alert('접수기간 시작 시간 시를 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#start_join_time1').val() < '00' || $('input#start_join_time1').val() > '23'){
						$('input#start_join_time1').focus();
						alert('접수기간 시작 시간 시의 범위는 00부터 23까지입니다.');
						return false;
					}
					
					var sjt2 = $('input#start_join_time2').val();
					if($('input#start_join_time2').val().length < 2){
						$('input#start_join_time2').focus();
						alert('접수기간 시작 시간 분을 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#start_join_time2').val() < '00' || $('input#start_join_time2').val() > '59'){
						$('input#start_join_time2').focus();
						alert('접수기간 시작 시간 분의 범위는 00부터 59까지입니다.');
						return false;
					}
					
					$('input#start_join_time').val(sjt1+':'+sjt2);
					
					var ejt1 = $('input#end_join_time1').val();
					if($('input#end_join_time1').val().length < 2){
						$('input#end_join_time1').focus();
						alert('접수시간 종료 시간 시를 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#end_join_time1').val() < '00' || $('input#end_join_time1').val() > '23'){
						$('input#end_join_time1').focus();
						alert('접수시간 종료 시간 시의 범위는 00부터 23까지입니다.');
						return false;
					}

					var ejt2 = $('input#end_join_time2').val();
					if($('input#end_join_time2').val().length < 2){
						$('input#end_join_time2').focus();
						alert('접수시간 종료 시간 분을 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#end_join_time2').val() < '00' || $('input#end_join_time2').val() > '59'){
						$('input#end_join_time2').focus();
						alert('접수기간 종료 시간 분의 범위는 00부터 59까지입니다.');
						return false;
					}

					$('input#end_join_time').val(ejt1+':'+ejt2);

					var start_join_time_final = $('input#start_join_date').val() + ' ' + $('input#start_join_time').val();
					var end_join_time_final = $('input#end_join_date').val() + ' ' + $('input#end_join_time').val();
					if(start_join_time_final > end_join_time_final){
						$('input#start_join_time1').focus();
						alert('접수기간 시작 시간은 접수기간 종료 시간보다 이후일 수 없습니다.');
						return false;
					}
					
					if($("input:checkbox[name = 'teach_day']").is(':checked') == false){
						alert('강의요일을 선택해 주세요.');
						return false;
					}
					
					if($('input#start_date').val() == ''){
						$('input#start_date').focus();
						alert('강의시작 기간을 선택하세요.');
						return false;
					}
					
					if($('input#end_date').val() == ''){
						$('input#end_date').focus();
						alert('강의종료 기간을 선택하세요.');
						return false;
					}

					var st1 = $('input#start_time1').val();
					if($('input#start_time1').val().length < 2){
						$('input#start_time1').focus();
						alert('강의시간 시작 시간 시를 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#start_time1').val() < '00' || $('input#start_time1').val() > '23'){
						$('input#start_time1').focus();
						alert('강의시간 시작 시간 시의 범위는 00부터 23까지입니다.');
						return false;
					}
					
					var st2 = $('input#start_time2').val();
					if($('input#start_time2').val().length < 2){
						$('input#start_time2').focus();
						alert('강의시간 시작 시간 분을 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#start_time2').val() < '00' || $('input#start_time2').val() > '59'){
						alert('강의시간 시작 시간 분의 범위는 00부터 59까지입니다.');
						return false;
					}
					
					$('input#start_time').val(st1+':'+st2);
					
					var et1 = $('input#end_time1').val();
					if($('input#end_time1').val().length < 2){
						$('input#end_time1').focus();
						alert('강의시간 종료 시간 시를 0이 필요하다면 포함하여 2자리로 입력해 주세요.');
						return false;
					}
					if($('input#end_time1').val() < '00' || $('input#end_time1').val() > '23'){
						$('input#end_time1').focus();
						alert('강의시간 종료 시간 시의 범위는 00부터 23까지입니다.');
						return false;
					}

					var et2 = $('input#end_time2').val();
					if($('input#end_time2').val().length < 2){
						$('input#end_time2').focus();
						alert('강의시간 종료 시간 분을 0이 필요하다면 포함하여 2자리로 입력해주세요.');
						return false;
					}
					if($('input#end_time2').val() < '00' || $('input#end_time2').val() > '59'){
						$('input#end_time2').focus();
						alert('강의시간 종료 시간 분의 범위는 00부터 59까지입니다.');
						return false;
					}
					$('input#end_time').val(et1+':'+et2);

					if($('input#start_time').val() > $('input#end_time').val()){
						$('input#start_time1').focus();
						alert('강의 시작 시간은 강의 종료 시간보다 이후일 수 없습니다.');
						return false;
					}

					var planFile = $('#plan_file');
					if ( $('#plan_file').val() == '' ) {
						$('#plan_file').remove();
					}

					var imagePlanFile = $('#image_plan_file');
					if ( $('#image_plan_file').val() == '' ) {
						$('#image_plan_file').remove();
					}
					
					var attachFile = $('#attach_file');
					if($('#attach_file'). val() == '') {
						$('#attach_file').remove();
					}

					$('select#holidays option').prop('selected', true);

					var option = {
						url : 'save.do',
						type : 'POST',
// 						data : $('#teachForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								location.reload();
							} else {
								$('tr.limit_value').html('').append(limitChlidren);
								$('td.planFile').append(planFile);
								$('td.imagePlanFile').append(imagePlanFile);
								$('td.attachFile').append(attachFile);
				                for(var i =0 ; i < response.result.length ; i++) {
									alert(response.result[i].code);
									$('#'+response.result[i].field).focus();
									break;
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				        	 $('tr.limit_value').html('').append(limitChlidren);
				        	 $('td.planFile').append(planFile);
				        	 $('td.imagePlanFile').append(imagePlanFile);
				        	 $('td.attachFile').append(attachFile);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#teachForm').ajaxSubmit(option);
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
		width: 800,
		height: 800
	});

	$('a.sameTeach-btn').on('click', function(e) {
		$.get('getSameTeachList.do?homepage_id=' + $('#teachForm #homepage_id').val() + '&group_idx=' + $('#teachForm #group_idx').val() + '&category_idx=' + $('#teachForm #category_idx').val() + '&teach_name=' + encodeURIComponent($('#teachForm #teach_name').val()) + '&teach_idx=' + $('#teachForm #teach_idx').val(), function(response) {
			var sameTeachList = response.sameTeachList;
			if ( sameTeachList.length > 0 ) {
				var resultMessage = '동일강좌가 있습니다.';
				$(sameTeachList).each(function(i, v) {
					resultMessage = resultMessage + '\n===========================================';
					resultMessage = resultMessage + '\n등록일 : ' + v.add_date + '\n강좌명 : ' + v.teach_name + '\n동일강좌제한 횟수 : ' + v.teach_same_limit_count;
				});
				alert(resultMessage);
			}
			else {
				alert('동일 강좌가 없습니다.');
			}
		});
	});

	$('a.teacher-btn').on('click', function(e) {
		$('#dialog-teacher').load('/cms/module/teacher/searchTeacher.do?homepage_id=' + $('#homepage_id_1').val(), function( response, status, xhr ) {
			$('#dialog-teacher').dialog('open');
		});

		e.preventDefault();
	});

	$('input#start_join_date').datepicker({
		maxDate: $('input#end_join_date').val(),
		onClose: function(selectedDate){
			$('input#end_join_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#end_join_date').datepicker({
		minDate: $('input#start_join_date').val(),
		onClose: function(selectedDate){
			$('input#start_join_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
	$('input#start_cancle_date').datepicker({
		maxDate: $('input#end_cancle_date').val(),
		onClose: function(selectedDate){
			$('input#end_cancle_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	$('input#end_cancle_date').datepicker({
		minDate: $('input#start_cancle_date').val(),
		onClose: function(selectedDate){
			$('input#start_cancle_date').datepicker('option', 'maxDate', selectedDate);
		}
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

	<%--대분류변경--%>
	$('#teachForm select#large_category_idx').on('change', function() {
		var largeCategoryIdx = $(this).val();
		if ( $(this).val() > 0 ) {
			$.get('/cms/module/category/getCategoryGroupList.do?homepage_id=' + $('#homepage_id_1').val() + '&large_category_idx=' + $(this).val() + '&group_idx=' + $('select#group_idx').val(), function(data) {
				$('#teachForm select#group_idx option').remove();
				if ( data.length > 0 ) {
					var groupIdx = 1;
					$.each(data, function(i, v) {
						if (i == 0) {
							groupIdx = v.group_idx;
						}
						$('#teachForm select#group_idx').append('<option value="' + v.group_idx + '">' + v.group_name + '</option>');
					});
					<%--중분류도변경(소분류 새로가져오기)--%>
					if ( groupIdx > 0 ) {
						$.get('/cms/module/category/getCategoryList.do?homepage_id=' + $('#homepage_id_1').val() + '&large_category_idx=' + largeCategoryIdx + '&group_idx=' + groupIdx, function(response) {
							$('#teachForm select#category_idx option').remove();
							if ( response.categoryList.length > 0 ) {
								$.each(response.categoryList, function(i, v) {
									$('#teachForm select#category_idx').append('<option value="' + v.category_idx + '">' + v.category_name + '</option>');
								});
							}
							else {
								$('#teachForm select#category_idx').append('<option value="0">등록된 소분류가 없습니다.</option>');
							}
						});
					} else {
						$('#teachForm select#category_idx option').remove();
						$('#teachForm select#category_idx').append('<option value="0">중분류를 선택 해주세요</option>');
					}
				}
				else {
					$('#teachForm select#group_idx').append('<option value="0">등록된 중분류가 없습니다.</option>');
					$('#teachForm select#category_idx option').remove();
					$('#teachForm select#category_idx').append('<option value="0">중분류를 선택 해주세요</option>');
				}


			});
		}
		else {
			$('#teachForm select#group_idx option').remove();
			$('#teachForm select#group_idx').append('<option value="0">대분류를 선택 해주세요</option>');
		}
	}).trigger('change');

	<%--중분류변경--%>
	$('#teachForm select#group_idx').on('change', function() {
		var largeCategoryIdx = $('#teachForm select#large_category_idx').val();
		if ( $(this).val() > 0 ) {
			$.get('/cms/module/category/getCategoryList.do?homepage_id=' + $('#homepage_id_1').val() + '&large_category_idx=' + largeCategoryIdx + '&group_idx=' + $(this).val(), function(response) {
				$('#teachForm select#category_idx option').remove();
				if ( response.categoryList.length > 0 ) {
					$.each(response.categoryList, function(i, v) {
						$('#teachForm select#category_idx').append('<option value="' + v.category_idx + '">' + v.category_name + '</option>');
					});
				}
				else {
					$('#teachForm select#category_idx').append('<option value="0">등록된 소분류가 없습니다.</option>');
				}
			});
		}
		else {
			$('#teachForm select#category_idx option').remove();
			$('#teachForm select#category_idx').append('<option value="0">중분류를 선택 해주세요</option>');
		}
	}).trigger('change');

	//강의계획서 삭제
	$('a.delete-file-btn').on('click', function(e) {
		e.preventDefault();
		var action = $('form#deleteFileForm').attr('action');
		$('form#deleteFileForm').attr('action', 'deleteFile.do');
		if ( doAjaxPost($('#deleteFileForm')) ) {
			$('form#deleteFileForm').attr('action', action);
			$('td.planFile a').remove();
			$('a.delete-file-btn').remove();
		}
	});
	//강의이미지 삭제
	$('a.delete-image-btn').on('click', function(e) {
		e.preventDefault();
		var action = $('form#deleteFileForm').attr('action');
		$('form#deleteFileForm').attr('action', 'deleteImage.do');
		if ( doAjaxPost($('#deleteFileForm')) ) {
			$('form#deleteFileForm').attr('action', action);
			$('td.imagePlanFile img').remove();
			$('a.delete-image-btn').remove();
		}
	});
	$('a.delete-attach-btn').on('click', function(e) {
		e.preventDefault();
		var action = $('form#deleteFileForm').attr('action');
		$('form#deleteFileForm').attr('action', 'deleteAttach.do');
		if(doAjaxPost($('#deleteFileForm'))) {
			$('form#deleteFileForm').attr('action', action);
			$('td.attachFile a').remove();
			$('a.delete-attach-btn').remove();
		}
	});

	$('[name="teach_join_limit_unit"]').change(function() {
		var $this = $(this);
		if ( $this.val() == 'SEX' ) {
			if ( !$this.is(':checked') ) {
				$this.parent().find('[name="teach_join_limit_value"]').prop('checked', false);
				$this.parent().find('[name="teach_join_limit_value"]').prop('disabled', true);
			}
			else {
				$this.parent().find('[name="teach_join_limit_value"]').prop('disabled', false);
			}
		}
		else if ( $this.val() == 'OLD' ) {
			if ( !$this.is(':checked') ) {
				$this.parent().find('[name="teach_join_limit_value"]').val('');
				$this.parent().find('[name="teach_join_limit_value"]').prop('disabled', true);
			}
			else {
				$this.parent().find('[name="teach_join_limit_value"]').prop('disabled', false);
			}
		}
	}).trigger('change');
	
	$('input#teach_addr_limit').on('click', function() {
		$('input#teach_addr_limit_value').prop('disabled', $(this).is(':checked') ? false : true);
		
		if($(this).is(':checked')) {
			$('input#address_yn1').prop('checked', true);
		} else {
			$('input#address_yn2').prop('checked', true);
		}
	});

	$('button#cancelFile').on('click', function(e) {
		e.preventDefault();
		$('input#plan_file').val('');
// 		$(this).hide();
	});

	$('button#cancelImage').on('click', function(e) {
		e.preventDefault();
		$('input#image_plan_file').val('');
// 		$(this).hide();
	});

	$('input#plan_file').on('change', function() {
		if ($(this).val() != '') {
// 			$('button#cancelFile').show();
		}
	});

	$('td.limit_${teach.teach_join_limit_unit}').show();

	$('input#limit_hak_yn1').on('click', function(){
		var flag = $(this).is(':checked');
		if (flag) {
			$('#school_grade_yn1').click();
		}
	});

	$('input#school_grade_yn2').on('click', function(e){
		if ($('input#limit_hak_yn1').is(':checked')) {
			$('#school_grade_yn1').click();
			alert('학년제한이 있는 경우 학년 입력여부를 수정할 수 없습니다.');
			return false;
		}
	});
	
	$('input#teach_join_limit_unit2').on('click', function(){
		var flag = $(this).is(':checked');
		if (flag) {
			$('#birth_yn1').click();
			$('#age_info_yn1').click();
		}
	});
	
	$('input#birth_yn2').on('click', function(e){
		if ($('input#teach_join_limit_unit2').is(':checked')) {
			$('#birth_yn1').click();
			alert('나이제한이 있는 경우 생년월일 입력여부를 수정할 수 없습니다.');
			return false;
		}
	});

	$('input#tempHoliDay').datepicker({
		onClose: function(selectedDate){
			$('input#tempHoliDayDummy').datepicker('option', 'dateFormat', 'yy-mm-dd');
		}
	});
	$('input#tempHoliDayDummy').datepicker({
		onClose: function(selectedDate){
			$('input#tempHoliDay').datepicker('option', 'dateFormat', 'yy-mm-dd');
		}
	});

	$('a#addHoliday').on('click', function(e) {
		e.preventDefault();
		var day = $('input#tempHoliDay').val();
		var hasDay = false;
		$('select#holidays option').each(function() {
			if (day == $(this).val()) {
				hasDay = true;
				return false;
			}
		});

		if (!hasDay) {
			$('select#holidays').append( '<option value="'+day+'">'+day+'</option>' );
		} else {
			alert('이미 존재 합니다.');
		}
	});

	$('a#deleteHoliday').on('click', function(e) {
		e.preventDefault();
		$('select#holidays option:selected').remove();
	});

	<%-- 프로그램 대분류 변경 --%>
	$('select.program_class').on('change', function() {
		var id = $(this).attr('id');
		if (id == 'program_classification1') {
			var large_code = $('select#program_classification1').val();
			$.get('getMidCodeList.do?large_code=' + large_code, function(data) {
				var cate2 = $('select#program_classification2').empty();
				var cate3 = $('select#program_classification3').empty();
				$(data).sort(function(a, b) {
					return parseInt(a.print_seq) > parseInt(b.print_seq);
				}).each(function(i) {
					cate2.append($('<option>', { value: this.mid_code, text: this.code_name }));
				});
			});
			$.get('getSmallCodeList.do?large_code=' + large_code + '&mid_code=01', function(data) {
				var cate3 = $('select#program_classification3').empty();
				$(data).sort(function(a, b) {
					return parseInt(a.print_seq) > parseInt(b.print_seq);
				}).each(function(i) {
					cate3.append($('<option>', { value: this.small_code, text: this.code_name }));
				});
			});

		} else if (id == 'program_classification2') {
			var large_code = $('select#program_classification1').val();
			var mid_code = $('select#program_classification2').val();
			$.get('getSmallCodeList.do?large_code=' + large_code + '&mid_code=' + mid_code, function(data) {
				var cate3 = $('select#program_classification3').empty();
				$(data).sort(function(a, b) {
					return parseInt(a.print_seq) > parseInt(b.print_seq);
				}).each(function(i) {
					cate3.append($('<option>', { value: this.small_code, text: this.code_name }));
				});
			});
		}
	});

	<%--강의대분류변경--%>
	$('select#large_category_idx').on('change', function() {

	});

	$('select#program_age_div_arr option:eq(0)').prop('selected', true);

// 	if ($("input:radio[name = teach_age_type]:checked").val() == 'adult') {
// 		$("input:radio[name = 'family_yn'][value = 'N']").prop('checked', 'true');
// 		$('input#family_yn1').attr('disabled', 'true');
// 	}

// 	if ($("input:radio[name = teach_age_type]:checked").val() == 'child') {
// 		$("input:radio[name = 'family_yn'][value = 'Y']").prop('checked', 'true');
// 		$("input:radio[name = 'agent_yn'][value = 'Y']").prop('checked','true');
// 		$('input#family_yn2').attr('disabled', 'true');
// 		$('input#agent_yn2').attr('disabled', 'true');
// 	}

// 	$('input#teach_age_type1').on('click', function() {
// 		$('input#family_yn2').removeAttr('disabled');
// 		$('input#agent_yn2').removeAttr('disabled');
// 		$("input:radio[name = 'family_yn'][value = 'N']").prop('checked', 'true');
// 		$('input#family_yn1').attr('disabled', 'true');
// 	});

	$('input#teach_age_type2').on('click', function() {
// 		$('input#family_yn1').removeAttr('disabled');
// 		$("input:radio[name = 'family_yn'][value = 'Y']").prop('checked', 'true');
		$("input:radio[name = 'agent_yn'][value = 'Y']").prop('checked', 'true');
// 		$('input#family_yn2').attr('disabled', 'true');
// 		$('input#agent_yn2').attr('disabled', 'true');
	});
	
	$('input#teach_age_type1').on('click', function() {
		var value = $('input[name="teach_age_type"]:checked').val();
		if (value == "infants") {
			$('.limit_text1').text("개월 이상");
			$('.limit_text2').text("개월 이하");
		}else {
			$('.limit_text1').text("세 이상");
			$('.limit_text2').text("세 이하");
			
		}
		$("input:radio[name = 'agent_yn'][value = 'Y']").prop('checked', 'true');
	});
	
});

</script>
<form:form id="deleteFileForm" modelAttribute="teach" action="deleteFile.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
</form:form>


<form:form id="teachForm" modelAttribute="teach" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="editMode"/>

	<table class="type2">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr style="display: none;">
	         	<th>프로그램분류 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		대분류 : <form:select path="program_classification1" cssClass="program_class" items="${teachLargeCodeList}" itemLabel="code_name" itemValue="large_code" /> &nbsp;&nbsp;
	         		중분류 : <form:select path="program_classification2" cssClass="program_class" items="${teachMidCodeList}" itemLabel="code_name" itemValue="mid_code" /> &nbsp;&nbsp;
	         		소분류 : <form:select path="program_classification3" cssClass="program_class" items="${teachSmallCodeList}" itemLabel="code_name" itemValue="small_code" /> &nbsp;&nbsp;
         		</td>
        	</tr>
			<tr style="display: none;">
	         	<th>프로그램 주제구분 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:select path="program_subject" cssClass="program_subject" items="${teachSubjectCodeList}" itemLabel="code_name" itemValue="teach_code" />
         		</td>
        	</tr>
			<tr style="display: none;">
	         	<th>프로그램 연령구분 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:select items="${teachAgeDivCodeList}" path="program_age_div_arr" itemLabel="code_name" itemValue="teach_code" cssStyle="margin-left:10px;"/>
         		</td>
        	</tr>
        	<tr style="display: none;">
				<th>접수취소 사용여부</th>
				<td>
					<form:radiobutton path="cancle_use_yn" cssClass="cancle_yn" value="Y" label="사용" cssStyle="cursor: pointer;"/>
					<form:radiobutton path="cancle_use_yn" cssClass="cancle_yn" value="N" label="미사용" cssStyle="cursor: pointer;"/>
					<div class="ui-state-highlight">
						<em>* 접수취소 기능 사용 시 취소기간 중 최초 1회한 SMS를 발송합니다. (오전 10:00)</em>
					</div>
				</td>
			</tr>
			<tr style="display: none;">
				<th>접수취소기간</th>
				<td>
					<form:input path="start_cancle_date" class="text ui-calendar"/> <form:input path="start_cancle_time" class="text" style="width:50px;" maxlength="5"/> ~ <form:input path="end_cancle_date" class="text ui-calendar"/> <form:input path="end_cancle_time" class="text" style="width:50px;" maxlength="5"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
        	<tr>
	         	<th>강의 대분류 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
		         	<c:choose>
		       			<c:when test="${teach.editMode eq 'MODIFY'}">
							${teach.large_category_name}<form:hidden path="large_category_idx"/>
		       			</c:when>
		       			<c:otherwise>
			         		<form:select path="large_category_idx" items="${teachLargeCategoryList}" itemLabel="code_name" itemValue="teach_code">
			         		</form:select>
			       		</c:otherwise>
	   				</c:choose>
        		</td>
       		</tr>
			<tr>
	         	<th>강의 중분류 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
		         	<c:choose>
		         		<c:when test="${teach.editMode eq 'MODIFY'}">
		       				${teach.group_name}<form:hidden path="group_idx"/>
		       			</c:when>
		       			<c:otherwise>
			         		<form:select path="group_idx">
			         			<c:choose>
			         				<c:when test="${fn:length(categoryGroupList) > 0}">
			         					<form:options items="${categoryGroupList}" itemLabel="group_name" itemValue="group_idx"/>
			         				</c:when>
			         				<c:otherwise>
			         					<form:option value="0">등록된 중분류가 없습니다.</form:option>
			         				</c:otherwise>
			         			</c:choose>
			         		</form:select>
		         		</c:otherwise>
     				</c:choose>
         		</td>
        	</tr>
    		<tr>
	         	<th>강의 소분류</th>
	         	<td>
		         	<c:choose>
		       			<c:when test="${teach.editMode eq 'MODIFY'}">
							${teach.category_name}<form:hidden path="category_idx"/>
		       			</c:when>
		       			<c:otherwise>
			         		<form:select path="category_idx">
			         			<c:choose>
			         				<c:when test="${fn:length(categoryGroupList) > 0}">
			         					<form:options items="${categoryGroupList}" itemLabel="group_name" itemValue="group_idx"/>
			         				</c:when>
			         				<c:otherwise>
					         			<form:option value="0">강의 중분류를 선택하세요.</form:option>
			         				</c:otherwise>
			         			</c:choose>
			         		</form:select>
			       		</c:otherwise>
	   				</c:choose>
        		</td>
       		</tr>
       		<tr>
	         	<th>출력순서</th>
	         	<td>
	         		<form:input path="print_seq" class="text" cssStyle="width:30px" maxlength="5"/>
				</td>
	        </tr>
	        <tr>
	         	<th>홈페이지 게시여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton path="use_yn" class="Y" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" class="N" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
				</td>
	        </tr>
	        <tr>
	         	<th>이달의 행사 게시여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton path="calendar_view_yn" class="Y" value="Y"/> <label for="calendar_view_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="calendar_view_yn" class="N" value="N"/> <label for="calendar_view_yn2" style="cursor:pointer;">사용안함</label>
				</td>
	        </tr>
	        <tr>
	         	<th>강의대상</th>
	         	<td><form:input path="teach_target" class="text" cssStyle="width:100%"/></td>
	        </tr>
			<tr>
	         	<th>강의명 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="teach_name" class="text" cssStyle="width:70%" maxlength="33"/> <a class="btn btn1 sameTeach-btn">동일강좌 확인</a></td>
        	</tr>
			<tr>
				<th>상단 노출 </th>
				<td colspan="3">
					<div class="checkbox-original">
						<form:checkbox id="teach_code_yn" path="teach_code_yn" value="Y"/>
						<label for="teach_code_yn">상단 노출 여부</label>
						<em class="info">체크 시 목록 상단에 표시됩니다.</em>
					</div>
				</td>
			</tr>
	        <tr>
	         	<th>강의이미지</th>
	         	<td class="imagePlanFile">
	         		<c:if test="${not empty teach.image_org_file_name}">
	         		<img src="/data/teach/${teach.homepage_id}/img/${teach.image_server_file_name}" style="max-width: 400px;" alt="강의 이미지 입니다.">
	         		<a class="btn btn1 delete-image-btn">삭제</a>
	         		<br/>
	         		</c:if>
	         		<input type="file" id="image_plan_file" name="image_plan_file" class="text" accept=".gif,.jpeg,.jpg,.png"/><button id="cancelImage">등록취소</button>
	         		<div class="ui-state-highlight">
						<em>* 파일 확장자가  gif, jpeg, jpg, png 인 경우에만 업로드 가능합니다. <br/> * 기타 파일(pdf, hwp 등)을 등록하실 경우 정상적으로 나타나지 않습니다. </em>
					</div>
	         		<form:hidden path="image_org_file_name"/>
         		</td>
	        </tr>
	        <tr>
	         	<th>강의설명</th>
	         	<td><form:textarea path="teach_desc" class="text" cssStyle="width:100%;" rows="5" /></td>
	        </tr>
	        <tr>
	         	<th>강의장소 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td><form:input path="teach_stage" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>강사명</th>
	         	<td>
	         		<form:hidden path="teacher_idx"/>
 	         		<form:input path="teacher_name" class="text" /> <a class="btn btn1 teacher-btn">검색</a>
	         	</td>
	        </tr>
	        <tr>
	         	<th>준비물 및 재료비</th>
	         	<td><form:input path="teach_etc" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
				<th>접수기간 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="start_join_date" class="text ui-calendar"/>
					<form:hidden path="start_join_time" class="text" style="width:50px;" maxlength="5"/>
					<form:input path="start_join_time1" class="text" style="width:20px;" maxlength="2"/> :
					<form:input path="start_join_time2" class="text" style="width:20px;" maxlength="2"/> ~
					<form:input path="end_join_date" class="text ui-calendar"/>
					<form:hidden path="end_join_time" class="text" style="width:50px;" maxlength="5"/>
					<form:input path="end_join_time1" class="text" style="width:20px;" maxlength="2"/> :
					<form:input path="end_join_time2" class="text" style="width:20px;" maxlength="2"/>
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>강의기간 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="start_date" class="text ui-calendar"/> ~ <form:input path="end_date" class="text ui-calendar"/>
				</td>
			</tr>
			<tr>
				<th>강의시간 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:hidden path="start_time" class="text" style="width:50px;" maxlength="5"/>
					<form:input path="start_time1" class="text" style="width:20px;" maxlength="2"/> :
					<form:input path="start_time2" class="text" style="width:20px;" maxlength="2"/> ~
					<form:hidden path="end_time" class="text" style="width:50px;" maxlength="5"/>
					<form:input path="end_time1" class="text" style="width:20px;" maxlength="2"/> :
					<form:input path="end_time2" class="text" style="width:20px;" maxlength="2"/>
				</td>
			</tr>
			<tr>
				<th>강의요일 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<c:forEach var="i" varStatus="status" begin="1" end="7" step="1">
						<c:set var="label" value=""/>
						<c:set var="checked" value="" />
						<c:choose>
							<c:when test="${i eq '1'}"><c:set var="label" value="일" /></c:when>
							<c:when test="${i eq '2'}"><c:set var="label" value="월" /></c:when>
							<c:when test="${i eq '3'}"><c:set var="label" value="화" /></c:when>
							<c:when test="${i eq '4'}"><c:set var="label" value="수" /></c:when>
							<c:when test="${i eq '5'}"><c:set var="label" value="목" /></c:when>
							<c:when test="${i eq '6'}"><c:set var="label" value="금" /></c:when>
							<c:when test="${i eq '7'}"><c:set var="label" value="토" /></c:when>
						</c:choose>
						<c:forEach var="j" varStatus="stats_j" items="${teach.teach_day_arr}">
							<c:if test="${i eq j}">
								<c:set var="checked" value="checked=\"checked\"" />
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${teach.editMode eq 'ADD'}">
								<input type="checkbox" name="teach_day" id="day${i}" value="${i}" checked="checked" /><label for="day${i}">${label}</label>&nbsp;							
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="teach_day" id="day${i}" value="${i}" ${checked} /><label for="day${i}">${label}</label>&nbsp;		
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>강의요일 직집지정</th>
				<td>
					<form:radiobutton path="teach_day_yn" value="Y" label="사용"/>
					<form:radiobutton path="teach_day_yn" value="N" label="미사용"/>
					<form:input path="teach_day_txt" cssClass="text" placeholder="ex) 격주 월, 수" cssStyle="width:50%"/>
				</td>
			</tr>
			<tr>
	         	<th>강의 총 횟수 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:input path="teach_count" class="text" cssStyle="width:30px" maxlength="5"/> 회
				</td>
	        </tr>
        	<tr>
	         	<th>모집인원 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:input path="teach_limit_count" class="text" cssStyle="width:30px" maxlength="5"/>
         		</td>
	        </tr>
	        <tr>
	         	<th>모집후보인원</th>
	         	<td><form:input path="teach_backup_count" class="text" cssStyle="width:30px" maxlength="5"/></td>
	        </tr>
	        <tr>
	         	<th>모집오프라인인원</th>
	         	<td><form:input path="teach_offline_count" class="text" cssStyle="width:30px" maxlength="5"/></td>
	        </tr>
	        <tr>
	         	<th>강의계획서</th>
	         	<td class="planFile">
	         		<c:if test="${teach.org_file_name ne null and teach.org_file_name ne ''}">
	         			<a href="/cms/module/teach/download/${teach.homepage_id}/${teach.group_idx}/${teach.category_idx}/${teach.teach_idx}.do"><i class="fa fa-floppy-o"></i>${teach.org_file_name}</a><a class="btn btn1 delete-file-btn">삭제</a>
	         			<br/>
	         		</c:if>
	         		<input type="file" id="plan_file" name="plan_file" class="text"/><form:hidden path="org_file_name"/>
	         		<button id="cancelFile">등록취소</button>
         		</td>
	        </tr>
			<tr>
				<th>첨부파일</th>
				<td class="attachFile">
					<c:if test="${teach.attach_org_file_name ne null and teach.attach_org_file_name ne ''}">
						<a href="/cms/module/teach/download/${teach.homepage_id}/${teach.group_idx}/${teach.category_idx}/${teach.teach_idx}.do?file_type=attach"><i class="fa fa-floppy-o"></i>${teach.attach_org_file_name}</a><a class="btn btn1 delete-attach-btn">삭제</a>
						<br/>
					</c:if>
					<input type="file" id="attach_file" name="attach_file" class="text"><form:hidden path="attach_org_file_name"/>
					<button id="attachCancelFile">등록취소</button>
				</td>
			</tr>
			<tr>
				<th>하이퍼링크</th>
				<td>
					<form:input path="link_url" cssClass="text" cssStyle="width:90%" />
					<div class="ui-state-highlight">
						<em>
							* 클릭시 이동 할 URL 입니다.<br>
							* http:// 부터 전체 URL을 입력하세요.
						</em>
					</div>
				</td>
			</tr>
	        <tr>
	        	<th>약관선택 </th>
	        	<td>
	        		<c:forEach items="${termsList}" var="i" varStatus="status">
	        			<input type="checkbox" name="terms" id="terms${status.count}" value="${i.terms_idx}" ${fn:contains(teach.terms, i.terms_idx) ? 'checked' : ''}>
	        			<label for="terms${status.count}">${i.title}</label>
	        		</c:forEach>
	        	</td>
	        </tr>
	        <tr>
				<th>비회원 신청여부</th>
				<td>
					<form:radiobutton path="member_yn" value="Y"/> <label for="member_yn1" style="cursor:pointer;">Y</label>&nbsp;
					<form:radiobutton path="member_yn" value="N"/> <label for="member_yn2" style="cursor:pointer;">N</label>
					<div class="ui-state-highlight">
						<em>* Y 일 경우 해당 강좌는 비회원도 신청 가능합니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>동일강좌접수제한 횟수</th>
				<td>
					<form:input path="teach_same_limit_count" class="text" cssStyle="width:30px" maxlength="5"/>
					<div class="ui-state-highlight">
						<em>* 동일강좌 기준은 '강좌명' 입니다.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>접수제한</th>
				<td>
					<c:set var="limitValues" value="${fn:split(teach.teach_join_limit_value, ',')}"/>
					<div>
						<input type="checkbox" id="teach_join_limit_unit1" name="teach_join_limit_unit" value="SEX" class="SEX" <c:if test="${fn:indexOf(teach.teach_join_limit_unit, 'SEX') ne -1}">checked="checked"</c:if>/><label for="teach_join_limit_unit1">성별</label>
						: <input type="radio" id="teach_join_limit_value1" name="teach_join_limit_value" value="M" <c:if test="${fn:indexOf(teach.teach_join_limit_value, 'M') ne -1}">checked="checked"</c:if>/><label for="teach_join_limit_value1"> 남자</label>
						  <input type="radio" id="teach_join_limit_value2" name="teach_join_limit_value" value="F" <c:if test="${fn:indexOf(teach.teach_join_limit_value, 'F') ne -1}">checked="checked"</c:if>/><label for="teach_join_limit_value2"> 여자</label>
					</div>
					<div>
						<input type="checkbox" id="teach_join_limit_unit2" name="teach_join_limit_unit" value="OLD" class="OLD" <c:if test="${fn:indexOf(teach.teach_join_limit_unit, 'OLD') ne -1}">checked="checked"</c:if>/><label for="teach_join_limit_unit2">나이</label>
						<c:choose>
							<c:when test="${fn:indexOf(teach.teach_join_limit_unit, 'OLD') ne -1}">
								: <input class="text" id="teach_join_limit_value1" name="teach_join_limit_value" style="width:50px;" value="${fn:indexOf(teach.teach_join_limit_unit, 'SEX') == -1 ? limitValues[0] : limitValues[1]}" maxlength="3"/>
									<c:choose>
										<c:when test="${teach.teach_age_type eq 'infants' }">
											<span class="limit_text1" style="display: inline-block;">개월 이상</span> ~
										</c:when>									
										<c:otherwise>
											<span class="limit_text1" style="display: inline-block;">세 이상</span>
										</c:otherwise>
									</c:choose>
						  		<input class="text" id="teach_join_limit_value2" name="teach_join_limit_value" style="width:50px;" value="${fn:indexOf(teach.teach_join_limit_unit, 'SEX') == -1 ? limitValues[1] : limitValues[2]}" maxlength="3"/>
						  			<c:choose>
										<c:when test="${teach.teach_age_type eq 'infants' }">
											<span class="limit_text2" style="display: inline-block;">개월 이하</span> 
										</c:when>									
										<c:otherwise>
											<span class="limit_text2" style="display: inline-block;">세 이하</span>
										</c:otherwise>
									</c:choose>
							</c:when>
							<c:otherwise>
								: <input class="text" id="teach_join_limit_value1" name="teach_join_limit_value" style="display: inline-block; width: 50px;" value="" maxlength="3" disabled="true"/> <p class="limit_text1" style="display: inline-block;" >세 이상</p> ~
					  			<input class="text" id="teach_join_limit_value2" name="teach_join_limit_value" style="display: inline-block; width: 50px;" value="" maxlength="3" disabled="true"/> <p class="limit_text2"style=" display: inline-block;">세 이하 </p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="ui-state-highlight">
						<em>* 나이 = (현재 연도 - 수강생 생년)+1 ex) 2019 - 1990 + 1 = 30</em>
					</div>
					<div>
						<form:checkbox path="limit_hak_yn" cssClass="text" value="Y" label="학년 : "/>
						<form:select path="limit_hak" cssClass="selectmenu">
							<form:option value="1" label="초등 1학년" />
							<form:option value="2" label="초등 2학년" />
							<form:option value="3" label="초등 3학년" />
							<form:option value="4" label="초등 4학년" />
							<form:option value="5" label="초등 5학년" />
							<form:option value="6" label="초등 6학년" />
							<form:option value="7" label="중등 1학년" />
							<form:option value="8" label="중등 2학년" />
							<form:option value="9" label="중등 3학년" />
							<form:option value="10" label="고등 1학년" />
							<form:option value="11" label="고등 2학년" />
							<form:option value="12" label="고등 3학년" />
						</form:select>이상 ~
						<form:select path="limit_hak2" cssClass="selectmenu">
							<form:option value="1" label="초등 1학년" />
							<form:option value="2" label="초등 2학년" />
							<form:option value="3" label="초등 3학년" />
							<form:option value="4" label="초등 4학년" />
							<form:option value="5" label="초등 5학년" />
							<form:option value="6" label="초등 6학년" />
							<form:option value="7" label="중등 1학년" />
							<form:option value="8" label="중등 2학년" />
							<form:option value="9" label="중등 3학년" />
							<form:option value="10" label="고등 1학년" />
							<form:option value="11" label="고등 2학년" />
							<form:option value="12" label="고등 3학년" />
						</form:select>이하
					</div>
					<div class="ui-state-highlight">
						<em>* 강의 설명에 학년제한 항목이 노출됩니다. 학년 정보를 반드시 입력받아야 합니다.</em>
					</div>
					<div>
						<form:checkbox path="teach_addr_limit" id="teach_addr_limit" value="Y" label="주소"/>
						<form:input path="teach_addr_limit_value" disabled="${teach.teach_addr_limit eq 'Y' ? false : true}"/>
					</div>
					<div class="ui-state-highlight">
						<em>* 구분자 ','로 나누어 허용할 주소를 입력해주세요.</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>강의유형 (<span style="color: red; font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="teach_age_type" id="teach_age_type1" value="adult"/> <label for="teach_age_type1" style="cursor:pointer;">성인 강의</label>&nbsp;
					<form:radiobutton path="teach_age_type" id="teach_age_type1" value="child"/> <label for="teach_age_type2" style="cursor:pointer;">어린이 강의</label>&nbsp;
					<form:radiobutton path="teach_age_type" id="teach_age_type1" value="infants"/> <label for="teach_age_type3" style="cursor:pointer;">영유아 강의</label>&nbsp;
				</td>
			</tr>
			<tr>
	         	<th>대리신청여부</th>
	         	<td>
	         		<form:radiobutton path="agent_yn" class="Y" value="Y"/> <label for="agent_yn1" style="cursor:pointer;">사용</label>&nbsp;
					<form:radiobutton path="agent_yn" class="N" value="N"/> <label for="agent_yn2" style="cursor:pointer;">미사용</label>
					<div class="ui-state-highlight">
						<em>* 사용 시 '수강생' 입력항목이 노출됩니다. 아닌경우 신청자 정보만으로 신청합니다.
						</em>
					</div>
				</td>
	        </tr>
	         <tr>
	        	<th>법정대리인동의여부</th>
	         	<td>
	         		<form:radiobutton path="family_yn" class="Y" value="Y"/> <label for="family_yn1" style="cursor:pointer;">사용</label>&nbsp;
					<form:radiobutton path="family_yn" class="N" value="N"/> <label for="family_yn2" style="cursor:pointer;">미사용</label>
					<div class="ui-state-highlight">
						<em>* 해당 항목 사용시 수강생 입력 또는 신청 화면에서 보호자 정보 및 승인을 입력받는 항목이 노출됩니다.<br/>
						* 성인 강의일 경우 보호자가 필요하지 않아 미사용으로 고정되고 어린이 강의일 경우 보호자가 필요하여 사용에 고정됩니다.
						</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>생년월일 입력여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton path="birth_yn" class="Y" value="Y"/> <label for="birth_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="birth_yn" class="N" value="N"/> <label for="birth_yn2" style="cursor:pointer;">사용안함</label>
					<div class="ui-state-highlight">
						<em>* 사용 시 '생년월일' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
				<th>나이입력여부</th>
				<td>
					<form:radiobutton path="age_info_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="age_info_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '나이' 입력항목이 노출됩니다.</em>
					</div>
				</td>
			</tr>
	        <tr>
	         	<th>성별 입력여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
	         	<td>
	         		<form:radiobutton path="sex_yn" class="Y" value="Y"/> <label for="sex_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="sex_yn" class="N" value="N"/> <label for="sex_yn2" style="cursor:pointer;">사용안함</label>
					<div class="ui-state-highlight">
						<em>* 사용 시 '성별' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>주소입력여부</th>
	         	<td>
	         		<form:radiobutton path="address_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="address_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					
					<form:checkbox path="detail_address_yn" label="상세주소 여부" value="Y" />
					
					<div class="ui-state-highlight">
						<em>* 사용 시 '주소' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>학교 입력여부</th>
	         	<td>
	         		<form:radiobutton path="school_info_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="school_info_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '학교' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>학년 입력여부</th>
	         	<td>
	         		<form:radiobutton path="school_grade_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="school_grade_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '학년' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>비고입력여부</th>
	         	<td>
	         		<form:radiobutton path="remark_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="remark_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '비고' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>비고안내문구</th>
	         	<td>
					<form:input path="remark_comment" class="text" cssStyle="width:90%" />
					<div class="ui-state-highlight">
						<em>* '비고' 입력 사용 시 안내 문구를 입력할 수 있습니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>가족프로그램여부</th>
	         	<td>
	         		<form:radiobutton path="family_count_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="family_count_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 가족프로그램의 경우 가족 '참여가족 인원 수' 입력 항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>수료증 발급 여부</th>
	         	<td>
	         		<form:radiobutton path="certificate_yn" class="Y" value="Y"/> <label for="certificate_yn1" style="cursor:pointer;">가능</label>&nbsp;
					<form:radiobutton path="certificate_yn" class="N" value="N"/> <label for="certificate_yn2" style="cursor:pointer;">불가능</label>
				</td>
	        </tr>
	        <tr>
	        	<th>sms 수신동의여부</th>
	        	<td>
	        		<form:radiobutton path="sms_service_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
	        		<form:radiobutton path="sms_service_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>&nbsp;
	        		<div class="ui-state-highlight">
	        			<em>* 사용 시 'sms 수신동의여부' 입력항목이 노출됩니다.<br/>
	        			* 어린이 강의일 경우 보호자 정보에 입력항목이 노출됩니다. 성인 강의이고 대리신청일 경우 수강생 정보에 입력항목이 노출됩니다.
	        			</em>
	        		</div>
	        	</td>
	        </tr>
	        <tr style="display: none;">
				<th>취소 안내 SMS</th>
				<td><form:textarea path="cancle_guid" class="text" cssStyle="width:100%;" rows="5" /></td>
			</tr>
	        <tr>
	        	<th>사진 촬영 동의 여부</th>
	        	<td>
	        		<form:radiobutton path="picture_use_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
	        		<form:radiobutton path="picture_use_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>&nbsp;
	        		<div class="ui-state-highlight">
	        			<em>* 사용 시 '사진 촬영 동의 여부' 입력항목이 노출됩니다.<br/>
	        			* 어린이 강의일 경우 수강생 정보에 입력항목이 노출됩니다. 성인 강의이고 대리신청일 경우 수강생 정보에 입력항목이 노출됩니다.
	        			</em>
	        		</div>
	        	</td>
	        </tr>
	        <tr>
	         	<th>지역입력여부</th>
	         	<td>
	         		<form:radiobutton path="neis_location_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="neis_location_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '지역' 선택항목이 노출됩니다.(나이스용)</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>개인번호</th>
	         	<td>
	         		<form:radiobutton path="neis_cd_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="neis_cd_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '개인번호' 입력항목이 노출됩니다.(나이스용)</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>연수지명번호입력여부</th>
	         	<td>
	         		<form:radiobutton path="neis_training_num_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="neis_training_num_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '연수지명번호' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>기관 입력여부</th>
	         	<td>
	         		<form:radiobutton path="organization_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="organization_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '기관' 입력항목이 노출됩니다. (예: 도서관 정보화과)</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>직급 입력여부</th>
	         	<td>
	         		<form:radiobutton path="rank_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="rank_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '직급' 입력항목이 노출됩니다. (예: 행정7급, 지방행정사무관)</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>연수수강여부 입력여부</th>
	         	<td>
	         		<form:radiobutton path="course_taken_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="course_taken_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '연수수강여부' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	         	<th>백신여부 입력여부</th>
	         	<td>
	         		<form:radiobutton path="vaccines_yn" class="Y" value="Y" label="사용" style="cursor:pointer;"/>&nbsp;
					<form:radiobutton path="vaccines_yn" class="N" value="N" label="미사용" style="cursor:pointer;"/>
					<div class="ui-state-highlight">
						<em>* 사용 시 '백신여부' 입력항목이 노출됩니다.</em>
					</div>
				</td>
	        </tr>
	        <tr>
	        	<th>신청첨부파일 여부</th>
	        	<td>
	        		<form:radiobutton path="apply_file_yn" value="Y" label="사용"/>
	        		<form:radiobutton path="apply_file_yn" value="N" label="미사용"/>
	        		<div class="ui-state-highlight">
						<em>* 사용 시 '신청첨부파일여부' 입력항목이 노출됩니다.</em>
					</div>
	        	</td>
	        </tr>
	        <tr>
	         	<th>휴강일설정</th>
	         	<td>
	         		<div style="float: left; margin-right: 10px;">
		         		<input type="text" class="text ui-calendar" id="tempHoliDay" style="vertical-align: top">
		         		<input type="text" class="text ui-calendar" id="tempHoliDayDummy" style="vertical-align: top; display: none;">
		         		<br/>
		         		<a href="#" id="addHoliday" class="btn btn5" style="vertical-align: top; width:95px;"><i class="fa fa-plus" aria-hidden="true"></i>휴강일 추가 </a>
		         		<br/>
		         		<a href="#" id="deleteHoliday" class="btn" style="vertical-align: top; width:95px;"><i class="fa fa-times" aria-hidden="true"></i>선택 삭제 </a>
		         		<br/>
	         		</div>
	         		<div>
		         		<form:select path="holidays" multiple="true" cssClass="selectmenu" cssStyle="width:40%;" size="5">
		         			<c:forEach items="${teach.holidays}" var="i" varStatus="status">
		         			<form:option value="${i}">${i}</form:option>
		         			</c:forEach>
		         		</form:select>
	         		</div>
					<div>
						휴관일 표시안함여부
						<form:radiobutton path="disable_holi" value="Y" label="사용"/>
						<form:radiobutton path="disable_holi" value="N" label="미사용"/>
					</div>
					<div>
						휴강일 달력 표시 제외
						<form:radiobutton path="disable_holi_calendar" value="Y" label="사용"/>
						<form:radiobutton path="disable_holi_calendar" value="N" label="미사용"/>
					</div>
					
					<div class="ui-state-highlight" style="clear: both;">
						<em>* '이달의 행사' 메뉴에서 '(휴강)강좌명' 으로 표시됩니다.<br/>* Ctrl+클릭 시 다중선택 가능합니다.<br/>*  표시안함여부를 사용함으로 바꾸면 '이달의 행사'메뉴에서 '(강좌)강좌명'으로 표시됩니다.
							<br/>* 휴강일 달력 표시 제외를 사용함으로 바꾸면 캘린더에서 보여지지 않습니다.</em>
					</div>
				</td>
	        </tr>
		</tbody>
	</table>
</form:form>

<div id="dialog-teacher" class="dialog-common" title="강사 검색"></div>