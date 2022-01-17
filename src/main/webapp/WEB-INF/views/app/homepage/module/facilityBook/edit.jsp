<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- <script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script> -->
<script type="text/javascript">
$(function() {
	
	$('#save-btn').on('click', function() {
		
		var agreeLength = $('div.agree_codes input[name="agree_codes"]').length;
		for(var i = 1; i <= agreeLength; i++) {
			if(!$('#terms'+i).prop('checked')) {
				alert($('#terms'+i).attr('keyValue') + ' 동의 하지 않았습니다.');
				return false;
			}
		}

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

		doAjaxPost($('#facilityBookForm'));
	});

	$('#cancel-btn').on('click', function() {
		var url = '/${homepage.context_path}/module/facilityBook/index.do';
		var formData = serializeParameter(['menu_idx']);
		doGetLoad(url, formData);
	});

	// 연락처 필드 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});

});

</script>

<c:forEach items="${termsList}" var="terms" varStatus="status">
	<c:if test="${status.first}">
	<div class="join-wrap" style="padding: 0">
	</c:if>
	<h4>${terms.title}</h4>
	<div class="Box" style="max-height:200px" tabindex="0" >
		${terms.contents}
	</div>
	<div class="agree_codes" >
		<div class="checkbox">
			<input id="terms${status.count}" name="agree_codes" type="checkbox" keyValue="${terms.title}" style="opacity: inherit;">
			<label style="position: static !important;" for="terms${status.count}">${terms.title} 동의</label><br>
		</div>
	</div>
	<c:if test="${status.last}">
	<br><br>
	</div>
	</c:if>
</c:forEach>

<form:form id="facilityBookForm" modelAttribute="facilityBook" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	
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
       			<td><form:radiobutton path="facility_book_name" value="1" label="4층 토론실(16석)"/></td>
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
       	</tbody>
	</table>
	<br>
	<div class="center">
		<p>대구광역시립중앙도서관 규정에 의거 상기와 같이 신청합니다.</p>
		<fmt:formatDate value="${facilityBook.add_date}" pattern="yyyy년 MM월 dd일"/>
		<p>신청인 <form:input path="add_id" class="text" cssStyle="width:100px;"/></p>
	</div>
	<br>
	<div class="center">
		<span style="font-weight:bold;">대구광역시립중앙도서관 관장 귀하</span>
	</div>
</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancel-btn" class="btn btn5">취소</button>
</div>
