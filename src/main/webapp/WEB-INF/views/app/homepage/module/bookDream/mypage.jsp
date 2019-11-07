<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<h2>새 책 드림 서비스 신청내역</h2>

<div id="request_form_list" style="_height:300px;min-height:300px">
	<table class="tstyle" summary="새 책 드림 신청도서에 대한 도서명, 도서정보 및 신청일, 관리를 나타낸 표입니다.">
		<caption>새 책 드림 서비스 신청내역</caption>
		<thead>
			<tr>
				<th>No</th>
				<th>상태</th>
				<th>신청도서</th>
				<th>신청일</th>
				<th>반납일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${bookDreamList}" var="i" varStatus="status">
			<tr>
				<td>${paging.listRowNum - status.index}</td>
				<td>${i.r_state_nm}</td>
				<td class="tal">
					<strong>${i.r_title}</strong><br />
					저자 : ${i.r_author} / 
					가격 : <fmt:formatNumber value="${i.r_price}" pattern="#,###"/> 원 /
					출판사 : ${i.r_publisher } /
					<fmt:parseDate var="pubDate" value="${i.r_pubdate}" pattern="yyyyMMdd"/>
					출판일 : <fmt:formatDate value="${pubDate}" pattern="yyyy-MM-dd"/>		
				</td>
				<td>
					<fmt:formatDate value="${i.r_created}" pattern="yyyy-MM-dd"/>
					<c:if test="${i.r_state > 10}">
						<c:choose>
							<c:when test="${i.r_payed ne null}">
					<br />구매 : <fmt:formatDate value="${i.r_payed}" pattern="yyyy-MM-dd"/> 
							</c:when>
							<c:otherwise>
					<br />마감 : <fmt:formatDate value="${i.r_created5}" pattern="yyyy-MM-dd"/>
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td>
					<c:if test="${i.r_state > 10 and i.r_payed ne null}">
						<c:choose>
							<c:when test="${i.r_return ne null}">
					<fmt:formatDate value="${i.r_return}" pattern="yyyy-MM-dd"/> 
							</c:when>
							<c:otherwise>
					마감 : <fmt:formatDate value="${i.r_return_close}" pattern="yyyy-MM-dd"/> 
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td>
					<c:if test="${i.r_state >= 0 and i.r_state < 20}">
					<a href="#" class="btn btn-small btnModify" keyValue="${i.r_no}">수정</a>
					<a href="#" class="btn btn-small btnDelete" keyValue="${i.r_no}">취소</a>
					</c:if>
					<c:if test="${i.r_state eq '20' }">
					<a href="#" class="btn btn-small btnHaving btn-inverse" keyValue="${i.r_no}" style="background-color:black; color:white;height: auto !important;">개인소장</a>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(bookDreamList) < 1 }">
			<tr>
				<td colspan="9" height="50">새 책 드림 서비스 신청 내역이 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
</div>
	<div class="pagenation">
		<ul>
		<c:if test="${paging.firstPageNum > 0}">
			<li class='curr'><a href="" class="curr paginate_button previous" keyValue="${paging.firstPageNum}">처음</a></li>
		</c:if>
		<c:if test="${paging.prevPageNum > 0}">
			<li class='curr'><a href="" class="curr paginate_button previous" keyValue="${paging.prevPageNum}">이전</a></li>
		</c:if>	
		<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
		<c:choose>
		<c:when test="${i eq paging.viewPage}">	
			<li class='curr this'><a href="" class="curr this paginate_button current" keyValue="${i}">${i}</a></li>
		</c:when>
		<c:otherwise>
			<li class='curr'><a href="" class="curr paginate_button" keyValue="${i}">${i}</a></li>
		</c:otherwise>
		</c:choose>
		</c:forEach>
		<c:if test="${paging.nextPageNum > 0}">
			<li class='curr'><a href="" class="curr paginate_button next" keyValue="${paging.nextPageNum}">다음</a></li>
		</c:if>
		<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
			<li class='curr'><a href="" class="curr paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a></li>
		</c:if>
		</ul>
	</div>
<form:form modelAttribute="bookDream" action="mypage.do" onsubmit="return false;">
<form:hidden path="viewPage"/>
</form:form>	
<form:form modelAttribute="bookDream" id="bookDreamCancelForm" action="modify.do" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="r_no"/>
</form:form>	
<script>
$(function() {	
	$('div.pagenation a').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val($(this).attr('keyValue'));
		doGetLoad('mypage.do', $('form#bookDream').serialize());
	});	
	$('.btnModify').bind('click', function(e) {
		var param = 'r_no='+$(this).attr('keyValue');
		doGetLoad('modifyForm.do', param);
	});
	$('.btnDelete').bind('click', function(e) {
		e.preventDefault();
		if (confirm("취소처리되면 다시 복구할 수 없습니다.\n\n취소처리 하시겠습니까?")) {
			$('input#editMode').val('CANCEL');
			$('input#r_no').val($(this).attr('keyValue'));
			doAjaxPost($('form#bookDreamCancelForm'));
		}
	});
	$('.btnHaving').bind('click', function(e) {
		e.preventDefault();
		if (confirm("소장처리되면 다시 복구할 수 없으며, 도서관에 반납이 불가합니다.\n\n소장하시겠습니까?")) {
			$('input#editMode').val('HAVE');
			$('input#r_no').val($(this).attr('keyValue'));
			doAjaxPost($('form#bookDreamCancelForm'));
		}
	});
});
$(function() {
	
});
</script>