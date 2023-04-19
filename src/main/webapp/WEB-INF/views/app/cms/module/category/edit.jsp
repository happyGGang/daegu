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
	        $('body > div.ui-dialog').remove();
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					var group_idx = $('#categoryForm #group_idx').val();
					if ( doAjaxPost($('#categoryForm')) ) {
						$(this).dialog('destroy');
						$('a.select-btn.group_' + group_idx).click();
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
	
	$("#dialog-2").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 450
	});
	
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="categoryForm" modelAttribute="category" method="post" action="save.do" >
	<form:hidden path="homepage_id"/>
	<form:hidden path="large_category_idx"/>			
	<form:hidden path="group_idx"/>
	<form:hidden path="category_idx"/>			
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>소분류명</th>
	         	<td><form:input path="category_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>노출순서</th>
	         	<td><form:input path="print_seq" class="text" cssStyle="width:30px" maxlength="5"/></td>
	        </tr>
	        <%-- <tr>
	         	<th>소분류사용여부</th>
	         	<td>
	         		<form:radiobutton path="use_yn" class="Y" value="Y"/><label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;&nbsp;
					<form:radiobutton path="use_yn" class="N" value="N"/><label for="use_yn2" style="cursor:pointer;">사용안함</label>
         		</td>
	        </tr> --%>
	        <tr>
	         	<th>신청제한사용여부</th>			
	         	<td>
	         		<form:radiobutton path="req_limit_yn" value="Y" label="사용함"/>&nbsp;&nbsp;
	         		<form:radiobutton path="req_limit_yn" value="N" label="사용안함"/>
	         	</td>
        	</tr>
        	<tr>
	         	<th>신청제한기간</th>			
	         	<td>
	         		<form:select path="req_limit_type" class="selectmenu">
	         			<form:option value="1" label="1년"></form:option>
	         			<form:option value="6" label="6개월"></form:option>
	         			<form:option value="3" label="3개월"></form:option>
	         		</form:select>
	         	</td>
        	</tr>
        	<tr>
	         	<th>신청제한횟수</th>			
	         	<td>
	         		<form:input path="req_limit_count" class="text" style="width:50px"/>
	         		<c:if test="${not empty possibleCount}">
	         		제한 가능 수  : ${possibleCount}
	         		</c:if>
		         	<div class="ui-state-highlight">
						* 신청제한 설정은 해당 소분류 내 모든 강좌에 대하여 1인당 강좌수 제한을 설정합니다.<br/>
						* 상위 중분류에 신청제한이 설정된 경우 중분류의 제한 설정을 우선 적용합니다.<br/>
<!-- 						* 같은 그룹 내 소분류의 신청제한의 합이 상위 그룹의 신청제한 설정보다 높을 수 없습니다.(그룹 수정기능에서 제한설정) <br/> -->
						* 1년(1월~12월), 6개월(1월~6월, 7월~12월)<br/>
						* 3개월(1월~3월, 4월~6월, 7월~9월, 10월~12월)단위로 제한합니다.
					</div>
	         	</td>
        	</tr>
        	<tr>
	         	<th>홈페이지노출여부</th>	
	         	<td>
	         		<form:radiobutton path="homepage_view_yn" value="Y" label="노출함"/>&nbsp;&nbsp;
	         		<form:radiobutton path="homepage_view_yn" value="N" label="노출안함"/>
	         		<div class="ui-state-highlight">
						* 홈페이지노출여부 설정은 홈페이지 강좌,행사 신청 페이지에 소분류 검색조건을 노출하는지에 대한 노출여부입니다.
					</div>
	         	</td>
        	</tr>
		</tbody>
	</table>
</form:form>
