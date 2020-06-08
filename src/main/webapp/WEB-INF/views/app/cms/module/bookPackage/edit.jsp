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
// 					if(doAjaxPost($('#bookPackageEdit'))) {
// 						location.reload();
// 					}

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
					$('#bookPackageEdit').ajaxSubmit(option);
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
	
	$('#thumbnail').hide();

});

function getNaverData(arg) {
	arg = arg.split('//');
	
	<%-- ${i.title}//${i.author}//${i.publisher}//${fn:substring(i.pubdate,0,4)}//${i.isbn13}//${i.price}//${i.description}//${i.link}//${i.image} --%>
	$('input#book_package_subject').val(arg[0].replace(/(<([^>]+)>)/ig,""));
	$('input#author').val(arg[1]);
	$('input#publisher').val(arg[2]);
	$('input#publish_year').val(arg[3]);
	$('input#isbn').val(arg[4]);
	$('input#book_price').val(arg[5]);
// 	$('textarea#content').val(arg[6]);
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
<form:form id="bookPackageEdit" modelAttribute="bookPackage" action="save.do" method="POST">
	<form:hidden path="editMode" id="editMode_u"/>
	<form:hidden path="book_package_idx" id="book_package_idx_u"/>
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
		        	<form:input path="book_package_name" cssClass="text" cssStyle="width:100px;" value="${member.member_name}"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>책꾸러미명(<span style="color: red;font-weight: bold;">*</span>)</th>
	        	<td>
	        		<form:input path="book_package_subject" cssClass="text" cssStyle="width:200px;"/>
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
	        	<th>가격</th>
	        	<td>
	        		<form:input path="book_price" cssClass="text" cssStyle="width:100px;"/>원
	        	</td>
	        </tr>
	        <tr>
	        	<th>쪽수</th>
	        	<td>
	        		<form:input path="book_pages" cssClass="text" cssStyle="width:100px;"/>쪽
	        	</td>
	        </tr>
	        <tr>
	        	<th>대상</th>
	        	<td>
	        		<form:input path="purpose" cssClass="text" cssStyle="width:100px;"/>
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
	        	<th>소장권수</th>
	        	<td>
	        		<form:select path="quantity">
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
	        			<form:option value="3">초등</form:option>
	        			<form:option value="4">중등</form:option>
	        			<form:option value="5">고등</form:option>
	        		</form:select>
	        	</td>
	        </tr>
	        <tr>
	        	<th>주류별</th>
	        	<td>
	        		<form:checkbox path="category" id="cate1" value="000" label="총류" checked="${fn:contains(bookPackage.category, '000') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate2" value="100" label="철학" checked="${fn:contains(bookPackage.category, '100') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate3" value="200" label="종교" checked="${fn:contains(bookPackage.category, '200') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate4" value="300" label="사회과학" checked="${fn:contains(bookPackage.category, '300') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate5" value="400" label="자연과학" checked="${fn:contains(bookPackage.category, '400') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate6" value="500" label="기술과학" checked="${fn:contains(bookPackage.category, '500') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate7" value="600" label="예술" checked="${fn:contains(bookPackage.category, '600') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate8" value="700" label="언어" checked="${fn:contains(bookPackage.category, '700') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate9" value="800" label="문학" checked="${fn:contains(bookPackage.category, '800') ? 'checked' : ''}"/>
	        		<form:checkbox path="category" id="cate10" value="900" label="역사" checked="${fn:contains(bookPackage.category, '900') ? 'checked' : ''}"/>
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
	        <tr id="thumbnail">
	        	<th>썸네일 이미지</th>
	        	<td></td>
	        </tr>
	        <tr>
	        	<td colspan="2">
	        		<form:textarea path="content" rows="10" cols="100" cssStyle="width:95%;"/>
	        	</td>
	        </tr>
	        <tr>
	        	<th>도서이미지</th>
	        	<td class="fileTd">
        			<input type="file" id="mfile" name="mfile" class="text" title="파일선택" />
        		</td>
	        </tr>
	        <tr>
	        	<th>문서파일</th>
	        	<td class="fileTd" id="doc_file_td">
	        		<input type="file" id="doc_file" name="doc_file" class="text" title="파일선택">
	        	</td>
	        </tr>
		</tbody>
	</table>
</form:form>
