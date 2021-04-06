<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	var $form = $('#marathonRecord');

	$('a#write').on('click', function(e) {
		e.preventDefault();
		var date = new Date();
		<c:if test="${checkEnd eq true}">
			alert('독서마라톤대회가 종료되었습니다.');
			return false;
		</c:if>
		<c:if test="${checkNoStart eq true}">
			alert('독서마라톤대회 시작 전입니다.');
			return false;
		</c:if>
		

		var url = 'edit.do';
		$('input#editMode').val('ADD');
		doGetLoad(url, serializeCustom($form));
	});
	
	$('a.record').on('click', function(e) {
		e.preventDefault();
		var url = 'edit.do';
		$('input#editMode').val('MODIFY');
		$('input#record_idx').val($(this).attr('keyValue'));
		doGetLoad(url, serializeCustom($form));
	});
	
	$('a#rowCountSelect').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		var url = 'index.do';
		doGetLoad(url, serializeCustom($form));
	});
	
	$('a#checkAll').on('click', function(e) {
		e.preventDefault();
		if($('input:checkbox[name = record_idx_arr]').eq(0).is(':checked')){
			for(var i = 0; i < $('input:checkbox[name = record_idx_arr]').length; i++){
				$('input:checkbox[name = record_idx_arr]').eq(i).prop('checked', false);
			}
		}else{
			for(var i = 0; i < $('input:checkbox[name = record_idx_arr]').length; i++){
				$('input:checkbox[name = record_idx_arr]').eq(i).prop('checked', true);
			}
		}
	});
	
	$('a#deleteSelected').on('click', function(e) {
		e.preventDefault();
		$('#editMode').val('DELETE');
		if(confirm('선택한 일지를 삭제하시겠습니까?')){
			var checkboxarr = $('input:checkbox[name = record_idx_arr]:checked');
			var read_page_count_arr = new Array();
			checkboxarr.each(function(i) {
				var tr = checkboxarr.parent().parent().eq(i);
				var td = tr.children();
				var read_page_count_replace = td.eq(6).text().replace(/,/gi, "");
				read_page_count_arr.push(read_page_count_replace);
			});
			$('input#read_page_count_arr').val(read_page_count_arr);

			$('form#marathonRecord').attr('action', 'save.do');
			if(doAjaxPost($('form#marathonRecord'))){
				location.reload();
			}
		}
	});
	
	$('button#search_btn').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('form#marathonRecord')));
	});
});
</script>
<style>
	div.search {border: 0px;background: 0;}

	@media (max-width: 430px) and (min-width: 0px) {
		table.bbs th, table.bbs td{display:table-cell;}
	}
</style>
<form:form modelAttribute="marathonRecord" action="index.do" method="GET" onsubmit="return false;">
	<form:hidden path="homepage_id"/>
	<form:hidden path="contest_idx"/>
	<form:hidden path="contest_type_idx"/>
	<form:hidden path="applicant_idx"/>
	<form:hidden path="record_idx"/>
	<form:hidden path="editMode"/>
	<form:hidden path="menu_idx"/>
	<form:hidden path="read_page_count_arr"/>

	<div class="wrapper-bbs">
		<div class="infodesk">
			<div class="button btn-group inline">
				<span class="bbs-result">
					전체 <b>${paging.totalDataCount}</b>개
				</span>
				<form:select path="rowCount" class="selectmenu new_select_box" title="보기 개수 선택">
					<form:option value="10">10개씩 보기</form:option>
					<form:option value="20">20개씩 보기</form:option>
					<form:option value="30">30개씩 보기</form:option>
					<form:option value="40">40개씩 보기</form:option>
					<form:option value="50">50개씩 보기</form:option>
				</form:select>
				<a href="#" id="rowCountSelect" class="btn btn1">이동</a>
			</div>
		</div>
		<div class="rsv-info"></div>
		<div class="auto-scroll table-wrap">
			<table class="bbs center">
				<thead>
					<tr>
						<th>선택</th>
						<th>번호</th>
						<th>이름</th>
						<th>도서명</th>
						<th>날짜</th>
						<th>분류번호</th>
						<th>읽은쪽수</th>
						<th>누적쪽수</th>
						<th>도서관명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${marathonRecordList}" var="i" varStatus="status">
						<tr>
							<td><form:checkbox path="record_idx_arr" value="${i.record_idx}"/></td>
							<td>${status.count}</td>
							<td>${i.member_name}</td>
							<td style="width:30%;"><a href="#" keyValue="${i.record_idx}" class="record">${i.book_name}</a></td>
							<td><fmt:formatDate value="${i.record_date}" pattern="yyyy.MM.dd"/></td>
							<td>${i.book_type}</td>
							<td><fmt:formatNumber value="${i.read_page_count}" pattern="#,###"/></td>
							<c:choose>
								<c:when test="${status.count eq 1}">
									<c:set var="read_page_count_total_value" value="${read_page_count_total}"/>
									<c:set var="read_page_count_total_pre" value="${i.read_page_count}"/>
								</c:when>
								<c:otherwise>
									<c:set var="read_page_count_total_value" value="${read_page_count_total_value - read_page_count_total_pre}"/>
									<c:set var="read_page_count_total_pre" value="${i.read_page_count}"/>
								</c:otherwise>
							</c:choose>
							<td><fmt:formatNumber value="${read_page_count_total_value}" pattern="#,###"/></td>
							<td style="width:15%;">
								<c:choose>
									<c:when test="${i.book_resources == '100'}">
										공공도서관(달서가족문화도서관)
									</c:when>
									<c:when test="${i.book_resources == '200'}">
										공공도서관(달서구립도원도서관)
									</c:when>
									<c:when test="${i.book_resources == '300'}">
										공공도서관(달서어린이도서관)
									</c:when>
									<c:when test="${i.book_resources == '400'}">
										공공도서관(달서영어도서관)
									</c:when>
									<c:when test="${i.book_resources == '500'}">
										공공도서관(도원도서관)
									</c:when>
									<c:when test="${i.book_resources == '600'}">
										공공도서관(본리도서관)
									</c:when>
									<c:when test="${i.book_resources == '700'}">
										공공도서관(성서도서관)
									</c:when>
									<c:when test="${i.book_resources == '800'}">
										구입도서
									</c:when>
									<c:when test="${i.book_resources == '900'}">
										소장도서
									</c:when>
									<c:otherwise>
										${i.book_resources}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(marathonRecordList) < 1}">
						<tr>
							<td colspan="9" class="dataEmpty first last td1">등록된 일지가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="button bbs-btn right">
			<a href="#" class="btn checkAll" id="checkAll"><span>전체 선택/해제</span></a>
			<a href="#" class="btn deleteSelected" id="deleteSelected"><i class="fa fa-trash-o"></i><span>선택 게시글 삭제</span></a>
			<a href="#" class="btn btn1 write" id="write"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#marathonRecord"/>
	</jsp:include>
	
	<div class="search txt-center" style="margin-top:25px;">
		<fieldset>
			<form:select path="search_type" cssClass="selectmenu new_select_box">
				<form:option value="book_name">도서명</form:option>
				<form:option value="book_journals">감상문내용</form:option>
			</form:select>
			<form:input path="search_text" cssClass="text new_text01" cssStyle="width:200px;"/>
			<button id="search_btn" style="background-color:#2c75cb;border-color:#1962ba;background-image:none;padding:7px 10px;"><i class="fa fa-search"></i><span>검색</span></button>
		</fieldset>
	</div>
	
</form:form>