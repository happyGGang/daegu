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

	/* nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "html",
		sSkinURI: "${getContextPath}/resources/cms/smart_editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function() {
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	}); */
	
	<%-- 이미지 미리보기 --%>
	$('input#org_file_name_temp').change(function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$('img#newBannerImg').attr('src', e.target.result);
			};
			reader.readAsDataURL(this.files[0]);
		} else {
			$('img#newBannerImg').attr('src', '/resources/img/wsm/noimg_135_42.gif');
		}
	});
	
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
						data : $('#banner').serialize(),
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
					$('#banner').ajaxSubmit(option);
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
		height: 420
	});
	
	//달력
	$('.ui-calendar').each(function() {
		$(this).datepicker({
			//기본달력
		});
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
<form:form modelAttribute="banner" action="save.do" method="POST" onsubmit="return false;" enctype="multipart/form-data">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="banner_idx"/>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>타이틀(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="banner_name" cssStyle="width:200px;" cssClass="text" maxlength="20"/>
			</td>
		</tr>
		<tr> 
			<th>배너링크URL(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<form:input path="banner_link" cssClass="text" cssStyle="width:300px;" maxlength="100"/>
				<div class="ui-state-highlight">
					<em>
						*배너 클릭시 이동 할 URL 입니다.<br>
						* http:// 부터 전체 URL을 입력하세요
					</em>
				</div>	
			</td>
		</tr>
		<tr>
			<th>이미지(<span style="color: red;font-weight: bold;">*</span>)</th>
			<td>
				<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="이미지 파일 첨부" accept=".gif,.jpeg,.jpg,.png"/>
			</td>
		</tr>
		
		<c:if test="${banner.editMode eq 'MODIFY'}">
			<tr>
				<th scope="row">이미지</th>
				<td colspan="3">
					<div class="item">
						<a href="${banner.banner_link}" target="_blank"><img width="135" height="42" src="${getContextPath}/data/banner/${banner.homepage_id}/${banner.server_file_name}" alt="${banner.banner_name}"></a>	${banner.org_file_name}							 
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">현재 이미지</th>
				<td colspan="3">
					<div class="item">
						<img id="newBannerImg" name="newBannerImg" width="135" height="42" src="/resources/cms/img/noimg_135_42.gif" alt="noImage">							 
					</div>
				</td>
			</tr>
			</c:if>
			<c:if test="${banner.editMode eq 'ADD'}">
			<tr>
				<th scope="row">등록될 이미지</th>
				<td colspan="3">
					<div class="item">
						<img id="newBannerImg" name="newBannerImg" width="135" height="42" src="/resources/cms/img/noimg_135_42.gif" alt="noImage">
					</div>
				</td>
			</tr>
		</c:if>
		<%-- <tr>
			<th>게시일</th>
			<td>
				<form:input path="start_date" cssClass="text ui-calendar"/> ~ <form:input path="end_date" cssClass="text ui-calendar"/>
			</td>
		</tr> --%>
		<%-- <tr>
			<th>팝업종류</th>
			<td>
				<form:radiobutton path="popup_type" value="LAYER"/> <label for="popup_type1" style="cursor:pointer;">레이어</label>&nbsp;
				<form:radiobutton path="popup_type" value="WINDOW"/> <label for="popup_type2" style="cursor:pointer;">윈도우</label>
			</td>
		</tr> --%>
		<%-- <tr>
			<th>창크기</th>
			<td>
				가로 <form:input path="width" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				세로 <form:input path="height" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>px 단위로 설정합니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>창위치</th>
			<td>
				상단 <form:input path="x_position" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				왼쪽 <form:input path="y_position" cssClass="text" cssStyle="width:50px;" maxlength="4"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>px 단위로 설정합니다.</em>
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
			<th>상세내용</th>
			<td> 
				<form:textarea path="html" cssStyle="width:100%;height:60px;"/>
			</td>
		</tr> --%>
		<tr>
			<th>출력 순서</th>
			<td>
				<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
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