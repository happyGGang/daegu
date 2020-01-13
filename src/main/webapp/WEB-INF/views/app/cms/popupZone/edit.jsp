<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script>
$(function() {
	var oEditors = [];
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
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
						data : $('#popupZone').serialize(),
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
					$('#popupZone').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 600
	});

	//달력
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


});

function getFileData(fileData) {
	fileList = fileData;
	var html = '';
	for (var i = 0; i < fileList.length; i++) {
		alert(fileList[i].name);
	}
}
</script>
<form:form modelAttribute="popupZone" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="popup_zone_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>팝업존명(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="popup_zone_name" cssStyle="width:200px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr>
			<th>게시일(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="start_date" cssClass="text ui-calendar"/> ~ <form:input path="end_date" cssClass="text ui-calendar"/>
			</td>
		</tr>
		<tr>
			<th>이미지</th>
			<td>
				<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="이미지 파일 첨부" accept=".gif,.jpeg,.jpg,.png"/>
				<c:choose>
					<c:when test="${popupZone.homepage_id eq 'h1' }"><!-- 228기념학생도서관 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 413 X 세로 325 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h2' }"><!-- 228민주운동기념회관 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 413 X 세로 430 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h3' }"><!-- 남부 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 410 X 세로 442 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h4' }"><!-- 달성 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 410 X 세로 430 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h5' }"><!-- 동부 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 600 X 세로 220 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h6' }"><!-- 두류 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 413 X 세로 328 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h7' }"><!-- 북부 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 413 X 세로 328 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h8' }"><!-- 서부 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 600 X 세로 220 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h9' }"><!-- 수성 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 315 X 세로 313 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h10' }"><!-- 중앙 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 395 X 세로 350 입니다(픽셀단위)</em>
					</div>
					</c:when>
				</c:choose>

			</td>
		</tr>
		<tr>
			<th scope="row">이미지 대체 텍스트</th>
			<td>
				<form:textarea path="alt_text" cssStyle="width:100%; height:60px;"/>
			</td>
		</tr>
		<c:if test="${popupZone.editMode eq 'MODIFY'}">
		<tr>
			<th>현재 이미지</th>
			<td>
				<img id="currentImg" name="currentImg" src="/data/popupZone/${popupZone.homepage_id}/${popupZone.server_file_name}" alt="${popupZone.server_file_name}"/>
			</td>
		</tr>
		</c:if>
		<tr>
			<th>링크URL(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="link_url" cssClass="text" cssStyle="width:300px;" maxlength="200"/>
				<div class="ui-state-highlight">
					<em>* 팝업존 클릭시 이동 할 URL 입니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>링크타겟</th>
			<td>
				<form:radiobutton path="link_target" value="CURRENT"/> <label for="link_target1" style="cursor:pointer;">현재창</label>&nbsp;
				<form:radiobutton path="link_target" value="BLANK"/> <label for="link_target2" style="cursor:pointer;">새창</label>
			</td>
		</tr>
		<tr>
			<th>출력 순서</th>
			<td>
				<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>오름차순 정렬. 낮을수록 앞에 출력됩니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<form:radiobutton path="use_yn" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
				<form:radiobutton path="use_yn" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
			</td>
		</tr>
	</tbody>
</table>
</form:form>