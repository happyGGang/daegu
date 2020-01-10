<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${getContextPath}/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
$(function() {
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "/resources/common/smart_editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
// 		fOnAppLoad : function() {
			
// 		},
		fCreator: "createSEditor2"
	});
	
	$('#save-btn').on('click', function(e) {
		e.preventDefault();
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		var file = $('#mfile');
		if ( $('#mfile').val() == '' ) {
			$('#mfile').remove();
		}

		jQuery.ajaxSettings.traditional = true;
		var option = {
			url : 'save.do',
			type : "POST",
			success: function(response) {
				if(response.valid) {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
						doGetLoad(response.url, response.data);
					}
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
		$('#libraryCheckEdit').ajaxSubmit(option);
	});
	
	$('#cancle-btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('index.do', $('#libraryCheckEdit').serialize());
	});

});
</script>
<form:form id="libraryCheckEdit" modelAttribute="libraryCheck" action="save.do" method="POST">
	<form:hidden path="menu_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="viewPage"/>
	<form:hidden path="library_check_idx"/>
	<table class="type2">
		<colgroup>
	       <col width="150"/>
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	        	<th>이름(<span style="color: red;font-weight: bold;">*</span>)</th>
	        	<td>
        			${sessionScope.supportMember.school_name}
        			<form:hidden path="library_check_name" value="${sessionScope.supportMember.school_name}"/>
		        	<div class="ui-state-error">
						<i class="fa fa-warning"></i><em>한글만 사용하실 수 있습니다.</em>
					</div>
	        	</td>
	        </tr>
	        <tr>
				<th>장서점검기(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="library_check_number" cssClass="selectmenu">
					<c:forEach begin="1" end="20" var="i">
						<form:option value="${i}">장서점검기 ${i}</form:option>
					</c:forEach>
					</form:select>
				</td>
	        </tr>
	        <tr>
	        	<td colspan="2">
	        		<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>장서점검기 이미지</th>
	        	<td class="fileTd">
        			<input type="file" id="mfile" name="mfile" class="text" title="파일선택" />
        		</td>
	        </tr>
		</tbody>
	</table>
</form:form>
<br/>
<div class="txt-right">
	<button id="save-btn" class="btn btn2">신청하기</button>
	<button id="cancle-btn" class="btn btn5">취소</button>
</div>