<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	//모달창 링크 버튼
	$('a#dialog-add').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=ADD', function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('a#delete').on('click', function(e) {
		if(confirm('해당 도서관 설정을 삭제 하시겠습니까?')) {
			$('input#editMode_index').val('DELETE');
			$('input#homepage_id_index').val($(this).attr('keyValue'));
			if(doAjaxPost($('#homepage_index'))) {
				location.reload();
			}
		}

		e.preventDefault();
	});

	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

		e.preventDefault();
	});

	$('#rowCount').change(function(e) {
		doGetLoad('index.do', serializeCustom($('#homepage_index')));
	});

	/* $('a#dialog-tempPage').on('click', function(e) {
		$('#dialog-2').load('tempPage.do?homepage_id=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-2').dialog('open');
		});
		e.preventDefault();
	}); */
});
</script>
<form:form id="homepage_index" modelAttribute="homepage" action="save.do" method="post" onsubmit="return false;">
	<form:hidden id="editMode_index" path="editMode"/>
	<form:hidden id="homepage_id_index" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : ${homepageListCount}건
		<form:select path="rowCount" class="selectmenu" style="width:150px;">
				<form:option value="10">10개씩 보기</form:option>
				<form:option value="20">20개씩 보기</form:option>
				<form:option value="30">30개씩 보기</form:option>
				<form:option value="${homepageListCount}">전체 보기</form:option>
			</form:select>
		<div class="button btn-group inline">
			<c:if test="${member.admin}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>도서관 추가</span></a>
			</c:if>
		</div>
	</div>
	<div class="table-wrap">
		<table class="type1 center">
			<colgroup>
				<col/>
				<col width="200"/>
				<col width="200"/>
				<col width="100"/>
				<col width="200"/>
			</colgroup>
			<thead>
				<tr>
					<th>도서관명</th>
					<th>관리코드</th>
					<th>도서관 부호</th>
					<th>출력순서</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(homepageList) < 1}">
				<tr>
					<td colspan="8">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${homepageList}">
				<tr>
					<%-- <td class="num">${i.homepage_id}</td> --%>
					<td>${i.homepage_name}</td>
					<td>
						${i.manage_code}
					</td>
					<td>
						${i.lib_code}
					</td>
					<td>
						${i.print_seq}
					</td>
					<td>
						<c:if test="${member.admin or (authU and asideHomepageId eq i.homepage_id)}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.homepage_id}">수정</a>
						</c:if>
						<c:if test="${member.admin}">
							<a href="" class="btn" id="delete" keyValue="${i.homepage_id}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
			<jsp:param name="formId" value="#homepage_index"/>
		</jsp:include>
	</div>
</form:form>
<div id="dialog-1" class="dialog-common" title="도서관 정보">
</div>
<div id="dialog-2" class="dialog-common" title="임시페이지 예약">
</div>