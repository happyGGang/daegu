<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	$('button.select-btn').on('click', function(e) {
		$('tr.selectRow').css('background', 'white');
		$(this).parent().parent().css('background', '#b4e0fa');
		$('#studentLayer').load('student.do?homepage_id='+$(this).attr('keyValue1')+'&group_idx=' + $(this).attr('keyValue2')+ '&category_idx=' + $(this).attr('keyValue3')+'&teach_idx=' + $(this).attr('keyValue4')+'&large_category_idx=' + $(this).attr('keyValue5'));
		e.preventDefault();
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			// $('input#homepage_id_1').val($(this).val());
			doGetLoad('index.do', $('#adminStudentForm').serialize());
		}

		e.preventDefault();
	});

	$('select#large_category_idx').on('change', function() {
		$('#adminStudentForm select#group_idx option.all').prop('selected', true);
		$('#adminStudentForm select#category_idx option.all').prop('selected', true);
		doGetLoad('index.do', $('#adminStudentForm').serialize());
	});

	$('select#group_idx').on('change', function() {
		$('#adminStudentForm select#category_idx option.all').prop('selected', true);
		doGetLoad('index.do', $('#adminStudentForm').serialize());
	});

	$('select#category_idx').on('change', function() {
		doGetLoad('index.do', $('#adminStudentForm').serialize());
	});

	$('#studentLayer').load('student.do?editMode=FIRST');

});
</script>
<form:form id="adminStudentForm" modelAttribute="student">
	<div class="wrapper wrapper-white">
		<div class="column ban">
			<div class="areaL auto-scroll" style="width:30%;height:500px">
			<span>
				<c:choose>
					<c:when test="${fn:length(subHomepageList) > 0 and asideHomepageId ne 'h50' and asideHomepageId ne 'h51' and asideHomepageId ne 'h37'}">
						도서관 : <form:select id="homepage_id_1" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
					</c:when>

					<c:when test="${asideHomepageId eq 'h50'}">
						도서관 :
						<form:select id="homepage_id_1" path="homepage_id">
							<form:option value="h50">범어</form:option>
							<form:option value="h54">책숲길</form:option>
							<form:option value="h55">물망이</form:option>
							<form:option value="h93">황금책</form:option>
						</form:select>
					</c:when>


					<c:when test="${asideHomepageId eq 'h51'}">
						도서관 :
						<form:select id="homepage_id_1" path="homepage_id">
							<form:option value="h51">용학</form:option>
							<form:option value="h56">파동</form:option>
							<form:option value="h57">무학숲</form:option>
						</form:select>
					</c:when>



					<c:when test="${asideHomepageId eq 'h37'}">
						도서관 :
						<form:select id="homepage_id_1" path="homepage_id">
							<form:option value="h72">도원</form:option>
							<form:option value="h67">성서</form:option>
							<form:option value="h68">본리</form:option>
							<form:option value="h69">달서가족문화</form:option>
							<form:option value="h66">달서어린이</form:option>
							<form:option value="h70">달서영어</form:option>
							<form:option value="h41">독서문화진흥</form:option>
						</form:select>
					</c:when>
					<c:otherwise>
						<form:hidden id="homepage_id_1" path="homepage_id"/>
					</c:otherwise>
				</c:choose>

			</span>
			<br/>

			<span>검색 결과 : ${fn:length(teachList)}건</span>
				<div class="infodesk">
					<span style="float:left;">대분류 :
					<form:select path="large_category_idx">
						<form:option class="all" value="0" label="전체" />
						<form:options itemValue="teach_code" itemLabel="code_name" items="${teachLargeCategoryList}"/>
					</form:select></span>
					<span style="float:left;">중분류 :
					<form:select path="group_idx" cssStyle="width:100px;">
						<form:option class="all" value="0" label="전체" />
						<form:options itemValue="group_idx" itemLabel="group_name" items="${categoryGroupList}"/>
					</form:select></span>
					<span style="float:right;">소분류 :
					<form:select path="category_idx" >
						<form:option class="all" value="0" label="전체" />
						<c:forEach items="${categoryList}" var="i">
	         				<form:option class="group_${i.group_idx}" value="${i.category_idx}" >${i.category_name}</form:option>
	         			</c:forEach>
					</form:select></span><br/>
				</div>

				<div class="table-wrap">
					<table class="type1 center">
						<thead>
						<tr>
							<th width="30">번호</th>
							<th>강좌명</th>
							<th width="15%">선택</th>
						</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(teachList) > 0}">
									<c:forEach var="i" varStatus="status" items="${teachList}">
										<tr class="selectRow">
											<td class="num">${(student.viewPage * student.listPageCount - (student.listPageCount - status.count))}</td>
											<td>${i.teach_name}</td>
											<td><button class="btn teach_btn_${i.group_idx}${i.category_idx}${i.teach_idx} select-btn" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}" keyValue3="${i.category_idx}" keyValue4="${i.teach_idx}" keyValue5="${i.large_category_idx}">선택</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">데이터가 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

			<div id="studentLayer" class="areaR" style="float:left; width:68%;">
			</div>
		</div>
	</div>
</form:form>

