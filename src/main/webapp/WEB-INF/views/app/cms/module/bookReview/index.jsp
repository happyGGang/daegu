<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style type="text/css">
.ellipsis {width: 200px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
</style>
<script type="text/javascript">
$(function() {
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#bookReviewForm').submit();
	});
	
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&book_review_idx=' + $(this).attr('keyValue') , function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if (confirm("해당 서평을 리스트 목록에서 삭제하시겠습니까?")) {
			$('form#bookReviewForm').attr('action', 'save.do');
			$('input#book_review_idx').val($(this).attr('keyValue'));
			$('input#editMode').val('DELETE');
			
			doAjaxPost($('#bookReviewForm'));
		}
	});
	
	$('select#homepage_id').on('change', function(e) {
		if($(this).val() != '') {
			$('#bookReviewForm').submit();
		}
		e.preventDefault();
	});
	
	$('a#excelDownload').on('click', function(e) {
		if('${fn:length(bookReviewLocaList)}' > 0) {
			$('#bookReviewForm').attr('method', 'POST');
			$('#bookReviewForm').attr('action', 'excelDownload.do').submit();
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
	$('a#csvDownload').on('click', function(e) {
		if('${fn:length(bookReviewLocaList)}' > 0) {
			$('#bookReviewForm').attr('method', 'POST');
			$('#bookReviewForm').attr('action', 'csvDownload.do').submit();
		} else {
			alert('해당 내역이 없습니다.');
		}
		e.preventDefault();
	});
	
});
</script>
<form:form id="bookReviewForm"  modelAttribute="bookReview" action="index.do" method="GET">
	<form:hidden path="book_review_idx"/>
	<form:hidden path="editMode" />
	<c:if test="${!member.admin}">
		<form:hidden path="homepage_id"/>
	</c:if>
	
	<c:if test="${member.admin}">
		<div class="search">
			<fieldset>
				<label class="blind">검색</label>				
				<form:select class="selectmenu-search" style="width:250px" path="homepage_id">
					<form:option value="" label="홈페이지를 선택하세요." />
					<form:options itemValue="homepage_id" itemLabel="homepage_name" items="${homepageList}"/>
				</form:select> 
			</fieldset>
		</div>
	</c:if>
	
	<table class="type1 center">
		<colgroup>
			<col width="5%" />
			<col width="12%" />
			<col width="5%" />
			<col width="15%" />
			<col />
			<col width="15%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>서평 점수</th>
				<th>서명</th>
				<th>서평 내용</th>
				<th>등록일</th>
				<th>기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="i" varStatus="status" items="${bookReviewLocaList}">
				<c:set var="detailURL" value="/${i.book_info.context_path}/intro/search/detail.do?menu_idx=${fn:escapeXml(i.menu_idx)}&isbn=${i.book_info.ISBN}&regNo=${fn:escapeXml(i.book_info.REG_NO)}&manageCode=${fn:escapeXml(i.book_info.MANAGE_CODE)}&booktype=${fn:escapeXml(i.book_type eq '0' ? 'BO' : 'SE')}"></c:set>
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>${i.book_review_name}<br>(${i.book_review_loan_id})</td>
					<td>
						${i.book_review_score}
					</td>
					<td class="left">
						<div class="ellipsis">${i.book_info.TITLE_INFO}</div>
					</td>
					<td>
						<a href="${detailURL}" target="_blank">${i.book_review_content}</a>
					</td>
					<td>
						<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" id="dialog-modify-${i.book_review_idx}" keyValue="${i.book_review_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue="${i.book_review_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(bookReviewLocaList) < 1}">
				<tr>
					<td colspan="7">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
 	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookReviewForm"/>
	</jsp:include>
	
 	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu">
				<form:option value="book_review_web_id">작성자</form:option>
				<form:option value="book_review_content">서평내용</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="서평 정보"></div>
