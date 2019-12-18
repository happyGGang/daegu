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
					jQuery.ajaxSettings.traditional = true;
					var file = $('#icon_file');
					if ( $('#icon_file').val() == '' ) {
						$('#icon_file').remove();
					}
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#quickMenuForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
								location.reload();
							} else {
								$('td.realFile').append(file);
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
				        	 $('td.realFile').append(file);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#quickMenuForm').ajaxSubmit(option);
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
		width: 500,
		height: 400
	});
	
	if ( '${quickMenu.view_yn}' != '' ) {
		$('[name="view_yn"].${quickMenu.view_yn}').click();	
	}
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="quickMenuForm" modelAttribute="quickMenu" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="quick_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>메뉴명(<span style="color: red;font-weight: bold;">*</span>)</th>
	         	<td><form:input path="menu_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr >
	         	<th>아이콘<c:if test="${quickMenu.editMode eq 'ADD'}">(<span style="color: red;font-weight: bold;">*</span>)</c:if></th>
	         	<td class="realFile">${quickMenu.org_file_name}<input type="file" id="icon_file" name="icon_file" class="text"/><form:hidden path="org_file_name"/></td>
	        </tr>
	        <tr>
	         	<th>링크</th>
	         	<td>
	         		<form:input path="link_url" class="text" cssStyle="width:100%"/>
	         		<div class="ui-state-highlight">
						<em>* 링크 사용 안할 시  # 을 입력하세요. </em>
					</div>	
         		</td>
	        </tr>
	        <tr>
	         	<th>링크대상</th>
	         	<td>
					<form:radiobutton path="link_target" value="CURRENT"/><label for="link_target1" style="cursor:pointer;">현재창</label>&nbsp;
					<form:radiobutton path="link_target" value="BLANK"/><label for="link_target2" style="cursor:pointer;">새창</label>
				</td>
	        </tr>
	        <tr>
     			<th>노출여부</th>
				<td>
					<form:radiobutton path="view_yn" class="Y" value="Y"/> <label for="view_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="view_yn" class="N" value="N"/> <label for="view_yn2" style="cursor:pointer;">사용안함</label>
				</td>
	        </tr>
	        <tr>
				<th>출력 순서</th>
				<td>
					<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
