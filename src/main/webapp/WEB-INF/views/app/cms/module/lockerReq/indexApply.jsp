<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('#dialog-2').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $(this).dialog('destroy');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});

	$('#apply a#dialog-add').on('click', function(e) {
		if($('#homepage_id').val() == null || $('#homepage_id').val() == "") {
			alert("홈페이지를 선택 해 주세요.");
			return false;
		}
		
		$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val() + '&locker_pre_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('#apply a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&locker_pre_idx=' + $('#locker_pre_idx').val() + '&req_idx=' + $(this).attr('keyValue') + '&apply_id=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(e) {
		if ( confirm('해당 사물함을 삭제 하시겠습니까?') ) {
			$('#apply #req_idx').val($(this).attr('keyValue'));
			$('#apply #apply_id').val($(this).attr('keyValue2'));			
			$('#apply #editMode').val("DELETE");
			$('#apply').attr("action", "save.do");
			
			if(doAjaxPost($('#apply'))) {
				location.reload();
			}
		}
		e.preventDefault();
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 750,
		height: 600
	});
	
	$('a#assignment').on('click', function(e) {
		
		if('${lockerReqApplyCount}' > 0) {
			var type = $(this).attr("type");
			
			$('#apply').attr("action", "assignment.do");
			
			if(type == "req") {
				if ( confirm('사물함 배정[순차부여] 하시겠습니까?') ) {						
					$('#apply #editMode').val("SEQUENCE");
					
					doAjaxPost($('#apply'));
				}
			} else if (type == "random") {
				if ( confirm('사물함 배정[랜덤부여] 하시겠습니까?') ) {						
					$('#apply #editMode').val("RANDOM");
					
					doAjaxPost($('#apply'));
				}
			} else if (type == "ref") {
				if ( confirm('사물함 배정[추첨부여] 하시겠습니까?') ) {						
					$('#apply #editMode').val("RAFFLE");
					
					doAjaxPost($('#apply'));
				}
			}
			
			location.reload();	
		} else {
			alert('신청자가 없습니다.');	
		}
		
		e.preventDefault();
	});
	
	$('select#locker_status_1').on('change', function(e) {
		$('#apply').attr('action','indexApply.do');
		$('#dialog-2').load('indexApply.do?homepage_id=' + $('#homepage_id').val() + '&locker_pre_idx=' + $('#locker_pre_idx').val() + '&locker_status=' + $('#locker_status_1').val(), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		if('${lockerReqApplyCount}' > 0) {
			$('#apply').attr('action', 'excelDownload.do').submit();
			$('#apply').attr('action', 'assignment.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${lockerReqApplyCount}' > 0) {
			$('#apply').attr('action', 'csvDownload.do').submit();
			$('#apply').attr('action', 'assignment.do');	
		} else {
			alert('해당 내역이 없습니다.');	
		}
		
		e.preventDefault();
	});
	
	$('a.add_blackList').on('click', function(e) {		
		$('#dialog-4').load('/cms/module/blackList/edit.do?editMode=ADD&black_type=20&after_click_btn=a.dialog-list&homepage_id=' + $(this).attr('homepage_id') + '&member_id=' + $(this).attr('keyValue')+ '&member_key=' + $(this).attr('keyValue1'), function( response, status, xhr ) {
			$('#dialog-4').dialog({
				width: 600,
				height: 300
			});
			$('#dialog-4').dialog('open');
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
					black_type	: '20'
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
		                 $('#dialog-2').load('indexApply.do?homepage_id=${lockerReqApply.homepage_id}&locker_pre_idx=${lockerReqApply.locker_pre_idx}', function( response, status, xhr ) {
		         			 $('#dialog-2').dialog('open');
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
<form:form modelAttribute="lockerReqApply" id="apply" action="assignment.do">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="req_idx"/>
<form:hidden path="apply_id"/>
<form:hidden path="locker_pre_idx"/>
<form:hidden path="locker_status"/>

<div class="table-wrap">
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>							
				<form:select class="selectmenu-search" style="width:100px" path="locker_status" id="locker_status_1">							
					<option value="">전체</option>			
					<option value="assing" <c:if test="${'assing' eq lockerReqApply.locker_status }">selected="selected"</c:if>>배정</option>
					<option value="unassing" <c:if test="${'unassing' eq lockerReqApply.locker_status }">selected="selected"</c:if>>대기자</option>
				</form:select>
		</fieldset>
	</div>
	<div class="infodesk">
		검색 결과 : 총 ${lockerReqApplyCount}건
		<div class="button">
			<c:if test="${member.auth_id <= 200 or member.auth_id eq 7000}">
				<c:if test="${lockerPre.locker_pre_type eq 'FIFO'}">
					<a href="" class="btn btn1 left" id="assignment" type="req"><i class="fa fa-plus"></i><span>순차배정</span></a>
				</c:if>				
				<c:if test="${lockerPre.locker_pre_type eq 'RANDOM'}">
					<a href="" class="btn btn2 left" id="assignment" type="random"><i class="fa fa-plus"></i><span>랜덤배정</span></a>
				</c:if>
				<c:if test="${lockerPre.locker_pre_type eq 'LOTTERY'}">
					<a href="" class="btn btn3 left" id="assignment" type="ref"><i class="fa fa-plus"></i><span>추첨배정</span></a>
				</c:if>			
				<a href="" class="btn btn5 left" id="dialog-add" keyValue="${lockerReqApply.locker_pre_idx}"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</div>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="100"/>
			<col width="90"/>
			<col width="160"/>
			<col width="120"/>					
			<col width="120"/>
			<col width=""/>
		</colgroup>
		<thead>
			<tr>
				<th>사물함</th>
				<th>신청자명</th>
				<th>신청자ID</th>
				<th>전화번호</th>
				<th>휴대전화번호</th>				
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${lockerReqApplyList}">
				<c:if test="${fn:length(lockerReqApplyList) < 1}">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
				</c:if>
				<tr>
					<td>
						<c:if test="${i.locker_idx eq 0 }">
							대기자
						</c:if>
						<c:if test="${i.locker_idx ne 0 }">
							${i.locker_idx }
						</c:if>
					</td>
					<td>${i.req_name }</td>
					<td>${i.apply_id }</td>
					<td>${i.phone }</td>
					<td>${i.cell_phone }</td>
					<td>
						<a href="" class="btn" id="dialog-modify" keyValue="${i.req_idx}" keyValue2="${i.apply_id }">수정</a>
						<a href="" class="btn" id="delete-btn" keyValue="${i.req_idx}" keyValue2="${i.apply_id }">삭제</a>
						<c:if test="${i.isBlackList > 0 }">
						<a href="" class="btn btn4 delete_blackList" homepage_id="${i.homepage_id}" keyValue="${i.member_key}">블랙리스트 삭제</a>
						</c:if>
						<c:if test="${i.isBlackList < 1 }">
						<a href="" class="btn btn1 add_blackList" homepage_id="${i.homepage_id}" keyValue="${i.apply_id}" keyValue1="${i.member_key}">블랙리스트 추가</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="사물함 신청 관리"></div>