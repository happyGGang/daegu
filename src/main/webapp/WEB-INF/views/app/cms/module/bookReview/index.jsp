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
	
	$('a.review-btn').on('click', function(e) {
		e.preventDefault();
		var vLoca = $(this).attr('vLoca');
		var vCtrl = $(this).attr('vCtrl');
		var vImg = $(this).attr('vImg');
		var isbn = $(this).attr('isbn');
		var menuIdx = $(this).attr('keyValue');
		
		var url = '/'+$(this).attr('keyValue2')+'/intro/search/detail.do';
		var formData = 'vLoca='+vLoca + '&vCtrl='+vCtrl + '&vImg='+vImg + '&isbn='+isbn + '&menu_idx='+menuIdx;
		
		window.open(url+'?'+formData, '_blank');
	});
	
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#bookReviewForm').submit();
	});
	
	$('a.dialog-modify').on('click', function(e) {
		$('#dialog-1').load('edit.do?editMode=MODIFY&br_idx=' + $(this).attr('keyValue') , function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});
		
		e.preventDefault();
	});
	
	$('a.delete-btn').on('click', function(e) {
		if (confirm("해당 서평을 리스트 목록에서 삭제하시겠습니까?")) {
			$('form#bookReviewForm').attr('action', 'save.do');
			$('input#br_idx').val($(this).attr('keyValue'));
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
	<form:hidden path="br_idx"/>
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
				<tr>
					<td class="num">${paging.listRowNum - status.index}</td>
					<td>${i.br_name}<br>(${i.br_loan_id})</td>
					<td>
						${i.br_score}
					</td>
					<td class="left">
						<div class="ellipsis">${i.dsItemDetail.TITLE}</div>
					</td>
					<td>
						<a href="#" class="review-btn" vLoca="${i.dsItemDetail.LOCA}" vCtrl="${i.dsItemDetail.CTRLNO}" vImg="${i.dsItemDetail.IMAGE_URL}" isbn="${i.dsItemDetail.ISBN}" keyValue="${i.menu_idx}" keyValue2="${i.dsItemDetail.context_path}">${i.br_content}</a>
					</td>
					<td>
						<fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
						<c:if test="${authU}">
							<a href="" class="btn dialog-modify" id="dialog-modify-${i.br_idx}" keyValue="${i.br_idx}">수정</a>
						</c:if>
						<c:if test="${authD}">
							<a href="" class="btn delete-btn" keyValue="${i.br_idx}">삭제</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(bookReviewLocaList) < 1}">
				<tr>
					<td colspan="6">조회된 자료가 없습니다.</td>
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
				<form:option value="br_web_id">작성자</form:option>
				<form:option value="br_content">서평내용</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
			<a href="#" id="excelDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>엑셀저장</span></a>
			<a href="#" id="csvDownload" class="btn btn2"><i class="fa fa-file-excel-o"></i><span>CSV저장</span></a>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="서평 정보"></div>
