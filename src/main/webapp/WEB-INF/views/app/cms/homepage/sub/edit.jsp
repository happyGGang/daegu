<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					if(doAjaxPost($('#homepage'))) {
						$(this).dialog('destroy');
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

	$('input#zipcode').on('click', function(e) {
		e.preventDefault();
		$('a#findPostCode').click();
	});

	$('#homepage a#findPostCode').on('click', function(e){
		e.preventDefault();
		new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
				fullAddr = data.roadAddress;
				if(data.bname !== ''){
				    extraAddr += data.bname;
				}
				if(data.buildingName !== ''){
				    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                $('input#zipcode').val(data.zonecode);//5자리 새우편번호 사용
                $('input#address1').val(fullAddr);
                $('input#eng_address').val(data.roadAddressEnglish);
                $('input#address1').focus();
            }
        }).open();
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 800,
		height: 830
	});

	$('input#print_seq').spinner({
		min: 0,
		max: 2500,
		step: 1,
		start: 1000
	});
});
</script>


<form:form modelAttribute="homepage" id="homepage" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="homepage_id"/>
<form:hidden path="homepage_group"/>
<input type="text" name="domain" value="${homepage.homepage_group}"/>
<input type="text" name="folder" value="${homepage.homepage_group}"/>

<c:if test="${homepage.editMode eq 'ADD'}">
	<form:hidden path="homepage_type" value="0"/>
</c:if>
<c:if test="${homepage.editMode eq 'MODIFY'}">
	<form:hidden path="homepage_type"/>
</c:if>

<table class="type2">
	<colgroup>
		<col width="160"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
		</tr>
		<tr>
			<th>도서관명 <em>*</em></th>
			<td>
				<form:input path="homepage_name" cssStyle="width:178px;" cssClass="text"/>
				<em>예) OOO 도서관</em>
			</td>
		</tr>
		<tr>
			<th>도서관명(영문)</th>
			<td>
				<form:input path="homepage_eng_name" cssStyle="width:80%;" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>도서관 별칭</th>
			<td>
				<form:input path="homepage_alias" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<form:input path="homepage_tell" cssStyle="width:178px;" cssClass="text"/>
				<em>예) 054-123-1234 <strong>","</strong> 구분으로 전화번호 여러개 입력가능</em>
			</td>
		</tr>
		<tr>
			<th>팩스번호</th>
			<td>
				<form:input path="homepage_fax" cssStyle="width:178px;" cssClass="text"/>
				<em>예) 054-123-1234 <strong>","</strong> 구분으로 팩스번호 여러개 입력가능</em>
			</td>
		</tr>
		<tr>
			<th>SMS발신 전화번호</th>
			<td>
				<form:input path="homepage_send_tell" cssStyle="width:178px;" cssClass="text"/>
				<em>* 대표번호 한개만 입력바랍니다. 예) 053-123-1234 </em>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<form:input path="zipcode" class="text" readonly="true" cssStyle="width: 80px;"/> <a href="#" id="findPostCode" class="btn">우편번호 찾기</a>
				<form:input path="address1" class="text" style="width:80%;" />
			</td>
		</tr>
		<tr>
			<th>영문주소</th>
			<td>
				<form:input path="eng_address" class="text" style="width:80%;" />
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:input path="remark" cssStyle="width:178px;" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>관리코드</th>
			<td>
				<form:input path="manage_code" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>도서관 부호</th>
			<td>
				<form:input path="lib_code" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>타입</th>
			<td>
				<form:select path="temp_use_yn">
					<form:option value="Y" label="검색대+홈페이지"></form:option>
					<form:option value="N" label="검색대"></form:option>
				</form:select>
			</td>
		</tr>
		<c:if test="${sessionScope.member.admin}">
		<tr>
			<th>출력순서</th>
			<td>
				<form:input path="print_seq" cssClass="text spinner" style="width:70px;"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>오름차순으로 정렬됩니다.(낮은번호가 상단에 출력.)<br/>순서가 동일할 경우 도서관명 오름차순으로 정렬됩니다.</em>
				</div>
			</td>
		</tr>
		</c:if>
	</tbody>
</table>
</form:form>