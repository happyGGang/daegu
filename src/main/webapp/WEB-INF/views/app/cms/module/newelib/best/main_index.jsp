<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(function() {
	$('button#search_btn').on('click', function(e) {
		$('#viewPage').val(1);
		$('#bookListForm').submit();
	});
	
	$('a.addbestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		var new_book_idx = parseInt($('#new_book_idx').val()) || 0;
		
		if(new_book_idx == 0) {
			alert('0보다 큰 숫자를 입력하세요.');
			return;
		}
		
		$('#bestbook_editMode').val('ADDBESTBOOK');
		$('#bestbook_book_idx').val($('#new_book_idx').val());
		$('#bestbook_bestbook_idx').val($(this).data('bestbook_idx'));
		if(doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a.deletebestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('DELETEBESTBOOK');
		$('#bestbook_book_idx').val($(this).data('book_idx'));
		if(confirm('제외하시겠습니까?') && doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a.raisebestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('RAISEBESTBOOK');
		$('#bestbook_book_idx').val($(this).data('book_idx'));
		$('#bestbook_bestbook_idx').val($(this).data('bestbook_idx'));
		if(doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a.lowerbestbook').on('click', function(e) {
		e.preventDefault();
		var $form = $('form#bestbook_form');
		
		$('#bestbook_editMode').val('LOWERBESTBOOK');
		$('#bestbook_book_idx').val($(this).data('book_idx'));
		$('#bestbook_bestbook_idx').val($(this).data('bestbook_idx'));
		if(doAjaxPost($form)) {
			location.reload();
		}
	});
	
	$('a#set').on('click', function(e) {
		e.preventDefault();
		var date_range = parseInt($('#date_range').val()) || 0;
		var lend_weight = parseFloat($('#lend_weight').val()) || 0;
		var reserve_weight = parseFloat($('#reserve_weight').val()) || 0;
		var comment_weight = parseFloat($('#comment_weight').val()) || 0;
		var recommend_weight = parseFloat($('#recommend_weight').val()) || 0;
		var audiobook_weight = parseFloat($('#audiobook_weight').val()) || 0;
		var elearning_weight = parseFloat($('#elearning_weight').val()) || 0;
		
		if($('input[name=types]:checked').length == 0) {
			alert('콘텐츠 타입은 하나 이상 선택해야 합니다.');
			$('#types').focus();
			return;
		}
		
		if(date_range == 0) {
			alert('통계 기간의 값은 0보다 커야 합니다.');
			$('#date_range').focus();
			return;
		}
		
		if(lend_weight + reserve_weight + comment_weight + recommend_weight + audiobook_weight + elearning_weight != 1) {
			alert('모든 가중치의 합은 1이어야 합니다.');
			return;
		}
		if(doAjaxPost($('form#config_form'))) {
			location.reload();
		};
	});
	
	$('select#library_code').on('change', submit);
	$('select#com_code').on('change', submit);
	$('select#sortField').on('change', submit);
	$('select#rowCount').on('change', submit);
	$('select#type').on('change', submit);
	$('select#cate1').on('change', submit);
	
});

function submit(e) {
	e.preventDefault();
	$('#bookListForm').submit();
}
</script>
<form:form id="hiddenForm" modelAttribute="bestBook" action="save.do">
<form:hidden path="editMode" value="DELETE"/>
<form:hidden path="homepage_id"/>
<form:hidden path="book_idx" id="hiddenForm_book_idx"/>
<form:hidden path="type" id="hiddenForm_type"/>
</form:form>
<form:form modelAttribute="bestBook" id="bestbook_form" action="save.do" method="post">
<form:hidden path="editMode" id="bestbook_editMode"/>
<form:hidden path="book_idx" id="bestbook_book_idx"/>
<form:hidden path="parent_id" id="bestbook_parent_id"/>
<form:hidden path="cate_id" id="bestbook_cate_id"/>
<form:hidden path="print_seq" id="bestbook_print_seq"/>
<form:hidden path="bestbook_idx" id="bestbook_bestbook_idx"/>
</form:form>
<c:set var="countName" value="대출횟수"/>
<c:set var="cols" value="11"/>
<c:if test="${bestBook.type != 'WEB'}">
<c:set var="cols" value="11"/>
</c:if>
<div class="infodesk">
	<div class="button center">
<%-- 		<c:if test="${authC}"> --%>
			<a href="" class="btn btn5 left" id="set"><i class="fa fa-plus"></i><span>저장</span></a>
<%-- 		</c:if> --%>
	</div>
</div>
<form:form modelAttribute="bestBook" id="config_form" action="save.do" method="post">
<form:hidden path="editMode" value="MODIFYCONFIG"/>
<table class="type1">
	<colgroup>
       <col width="230" />
       <col width="*"/>
	</colgroup>
	<tbody>
		<tr>
         	<th>메인 베스트 자동 업데이트</th>
         	<td>
         		<form:radiobutton path="auto_update_yn" value="Y" label="켜기"/>&nbsp;
         		<form:radiobutton path="auto_update_yn" value="N" label="끄기"/>
         		<div class="ui-state-highlight">
					<em>활성화 시 매일 새벽 0시 27분에 자동 업데이트</em>
				</div>
         	</td>
       	</tr>
		<tr>
         	<th>콘텐츠 타입</th>
         	<td>
         		<input type="checkbox" name="types" value="EBK" id="types1" <c:if test="${fn:indexOf(bestBook.types, 'EBK') > -1}"> checked</c:if>/><label for="types1">전자책</label>&nbsp;
         		<input type="checkbox" name="types" value="ADO" id="types2" <c:if test="${fn:indexOf(bestBook.types, 'ADO') > -1}"> checked</c:if>/><label for="types2">오디오북</label>&nbsp;
         		<input type="checkbox" name="types" value="WEB" id="types3" <c:if test="${fn:indexOf(bestBook.types, 'WEB') > -1}"> checked</c:if>/><label for="types3">온라인강좌</label>
         	</td>
       	</tr>
		<tr>
         	<th>인기 지수 가중치 설정</th>
         	<td>
         		최근 <form:input path="date_range" class="text" cssStyle="width: 50px;"/>일 간의 통계<br/>
         		인기 지수 = <br/>
         			&nbsp;&nbsp;&nbsp;(대출수 × <form:input path="lend_weight" class="text" cssStyle="width: 50px;"/>) <br/>
         			+ (예약수 × <form:input path="reserve_weight" class="text" cssStyle="width: 50px;"/>) <br/>
         			+ (서평수 × <form:input path="comment_weight" class="text" cssStyle="width: 50px;"/>) <br/>
         			+ (추천수 × <form:input path="recommend_weight" class="text" cssStyle="width: 50px;"/>) <br/>
         			+ (오디오북 조회수 × <form:input path="audiobook_weight" class="text" cssStyle="width: 50px;"/>) <br/>
         			+ (온라인강좌 조회수 × <form:input path="elearning_weight" class="text" cssStyle="width: 50px;"/>) <br/>
         		<div class="ui-state-highlight">
					<em>ex) 인기 지수 = (대출수 × 0.25) + (예약수 × 0.05) + (서평수 × 0.20) + (추천수 × 0.10) + (오디오북 조회수 × 0.20) + (온라인강좌 조회수 × 0.20)</em>
					<br/>
					<em>* 모든 가중치의 합은 1이 되어야 함</em><br/>
					<em>*'대출수', '예약수'는 전자책과 일부 오디오북에만 존재하며 '오디오북 조회수'는 일부 오디오북, '온라인강의 조회수'는 온라인강의에만 존재함</em>
				</div>
         	</td>
       	</tr>
	</tbody>
</table>
</form:form>
<br/>
<table class="type1 center">
<colgroup>
	<col width="50"/>
	<col width="80"/>
	<col width="100"/>
	<col width="200"/>
	<col width="150"/>
	<col width="100"/>
	<col width="100"/>
	<col width="80"/>
	<col width="50"/>
	<col width="50"/>
	<col width="50"/>
	<col width="50"/>
	<col width="50"/>
	<col width="50"/>
	<col width="50"/>
	<col/>
</colgroup>
<thead>
	<tr>
		<th>순위</th>
		<th>내부등록번호</th>
		<th>카테고리</th>
		<th>책제목</th>
		<th>저자</th>	
		<th>출판사</th>
		<th>도서관명</th>
		<th>공급사</th>
		<th>인기지수</th>
		<th>대출수</th>
		<th>예약수</th>
		<th>서평수</th>
		<th>추천수</th>
		<th>오디오북 조회수</th>
		<th>온라인강좌 조회수</th>
		<th>기능</th>
	</tr>
</thead>
<tbody>
	<c:if test="${fn:length(bestBookList) < 1}">
		<tr style="height:100%">
			<td colspan="19" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
		</tr>
	</c:if>
	<c:forEach var="i" varStatus="status" items="${bestBookList}">
	<tr<c:if test="${status.index >= 7}"> style="background-color: #AAAAAA"</c:if>>
		<td>${status.index+1}</td>
		<td>${i.book_idx}</td>
		<td class="left">${i.parent_name} <br/> &gt;&gt; ${i.cate_name}</td>
		<td>${i.book_name}</td>
		<td>${i.author_name}</td>
		<td>${i.book_pubname}</td>
		<td>${i.library_name}</td>
		<td>${i.comp_name}</td>
		<td>${i.rank_index}</td>
		<td>${i.lend_cnt}</td>
		<td>${i.reserve_cnt}</td>
		<td>${i.comment_cnt}</td>
		<td>${i.recommend_cnt}</td>
		<td>${i.audio_view_cnt}</td>
		<td>${i.elearn_view_cnt}</td>
		<td>
			<c:if test="${i.book_idx ne 0}">
			<a href="#" class="btn deletebestbook" data-book_idx="${i.book_idx}">제외</a>
			</c:if>
			<c:if test="${i.book_idx eq 0}">
			<input type="text" id="new_book_idx" class="text"> <a href="#" class="btn addbestbook" data-bestbook_idx="${i.bestbook_idx}">등록</a>
			</c:if>
			<c:if test="${!status.first}">
			<a href="#" class="btn raisebestbook" data-book_idx="${i.book_idx}" data-bestbook_idx="${i.bestbook_idx}">위로</a>
			</c:if>
			<c:if test="${!status.last}">
			<a href="#" class="btn lowerbestbook" data-book_idx="${i.book_idx}" data-bestbook_idx="${i.bestbook_idx}">아래로</a>
			</c:if>
		</td>
	</tr>
	</c:forEach>
</tbody>
</table>
<br/>
<form:form id="bookListForm"  modelAttribute="bestBook" action="main_index.do" >
<c:if test="${!member.admin}">
	<form:hidden id="homepage_id_1" path="homepage_id"/>
</c:if>
<c:if test="${member.admin}">
	<div class="search">
		<fieldset>
			<label class="blind">검색</label>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/type_select.jsp">
				<jsp:param name="noADO" value="Y"/>
			</jsp:include>
<%-- 			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/primary_category_select.jsp"/> --%>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/provider_select.jsp"/>
			<jsp:include page="/WEB-INF/views/app/cms/module/elib/common/library_select.jsp"/>
		</fieldset>
	</div>
</c:if>

	<div class="infodesk">
		검색 결과 : 총 <fmt:formatNumber value="${bookListCnt}" pattern="#,###" />건
		<form:select path="sortField" class="selectmenu">
			<option value="">정렬 순서 선택</option>
			<option value="" <c:if test="${book.sortField eq ''}">selected="selected"</c:if>>인기지수순</option>
			<option value="lend_cnt" <c:if test="${book.sortField eq 'lend_cnt'}">selected="selected"</c:if>>대출수순</option>
			<option value="reserve_cnt" <c:if test="${book.sortField eq 'reserve_cnt'}">selected="selected"</c:if>>예약수순</option>
			<option value="comment_cnt" <c:if test="${book.sortField eq 'comment_cnt'}">selected="selected"</c:if>>서평수순</option>
			<option value="recommend_cnt" <c:if test="${book.sortField eq 'recommend_cnt'}">selected="selected"</c:if>>추천수순</option>
			<option value="book_idx" <c:if test="${book.sortField eq 'book_idx'}">selected="selected"</c:if>>내부등록번호</option>
			<option value="book_name" <c:if test="${book.sortField eq 'book_name'}">selected="selected"</c:if>>책제목순</option>
			<option value="author_name" <c:if test="${book.sortField eq 'author_name'}">selected="selected"</c:if>>저자순</option>
		</form:select>
		<form:select path="rowCount" class="selectmenu" style="width:120px;">
			<form:option value="10">10개씩 보기</form:option>
			<form:option value="25">25개씩 보기</form:option>
			<form:option value="50">50개씩 보기</form:option>
			<form:option value="100">100개씩 보기</form:option>
			<form:option value="200">200개씩 보기</form:option>
		</form:select>
	</div>
	<table class="type1 center">
		<colgroup>
			<col width="80"/>
			<col width="100"/>
			<col width="200"/>
			<col width="150"/>
			<col width="100"/>
			<col width="100"/>
			<col width="80"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col width="50"/>
			<col/>
		</colgroup>
		<thead>
			<tr>
				<th>내부등록번호</th>
				<th>카테고리</th>
				<th>책제목</th>
				<th>저자</th>
				<th>출판사</th>
				<th>도서관명</th>
				<th>공급사</th>
				<th>인기지수</th>
				<th>대출수</th>
				<th>예약수</th>
				<th>서평수</th>
				<th>추천수</th>
				<th>오디오북 조회수</th>
				<th>온라인강좌 조회수</th>
<%-- 				<th>기능</th> --%>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(bookList) < 1}">
				<tr style="height:100%">
					<td colspan="16" style="background:#f8fafb;">조회된 자료가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="i" varStatus="status" items="${bookList}">
				<tr>
					<td>${i.book_idx}</td>
					<td class="left">${i.parent_name} <br/> &gt;&gt; ${i.cate_name}</td>
					<td>${i.book_name}</td>
					<td>${i.author_name}</td>
					<td>${i.book_pubname}</td>
					<td>${i.library_name}</td>
					<td>${i.comp_name}</td>
					<td>${i.rank_index}</td>
					<td>${i.lend_cnt}</td>
					<td>${i.reserve_cnt}</td>
					<td>${i.comment_cnt}</td>
					<td>${i.recommend_cnt}</td>
					<td>${i.audio_view_cnt}</td>
					<td>${i.elearn_view_cnt}</td>
<%--
					<td>
						<c:if test="${authC}">
							<a href="#" class="btn addbestbook" data-book_idx="${i.book_idx}">베스트</a>
						</c:if>
					</td>
--%>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#bookListForm"/>
		<jsp:param name="pagingUrl" value="main_index.do"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
		<fieldset>
			<form:select path="search_type" class="selectmenu">
				<form:option value="book_idx">내부등록번호</form:option>
				<form:option value="book_name">책제목</form:option>
				<form:option value="author_name">저자</form:option>
				<form:option value="book_pubname">출판사</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text" cssStyle="width:200px;"/>
			<button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
</form:form>
	
<div id="dialog-1" class="dialog-common" title="콘텐츠 관리"></div>