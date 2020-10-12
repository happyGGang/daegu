<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/hb_common.css"/>
<script type="text/javascript">
$(function(){


	$('a#apply-btn').on('click', function(e) {
		e.preventDefault();

		if ($('input#reqHumanBookPrivacy:checked').val() != '1') {
			alert('개인정보 수집 이용에 동의 후 신청 가능합니다.');
			$('input#reqHumanBookPrivacy').focus();
			return false;
		}

		if(doAjaxPost($('form#humanApply'))) {
			var url = '/${homepage.context_path}/module/humanBook/list.do';
			$('input#editMode').remove();
			doGetLoad(url, serializeCustom($('form#humanBookList')));
		}
	});

	$('a#cancel-btn').on('click', function(e) {
		e.preventDefault();
		history.go(-1);
	});

});
$(document).on('keyup', 'input.onlyNum', function() {
	$(this).val( $(this).val().replace(/[^0-9]/gi, '') );
});
</script>
<form:form modelAttribute="humanApply" id="humanBookList" action="list.do" method="GET">
<form:hidden path="homepage_id"/>
<form:hidden path="menu_idx"/>
<form:hidden path="viewPage"/>
</form:form>

<form:form modelAttribute="humanApply" action="save.do" method="POST">
<form:hidden path="homepage_id"/>
<form:hidden path="editMode"/>
<form:hidden path="human_book_idx"/>

<h4>개인정보 수집 및 이용 동의</h4>
<div class="Box">
	<ul class="con2">
		<li> 휴먼북 열람을 위한 개인 정보 수입에 동의하며, 또한 알게 된 ‘휴먼북’의 개인정보에 대해서 비밀을 지키며, 내부지침을 준수할 것을 약속합니다. </li>
		<li> 위에 기재된 정보는 「공공기관의 개인정보보호에 관한 법률」에 의해 보호되며, 휴먼북 상담외에는 사용하지 않습니다. </li>
	</ul>
</div>
<div class="agree_codes">
	<input id="reqHumanBookPrivacy" name="reqHumanBookPrivacy" type="checkbox" value="1"/>
	<label for="reqHumanBookPrivacy">개인정보 수집 및 이용에 동의 합니다.</label>
</div>

<table class="edit" style="margin-top:23px;">
	<tbody>
		<tr>
			<th>휴먼북 제목</th>
			<td>
				<form:hidden path="human_book_title"/>
				${humanApply.human_book_title}
			</td>
		</tr>
		<tr>
			<th>신청자명</th>
			<td><form:input path="human_apply_name" cssClass="text"/></td>
		</tr>
		<tr>
			<th>신청자연령</th>
			<td>
				<form:radiobutton path="human_apply_age" value="20" label="20대" />
				<form:radiobutton path="human_apply_age" value="30" label="30대" />
				<form:radiobutton path="human_apply_age" value="40" label="40대" />
				<form:radiobutton path="human_apply_age" value="50" label="50대" />
				<form:radiobutton path="human_apply_age" value="60" label="60대 이상" />
			</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				<form:radiobutton path="human_apply_gender" value="1" label="남"/>
				<form:radiobutton path="human_apply_gender" value="2" label="여"/>
			</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>
				<form:input path="human_apply_phone" cssClass="text" size="15"/>
			</td>
		</tr>
		<tr>
			<th>열람희망일 및 시간</th>
			<td>
				<form:input path="human_apply_hope_date" cssClass="text" placeholder="년 .월 .일 .(오전․오후) 시 분" size="30"/>
			</td>
		</tr>
		<tr>
			<th>열람장소</th>
			<td><form:input path="human_apply_place" cssClass="text"/></td>
		</tr>
		<tr>
			<th>열람인원</th>
			<td><form:input path="human_apply_people" class="onlyNum text" size="5"/></td>
		</tr>
		<tr>
			<th>열람목적</th>
			<td>
				<form:textarea path="human_apply_content" cssClass="text" cssStyle="width:98%;height:180px;"/>
				</td>
			</tr>

		</tbody>
</table>


<div class="" style="text-align:center;padding-top:10px;">
	<a href="#" id="apply-btn" class="btn btn1">신청</a>
	<a href="#" id="cancel-btn" class="btn">취소</a>
</div>

</form:form>