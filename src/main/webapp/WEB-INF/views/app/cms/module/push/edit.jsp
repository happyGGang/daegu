<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-1').dialog({ //모달창 기본 스크립트 선언
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
					
					if ( $('select#push_type').val() == '이미지' ) {
						if ( $('#file').val() == '' ) {
							alert('이미지를 지정해주세요.');
							return false;
						}
					}
					
					var push_date = $('#pushForm #push_date').val();
					var push_hour = $('#pushForm #push_hour').val();
					var push_reserve_date = push_date + push_hour;
					
					if ( push_date == '' ) {
						alert('발송 일자를 지정해주세요.');
						return;
					}
					
					$('#pushForm #push_reserve_date').val(push_reserve_date);
					
					var file = $('#file');
					if ( $('#file').val() == '' ) {
						$('#file').remove();
					}
					
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#pushForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
				    			location.reload();
							} else {
								$('div.fileDiv').append(file);
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
				        	 $('div.fileDiv').append(file);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#pushForm').ajaxSubmit(option);
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
	
	$('input#push_date').datepicker({
		dateFormat: 'yymmdd',
		minDate: new Date(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker("setDate", new Date());;
	
	$('select#push_type').change(function() {
		if ( $(this).val() == '이미지' ) {
			$('tr.noImage').hide();
			$('tr.Image').show();
		}
		else {
			$('tr.noImage').show();
			$('tr.Image').hide();
		}
	}).trigger('change');
	
	$('a.file-delete-btn').on('click', function(e) {
		e.preventDefault();
		$('#pushForm #editMode').val('FILEDELETE');
		
		if ( confirm('해당 파일을 정말 삭제 하시겠습니까?') ) {
			if ( doAjaxPost($('#pushForm')) ) {
				location.reload();
			}	
		}
		
	});
});

</script>
<form:form modelAttribute="push" id="pushForm" method="post" action="save.do">
	<form:hidden path="editMode"/>
	<form:hidden path="tid"/>
	<c:if test="${(push.lib_code ne 'admin') and (push.lib_code ne '00147046')}">
		<form:hidden path="lib_code"/>
	</c:if>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<c:if test="${(push.lib_code eq 'admin') or (push.lib_code eq '00147046')}">
	       		<tr>
		         	<th>도서관</th>			
		         	<td>
		         		<form:select path="lib_code" cssClass="selectmenu">
		         			<form:option value="ALL" label="전체"/>
		         			<c:forEach items="${homepageList}" var="i">
		         				<c:if test="${i.homepage_code != null and i.homepage_code != ''}">
		         					<form:option value="${fn:split(i.homepage_code, ',')[0]}" label="${i.homepage_name}"/>
		         				</c:if>
		         			</c:forEach>
		         		</form:select>
		       		</td>
		       	</tr>
	       	</c:if>
	       	<tr>
				<th>푸쉬 타입</th>
				<td>
					<form:select path="push_type" cssClass="selectmenu">
	         			<form:option value="일반텍스트" label="일반텍스트"/>
	         			<form:option value="긴텍스트" label="긴텍스트"/>
	         			<form:option value="이미지" label="이미지"/>
	         		</form:select>
				</td>
			</tr>
        	<tr>
	         	<th>푸쉬 메시지</th>			
	         	<td>
	         		<form:textarea path="push_msg" class="text" style="width:100%"/>
	         		<div class="ui-state-error">
						<em>* 일반텍스트 : 최대 20자,<br/> 긴텍스트 : 최대 150자 제한됩니다.</em>
					</div>	
         		</td>
        	</tr>
        	<tr>
	         	<th>발송 일자</th>			
	         	<td>
	         		<form:hidden path="push_reserve_date"/>
	         		<form:input path="push_date" class="text ui-calendar"/>
	         		<form:select path="push_hour" cssClass="selectmenu" cssStyle="width:60px">
	         			<form:option value="00" label="00"/>
	         			<form:option value="01" label="01"/>
	         			<form:option value="02" label="02"/>
	         			<form:option value="03" label="03"/>
	         			<form:option value="04" label="04"/>
	         			<form:option value="05" label="05"/>
	         			<form:option value="06" label="06"/>
	         			<form:option value="07" label="07"/>
	         			<form:option value="08" label="08"/>
	         			<form:option value="09" label="09"/>
	         			<form:option value="10" label="10"/>
	         			<form:option value="11" label="11"/>
	         			<form:option value="12" label="12"/>
	         			<form:option value="13" label="13"/>
	         			<form:option value="14" label="14"/>
	         			<form:option value="15" label="15"/>
	         			<form:option value="16" label="16"/>
	         			<form:option value="17" label="17"/>
	         			<form:option value="18" label="18"/>
	         			<form:option value="19" label="19"/>
	         			<form:option value="20" label="20"/>
	         			<form:option value="21" label="21"/>
	         			<form:option value="22" label="22"/>
	         			<form:option value="23" label="23"/>
	         		</form:select>
	         	</td>
        	</tr>
        	<tr class="noImage">
        		<th>접속 URL</th>
        		<td>
        			<form:input path="push_url" class="text"/>
        		</td>
        	</tr>
        	<tr class="Image">
	         	<th>이미지</th>			
	         	<td>
	         		<div class="fileDiv">
	         			<input type="file" id="file" name="file" class="text"/>
	         		</div>
	         		<c:if test="${push.push_type eq '이미지' and push.push_url != null and push.push_url != ''}">
	         			<img alt="push_url" src="${push.push_url}"><a class="btn btn1 file-delete-btn" keyValue="${push.tid}">파일삭제</a>
	         		</c:if>
	         		<div class="ui-state-error">
						<em>PUSH 이미지 최적 사이즈 :  W 892 X H 393 사이즈</em>
					</div>
	         	</td>
        	</tr>
        	<tr>
	         	<th>상태</th>			
	         	<td>
     				<form:select path="push_status" cssClass="selectmenu">
	         			<form:option value="1" label="발송대기"/>
	         			<form:option value="2" label="임시저장"/>
	         		</form:select>
         		</td>
        	</tr>
		</tbody>
	</table>
</form:form>
