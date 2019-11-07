<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/container.css">
<script type="text/javascript">
$(function(){

	$('a.modifyBtn').on('click', function(e) {
		e.preventDefault();
		$('#dialog-1').load('edit.do?editMode=MODIFY&r_no='+$(this).attr('keyValue'), function( response, status, xhr ) {
			$('#dialog-1').dialog('open');
		});

	});

	$('a#searchBtn').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('index.do', serializeCustom($('#bookDream')));
	});

	$('a#excelDownloadBtn').on('click', function(e) {
		alert('책 가격을 가져오기 위한 기능으로 인해 수 분 정도의 시간이 소요됩니다.');
		$('form#bookDream').attr('action', 'excelDownload.do');
		$('form#bookDream').submit();
	}); 
	
	$('a#csvDownloadBtn').on('click', function(e) {
		alert('책 가격을 가져오기 위한 기능으로 인해 수 분 정도의 시간이 소요됩니다.');
		$('form#bookDream').attr('action', 'csvDownload.do');
		$('form#bookDream').submit();
	});

	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});

	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});

	$('input#allState').on('click', function() {
		$('input.search_state').prop('checked', $(this).is(':checked'));
	});

	$('input#chkAll').on('click', function() {
		if($('input#chkAll').prop("checked")) {
			$('input[name="chkOne"]').prop("checked", true);
		} else {
			$('input[name="chkOne"]').prop("checked", false);
		}
	});

	$('a#chkAll_save').on('click', function() {
		if ($('input[name="chkOne"]:checked').length < 1) {
			alert('선택된 항목이 없습니다.');
		} else {
			if(confirm("상태를 일괄수정하시겠습니까?")) {
				$('#bookDream').attr('action', 'batch.do');
				doAjaxPost($('#bookDream'));
			}
		}
	});


});
</script>

<h2>신청내역</h2>
<form:form modelAttribute="bookDream" action="excelDownload.do" method="post">
	<ul class="con02 lpad01 lbook">
		<li>
			<span>도서관 :</span>
			<form:checkbox path="search_lib" value="andong" label="안동"/>
			<form:checkbox path="search_lib" value="yongsang" label="용상"/>
			<form:checkbox path="search_lib" value="pungsan" label="풍산"/>
		</li>
		<li>
			<span>상태  :</span>
			<input type="checkbox" id="allState" checked="checked" ><label for="allState">전체</label> &nbsp;
			<form:checkbox path="search_state" class="search_state" value="0" label="대기"/>
			<form:checkbox path="search_state" class="search_state" value="10" label="신청"/>
			<form:checkbox path="search_state" class="search_state" value="13" label="재고있음"/>
			<form:checkbox path="search_state" class="search_state" value="15" label="주문중"/>
			<form:checkbox path="search_state" class="search_state" value="17" label="입고완료"/>
			<form:checkbox path="search_state" class="search_state" value="20" label="구매확정"/>
			<form:checkbox path="search_state" class="search_state" value="30" label="반납"/>
			<form:checkbox path="search_state" class="search_state" value="40" label="환불"/>
			<form:checkbox path="search_state" class="search_state" value="50" label="정산완료"/>
			<form:checkbox path="search_state" class="search_state" value="-10" label="회원취소"/>
			<form:checkbox path="search_state" class="search_state" value="-20" label="개인소장"/>
			<form:checkbox path="search_state" class="search_state" value="-90" label="관리취소"/>
		</li>
		<li><span>기간 :</span>
			<form:select path="search_date">
				<form:option value="r_created">신청일자</form:option>
				<form:option value="r_payed">구매일자</form:option>
				<form:option value="r_return">반환일자</form:option>
				<form:option value="r_refund">환불일자</form:option>
				<form:option value="r_calc">정산일자</form:option>
			</form:select>
			<form:input path="start_date" class="text ui-calendar" readonly="true"/>
			<form:input path="end_date" class="text ui-calendar" readonly="true"/>
			<span>정렬 :</span>
			<form:select path="sortField">
				<form:option value="r_created" label="신청일"></form:option>
				<form:option value="r_return" label="반납일"></form:option>
				<form:option value="r_return_close" label="마감일"></form:option>
				<form:option value="r_payed" label="구매일"></form:option>
			</form:select>
			<form:select path="sortType">
				<form:option value="ASC" label="오름차순"></form:option>
				<form:option value="DESC" label="내림차순"></form:option>
			</form:select>


			<span>검색어 :</span>
			<form:select path="search_type">
				<form:option value="r_name" label="신청자"></form:option>
				<form:option value="r_title" label="도서명"></form:option>
				<form:option value="r_author" label="저자"></form:option>
				<form:option value="r_hp" label="전화번호"></form:option>
			</form:select>
			<form:input path="search_text" cssClass="text"/>
			<a class="btn btn1 btn-small btn-inverse" id="searchBtn">
				<span>검색</span>
			</a>
			<a class="btn btn2 btn-small btn-inverse" id="excelDownloadBtn">
				<span>엑셀저장</span>
			</a>
			<a class="btn btn2 btn-small btn-inverse" id="csvDownloadBtn">
				<span>CSV저장</span>
			</a>
		</li>
		<li>
			<span>상태일괄수정  :</span>
			<form:select path="batch">
				<form:option value="0" label="대기">대기</form:option>
				<form:option value="10" label="신청">신청</form:option>
				<form:option value="13" label="재고있음">재고있음</form:option>
				<form:option value="15" label="주문중">주문중</form:option>
				<form:option value="17" label="입고완료">입고완료</form:option>
				<form:option value="20" label="구매확정">구매확정</form:option>
				<form:option value="30" label="반납">반납</form:option>
				<form:option value="40" label="환불">환불</form:option>
				<form:option value="50" label="정산완료">정산완료</form:option>
				<form:option value="-10" label="회원취소">회원취소</form:option>
				<form:option value="-20" label="개인소장">개인소장</form:option>
				<form:option value="-90" label="관리취소">관리취소</form:option>
			</form:select>
			<a class="btn btn2" id="chkAll_save">
				<span>선택된 항목 일괄수정</span>
			</a>
		</li>
	</ul>


<br/>

<table class="tstyle lbook" summary="서점명, 대표자, 전화번호, 등록일, 관리에 대해 서점관리 부분을 안내하는 표입니다.">
	<caption class="blind">서점관리</caption>
	<colgroup>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th><label for="chkAll">No</label>&nbsp;<input type="checkbox" id="chkAll"></th>
			<th>이미지</th>
			<th>상태(서점명)</th>
			<th class="left">
				신청도서(도서명 / 저자 / 출판사 / 출판일시 / 가격)
			</th>
			<th>
				신청자
			</th>
			<th>
				구매<br />
				(방법 / 구매가)
			</th>
			<th>
				일자<br />
				(신청 / 구매)
			</th>
<!-- 			<th class="left"> -->
<!-- 				신청도서 (<a -->
<!-- 				href="/book/admin/request/list.php?odby=title&odsc=desc&page=1">도서명</a> -->
<!-- 				/ <a -->
<!-- 				href="/book/admin/request/list.php?odby=author&odsc=desc&page=1">저자</a> -->
<!-- 				/ <a -->
<!-- 				href="/book/admin/request/list.php?odby=publisher&odsc=desc&page=1">출판사</a> -->
<!-- 				/ <a -->
<!-- 				href="/book/admin/request/list.php?odby=pubdate&odsc=desc&page=1">출판일시</a> -->
<!-- 				/ <a href="/book/admin/request/list.php?odby=price&odsc=desc&page=1">가격</a>) -->
<!-- 			</th> -->
<!-- 			<th><a -->
<!-- 				href="/book/admin/request/list.php?odby=name&odsc=desc&page=1">신청자</a></th> -->
<!-- 			<th>구매<br/>(<a -->
<!-- 				href="/book/admin/request/list.php?odby=pay_type&odsc=desc&page=1">방법</a> -->
<!-- 				/ <a href="/book/admin/request/list.php?odby=pay&odsc=desc&page=1">구매가</a>) -->
<!-- 			</th> -->
<!-- 			<th>일자<br/>(<a -->
<!-- 				href="/book/admin/request/list.php?odby=created&odsc=asc&page=1">신청▼</a> -->
<!-- 				/ <a href="/book/admin/request/list.php?odby=payed&odsc=desc&page=1">구매</a>) -->
<!-- 			</th> -->
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${bookDreamList}" var="i" varStatus="status">
		<tr>
			<td>
				<input type="checkbox" id="chk${status.count}" name="chkOne" value="${i.r_no}">
				<label for="chk${status.count}">${paging.listRowNum - status.index}</label>
			</td>
			<td><img src="${i.r_image}" /></td>
			<td>
				<p class="stay">
					<c:choose>
						<c:when test="${i.r_state eq '0'}">대기</c:when>
						<c:when test="${i.r_state eq '10'}">신청</c:when>
						<c:when test="${i.r_state eq '13'}">재고있음</c:when>
						<c:when test="${i.r_state eq '15'}">주문중</c:when>
						<c:when test="${i.r_state eq '17'}">입고완료</c:when>
						<c:when test="${i.r_state eq '20'}">구매확정</c:when>
						<c:when test="${i.r_state eq '30'}">반납</c:when>
						<c:when test="${i.r_state eq '40'}">환불</c:when>
						<c:when test="${i.r_state eq '50'}">정산완료</c:when>
						<c:when test="${i.r_state eq '-10'}">회원취소</c:when>
						<c:when test="${i.r_state eq '-20'}">개인소장</c:when>
						<c:when test="${i.r_state eq '-90'}">관리취소</c:when>
					</c:choose><br/>
					<c:choose>
						<c:when test="${i.store_no eq '1'}">(강남서점)</c:when>
						<c:when test="${i.store_no eq '2'}">(교학사)</c:when>
						<c:when test="${i.store_no eq '3'}">(세종서적)</c:when>
						<c:when test="${i.store_no eq '4'}">(현대서림)</c:when>
						<c:when test="${i.store_no eq '5'}">(느낌표)</c:when>
						<c:when test="${i.store_no eq '8'}">(종로서적)</c:when>
					</c:choose><br/>
					<c:choose>
						<c:when test="${i.r_src eq 'pungsan'}">[풍산]</c:when>
						<c:when test="${i.r_src eq 'yongsang'}">[용상]</c:when>
						<c:otherwise>[안동]</c:otherwise>
					</c:choose>
				</p>
			</td>
			<td class="left fb">
				${i.r_title }<br />
				저자 : ${i.r_author } / 가격 : <fmt:formatNumber value="${i.r_price }" pattern="#,###"/><br />
				출판사 : ${i.r_publisher } / 출판일 : ${i.r_pubdate }<br />
				ISBN : ${i.r_isbn }
			</td>
			<td>
				${i.r_name }<br/>
				${i.r_hp }<br/>
				${i.r_email }
			</td>
			<td>
				<c:choose>
					<c:when test="${i.r_pay_type eq 'cash'}">현금</c:when>
					<c:when test="${i.r_pay_type eq 'card'}">카드</c:when>
				</c:choose><br/>
				<c:if test="${i.r_pay > 0}">
				<fmt:formatNumber value="${i.r_pay}" pattern="#,###"/>
				</c:if>
			</td>
			<td class="nowrap">
				<p><fmt:formatDate value="${i.r_created}" pattern="yyyy-MM-dd"/></p>
				<c:if test="${i.r_state > 10}">
					<c:if test="${i.r_payed ne null}">
					<p>구매:<fmt:formatDate value="${i.r_payed}" pattern="yyyy-MM-dd"/></p>
					</c:if>
					<c:if test="${i.r_return ne null}">
					<p>반납:<fmt:formatDate value="${i.r_return}" pattern="yyyy-MM-dd"/></p>
					</c:if>
					<c:if test="${i.r_return_close ne null}">
					<p>마감:<fmt:formatDate value="${i.r_return_close}" pattern="yyyy-MM-dd"/></p>
					</c:if>
				</c:if>
			</td>
			<td><a class="btn btn-small modifyBtn" href="#" keyValue="${i.r_no}">수정</a></td>
		</tr>
		</c:forEach>
		<c:if test="${fn:length(bookDreamList) < 1 }">
		<tr>
			<td colspan="8">조회된 결과가 없습니다.</td>
		</tr>
		</c:if>
	</tbody>
</table>
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookDream"/>
</jsp:include>
</form:form>
<div id="dialog-1" class="dialog-common" title="신청내역 수정">
</div>
