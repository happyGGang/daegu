<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('a.select-btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#categoryLayer').load('category.do?homepage_id=' + $(this).attr('keyValue1') + '&group_idx=' + $(this).attr('keyValue2') + '&large_category_idx=' + $('select#large_category_idx').val());
		e.preventDefault();
	});

	$('a.add-btn').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');
		}
		else {
			$('#dialog-1').load('editGroup.do?editMode=ADD&homepage_id=' + $('#homepage_id_1').val() + '&large_category_idx=' + $('select#large_category_idx').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}

		e.preventDefault();
	});

	$('a.modify-btn').on('click', function(e) {
		$('#dialog-1').load('editGroup.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue1') + '&group_idx=' + $(this).attr('keyValue2') + '&large_category_idx=' + $('select#large_category_idx').val(), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a.del-btn').on('click', function(e) {
		if ( confirm('해당 중분류를 삭제 하시겠습니까?') ) {
			$('#hiddenGroupForm #homepage_id').val($(this).attr('keyValue1'));
			$('#hiddenGroupForm #group_idx').val($(this).attr('keyValue2'));
			if(doAjaxPost($('#hiddenGroupForm'))) {
				location.reload();
			}
		}

		e.preventDefault();
	});

	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('#categoryGroupListForm input#homepage_id_1').val($(this).val());
			$('#categoryGroupListForm').submit();
		}
	});

	$('#categoryLayer').load('category.do?editMode=FIRST&homepage_id='+$('#homepage_id_1').val());

	<%--대분류변경--%>
	$('select#large_category_idx, select#homepage_id').on('change', function() {
		doGetLoad('index.do', $('form#hiddenGroupForm').serialize());
	});


});
</script>
<form:form id="categoryGroupListForm"  modelAttribute="categoryGroup" action="index.do" >
	<form:hidden id="homepage_id_1" path="homepage_id"/>

</form:form>

<form:form id="hiddenGroupForm" modelAttribute="categoryGroup" action="saveGroup.do">
	<form:hidden path="editMode" value="DELETE"/>
<%--	<form:hidden path="homepage_id"/>--%>
	<form:hidden path="group_idx"/>



<div class="search">
	<fieldset>
		<label class="blind">검색</label>
		<c:choose>
			<c:when test="${fn:length(subHomepageList) > 0 and asideHomepageId ne 'h50' and asideHomepageId ne 'h51' and asideHomepageId ne 'h37'}">
				도서관 : <form:select id="homepage_id" path="homepage_id" items="${subHomepageList}" itemLabel="homepage_name" itemValue="homepage_id"></form:select>
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
					<form:option value="h98">그림책</form:option>
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
				<form:hidden path="homepage_id"/>
			</c:otherwise>
		</c:choose>

		대분류 선택 :
		<form:select path="large_category_idx" items="${teachLargeCategoryList}" itemLabel="code_name" itemValue="teach_code">
		</form:select>
	</fieldset>
</div>
</form:form>
<div class="column ban" >

	<div class="areaL" style="width:45%;">
		<h3>중분류정보</h3>
		<div class="group-menu-header">
			<span>검색 결과 : ${categoryGroupListCount}건</span>
			<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 add-btn"><i class="fa fa-plus"></i><span>중분류 신규등록</span></a>
			</c:if>
			</div>
		</div>

		<div class="table-wrap auto-scroll" style="height:500px">
			<table class="type1 center">
				<colgroup>
					<col width="50" />
					<col width="" />
					<col width="100" />
					<col width="100" />
					<col width="200" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>중분류명</th>
						<th>신청제한단위</th>
						<th>신청제한수</th>
						<th>기능</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(categoryGroupList) > 0}">
							<c:forEach var="i" varStatus="status" items="${categoryGroupList}">
								<tr>
									<td class="num">${categoryGroup.listRowNum - status.index}<br/>(${i.group_idx})</td>
									<td>
									<a href="" class="select-btn group_${i.group_idx}" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}"><span>${i.group_name}</span></a>

									</td>
									<td>
										<c:if test="${i.req_limit_yn eq 'Y'}">
										<c:choose>
										<c:when test="${i.req_limit_type eq '1'}">
										1년
										</c:when>
										<c:when test="${i.req_limit_type eq '6'}">
										6개월
										</c:when>
										<c:when test="${i.req_limit_type eq '3'}">
										3개월
										</c:when>
										</c:choose>
										</c:if>
									</td>
									<td>${i.req_limit_count}</td>
				<%-- 					<td>${i.print_seq}</td> --%>
				<%-- 					<td>${i.use_yn}</td> --%>
									<td>
										<c:if test="${authU}">
											<a href="" class="btn modify-btn" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}"><i class="fa fa-plus"></i><span>수정</span></a>
										</c:if>
										<c:if test="${authD}">
											<a href="" class="btn del-btn" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}"><i class="fa fa-minus"></i><span>삭제</span></a>
										</c:if>
										<a href="" class="btn btn1 select-btn group_${i.group_idx}" keyValue1="${i.homepage_id}" keyValue2="${i.group_idx}"><span>선택</span></a>
									</td>
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

	<div id="categoryLayer" class="areaR" style="float:left; width:45%%" >
	</div>
</div>
<div class="ui-state-highlight">
	<em>* 메뉴연결시 번호 중분류 아랫부분 괄호 안의 번호를 입력해주세요.</em>
</div>
<div class="ui-state-highlight">
	<em>* 중분류 삭제는 해당 중분류에 소분류가 있을시 불가능 합니다.</em>
</div>
<div class="ui-state-highlight">
	<em>* 소분류 삭제는 해당 소분류에 강좌가 있을시 불가능 합니다.</em>
</div>
<div id="dialog-1" class="dialog-common" title="중분류 정보">
</div>