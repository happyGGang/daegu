<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
					if($('#phone1').val() != "") {
						$('#phone').val($('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val());
					}
					if($('#sub_phone1').val() != "") {
						$('#sub_phone').val($('#sub_phone1').val()+'-'+$('#sub_phone2').val()+'-'+$('#sub_phone3').val());
					}
					if($('#man_count').val() == null || $('#man_count').val() == '') {
						$('#man_count').val(0);
					}
					if($('#woman_count').val() == null || $('#woman_count').val() == '') {
						$('#woman_count').val(0);
					}

					if(doAjaxPost($('#facilityBookForm'))) {
						location.reload();
					};
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
		width: 850,
		height: 700
	});
	
	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

});

</script>
<form:form id="facilityBookForm" modelAttribute="facilityBook" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="facility_book_idx"/>
	
	<h3>신청인 기본정보</h3>
	<table class="type1">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
	       <col width="160"/>
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
       			<th>신청인</th>
       			<td colspan="3">
       				<form:input path="apply_name" class="text"/>
       			</td>
       		</tr>
       		<tr>
				<th>휴대폰번호 1<br>(신청자본인)</th>
				<td>
					<form:hidden path="phone"/>
					<form:input path="phone1" class="text" cssStyle="width:40px;" maxlength="3" numberonly="true"/>
				 	- <form:input path="phone2" class="text" cssStyle="width:50px;" maxlength="4" numberonly="true"/>
				 	- <form:input path="phone3" class="text" cssStyle="width:50px;" maxlength="4" numberonly="true"/>
				</td>
				<th>휴대폰번호 2<br>(참여인원 중 한명)</th>
				<td>
					<form:hidden path="sub_phone"/>
					<form:input path="sub_phone1" class="text" cssStyle="width:40px;" maxlength="3" numberonly="true"/>
				 	- <form:input path="sub_phone2" class="text" cssStyle="width:50px;" maxlength="4" numberonly="true"/>
				 	- <form:input path="sub_phone3" class="text" cssStyle="width:50px;" maxlength="4" numberonly="true"/>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<h3>신청사항</h3>
	<table class="type1">
		<colgroup>
	       <col width="160" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
       			<th>사용시설</th>
       			<td>
					4층 토론실(16석)
       				<form:hidden path="facility_book_name"/>
       			</td>
       		</tr>
       		<tr>
	       		<th>이용시간</th>
	       		<td>
	       			신청일:<form:input path="apply_date" class="text" cssStyle="width:100px;" readonly="true"/>일
	       			<c:choose>
	       				<c:when test="${facilityBook.apply_time_code eq '0'}">
	       				09:30~13:30
	       				</c:when>
	       				<c:when test="${facilityBook.apply_time_code eq '1'}">
	       				13:30~17:30
	       				</c:when>
	       			</c:choose>
	       			<form:hidden path="apply_time_code"/>
	       		</td>
       		</tr>
       		<tr>
       			<th>모임명</th>
       			<td><form:input path="curcles_name" class="text" cssStyle="width:100px;"/></td>
       		</tr>
       		<tr>
       			<th>참여인원</th>
       			<td>
       				남:<form:input path="man_count" class="text" cssStyle="width:40px;" numberonly="true"/>명/
       				여:<form:input path="woman_count" class="text" cssStyle="width:40px;" numberonly="true"/>명
       				<span>ex)숫자를 입력해 주세요.</span>
       			</td>
       		</tr>
       		<tr>
				<th>참가자명단</th>
				<td><form:textarea path="attend_list" class="text" cssStyle="width:100%; height:150px;"/></td>
			</tr>
			<tr>
				<th>신청상태</th>
				<td>
					<form:select path="apply_status">
						<form:option value="0">대기</form:option>
						<form:option value="1">승인</form:option>
					</form:select>
				</td>
			</tr>
       	</tbody>
	</table>
</form:form>