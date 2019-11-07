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
					var file = $('#file');
					if ( $('#file').val() == '' ) {
						$('#file').remove();
					}
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#projectManageForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
								location.reload();
							} else {
								$('td.realFile').append(file);
				                for(var i =0 ; i < response.result.length ; i++) {
									alert(response.result[i].code);
									$('#'+response.result[i].field).focus();
									break;
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				        	 $('td.realFile').append(file);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#projectManageForm').ajaxSubmit(option);
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
		height: 500
	});
	
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="projectManageForm" modelAttribute="projectManage" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="req_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
			<tr>
	         	<th>분류</th>			
	         	<td>
	         		<form:select path="type" cssClass="select">
						<form:option value="하드웨어">하드웨어</form:option>
						<form:option value="자료관리시스템">자료관리시스템</form:option>
						<form:option value="홈페이지">홈페이지</form:option>
					</form:select>
				</td>
        	</tr>
	        <tr>
	         	<th>제목</th>
	         	<td><form:input path="title" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>내용</th>
	         	<td><form:textarea path="contents" class="text" cssStyle="width:100%; height:200px;"/></td>
	        </tr>
	        <tr >
	         	<th>첨부파일</th>
	         	<td class="realFile">${projectManage.file_name}<input type="file" id="file" name="file" class="text"/><form:hidden path="file_name"/></td>
	        </tr>
	        <%-- <tr>
	         	<th>상태</th>
	         	<td>
	         		<form:select path="status" cssClass="select">
						<form:option value="신청">신청</form:option>
						<form:option value="검토">검토</form:option>
						<form:option value="진행">진행</form:option>
						<form:option value="보류">보류</form:option>
						<form:option value="완료">완료</form:option>
					</form:select>
	         	</td>
	        </tr> --%>
        	<%-- <tr>
	         	<th>담당자</th>
	         	<td><form:input path="person" class="text"/></td>
	        </tr>
	        <tr>
	         	<th>등록일</th>
	         	<td>${projectManage.add_date}</td>
	        </tr>
	        <tr>
	         	<th>완료일</th>
	         	<td><form:input path="end_date" class="ui-calendar"/></td>
	        </tr> --%>
		</tbody>
	</table>
</form:form>
