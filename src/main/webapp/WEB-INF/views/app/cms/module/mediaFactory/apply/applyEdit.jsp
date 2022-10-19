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
	        location.reload();
	    },
		buttons: [
			{
				text: "엑셀저장",
				"class": 'btn btn2',
				click: function() {		
					if('${fn:length(applyList)}' > 0) {
						$('#apply_edit2').attr('action', '/cms/module/mediaFactory/apply/excelDownload.do').submit();
// 						$('#apply_edit2').attr('action', '/cms/module/mediaFactory/apply/save.do');	
					} else {
						alert('해당 내역이 없습니다.');	
					}
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
					location.reload();
				}
			}
		]
	});
	
	$("#dialog-3").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1200,
		height: 500
	});
	
	//신청자 수정버튼
	$('a#apply-modify').on('click', function(event) {
		$('#dialog-2').load('/cms/module/mediaFactory/apply/edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id_1').val() + '&apply_idx=' + $(this).attr('keyValue') + '&use_time=' + $(this).attr('keyValue2'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		
		event.preventDefault();
	});
	
	//승인처리 버튼
	$('a#state-modify').on('click', function(event) {
		$('#dialog-4').load('/cms/module/mediaFactory/apply/stateEdit.do?editMode=STATEMODIFY&homepage_id=' + $('#homepage_id_1').val() + '&apply_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-4').dialog('open');
		});
		
				
		event.preventDefault();
	});
	
	$('a#delete-btn').on('click', function(event) {
		if(confirm('해당 정보를 삭제 하시겠습니까?')) {
			$('input#editMode').val('DELETE');
			$('input#apply_idx').val($(this).attr('keyValue'));
			if(doAjaxPost($('#apply_edit2'))) {
				$('#dialog-3').load('/cms/module/mediaFactory/apply/applyEdit.do?editMode=VIEW&homepage_id=' + $('#homepage_id').val() + '&mediaFactory_idx=' + $(this).attr('keyValue') + '&start_date=' + $(this).attr('plan_date'), function( response, status, xhr ) {
					$('#dialog-3').dialog('open');
				});
			}
		}
		event.preventDefault();
	});
	
});
</script>
<form:form modelAttribute="mediaFactoryApply" id="apply_edit2" action="/cms/module/mediaFactory/apply/save.do" method="post">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="plan_date"/>
<form:hidden path="apply_idx"/>
<form:hidden path="use_time"/>
<div class="table-wrap">
	<table class="type1 center">
		<colgroup>
			<c:choose>
				<c:when test="${mediaFactoryApply.homepage_id ne 'h50'}">
					<col width="80"/>
					<col width="100"/>
					<col width="90"/>
					<col width="90"/>
					<col width="60"/>
					<col width="60"/>
					<col width="80"/>
					<col width="75"/>
					<col width="100"/>
					<col width="100"/>
				</c:when>
				<c:otherwise>
					<col width="100"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="75"/>
					<col width="75"/>
					<col width=""/>
				</c:otherwise>
			</c:choose>
		</colgroup>
		<thead>
			<tr>
				<th>신청자 성명</th>
				<th>신청자 전화번호</th>
				<th>방문일자</th>
				<th>이용시간</th>
				<th>방문인원</th>
				<th>승인여부</th>
				<c:if test="${mediaFactoryApply.homepage_id ne 'h50'}">
					<th>보호자 성명</th>
					<th>신청인과의 관계</th>
					<th>보호자 전화번호</th>
				</c:if>
				<c:if test="${mediaFactoryApply.editMode ne 'VIEW' }">
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
					<td>${i.applicant_name}</td>
					<td>${i.applicant_tel}</td>
					<td>${i.start_date}</td>
					<td>
						<c:choose>
							<c:when test="${hompage_id ne 'h50' }">
								${i.start_time} ~ ${i.end_time }
							</c:when>
							<c:otherwise>
								${i.use_time }							
							</c:otherwise>
						</c:choose>
					</td>
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
					<c:if test="${mediaFactoryApply.homepage_id ne 'h50'}">
						<td>${i.protector_name}</td>
						<td>
							<c:choose>
								<c:when test="${i.protector_relation eq '1'}">
									부모
								</c:when>
								<c:otherwise>
									교사
								</c:otherwise>
							</c:choose>
						</td>
						<td>${i.protector_tel}</td>
					</c:if>
					<c:if test="${mediaFactoryApply.editMode ne 'VIEW' }">
						<td>
							<a href="" class="btn" id="state-modify" keyValue="${i.apply_idx}">승인처리</a>
							<a href="" class="btn" id="apply-modify" keyValue="${i.apply_idx}" keyValue2="${i.use_time}">수정</a>
							<a href="" class="btn" id="delete-btn" keyValue="${i.apply_idx}" plan_date="${i.start_date}">삭제</a>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</form:form>
<div id="dialog-4" class="dialog-common" title="신청자 승인 처리"/>