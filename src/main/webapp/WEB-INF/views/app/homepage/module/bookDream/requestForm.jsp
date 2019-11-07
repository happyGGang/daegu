<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="loading_img" style="display:none;"><img src="/resources/homepage/bookdream/img/loading.gif"><span>loading...</div>

<h2>새 책 드림 신청하기</h2>

<div id="notice">
<!-- 	<h3>공지사항</h3> -->
<!-- 	<ul class="con01"> -->
<!-- 	<li><a href="#">2015년 4월부터 12월까지 새 책 드림 dream 서비스를 실시합니다.</a><span>2015.03.25</span></li> -->
<!-- 	<li><a href="#">참여 가능 도서관 안내 : 안동도서관 본관 , 용상분관, 풍산분관입니다.</a><span>2015.03.25</span></li> -->
<!-- 	<li><a href="#">새 책 드림 Dream 서비스 목적 및 필요성에 대한 안내입니다.</a><span>2015.03.25</span></li> -->
<!-- 	<li><a href="#">도서구입 제외도서 목록</a><span>2015.03.25</span></li> -->
<!-- 	</ul> -->


	<h3>도서를 먼저 검색하신 후 검색결과에서 신청가능한 도서를 확인하여 신청하세요.</h3>
	<h3>아래의 <strong style="color:red;display:inline;">"구입 제외 도서"</strong> 안내를 꼭 확인하시고 신청을 해 주세요.</h3>

</div>

<form:form modelAttribute="bookDream" id="frmSearch" action="naverSearch.do">
	<form:input path="search_text"/>
	<form:hidden path="viewPage"/>
	<button type="submit" class="btn btn-large btn-success "><span>검색</span></button>
</form:form>

<div id="request_item_list">
</div>

<script>
function number_format(str) {
	str = str + '';
	str = str_reverse(str);
	str = str.replace(/([0-9]{3})/g, '$1,');
	str = str.replace(/[0,]+$/, '');
	str = str_reverse(str);
	return str;
}
function str_reverse(str) {
	var res = '';
	var len = str.length;
	for (var i = 0; i < len; i++) {
		res = str.charAt(i) + '' + res;
	}
	return res;
}

	$(function() {



		$('#frmSearch').bind('submit', function() {
			var obj = $(this);
			var url = obj.attr('action');
			if (!this.search_text.value) {
				alert('검색어를 입력해주세요');
				this.search_text.focus();
				return false;
			}

			var q = encodeURIComponent(this.search_text.value);
			url += '?search_text='+q+'&page=1';
			getData(url);

			return false;
		});
	});

	function getData(url) {
		$('.loading_img').show();
		setTimeout(function() {$('.loading_img').hide(); }, 20000);
		doAjaxLoad('#request_item_list', url);
		$('.loading_img').hide();
// 		$.getJSON(url, function(response) {
// 			console.log(response);
// 			var list = $("<ul class='item_list' />");
// 			var cnt = 0;

// 			for (var k in response.naver.rss.channel.item) {
// 				var o = response.naver.rss.channel.item[k];
// 				var ul = $("<ul id='" + o.isbn + "' />");
// // 				var pubdate = o.pubdate.replace(/^(.{4})(.+)(.{2})$/, '$1.$2.$3');
// 				var pubdate = o.pubdate;
// 				ul.append($("<li class='image'><img src='" + o.image + "' /></li>"));
// 				ul.append($("<li class='title'>" + o.title + "</li>"));
// 				ul.append($("<li class='author'>저자 : " + o.author + " / 가격 : " + number_format(o.price) + "원</li>"));
// 				ul.append($("<li class='price'>출판사 : " + o.publisher + " / 출판일 : " + pubdate + "</li>"));
// 								ul.append($("<li class='isbn'>ISBN : " + o.isbn + "</li>"));
// 				if (o.status == '1') ul.append($("<li class='button'><a class='btn btn-small btn-danger' href='form.php?isbn=" + o.isbn + "'>신청하기</a></li>"));
// 				if (o.status == '0') ul.append($("<li class='button'><a class='btn btn-small btn-inverse' href='form.php?isbn=" + o.isbn + "'>대기자등록</a></li>"));
// 				if (o.status == '-1') ul.append($("<li class='button'><span class='no'>신청불가도서</span></li>"));
// 				$("<li class='item' />").append(ul).appendTo(list);
// 				cnt++;
// 			};

// 			if (!cnt) {
// 				$('#request_item_list').html('<div class="search_result nodata">검색된 도서가 없습니다.</div>');
// 			} else {
// 				$('#request_item_list')
// 						  .html('')
// 						  .html('<p class="search_result"><span class="red fb">"' + $('input#search_text').val() + '"</span>에 대한 <span class="fb">' + number_format(response.total) + '</span>개의 검색 결과입니다.</p>')
// 						  .append(list)
// 						  .append($("<div class='pageing'>" + response.paging + "</div>"));
// 				$("div.pageing a").bind('click', function() {
// 					$('#request_item_list').html('');
// 					getData($(this).attr('href'));
// 					return false;
// 				});
// 			}

// 			$('.loading_img').hide();
// 		});
	}
</script>

<div style="float:left;">
	<h4 class="red">구입 제외 도서</h4>
	<ul class="con02">
		<li>구입 중이거나 정리 중인 도서  </li>
		<li>출판된 지 5년이 경과된 도서</li>
		<li>비도서, 정기간행물  </li>
		<li>개인의 학습을 위한 도서(학습지, 문제집, 수험서, 참고서, 대학교재 등)</li>
		<li>오락성 및 폭력성 자료(만화, 로맨스소설, 무협소설, 판타지소설, 폭력소설)</li>
		<li>학습만화, 팝업북, 헝겊책, 사운드북</li>
		<li>전집류, 해외주문도서</li>
		<li>5만원 이상 고가의 도서</li>
		<li>유해 매체물, 출판금지도서, 사회적으로 물의를 일으킬 소지가 있는 자료 </li>
		<li>특정 종교나 단체의 관련 자료를 집중 신청하는 경우  </li>
		<li>기타 도서관자료로서 부적합하다고 판단되는 자료 </li>
	</ul>
</div>


<div style="clear:both;"></div>

<script>
$(function() {
	$('div.images li').on('hover', function() {
		var no = $(this).attr('item_no');
		$('.item-list .item').hide();
		$('.item-list .item-'+no).show();
		$('.item-list .images li').css('border-clor', '#fff');
		$(this).css('border-color', '#ddd');
	}).css({
		'border-clor': '#fff',
		'float' : 'left'
	});
	$('.item-list .images li').eq(0).mouseover();
});
</script>
