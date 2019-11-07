<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<h2>새 책 드림 서비스 신청내역</h2>

<div id="request_form_list" style="_height:400px;min-height:400px;">
	<c:forEach items="${bookDreamList}" var="i" varStatus="status">
	<div class="request_box">
		<p class="image"><img src="${i.r_image}" /></p>
		<div class="pdl120">
			<h4>
				<c:choose>
					<c:when test="${i.r_src eq 'pungsan'}">[풍산]</c:when>
					<c:when test="${i.r_src eq 'yongsang'}">[용상]</c:when>
					<c:otherwise>[안동]</c:otherwise>
				</c:choose>
				${i.r_title}
			</h4>
			<ul class="con01">
				<li>
					저자 : ${i.r_author }/ 
					가격 : <fmt:formatNumber value="${i.r_price}" pattern="#,###"/> 원 /
					출판사 : ${i.r_publisher } /
					<fmt:parseDate var="pubDate" value="${i.r_pubdate}" pattern="yyyyMMdd"/>
					출판일 : <fmt:formatDate value="${pubDate}" pattern="yyyy-MM-dd"/>				
				</li>
			</ul>
			<ul class="con02">
				<c:forEach items="${i.innerList}" var="j" varStatus="statusJ">
				<li>
					${statusJ.count}. 
					<span class="state${j.r_state >= 40 ? ' top' : (j.r_state >= 10 ? ' top' : '')}">
					${j.r_state >= 40 ? '완료' : (j.r_state >= 10 ? '이용중' : '취소')}
					</span> 
					<span class="name">${fn:substring(j.r_name,0,1)}*${fn:substring(j.r_name,2,10)}</span> 
					<c:set var="hp" value="${fn:replace(j.r_hp, '-', '')}"></c:set>
					<span class="phone">${fn:substring(hp,0,3)}-****-${fn:substring(hp,7,13)}</span> 
					<span class="date">신청일 : <fmt:formatDate value="${j.r_created}" pattern="yyyy-MM-dd"/> </span>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	</c:forEach>
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
<form:form modelAttribute="bookDream" action="requestList.do" onsubmit="return false;">
<form:hidden path="viewPage"/>
</form:form>	
<script>
$(function() {	
	$('div.pagenation a').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val($(this).attr('keyValue'));
		doGetLoad('requestList.do', $('form#bookDream').serialize());
	});	
});
</script>