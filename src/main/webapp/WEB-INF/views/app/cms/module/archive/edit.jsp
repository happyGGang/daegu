<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
						jQuery.ajaxSettings.traditional = true;

						var archiveFile = $('#archive_file');
						if ( $('#archive_file').val() == '' ) {
							$('#archive_file').remove();
						}

						var imageArchiveFile = $('#image_archive_file');
						if ( $('#image_archive_file').val() == '' ) {
							$('#image_archive_file').remove();
						}

						var option = {
							url : 'save.do',
							type : 'POST',
							data : $('#archiveForm').serialize(),
							success: function(response) {
								if(response.valid) {
									alert(response.message);
									location.reload();
								} else {
									$('td.archiveFile').append(archiveFile);
									$('td.imageArchiveFile').append(imageArchiveFile);
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}
								}
							},
							error: function(jqXHR, textStatus, errorThrown) {
								$('td.archiveFile').append(archiveFile);
								$('td.imageArchiveFile').append(imageArchiveFile);
								alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
							}
						};
						$('#archiveForm').ajaxSubmit(option);
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
			height: 800
		});
		
		$('input#product_date').datepicker({
			
		});

		<%--1차 카테고리 변경--%>
		$('#archiveForm select#large_code').on('change', function() {
			var largeCategoryCode = $(this).val();
			if ( $(this).val() != '--' ) {
				$.get('/cms/module/archive/archiveCategory/getMidCategoryList.do?large_code=' + $(this).val(), function(data) {
					$('#archiveForm select#mid_code option').remove();
					if ( data.length > 0 ) {
						var midCategoryCode = '--';
						$.each(data, function(i, v) {
							if (i == 0) {
								midCategoryCode = v.mid_code;
							}
							$('#archiveForm select#mid_code').append('<option value="' + v.mid_code + '">' + v.code_name + '</option>');
						});
						//2차 타케고리도변경(3차 카테고리 새로가져오기)
						if ( midCategoryCode != '--' ) {
							$.get('/cms/module/archive/archiveCategory/getSmallCategoryList.do?large_code=' + largeCategoryCode + '&mid_code=' + midCategoryCode, function(data) {
								$('#archiveForm select#small_code option').remove();
								if ( data.length > 0 ) {
									$.each(data, function(i, v) {
										$('#archiveForm select#small_code').append('<option value="' + v.small_code + '">' + v.code_name + '</option>');
									});
								}
								else {
									$('#archiveForm select#small_code').append('<option value="--">등록된 3차 카테고리가 없습니다.</option>');
								}
							});
						} else {
							$('#archiveForm select#small_code option').remove();
							$('#archiveForm select#small_code').append('<option value="--">2차 카테고리를 선택해 주세요</option>');
						}
					}
					else {
						$('#archiveForm select#mid_code').append('<option value="--">등록된 2차 카테고리가 없습니다.</option>');
						$('#archiveForm select#small_code option').remove();
						$('#archiveForm select#small_code').append('<option value="--">2차 카테고리를 선택 해주세요</option>');
					}


				});
			}
			else {
				$('#archiveForm select#mid_code option').remove();
				$('#archiveForm select#mid_code').append('<option value="--">1차 카테고리를 선택해 주세요</option>');
			}
		});

		<%--2차 카테고리 변경--%>
		$('#archiveForm select#mid_code').on('change', function() {
			var largeCategoryCode = $('#archiveForm select#large_code').val();
			if ( $(this).val() != '--' ) {
				$.get('/cms/module/archive/archiveCategory/getSmallCategoryList.do?large_code=' + largeCategoryCode + '&mid_code=' + $(this).val(), function(data) {
					$('#archiveForm select#small_code option').remove();
					if ( data.length > 0 ) {
						$.each(data, function(i, v) {
							$('#archiveForm select#small_code').append('<option value="' + v.small_code + '">' + v.code_name + '</option>');
						});
					}
					else {
						$('#archiveForm select#small_code').append('<option value="--">등록된 3차 카테고리가 없습니다.</option>');
					}
				});
			}
			else {
				$('#archiveForm select#small_code option').remove();
				$('#archiveForm select#small_code').append('<option value="--">1차 카테고리를 선택해 주세요</option>');
			}
		});

		//아카이브 파일 삭제
		$('a.delete-file-btn').on('click', function(e) {
			e.preventDefault();
			var action = $('form#deleteFileForm').attr('action');
			$('form#deleteFileForm').attr('action', 'deleteFile.do');
			if ( doAjaxPost($('#deleteFileForm')) ) {
				$('form#deleteFileForm').attr('action', action);
				$('td.archiveFile a').remove();
				$('a.delete-file-btn').remove();
				$('input#file_name').val('');
				$('input#file_path').val('');
			}
		});
		//아카이브 이미지(썸네일) 삭제
		$('a.delete-image-btn').on('click', function(e) {
			e.preventDefault();
			var action = $('form#deleteFileForm').attr('action');
			$('form#deleteFileForm').attr('action', 'deleteImage.do');
			if ( doAjaxPost($('#deleteFileForm')) ) {
				$('form#deleteFileForm').attr('action', action);
				$('td.imageArchiveFile img').remove();
				$('a.delete-image-btn').remove();
				$('input#image_file_name').val('');
				$('input#image_file_path').val('');
			}
		});
	
		$('button#cancelFile').on('click', function(e) {
			e.preventDefault();
			$('input#archive_file').val('');
// 		$(this).hide();
		});

		$('button#cancelImage').on('click', function(e) {
			e.preventDefault();
			$('input#image_archive_file').val('');
// 		$(this).hide();
		});

		$('input#archive_file').on('change', function() {
			if ($(this).val() != '') {
// 			$('button#cancelFile').show();
			}
		});

	});

</script>

<form:form id="deleteFileForm" modelAttribute="archive" action="deleteFile.do">
	<form:hidden path="large_code" value="${archive.large_code}"/>
	<form:hidden path="book_idx"/>
	
</form:form>

<form:form id="archiveForm" modelAttribute="archive" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="original_large_code" value="${archive.large_code}"/>
	<form:hidden path="book_idx"/>
	<form:hidden path="editMode"/>

	<table class="type2">
		<colgroup>
			<col width="160" />
			<col width="*"/>
		</colgroup>
		<tbody>
		<tr>
			<th>1차 카테고리 (<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:select path="large_code">
					<c:choose>
						<c:when test="${fn:length(largeCategoryList) > 0}">
							<form:options itemValue="large_code" itemLabel="code_name" items="${largeCategoryList}"/>
						</c:when>
						<c:otherwise>
							<form:option value="--">등록된 1차 카테고리가 없습니다.</form:option>
						</c:otherwise>
					</c:choose>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>관리번호</th>
			<td>
				<form:input path="manage_num" class="text" cssStyle="70%"/>
			</td>
		</tr>
		<tr>
			<th>관련번호</th>
			<td>
				<form:input path="related_number" class="text" cssStyle="70%"/>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<form:input path="title" class="text" cssStyle="width:70%"/>
			</td>
		</tr>
		<tr>
			<th>생산연도</th>
			<td>
				<form:input path="product_year" class="text" maxlength="4"/>
			</td>
		</tr>
		<tr>
			<th>생산일자</th>
			<td>
				<form:input path="product_date" class="text ui-calendar"/>
			</td>
		</tr>
		<tr>
			<th>생산자명</th>
			<td>
				<form:select path="producer_name" class="selectmenu">
					<form:options items="${producerNameCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>원본소장처</th>
			<td>
				<form:select path="original_owner" class="selectmenu">
					<form:options items="${originalOwnerCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>지역</th>
			<td>
				<form:select path="region" class="selectmenu">
					<form:options items="${regionCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>인물</th>
			<td>
				<form:select path="person" class="selectmenu">
					<form:options items="${personCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>설명</th>
			<td>
				<form:textarea path="description" class="text" cssStyle="width:100%;" rows="5" />
			</td>
		</tr>
		<tr>
			<th>유형</th>
			<td>
				<form:select path="type" class="selectmenu">
					<form:options items="${typeCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>형태</th>
			<td>
				<form:select path="data_type" class="selectmenu">
					<form:options items="${dataTypeCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>제공방법</th>
			<td>
				<form:input path="provide_method" class="text"/>
			</td>
		</tr>
		<tr>
			<th>공개여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:radiobutton path="public_yn" class="Y" value="Y"/> <label for="public_yn1" style="cursor:pointer;">공개</label>&nbsp;
				<form:radiobutton path="public_yn" class="N" value="N"/> <label for="public_yn2" style="cursor:pointer;">비공개</label>
			</td>
		</tr>
		<tr>
			<th>애뜰자료여부 (<span style="color: red; font-weight: bold;">*</span>)</th>
			<td>
				<form:radiobutton path="addle_data_yn" class="Y" value="Y"/> <label for="addle_data_yn1" style="cursor:pointer;">Y</label>&nbsp;
				<form:radiobutton path="addle_data_yn" class="N" value="N"/> <label for="addle_data_yn2" style="cursor:pointer;">N</label>
			</td>
		</tr>
		<tr>
			<th>이미지(썸네일)</th>
			<td class="imageArchiveFile">
				<c:if test="${not empty archive.image_file_name}">
					<img src="/data/archive/img/${archive.image_file_name}" style="max-width: 400px;" alt="아카이브 이미지 입니다.">
					<a class="btn btn1 delete-image-btn">삭제</a>
					<br/>
				</c:if>
				<input type="file" id="image_archive_file" name="image_archive_file" class="text" accept=".gif,.jpeg,.jpg,.png,.bmp"/><button id="cancelImage">등록취소</button>
				<div class="ui-state-highlight">
					<em>* 파일 확장자가  gif, jpeg, jpg, png, bmp 인 경우에만 업로드 가능합니다. <br/> * 기타 파일(pdf, hwp 등)을 등록하실 경우 정상적으로 나타나지 않습니다. </em>
				</div>
				<form:hidden path="image_file_name"/>
				<form:hidden path="image_file_path"/>
			</td>
		</tr>
		<tr>
			<th>자료</th>
			<td class="archiveFile">
				<c:if test="${archive.file_name ne null and archive.file_name ne ''}">
					<a href="/cms/module/archive/download/${archive.large_code}/${archive.mid_code}/${archive.small_code}/${archive.book_idx}.do"><i class="fa fa-floppy-o"></i>${archive.file_name}</a><a class="btn btn1 delete-file-btn">삭제</a>
					<br/>
				</c:if>
				<input type="file" id="archive_file" name="archive_file" class="text"/>
				<form:hidden path="file_name"/>
				<form:hidden path="file_path"/>
				<button id="cancelFile">등록취소</button>
			</td>
		</tr>
		<tr>
			<th>뷰어파일 경로</th>
			<td>
				<form:input path="view_file_path" class="text" cssStyle="width:70%"/>
			</td>
		</tr>
		<tr>
			<th>링크</th>
			<td>
				<form:input path="archive_link" class="text" cssStyle="width:70%"/>
			</td>
		</tr>
		<tr>
			<th>시대</th>
			<td>
				<form:select path="era" class="selectmenu">
					<form:options items="${eraCode}" itemValue="code_id" itemLabel="code_name"/>
				</form:select>
			</td>
		</tr>
		<tr>
			<th>저작권표시</th>
			<td>
				<form:input path="copyright" class="text" cssStyle="width:70%"/>
			</td>
		</tr>
		<tr>
			<th>이용안내멘트</th>
			<td>
				<form:textarea path="information_ment" class="text" cssStyle="width:100%;" rows="5" />
			</td>
		</tr>
		</tbody>
	</table>
</form:form>