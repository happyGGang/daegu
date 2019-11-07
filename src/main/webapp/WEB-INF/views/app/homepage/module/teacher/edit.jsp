<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(function () {
	$('#save-btn').on('click', function() {
		if(doAjaxPost($('#teacherForm'))) {
		}
	});
	
	$('#back-btn').on('click', function() {
		history.back();
	});
	
	$('.findPostCode').on('click', function(e){
		e.preventDefault();
		var zipcodeInput 	= $(this).attr('keyValue1');
		var addressInput 	= $(this).attr('keyValue2');
		var focusInput 		= $(this).attr('keyValue2');
		daum.postcode.load(function() {
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	
	                $(zipcodeInput).val(data.zonecode);
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $(addressInput).val(fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
	                $(focusInput).focus();
	            }
	        }).open();
		});
	});
	
});
</script>
<form:form id="teacherForm" modelAttribute="teacher" method="post" action="save.do">
	<form:hidden path="homepage_id"/>
	<form:hidden path="teacher_idx"/>
	<form:hidden path="member_key"/>
	<form:hidden path="editMode"/>									
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>강사ID</th>			
	         	<td>
	         		<c:choose>
	         			<c:when test="${teacher.editMode eq 'ADD' }">
	         				<form:input path="teacher_id" class="text" /> <a class="btn btn1 idCheck">ID 확인</a>	
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_id}
	         			</c:otherwise>
	         		</c:choose>
         		</td>
        	</tr>
			<tr>
	         	<th>강사명</th>			
	         	<td>
	         		<c:choose>
		         		<c:when test="${teacher.editMode eq 'ADD' }">
		         			<form:input path="teacher_name" class="text" readonly="true"/>
	         			</c:when>
	         			<c:otherwise>
	         				${teacher.teacher_name}
	         			</c:otherwise>
         			</c:choose>	
         		</td>
        	</tr>
        	<tr>
	         	<th>과목명</th>			
	         	<td><form:input path="teacher_subject_name" class="text" style="width:100%"/></td>
        	</tr>
        	<tr>
	         	<th>강의실</th>			
	         	<td><form:input path="stage" class="text" style="width:100%"/></td>
        	</tr>
	        <tr>
	         	<th>성별</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${teacher.editMode eq 'ADD' }">
			         		<form:radiobutton path="teacher_sex" value="남"/> <label for="teacher_sex1" style="cursor:pointer;">남</label>&nbsp;
							<form:radiobutton path="teacher_sex" value="여"/> <label for="teacher_sex2" style="cursor:pointer;">여</label>
						</c:when>
						<c:otherwise>
							${teacher.teacher_sex}
						</c:otherwise>
					</c:choose>
				</td>
	        </tr>
			<tr> 
				<th>전화번호</th>
				<td>
					<form:input path="teacher_phone" class="text"/>
					<div class="ui-state-highlight">
						<em>* ex) 053-666-7777</em>
					</div>
				</td>
			</tr>
			<tr> 
				<th>휴대전화번호</th>
				<td>
					<form:input path="teacher_cell_phone" class="text"/>
					<div class="ui-state-highlight">
						<em>* ex) 010-1234-5678</em>
					</div>
				</td>
			</tr>
			<tr>
	         	<th>E-MAIL</th>			
	         	<td>
	         		<form:input path="teacher_email" class="text" style="width:100%"/>
	         	</td>
        	</tr>
			<tr>
	         	<th>국적</th>			
	         	<td>
	         		<form:input path="teacher_nationality" class="text"/>
	         		<div class="ui-state-highlight">
						<em>* ex) 한국, 중국, 일본</em>
					</div>
	         	</td>
        	</tr>
        	<tr>
	         	<th>우편번호</th>			
	         	<td><form:input path="teacher_zipcode" class="text"/> <button class="btn btn2 findPostCode" keyValue1="#teacher_zipcode" keyValue2="#teacher_address">우편번호 찾기</button></td>
        	</tr>
			<tr>
	         	<th>주소</th>			
	         	<td><form:input path="teacher_address" class="text" style="width:100%"/></td>
        	</tr>
        	<tr>
	         	<th>강사이력</th>			
	         	<td><form:textarea path="teacher_history" class="text" style="width:100%;height:80px;"/></td>
        	</tr>
		</tbody>
	</table>
</form:form>
<br/>
<div class="button bbs-btn center">
	<button id="save-btn" class="btn btn5">${teacher.editMode eq 'ADD' ? '신청하기' : '저장하기'}</button>
	<button id="back-btn" class="btn"><i class="fa fa-reorder"></i><span>뒤로가기</span></button>
</div>