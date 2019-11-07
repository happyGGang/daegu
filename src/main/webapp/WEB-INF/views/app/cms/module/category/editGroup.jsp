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
					if ( doAjaxPost($('#categoryGroupForm')) ) {
						location.reload();
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
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 450
	});
	
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="categoryGroupForm" modelAttribute="categoryGroup" method="post" action="saveGroup.do" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="large_category_idx"/>
	<form:hidden path="group_idx"/>
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>중분류명</th>
	         	<td><form:input path="group_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr style="display: none;">
	         	<th>사용여부</th>
	         	<td>
	         		<form:hidden path="use_yn" value="Y" />
         		</td>
	        </tr>
	        <%-- <tr>
	         	<th>노출순서</th>
	         	<td><form:input path="print_seq" class="text"/></td>
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
						* 신청제한 설정은 해당 중분류 내 모든 강좌에 대하여 1인당 강좌수 제한을 설정합니다.<br/>
						* 중분류 내 소분류의 신청제한 설정보다 우선 적용됩니다.<br/>
<!-- 						* 전체 중분류의 신청제한의 합이 도서관의 신청제한 설정보다 높을 수 없습니다.(독서/문화강좌 관리 메뉴에서 설정) <br/> -->
						* 1년(1월~12월), 6개월(1월~6월, 7월~12월)<br/>
						* 3개월(1월~3월, 4월~6월, 7월~9월, 10월~12월)단위로 제한합니다.
					</div>
	         	</td>
        	</tr>
		</tbody>
	</table>
</form:form>
