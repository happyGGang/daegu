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
	
	$('a#save_btn').on('click', function(e) {
		e.preventDefault();
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		var option = {
			type : 'POST',
			url : 'save.do',
			success: function(response) {
				if(response.valid) {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					}
					if(response.reload) {
						location.reload();
					}
					if(response.targetOpener) {
						window.open(response.url, '','width=500,height=510');
						return false;
					}
					if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
						doGetLoad(response.url, response.data);
					}
				} else {
					if(response.message != null && response.message.replace(/\s/g,'').length!=0) {
						alert(response.message);
					} else {
						if (response.result != null && response.result.length > 0) {
							for(var i =0 ; i < response.result.length ; i++) {
								alert(response.result[i].code);
								$('#'+response.result[i].field).focus();
								$('#'+response.result[i].field).css('border-color', 'red');
								$('#'+response.result[i].field).on('change', function() {
									$(this).css('border-color', '');
								});
									break;
							}
						}
					}

					if(response.url != null && response.url.replace(/\s/g,'').length!=0) {
						if(ajaxBody != null && ajaxBody.replace(/\s/g,'').length!=0) {
							doAjaxLoad(ajaxBody, response.url, response.data);
						} else {
							doGetLoad(response.url, response.data);
						}
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
			}
		}
		$('#bestPracticesContestEdit').ajaxSubmit(option);
	});
	
	$('a#cancle_btn').on('click', function(e) {
		e.preventDefault();
		location.href = 'index.do?menu_idx=${fn:escapeXml(param.menu_idx)}';
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
	
});
</script>
<style>
	.bbs-edit th, .bbs-edit td{font-size:14px;}
</style>

<form:form id="deleteFileForm" modelAttribute="bestPracticesContest">
	<form:hidden path="homepage_id"/>
	<form:hidden path="best_practices_idx"/>
</form:form>

<form:form modelAttribute="bestPracticesContest" id="bestPracticesContestEdit" action="save.do" enctype="multipart/form-data">
<form:hidden path="menu_idx"/>
<form:hidden path="editMode"/>
<form:hidden path="best_practices_idx"/>

	<div class="wrapper-bbs">
		<p style="margin-bottom:10px;"><b style="color: red;">(*)</b>표시항목은 필수입력항목입니다.</p>
		<table class="bbs-edit" summary="독서릴레이 우수사례공모 신청">
			<caption>독서릴레이 우수사례공모 신청</caption>
			<colgroup>
				<col width="20%">
				<col width="">
			</colgroup>
			<tbody id="board_tbody">
				<tr>
					<th>공모분야<b style="color: red;">(*)</b></th>
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
					<th>작성자<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_name" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>비밀번호<b style="color: red;">(*)</b></th>
					<td>
						<form:password path="password" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>이메일<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_email" cssClass="text" />
					</td>
				</tr>
				<tr>
					<th>연락처<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_phone" cssClass="text" />
						<span>※ 입력예시 : 010-0000-0000</span>
					</td>
				</tr>
				<tr>
					<th>주소<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="user_address" cssClass="text" cssStyle="width: 100%;" />
					</td>
				</tr>
				<tr>
					<th>제목<b style="color: red;">(*)</b></th>
					<td>
						<form:input path="title" cssClass="text" cssStyle="width: 100%;" />
					</td>
				</tr>
				<tr>
					<th>내용<b style="color: red;">(*)</b></th>
					<td>
						<form:textarea path="contents" rows="10" cols="100" cssStyle="width: 100%;" />
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td class="file1">
		         		<input type="file" id="org_file_name_temp" name="org_file_name_temp" class="text" title="파일 첨부" />
	         			<span>※ 사진, 영상 등을 첨부해 주세요.</span>
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
		         		<input type="file" id="org_file_name_temp2" name="org_file_name_temp2" class="text" title="파일 첨부" />
	         			<span>※ 사진, 영상 등을 첨부해 주세요.</span>
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
		         		<input type="file" id="org_file_name_temp3" name="org_file_name_temp3" class="text" title="파일 첨부" />
	         			<span>※ 사진, 영상 등을 첨부해 주세요.</span>
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
		
		<div class="button bbs-btn center">
			<a href="#" id="save_btn" class="btn btn1">신청하기</a>
			<a href="#" id="cancle_btn" class="btn">취소</a>
		</div>
	</div>
</form:form>

