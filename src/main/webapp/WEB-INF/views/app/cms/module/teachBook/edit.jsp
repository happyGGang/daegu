<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('div#teachBookEditArea').dialog({ //모달창 기본 스크립트 선언
		width: 700,
		height: 700,
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					var count = 0;
					$('select.attend_sel').each(function() {
						var status = $(this).val().split("//")[1];
						if (status == '0') {
							alert("출석상태를 선택해주세요.");
							$(this).focus();
							count ++;
							return false;
						}
					});
					
					if (count > 0) {
						return false;
					}
					
					jQuery.ajaxSettings.traditional = true;
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#teachBookEditForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('div#teachBookEditArea').dialog('destroy');
							} else {
				                for(var i =0 ; i < response.result.length ; i++) {
									alert(response.result[i].code);
									$('#'+response.result[i].field).focus();
									break;
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#teachBookEditForm').ajaxSubmit(option);
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
	
	$('.ui-calendar').each(function() {
		$(this).datepicker({
			//기본달력
		});
	});
	
	$('a#all_attend').on('click', function(e) {
		e.preventDefault();
		
		$('select.attend_sel > option').each(function() {
			if ($(this).attr('status') == '1') {
				$(this).attr('selected', 'selected');
			}
		});
	});
});

</script>
<div class="button" style="float: right; margin: 10px 0">
	<a href="" id="all_attend" class="btn btn5 right"><span>전체 출석설정</span></a>
</div>
<form:form id="teachBookEditForm" modelAttribute="teachBook" method="post" action="save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>
	<form:hidden path="teach_idx"/>
	<form:hidden path="teach_book_time_idx"/>
	<table class="type1 center" >
		<colgroup>
	       <col width="15%" />
	       <col />
	       <col width="20%"/>
	       <col width="5%"/>
	       <col width="5%"/>
	       <col width="5%"/>
       	</colgroup>
       	<thead>
       		<tr>
       			<th>순번</th>
				<th>수강생명</th>
				<th>출석상태</th>
				<th>수강료</th>
				<th>교재비</th>
				<th>재료비</th>       		
       		</tr>
       	</thead>
       	<tbody>
       		<c:if test="${fn:length(teachBookList) < 1 }">
       		<tr>
       			<td colspan="6">등록된 수강생이 없습니다.</td>
       		</tr>
       		</c:if>
       		<c:forEach var="i" varStatus="status" items="${teachBookList}">
       		<tr>
	         	<td class="num first">${status.count}</td>			
	         	<td>${i.student_name}</td>
	         	<td class="last">
	         		<select class="attend_sel selectmenu" name="studentList" >
	         			<option value="${i.student_idx}//0">==선택==</option>
	         			<c:forEach var="j" varStatus="status_j" items="${codeList}">
	         				<option value="${i.student_idx}//${j.code_id}" status="${j.code_id}" ${i.status eq j.code_id? 'selected' : ''}>${j.code_name }</option>
	         			</c:forEach>
	         		</select>
	         	</td>
	         	<td class="last">
	         		<select class="attend_sel selectmenu" name="pay1List">
	         			<option value="">선택</option>
	         			<option value="Y" <c:if test="${i.pay1 eq 'Y'}">selected="selected"</c:if>>완납</option>
	         			<option value="N" <c:if test="${i.pay1 eq 'N'}">selected="selected"</c:if>>미납</option>
	         		</select>
	         	</td>
	         	<td class="last">
	         		<select class="attend_sel selectmenu" name="pay2List">
	         			<option value="">선택</option>
	         			<option value="Y" <c:if test="${i.pay2 eq 'Y'}">selected="selected"</c:if>>완납</option>
	         			<option value="N" <c:if test="${i.pay2 eq 'N'}">selected="selected"</c:if>>미납</option>
	         		</select>
	         	</td>
	         	<td class="last">
	         		<select class="attend_sel selectmenu" name="pay3List">
	         			<option value="">선택</option>
	         			<option value="Y" <c:if test="${i.pay3 eq 'Y'}">selected="selected"</c:if>>완납</option>
	         			<option value="N" <c:if test="${i.pay3 eq 'N'}">selected="selected"</c:if>>미납</option>
	         		</select>
	         	</td>
        	</tr>
        	</c:forEach>
		</tbody>
	</table>
</form:form>
