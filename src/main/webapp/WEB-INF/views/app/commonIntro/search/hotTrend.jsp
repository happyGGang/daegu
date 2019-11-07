<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

	$('div.tabmenu.on > ul > li > a').on('click', function(e) {
		e.preventDefault();

		if(!$(this).parent().hasClass('active')) {
			var $active = $('div.tabmenu.on > ul > li.active');
			var $nonActive = $('div.tabmenu.on > ul > li').not('.active');

			$active.removeClass('active');
			$nonActive.addClass('active');

			$active = $('div.tabCon.active');
			$nonActive = $('div.tabCon').not('.active');

			$active.removeClass('active');
			$active.hide();
			$nonActive.addClass('active');
			$nonActive.show();
		}
	});
});
</script>
<h4><span class="middot"></span>실시간 검색어 순위</h4>
<div style="position: relative;">
	<div class="tabmenu on tab2" style="padding-bottom: 0; position:absolute; top: 0; width: 90px;">
	   <h4 class="blind">탭 구분</h4>
	  <ul>
	    <li class="active" style="width: 100%;"><a href="#tabCon1" style="padding: 8px 31px 9px !important;">일간</a></li>
	  </ul>
	</div>
	<div class="tabCon active" id="tabCon1" style="position: absolute; top: 40px;">
	<h4 class="blind">일간 검색어 순위</h4>
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
	<div class="tabmenu on tab2" style="padding-bottom: 0; position: absolute; top:0; left:90px;">
	  <h4 class="blind">탭 구분</h4>
	  <ul>
	    <li style="width: 100%;"><a href="#tabCon2" style="padding: 8px 31px 9px !important;">주간</a></li>
	  </ul>
	</div>
	<div class="tabCon" id="tabCon2" style="position: absolute; top: 40px; display: none;">
		<h4 class="blind">주간 검색어 순위</h4>
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
</div>