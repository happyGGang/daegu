<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){
	$('button#search_btn').on('click', function(e) {
		$('#viewPage_ajax').val(1);
		doAjaxLoad('#studentLayer', 'student.do', serializeCustom($('#studentListForm')));
		e.preventDefault();
	});

	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
			return false;
		}
		if ( '${student.teach_idx}' == 0 ){
			alert('선택된 강좌가 없습니다.');
			return false;
		}

		else{
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=${student.homepage_id}&group_idx=${student.group_idx}&category_idx=${student.category_idx}&teach_idx=${student.teach_idx}&large_category_idx=${student.large_category_idx}', function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}

		e.preventDefault();
	});

	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=${student.homepage_id}&group_idx=${student.group_idx}&category_idx=${student.category_idx}&teach_idx=${student.teach_idx}&large_category_idx=${student.large_category_idx}&student_idx=' + $(this).attr('keyValue1'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete-btn').on('click', function(e) {
		if ( confirm('해당 수강생을 삭제 하시겠습니까?') ) {
			$('#delForm #student_idx').val($(this).attr('keyValue1'));
			if(doAjaxPost($('#delForm'))) {
				$('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
			}
		}
		e.preventDefault();
	});

	$('a.cancel_btn').on('click', function(e) {
		if (confirm('해당 수강생의 신청을 취소하시겠습니까?')) {
			$('#delForm > #editMode').val('CANCEL');

			$('#delForm #student_idx').val($(this).attr('keyValue1'));
			if(doAjaxPost($('#delForm'))) {
				$('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
			}
		}
		e.preventDefault();
	});

	$('a#batch-delete-btn').on('click', function(e) {
		var student_idx_arr = $('input.student_idx_arr:checked').map(function() { return $(this).val(); }).get().join(',');

		if ( !student_idx_arr ){
			alert('선택된 수강생이 없습니다.');
			return false;
		}

		if ( confirm('선택한 수강생들을 삭제 하시겠습니까?') ) {
			$('#delForm > #editMode').val('BATCH_DELETE');
			$('#delForm #student_idx_arr').val(student_idx_arr);
			if(doAjaxPost($('#delForm'))) {
				$('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
			}
		}
		e.preventDefault();
	});

	$('a#batch-cancel-btn').on('click', function(e) {
		var student_idx_arr = $('input.student_idx_arr:checked').map(function() { return $(this).val(); }).get().join(',');

		if ( !student_idx_arr ){
			alert('선택된 수강생이 없습니다.');
			return false;
		}

		if (confirm('선택한 수강생들의 신청을 취소하시겠습니까?')) {
			$('#delForm > #editMode').val('BATCH_CANCEL');
			$('#delForm #student_idx_arr').val(student_idx_arr);
			if(doAjaxPost($('#delForm'))) {
				$('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
			}
		}
		e.preventDefault();
	});

	$('a.dialog-certificate').on('click', function(e) {
		$('#studentListForm input#student_idx').val($(this).attr('keyValue'));
		$('#dialog-2').load('certificate.do?'+$('#studentListForm').serialize(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});

		e.preventDefault();
	});

	$('a.add_blackList').on('click', function(e) {
		$('#dialog-3').load('/cms/module/blackList/edit.do?editMode=ADD&black_type=10&after_click_btn=button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}&homepage_id=' + $(this).attr('homepage_id') + '&member_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-3').dialog({
				width: 500,
				height: 250
			});
			$('#dialog-3').dialog('open');
		});

		e.preventDefault();
	});

	$('a.delete_blackList').on('click', function(e) {
		e.preventDefault();

		if (confirm('해당 수강생을 블랙리스트 목록에서 삭제하시겠습니까?')) {
			var data = {
				editMode : 'BLACKTYPEDELETE',
				homepage_id : $(this).attr('homepage_id'),
				member_id : $(this).attr('keyValue'),
				black_type	: '10'
			}

			jQuery.ajaxSettings.traditional = true;
		    $.ajax({
		        type: "POST",
		        url: '/cms/module/blackList/save.do',
		        async: false,
		        data: data,
		        dataType:'json',
		        success: function(response) {
		        	response = eval(response);
		            if(response.valid) {
		                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
		                	 alert(response.message);
		                 }
		                 $('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
					} else {
						if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
							alert(response.message);
		                } else {
		                	for(var i =0 ; i < response.result.length ; i++) {
		    					alert(response.result[i].code);
		    					$('#'+response.result[i].field).focus();
		    					$('#'+response.result[i].field, $(form)).css('border-color', 'red');
		                		$('#'+response.result[i].field, $(form)).on('change', function() {
		                			$(this).css('border-color', '');
		                		});
		    					break;
		    				}
		                }
					}
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		         }
		    });
		}
	});

	$('a#excelDownload').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
			return false;
		}
		if ( '${student.teach_idx}' == 0 ){
			alert('선택된 강좌가 없습니다.');
			return false;
		}

		$('#delForm').attr('action', 'excelDownload.do').submit();
		$('#delForm').attr('action', 'save.do');
		e.preventDefault();
	});

	$('a#csvDownload').on('click', function(e) {
		e.preventDefault();
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
			return false;
		}
		if ( '${student.teach_idx}' == 0 ){
			alert('선택된 강좌가 없습니다.');
			return false;
		}

		$('#delForm').attr('action', 'csvDownload.do').submit();
	});

	$('a.formPrint-btn').on('click', function(e) {
		var divToPrint = $('div#printPage').clone();
		divToPrint = divToPrint.show()[0];
	    newWin= window.open("");
	    newWin.document.write(divToPrint.outerHTML);
	    newWin.document.close();
	    newWin.print();
	    newWin.close();
	});

	$('a#excelUpload').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
			return false;
		}
		if ( '${student.teach_idx}' == 0 ){
			alert('선택된 강좌가 없습니다.');
			return false;
		}

		if(confirm('열의순서와 값을 다시한번 확인하신 후 파일을 첨부해 주시기 바랍니다.\n 비고란 및 나이스 정보 등 해당 강좌에 맞게 작성하여 업로드 하시기 바랍니다. \n 노란색 열은 필수 입력항목입니다.\n 해당사항이 없는 경우 입력하지 마시기 바랍니다. \n 작업은 시스템 사정에 따라 몇분정도가 소요될 수 있습니다.')) {
			$('input#file').click();
		}
		e.preventDefault();
	});

	$('input#file').change(function(e) {
		var data = new FormData();
		var sendFile = $('#file')[0].files;
		if ( sendFile.length > 0 ) {
			data.append('file', sendFile[0]);
			data.append('homepage_id', $('#studentListForm #homepage_id').val());
			data.append('group_idx', $('#studentListForm #group_idx').val());
			data.append('category_idx', $('#studentListForm #category_idx').val());
			data.append('teach_idx', $('#studentListForm #teach_idx').val());
			data.append('large_category_idx', $('#studentListForm #large_category_idx').val());
			$.ajax({
		        type: "POST",
		        url: 'excelUpload.do',
		        async: false,
		        processData: false,
	    	    contentType: false,
		        data: data,
		        dataType : 'json',
		        success: function(response) {
		        	$('tbody.dataList').html('');
		        	var htmlArr = [];
		        	$(response.studentList).each(function(i, v){
		        		htmlArr.push('<tr>');
		        		htmlArr.push('<td>' + (i+1) + '</td>');
		        		htmlArr.push('<td>'+v.member_id 			+'<input type="hidden" name="studentList['+i+'].member_id" value="'+v.member_id+'"></td>');
		        		htmlArr.push('<td>'+v.applicant_name 		+'<input type="hidden" name="studentList['+i+'].applicant_name" value="'+v.applicant_name+'"></td>');
		        		htmlArr.push('<td>'+v.applicant_birth 		+'<input type="hidden" name="studentList['+i+'].applicant_birth" value="'+v.applicant_birth+'"></td>');
		        		htmlArr.push('<td>'+v.applicant_sex 		+'<input type="hidden" name="studentList['+i+'].applicant_sex" value="'+v.applicant_sex+'"></td>');
		        		htmlArr.push('<td>'+v.applicant_zipcode 	+'<input type="hidden" name="studentList['+i+'].applicant_zipcode" value="'+v.applicant_zipcode+'"></td>');
		        		htmlArr.push('<td>'+v.applicant_address 	+'<input type="hidden" name="studentList['+i+'].applicant_address" value="'+v.applicant_address+'"></td>');
		        		htmlArr.push('<td>'+v.applicant_cell_phone	+'<input type="hidden" name="studentList['+i+'].applicant_cell_phone" value="'+v.applicant_cell_phone+'"></td>');
		        		htmlArr.push('<td>'+v.self_yn               +'<input type="hidden" name="studentList['+i+'].self_yn" value="'+v.self_yn+'"></td>');
		        		htmlArr.push('<td>'+v.student_name 			+'<input type="hidden" name="studentList['+i+'].student_name" value="'+v.student_name+'"></td>');
		        		htmlArr.push('<td>'+v.student_birth 		+'<input type="hidden" name="studentList['+i+'].student_birth" value="'+v.student_birth+'"></td>');
		        		htmlArr.push('<td>'+v.student_sex 			+'<input type="hidden" name="studentList['+i+'].student_sex" value="'+v.student_sex+'"></td>');
		        		htmlArr.push('<td>'+v.student_zipcode 		+'<input type="hidden" name="studentList['+i+'].student_zipcode" value="'+v.student_zipcode+'"></td>');
		        		htmlArr.push('<td>'+v.student_address 		+'<input type="hidden" name="studentList['+i+'].student_address" value="'+v.student_address+'"></td>');
		        		htmlArr.push('<td>'+v.picture_use_yn        +'<input type="hidden" name="studentList['+i+'].picture_use_yn" value="'+v.picture_use_yn+'"></td>');
		        		htmlArr.push('<td>'+v.self_parent_yn        +'<input type="hidden" name="studentList['+i+'].self_parent_yn" value="'+v.self_parent_yn+'"></td>');
		        		htmlArr.push('<td>'+v.family_relation 		+'<input type="hidden" name="studentList['+i+'].family_relation" value="'+v.family_relation+'"></td>');
		        		htmlArr.push('<td>'+v.family_name 			+'<input type="hidden" name="studentList['+i+'].family_name" value="'+v.family_name+'"></td>');
		        		htmlArr.push('<td>'+v.family_cell_phone		+'<input type="hidden" name="studentList['+i+'].family_cell_phone" value="'+v.family_cell_phone+'"></td>');
		        		htmlArr.push('<td>'+v.sms_service_yn        +'<input type="hidden" name="studentList['+i+'].sms_service_yn" value="'+v.sms_service_yn+'"></td>');
		        		htmlArr.push('<td>'+v.family_confirm_yn		+'<input type="hidden" name="studentList['+i+'].family_confirm_yn" value="'+v.family_confirm_yn+'"></td>');
		        		htmlArr.push('<td>'+v.family_desc			+'<input type="hidden" name="studentList['+i+'].family_desc" value="'+v.family_desc+'"></td>');
		        		htmlArr.push('<td>'+v.student_family_count	+'<input type="hidden" name="studentList['+i+'].student_family_count" value="'+v.student_family_count+'"></td>');
		        		htmlArr.push('<td>'+v.student_school 		+'<input type="hidden" name="studentList['+i+'].student_school" value="'+v.student_school+'"></td>');
		        		htmlArr.push('<td>'+(v.student_hack == 0 ? "" : v.student_hack)	+'<input type="hidden" name="studentList['+i+'].student_hack" value="'+(v.student_hack == 0 ? "1" : v.student_hack)+'"></td>');
		        		htmlArr.push('<td>'+v.student_remark		+'<input type="hidden" name="studentList['+i+'].student_remark" value="'+v.student_remark+'"></td>');
		        		htmlArr.push('<td>'+v.student_location_code	+'<input type="hidden" name="studentList['+i+'].student_location_code" value="'+v.student_location_code+'"></td>');
		        		htmlArr.push('<td>'+v.student_neis_cd		+'<input type="hidden" name="studentList['+i+'].student_neis_cd" value="'+v.student_neis_cd+'"></td>');
		        		htmlArr.push('<td>'+v.student_training_num	+'<input type="hidden" name="studentList['+i+'].student_training_num" value="'+v.student_training_num+'"></td>');
		        		htmlArr.push('<td>'+v.student_organization	+'<input type="hidden" name="studentList['+i+'].student_organization" value="'+v.student_organization+'"></td>');
		        		htmlArr.push('<td>'+v.student_rank			+'<input type="hidden" name="studentList['+i+'].student_rank" value="'+v.student_rank+'"></td>');
		        		htmlArr.push('<td>'+v.student_course_taken_yn +'<input type="hidden" name="studentList['+i+'].student_course_taken_yn" value="'+v.student_course_taken_yn+'"></td>');
		        		htmlArr.push('<td>'+v.agree_codes			+'<input type="hidden" name="studentList['+i+'].agree_codes" value="'+v.agree_codes+'"></td>');
		        		htmlArr.push('<td style="display:none">'+v.student_old 			+'<input type="hidden" name="studentList['+i+'].student_old" value="'+v.student_old+'"></td>');
		        		htmlArr.push('</tr>');
		        	});
					$('div#dialog-4 tbody.dataList').html(htmlArr.join(''));

		        	$('div#dialog-4.dialog-common').dialog({ //모달창 기본 스크립트 선언
		        		autoOpen: true,
		        		resizable: false,
		        		modal: true,
		        	    open: function(){
		        	        $('.ui-widget-overlay').addClass('custom-overlay');
		        	    },
		        	    close: function(){
		        	        $('.ui-widget-overlay').removeClass('custom-overlay');
		        	        $('body > div.ui-dialog').remove();
		        	        $('button.teach_btn_${student.group_idx}${student.category_idx}${student.teach_idx}').click();
		        	    },
		        		buttons: [
		        			{
		        				text: "저장",
		        				"class": 'btn btn1',
		        				click: function() {
		        					if (confirm('저장하시겠습니까?\n\n*ID가 정확하지 않은경우 해당사용자가 수강신청 내역을 확인할 수 없습니다.')) {
			        					doAjaxPost($('#excelStudentList'));
		        						$('#studentLayer').load('student.do?' + $('#studentListForm').serialize());
		        						$(this).dialog('destroy');

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

		        	$("div#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		        		width: 1200,
		        		height: 600
		        	});

		        }
			});
		}

		$('#file').val('');
	});

	$('a#excelDownloadSample').on('click', function(e) {
		if($('#teach_idx').val() == 0){
			alert('강좌를 선택해 주세요.');
			return false;
		}
		$('#studentListForm #homepage_id').clone().appendTo('#excelDownloadSampleForm');
		$('#studentListForm #group_idx').clone().appendTo('#excelDownloadSampleForm');
		$('#studentListForm #category_idx').clone().appendTo('#excelDownloadSampleForm');
		$('#studentListForm #teach_idx').clone().appendTo('#excelDownloadSampleForm');
		$('#excelDownloadSampleForm').submit();
		e.preventDefault();
	});

	$('input#checkAll').on('click', function(e) {
		$('input[type=checkbox].student_idx_arr').prop('checked', $(this).is(':checked'));
	});
	
	$('select#rowCount').on('change', function(e) {
		e.preventDefault();
		$('#studentLayer').load('student.do?homepage_id=' + $('#studentListForm #homepage_id').val() + '&group_idx=' + $('#studentListForm #group_idx').val() + '&category_idx=' + $('#studentListForm #category_idx').val() + '&teach_idx=' + $('#studentListForm #teach_idx').val() +'&large_category_idx=' + $('#studentListForm #large_category_idx').val() + '&rowCount=' + $('#studentListForm #rowCount').val());
	});
	
});
</script>
<form:form id="delForm" modelAttribute="student" action="save.do">
	<form:hidden path="editMode" value="DELETE"/>
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="student_idx_arr"/>
</form:form>

<form:form id="studentListForm" modelAttribute="student" action="student.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="student_idx" />
	<c:if test="${student.editMode eq 'FIRST'}">
		<div class="mask"></div>
	</c:if>
	<div class="infodesk">
		검색 결과 : ${studentListCount}건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="20">20개씩 보기</form:option>
			<form:option value="30">30개씩 보기</form:option>
			<form:option value="${studentListCount}">전체 보기</form:option>
		</form:select>
		<div class="button btn-group inline">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add" style="margin-right: 5px;"><i class="fa fa-plus"></i><span>수강생등록</span></a>
				<a href="#" id="excelUpload" class="btn btn5" style="margin-right: 5px;"><i class="fa fa-plus"></i><span>엑셀등록</span></a>
				<a href="#" id="excelDownloadSample" class="btn btn2" style="margin-right: 5px;"><i class="fa fa-file-excel-o"></i><span>신청서</span></a>
				<a href="#" class="btn btn1 formPrint-btn" style="margin-right: 5px;"><i class="fa fa-file-excel-o"></i><span>신청서 인쇄</span></a>
				<a href="#" class="btn btn5 left" id="batch-delete-btn" style="margin-right: 5px;"><i class="fa fa-minus"></i><span>일괄삭제</span></a>
				<a href="#" class="btn btn5 left" id="batch-cancel-btn" style="margin-right: 5px;"><i class="fa fa-minus"></i><span>일괄취소</span></a>
			</c:if>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="5%">
			<col width="6%" />
			<col width="10%" />
			<col width="11%" />
			<col width="8%" />
			<col width="13%" />
			<col width="7%" />
			<c:if test="${teachInfo.vaccines_yn eq 'Y'}">
				<col width="7%" />
			</c:if>
			<c:if test="${teachInfo.school_grade_yn eq 'Y'}">
				<col width="7%" />
			</c:if>
			<col width="9%" />
			<c:if test="${teachInfo.teach_status ne '1'}">
				<col width="8%" />
				<col width="9%" />
			</c:if>
			<col width="13%" />
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll"></th>
				<th>순번</th>
				<th>이름<br/>(수강생)(ID)</th>
				<th>생년월일<br/>(수강생)</th>
				<th>성별<br/>(수강생)</th>
				<th>휴대전화번호<br/>(신청자)</th>
				<th>상태</th>
				<c:if test="${teachInfo.vaccines_yn eq 'Y'}">
					<th>접종상태</th>
				</c:if>
				<c:if test="${teachInfo.school_grade_yn eq 'Y'}">
					<th>반</th>
				</c:if>
				<th>신청일</th>
				<th>취소자ID</th>
				<th>취소일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(studentList) < 1}">
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${teachInfo.teach_status ne '1'}"> --%>
					<tr style="height:100%">
						<td colspan="11" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td>
					</tr>
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
<!-- 					<tr style="height:100%"> -->
<!-- 						<td colspan="9" style="background:#f8fafb;">데이터가 존재하지 않습니다.</td> -->
<!-- 					</tr> -->
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose> --%>
		</c:if>
		<c:forEach var="i" varStatus="status" items="${studentList}">
			<tr>
				<td><form:checkbox path="student_idx_arr" cssClass="student_idx_arr" value="${i.student_idx}"/></td>
				<td class="num">${((paging.viewPage-1)*paging.rowCount) + status.count}</td>
				<td>
					<font>
					${i.student_name}
					<c:if test="${empty i.web_id}">
						<c:set var="member__id" value=""></c:set>
						<c:choose>
						<c:when test="${fn:indexOf(i.member_id, '*') > -1}">
							<c:set var="member__id" value="${fn:replace(i.member_id, '*', '') }"></c:set>
							<br/>(${fn:toLowerCase(member__id)})
						</c:when>
						<c:otherwise>
							<br/>(${i.member_id})
						</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${not empty i.web_id}">
					<br/>(${i.web_id})
					</c:if>
					</font>
				</td>
				<td>${i.student_birth}</td>
				<td>
					<c:choose>
						<c:when test="${i.student_sex eq 'M'}">남자</c:when>
						<c:when test="${i.student_sex eq 'F'}">여자</c:when>
					</c:choose>
				</td>
				<td>${i.applicant_cell_phone}</td>
				<td>
					<c:choose>
						<c:when test="${teachInfo.teach_status eq '1' }">
							${i.student_status eq '1'? '수료' : i.apply_status eq '1' ? '미수료' : statusCode[i.apply_status].code_name}
						</c:when>
						<c:otherwise>
							${(i.apply_type eq 'CMS') and (i.apply_status eq 1) ? '오프 참여' : statusCode[i.apply_status].code_name}
						</c:otherwise>
					</c:choose>
				</td>
				<c:if test="${teachInfo.vaccines_yn eq 'Y'}">
					<td>
						<c:choose>
							<c:when test="${i.vaccines_counter eq '1' }">
								1회접종자
							</c:when>
							<c:when test="${i.vaccines_counter eq '2' }">
								2회접종자
							</c:when>
							<c:when test="${i.vaccines_counter eq '3' }">
								3회접종자
							</c:when>
							<c:otherwise>
								미접종자
							</c:otherwise>
						</c:choose>
					</td>
				</c:if>
				<c:if test="${teachInfo.school_grade_yn eq 'Y'}">
					<td>
						<c:if test="${empty i.student_ban}">없음</c:if>
						${i.student_ban}
					</td>
				</c:if>
				<td>
					${i.add_date}
				</td>
				<td>${i.cancel_id}</td>
				<td><fmt:formatDate value="${i.cancel_date}" pattern="yyyy-MM-dd"/></td>
				<td>
					<c:if test="${authU}">
					<a href="" class="btn dialog-modify" keyValue1="${i.student_idx}">수정</a>
					</c:if>
					<c:if test="${teachInfo.teach_status ne '1' }">
						<c:if test="${i.apply_status ne '99'}">
							<c:if test="${authU or authD}">
							<a href="" class="btn cancel_btn" keyValue1="${i.student_idx}">취소</a>
							</c:if>
						</c:if>
					</c:if>
					<c:if test="${authD}">
					<a href="" class="btn delete-btn" keyValue1="${i.student_idx}">삭제</a><br/>
					</c:if>
					
					<c:if test="${i.isBlackList > 0}">
					<a href="" class="btn btn4 delete_blackList" homepage_id="${i.homepage_id}" keyValue="${i.member_id}">블랙리스트 삭제</a>
					</c:if>
					<c:if test="${i.isBlackList < 1}">
					<a href="" class="btn btn1 add_blackList" homepage_id="${i.homepage_id}" keyValue="${i.member_id}">블랙리스트 추가</a>
					</c:if>
					
					<c:if test="${not empty i.server_file_name}">
					<a href="download/${i.homepage_id}/${i.group_idx}/${i.category_idx}/${i.teach_idx}/${i.student_idx}.do" class="btn file_btn">파일</a>
					</c:if>
					<c:if test="${teachInfo.teach_status eq '1' }">
						<c:if test="${i.student_status eq '1' }">
						<a href="" class="btn dialog-certificate" keyValue="${i.student_idx}">수료증 출력</a>
						</c:if>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging_ajax.jsp" flush="false">
		<jsp:param name="formId" value="#studentListForm"/>
		<jsp:param name="layerId" value="#studentLayer"/>
		<jsp:param name="pagingUrl" value="student.do"/>
	</jsp:include>

	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="STUDENT_NAME">수강생명</form:option>
				<form:option value="APPLICANT_NAME">신청자명</form:option>
				<form:option value="APPLICANT_BIRTH">생년월일</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</fieldset>
	</div>
	<div class="ui-state-highlight">
		<em>신청자에 대한 상세 항목은 엑셀, CSV 다운로드 하여 확인 할 수 있습니다.</em>
	</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="수강생 정보">
</div>

<div id="dialog-2" class="dialog-common" title="수료증">
</div>

<div id="dialog-3" class="dialog-common" title="블랙리스트 추가">
</div>

<div id="dialog-4" class="dialog-common auto-scroll" title="수강생 리스트">
	<form id="excelStudentList" method="post" action="save.do">
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="hidden" name="homepage_id" value="${student.homepage_id}"/>
	<input type="hidden" name="group_idx" value="${student.group_idx}"/>
	<input type="hidden" name="category_idx" value="${student.category_idx}"/>
	<input type="hidden" name="large_category_idx" value="${student.large_category_idx}"/>
	<input type="hidden" name="teach_idx" value="${student.teach_idx}"/>
	<input type="hidden" name="editMode" value="SAVELIST"/>
	<table type="1" style="width:2000px">
		<thead>
			<tr>
				<th>번호</th>
				<th>신청자 ID</th>
				<th>신청자 명</th>
				<th>신청자 생년월일</th>
				<th>신청자 성별(남,여)</th>
				<th>신청자 우편번호</th>
				<th>신청자 주소</th>
				<th>신청자 휴대전화번호</th>
				<th>수강생-신청자 동일여부</th>
				<th>수강생 명</th>
				<th>수강생 생년월일</th>
				<th>수강생 성별(남,여)</th>
				<th>수강생 우편번호</th>
				<th>수강생 주소</th>
				<th>사진 촬영 동의 여부</th>
				<th>보호자-신청자 동일여부</th>
				<th>보호자 관계</th>
				<th>보호자 성명</th>
				<th>보호자 연락처</th>
				<th>SMS 수신 동의 여부</th>
				<th>보호자 동의 여부(Y,N)</th>
				<th>보호자 비고여부</th>
				<th>가족 인원 수</th>
				<th>학교</th>
				<th>학년</th>
				<th>일반 비고부</th>
				<th>코드 입력
				<th>나이스 개인번호
				<th>나이스 연수지명번호
				<th>기관
				<th>직급
				<th>연수수강여부 (Y,N)
				<th>선택약관</th>
			</tr>
		</thead>
		<tbody class="dataList">
		</tbody>
	</table>
	</form>
</div>

<div id="printPage" class="center" style="display:none; width:600; float:center">
<%@ include file="print.jsp"%>
</div>


<form id="excelUploadForm" action="excelUpload.do" method="post" enctype="multipart/form-data" hidden="hidden" >
	<input type="hidden" name="_csrf" value="${_csrf.token}">
	<input type="file" id="file" name="file">
</form>
<form id="excelDownloadSampleForm" action="excelDownloadSample.do" method="get" hidden="hidden" >
<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>