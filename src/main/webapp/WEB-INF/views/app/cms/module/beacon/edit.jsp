<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#dialog-1').dialog({ //모달창 기본 스크립트 선언
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

					var file = $('#file');
					if ( $('#file').val() == '' ) {
						$('#file').remove();
					}

					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#beaconForm').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
				    			location.reload();
							} else {
								$('div.fileDiv').append(file);
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
				        	 $('div.fileDiv').append(file);
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#beaconForm').ajaxSubmit(option);
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
		height: 650
	});

	$('select#type').change(function() {
		if ( $(this).val() == '공지' ) {
			$('tr.noImage').hide();
			$('tr.Image').show();
		}
		else {
			$('tr.noImage').show();
			$('tr.Image').hide();
		}
	}).trigger('change');

	$('a.file-delete-btn').on('click', function(e) {
		e.preventDefault();
		$('#beaconForm #editMode').val('FILEDELETE');

		if ( confirm('해당 파일을 정말 삭제 하시겠습니까?') ) {
			if ( doAjaxPost($('#beaconForm')) ) {
				location.reload();
			}
		}

	});

});

</script>
<form:form modelAttribute="beacon" id="beaconForm" method="post" action="save.do" enctype="multipart/form-data">
	<form:hidden path="editMode"/>
	<form:hidden path="tid"/>
	<table class="type2">
		<colgroup>
	       <col width="130" />
	       <col width="*"/>
       	</colgroup>
       	<tbody>
       		<tr>
	         	<th>도서관</th>
	         	<td>
	         		<form:select path="lib_code" cssClass="selectmenu">
	         			<c:forEach items="${homepageList}" var="i">
	         				<c:if test="${i.homepage_code != null and i.homepage_code != ''}">
	         				<c:if test="${i.homepage_id ne 'c1' and i.homepage_id ne 'c0' and i.homepage_id ne 'h27'}">
	         					<form:option value="${fn:split(i.homepage_code, ',')[0]}" label="${i.homepage_name}"/>
	         				</c:if>
	         				</c:if>
	         			</c:forEach>
	         		</form:select>
	       		</td>
	       	</tr>
	       	<tr>
	         	<th>비콘의 실별</th>
	         	<td>
        			<form:input path="place_info" class="text" style="width:100%"/>
         		</td>
        	</tr>
	       	<tr>
				<th>비콘 타입</th>
				<td>
					<form:select path="type" cssClass="selectmenu">
	         			<form:option value="텍스트" label="텍스트"/>
	         			<form:option value="공지" label="공지"/>
	         			<form:option value="바로가기" label="바로가기"/>
	         		</form:select>
				</td>
			</tr>
        	<tr>
	         	<th>내용</th>
	         	<td>
	         		<form:textarea path="content" class="text" style="width:100%" rows="10"/>
	         		<div class="ui-state-highlight">
						<em>* 2000 byte 까지 입력가능합니다.</em>
					</div>
         		</td>
        	</tr>
        	<tr>
	         	<th>MAJOR</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${beacon.editMode eq 'ADD' }">
							<form:input path="major" class="text"/>
	         			</c:when>
	         			<c:otherwise>
	         				${beacon.major}
	         			</c:otherwise>
	         		</c:choose>
	         		<div class="ui-state-error">
						<em>* 수정 불가능 합니다.</em>
					</div>
         		</td>
        	</tr>
        	<tr>
	         	<th>MINOR</th>
	         	<td>
	         		<form:input path="minor" class="text"/>
	         		<div class="ui-state-error">
						<em>* 중복이 있으면 안됩니다.</em>
					</div>
         		</td>
        	</tr>
        	<tr>
	         	<th>DISTANCE</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${beacon.editMode eq 'ADD' }">
	         				<form:input path="distance" class="text"/>
         				</c:when>
	         			<c:otherwise>
	         				${beacon.distance}
	         			</c:otherwise>
	         		</c:choose>
	         		<div class="ui-state-error">
						<em>* 수정 불가능 합니다.</em>
					</div>
         		</td>
        	</tr>
        	<tr class="noImage">
        		<th>URL</th>
        		<td>
        			<form:input path="url" class="text"/>
        		</td>
        	</tr>
        	<tr class="Image">
	         	<th>이미지</th>
	         	<td>
	         		<div class="fileDiv">
	         			<input type="file" id="file" name="file" class="text"/>
	         		</div>
	         		<c:if test="${beacon.url != null and beacon.url != ''}">
	         			<img style="width:100%;" alt="url" src="${beacon.url}"><a class="btn btn1 file-delete-btn" keyValue="${beacon.tid}">파일삭제</a>
	         		</c:if>
	         		<div class="ui-state-error">
						<em>BEACON 이미지 최적 사이즈 :  W 540 X H 540 사이즈</em>
					</div>
	         	</td>
        	</tr>
        	<tr>
	         	<th>UUID</th>
	         	<td>
	         		<c:choose>
	         			<c:when test="${beacon.editMode eq 'ADD' }">
	         				<form:input path="uuid" class="text" style="width:100%"/>
         				</c:when>
	         			<c:otherwise>
	         				${beacon.uuid}
	         			</c:otherwise>
	         		</c:choose>
	         		<div class="ui-state-error">
						<em>* 수정 불가능 합니다.</em>
					</div>
         		</td>
        	</tr>
		</tbody>
	</table>
</form:form>
