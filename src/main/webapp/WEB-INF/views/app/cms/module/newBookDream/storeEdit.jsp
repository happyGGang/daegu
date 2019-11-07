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
						url : 'saveStore.do',
						type : 'POST',
						data : $('#bookDreamStoreEdit').serialize(),
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
					$('#bookDreamStoreEdit').ajaxSubmit(option);
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
		width: 1200,
		height: 800
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
<form:form modelAttribute="bookDreamStoreEdit" action="saveStore.do" method="post" onsubmit="return false;">
<form:hidden path="editMode" />
<form:hidden path="s_no"/>
	<table class="tstyle lbook" summary="서점명, 대표자, 아이디, 비밀번호, 전화번호를 수정할 수 있는 서점관리 표입니다.">
		<caption class="blind">서점관리 수정</caption>
		<colgroup>
			<col style="width:110px" />
			<col />
			<col style="width:400px" />
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>내용</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>서점명</td>
				<td>
					<form:input path="s_name" cssClass="text" cssStyle="width:30%;"/>
				</td>
			</tr>
			<tr>
				<td>대표자</td>
				<td>
					<form:input path="s_owner" cssClass="text" cssStyle="width:30%;"/>
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<c:if test="${bookDream.editMode eq 'MODIFY'}">
					${bookDreamStoreEdit.s_id}
					</c:if>
					<c:if test="${bookDream.editMode ne 'MODIFY'}">
					<form:input path="s_id" cssClass="text" cssStyle="width:30%;"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<form:password path="s_pw" value="" cssClass="text" cssStyle="width:30%;"/> <c:if test="${bookDream.editMode eq 'MODIFY'}">*입력된 경우에만 변경됩니다.</c:if>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<form:input path="s_tel" cssClass="text" cssStyle="width:30%;"/>
				</td>
			</tr>
		</tbody>
	
	</table>

<!-- 	<div class="btn_menu center"> -->
<!-- 		<button type="submit" class="btn btn1 btn-primary btn-large btnWrite"><span>저장</span></button> -->
<!-- 		<a class="btn btn-large" href="/book/admin/request/list.php">목록</a> -->
<!-- 	</div> -->

</form:form>