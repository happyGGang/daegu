<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#newsListForm').submit();
	});
	
	
	$('a#dialog-add').on('click', function(e) {
		if ( $('#homepage_id_1').val() == '' ) {
			alert('홈페이지정보가 없습니다.');	
		}
		else {
			$('#dialog-1').load('edit.do?editMode=ADD&homepage_id=' + $('#homepage_id').val(), function( response, status, xhr ) {
				$('#dialog-1').dialog('open');
			});
		}
		e.preventDefault();
	});
	$('a#dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&homepage_id=' + $('#homepage_id').val() + '&news_idx=' + $(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
// 	$('a#delete-btn').on('click', function(e) {
// 		if ( confirm('해당 뉴스를 삭제 하시겠습니까?') ) {
// 			$('#hiddenForm #news_idx').val($(this).attr('keyValue'));
// 			if(doAjaxPost($('#hiddenForm'))) {
// 				location.reload();
// 			}	
// 		}
// 		e.preventDefault();
// 	});

	$('a#delete-btn').on('click', function(e) {
		if(confirm('선택된 팝업을 삭제 하시겠습니까?')) {
			$('form#hiddenForm input#news_idx').val($(this).attr('keyValue'));
			
			$.ajax({
				url : 'delete.do',
				async : false,
				data : serializeObject($('#hiddenForm')),
				method : 'POST',
				success : function(data) {
					if(data.valid) {
						alert(data.message);
						location.reload();
					}
					else {
						if ( data.message != null ) {
							alert(data.message);
						}
						else {
							alert(data.result);	
						}
					}
				}
			});
		}
		
		e.preventDefault();
	}); 
	
	$('select#homepage_id_1').on('change', function(e) {
		if($(this).val() != '') {
			$('input#homepage_id_1').val($(this).val());
			$('#newsListForm').submit();
		}
		
		e.preventDefault();
	});
});
</script>
<form:form id="hiddenForm" modelAttribute="news" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="news_idx"/>
</form:form>

<form:form id="newsListForm"  modelAttribute="news" action="index.do" >
<form:hidden id="homepage_id_1" path="homepage_id"/>

	<div class="infodesk">
		검색 결과 : 총 ${newsListCount}건, 홈페이지 ID : ${news.homepage_id} 
		<div class="button">
			<c:if test="${authC}">
				<a href="" class="btn btn5 left" id="dialog-add"><i class="fa fa-plus"></i><span>등록</span></a>
			</c:if>
		</div>
	</div>
	<!-- 교육소식 관리 table -->
	<table class="type1 center">
		<colgroup>
			<col width="50" />
			<col width="200" />
			<col width="200" />
			<col width="" />
			<col width="200" />
			<col width="100" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>소제목</th>
				<th>내용</th>
				<th>등록일</th>
				<th>사용여부</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${newsList}">
				<tr>
					<td>${news.listRowNum - status.index}</td>
					<td>${i.title}</td>
					<td>${i.sub_title}</td>
					<td>${i.contents}</td>
					<td>${i.add_date}</td>
					<td>${i.use_yn}</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn" id="dialog-modify" keyValue="${i.news_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn" id="delete-btn" keyValue="${i.news_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${newsListCount eq 0}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#newsListForm"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="TITLE">제목</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="뉴스 정보"></div>