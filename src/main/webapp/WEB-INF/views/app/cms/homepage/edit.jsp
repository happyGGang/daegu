<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
		daum.postcode.load(function() {
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
	                $('#zipcode').val(data.zonecode);//5자리 새우편번호 사용
	                $('#address1').val(fullAddr);
	                $('#address1').focus();
	            }
	        }).open();
		});
	});

	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
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
<form:hidden path="tid"/>
<form:hidden path="homepage_group" value="ALL"/>

<c:if test="${homepage.editMode eq 'ADD'}">
	<form:hidden path="homepage_type" value="2"/>
</c:if>
<c:if test="${homepage.editMode eq 'MODIFY'}">
	<form:hidden path="homepage_type"/>
</c:if>

<code>WEB 홈페이지 정보</code>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>홈페이지ID</th>
			<td>
			<c:choose>
			<c:when test="${homepage.editMode eq 'MODIFY'}">${homepage.homepage_id}</c:when>
			<c:otherwise><em>* 자동으로 홈페이지 ID가 등록됩니다.</em></c:otherwise>
			</c:choose>
			</td>
		</tr>
		<%-- <tr>
			<th>분류</th>
			<td>
				<form:select path="homepage_group">
					<form:option value="ALL">ALL</form:option>
				</form:select>
			</td>
		</tr> --%>
		<tr>
			<th>홈페이지명 <em>*</em></th>
			<td>
				<form:input path="homepage_name" cssStyle="width:178px;" cssClass="text"/>
				<em>예) OOO 홈페이지</em>
			</td>
		</tr>
		<tr>
			<th>홈페이지명(영문)</th>
			<td>
				<form:input path="homepage_eng_name" cssStyle="width:80%;" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>홈페이지 별칭</th>
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
				<em>* 대표번호 한개만 입력바랍니다. 예) 054-123-1234 </em>
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
<!-- 		<tr> -->
<!-- 			<th>홈페이지 유형 <em>*</em></th> -->
<!-- 			<td> -->
<!-- 				<div class="form-group">                        -->
<!-- 				    <div class="radio"> -->
<%-- 				    	<form:radiobuttons path="homepage_type" items="${homepageTypeList}" itemLabel="code_name" itemValue="code_id"/>  --%>
<!-- 				    </div> -->
<!-- 				</div> -->
<!-- 			</td> -->
<!-- 		</tr> -->
		<tr>
			<th>폴더명 <em>*</em></th>
			<td>
				<form:input path="folder" cssStyle="width:178px;" cssClass="text"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>해당 홈페이지의 디자인 폴더를 설정합니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>도메인 <em>*</em></th>
			<td>
				<form:input path="domain" cssStyle="width:178px;" cssClass="text"/>
				<em>예) http://domain.com</em>
			</td>
		</tr>
		<tr>
			<th>컨텍스트 경로</th>
			<td>
				<form:input path="context_path" cssStyle="width:178px;" cssClass="text"/>
				<em>예) test</em>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>홈페이지 유형(도메인 + 컨텍스트 패스)일 경우에 입력합니다.</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:input path="remark" cssStyle="width:178px;" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>홈페이지 코드</th>
			<td>
				<form:input path="homepage_code" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>SNS 계정관리</th>
			<td>
				<table>
					<colgroup>
						<col width="130"/>
						<col width="*"/>
					</colgroup>
					<tr align="center">
						<td>구분</td>
						<td>URL</td>
					</tr>
					<tr align="center">
						<td>네이버블로그</td>
						<td><form:input path="blog_url" cssStyle="width:90%;" /></td>
					</tr>
					<tr align="center">
						<td>페이스북</td>
						<td><form:input path="facebook_url" cssStyle="width:90%;"/></td>
					</tr>
					<tr align="center">
						<td>트위터</td>
						<td><form:input path="twitter_url" cssStyle="width:90%;"/></td>
					</tr>
					<tr align="center">
						<td>카카오스토리</td>
						<td><form:input path="kakao_url" cssStyle="width:90%;"/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<th>사용자보관함 제한개수</th>
			<td>
				<form:input path="mystorage_limit_count" cssClass="text" style="width:70px;"/>
			</td>
		</tr>
		<c:if test="${sessionScope.member.admin}">
		<tr>
			<th>출력순서</th>
			<td>
				<form:input path="print_seq" cssClass="text spinner" style="width:70px;"/>
				<div class="ui-state-highlight">
					<i class="fa fa-question-circle"></i><em>오름차순으로 정렬됩니다.(낮은번호가 상단에 출력.)<br/>순서가 동일할 경우 홈페이지명 오름차순으로 정렬됩니다.</em>
				</div>
			</td>
		</tr>
		</c:if>
	</tbody>
</table>
<br/><code>APP 홈페이지 정보</code>
<table class="type2">
	<colgroup>
		<col width="130"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th>홈페이지 명</th>
			<td>
				<form:input path="lib_name" cssClass="text"/>
			</td>
		</tr>
		<tr>
			<th>URL</th>
			<td>
				<form:input path="lib_url" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>대표이미지URL</th>
			<td>
				<form:input path="lib_picture_url" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<form:input path="lib_address" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>위도</th>
			<td>
				<form:input path="lib_latitude" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>경도</th>
			<td>
				<form:input path="lib_longitude" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>대표전화번호</th>
			<td>
				<form:input path="lib_tel" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<form:input path="lib_email" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>휴관일 정보</th>
			<td>
				<form:input path="lib_holiday_info" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>이용시간 정보</th>
			<td>
				<form:input path="lib_use_time" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>사물함 신청여부</th>
			<td>
				<form:select path="lib_cabinet_yn" class="selectmenu">
					<form:option value="Y">Y</form:option>
					<form:option value="N">N</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>사물함 신청 URL</th>
			<td>
				<form:input path="lib_cabinet_url" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>문화강좌 신청여부</th>
			<td>
				<form:select path="lib_reg_cource_yn" class="selectmenu">
					<form:option value="Y">Y</form:option>
					<form:option value="N">N</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>문화강좌 신청 URL</th>
			<td>
				<form:input path="lib_reg_cource_url" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>디지털자료실 좌석예약여부</th>
			<td>
				<form:select path="lib_webbooking_yn" class="selectmenu">
					<form:option value="Y">Y</form:option>
					<form:option value="N">N</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>디지털자료실 좌석예약 URL</th>
			<td>
				<form:input path="lib_webbooking_url" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
		<tr>
			<th>기타시설이용 신청여부</th>
			<td>
				<form:select path="lib_etc_yn" class="selectmenu">
					<form:option value="Y">Y</form:option>
					<form:option value="N">N</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>기타시설 이용신청 URL</th>
			<td>
				<form:input path="lib_etc_url" cssClass="text" cssStyle="width:90%;"/>
			</td>
		</tr>
	</tbody>
</table>
</form:form>