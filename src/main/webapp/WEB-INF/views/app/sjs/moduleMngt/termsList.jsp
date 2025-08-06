<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-2.dialog-common').dialog({ //모달창 기본 스크립트 선언
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
				text: "취소",
				"class": 'btn',
				click: function() {
					$(this).dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 600,
		height: 600
	});
	
	$('a.deleteTerm-btn').on('click', function(e) {
		e.preventDefault();
		$('#moduleTermsForm #editMode').val('DELETE');
		$('#moduleTermsForm #terms_idx').val($(this).attr('keyValue1'));
		
		if ( confirm('해당 약관을 제거 하시겠습니까?') ) {
			if ( doAjaxPost($('#moduleTermsForm')) ) {
				$('#dialog-2').load('moduleTerms.do?module_idx=' + $('#moduleTermsForm #module_idx').val());	
			}
		}
			
	});
	
	$('a.addTerm-btn').on('click', function(e) {
		e.preventDefault();
		$('#moduleTermsForm #editMode').val('ADD');
		$('#moduleTermsForm #terms_idx').val($(this).attr('keyValue1'));
		
		if ( doAjaxPost($('#moduleTermsForm')) ) {
			$('#dialog-2').load('moduleTerms.do?module_idx=' + $('#moduleTermsForm #module_idx').val());
		}
	});
	
});

</script>
<form:form id="moduleTermsForm" modelAttribute="moduleMngt" action="saveTerms.do" >
	<form:hidden path="editMode"/>
	<form:hidden path="module_idx"/>			
	<form:hidden path="terms_idx"/>
</form:form>

<code>현재 등록된 약관</code>
<table class="type1 center">
	<colgroup>
		<col width="150" />
		<col width="*" />
		<col width="100" />
		<col width="80" />
	</colgroup>
	<thead>
		<tr>
			<th>약관 분류</th>
			<th>제목</th>
			<th>등록일</th>
			<th>기능</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${inTermsList}" var="i">
			<tr>
				<td>${i.terms_type_name}</td>
				<td class="left">${i.title}</td>
				<td>${i.add_date}</td>
				<td><a class="btn deleteTerm-btn" keyValue1="${i.terms_idx}" >제거</a></td>
			</tr>	
		</c:forEach>
	</tbody>
</table>
<br/>
<code>미등록 약관 리스트</code>
<table class="type1 center">
	<colgroup>
		<col width="150" />
		<col width="*" />
		<col width="100" />
		<col width="80" />
	</colgroup>
	<thead>
		<tr>
			<th>약관 분류</th>
			<th>제목</th>
			<th>등록일</th>
			<th>기능</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${notInTermsList}" var="i">
			<tr>
				<td>${i.terms_type_name}</td>
				<td class="left">${i.title}</td>
				<td>${i.add_date}</td>
				<td><a class="btn addTerm-btn" keyValue1="${i.terms_idx}">추가</a></td>
			</tr>	
		</c:forEach>
	</tbody>
</table>
