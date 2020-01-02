<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('input#list_seq, input#write_seq, input#search_seq').spinner({
		min: 0,
		max: 100,
		step: 1,
		start: 1
	});

	$('a#fieldManage_add').on('click', function(e) {
		$('#fieldManageEditLayer').load('/cms/boardManage/fieldManage/edit.do?editMode=ADD&manage_idx=${fieldManage.manage_idx}', function() {
			$('button#fieldManage_save').show();
		});
		e.preventDefault();
	});

	$('select#board_column').on('change', function(e) {
		var column_nm = $(this).children("option:selected").text()
		$('input#board_column_nm').val(column_nm);
		$('input#board_content').val(column_nm);
	});
});
</script>
<h3>컬럼 설정하기${fieldManage.editMode eq 'MODIFY'?'(수정하기)':'(신규등록)'}
<a href="" class="btn btn5" id="fieldManage_add"><i class="fa fa-plus"></i><span>추가</span></a>
</h3>
<div id="editDisable" class="disableBox">
	<c:if test="${fieldManage.editMode eq 'FIRST'}">
	<div class="mask"></div>
	</c:if>
	<div style="height:263px">
	<form:form modelAttribute="fieldManage" action="/cms/boardManage/fieldManage/save.do" method="POST">
	<form:hidden path="manage_idx"/>
	<form:hidden path="field_idx"/>
	<form:hidden path="editMode"/>
		<table class="type3 center">
			<tbody>
				<tr>
					<th rowspan="2" class="ceGroup">공통</th>
					<th style="width:18%">컬럼</th>
					<th style="width:18%">컬럼(디폴트)명</th>
					<th style="width:18%">항목명</th>
					<th style="width:18%">컬럼타입</th>
					<th style="width:18%">코드맵핑</th>
				</tr>
				<tr class="gubun">
					<td>
						<form:select path="board_column" cssClass="selectmenu-search" cssStyle="width:150px;">
							<form:option value="">==컬럼선택 ==</form:option>
							<form:options itemLabel="board_column_nm" itemValue="board_column" items="${boardColumnInfoList}"/>
						</form:select>
					</td>
					<td><form:input path="board_column_nm" cssClass="text disabled" cssStyle="width:150px;" readonly="true"/></td>
					<td><form:input path="board_content" cssClass="text" cssStyle="width:150px;"/></td>
					<td>
						<form:select path="column_type" cssClass="selectmenu-search tags" cssStyle="width:150px;">
							<form:options itemLabel="code_name" itemValue="code_id" items="${columnTypeList}"/>
						</form:select>
					</td>
					<td>
						<form:select path="code_mapping" cssClass="selectmenu-search" cssStyle="width:150px;">
							<form:option value="">==코드선택 ==</form:option>
							<form:options itemLabel="group_name" itemValue="group_id" items="${codeGroupList}"/>
						</form:select>
					</td>
				</tr>

				<tr>
					<th rowspan="2" class="ceGroup">글목록</th>
					<th>넓이</th>
					<th>최대표시길이</th>
					<th>순서</th>
					<th>사용</th>
					<th>본문링크</th>
				</tr>
				<tr class="gubun">
					<td><form:input path="list_width" cssClass="text" cssStyle="width:150px;"/></td>
					<td><form:input path="list_maxwidth" cssClass="text" cssStyle="width:150px;"/></td>
					<td><form:input path="list_seq" cssClass="text" cssStyle="width:110px;"/></td>
					<td>
						<form:radiobutton path="list_use_yn" value="Y" label="사용함"/>
						<form:radiobutton path="list_use_yn" value="N" label="사용안함"/>
					</td>
					<td>
						<form:radiobutton path="content_link_yn" value="Y" label="사용함"/>
						<form:radiobutton path="content_link_yn" value="N" label="사용안함"/>
					</td>
				</tr>

				<tr>
					<th rowspan="2" class="ceGroup">글등록</th>
					<th>항목넓이</th>
					<th>항목높이</th>
					<th>필수입력</th>
					<th>순서</th>
					<th>답변전용</th>
				</tr>
				<tr class="gubun">
					<td><form:input path="write_width" cssClass="text" cssStyle="width:150px;"/></td>
					<td><form:input path="write_height" cssClass="text" cssStyle="width:150px;"/></td>
					<td>
						<form:radiobutton path="write_req_cont" value="Y" label="사용함"/>
						<form:radiobutton path="write_req_cont" value="N" label="사용안함"/>
					</td>
					<td><form:input path="write_seq" cssClass="text" cssStyle="width:110px;"/></td>
					<td>
						<form:radiobutton path="admin_only" value="Y" label="사용함"/>
						<form:radiobutton path="admin_only" value="N" label="사용안함"/>
					</td>
				</tr>

				<tr>
					<th rowspan="2" class="ceGroup">검색</th>
					<th>순서</th>
					<th>사용</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr>
				<tr class="gubun">
					<td><form:input path="search_seq" cssClass="text" cssStyle="width:110px;"/></td>
					<td>
						<form:radiobutton path="search_use_yn" value="Y" label="사용함"/>
						<form:radiobutton path="search_use_yn" value="N" label="사용안함"/>
					</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</tbody>
		</table>
	</form:form>
	</div>
</div>