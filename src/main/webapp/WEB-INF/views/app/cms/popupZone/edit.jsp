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
		width: 600,
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
				${homepage.homepage_id }
				<c:choose>
					<c:when test="${popupZone.homepage_id eq 'h1' }"><!-- 통합 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 500 X 세로 148 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h2' }"><!-- 구미 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 328 X 세로 189 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h3' }"><!-- 안동 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 400 X 세로 170 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h4' }"><!-- 용상 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 189 X 세로 320 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h5' }"><!-- 풍산 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 250 X 세로 173 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h6' }"><!-- 상주 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 570 X 세로 158 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h7' }"><!-- 화령 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 250 X 세로 303 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h9' }"><!-- 외동 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 352 X 세로 268 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h10' }"><!-- 영주 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 285 X 세로 230 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h11' }"><!-- 풍기 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 239 X 세로 270 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h12' }"><!-- 영천금호 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 295 X 세로 121 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h13' }"><!-- 점촌 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 300 X 세로 150 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h14' }"><!-- 군위 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 355 X 세로 146 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h15' }"><!-- 의성 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 295 X 세로 121 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h16' }"><!-- 청송 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 360 X 세로 150 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h17' }"><!-- 영양 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 335 X 세로 188 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h18' }"><!-- 영덕 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 325 X 세로 268 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h19' }"><!-- 청도 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 295 X 세로 122 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h20' }"><!-- 고령 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 467 X 세로 178 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h21' }"><!-- 성주 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 444 X 세로 168 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h22' }"><!-- 칠곡 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 295 X 세로 122 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h23' }"><!-- 예천 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 353 X 세로 270 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h25' }"><!-- 울진 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 570 X 세로 210 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h26' }"><!-- 울릉 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 352 X 세로 268 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h27' }"><!-- 센터도서관 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 399 X 세로 200 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h28' }"><!-- 센터 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 712 X 세로 360 입니다(픽셀단위)</em>
					</div>
					</c:when>
					<c:when test="${popupZone.homepage_id eq 'h31' }"><!-- 학생문화회관 -->
					<div class="ui-state-highlight">
						<em>* 팝업존 최적 이미지 사이즈는 가로 559 X 세로 243 입니다(픽셀단위)</em>
					</div>
					</c:when>
				</c:choose>
				
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
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<form:textarea path="content" class="text" cssStyle="width:100%;" rows="2"/>
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