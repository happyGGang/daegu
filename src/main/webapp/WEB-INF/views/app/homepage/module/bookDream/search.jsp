<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag"	uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form:form modelAttribute="bookDream" id="requestForm" action="requestForm2.do">
<form:hidden path="isbn"/>
</form:form>
	<c:choose>
		<c:when test="${fn:length(naverResult) < 1}">
	<div class="search_result nodata">검색된 도서가 없습니다.</div>
		</c:when>
		<c:otherwise>
	<p class="search_result">
		<span class="red fb">"${bookDream.search_text}"</span>에 대한 <span class="fb"><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </span>개의
		검색 결과입니다.
	</p>
	<ul class="item_list">
		<c:choose>
			<c:when test="${naverResult.rss.channel.total eq '1'}">
		<li class="item">
			<ul id="${naverResult.rss.channel.item.isbn}">
				<li class="image"><img src="${naverResult.rss.channel.item.image}"></li>
				<li class="title" id="0">${naverResult.rss.channel.item.title}</li>
				<li class="author">저자 : ${fn:substring(naverResult.rss.channel.item.author,0,10)}<c:if test="${fn:length(naverResult.rss.channel.item.author) > 10}">...</c:if> / 가격 : <fmt:formatNumber value="${naverResult.rss.channel.item.price}" pattern="#,###"/>원</li>
				<jsp:useBean id="toDay1" class="java.util.Date"></jsp:useBean>
				<fmt:formatDate var="toDate1" value="${toDay1}" pattern="yyyyMMdd"/>

				<c:catch var="e1">
				<fmt:parseDate var="pubDate1" value="${naverResult.rss.channel.item.pubdate}" pattern="yyyyMMdd"/>
				</c:catch>
				<c:if test="${e1 != null}">
				<fmt:parseDate var="pubDate1" value="${naverResult.rss.channel.item.pubdate}" pattern="yyyy"/>
				</c:if>

				<fmt:parseDate var="toDate1" value="${toDate1}" pattern="yyyyMMdd"/>
				<c:set value="${(toDate1.time / (1000*60*60*24*30*12)) - (pubDate1.time  / (1000*60*60*24*30*12))}" var="year5"></c:set>
				<li class="price">출판사 : ${naverResult.rss.channel.item.publisher} / 출판일 : <fmt:formatDate value="${pubDate1}" pattern="yyyy-MM-dd"/></li>
				<li class="isbn">ISBN : ${fn:split(naverResult.rss.channel.item.isbn,' ')[0]} ${fn:split(naverResult.rss.channel.item.isbn,' ')[1]}</li>
				<c:choose>
					<c:when test="${fn:split(naverResult.rss.channel.item.isbn,' ')[0] eq '0000053147'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${fn:split(naverResult.rss.channel.item.isbn,' ')[0] eq '60008316333' or fn:split(naverResult.rss.channel.item.isbn,' ')[1] eq '9786000831639'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${fn:split(naverResult.rss.channel.item.isbn,' ')[0] eq '480D170295870'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${fn:split(naverResult.rss.channel.item.isbn,' ')[0] eq '0000061034' or fn:split(naverResult.rss.channel.item.isbn,' ')[1] eq '2090000061031'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${naverResult.rss.channel.item.price >= 50000 }">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${year5 >= 5 }">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${naverResult.rss.channel.item.cantRequest}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${naverResult.rss.channel.item.already}">
				<li class="button"><span class="no">소장도서</span></li>
					</c:when>
					<c:when test="${naverResult.rss.channel.item.already}">
				<li class="button"><span class="no">소장도서</span></li>
					</c:when>
					<c:otherwise>
				<li class="button"><a class="btn btn-small btn-danger request" index="0" keyValue="${fn:split(naverResult.rss.channel.item.isbn,' ')[0]}" href="#">신청하기</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</li>
			</c:when>

			<c:otherwise>
		<c:forEach items="${naverResult.rss.channel.item}" var="i" varStatus="status">
		<li class="item">
			<ul id="${i.isbn}">
				<li class="image"><img src="${i.image}"></li>
				<li class="title" id="${status.index}">${i.title}</li>
				<li class="author">저자 : ${fn:substring(i.author,0,10)}<c:if test="${fn:length(i.author) > 10}">...</c:if> / 가격 : <fmt:formatNumber value="${i.price}" pattern="#,###"/>원</li>
				<jsp:useBean id="toDay" class="java.util.Date"></jsp:useBean>
				<fmt:formatDate var="toDate" value="${toDay}" pattern="yyyyMMdd"/>

				<c:catch var="e2">
				<fmt:parseDate var="pubDate" value="${i.pubdate}" pattern="yyyyMMdd"/>
				</c:catch>
				<c:if test="${e2 != null}">
				<fmt:parseDate var="pubDate" value="${i.pubdate}" pattern="yyyy"/>
				</c:if>

				<fmt:parseDate var="toDate" value="${toDate}" pattern="yyyyMMdd"/>
				<c:set value="${(toDate.time / (1000*60*60*24*30*12)) - (pubDate.time  / (1000*60*60*24*30*12))}" var="year5"></c:set>
				<li class="price">출판사 : ${i.publisher} / 출판일 : <fmt:formatDate value="${pubDate}" pattern="yyyy-MM-dd"/></li>
				<li class="isbn">ISBN : ${fn:split(i.isbn,' ')[0]} ${fn:split(i.isbn,' ')[1]}</li>
				<c:choose>
					<c:when test="${fn:split(i.isbn,' ')[0] eq '0000053147'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${fn:split(i.isbn,' ')[0] eq '60008316333' or fn:split(i.isbn,' ')[1] eq '9786000831639'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${fn:split(i.isbn,' ')[0] eq '480D170295870'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${fn:split(i.isbn,' ')[0] eq '0000061034' or fn:split(i.isbn,' ')[1] eq '2090000061031'}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${i.price >= 50000 }">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${year5 >= 5 }">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${i.cantRequest}">
				<li class="button"><span class="no">신청불가도서</span></li>
					</c:when>
					<c:when test="${i.already}">
				<li class="button"><span class="no">소장도서</span></li>
					</c:when>
					<c:when test="${i.already}">
				<li class="button"><span class="no">소장도서</span></li>
					</c:when>
					<c:otherwise>
				<li class="button"><a class="btn btn-small btn-danger request" index="${status.index}" keyValue="${fn:split(i.isbn,' ')[0]}" href="#">신청하기</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</li>
		</c:forEach>

			</c:otherwise>
		</c:choose>
	</ul>
	<div id="board_paging" class="pageing">
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
		</c:otherwise>
	</c:choose>

<div style="clear: both;"></div>

<script>
	$(function() {
		$('div.images li').on('hover', function() {
			var no = $(this).attr('item_no');
			$('.item-list .item').hide();
			$('.item-list .item-' + no).show();
			$('.item-list .images li').css('border-clor', '#fff');
			$(this).css('border-color', '#ddd');
		}).css({
			'border-clor' : '#fff',
			'float' : 'left'
		});
		$('.item-list .images li').eq(0).mouseover();

		$('div#board_paging a').on('click', function(e) {
			e.preventDefault();
			$('input#viewPage').val($(this).attr('keyValue'));
			var q = encodeURIComponent($('input#search_text').val());
			var url = 'naverSearch.do?search_text='+q+'&viewPage='+$('input#viewPage').val();
			getData(url);
		});

		$('a.request').on('click', function(e) {
			e.preventDefault();
			var idx = $(this).attr('index');
			var title = $('li#'+idx).text();
			if (confirm('\''+title+'\' 새 책 드림 서비스를 등록 하시겠습니까?' )) {
				var $form = $('form#requestForm');
				$('input#isbn').val($(this).attr('keyValue'));
				$('form#requestForm').submit();
			}
		});

	});
</script>
