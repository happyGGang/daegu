<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script>
function save() {
	doAjaxPost($('#untactBookSetting'));
}
</script>
<div class="ui-state-highlight">
	'사물함' 기본설정 화면입니다.
</div>	
<form:form modelAttribute="untactBookSetting" action="bookSettingSave.do" method="POST">
	<table class="type1 center">
		<colgroup>
			<col width="10%" />
			<col  />
			<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th>홈페이지ID</th>
				<th>사물함 사용여부</th>
				<th>사물함 한줄당 갯수</th>	
				<th>총 사물함 갯수</th>	
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${untactBookSetting.homepage_id}</td>
				<td>
					<form:radiobutton path="use_yn" value="Y" label="사용" />
					<form:radiobutton path="use_yn" value="N" label="미사용" />
				</td>
				<td>
					<form:input path="row_count"/>		
				</td>
				<td>
					<form:input path="total_count"/>
				</td>
			</tr>
		</tbody>
	</table>
</form:form>
<div class="table-wrap">
	<div class="button">
		<a href="javascript:void(0)" class="btn btn1" onclick="save();"><i class="fa fa-pencil"></i><span>저장하기</span></a>
		<a href="" class="btn" id="editGroup_delete"><i class="fa fa-minus"></i><span>취소</span></a>
	</div>
</div>