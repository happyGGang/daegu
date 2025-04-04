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
			fOnBeforeUnload : function(){
			}
		}, //boolean
		fCreator: "createSEditor2"
	});
	
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
					oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

					if($('#doc_file').val() == '') {
						$('#doc_file').remove();
					}

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
									location.reload();
				                 }
							} else {
				                for(var i =0 ; i < response.result.length ; i++) {
									alert(response.result[i].code);
									$('#'+response.result[i].field).focus();
									break;
								}
								$('td#doc_file_td').html('<input type="file" id="doc_file" name="doc_file" class="text" title="파일선택">');
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#thinkPocketPackageEdit').ajaxSubmit(option);
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
		width: 800,
		height: 700
	});

	$('a#naver-search').on('click', function(e) {
		e.preventDefault();
		var lasList = window.open('search.do', 'searchBook', 'width=1000 height=600,scrollbars=yes');
	});

	$('#mfile').on('change', function () {
		var file = this.files[0];
		if (!file) {
			return;
		}

		if (!file.type.match('image.*')) {
			alert('이미지 파일만 선택해주세요.');
			$(this).val('');
			return;
		}

		var reader = new FileReader();
		reader.onload = function (e) {
			var imageData = e.target.result;
			$('#thumbnail td').empty();
			$('#thumbnail').show();
			$('#thumbnail td').html('<img src="' + imageData + '" alt="도서 이미지 미리보기" style="max-width:200px;">');
		};
		reader.readAsDataURL(file);
	});
});

function getNaverData(arg) {
	arg = arg.split('//');
	
	$('input#think_pocket_package_subject').val(arg[0].replace(/(<([^>]+)>)/ig,""));
	$('input#author').val(arg[1]);
	$('input#publisher').val(arg[2]);
	$('input#publish_year').val(arg[3]);
	$('input#isbn').val(arg[4]);
	$('input#book_price').val(arg[5]);
	oEditors.getById["content"].exec("SET_IR", [arg[6]]);
	$('input#desc_link').val(arg[7] + '//' + arg[8]);
	if(arg[9] != null && arg[9] != '') {
		$('#thumbnail').show();
		$('#thumbnail td').html('<img src="'+(arg[9] + '//' + arg[10]) +'" alt="'+arg[0].replace(/(<([^>]+)>)/ig,"")+'">');
		$('input#image_link').val(arg[9] + '//' + arg[10]);
	}
	
	return false;
}

</script>
<form:form id="thinkPocketPackageEdit" modelAttribute="thinkPocketPackage" action="save.do" method="POST">
	<form:hidden path="editMode" id="editMode_u"/>
	<form:hidden path="think_pocket_package_idx" id="think_pocket_package_idx_u"/>
	<form:hidden path="image_link"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
				<th>도서검색</th>
				<td>
					<a href="#" class="btn btn2" id="naver-search"><i class="fa fa-plus"></i><span>도서검색</span></a>&nbsp;&nbsp;<span id="img_file"></span>
				</td>
	        </tr>
	        <tr>
	        	<th>이름(<span style="color: red;font-weight: bold;">*</span>)</th>
	        	<td>
		        	<form:input path="think_pocket_package_name" cssClass="text" cssStyle="width:100px;" value="${member.member_name}"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>생각 주머니명(<span style="color: red;font-weight: bold;">*</span>)</th>
	        	<td>
	        		<form:input path="think_pocket_package_subject" cssClass="text" cssStyle="width:200px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>작가</th>
	        	<td>
	        		<form:input path="author" cssClass="text" cssStyle="width:100px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>출판사</th>
	        	<td>
	        		<form:input path="publisher" cssClass="text" cssStyle="width:100px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>출판년도</th>
	        	<td>
	        		<form:input path="publish_year" cssClass="text" cssStyle="width:100px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>ISBN</th>
	        	<td>
	        		<form:input path="isbn" cssClass="text" cssStyle="width:120px;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>대출가능권수</th>
	        	<td>
	        		<form:select path="loan_count" cssClass="seletmenu">
	        			<form:option value="">권수</form:option>
		        		<c:forEach var="i" begin="1" end="50" >
		        		<form:option value="${i}">${i} 권</form:option>
		        		</c:forEach>
	        		</form:select>
	        	</td>
	        </tr>
	        <tr>
	        	<th>수준별</th>
	        	<td>
	        		<form:select path="grade">
	        			<form:option value="">수준별보기</form:option>
	        			<form:option value="1">유아</form:option>
	        			<form:option value="2">초등</form:option>
	        		</form:select>
	        	</td>
	        </tr>
			<c:if test="${not empty categoryList and thinkPocketPackage.homepage_id eq 'h10' }">
				<tr>
					<th>주제별</th>
					<td>
				<%--		국채보상운동 도서관만 활성화 --%>

						<form:select path="category">
							<form:options items="${categoryList}" itemLabel="code_name" itemValue="code_id"/>
						</form:select>
					</td>
				</tr>
			</c:if>



			<tr>
				<th>출력순서</th>
				<td>
					<form:input path="output_order" type="number" cssClass="number"/>
				</td>
			</tr>
	        <tr>
	        	<th>키워드</th>
	        	<td>
	        		<form:input path="keyword" cssClass="text" cssStyle="width:300px;"/> * 쉼표(,)로 구분지어 주세요.
	        	</td>
	        </tr>
	        <tr>
	        	<th>도서 설명 페이지 링크 주소</th>
	        	<td>
	        		<form:input path="desc_link" cssClass="text" cssStyle="width:300px;"/> * http://부터 입력해주세요.
	        	</td>
	        </tr>
			<tr>
				<th>도서이미지</th>
				<td class="fileTd">
					<input type="file" id="mfile" name="mfile" class="text" title="파일선택" />
				</td>
			</tr>
	        <tr id="thumbnail">
	        	<th>썸네일 이미지</th>
	        	<td></td>
	        </tr>
	        <tr>
	        	<td colspan="2">
	        		<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;"/>
	        	</td>
	        </tr>
		</tbody>
	</table>
</form:form>
