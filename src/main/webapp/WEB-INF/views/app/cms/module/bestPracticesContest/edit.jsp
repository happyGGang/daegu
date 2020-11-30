<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript" src="/resources/common/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
var oEditors = [];
$(function() {
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "contents",
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
		fOnAppLoad : function() {

		},
		fCreator: "createSEditor2"
	});
	
	$('a#modify_btn').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('MODIFY');
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
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
		$('#bestPracticesContestEdit').ajaxSubmit(option);
	});

	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('view.do', $('form#bestPracticesContestEdit').serialize());
	});
	
	$('a#list_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do';
	});
	
	//첨부파일 삭제
	$('a.delete-file-btn').on('click', function(e) {
		e.preventDefault();
		var action = $('form#deleteFileForm').attr('action');
		$('form#deleteFileForm').attr('action', 'deleteFile.do');
		if ( doAjaxPost($('#deleteFileForm')) ) {
			$('form#deleteFileForm').attr('action', action);
			$('td.file1 a').remove();
			$('a.delete-file-btn').remove();
		}
	});
	
	$('a.delete-file-btn2').on('click', function(e) {
		e.preventDefault();
		var action = $('form#deleteFileForm').attr('action');
		$('form#deleteFileForm').attr('action', 'deleteFile2.do');
		if ( doAjaxPost($('#deleteFileForm')) ) {
			$('form#deleteFileForm').attr('action', action);
			$('td.file2 a').remove();
			$('a.delete-file-btn2').remove();
		}
	});
	
	$('a.delete-file-btn3').on('click', function(e) {
		e.preventDefault();
		var action = $('form#deleteFileForm').attr('action');
		$('form#deleteFileForm').attr('action', 'deleteFile3.do');
		if ( doAjaxPost($('#deleteFileForm')) ) {
			$('form#deleteFileForm').attr('action', action);
			$('td.file3 a').remove();
			$('a.delete-file-btn3').remove();
		}
	});
	
	if($('input#editMode').val() == 'ADD'){
		$('div#btn_div').hide();
	} else {
		$('div#btn_div').show();
	}
	
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
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
					jQuery.ajaxSettings.traditional = true;
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#bestPracticesContestEdit').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
				    			location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#bestPracticesContestEdit').ajaxSubmit(option);
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

	$('#dialog-1').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1000
	});
	
	// 숫자만 입력 가능
	$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
	
});
</script>
<form:form id="deleteFileForm" modelAttribute="bestPracticesContest">
	<form:hidden path="homepage_id"/>
	<form:hidden path="best_practices_idx"/>
</form:form>

<form:form modelAttribute="bestPracticesContest" id="bestPracticesContestEdit" action="save.do" enctype="multipart/form-data">
<form:hidden path="homepage_id"/>
<form:hidden path="best_practices_idx"/>
<form:hidden path="editMode"/>
	
	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="20%">
			<col width="">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>공모분야(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<span>개인 &#124;</span>
					<form:radiobutton path="contest_field" value="1" label="소년부(초등~중등)" />
					<form:radiobutton path="contest_field" value="2" label="장년부(고등~일반)" /><br/>
					<span>단체 &#124;</span>
					<form:radiobutton path="contest_field" value="3" label="소년부(초등~중등)" />
					<form:radiobutton path="contest_field" value="4" label="장년부(고등~일반)" />
				</td>
			</tr>
			<tr>
				<th>작성자(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="user_name" cssClass="text" />
				</td>
			</tr>
			<tr>
				<th>비밀번호(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:password path="password" cssClass="text" />
				</td>
			</tr>
			<tr>
				<th>이메일(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="user_email" cssClass="text" />
				</td>
			</tr>
			<tr>
				<th>연락처(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="user_phone" cssClass="text" />
					<span>※ 입력 예)010-0000-0000</span>
				</td>
			</tr>
			<tr>
				<th>주소(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="user_address" cssClass="text" cssStyle="width: 95%;" />
				</td>
			</tr>
			<tr>
				<th>제목(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="title" cssClass="text" cssStyle="width: 95%;" />
				</td>
			</tr>
			<tr>
				<th>내용(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:textarea path="contents" rows="10" cols="100" cssStyle="width: 100%;" />
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td class="file1">
	         		<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="파일 첨부" /><form:hidden path="org_file_name"/>
         			<span>※ 사진, 영상 등 첨부해 주세요.</span>
	         		<c:if test="${bestPracticesContest.editMode eq 'MODIFY'}">
						<c:if test="${bestPracticesContest.server_file_name ne NULL}">
							<div class="item">
								<a href="/cms/module/bestPracticesContest/download/${bestPracticesContest.homepage_id}/${bestPracticesContest.best_practices_idx}.do"><i class="fa fa-floppy-o"></i>${bestPracticesContest.org_file_name}.${bestPracticesContest.file_extension}</a><a class="btn btn1 delete-file-btn">삭제</a>
							</div>
						</c:if>
					</c:if>
         		</td>
			</tr>
			<tr>
				<th>첨부파일2</th>
				<td class="file2">
	         		<input type="file" id="org_file_name_temp2" name="org_file_name_temp2" class="text" title="파일 첨부" /><form:hidden path="org_file_name2"/>
	         		<span>※ 사진, 영상 등 첨부해 주세요.</span>
	         		<c:if test="${bestPracticesContest.editMode eq 'MODIFY'}">
						<c:if test="${bestPracticesContest.server_file_name2 ne NULL}">
							<div class="item">
								<a href="/cms/module/bestPracticesContest/download/${bestPracticesContest.homepage_id}/${bestPracticesContest.best_practices_idx}2.do"><i class="fa fa-floppy-o"></i>${bestPracticesContest.org_file_name2}.${bestPracticesContest.file_extension2}</a><a class="btn btn1 delete-file-btn2">삭제</a>
							</div>
						</c:if>
					</c:if>
         		</td>
			</tr>
			<tr>
				<th>첨부파일3</th>
				<td class="file3">
	         		<input type="file" id="org_file_name_temp3" name="org_file_name_temp3" class="text" title="파일 첨부" /><form:hidden path="org_file_name3"/>
	         		<span>※ 사진, 영상 등 첨부해 주세요.</span>
	         		<c:if test="${bestPracticesContest.editMode eq 'MODIFY'}">
						<c:if test="${bestPracticesContest.server_file_name3 ne NULL}">
							<div class="item">
								<a href="/cms/module/bestPracticesContest/download/${bestPracticesContest.homepage_id}/${bestPracticesContest.best_practices_idx}3.do"><i class="fa fa-floppy-o"></i>${bestPracticesContest.org_file_name3}.${bestPracticesContest.file_extension3}</a><a class="btn btn1 delete-file-btn3">삭제</a>
							</div>
						</c:if>
					</c:if>
         		</td>
			</tr>
		</tbody>
	</table>
	
	<div id="btn_div" class="button bbs-btn" style="margin-top: 10px; text-align: right;">
		<a href="#" id="modify_btn" class="btn btn1">저장</a>
		<a href="#" id="cancle_btn" class="btn btn5">취소</a>
		<a href="#" id="list_btn" class="btn btn2">목록으로</a>
	</div>
</form:form>

