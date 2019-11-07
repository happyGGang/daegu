<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
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
				text: "엑셀저장",
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(applyList)}' > 0) {
						$('#apply_edit2').attr('action', '/cms/module/excursions/apply/excelDownload.do').submit();
						$('#apply_edit2').attr('action', '/cms/module/excursions/apply/save.do');	
					} else {
						alert('해당 내역이 없습니다.');	
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
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 900,
		height: 500
	});
	
	//신청자 수정버튼
	$('a#apply-modify').on('click', function(event) {
		$('#dialog-2').load('/cms/module/excursions/apply/edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&apply_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		event.preventDefault();
	});
	
	//승인처리 버튼
	$('a#state-modify').on('click', function(event) {
		$('#dialog-4').load('/cms/module/excursions/apply/stateEdit.do?editMode=STATEMODIFY&homepage_id=' + $('#homepage_id_1').val() + '&apply_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
		
				
		event.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(event) {
		if(confirm('해당 정보를 삭제 하시겠습니까?')) {
			$('input#editMode').val('DELETE');
			$('input#apply_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#apply_edit2'))) {
				$('#dialog-3').load('/cms/module/excursions/apply/applyEdit.do?editMode=VIEW&homepage_id=' + $('#homepage_id_1').val() + '&excursions_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}
		}
		event.preventDefault();
	});
	
	$('a.add_blackList').on('click', function(e) {		
		$('#dialog-5').load('/cms/module/blackList/edit.do?editMode=ADD&black_type=40&after_click_btn=a.check_apply_${applyList[0].excursions_idx}&homepage_id=' + $(this).attr('homepage_id') + '&member_id=' + $(this).attr('keyValue')+ '&member_key=' + $(this).attr('keyValue1'), function( response, status, xhr ) {
			$('#dialog-5').dialog({
				width: 600,
				height: 300
			});
			$('#dialog-5').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete_blackList').on('click', function(e) {
		e.preventDefault();
		
		if (confirm('해당 수강생을 블랙리스트 목록에서 삭제하시겠습니까?')) {
			var data = {
					editMode : 'BLACKTYPEDELETE',
					homepage_id : $(this).attr('homepage_id'),
					member_key : $(this).attr('keyValue'),
					black_type	: '40'
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
		                 $('#dialog-3').load('/cms/module/excursions/apply/applyEdit.do?editMode=ADD&homepage_id=${apply.homepage_id}&start_date=${apply.plan_date}', function( response, status, xhr ) {
			         	     $('#dialog-3').dialog('open');
			         	 });
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
});
</script>
<form:form modelAttribute="apply" id="apply_edit2" action="/cms/module/excursions/apply/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="apply_idx"/>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<col width="150"/>
			<col width="90"/>
			<col width="120"/>
			<col width="100"/>
			<col width="75"/>
			<col width="75"/>
			<col width=""/>
		</colgroup>
		<thead>
			<tr>
				<th>기관명</th>
				<th>신청자 성명</th>
				<th>신청자 전화번호</th>
				<th>방문일자</th>
				<th>방문인원</th>
				<th>승인여부</th>
				<c:if test="${apply.editMode ne 'VIEW' }">
					<th>신청</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${applyList}">
				<c:if test="${fn:length(applyList) < 1}">
				<tr>
					<td colspan="7">데이터가 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<tr>
					<td>${i.agency_name}</td>
					<td>${i.applicant_name}</td>
					<td>${i.applicant_tel}</td>
					<td>${i.start_date}</td>
					<td>${i.personnel}</td>
					<td>
						<c:set var="apply_state" value="${i.apply_state}" />
						<c:choose>
						    <c:when test="${apply_state eq '3'}">
						        승인
						    </c:when>
						    <c:when test="${apply_state eq '2'}">
						        불가
						    </c:when>
						    <c:otherwise>
						        대기
						    </c:otherwise>
						</c:choose>
					</td>
					<c:if test="${apply.editMode ne 'VIEW' }">
						<td>
							<a href="" class="btn" id="state-modify" keyValue="${i.apply_idx}">승인처리</a>
							<a href="" class="btn" id="apply-modify" keyValue="${i.apply_idx}">수정</a>
							<a href="" class="btn" id="delete-btn" keyValue="${i.apply_idx}">삭제</a>
							<c:if test="${i.isBlackList > 0 }">
							<a href="" class="btn btn4 delete_blackList" homepage_id="${i.homepage_id}" keyValue="${i.member_key}">블랙리스트 삭제</a>
							</c:if>
							<c:if test="${i.isBlackList < 1 }">
							<a href="" class="btn btn1 add_blackList" homepage_id="${i.homepage_id}" keyValue="${i.apply_id}" keyValue1="${i.member_key}">블랙리스트 추가</a>
							</c:if>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
<div id="dialog-4" class="dialog-common" title="신청자 승인 처리"/>
<div id="dialog-5" class="dialog-common" title="블랙리스트"/>