<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
var oEditors = [];
$(function() {
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "conrtents",
		sSkinURI: "/resources/common/smart_editor/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {

		},
		fCreator: "createSEditor2"
	});
	
	$('a#modify_btn').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('MODIFY');
		oEditors.getById["conrtents"].exec("UPDATE_CONTENTS_FIELD", []);
		jQuery.ajaxSettings.traditional = true;
		var option = {
			url : 'save.do',
			type : "POST",
			success: function(response) {
				 if(response.valid) {
	                 if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
						doGetLoad(response.url, response.data);
	                 }
				} else {
	                for(var i =0 ; i < response.result.length ; i++) {
						alert(response.result[i].code);
						$('#'+response.result[i].field).focus();
						break;
					}
				}
	         },
	         error: function(jqXHR, textStatus, errorThrown) {
	             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
	         }
		};
		$('#relayLectureEdit').ajaxSubmit(option);
	});

	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('view.do', $('form#relayLectureEdit').serialize());
	});

	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do';
	});
	
	if($('input#editMode').val() == 'ADD'){
		$('div#btn_div').hide();
	} else {
		$('div#btn_div').show();
	}
	
	<%-- 이미지 미리보기 --%>
	$('input#org_file_name_temp').change(function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$('img#newImg').attr('src', e.target.result);
			};
			reader.readAsDataURL(this.files[0]);
		} else {
			$('img#newImg').attr('src', '/resources/img/wsm/noimg_135_42.gif');
		}
	});
 
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
					jQuery.ajaxSettings.traditional = true;
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#relayLectureEdit').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
				    			location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#relayLectureEdit').ajaxSubmit(option);
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

	$('#dialog-1').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 900
	});
	
	$('input#event_start_date').datepicker({
		maxDate: $('input#event_end_date').val(),
		onClose: function(selectedDate){
			$('input#event_end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#event_end_date').datepicker({
		minDate: $('input#event_start_date').val(),
		onClose: function(selectedDate){
			$('input#event_start_date').datepicker('option', 'maxDate', selectedDate);
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

	//달력
	$('.ui-calendar').each(function(){
		$(this).datepicker({
			//기본달력
		});
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
});

</script>

<form:form modelAttribute="relayLecture" id="relayLectureEdit" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data" >
<form:hidden path="homepage_id"/>
<form:hidden path="lecture_idx"/>
<form:hidden path="editMode"/>

	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="25%">
			<col width="">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>행사명(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="event_name" cssClass="text" cssStyle="width: 95%;" />
				</td>
			</tr>
			<tr>
				<th>행사일자(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="event_start_date" cssClass="text ui-calendar " /> ~ 
					<form:input path="event_end_date" cssClass="text ui-calendar " />
				</td>
			</tr>
			<tr>
				<th>행사장소(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="event_place" cssClass="text" />
				</td>
			</tr>
			<tr>
				<th>행사시간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="event_start_time" cssClass="text" cssStyle="width: 50px;" maxlength="5" /> ~ 
					<form:input path="event_end_time" cssClass="text" cssStyle="width: 50px;" maxlength="5" />
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>신청 가능 기간(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="apply_start_date" cssClass="text ui-calendar " /> 
					<form:input path="apply_start_time" cssClass="text" cssStyle="width: 50px;" maxlength="5" /> ~ 
					<form:input path="apply_end_date" cssClass="text ui-calendar " />
					<form:input path="apply_end_time" cssClass="text" cssStyle="width: 50px;" maxlength="5" />
					<div class="ui-state-highlight">
						<em>* 시간 입력 ex) 10:30</em>
					</div>
				</td>
			</tr>
			<tr>
				<th>모집인원(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="recruitment_number" cssClass="text" cssStyle="width: 40px;" numberOnly="true" />명
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<form:textarea path="conrtents" rows="10" cols="100" cssStyle="width: 100%;" />
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
	         		<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="이미지 파일 첨부" accept=".gif,.jpeg,.jpg,.png"/>
         		</td>
			</tr>
			<c:if test="${relayLecture.editMode eq 'MODIFY'}">
				<c:if test="${relayLecture.server_file_name ne NULL}">
					<tr>
						<th scope="row">이미지</th>
						<td colspan="3">
							<div class="item">
								<img width="135" height="42" src="${getContextPath}/data/relayLecture/${relayLecture.homepage_id}/${relayLecture.server_file_name}" alt="${relayLecture.event_name}">
							</div>
						</td>
					</tr>
				</c:if>
				<tr>
					<th scope="row">변경될 이미지</th>
					<td colspan="3">
						<div class="item">
							<img id="newImg" name="newImg" width="135" height="42" src="/resources/cms/img/noimg_135_42.gif" alt="noImage">
						</div>
					</td>
				</tr>
		</c:if>
			<c:if test="${relayLecture.editMode eq 'ADD'}">
			<tr>      
				<th scope="row">등록될 이미지</th>
				<td colspan="3">
					<div class="item">
						<img id="newImg" name="newImg" width="135" height="42" src="/resources/cms/img/noimg_135_42.gif" alt="noImage">
					</div>
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	
	<div id="btn_div" class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="modify_btn" class="btn btn1">저장</a>
		<a href="#" id="cancle_btn" class="btn btn5">취소</a>
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
	
</form:form>

