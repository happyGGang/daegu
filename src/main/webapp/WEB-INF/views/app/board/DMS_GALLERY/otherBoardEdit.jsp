<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/edit/script.jsp" flush="false" />
<script>
$(document).ready(function() {
	
	$('a#imgDown').on('click', function(e) {
		e.preventDefault();
		if ($('input[name=selectDesign]:checked').is(':checked')) {
			
		} else {
			alert('선택된 이미지가 없습니다.');
			return false;
		}
		var downUrl = $('input[name=selectDesign]:checked').attr('downUrl');
		location.href = downUrl;
	});
});
</script>
<form:form modelAttribute="board" action="save.do" method="post" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="group_idx"/>
<form:hidden path="parent_idx"/>
<form:hidden path="category1"/>
<form:hidden path="category2" value="${asideHomepageId}"/>
<form:hidden path="category3"/>
								<div class="doc-title">
									<c:if test="${board.category2_name ne null}">
									<h3>${board.category1_name} - ${board.category2_name}</h3>
									</c:if>
									<p style="float: left;">※ 사이즈별 디자인 스타일을 선택해주세요.</p>
									<p style="float: right;"><a class="btn btn1" id="imgDown"><span>선택 파일 다운로드</span></a></p>
								</div>
								<ul class="list col4" style="clear: both;">
									<c:forEach var="i" varStatus="status" items="${boardList}">
									<li class="thumb">
										<label for="lia${status.index+1}">
										<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
											<a href="#" keyValue="${i.board_idx}">
												<img src="${i.preview_img}" style="width:121px;height:171px" alt="${i.title}"/>
											</a>
												</c:when>
												<c:otherwise>
											<%-- <a href="#" keyValue="${i.board_idx}"> --%>
												<img style="width:121px;height:171px" src="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}" alt="${i.title}"/>
											<%-- </a> --%>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<a href="#" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" style="width:121px;height:171px" alt="${i.title}"></a>
										</c:otherwise>
										</c:choose>
										</label>
										<p class="admin"><input name="selectDesign" id="lia${status.index+1}" type="radio" downUrl="/board/boardFile/download/${i.manage_idx}/${i.board_idx}/${i.boardFile[0].file_idx}.do" value="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}"/></p>
									</li>
									</c:forEach>
								</ul>
								<table class="bbs-edit">
									<tbody>
										<form:hidden path="title"/>
										<c:if test="${boardManage.file_use_yn eq 'Y'}">
										<tr>
											<td colspan="4" class="file_attach mmm1">
												<div class="doc-title">
													<h3>파일업로드</h3>
													<p>※ 작업에 필요한 파일을 업로드하여 주시기 바랍니다.</p>
												</div>
												<script src="${getContexPath}/resources/common/jqueryFileUpload/js/vendor/jquery.ui.widget.js"></script>
												<script src="${getContexPath}/resources/common/jqueryFileUpload/js/jquery.iframe-transport.js"></script>
												<script src="${getContexPath}/resources/common/jqueryFileUpload/js/jquery.fileupload.js"></script>
												<script src="${getContexPath}/resources/common/jqueryFileUpload/js/handlers.js"></script>
												<style>
												.fileinput-button {position: relative; overflow: hidden;}
												.fileinput-button input {position: absolute; top: 0; right: 0; margin: 0; opacity: 0; -ms-filter: 'alpha(opacity=0)'; font-size: 200px; direction: ltr; cursor: pointer;}
												
												/* Fixes for IE < 8 */
												@media screen\9 {
												  .fileinput-button input {filter: alpha(opacity=0); font-size: 100%; height: 100%;}
												}
												</style>
												<script>
													var uploading = false;
													var file_ban_ext = '${otherBoardManage.file_ban_ext}';
													var uploadResult = false;
													$(document).ready(function() {
														$('#fileupload').fileupload({
													        dataType: 'json',
													        url : '/board/boardFile/upload.do',
													        limitMultiFileUploadSize : 10*1024*1024, // 10Mb
													        add : function(e, data) {
													        	$('select#boardFileArray').addClass('on');
													        	var file_count = $('#boardFileArray > option').length;
													        	data.formData = { "mode" : "ADD" , "board_idx" : "${board.board_idx}", "manage_idx" : "${otherBoardManage.manage_idx}", "file_count" : file_count};
													        	data.process().done(function () {
													        		for ( var i in data.files) {
													        			var ext = data.files[i].name.substring(data.files[i].name.lastIndexOf(".")+1);
													        			if (file_ban_ext.indexOf(ext) > -1) {
													        				alert('업로드 불가능한 파일 확장자 입니다.' + ext);
														        			return false;	
													        			}
																	}
													                data.submit();
													            });
													        },
													        submit : function(e, data) {
													        	uploading = true;
													        	$.each(data.files, function(index, file) {
													        		uploadStart(file);
													        	});
													        },
													        done : function(e, data) {
													        	uploading = false;
													        	$.each(data.files, function(index, file) {
													        		uploadSuccess(file, data.result);
													        	});
													        	previewUpload();
													        },
													        progressall: function (e, data) {
													            var progress = parseInt(data.loaded / data.total * 100, 10);
													            $('.progress_bar #progressBarStatus').css(
													                'width',
													                progress + '%'
													            );
													            $('#progressStatus').text(progress+"%");
													        },
													 
													        dropZone: $('#attach_area')
													    });
														
														fileListAreaID = $('#boardFileArray')[0];		//select 박스 id
													    previewAreaID = $('#previewFile')[0];			//미리보기 ID
													    fileSizeViewID = $('#fileSizeView')[0];			//파일사이즈 ID
													    defaultPath = "${board.editMode eq 'MODIFY'?boardStoragePath:'/data/boardTemp/'}";	// 파일 미리보기 폴더
													    //defaultPath = "/data/board/";
													    /* totalFileSize = '10';  	// 파일 총용량 사이즈(MB)
													    singleFileSize = '5';		// 파일당 사이즈(MB)
													    fileCount = '10';		// 허용 파일 갯수 */
													    
													    
													    $('#delete_btn').on('click', function(e) {
													    	e.preventDefault();
													    	
													    	deleteFiles($('input#manage_idx').val(), $('input#board_idx').val(), $('input#editMode').val());	
													    	
													    });
													    
													    $('#boardFileArray').on('change', function(e) {
													    	e.preventDefault();
													    	preview();
													    });
													    
													    $('#inEditorButton').on('click', function(e) {
													    	e.preventDefault();
													    	pasteHTML('content');
													    });
													    
													    showFileList();
													});
												</script>
												
												<input type="hidden" id="preview_img" />
												<form:hidden path="deleteBoardFileArray" />
												<div id="attach_area">
													<!-- <h4>파일첨부</h4> -->
													<div class="fileUploader">
														<div class="file_attach_info">
															<p><strong>파일 용량 :</strong> <span id="fileSizeView">0Byte</span> / 최대 ${otherBoardManage.file_size_total}MB</p>
															<p><strong>파일 갯수 :</strong> 최대${otherBoardManage.file_count} 개</p>
														</div>
														<div class="preview">
															<span id="previewFile">미리보기</span>
														</div>
														<div class="fileBox">
															<div class="fileListArea">
																<form:select path="boardFileArray" multiple="multiple" size="6" />
																<div id="fsUploadProgress" class="fileResult">
																	<div class="rate" id="progressText">업로드 진행률</div>
																	<div class="loading">
																		<div class="progress_bar">
																			<span id="progressBarStatus" style="width:0%;"></span>
																		</div>
																	</div>
																	<div class="dsc_loading_no">
																		<span id="progressStatus" class="progress">0%</span>
																	</div>
																</div>
															</div>
															<div class="file_info">
																<div class="fileUploadControl">
																<span class="fileinput-button">
																	<a class="btn btn1"><i class="fa fa-plus-circle"></i><span>파일추가</span></a>
																	<input id="fileupload" type="file" name="multiFile" multiple>
																</span>
																	<a class="btn btn1" id="delete_btn"><i class="fa fa-minus-circle"></i><span>선택삭제</span></a>
																<c:if test="${boardManage.editor_use_yn eq 'Y'}">
																	<a class="btn btn1" id="inEditorButton"><i class="fa fa-arrow-circle-up"></i><span>에디터에 넣기</span></a>
																</c:if>
																</div>
															</div>
														</div>
													</div>
												</div>
												<br/>
											</td>
										</tr>
										</c:if>
										<tr>
											<td colspan="4" class="editor">
												<div class="doc-title">
													<h3>관련내용</h3>
													<p>※ 작업에 참고할 사항을 입력하여 주시기 바랍니다.</p>
													<p style="color: red;">※ 팝업창 요청시 [게시기간, 게시위치, 링크URL, 링크 새창여부를 입력해주시기 바랍니다.]</p>
													<p style="color: red;">※ 팝업존 요청시 [게시기간, 링크URL, 링크 새창여부를 입력해주시기 바랍니다.]</p>
												</div>
												<div class="bbs-textarea">
													<form:textarea path="content" rows="10" cols="20" cssStyle="width:95%;${boardManage.editor_use_yn eq 'Y'?' display:none':''}"/>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="button bbs-btn center">
									<a href="" class="btn btn1" id="board_save_btn"><i class="fa fa-pencil"></i><span>확인</span></a>
								</div>
								<!-- <div class="doc-title">
									<h3>파일업로드</h3>
									<p>※ 작업에 필요한 파일을 업로드하여 주시기 바랍니다.</p>
								</div>
								<div class="file_upload">
									<div class="file_list">
										<div class="box">
											<p class="hwp"><a href="">가을학기 홍보문.hwp</a></p>
											<p class="jpg"><a href="">img.jpg</a></p>
											<p class="gif"><a href="">img.gif</a></p>
											<p class="png"><a href="">img.png</a></p>
											<p class="exe"><a href="">so2006.exe</a></p>
											<p class="doc"><a href="">프로그램이 설치가 되지 않을 때.doc</a></p>
											<p class="pdf"><a href="">책책책.pdf</a></p>
											<p class="media"><a href="">영어듣기.wav</a></p>
											<p class="fla"><a href="">국어듣기.swf</a></p>
											<p class="zip"><a href="">desktop.zip</a></p>
											<p class="mp3"><a href="">멜로디.mp3</a></p>
										</div>
									</div>
									<div class="file_control">
										<a href="" class="btn btn6"><strong>파일삭제</strong></a>
										<p>
											<strong>0</strong>KB
										</p>
									</div>
								</div>
								<br/>
								<hr class="line"/>
								<div class="doc-title">
									<h3>관련내용</h3>
									<p>※ 작업에 참고할 사항을 입력하여 주시기 바랍니다.</p>
								</div>
								<div class="work_memo">
									<div class="box"><textarea></textarea></div>
								</div>
								<p class="txt-right">
									<a href="" class="btn btn1">
										<i class="fa fa-check"></i>
										<span>확인</span>
									</a>
								</p> -->
</form:form>								