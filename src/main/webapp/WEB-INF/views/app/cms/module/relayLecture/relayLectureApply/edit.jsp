<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {

	$('#dialog-3').dialog({ //모달창 기본 스크립트 선언
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
					if(doAjaxPost($('#relayLectureApplyEdit'))) {
						$(this).dialog('destroy');
						$('#dialog-2').load('/cms/module/relayLecture/relayLectureApply/index.do?editMode=ADD&homepage_id='+$('#homepage_id').val() + '&lecture_idx=${relayLectureApply.lecture_idx}');
					}
					
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

	$('#dialog-3').dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 700
	});
	
});
</script>

<form:form modelAttribute="relayLectureApply" id="relayLectureApplyEdit" action="/cms/module/relayLecture/relayLectureApply/save.do">
<form:hidden path="homepage_id"/>
<form:hidden path="lecture_idx"/>
<form:hidden path="lecture_apply_idx"/>
<form:hidden path="editMode"/>

	<p>(<span style="color: red;font-weight: bold;">*</span>)</b>표시항목은 필수입력항목입니다.</p>
	<table class="type2">
		<colgroup>
			<col width="25%">
			<col width="">
		</colgroup>
		<tbody id="board_tbody">
			<tr>
				<th>이름(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="applicant_name" cssClass="text" />
				</td>
			</tr>
			<tr>
				<th>성별(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:select path="applicant_sex">
						<form:option value=""></form:option>
						<form:option value="M">남</form:option>
						<form:option value="W">여</form:option>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>연령대(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:radiobutton path="applicant_age" value="0" label="영유아(0~7세)" /><br/>
					<form:radiobutton path="applicant_age" value="1" label="초등학생(8~13세)" /><br/>
					<form:radiobutton path="applicant_age" value="2" label="청소년(14~19세)" /><br/>
					<form:radiobutton path="applicant_age" value="3" label="20대(20~29세)" /><br/>
					<form:radiobutton path="applicant_age" value="4" label="30대(30~39세)" /><br/>
					<form:radiobutton path="applicant_age" value="5" label="40대(40~49세)" /><br/>
					<form:radiobutton path="applicant_age" value="6" label="50대(50~59세)" /><br/>
					<form:radiobutton path="applicant_age" value="7" label="60대이상" />
				</td>
			</tr>
			<tr>
				<th>핸드폰(<span style="color: red;font-weight: bold;">*</span>)</th>
				<td>
					<form:input path="applicant_phone" cssClass="text" />
					<em class="ui-state-highlight">※ 입력 예) 010-0000-0000</em>
				</td>
			</tr>
			<tr>
				<th>소속</th>
				<td>
					<form:input path="applicant_belong" cssClass="text" /> 
					<em class="ui-state-highlight">※ 입력 예) 수성구청 OO과</em>
				</td>
			</tr>
		</tbody>
	</table>
	
</form:form>

