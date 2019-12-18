<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					jQuery.ajaxSettings.traditional = true;
					var file = $('#img_file');
					if ( $('#img_file').val() == '' ) {
						$('#img_file').remove();
					}
					var option = {
						url : 'save.do',
						type : 'POST',
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
								location.reload();
							} else {
								$('td.realFile').append(file);
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
				        	 $('td.realFile').append(file);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#mainImgForm').ajaxSubmit(option);
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
		width: 600,
		height: 500
	});
	
	$('.ui-calendar').each(function() {
		$(this).datepicker({
			//기본달력
		});
	});
	
	if ( '${mainImg.use_yn}' != '' ) {
		$('[name="use_yn"].${mainImg.use_yn}').click();	
	}
	
	$('input#img_file').change(function() {

		
		var maxSize = 500 * 1024;
		
		var fileSize = 0;
		
		var version = detectIE();

		
		if (version === false) {
			fileSize = $('input#img_file')[0].files[0].size;
		} else {
			fileSize = document.getElementById('img_file').files[0].size
		}

		if (fileSize > maxSize) {
			alert('메인이미지는 500 KB 이하의 파일만 등록가능합니다.\n\n선택 파일 크기 : ' + parseInt(fileSize/1024) + ' KB');
			$(this).val('');
		}

		// add details to debug result

		/**
		 * detect IE
		 * returns version of IE or false, if browser is not Internet Explorer
		 */
	});
	
	function detectIE() {
		  var ua = window.navigator.userAgent;

		  // Test values; Uncomment to check result …

		  // IE 10
		  // ua = 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)';
		  
		  // IE 11
		  // ua = 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko';
		  
		  // Edge 12 (Spartan)
		  // ua = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0';
		  
		  // Edge 13
		  // ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586';

		  var msie = ua.indexOf('MSIE ');
		  if (msie > 0) {
		    // IE 10 or older => return version number
		    return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
		  }

		  var trident = ua.indexOf('Trident/');
		  if (trident > 0) {
		    // IE 11 => return version number
		    var rv = ua.indexOf('rv:');
		    return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
		  }

		  var edge = ua.indexOf('Edge/');
		  if (edge > 0) {
		    // Edge (IE 12+) => return version number
		    return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
		  }

		  // other browser
		  return false;
	}
});

</script>
<!-- 대구교육 소식지 신청 등록, 수정 form -->
<form:form id="mainImgForm" modelAttribute="mainImg" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="homepage_id"/>
	<form:hidden path="img_idx"/>
	<form:hidden path="editMode"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
	        <tr>
	         	<th>제목(<span style="color: red;font-weight: bold;">*</span>)</th>
	         	<td><form:input path="main_img_name" class="text" cssStyle="width:100%"/></td>
	        </tr>
	        <tr>
	         	<th>이미지<c:if test="${mainImg.editMode eq 'ADD'}">(<span style="color: red;font-weight: bold;">*</span>)</c:if></th>
	         	<td class="realFile">
	         		<input type="file" id="img_file" name="img_file" class="text"/><form:hidden path="org_file_name"/>
	         		<div class="ui-state-highlight">
	         			<em>* 메인이미지는 500 KB 이하의 파일만 등록가능합니다.</em>
					</div>
	         	</td>
	        </tr>
	        <c:if test="${mainImg.editMode eq 'MODIFY'}">
		        <tr>
		         	<th>현재 이미지</th>
		         	<td class="realFile">
		         		<c:choose>
		         			<c:when test="${mainImg.server_file_name ne ''}">
		         				<img style="width: 100%;" src="/data/mainImg/${mainImg.homepage_id}/${mainImg.server_file_name}" alt="${mainImg.server_file_name}"/>	
		         			</c:when>
		         			<c:otherwise>
		         				<img width="135" height="42" src="/resources/cms/img/noimg_135_42.gif" alt="이미지가 없습니다.">	
		         			</c:otherwise>
		         		</c:choose>
	         		</td>
		        </tr>
	        </c:if>
	        <tr>
				<th>출력 순서</th>
				<td>
					<form:input path="print_seq" cssStyle="width:30px;" cssClass="text spinner"/>
				</td>
			</tr>
	        <tr>
     			<th>사용여부</th>
				<td>
					<form:radiobutton path="use_yn" class="Y" value="Y"/> <label for="use_yn1" style="cursor:pointer;">사용함</label>&nbsp;
					<form:radiobutton path="use_yn" class="N" value="N"/> <label for="use_yn2" style="cursor:pointer;">사용안함</label>
				</td>
	        </tr>
		</tbody>
	</table>
</form:form>
