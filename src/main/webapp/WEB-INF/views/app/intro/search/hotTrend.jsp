<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function() {
	$('a.trendSearch').on('click', function(e) {
		e.preventDefault();
		$('input#sub_search1').prop('checked', false);
		$('#librarySearch #allBookListStr').val('');
		$('#librarySearch #search_type').val('L_TITLEAUTHOR');
		$('#librarySearch #search_text').val($(this).text().trim());
     	$('#librarySearch #do-search').click();
	});
	$('div.tabmenu.on > ul > li > a').on('click',function(e){
		e.preventDefault();
		if(!($(this).parent().hasClass('active'))){
		    $(this).parents('ul').children().removeClass('active');
		    $(this).parent().parent().parent().parent().children('div.tabCon').removeClass('active');
		    $(this).parent().addClass('active');
		    var activeTab = $(this).attr('href');
		    $(activeTab).addClass('active');
		}
	});
});
</script>
<h4>실시간 검색어 순위</h4>
<div class="tabmenu on tab2" style="padding-bottom: 0;">
  <ul>
    <li class="active" style="width: 50%;"><a href="#tabCon1" style="padding: 20px 30px 18px !important; font-size: 20px; text-align: center;">일간</a></li>
    <li style="width: 50%;"><a href="#tabCon2" style="padding: 20px 30px 18px !important; font-size: 20px; text-align: center;">주간</a></li>
  </ul>
</div>
<div class="tabCon active" id="tabCon1">
	<ul style="padding-top: 10px;">
		<c:forEach items="${hotTrendDailyList.data}" var="i" varStatus="status">
		<li style="padding-bottom: 2px;">
			<span>${i.IDX}</span>
			<span style="padding-left: 10px;">
				<a href="#" class="trendSearch" alt="${fn:trim(i.WORD)}" title=">${fn:trim(i.WORD)}">
					<c:choose>
					<c:when test="${fn:length(fn:trim(i.WORD)) > 10}">${fn:substring(fn:trim(i.WORD),0,10)}...</c:when>
					<c:otherwise>${fn:trim(i.WORD)}</c:otherwise>
					</c:choose>
				</a>
			</span>
	<%-- 		<span style="float: right;">${i.HIT_CNT}</span> --%>
		</li>
		</c:forEach>
	</ul>
</div>
<div class="tabCon" id="tabCon2">
	<ul style="padding-top: 10px;">
		<c:forEach items="${hotTrendWeeklyList.data}" var="i" varStatus="status">
		<li style="padding-bottom: 2px;">
			<span>${i.IDX}</span>
			<span style="padding-left: 10px;">
				<a href="#" class="trendSearch" alt="${fn:trim(i.WORD)}" title=">${fn:trim(i.WORD)}">
					<c:choose>
					<c:when test="${fn:length(fn:trim(i.WORD)) > 10}">${fn:substring(fn:trim(i.WORD),0,10)}...</c:when>
					<c:otherwise>${fn:trim(i.WORD)}</c:otherwise>
					</c:choose>
				</a>
			</span>
	<%-- 		<span style="float: right;">${i.HIT_CNT}</span> --%>
		</li>
		</c:forEach>
	</ul>
</div>
