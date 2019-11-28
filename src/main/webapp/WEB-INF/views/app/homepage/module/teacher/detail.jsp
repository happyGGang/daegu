<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function () {
	/* $('#save-btn').on('click', function() {
		if(doAjaxPost($('#teacherForm'))) {
		}
	}); */

	$('#back-btn').on('click', function() {
		history.back();
	});
});
</script>
<table class="type2">
	<colgroup>
       <col width="200" />
       <col width="*"/>
    </colgroup>
      	<tbody>
		<tr>
         	<th>강사명</th>
         	<td>${teacher.teacher_name}</td>
       	</tr>
       	<tr>
         	<th>과목명</th>
         	<td>${teacher.teacher_subject_name}</td>
       	</tr>
        <tr>
         	<th>성별</th>
         	<td>
				${teacher.teacher_sex}
			</td>
        </tr>
		<%-- <tr>
			<th>전화번호</th>
			<td>
				<div class="ui-state-highlight">
					<em>* ex) 053-666-7777</em>
				</div>
			</td>
		</tr>
		<tr>
			<th>휴대전화번호</th>
			<td>
				<form:input path="teacher_cell_phone" class="text"/>
				<div class="ui-state-highlight">
					<em>* ex) 010-1234-5678</em>
				</div>
			</td>
		</tr> --%>
		<tr>
         	<th>국적</th>
         	<td>${teacher.teacher_nationality}</td>
       	</tr>
       	<%-- <tr>
         	<th>우편번호</th>
         	<td><form:input path="teacher_zipcode" class="text"/> <button class="btn btn2 findPostCode" keyValue1="#teacher_zipcode" keyValue2="#teacher_address">우편번호 찾기</button></td>
       	</tr>
		<tr>
         	<th>주소</th>
         	<td><form:input path="teacher_address" class="text" style="width:100%"/></td>
       	</tr> --%>
       	<tr>
         	<th>강사이력</th>
         	<td>${teacher.teacher_history }</td>
       	</tr>
       	<c:if test="${ teacher.file_name != null and teacher.file_name != '' }">
       	<tr>
       		<th>첨부 파일</th>
       		<td><a href="/${homepage.context_path}/module/teacherReqManage/download/${teacher.homepage_id}/${teacher.teacher_idx}.do"><i class="fa fa-floppy-o"></i> ${teacher.file_name}</a></td>
       	</tr>
       	</c:if>
	</tbody>
</table>
<br/>
<div class="button bbs-btn center">
	<button id="back-btn" class="btn"><i class="fa fa-reorder"></i><span>뒤로가기</span></button>
</div>