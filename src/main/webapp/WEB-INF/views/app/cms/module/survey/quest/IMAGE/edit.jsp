<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="cms" uri="/WEB-INF/config/tld/cmsTag.tld"%>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript" ></script>
<script src="/resources/cms/survey/js/common.js" type="text/javascript" ></script>
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
				"class": 'btn',
				click: function() {
					
					var imgFile = $('#imageFile').val();
					
					if(imgFile == null || imgFile == "") {
						alert('업로드 할 이미지를 선택해주세요.');
						return;
					}										 

					imgFile = imgFile.slice(imgFile.indexOf(".") + 1).toLowerCase();
					if(imgFile != "jpg" && imgFile != "png" &&  imgFile != "gif" &&  imgFile != "bmp"){ 
						alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
						return;

					}
					
					doAjaxPostFileUpload($('#questEdit'));
					$(this).dialog('destroy');
					$('#dialog-3').load('/cms/survey/quest/index.do?survey_idx=${param.survey_idx}&homepage_id=${param.homepage_id}', function( response, status, xhr ) {
						$('#dialog-3').dialog('open');
					});
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
	
	$("#dialog-4").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 820,
		height: 650
	});
	
	<%-- 이미지 미리보기 --%>
	$('input[name=imageFile]').change(function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$('img#newImg').attr('src', e.target.result);
			};
			reader.readAsDataURL(this.files[0]);
		} else {
		}
	});
	
	<c:if test="${quest.editMode eq 'modify'}">
		$('img#newImg').attr('src', '/cms${quest.quest_content}');
	</c:if>
	
});
</script>

<div class="brdTop_01">
	<h1>이미지</h1>
</div>

<div class="guide">
	<ul class="list">
		<li><em>[이미지]</em>는 문항 사이에 기술하는 설명 및 안내문구를 입력할 수 있습니다.</li>
		<li>이미지를 선택하신 후 저장버튼을 선택하여 주십시오.</li>
	</ul>
</div>
<p class="hspace10"></p>
<form:form modelAttribute="quest" id="questEdit" action="/cms/survey/quest/saveImage.do" method="POST" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/cms/module/survey/quest/common/form_param.jsp" flush="false" />

<div class="boardEdit mysurvey">
	<table class="edit" summary="이미지를 첨부할 수 있습니다.">
		<colgroup>
			<col width="80" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>이미지</th>
				<td class="aL">
					<div class="item">
						<input type="file" name="imageFile" id="imageFile"/>
					</div>	
				</td>
			</tr>
			<tr>
				<th>미리보기</th>
				<td class="aL">
					<div class="item">
						<img src="" id="newImg" style="max-width: 470px;" alt="미리보기"/>
					</div>	
				</td>
			</tr>
			<tr>
				<th>필수여부</th>
				<td class="aL">
					<form:radiobutton path="required_yn" value="Y" label="필수"/>
					<form:radiobutton path="required_yn" value="N" label="선택"/>
					<span class="em">*반드시 응답해야 하는 문항이면 필수를 선택해 주세요.</span>
				</td>
			</tr>
			<tr style="display: none;">
				<th>권한설정</th>
				<td class="aL">
					<table>
						<tr>
							<td rowspan="2">
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="ALL" id="auth_ALL" />
								<label for="auth_ALL">전체</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="STUDENT" id="auth_STUDENT" />
								<label for="auth_STUDENT">학생</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="TEACHER" id="auth_TEACHER" />
								<label for="auth_TEACHER">교사</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="SPECIAL" id="auth_SPECIAL" />
								<label for="auth_SPECIAL">전문직</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="GENERAL" id="auth_GENERAL" />
								<label for="auth_GENERAL">일반직</label>
							</td>
						</tr>
						<tr>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="PARENT" id="auth_PARENT" />
								<label for="auth_PARENT">학부모</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="REGULAR" id="auth_REGULAR" />
								<label for="auth_REGULAR">일반</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="ORGAN" id="auth_ORGAN" />
								<label for="auth_ORGAN">기관</label>
							</td>
							<td>
								<cms:authCheckbox name="quest_auth" auth="${quest.quest_auth}" value="ETC" id="auth_ETC" />
								<label for="auth_ETC">기타</label>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form:form>
<p class="hspace10"></p>