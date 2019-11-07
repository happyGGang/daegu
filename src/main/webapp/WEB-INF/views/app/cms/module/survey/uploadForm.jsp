<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="/resources/cms/js/load-image.all.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="/resources/cms/js/canvas-to-blob.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-video.js"></script>
<!-- The File Upload validation plugin -->
<script src="/resources/cms/jQuery-File-Upload/js/jquery.fileupload-validate.js"></script>
<!-- <script type="text/javascript" src="/resources/cms/survey/css/container.css"></script> -->
<script>
$(function () {
	
	$('#dialog-upload').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: false,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	        $('#dialog-upload').dialog('destroy');
	    },
		buttons: [
			{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-upload').dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-upload").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700,
		height: 630
	});
	
	$('a#btn-excel-upload').on('click', function(e) {
		e.preventDefault();
		var sendFile = $('#file')[0].files;
		if ( sendFile.length > 0 ) {
			var option = {
				url : 'excelUpload.do',
				type : 'POST',
				data : $('#surveyUpload').serialize(),
				success: function(response) {
					if(response.valid) {
						alert(response.message);
						var idx = $('form#surveyUpload input#survey_idx').val();
						$('a#dialog-view[keyvalue="'+idx+'"].btn').click();
						$('#dialog-upload').dialog('destroy');
					} else {
						if ( response.message != null ) {
							alert(response.message);
						}
					}
		         },
		         error: function(jqXHR, textStatus, errorThrown) {
		        	 $('td.realFile').append(file);
		             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
		         }
			};
			$('#surveyUpload').ajaxSubmit(option);
		} else {
			alert('파일을 선택하세요');
		}
	});
	
	$('#offline-sample').on('click', function(e) {
		e.preventDefault();
		$('#surveyUpload').attr('action','excelSampleDownload.do').submit();
	});
	
});
</script>
<style type="text/css">
	div#menual {height: 380px;overflow: auto;margin-bottom: 20px;}
	div#menual>div>ul {margin: 10px 0px;}
	li.menual-block {margin: 10px 0px;}
	span.menual-tit {font-size: 15px;font-weight: bold;}
	ul.menual-txt {padding-left: 20px;}
	
	div.img-box {padding: 10px;}
	div.img-box img {width: 100%;}
</style>
<form:form modelAttribute="survey" id="surveyUpload" method="POST" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="survey_idx"/>
	<div id="menual">
		<h3>파일 업로드 유의사항</h3>
		<div>
			<ul>
				<li>
					1. 엑셀 양식은 번호, 이름, 문항1, 문항2, 문항3.... 순으로 생성됩니다.
				</li>
				<li>
					2. 단일형
					<ul class="menual-txt">
						<li>- 하나의 값을 입력합니다.</li>
						<li>- 기타의 경우 문자열을 입력합니다.</li>
					</ul>
					<div class="img-box">
						<img src="/resources/cms/survey/img/survey_one.png" alt="단일형 예제 이미지">
					</div>
				</li>
				<li>
					3. 복수형
					<ul class="menual-txt">
						<li>- 여러개의 값을 입력시 구분자 ','(콤마)를 주어 입력합니다.</li>
						<li>- 문자열 입력시 ','(콤마)를 제외하고 입력합니다.</li>
						<li>- 값을 입력시 순서에 맞게 주어야 하고 같은 값이 중복 될 수 없습니다.</li>
					</ul>
					<div class="img-box">
						<img src="/resources/cms/survey/img/survey_multi.png" alt="단일형 예제 이미지">
					</div>
				</li>
				<li>
					4. 메트릭스형
					<ul class="menual-txt">
						<li>- 세부질문 순서에 맞게 값을 주어야 하고 값이 중복될 수 있습니다.</li>
						<li>- 세부질문의 값은 구분자 ','(콤마)를 주어 입력합니다.</li>
						<li>- 세부질문의 개수에 맞게 값을 입력해야 하며 공백을 입력할 수 없습니다.</li>
					</ul>
					<div class="img-box">
						<img src="/resources/cms/survey/img/survey_matrix.png" alt="매트릭스형 예제 이미지">
					</div>
				</li>
				<li>
					5. 서술형
					<ul class="menual-txt">
						<li>- 문자열만 입력 합니다.</li>
						<li>- 필수입력시 반드시 값을 입력합니다.</li>
						<li>- 선택입력시 생략할 수 있습니다.</li>
					</ul>
					<div class="img-box">
						<img src="/resources/cms/survey/img/survey_description.png" alt="서술형 예제 이미지">
					</div>
				</li>
			</ul>
			
			<!-- <div class="img-box">
				<h4>[그림1]</h4>
				<img src="/resources/cms/survey/img/survey_form.JPG" alt="설문양식">
				
				<h4>[그림2]</h4>
				<img src="/resources/cms/survey/img/survey_excel.JPG" alt="엑셀양식">
			</div> -->
			
			<!-- <ul>
				<li>설문조사를 [그림1]과 같이 작성시 엑셀 양식은 [그림2]와 같이 나타납니다.</li>
				<li>설문조사 엑실파일 양식은 반드시 지켜서 입력합니다.</li>
				<li>설문조사 엑셀파일 업로드 하기전에 꼭 파일의 데이터를 확인 하시길 바랍니다.</li>
				<br>
				<li>[그림1]에서 Q1은(는) 단일형의 형식입니다. 보기가 1~4번까지 나타나 있고 자유응답형이 5번으로 나타납니다.</li>
				<li>[그림2]에서 Q1은(는) 단일형의 작성 형식입니다. 자유응답형이 있을경우 텍스트를 입력하고, 아닐 시 숫자를 입력합니다.</li>
				<li>단일형은 하나의 문항에 대해서 하나의 답변만 가능합니다.</li>
				<br>
				<li>[그림1]에서 Q2은(는) 복수형의 형식입니다. 보기가 1~5번까지 나타나 있고 자유응답형은 나타나 있지 않습니다.</li>
				<li>[그림2]에서 Q2은(는) 복수형의 작성 형식입니다. 보기 1번 부터 마지막 보기까지 순차적으로 입력하고 마지막에 D열2행 처럼 자유응답을 입력합니다.</li>
				<li>[그림2]의 D열4행과 같이 같은 값이 중복으로 입력할 경우 경고창이 발생합니다.</li>
				<br>
				<li>[그림1]의 Q3은(는) 매트릭스형의 형식입니다. 3개의 세부질문과 4개의 보기가 나타납니다. 메트릭스형은 자유응답이 없습니다.</li>
				<li>[그림2]의 Q3은(는) 매트릭스형의 작성 형식입니다.</li>
				<li>[그림2]의 E열2행과 같이 세부질문당 보기 하나로 구분을 주어 입력합니다.</li>
				<br>
				<li>[그림1]의 Q3은(는) 서술형형의 형식입니다. 필수와 선택으로 설정할 수 있습니다.</li>
				<li>[그림2]의 Q3은(는) 서술형의 작성 형식입니다. 텍스트만 입력이 가능하며, 숫자를 입력시 문자로 인식하여 저장됩니다.</li>
			</ul> -->
			
			<!-- <h3>&lt;Validation&gt;</h3>
			<ul class="menual-txt">
				<li>- 엑셀 양식이 맞지 않을 때 : 엑셀 양식이 올바르지 않습니다. 다시 확인 해주세요.</li>
			</ul>
			<ul>
				<li class="menual-block">
					<span class="menual-tit">1. 단일형</span>
					<ul class="menual-txt">
						<li>- 해당 문항에 값이 없을시 : n번행 n번 문항에 답하지 않으셨습니다.</li>
						<li>- 해당 답변이 문항 수 보다 크거나 1미만일 때 : n번행 n번 문항에 해당 보기가 없습니다. 현재 값 : n</li>
						<li>- 자유응답형 선택시 길이 초과 : n번행 n번 문항의 입력하신길이가 큽니다. 현재 : n byte, 제한 : n byte</li>
						<li>- 자유응답형이 없을 때 문자 입력시 :  n번행 n번 문항의 값을 확인하세요.</li>
					</ul>
				</li>
				<li class="menual-block">
					<span class="menual-tit">2. 복수형</span>
					<ul class="menual-txt">
						<li>- 해당 문항에 값이 없을시 : n번행 n번 문항에 답하지 않으셨습니다.</li>
						<li>- 해당 답변이 문항 수 보다 크거나 1미만일 때 : n번행 n번 문항에 해당 보기가 없습니다. 현재 값 : n</li>
						<li>- 같은 문항에 같은 값이 있을 경우 : n번행 n번 문항에 중복된 값이 있습니다.</li>
						<li>- 자유응답형 선택시 길이 초과 : n번행 n번 문항의 입력하신길이가 큽니다. 현재 : n byte, 제한 : n byte</li>
						<li>- 보기 입력 순서에 문자 입력시 : n번행 n번 문항의 보기에 문자가 있습니다.</li>
					</ul>
				</li>
				<li class="menual-block">
					<span class="menual-tit">3. 매트릭스형</span>
					<ul class="menual-txt">
						<li>- 세부질문의 수와 답변 수가 다를 시 : n번행 n번 문항의 답변 개수가 다릅니다.</li>
						<li>- 해당 문항의 세부 질문에 값이 없을시 : n번행 n번 문항의 n번 질문에 답하지 않으셨습니다.</li>
						<li>- 해당 답변이 문항 수 보다 크거나 1미만일 때 : n번행 n번 문항의 n번 답변에 해당 보기가 없습니다.</li>
						<li>- 매트릭스에 문자를 입력시 : n번행 n번 문항은 문자를 입력할 수 없습니다.</li>
					</ul>
				</li>
				<li class="menual-block">
					<span class="menual-tit">4. 서술형</span>
					<ul class="menual-txt">
						<li>- 해당 문항에 값이 없을시 : n번행 n번 문항에 답하지 않으셨습니다.</li>
						<li>- 입력한 문자가 길이 초과시 : n번행 n번 문항의 입력하신길이가 큽니다. 현재 : n byte, 제한 : n byte</li>
					</ul>
				</li>
			</ul> -->
		</div>
	</div>
	<div id="fileUpload">
		<table class="type2">
			<colgroup>
				<col width="80">
				<col>
				<col width="220">
			</colgroup>
			<tr>
				<th>양식</th>
				<td colspan="2">
					<a href="#" id="offline-sample" class="btn btn6" >엑셀 양식</a>
				</td>
			</tr>
			<tr>
				<th>파일</th>
				<td>
					<input type="file" id="file" name="file">
				</td>
				<td>
					<a href="#" id="btn-excel-upload" class="btn btn1" >엑셀 업로드</a>
				</td>
			</tr>
			
		</table>
		<div class="ui-state-highlight">
			<em>* 엑셀 업로드는 기등록된 설문결과에 내용이 추가등록 되오니, 중복 등록되지 않도록 주의하시기 바랍니다.</em>
		</div>
	</div>
</form:form>

<div id="dialog-upload" class="dialog-common" title="엑셀 파일 업로드"></div>