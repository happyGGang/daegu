<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script src="/resources/cms/js/vk/vk_popup.js?vk_skin=flat_gray&vk_layout=ZW Shona"></script>

<script type="text/javascript">
$(function() {
	var article = $('.faq .article');
	article.addClass('hide');
	article.find('.a').slideUp(100);

	$('.faq .article .trigger').click(function(e){
		e.preventDefault();
		var myArticle = $(this).parents('.article:first');
		if(myArticle.hasClass('hide')){
			article.addClass('hide').removeClass('show');
			article.find('.a').slideUp(100);
			myArticle.removeClass('hide').addClass('show');
			myArticle.find('.a').slideDown(100);
		} else {
			myArticle.removeClass('show').addClass('hide');
			myArticle.find('.a').slideUp(100);
		}
	});

	$('.faq .hgroup .trigger').click(function(e){
		e.preventDefault();
		var hidden = $('.faq .article.hide').length;
		if(hidden > 0){
			article.removeClass('hide').addClass('show');
			article.find('.a').slideDown(100);
		} else {
			article.removeClass('show').addClass('hide');
			article.find('.a').slideUp(100);
		}
	});

	$('#do-search').on('click', function(e) {
		if ( $('#totalSearch input#total_search_type').val() == 'TOTAL' ) {
			if ($('#totalSearch input#search_text').val() == '') {
				alert('검색어를 입력해주세요');
				$('#totalSearch input#search_text').focus();
				return false;
			}
		} else {
			if ( $('#totalSearch input#searchKeyword1').val() != '' || $('#totalSearch input#searchKeyword2').val() != '' || $('#totalSearch input#searchKeyword3').val() != '' || $('#totalSearch input#searchKeyword4').val() != '') {
			}
			else {
				alert('검색어를 입력해주세요');
				$('#totalSearch input#search_text').focus();
				return false;
			}
		}
		$('#totalSearch #book_more_count').val(1);
		$('#totalSearch #notice_more_count').val(1);
		$('#totalSearch #teach_more_count').val(1);
		$('#totalSearch #total_search_type').val('TOTAL')
		$('#totalSearch').submit();
		//doGetLoad('search.do', serializeCustom($('#librarySearch')));
	});

	/* $('a#toggleDetailSearch').on('click', function(e) {
		e.preventDefault();
		$('.bgArea').addClass('bgGray');
		if ( $(this).attr('keyValue') == 'hide' ) {
			$('#totalSearch input#total_search_type').val('DETAIL');
			$(this).attr('keyValue', 'show');
			$('div#detailSearchArea').show();
		}
		else {
			$('#totalSearch input#total_search_type').val('TOTAL');
			$(this).attr('keyValue', 'hide');
			$('div#detailSearchArea').hide();
		}

	}); */

	$('a#toggleDetailSearch').on('click', function(e) {
		e.preventDefault();
		$('#search_text').val('');
		$('#searchKeyword4').val('');
		$('#kdcSearch').val('');
		$('.bgArea').addClass('bgGray');
		$('#header').css('z-index','1');
		$('#totalSearch input#total_search_type').val('DETAIL');
		$(this).attr('keyValue', 'show');
		$('div#detailSearchArea').show();
		$('a#subjectSearch').focus();
		});

	$('a#closeSearch').on('click', function(e) {
		e.preventDefault();
		$('.bgArea').removeClass('bgGray');
		$('#header').css('z-index','3');
		$('#totalSearch input#total_search_type').val('TOTAL');
		$(this).attr('keyValue', 'hide');
		$('div#detailSearchArea').hide();
		$('a#toggleDetailSearch').focus();
	});


	//키보드로 제어할 수 있도록
	$('a#toggleDetailSearch').on('keydown', function(e) {
		if(e.keyCode==31 || e.keyCode == 13){
			e.preventDefault();
			if ( $(this).attr('keyValue') == 'hide' ) {
				$('#totalSearch input#total_search_type').val('DETAIL');
				$('.bgArea').addClass('bgGray');
				$(this).attr('keyValue', 'show');
				$('div#detailSearchArea').show();
				$('select#searchType1').focus();
			}
			else {
				$('#totalSearch input#total_search_type').val('TOTAL');
				$('.bgArea').removeClass('bgGray');
				$(this).attr('keyValue', 'hide');
				$('div#detailSearchArea').hide();
				$('div.detailSubject a:first').focus();
			}
		}
	});




// 	$('a.goDetail').on('click', function(e) {
// 		e.preventDefault();
// 		$('input#vLoca').val($(this).attr('vLoca'));
// 		$('input#vCtrl').val($(this).attr('vCtrl'));
// 		$('input#vImg').val($(this).attr('vImg'));
// 		$('input#isbn').val($(this).attr('isbn'));
// 		$('input#tid').val($(this).attr('tid'));
// 		var formData = serializeParameter(['vLoca', 'vCtrl', 'vImg', 'isbn', 'tid', 'menu_idx_detail']);
// 		doGetLoad('/${homepage.context_path }/intro/search/detail.do', formData);
// // 		$('form#detailForm').submit();
// 	});

// 	$('a.detail-btn').on('click', function(e) {
// 		$('#teach #homepage_id').val($(this).attr('keyValue'));
// 		$('#teach #group_idx').val($(this).attr('keyValue1'));
// 		$('#teach #category_idx').val($(this).attr('keyValue2'));
// 		$('#teach #teach_idx').val($(this).attr('keyValue3'));
// 		$('#teach #large_category_idx').val($(this).attr('keyValue4'));

// // 		window.open('/${homepage.context_path}/module/teach/detail.do?'+serializeCustom($('form#teach')));
// 		doGetLoad('/${homepage.context_path}/module/teach/detail.do', serializeCustom($('form#teach')));
// 		e.preventDefault();
// 	});

// 	$('a.showSlide').on('click', function(e) {
// 		e.preventDefault();
// 		var bci = $(this).parents('div.bif').next('div.bci');
// 		var toggleState = $(bci).is(':hidden');
// 		if (toggleState) {
// 			$(bci).load('/${homepage.context_path}/intro/search/index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
// 				$(bci).slideToggle();
// 			});
// 		} else {
// 			$(bci).slideToggle();
// 		}
// 	});

	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(),
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	}).datepicker("setDate", new Date());

	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(),
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	}).datepicker("setDate", new Date());

	$('a.more-btn').on('click', function(e) {
		e.preventDefault();
		var $this = $(this);
		var moreType = $(this).attr('keyValue');

		if ( moreType == 'BOOK' ) {
			$('#totalSearch #book_more_count').val(parseInt($('#totalSearch #book_more_count').val()) + 1);
			$.get('more.do?more_type=BOOK&'+serializeCustom($('#totalSearch')), function(data) {
				$('div#search-results').append($(data));
				moreResultCount(3, moreType, $this);
				$('a.showSlide').off();
				bindingEvents();
			});
		}
		else if ( moreType == 'NOTICE' ) {
			$('#totalSearch #notice_more_count').val(parseInt($('#totalSearch #notice_more_count').val()) + 1);
			$.get('more.do?more_type=NOTICE&'+serializeCustom($('#totalSearch')), function(data) {
				$('tbody.notice-results').append($(data));
				moreResultCount(5, moreType, $this);
				$('a.showSlide').off();
				bindingEvents();
			});
		}
		else if ( moreType == 'TEACH' ) {
			$('#totalSearch #teach_more_count').val(parseInt($('#totalSearch #teach_more_count').val()) + 1);
			$.get('more.do?more_type=TEACH&'+serializeCustom($('#totalSearch')), function(data) {
				$('div.teach-results').append($(data));
				moreResultCount(5, moreType, $this);
				$('a.showSlide').off();
				bindingEvents();
			});
		}

	});
	bindingEvents();
	function bindingEvents() {
		$('a.goDetail').on('click', function(e) {
			e.preventDefault();
			$('input#vLoca').val($(this).attr('vLoca'));
			$('input#vCtrl').val($(this).attr('vCtrl'));
			$('input#vImg').val($(this).attr('vImg'));
			$('input#isbn').val($(this).attr('isbn'));
			$('input#tid').val($(this).attr('tid'));
			var formData = serializeParameter(['vLoca', 'vCtrl', 'vImg', 'isbn', 'tid', 'menu_idx']);
			window.open('/${homepage.context_path }/intro/search/detail.do?'+formData);
//	 		$('form#detailForm').submit();
		});

		$('a.detail-btn').on('click', function(e) {
			$('#teach #homepage_id').val($(this).attr('keyValue'));
			$('#teach #group_idx').val($(this).attr('keyValue1'));
			$('#teach #category_idx').val($(this).attr('keyValue2'));
			$('#teach #teach_idx').val($(this).attr('keyValue3'));
			$('#teach #large_category_idx').val($(this).attr('keyValue4'));

//	 		window.open('/${homepage.context_path}/module/teach/detail.do?'+serializeCustom($('form#teach')));
			doGetLoad('/${homepage.context_path}/module/teach/detail.do', serializeCustom($('form#teach')));
			e.preventDefault();
		});

		$('a.showSlide').on('click', function(e) {
			e.preventDefault();
			var bci = $(this).parents('div.bif').next('div.bci');
			var toggleState = $(bci).is(':hidden');
			if (toggleState) {
				$(bci).load('/${homepage.context_path}/intro/search/index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
					$(bci).slideToggle();
				});
			} else {
				$(bci).slideToggle();
			}
		});
	}

	$('a.add').on('click', function(e) {
		var $this = $(this);
		doGetLoad('/${homepage.context_path}/module/teach/student/edit.do',
				'editMode=ADD&homepage_id='+$this.attr('keyValue1')+'&group_idx='+$this.attr('keyValue2')+'&category_idx='+$this.attr('keyValue3')
				+'&teach_idx='+$this.attr('keyValue4')+'&large_category_idx='+$this.attr('keyValue5')+ '&apply_status='+ $this.attr('apply_status')+'&menu_idx='+$('input#menu_idx').val());

		e.preventDefault();
	});

	$('#vk-popup').on('click', function(e) {
		PopupVirtualKeyboard.toggle('search_text','vk');
	});
	//키보드로 조작 할 수 있도록
	$('#vk-popup').on('keydown', function(e) {
			$('html, body').animate({scrollTop: 0 }, 'fast');  //spacebar 바로 인해 내려간 화면을 다시 올려줌
		if (e.keyCode == 32) {  //space bar keyCode
			PopupVirtualKeyboard.toggle('search_text','vk');
		}
	});

	//주제별 검색
	$('a#subjectSearch').on('click', function(e) {
		e.preventDefault();
		$('.bgArea').addClass('bgGray');
		$('#header').css('z-index','1');
		$('div#detailSubjectSearch').show();
		$('div.detailSubject a:first').focus();
	});
	$('a#closeSearch2').on('click', function(e) {
		e.preventDefault();
		$('.bgArea').removeClass('bgGray');
		$('#header').css('z-index','3');
		$('.box3').hide();
		$('.nonSelect').show();
		$('div.detailSubject > ul.box1 > li > a').removeClass('open');
		$('.default').addClass('select');
		$('div.detailSubject > ul.box1 > li > ul.box2 > li > a').removeClass('open');
		$('.box2').hide();
		$('.default2').show();
		$('#total_search_type').val('TOTAL');
		$('div#detailSubjectSearch').hide();
		$('a#subjectSearch').focus();
	});

	$('div.detailSubject > ul.box1 > li > a').on('mouseover',function(e){
		$('.default').removeClass('select')
		$('div.detailSubject > ul.box1 > li > a').removeClass('open');
		$(this).addClass('select');
		$('.nonSelect').show();
		$('.box2').hide();
		$('.box3').hide();
		$(this).next().show();
	});

	$('div.detailSubject > ul.box1 > li > a').on('mouseleave',function(e){
		$(this).removeClass('select');
	});

	$('div.detailSubject > ul.box1 > li > ul.box2 > li > a').on('mouseover',function(e){
		$(this).addClass('select');
		$(this).parents('ul').prev().addClass('open');
		$('div.detailSubject > ul.box1 > li > ul.box2 > li > a').removeClass('open');
		$('.nonSelect').hide();
		$('.box3').hide();
		$(this).next().show();
	});

	$('div.detailSubject > ul.box1 > li > ul.box2 > li > a').on('mouseleave',function(e){
		$(this).removeClass('select');
	});

	$('div.detailSubject > ul.box1 > li > ul.box2 > li > ul.box3 > li > a').on('mouseover',function(e){
		$(this).addClass('select');
		$(this).parents('ul').prev().addClass('open');
	});

	$('div.detailSubject > ul.box1 > li > ul.box2 > li > ul.box3 > li > a').on('mouseleave',function(e){
		$(this).removeClass('select');
	});

	<%-- 상세검색 --%>
	$('div#detailSearchArea a#detailDoSearch').on('click', function(e){

		/* if ( $('input#searchKeyword1').val()  == '' && $('input#searchKeyword2').val()  == '' && $('input#searchKeyword3').val() == '' && $('input#searchKeyword4').val() == '') {
			alert('검색어를 입력해주세요');
			$('input#searchKeyword1').focus();
			return false;
		} */

		$('#totalSearch #book_more_count').val(1);
		$('#totalSearch #notice_more_count').val(1);
		$('#totalSearch #teach_more_count').val(1);
		$('#totalSearch').submit();

	});

	$('div#detailSearchArea').hide();

	<%-- 주제별 검색 --%>
	$('div.detailSubject ul li a, div.detailSubject ul li ul li a, div.detailSubject ul li ul li ul li a').on('click', function(e){
		$('input#kdcSearch').val($(this).attr('data-kdc'));
		$('#totalSearch input#total_search_type').val('SUBJECT');
		$('#searchKeyword4').val($(this).text());
		$('#search_text').val('');
		$('#totalSearch').submit();
	});

	<%-- 도서, 공지, 강좌 카운터 클릭시 포커스 --%>
	$('.resultFocus').on('click', function(e) {
		e.preventDefault();

		var thisClass = $(this).attr('class');
		var offset;

		if(thisClass == 'resultFocus book') {
			offset = $('#bookScroll').offset();
		} else if(thisClass == 'resultFocus notice') {
			offset = $('#noticeScroll').offset();
		} else if(thisClass == 'resultFocus teach') {
			offset = $('#teachScroll').offset();
		}
		$('html, body').animate({scrollTop : offset.top}, 100);

	});



});

/*
 * +더기보기시 카운트 증가
 */
function moreResultCount(n, moreType, $this) {
	var bookCnt = Number($('#bookCnt').text());
	var noticeCnt = Number($('#noticeCnt').text());
	var teachCnt = Number($('#teachCnt').text());

	var bookTotalCnt = $('#bookTotalCnt').text();
	var noticeTotalCnt = $('#noticeTotalCnt').text();
	var teachTotalCnt = $('#teachTotalCnt').text();

	if ( moreType == 'BOOK' ) {
		if(bookCnt >= bookTotalCnt) {
			$this.css('display', 'none');
		} else {
			$('#bookCnt').html(bookCnt+n);
		}
	} else if ( moreType == 'NOTICE' ) {
		if(noticeCnt >= noticeTotalCnt) {
			$this.css('display', 'none');
		} else {
			$('#noticeCnt').html(noticeCnt+n);
		}
	} else if ( moreType == 'TEACH' ) {
		if(teachCnt >= teachTotalCnt) {
			$this.css('display', 'none');
		} else {
			$('#teachCnt').html(teachCnt+n);
		}
	}

}

</script>
<style>
.faqArea{clear:both;margin:0 auto;border-top:2px solid #3970b8;border-bottom:1px solid #d6d6d6;}
.faq{margin:0;padding:0;list-style:none;}
.faq .q{margin:0;border-top:1px solid #ddd;}
.faq .q a.trigger{display:block;padding:15px;font-weight:bold;color:#333;text-align:left;text-decoration:none !important;font-size:14px;}
.faq .q span{font-size:14px;font-weight:bold;color:#e32c2c;margin-right:5px;}
.faq .hide .q a.trigger{background:none;font-size:14px;}
.faq .q a.trigger:hover{background:#f5fbfd;color:#e32c2c;}
.faq .a{position:relative;margin:0;padding:10px 15px;line-height:1.5;background:#fdfcf5;overflow:hidden;padding-bottom:10px;padding-top:10px;border-top:1px dashed #ddd;}
.faq .a .tit{font-size:14px;font-weight:bold;color:#e32c2c;display:inline-block;width:14px;position:absolute;top:14px;left:15px;}
.faq .a .aContent{margin-left:25px;padding:5px 0;}
.faq .a .aContent p{line-height:20px;}
.faq .a .aContent span, .faq .a .aContent p, .faq .a .aContent strong{font-size:13px !important;}
.faq .goQna{
width:650px;padding:10px 0 10px 35px;margin:10px 0 7px 25px;border:1px dashed #ccc;background:url('/resources/board/img/ico_tip.gif') #fff no-repeat 10px 12px;font-size:13px;font-weight:bold;
-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;
}
.faq .goQna span{vertical-align:top;margin-right:7px;font-size:13px;}
.faq .q.blue span{color:#2e91ed;}
.faq .q.blue a.trigger:hover,
.faq .q.blue a.trigger:active,
.faq .q.blue a.trigger:focus{color:#2e91ed;}
.faq .a.blue .tit{color:#2e91ed !important;}

#searchResultSpan {float: left;margin-right: 5px;}
#searchResultCount li:not(:last-child) {float: left;margin-right: 1%;}
#searchResultCount li {font-size: 14px;}

@media all and (max-width:1120px){
	#searchResultSpan {float: none;}
}

@media all and (max-width:900px){
	#searchResultCount {margin-bottom: 35px;}
}

@media all and (max-width:570px){
	div.search-form{margin-top: 40px;}
}
</style>
<c:set var="replaceStr" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.search_text}</span>"/>
<c:set var="replaceStr1" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword1}</span>"/>
<c:set var="replaceStr2" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword2}</span>"/>
<c:set var="replaceStr3" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword3}</span>"/>
<c:set var="replaceStr4" value="<span style='color:#ffa651;padding:0px;margin:0px;vertical-align: top;'>${totalSearch.searchKeyword4}</span>"/>
<form id="detailForm" action="detail.do" method="post">
	<input type="hidden" id="menu_idx_detail" name="menu_idx" value="${totalSearch.menu_idx }"/>
	<input type="hidden" id="vLoca" name="vLoca"/>
	<input type="hidden" id="vCtrl" name="vCtrl"/>
	<input type="hidden" id="vImg" name="vImg"/>
	<input type="hidden" id="isbn" name="isbn"/>
	<input type="hidden" id="tid" name="tid"/>
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
<form id="teach" action="detail.do" method="post">
	<input type="hidden" id="homepage_id" name="homepage_id" />
	<input type="hidden" id="group_idx" name="group_idx"/>
	<input type="hidden" id="category_idx" name="category_idx"/>
	<input type="hidden" id="teach_idx" name="teach_idx"/>
	<input type="hidden" id="large_category_idx" name="large_category_idx"/>
	<input type="hidden" id="menu_idx_teach" name="menu_idx" value="123"/>
	<input type="hidden" name="_csrf" value="${_csrf.token}">
</form>
<form:form modelAttribute="totalSearch" action="index.do" method="get">
	<form:hidden path="book_more_count"/>
	<form:hidden path="notice_more_count"/>
	<form:hidden path="teach_more_count"/>
	<form:hidden path="total_search_type"/>
	<form:hidden path="search_type"/>
	<form:hidden path="menu_idx"/>
	<div class="search-wrap">
		<c:if test="${result.code eq '0000'}">
			<span id="searchResultSpan">
				검색결과
				<b class="og">
					<c:choose>
					<c:when test="${totalSearch.total_search_type eq 'TOTAL'}">
					<i>"${totalSearch.search_text}"</i>
					</c:when>
					<c:when test="${totalSearch.total_search_type eq 'DETAIL'}">
					<i>"${totalSearch.searchKeyword1}"</i>
					</c:when>
					<c:when test="${totalSearch.total_search_type eq 'SUBJECT'}">
					<i>"${totalSearch.searchKeyword4}"</i>
					</c:when>
					</c:choose>
				</b>
				에 대한
			</span>
			<ul id="searchResultCount">
				<c:if test="${result.totalCnt == '' or result.totalCnt eq null}">
				<c:set value="0" var="result.totalCnt"></c:set>
				</c:if>
				<c:if test="${noticeCount == '' or noticeCount eq null}">
				<c:set value="0" var="noticeCount"></c:set>
				</c:if>
				<c:if test="${teachCount == '' or teachCount eq null}">
				<c:set value="0" var="teachCount"></c:set>
				</c:if>
				<li><a href="#" class="resultFocus book"><b>도서(<span id="bookCnt">${fn:length(result.data)}</span>/<span id="bookTotalCnt">${result.totalCnt}</span>)건</b></a></li>
				<li>|</li>
				<li><a href="#" class="resultFocus notice"><b>공지사항(<span id="noticeCnt">${fn:length(noticeList)}</span>/<span id="noticeTotalCnt">${noticeCount}</span>)건</b></a></li>
				<li>|</li>
				<li><a href="#" class="resultFocus teach"><b>독서/문화 강좌(<span id="teachCnt">${fn:length(teachList)}</span>/<span id="teachTotalCnt">${teachCount}</span>)건</b></a></li>
			</ul>
		</c:if>
		<div class="search-form">
			<a href="#" id="toggleDetailSearch" class="btn btn1" title="상세검색" tabindex="0" style="border-radius: 15px;float: right;margin-top: -33px;margin-right: 119px;" keyValue="${totalSearch.total_search_type eq 'DETAIL' ? 'show' : 'hide'}"><i class="fa fa-search"></i> 상세 검색</a>
			<a href="#" id="subjectSearch" class="btn btn2" title="주제별검색" tabindex="0" style="border-radius: 15px;float: right;margin-top: -33px;" keyValue="${totalSearch.total_search_type eq 'DETAIL' ? 'show' : 'hide'}"><i class="fa fa-list-ul" aria-hidden="true"></i> 주제별 검색</a>
			<div class="box" style="margin-top: 10px;">
				<div class="b1">
					<label for="search_text" class="blind">검색어를 입력하세요</label>
					<form:input path="search_text" type="text" class="text" placeholder="검색어를 입력하세요." cssStyle="ime-mode:active; width:79%;"/>
				</div>
				<div class="b2">
					<%-- <a id="toggleDetailSearch" class="btn btn1" title="상세검색" tabindex="0" style="position: absolute;top: 0px;left: -91px;padding-top: 11px; padding-bottom:11px; font-size: 19px; line-height:140%;" keyValue="${totalSearch.total_search_type eq 'DETAIL' ? 'show' : 'hide'}">상세 <i class="fa fa-search"></i></a> --%>
					<button id="do-search" title="검색" ><i class="fa fa-search"></i><span class="blind">검색</span></button>
				</div>
			</div>
			<div></div>
			<br/>
			<p style="height:auto">
				<a id="vk-popup" class="btn" title="새창열림" style="line-height:140%" tabindex="0">
				  <i class="fa fa-keyboard-o" style="font-size:19px;color:#777"></i><span>다국어입력기</span>
				</a>
			</p>
		</div>
		<br/>
		<div class="bgArea"></div>
		<div class="detailSearch" id="detailSearchArea" style="${totalSearch.total_search_type eq 'DETAIL' ? '' : 'display:none;'}">
			<span style="font-size: 25px; font-weight: bold;">상세검색</span>
			
			<ul class="searchList">
				<!-- <li style="margin-bottom: 10px"><span>* 상세검색시 총 4가지 조건의 조합으로 검색이 가능합니다.<br/>* 구분(서명, 저자, 출판사, 키워드)조건은 도서검색에만 적용됩니다.<br/>* AND (그리고), OR (또는)</span></li> -->
				<li style="margin-bottom: 10px">
					<form:select path="searchType1" class="selectmenu" cssStyle="width:100px" title="검색항목선택1">
						<form:option value="TITLE" label="서명"/>
						<form:option value="AUTHOR" label="저자"/>
						<form:option value="PUBLISHER" label="출판사"/>
						<form:option value="KEYWORD" label="키워드"/>
					</form:select>
					<form:input path="searchKeyword1" class="text smalltxt" placeholder="검색어1"/><label for="searchKeyword1" class="blind">검색어1</label>
					<form:select path="searchSubType1" class="selectmenu" cssStyle="width:100px" title="검색어일치조건 선택">
						<form:option value="RIGHT" label="전방일치"/>
						<form:option value="PART" label="부분일치"/>
						<form:option value="MATCH" label="완전일치"/>
					</form:select>
					<form:select path="logicFunction1" class="selectmenu" cssStyle="width:80px" title="검색조건선택1">
						<form:option value="AND" label="AND"/>
						<form:option value="OR" label="OR"/>
					</form:select>
				</li>
				<li style="margin-bottom: 10px">
					<form:select path="searchType2" class="selectmenu" cssStyle="width:100px" title="검색항목선택2">
						<form:option value="TITLE" label="서명"/>
						<form:option value="AUTHOR" label="저자"/>
						<form:option value="PUBLISHER" label="출판사"/>
						<form:option value="KEYWORD" label="키워드"/>
					</form:select>
					<form:input path="searchKeyword2" class="text smalltxt" placeholder="검색어2"/><label for="searchKeyword2" class="blind">검색어2</label>
					<form:select path="searchSubType2" class="selectmenu" cssStyle="width:100px" title="검색어일치조건 선택">
						<form:option value="RIGHT" label="전방일치"/>
						<form:option value="PART" label="부분일치"/>
						<form:option value="MATCH" label="완전일치"/>
					</form:select>
					<form:select path="logicFunction2" class="selectmenu" cssStyle="width:80px" title="검색조건선택1">
						<form:option value="AND" label="AND"/>
						<form:option value="OR" label="OR"/>
					</form:select>
				</li>
				<li style="margin-bottom: 10px">
					<form:select path="searchType3" class="selectmenu" cssStyle="width:100px" title="검색항목선택3">
						<form:option value="TITLE" label="서명"/>
						<form:option value="AUTHOR" label="저자"/>
						<form:option value="PUBLISHER" label="출판사"/>
						<form:option value="KEYWORD" label="키워드"/>
					</form:select>
					<form:input path="searchKeyword3" class="text smalltxt" placeholder="검색어3"/><label for="searchKeyword3" class="blind">검색어3</label>
					<form:select path="searchSubType3" class="selectmenu" cssStyle="width:100px" title="검색어일치조건 선택">
						<form:option value="RIGHT" label="전방일치"/>
						<form:option value="PART" label="부분일치"/>
						<form:option value="MATCH" label="완전일치"/>
					</form:select>
					<form:select path="logicFunction3" class="selectmenu" cssStyle="width:80px" title="검색조건선택3">
						<form:option value="AND" label="AND"/>
						<form:option value="OR" label="OR"/>
					</form:select>
				</li>
				<li style="margin-bottom: 10px">
					<form:select path="searchType4" class="selectmenu" cssStyle="width:100px" title="검색항목선택4">
						<form:option value="TITLE" label="서명"/>
						<form:option value="AUTHOR" label="저자"/>
						<form:option value="PUBLISHER" label="출판사"/>
						<form:option value="KEYWORD" label="키워드"/>
					</form:select>
					<form:input path="searchKeyword4" class="text smalltxt" placeholder="검색어4"/><label for="searchKeyword4" class="blind">검색어4</label>
					<form:select path="searchSubType4" class="selectmenu" cssStyle="width:100px" title="검색어일치조건 선택">
						<form:option value="RIGHT" label="전방일치"/>
						<form:option value="PART" label="부분일치"/>
						<form:option value="MATCH" label="완전일치"/>
					</form:select>
					<form:select path="logicFunction4" class="selectmenu" cssStyle="width:80px" title="검색조건선택4">
						<form:option value="AND" label="AND"/>
						<form:option value="OR" label="OR"/>
					</form:select>
				</li>
				<li class="search2" style="margin-bottom: 10px">
					<span class="tit">ISBN</span>
					<form:input path="isbnSearch" class="text" placeholder="ISBN" title="ISBN 입력"/><label for="searchKeyword4" class="blind" title="ISBN 입력">ISBN</label>
					<form:select path="logicFunction5" class="selectmenu" cssStyle="width:80px" title="검색조건선택4">
						<form:option value="AND" label="AND"/>
						<form:option value="OR" label="OR"/>
					</form:select>
				</li>
				<li style="margin-bottom: 10px">
					<span class="tit">한국십진분류표</span>
					<form:input path="kdcSearch" class="text" placeholder="한국십진분류표" title="한국십진분류표 입력"/><label for="searchKeyword4" class="blind">한국십진분류표</label>
				</li>
				<li style="margin-bottom: 10px">
					<span class="tit">본문언어</span>
					<form:select path="langType" class="selectmenu" cssStyle="width:80px" title="본문언어">
						<form:option value="ALL" label="전체"/>
						<form:option value="ENG" label="영어"/>
						<form:option value="KOR" label="한국어"/>
						<form:option value="JPN" label="일어"/>
						<form:option value="CHI" label="중국어"/>
						<form:option value="ETC" label="기타"/>
					</form:select>
					<%-- <form:input path="" class="text" placeholder="본문언어"/><label for="searchKeyword4" class="blind">본문언어</label> --%>
				</li>
				<li style="margin-bottom: 10px">
					<span class="tit">발행년도</span>
					<span class="yeartxt"><form:input path="searchStYear" class="text txtcheck" title="발행년도 시작 입력"/> 년 부터&nbsp;&nbsp;&nbsp;</span>
					<span class="yeartxt"><form:input path="searchEdYear" class="text txtcheck" title="발행년도 끝 입력"/> 년</span>
				</li>
				<%-- <li style="margin-bottom: 10px" class="checkbox">
					<span class="tit">자료유형</span>
					<div class="checkList">
						<label for="all"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="all" checked="checked">전체</label>
						<label for="1"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="1">단행본</label>
						<label for="2"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="2">논문</label>
						<label for="3"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="3">연속간행물</label>
						<label for="4"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="4">전자자료</label>
						<label for="5"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="5">시청각자료</label>
						<label for="6"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="6">장애인자료</label>
						<label for="7"><input id="searchFormCode" name="searchFormCode" type="checkbox" value="7">기타</label>
					</div>
				</li> --%>


				<%-- <li style="margin-bottom:5px;">검색정렬 :
					<select id="sort_type" name="sort_type" class="selectmenu" style="width:100px" title="검색정렬선택">
						<option value="TITLE" ${totalSearch.sort_type eq 'TITLE' ? 'selected="selected"':''}>서명</option>
						<option value="AUTHOR" ${totalSearch.sort_type eq 'AUTHOR' ? 'selected="selected"':''}>저자</option>
						<option value="PUBLISHER" ${totalSearch.sort_type eq 'PUBLISHER' ? 'selected="selected"':''}>출판사</option>
						<option value="KEYWORD" ${totalSearch.sort_type eq 'KEYWORD' ? 'selected="selected"':''}>키워드</option>
					</select>
				</li>
				<li>
					<input id="date_type1" title="검색기간 전체 선택" name="date_type" style="width:35px" type="radio" value="ALL" ${totalSearch.date_type eq 'ALL' ? 'checked="checked"' : '' }>
					<label for="date_type1" style="vertical-align:middle;">전체</label>
					<input id="date_type2" title="검색기간 최근일주일 선택" name="date_type" style="width:35px" type="radio" value="WEEK" ${totalSearch.date_type eq 'WEEK' ? 'checked="checked"' : '' }>
					<label for="date_type2" style="vertical-align:middle;">최근일주일</label>
					<input id="date_type3" title="검색기간 최근1개월 선택" name="date_type" style="width:35px" type="radio" value="MONTH" ${totalSearch.date_type eq 'MONTH' ? 'checked="checked"' : '' }>
					<label for="date_type3" style="vertical-align:middle;">최근1개월</label>
					<input id="date_type4" title="검색기간 직접입력 선택" name="date_type" style="width:35px" type="radio" value="SELECT" ${totalSearch.date_type eq 'SELECT' ? 'checked="checked"' : '' }>
					<label for="date_type4" style="vertical-align:middle;">직접입력</label>
					<form:input title="시작기간 입력, 입력예시 2017-01-01" path="start_date" cssClass="text ui-calendar"/><label for="start_date" class="blind">시작일</label> ~
					<form:input title="종료기간 입력, 입력예시 2017-12-31" path="end_date" cssClass="text ui-calendar"/><label for="end_date" class="blind">종료일</label>
				</li> --%>
			</ul>
			<a href="#" class="searchBtn" id="detailDoSearch">상세 검색<img src="/resources/board/img/arrow.jpg" alt=""/></a>
			<a href="#" id="closeSearch" style="    position: absolute;    top: 10px;    right: 10px;    margin: 0;"><i class="fa fa-times" aria-hidden="true"></i><span class="blind">닫기</span></a>
		</div>
		<!-- 주제별 검색 -->
		<div class="subjectSearch" id="detailSubjectSearch" style="display: none;">
			<a href="#" id="closeSearch2"><i class="fa fa-times" aria-hidden="true"></i><span class="blind">닫기</span></a>
			<div class="detailSubject">
				<ul class="box1">
					<li><a href="#" class="select default" data-kdc="000">총류</a>
						<ul class="box2 default2" style="display: block;">
							<li><a href="#" data-kdc="000">총류</a>
								<ul class="box3">
									<li><a href="#" data-kdc="000">총류</a></li>
									<li><a href="#" data-kdc="001">지식, 학문 일반</a></li>
									<li><a href="#" data-kdc="003">시스템</a></li>
									<li><a href="#" data-kdc="004">전산학</a></li>
									<li><a href="#" data-kdc="005">프로그래밍, 프로그램, 데이터</a></li>
									<li><a href="#" data-kdc="007">연구 일반 및 방법론</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="010">도서학, 서지학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="010">도서학, 서지학</a></li>
									<li><a href="#" data-kdc="011">저작권법</a></li>
									<li><a href="#" data-kdc="012">판본, 제본, 출판</a></li>
									<li><a href="#" data-kdc="014">개인서목</a></li>
									<li><a href="#" data-kdc="015">국별서목</a></li>
									<li><a href="#" data-kdc="016">주제별서목</a></li>
									<li><a href="#" data-kdc="017">특수서목</a></li>
									<li><a href="#" data-kdc="018">참고서지</a></li>
									<li><a href="#" data-kdc="019">장서목록</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="020">문헌정보학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="020">문헌정보학</a></li>
									<li><a href="#" data-kdc="021">도서관행정 및 재정</a></li>
									<li><a href="#" data-kdc="022">도서관건물 및 설비</a></li>
									<li><a href="#" data-kdc="023">도서관 경영, 관리</a></li>
									<li><a href="#" data-kdc="024">수서, 정리 및 보관</a></li>
									<li><a href="#" data-kdc="025">도서관봉사 및 활동</a></li>
									<li><a href="#" data-kdc="026">일반 도서관</a></li>
									<li><a href="#" data-kdc="027">학교 및 대학도서관</a></li>
									<li><a href="#" data-kdc="029">독서 및 정보매체의 이용</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="030">백과사전</a>
								<ul class="box3">
									<li><a href="#" data-kdc="030">백과사전</a></li>
									<li><a href="#" data-kdc="031">한국어</a></li>
									<li><a href="#" data-kdc="032">중국어</a></li>
									<li><a href="#" data-kdc="033">일본어</a></li>
									<li><a href="#" data-kdc="034">영어</a></li>
									<li><a href="#" data-kdc="035">독일어</a></li>
									<li><a href="#" data-kdc="036">프랑스어</a></li>
									<li><a href="#" data-kdc="037">스페인어</a></li>
									<li><a href="#" data-kdc="038">이탈리아어</a></li>
									<li><a href="#" data-kdc="039">기타 제언어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="040">일반 논문집</a>
								<ul class="box3">
									<li><a href="#" data-kdc="040">일반 논문집</a></li>
									<li><a href="#" data-kdc="041">한국어</a></li>
									<li><a href="#" data-kdc="042">중국어</a></li>
									<li><a href="#" data-kdc="043">일본어</a></li>
									<li><a href="#" data-kdc="044">영어</a></li>
									<li><a href="#" data-kdc="045">독일어</a></li>
									<li><a href="#" data-kdc="046">프랑스어</a></li>
									<li><a href="#" data-kdc="047">스페인어</a></li>
									<li><a href="#" data-kdc="048">이탈이아어</a></li>
									<li><a href="#" data-kdc="049">기타 제언어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="050">일반 연속간행물</a>
								<ul class="box3">
									<li><a href="#" data-kdc="050">일반 연속간행물</a></li>
									<li><a href="#" data-kdc="051">한국어</a></li>
									<li><a href="#" data-kdc="052">중국어</a></li>
									<li><a href="#" data-kdc="053">일본어</a></li>
									<li><a href="#" data-kdc="054">영어</a></li>
									<li><a href="#" data-kdc="055">독일어</a></li>
									<li><a href="#" data-kdc="056">프랑스어</a></li>
									<li><a href="#" data-kdc="057">스페인어</a></li>
									<li><a href="#" data-kdc="058">기타 제언어</a></li>
									<li><a href="#" data-kdc="059">연감</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="060">일반 학회, 단체, 협회, 기관</a>
								<ul class="box3">
									<li><a href="#" data-kdc="060">일반 학회, 단체, 협회, 기관</a></li>
									<li><a href="#" data-kdc="061">아시아 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="062">유럽 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="063">아프리카 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="064">북아메리카 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="065">남아메리카 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="066">오세아니아 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="067">양극지방 일반 학회, 단체 등</a></li>
									<li><a href="#" data-kdc="069">박물관학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="070">신문, 언론, 저널리즘</a>
								<ul class="box3">
									<li><a href="#" data-kdc="070">신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="071">아시아 신문</a></li>
									<li><a href="#" data-kdc="072">유럽 신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="073">아프리카 신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="074">북아메리카 신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="075">남아메리카 신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="076">오세아니아 신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="077">양극지방 신문, 언론, 저널리즘</a></li>
									<li><a href="#" data-kdc="078">특정주제의 신문</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="080">일반 전집, 총서</a>
								<ul class="box3">
									<li><a href="#" data-kdc="080">일반 전집, 총서</a></li>
									<li><a href="#" data-kdc="081">개인의 일반 전집</a></li>
									<li><a href="#" data-kdc="082">2인 이상의 일반 전집, 총서</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="100">철학</a>
						<ul class="box2">
							<li><a href="#" data-kdc="100">철학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="100">철학</a></li>
									<li><a href="#" data-kdc="101">이론 및 철학의 효용</a></li>
									<li><a href="#" data-kdc="102">잡저</a></li>
									<li><a href="#" data-kdc="103">辭典, 事典, 用語辭典</a></li>
									<li><a href="#" data-kdc="104">강연집, 수필집</a></li>
									<li><a href="#" data-kdc="105">연속간행물</a></li>
									<li><a href="#" data-kdc="106">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="107">지도법, 연구법 및 교육, 교육자료</a></li>
									<li><a href="#" data-kdc="108">총서, 전집, 선집</a></li>
									<li><a href="#" data-kdc="109">철학사</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="110">형이상학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="110">형이상학</a></li>
									<li><a href="#" data-kdc="111">방법론</a></li>
									<li><a href="#" data-kdc="112">존재론</a></li>
									<li><a href="#" data-kdc="113">우주론 및 자연철학</a></li>
									<li><a href="#" data-kdc="114">철학적 인간학</a></li>
									<li><a href="#" data-kdc="115">인식론</a></li>
									<li><a href="#" data-kdc="116">자유 및 필연</a></li>
									<li><a href="#" data-kdc="117">목적론</a></li>
									<li><a href="#" data-kdc="118">가치론</a></li>
									<li><a href="#" data-kdc="119">인과론(인과성)</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="130">철학의 체계</a>
								<ul class="box3">
									<li><a href="#" data-kdc="130">철학의 체계</a></li>
									<li><a href="#" data-kdc="131">관념론 및 관련철학</a></li>
									<li><a href="#" data-kdc="132">비판철학</a></li>
									<li><a href="#" data-kdc="133">합리론</a></li>
									<li><a href="#" data-kdc="134">인문주의</a></li>
									<li><a href="#" data-kdc="135">경험론</a></li>
									<li><a href="#" data-kdc="136">자연주의</a></li>
									<li><a href="#" data-kdc="137">유물론</a></li>
									<li><a href="#" data-kdc="138">과학주의철학</a></li>
									<li><a href="#" data-kdc="139">기타</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="140">경학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="140">경학</a></li>
									<li><a href="#" data-kdc="141">역류</a></li>
									<li><a href="#" data-kdc="142">서류</a></li>
									<li><a href="#" data-kdc="143">시류</a></li>
									<li><a href="#" data-kdc="144">예류</a></li>
									<li><a href="#" data-kdc="145">악류</a></li>
									<li><a href="#" data-kdc="146">춘추류</a></li>
									<li><a href="#" data-kdc="147">효경</a></li>
									<li><a href="#" data-kdc="148">사서</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="150">아시아(동양) 철학, 사상</a>
								<ul class="box3">
									<li><a href="#" data-kdc="150">아시아(동양) 철학, 사상</a></li>
									<li><a href="#" data-kdc="151">한국철학, 사상</a></li>
									<li><a href="#" data-kdc="152">중국철학, 사상</a></li>
									<li><a href="#" data-kdc="153">일본철학, 사상</a></li>
									<li><a href="#" data-kdc="154">동남아시아 제국철학, 사상</a></li>
									<li><a href="#" data-kdc="155">인도철학, 사상</a></li>
									<li><a href="#" data-kdc="156">중앙아시아 제국철학, 사상</a></li>
									<li><a href="#" data-kdc="157">시베리아 철학, 사상</a></li>
									<li><a href="#" data-kdc="159">아랍 제국철학, 사상</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="160">서양철학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="160">서양철학</a></li>
									<li><a href="#" data-kdc="162">미국철학</a></li>
									<li><a href="#" data-kdc="163">북구철학</a></li>
									<li><a href="#" data-kdc="164">영국철학</a></li>
									<li><a href="#" data-kdc="165">독일, 오스트리아철학</a></li>
									<li><a href="#" data-kdc="166">프랑스, 네덜란드철학</a></li>
									<li><a href="#" data-kdc="167">스페인, 포르투갈철학</a></li>
									<li><a href="#" data-kdc="168">이탈리아철학</a></li>
									<li><a href="#" data-kdc="169">러시아철학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="170">논리학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="170">논리학</a></li>
									<li><a href="#" data-kdc="171">연역법</a></li>
									<li><a href="#" data-kdc="172">귀납법</a></li>
									<li><a href="#" data-kdc="173">변증법적 논리학</a></li>
									<li><a href="#" data-kdc="174">기호, 수리논리학</a></li>
									<li><a href="#" data-kdc="175">오류</a></li>
									<li><a href="#" data-kdc="177">가정</a></li>
									<li><a href="#" data-kdc="178">유추</a></li>
									<li><a href="#" data-kdc="179">논증, 설득</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="180">심리학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="180">심리학</a></li>
									<li><a href="#" data-kdc="181">각론</a></li>
									<li><a href="#" data-kdc="182">차이심리학</a></li>
									<li><a href="#" data-kdc="183">발달심리학</a></li>
									<li><a href="#" data-kdc="184">이상심리학</a></li>
									<li><a href="#" data-kdc="185">생리심리학</a></li>
									<li><a href="#" data-kdc="186">임상심리학</a></li>
									<li><a href="#" data-kdc="187">심령연구 및 비학, 초심리학</a></li>
									<li><a href="#" data-kdc="188">상법, 운명판단</a></li>
									<li><a href="#" data-kdc="189">응용심리학 일반</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="190">윤리학, 도덕철학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="190">윤리학, 도덕철학</a></li>
									<li><a href="#" data-kdc="191">일반윤리학 각론</a></li>
									<li><a href="#" data-kdc="192">가정윤리</a></li>
									<li><a href="#" data-kdc="193">국가 및 정치윤리</a></li>
									<li><a href="#" data-kdc="194">사회윤리</a></li>
									<li><a href="#" data-kdc="195">직업윤리 일반</a></li>
									<li><a href="#" data-kdc="196">오락 및 경기윤리</a></li>
									<li><a href="#" data-kdc="197">성윤리</a></li>
									<li><a href="#" data-kdc="198">소비윤리</a></li>
									<li><a href="#" data-kdc="199">도덕훈, 교훈</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="200">종교</a>
						<ul class="box2">
							<li><a href="#" data-kdc="200">종교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="200">종교</a></li>
									<li><a href="#" data-kdc="201">종교철학 및 종교사상</a></li>
									<li><a href="#" data-kdc="202">잡저</a></li>
									<li><a href="#" data-kdc="203">辭典, 事典</a></li>
									<li><a href="#" data-kdc="204">자연종교, 자연신학</a></li>
									<li><a href="#" data-kdc="205">연속간행물</a></li>
									<li><a href="#" data-kdc="206">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="207">지도법, 연구법 및 교육, 교육자료</a></li>
									<li><a href="#" data-kdc="208">총서, 전집, 선집</a></li>
									<li><a href="#" data-kdc="209">종교사</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="210">비교종교학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="210">비교종교학</a></li>
									<li><a href="#" data-kdc="211">교리</a></li>
									<li><a href="#" data-kdc="212">종 조, 교조, 개종자</a></li>
									<li><a href="#" data-kdc="213">종전, 교전</a></li>
									<li><a href="#" data-kdc="214">종교신앙, 신앙록, 신앙(수도)생활</a></li>
									<li><a href="#" data-kdc="215">종교포교, 전도활동, 교화활동</a></li>
									<li><a href="#" data-kdc="216">종단, 교단(교당론)</a></li>
									<li><a href="#" data-kdc="217">예배형식, 의식, 전례</a></li>
									<li><a href="#" data-kdc="218">종파, 교파</a></li>
									<li><a href="#" data-kdc="219">신화, 신화학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="220">불교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="220">불교</a></li>
									<li><a href="#" data-kdc="221">교리철학</a></li>
									<li><a href="#" data-kdc="222">제불, 보살, 불제자</a></li>
									<li><a href="#" data-kdc="223">경전(불전, 대장경)</a></li>
									<li><a href="#" data-kdc="224">법어, 신앙록, 신앙생활</a></li>
									<li><a href="#" data-kdc="225">포교, 교육, 교화활동</a></li>
									<li><a href="#" data-kdc="226">사원론</a></li>
									<li><a href="#" data-kdc="227">법회, 의식, 행사(의궤)</a></li>
									<li><a href="#" data-kdc="228">종파</a></li>
									<li><a href="#" data-kdc="229">라마교</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="230">기독교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="230">기독교</a></li>
									<li><a href="#" data-kdc="231">기독교신학, 교의학(조직신학)</a></li>
									<li><a href="#" data-kdc="232">예수그리스도, 사도</a></li>
									<li><a href="#" data-kdc="233">성서</a></li>
									<li><a href="#" data-kdc="234">신앙록, 명상록, 신앙생활</a></li>
									<li><a href="#" data-kdc="235">포교, 교육, 교화활동, 목회학</a></li>
									<li><a href="#" data-kdc="236">교회론</a></li>
									<li><a href="#" data-kdc="237">예배, 전례, 성례</a></li>
									<li><a href="#" data-kdc="238">교파</a></li>
									<li><a href="#" data-kdc="239">유태교</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="240">도교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="240">도교</a></li>
									<li><a href="#" data-kdc="241">교의, 신선사상</a></li>
									<li><a href="#" data-kdc="242">교조, 개조(장도능)</a></li>
									<li><a href="#" data-kdc="243">도장</a></li>
									<li><a href="#" data-kdc="244">신앙록, 신앙생활</a></li>
									<li><a href="#" data-kdc="245">포교, 전도, 교육, 교화활동</a></li>
									<li><a href="#" data-kdc="246">사원론(도관)</a></li>
									<li><a href="#" data-kdc="247">행사, 법술</a></li>
									<li><a href="#" data-kdc="248">교파</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="250">천도교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="250">천도교</a></li>
									<li><a href="#" data-kdc="258">동학교분파</a></li>
									<li><a href="#" data-kdc="259">단군교, 대종교</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="260">신도</a>
								<ul class="box3">
									<li><a href="#" data-kdc="260">신도</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="270">바라문교, 인도교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="270">바라문교, 인도교</a></li>
									<li><a href="#" data-kdc="279">지나교</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="280">회교(이슬람교)</a>
								<ul class="box3">
									<li><a href="#" data-kdc="280">회교(이슬람교)</a></li>
									<li><a href="#" data-kdc="289">조로아스타교</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="290">기타 제종교</a>
								<ul class="box3">
									<li><a href="#" data-kdc="290">기타 제종교</a></li>
									<li><a href="#" data-kdc="291">아시아</a></li>
									<li><a href="#" data-kdc="292">유럽</a></li>
									<li><a href="#" data-kdc="293">아프리카</a></li>
									<li><a href="#" data-kdc="294">북아메리카</a></li>
									<li><a href="#" data-kdc="295">남아메리카</a></li>
									<li><a href="#" data-kdc="296">오세아니아</a></li>
									<li><a href="#" data-kdc="297">양극지방</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="300">사회과학</a>
						<ul class="box2">
							<li><a href="#" data-kdc="300">사회과학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="300">사회과학</a></li>
									<li><a href="#" data-kdc="301">사회사상</a></li>
									<li><a href="#" data-kdc="302">잡저</a></li>
									<li><a href="#" data-kdc="303">辭典, 事典</a></li>
									<li><a href="#" data-kdc="304">강연집, 수필집, 연설문집</a></li>
									<li><a href="#" data-kdc="305">연속간행물</a></li>
									<li><a href="#" data-kdc="306">학회, 단체, 협회, 기관, 회의</a></li>
									<li><a href="#" data-kdc="307">연구법, 연구방법 및 교육</a></li>
									<li><a href="#" data-kdc="308">총서, 전집, 선집</a></li>
									<li><a href="#" data-kdc="309">정치, 경제, 사회, 문화사정, 역사</a></li>
								</ul></li>
							<li><a href="#" data-kdc="310">통계학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="310">통계학</a></li>
									<li><a href="#" data-kdc="311">아시아</a></li>
									<li><a href="#" data-kdc="312">유럽</a></li>
									<li><a href="#" data-kdc="313">아프리카</a></li>
									<li><a href="#" data-kdc="314">북아메리카</a></li>
									<li><a href="#" data-kdc="315">남아메리카</a></li>
									<li><a href="#" data-kdc="316">오세아니아</a></li>
									<li><a href="#" data-kdc="317">양극지방</a></li>
									<li><a href="#" data-kdc="319">인구통계</a></li>
								</ul></li>
							<li><a href="#" data-kdc="320">경제학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="320">경제학</a></li>
									<li><a href="#" data-kdc="321">경제각론</a></li>
									<li><a href="#" data-kdc="322">경제정책</a></li>
									<li><a href="#" data-kdc="323">산업경제 일반</a></li>
									<li><a href="#" data-kdc="324">기업경영</a></li>
									<li><a href="#" data-kdc="325">경영관리</a></li>
									<li><a href="#" data-kdc="326">공익사업</a></li>
									<li><a href="#" data-kdc="327">금융</a></li>
									<li><a href="#" data-kdc="328">보험</a></li>
									<li><a href="#" data-kdc="329">재정</a></li>
								</ul></li>
							<li><a href="#" data-kdc="330">사회학, 사회문제</a>
								<ul class="box3">
									<li><a href="#" data-kdc="330">사회학, 사회문제</a></li>
									<li><a href="#" data-kdc="331">사회학</a></li>
									<li><a href="#" data-kdc="332">사회조직 및 제도</a></li>
									<li><a href="#" data-kdc="334">사회문제</a></li>
									<li><a href="#" data-kdc="335">생활문제</a></li>
									<li><a href="#" data-kdc="336">노동문제</a></li>
									<li><a href="#" data-kdc="337">여성문제</a></li>
									<li><a href="#" data-kdc="338">사회복지</a></li>
									<li><a href="#" data-kdc="339">사회단체</a></li>
								</ul></li>
							<li><a href="#" data-kdc="340">정치학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="340">정치학</a></li>
									<li><a href="#" data-kdc="341">국가형태</a></li>
									<li><a href="#" data-kdc="342">국가와 개인 및 집단</a></li>
									<li><a href="#" data-kdc="344">선거</a></li>
									<li><a href="#" data-kdc="345">입법</a></li>
									<li><a href="#" data-kdc="346">정당</a></li>
									<li><a href="#" data-kdc="349">외교, 국제관계</a></li>
								</ul></li>
							<li><a href="#" data-kdc="350">행정학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="350">행정학</a></li>
									<li><a href="#" data-kdc="351">아시아 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="352">유럽 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="353">아프리카 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="354">북아메리카 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="355">남아메리카 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="356">오세아니아 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="357">양극지방 중앙행정 및 행정부</a></li>
									<li><a href="#" data-kdc="359">지방자치 및 행정</a></li>
								</ul></li>
							<li><a href="#" data-kdc="360">법학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="360">법학</a></li>
									<li><a href="#" data-kdc="361">국제법</a></li>
									<li><a href="#" data-kdc="362">헌법</a></li>
									<li><a href="#" data-kdc="363">행정법</a></li>
									<li><a href="#" data-kdc="364">형법</a></li>
									<li><a href="#" data-kdc="365">민법</a></li>
									<li><a href="#" data-kdc="366">상법</a></li>
									<li><a href="#" data-kdc="367">사법제도 및 소송법</a></li>
									<li><a href="#" data-kdc="368">기타 제법</a></li>
									<li><a href="#" data-kdc="369">각국 법 및 예규</a></li>
								</ul></li>
							<li><a href="#" data-kdc="370">교육학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="370">교육학</a></li>
									<li><a href="#" data-kdc="371">교육정책 및 행정</a></li>
									<li><a href="#" data-kdc="372">학교행정 및 경영, 보건</a></li>
									<li><a href="#" data-kdc="373">학습지도, 교육방법</a></li>
									<li><a href="#" data-kdc="374">교육과정</a></li>
									<li><a href="#" data-kdc="375">유아 및 초등교육</a></li>
									<li><a href="#" data-kdc="376">중등교육</a></li>
									<li><a href="#" data-kdc="377">대학, 전문, 고등교육</a></li>
									<li><a href="#" data-kdc="378">사회교육</a></li>
									<li><a href="#" data-kdc="379">특수교육</a></li>
								</ul></li>
							<li><a href="#" data-kdc="380">풍속, 민속학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="380">풍속, 민속학</a></li>
									<li><a href="#" data-kdc="381">의식주의 풍습</a></li>
									<li><a href="#" data-kdc="382">가정생활의 풍습</a></li>
									<li><a href="#" data-kdc="383">사회생활의 풍습</a></li>
									<li><a href="#" data-kdc="384">관혼상제</a></li>
									<li><a href="#" data-kdc="385">예의작법</a></li>
									<li><a href="#" data-kdc="386">축제, 연중행사</a></li>
									<li><a href="#" data-kdc="387">전쟁풍습</a></li>
									<li><a href="#" data-kdc="388">민간전승</a></li>
									<li><a href="#" data-kdc="389">민족학</a></li>
								</ul></li>
							<li><a href="#" data-kdc="390">국방, 군사학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="390">국방, 군사학</a></li>
									<li><a href="#" data-kdc="391">군사행정</a></li>
									<li><a href="#" data-kdc="392">전략, 전술</a></li>
									<li><a href="#" data-kdc="393">군사교육 및 훈련</a></li>
									<li><a href="#" data-kdc="394">군사시설 및 장비</a></li>
									<li><a href="#" data-kdc="395">군특수기술근무</a></li>
									<li><a href="#" data-kdc="396">육군</a></li>
									<li><a href="#" data-kdc="397">해군</a></li>
									<li><a href="#" data-kdc="398">공군</a></li>
									<li><a href="#" data-kdc="399">고대병법</a></li>
								</ul></li>
						</ul>
					</li>
					<li><a href="#" data-kdc="400">순수과학</a>
						<ul class="box2">
							<li><a href="#" data-kdc="400">순수과학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="400">순수과학</a></li>
									<li><a href="#" data-kdc="401">과학이론, 과학철학</a></li>
									<li><a href="#" data-kdc="402">잡저(편람, 제표, 서지, 인명록)</a></li>
									<li><a href="#" data-kdc="403">辭典, 事典</a></li>
									<li><a href="#" data-kdc="404">강연집, 수필집, 연설문집</a></li>
									<li><a href="#" data-kdc="405">연속간행물</a></li>
									<li><a href="#" data-kdc="406">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="407">지도법, 연구법 및 교육, 교육자료</a></li>
									<li><a href="#" data-kdc="408">전집, 총서</a></li>
									<li><a href="#" data-kdc="409">과학사 및 지역구분</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="410">수학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="410">수학</a></li>
									<li><a href="#" data-kdc="411">산수</a></li>
									<li><a href="#" data-kdc="412">대수학</a></li>
									<li><a href="#" data-kdc="413">확률론, 통계수학</a></li>
									<li><a href="#" data-kdc="414">해석학</a></li>
									<li><a href="#" data-kdc="415">기하학</a></li>
									<li><a href="#" data-kdc="416">화법기하학(도학)</a></li>
									<li><a href="#" data-kdc="417">삼각법</a></li>
									<li><a href="#" data-kdc="418">해석기하학</a></li>
									<li><a href="#" data-kdc="419">기타 산법</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="420">물리학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="420">물리학</a></li>
									<li><a href="#" data-kdc="421">고체역학</a></li>
									<li><a href="#" data-kdc="422">유체역학</a></li>
									<li><a href="#" data-kdc="423">기체역학</a></li>
									<li><a href="#" data-kdc="424">음향학, 진동학</a></li>
									<li><a href="#" data-kdc="425">광학</a></li>
									<li><a href="#" data-kdc="426">열학</a></li>
									<li><a href="#" data-kdc="427">전기학 및 전자학</a></li>
									<li><a href="#" data-kdc="428">자기</a></li>
									<li><a href="#" data-kdc="429">현대물리학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="430">화학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="430">화학</a></li>
									<li><a href="#" data-kdc="431">이론화학과 물리화학</a></li>
									<li><a href="#" data-kdc="432">화학실험실, 기구, 시설</a></li>
									<li><a href="#" data-kdc="433">분석화학</a></li>
									<li><a href="#" data-kdc="434">합성화학 일반</a></li>
									<li><a href="#" data-kdc="435">무기화학</a></li>
									<li><a href="#" data-kdc="436">금속원소와 그 화합물</a></li>
									<li><a href="#" data-kdc="437">유기화학</a></li>
									<li><a href="#" data-kdc="438">환상화합물</a></li>
									<li><a href="#" data-kdc="439">고분자화합물과 기타 유기물</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="440">천문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="440">천문학</a></li>
									<li><a href="#" data-kdc="441">이론천문학</a></li>
									<li><a href="#" data-kdc="442">실지천문학</a></li>
									<li><a href="#" data-kdc="443">기술천문학</a></li>
									<li><a href="#" data-kdc="445">지구</a></li>
									<li><a href="#" data-kdc="446">측지학</a></li>
									<li><a href="#" data-kdc="447">항해천문학</a></li>
									<li><a href="#" data-kdc="448">역법, 측시법</a></li>
									<li><a href="#" data-kdc="449">각국력</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="450">지학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="450">지학</a></li>
									<li><a href="#" data-kdc="451">지구물리학</a></li>
									<li><a href="#" data-kdc="452">지형학</a></li>
									<li><a href="#" data-kdc="453">기상학, 기후학</a></li>
									<li><a href="#" data-kdc="454">해양학</a></li>
									<li><a href="#" data-kdc="455">구조지질학</a></li>
									<li><a href="#" data-kdc="456">지사학</a></li>
									<li><a href="#" data-kdc="457">고생물학(화석학)</a></li>
									<li><a href="#" data-kdc="458">응용지질학 일반 및 광상학</a></li>
									<li><a href="#" data-kdc="459">암석학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="460">광물학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="460">광물학</a></li>
									<li><a href="#" data-kdc="461">원소광물</a></li>
									<li><a href="#" data-kdc="462">유화광물</a></li>
									<li><a href="#" data-kdc="463">할로겐화광물</a></li>
									<li><a href="#" data-kdc="464">산화광물</a></li>
									<li><a href="#" data-kdc="465">규산 및 규산염화물</a></li>
									<li><a href="#" data-kdc="466">기타 산화물을 포함한 광물</a></li>
									<li><a href="#" data-kdc="467">유기광물</a></li>
									<li><a href="#" data-kdc="469">결정학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="470">생물과학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="470">생물과학</a></li>
									<li><a href="#" data-kdc="471">인류학(자연인류학)</a></li>
									<li><a href="#" data-kdc="472">생물학</a></li>
									<li><a href="#" data-kdc="473">생명론, 생물철학</a></li>
									<li><a href="#" data-kdc="474">세포학(세포생물학)</a></li>
									<li><a href="#" data-kdc="475">미생물학</a></li>
									<li><a href="#" data-kdc="476">생물진화</a></li>
									<li><a href="#" data-kdc="477">생물지리학</a></li>
									<li><a href="#" data-kdc="478">현미경 및 현미경검사법 일반</a></li>
									<li><a href="#" data-kdc="479">생물채집 및 보존</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="480">식물학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="480">식물학</a></li>
									<li><a href="#" data-kdc="481">일반 식물학</a></li>
									<li><a href="#" data-kdc="482">은화식물</a></li>
									<li><a href="#" data-kdc="483">엽상식물</a></li>
									<li><a href="#" data-kdc="484">조균류</a></li>
									<li><a href="#" data-kdc="485">현화식물, 종자식물</a></li>
									<li><a href="#" data-kdc="486">나자식물</a></li>
									<li><a href="#" data-kdc="487">피자식물</a></li>
									<li><a href="#" data-kdc="488">단자엽식물</a></li>
									<li><a href="#" data-kdc="489">쌍자엽식물</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="490">동물학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="490">동물학</a></li>
									<li><a href="#" data-kdc="491">일반 동물학</a></li>
									<li><a href="#" data-kdc="492">무척추동물</a></li>
									<li><a href="#" data-kdc="493">원생동물, 해면동물, 자포동물</a></li>
									<li><a href="#" data-kdc="494">연체동물, 의연체동물</a></li>
									<li><a href="#" data-kdc="495">절족동물, 곤충류</a></li>
									<li><a href="#" data-kdc="496">척추동물</a></li>
									<li><a href="#" data-kdc="497">어류, 양서류, 파충류</a></li>
									<li><a href="#" data-kdc="498">조류</a></li>
									<li><a href="#" data-kdc="499">포유류</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="500">기술과학</a>
						<ul class="box2">
							<li><a href="#" data-kdc="500">기술과학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="500">기술과학</a></li>
									<li><a href="#" data-kdc="501">기술이론</a></li>
									<li><a href="#" data-kdc="502">잡(편람, 제표, 서지)</a></li>
									<li><a href="#" data-kdc="503">사전, 용어집</a></li>
									<li><a href="#" data-kdc="504">강연집, 수필집</a></li>
									<li><a href="#" data-kdc="505">연속간행물</a></li>
									<li><a href="#" data-kdc="506">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="507">연구법 및 교육지도법</a></li>
									<li><a href="#" data-kdc="508">전집, 총서, 강좌</a></li>
									<li><a href="#" data-kdc="509">기술사</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="510">의학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="510">의학</a></li>
									<li><a href="#" data-kdc="511">기초의학</a></li>
									<li><a href="#" data-kdc="512">임상의학</a></li>
									<li><a href="#" data-kdc="513">내과학</a></li>
									<li><a href="#" data-kdc="514">외과</a></li>
									<li><a href="#" data-kdc="515">치과의학, 이비인후과학, 안과학</a></li>
									<li><a href="#" data-kdc="516">부인과, 산과학, 소아과학</a></li>
									<li><a href="#" data-kdc="517">위생학, 공공의학</a></li>
									<li><a href="#" data-kdc="518">약학</a></li>
									<li><a href="#" data-kdc="519">한의학(韓醫學, 漢醫學)</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="520">농업, 농학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="520">농업, 농학</a></li>
									<li><a href="#" data-kdc="521">농업기초학</a></li>
									<li><a href="#" data-kdc="522">농업경제</a></li>
									<li><a href="#" data-kdc="523">재배 및 보호</a></li>
									<li><a href="#" data-kdc="524">작물학</a></li>
									<li><a href="#" data-kdc="525">원예</a></li>
									<li><a href="#" data-kdc="526">임학, 입업</a></li>
									<li><a href="#" data-kdc="527">축산학</a></li>
									<li><a href="#" data-kdc="528">수의학</a></li>
									<li><a href="#" data-kdc="529">수산업, 생물자원의 보호, 수렵업</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="530">공학, 공업일반</a>
								<ul class="box3">
									<li><a href="#" data-kdc="530">공학, 공업일반</a></li>
									<li><a href="#" data-kdc="531">토목공학</a></li>
									<li><a href="#" data-kdc="532">토목역학, 토목재료</a></li>
									<li><a href="#" data-kdc="533">측량</a></li>
									<li><a href="#" data-kdc="534">도로공학</a></li>
									<li><a href="#" data-kdc="535">철도공학</a></li>
									<li><a href="#" data-kdc="536">교량공학</a></li>
									<li><a href="#" data-kdc="537">수리공학</a></li>
									<li><a href="#" data-kdc="538">항만공학</a></li>
									<li><a href="#" data-kdc="539">위생, 도시, 환경공학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="540">건축공학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="540">건축공학</a></li>
									<li><a href="#" data-kdc="541">건축재료</a></li>
									<li><a href="#" data-kdc="542">건축실무</a></li>
									<li><a href="#" data-kdc="543">건물구조의 유형</a></li>
									<li><a href="#" data-kdc="544">목구조</a></li>
									<li><a href="#" data-kdc="545">세부구조</a></li>
									<li><a href="#" data-kdc="546">건축설비, 연관 및 파이프의 부설</a></li>
									<li><a href="#" data-kdc="547">난방, 환기 및 공기조절공학</a></li>
									<li><a href="#" data-kdc="548">건축상의 세부 마무리손질</a></li>
									<li><a href="#" data-kdc="549">각종 건물</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="550">기계공학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="550">기계공학</a></li>
									<li><a href="#" data-kdc="551">기계역학, 재료 및 설계</a></li>
									<li><a href="#" data-kdc="552">공구와 제작</a></li>
									<li><a href="#" data-kdc="553">열공학과 원동기</a></li>
									<li><a href="#" data-kdc="554">유체공학, 기력학, 진공학</a></li>
									<li><a href="#" data-kdc="555">정밀기계</a></li>
									<li><a href="#" data-kdc="556">자동차공학</a></li>
									<li><a href="#" data-kdc="557">철도차량, 기관차</a></li>
									<li><a href="#" data-kdc="558">항공우주공학, 우주항법학</a></li>
									<li><a href="#" data-kdc="559">기타 공학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="560">전기공학, 전자공학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="560">전기공학, 전자공학</a></li>
									<li><a href="#" data-kdc="561">전기회로, 계측, 재료</a></li>
									<li><a href="#" data-kdc="562">전기기계 및 기구</a></li>
									<li><a href="#" data-kdc="563">발전</a></li>
									<li><a href="#" data-kdc="564">송전, 배전</a></li>
									<li><a href="#" data-kdc="565">전등, 조명,</a></li>
									<li><a href="#" data-kdc="566">전산공학</a></li>
									<li><a href="#" data-kdc="567">전기통신</a></li>
									<li><a href="#" data-kdc="568">무선공학</a></li>
									<li><a href="#" data-kdc="569">전자공학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="570">화학공학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="570">화학공학</a></li>
									<li><a href="#" data-kdc="571">공업화학약품</a></li>
									<li><a href="#" data-kdc="572">폭발물, 연료공업</a></li>
									<li><a href="#" data-kdc="573">음료기술</a></li>
									<li><a href="#" data-kdc="574">식품공학</a></li>
									<li><a href="#" data-kdc="575">초, 유지, 석유, 가스공학</a></li>
									<li><a href="#" data-kdc="576">요업 및 동계공업</a></li>
									<li><a href="#" data-kdc="577">세탁, 염색 및 동계공업</a></li>
									<li><a href="#" data-kdc="578">고분자화학공업</a></li>
									<li><a href="#" data-kdc="579">기타 유기공업</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="580">제조업</a>
								<ul class="box3">
									<li><a href="#" data-kdc="580">제조업</a></li>
									<li><a href="#" data-kdc="581">금속제조 및 가공업</a></li>
									<li><a href="#" data-kdc="582">철 및 강철제조</a></li>
									<li><a href="#" data-kdc="583">철기류 및 소규모철공</a></li>
									<li><a href="#" data-kdc="584">제재업, 목공업, 목제품</a></li>
									<li><a href="#" data-kdc="585">피혁 및 모피공업</a></li>
									<li><a href="#" data-kdc="586">펄프, 종이 및 동계공업</a></li>
									<li><a href="#" data-kdc="587">직물 및 섬유공업</a></li>
									<li><a href="#" data-kdc="588">의류제조</a></li>
									<li><a href="#" data-kdc="589">소형상품제조</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="590">가정학 및 가정생활</a>
								<ul class="box3">
									<li><a href="#" data-kdc="590">가정학 및 가정생활</a></li>
									<li><a href="#" data-kdc="591">가정관리 및 가정생활</a></li>
									<li><a href="#" data-kdc="592">의복</a></li>
									<li><a href="#" data-kdc="593">몸치장(몸단장), 화장</a></li>
									<li><a href="#" data-kdc="594">식품과 식료</a></li>
									<li><a href="#" data-kdc="595">주택관리 및 가정설비</a></li>
									<li><a href="#" data-kdc="596">공동주거용 주택 시설관리</a></li>
									<li><a href="#" data-kdc="597">가정위생</a></li>
									<li><a href="#" data-kdc="598">육아</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="600">예술</a>
						<ul class="box2">
							<li><a href="#" data-kdc="600">예술</a>
								<ul class="box3">
									<li><a href="#" data-kdc="600">예술</a></li>
									<li><a href="#" data-kdc="601">미술이론, 미학</a></li>
									<li><a href="#" data-kdc="602">미술의 재료 및 기법</a></li>
									<li><a href="#" data-kdc="603">미술사전</a></li>
									<li><a href="#" data-kdc="604">미술의 주제</a></li>
									<li><a href="#" data-kdc="605">미술 연속간행물</a></li>
									<li><a href="#" data-kdc="606">미술 분야의 학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="607">미술의 지도법, 연구법 및 교육</a></li>
									<li><a href="#" data-kdc="608">미술전집, 총서</a></li>
									<li><a href="#" data-kdc="609">미술사</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="610">건축술</a>
								<ul class="box3">
									<li><a href="#" data-kdc="610">건축술</a></li>
									<li><a href="#" data-kdc="611">궁전, 묘사, 성곽</a></li>
									<li><a href="#" data-kdc="612">종교건물</a></li>
									<li><a href="#" data-kdc="613">공공건물</a></li>
									<li><a href="#" data-kdc="614">과학 및 연구용건물</a></li>
									<li><a href="#" data-kdc="615">공업용건물</a></li>
									<li><a href="#" data-kdc="616">상업, 교통, 통신용건물</a></li>
									<li><a href="#" data-kdc="617">주택건물</a></li>
									<li><a href="#" data-kdc="618">기타 건물</a></li>
									<li><a href="#" data-kdc="619">장식 및 의장</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="620">조각</a>
								<ul class="box3">
									<li><a href="#" data-kdc="620">조각</a></li>
									<li><a href="#" data-kdc="622">조소재료 및 기법</a></li>
									<li><a href="#" data-kdc="623">목조</a></li>
									<li><a href="#" data-kdc="624">석조</a></li>
									<li><a href="#" data-kdc="625">금동조</a></li>
									<li><a href="#" data-kdc="626">점토조소, 소조</a></li>
									<li><a href="#" data-kdc="627">기타 재료</a></li>
									<li><a href="#" data-kdc="628">전각, 인장</a></li>
									<li><a href="#" data-kdc="629">제상</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="630">공예, 장식미술</a>
								<ul class="box3">
									<li><a href="#" data-kdc="630">공예, 장식미술</a></li>
									<li><a href="#" data-kdc="631">도자공예, 유리공예</a></li>
									<li><a href="#" data-kdc="632">금속공예</a></li>
									<li><a href="#" data-kdc="633">보석, 갑각, 패류공예</a></li>
									<li><a href="#" data-kdc="634">목, 죽, 왕골공예</a></li>
									<li><a href="#" data-kdc="635">칠공예</a></li>
									<li><a href="#" data-kdc="636">염직물공예</a></li>
									<li><a href="#" data-kdc="637">고무, 플라스틱공예</a></li>
									<li><a href="#" data-kdc="638">미술가구</a></li>
									<li><a href="#" data-kdc="639">장식예술</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="640">서예</a>
								<ul class="box3">
									<li><a href="#" data-kdc="640">서예</a></li>
									<li><a href="#" data-kdc="641">한자의 서체</a></li>
									<li><a href="#" data-kdc="642">한자서법</a></li>
									<li><a href="#" data-kdc="643">한글서법</a></li>
									<li><a href="#" data-kdc="644">기타 서법</a></li>
									<li><a href="#" data-kdc="646">펜습자</a></li>
									<li><a href="#" data-kdc="647">낙관, 수결(서명)</a></li>
									<li><a href="#" data-kdc="648">서보, 서첩, 법첩</a></li>
									<li><a href="#" data-kdc="649">문방구</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="650">회화, 도화</a>
								<ul class="box3">
									<li><a href="#" data-kdc="650">회화, 도화</a></li>
									<li><a href="#" data-kdc="651">채색이론 및 실제</a></li>
									<li><a href="#" data-kdc="652">회화의 재료 및 방법</a></li>
									<li><a href="#" data-kdc="653">시대별 및 국별 회화</a></li>
									<li><a href="#" data-kdc="654">주제별 회화</a></li>
									<li><a href="#" data-kdc="656">소묘, 도화</a></li>
									<li><a href="#" data-kdc="657">만화, 삽화</a></li>
									<li><a href="#" data-kdc="658">그래픽디자인, 도안, 포스터</a></li>
									<li><a href="#" data-kdc="659">판화</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="660">사진술</a>
								<ul class="box3">
									<li><a href="#" data-kdc="660">사진술</a></li>
									<li><a href="#" data-kdc="661">사진기계, 재료</a></li>
									<li><a href="#" data-kdc="662">촬영기술</a></li>
									<li><a href="#" data-kdc="663">음화처리</a></li>
									<li><a href="#" data-kdc="664">양화처리(인화)</a></li>
									<li><a href="#" data-kdc="666">특수사진술</a></li>
									<li><a href="#" data-kdc="667">사진응용</a></li>
									<li><a href="#" data-kdc="668">사진집</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="670">음악</a>
								<ul class="box3">
									<li><a href="#" data-kdc="670">음악</a></li>
									<li><a href="#" data-kdc="671">음악이론 및 기법</a></li>
									<li><a href="#" data-kdc="672">종교음악</a></li>
									<li><a href="#" data-kdc="673">성악</a></li>
									<li><a href="#" data-kdc="674">극음악, 오페라</a></li>
									<li><a href="#" data-kdc="675">기악합주</a></li>
									<li><a href="#" data-kdc="676">건반악기 및 타악기</a></li>
									<li><a href="#" data-kdc="677">현악기</a></li>
									<li><a href="#" data-kdc="678">취주악기</a></li>
									<li><a href="#" data-kdc="679">국악</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="680">연극</a>
								<ul class="box3">
									<li><a href="#" data-kdc="680">연극</a></li>
									<li><a href="#" data-kdc="681">극장, 연출, 연기</a></li>
									<li><a href="#" data-kdc="682">가면극</a></li>
									<li><a href="#" data-kdc="683">인형극</a></li>
									<li><a href="#" data-kdc="684">각종 연극</a></li>
									<li><a href="#" data-kdc="685">무용, 발레</a></li>
									<li><a href="#" data-kdc="686">라디오극(방송극)</a></li>
									<li><a href="#" data-kdc="687">텔레비젼극</a></li>
									<li><a href="#" data-kdc="688">영화</a></li>
									<li><a href="#" data-kdc="689">대중연예</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="690">오락, 운동</a>
								<ul class="box3">
									<li><a href="#" data-kdc="690">오락, 운동</a></li>
									<li><a href="#" data-kdc="691">오락</a></li>
									<li><a href="#" data-kdc="692">체육학, 스포츠</a></li>
									<li><a href="#" data-kdc="693">체조, 유희</a></li>
									<li><a href="#" data-kdc="694">육상경기</a></li>
									<li><a href="#" data-kdc="695">구기</a></li>
									<li><a href="#" data-kdc="696">수상경기, 공중경기</a></li>
									<li><a href="#" data-kdc="697">동계운동경기</a></li>
									<li><a href="#" data-kdc="698">무예 및 기타경기</a></li>
									<li><a href="#" data-kdc="699">기타 오락 및 레저스포츠</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="700">언어</a>
						<ul class="box2">
							<li><a href="#" data-kdc="700">언어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="700">언어</a></li>
									<li><a href="#" data-kdc="701">언어학</a></li>
									<li><a href="#" data-kdc="702">잡저</a></li>
									<li><a href="#" data-kdc="703">사전</a></li>
									<li><a href="#" data-kdc="704">강연집</a></li>
									<li><a href="#" data-kdc="705">연속간행물</a></li>
									<li><a href="#" data-kdc="706">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="707">지도법, 연구법 및 교육, 교육재료</a></li>
									<li><a href="#" data-kdc="708">전집, 총서</a></li>
									<li><a href="#" data-kdc="709">언어사</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="710">한국어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="710">한국어</a></li>
									<li><a href="#" data-kdc="711">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="712">어원, 어의</a></li>
									<li><a href="#" data-kdc="713">사전</a></li>
									<li><a href="#" data-kdc="714">어휘</a></li>
									<li><a href="#" data-kdc="715">문법</a></li>
									<li><a href="#" data-kdc="716">작문</a></li>
									<li><a href="#" data-kdc="717">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="718">고어, 방언, 속어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="720">중국어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="720">중국어</a></li>
									<li><a href="#" data-kdc="721">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="722">어원, 어의</a></li>
									<li><a href="#" data-kdc="723">사전</a></li>
									<li><a href="#" data-kdc="724">어휘</a></li>
									<li><a href="#" data-kdc="725">문법, 어법</a></li>
									<li><a href="#" data-kdc="726">작문</a></li>
									<li><a href="#" data-kdc="727">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="728">고어, 방언, 이어(속어)</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="730">일본어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="730">일본어</a></li>
									<li><a href="#" data-kdc="731">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="732">어원, 어의</a></li>
									<li><a href="#" data-kdc="733">사전</a></li>
									<li><a href="#" data-kdc="734">어휘</a></li>
									<li><a href="#" data-kdc="735">문법, 어법</a></li>
									<li><a href="#" data-kdc="736">작문</a></li>
									<li><a href="#" data-kdc="737">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="738">고어, 방언</a></li>
									<li><a href="#" data-kdc="739">기타 아시아 제어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="740">영어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="740">영어</a></li>
									<li><a href="#" data-kdc="741">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="742">어원, 어의</a></li>
									<li><a href="#" data-kdc="743">사전</a></li>
									<li><a href="#" data-kdc="744">어휘</a></li>
									<li><a href="#" data-kdc="745">문법</a></li>
									<li><a href="#" data-kdc="746">작문</a></li>
									<li><a href="#" data-kdc="747">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="748">고어, 방언, 속어</a></li>
									<li><a href="#" data-kdc="749">앵글로색슨어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="750">독일어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="750">독일어</a></li>
									<li><a href="#" data-kdc="751">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="752">어원, 어의</a></li>
									<li><a href="#" data-kdc="753">사전</a></li>
									<li><a href="#" data-kdc="754">어휘</a></li>
									<li><a href="#" data-kdc="755">문법</a></li>
									<li><a href="#" data-kdc="756">작문</a></li>
									<li><a href="#" data-kdc="757">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="758">고어, 방언, 속어</a></li>
									<li><a href="#" data-kdc="759">기타 게르만어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="760">프랑스어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="760">프랑스어</a></li>
									<li><a href="#" data-kdc="761">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="762">어원, 어의</a></li>
									<li><a href="#" data-kdc="763">사전</a></li>
									<li><a href="#" data-kdc="764">어휘</a></li>
									<li><a href="#" data-kdc="765">문법</a></li>
									<li><a href="#" data-kdc="766">작문</a></li>
									<li><a href="#" data-kdc="767">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="768">고어, 방언, 속어</a></li>
									<li><a href="#" data-kdc="769">프로방스어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="770">스페인어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="770">스페인어</a></li>
									<li><a href="#" data-kdc="771">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="772">어원, 어의</a></li>
									<li><a href="#" data-kdc="773">사전</a></li>
									<li><a href="#" data-kdc="774">어휘</a></li>
									<li><a href="#" data-kdc="775">문법</a></li>
									<li><a href="#" data-kdc="776">작문</a></li>
									<li><a href="#" data-kdc="777">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="778">고어, 방언, 속어</a></li>
									<li><a href="#" data-kdc="779">포르투갈어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="780">이탈리아어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="780">이탈리아어</a></li>
									<li><a href="#" data-kdc="781">음운, 음성, 문자</a></li>
									<li><a href="#" data-kdc="782">어원, 어의</a></li>
									<li><a href="#" data-kdc="783">사전</a></li>
									<li><a href="#" data-kdc="784">어휘</a></li>
									<li><a href="#" data-kdc="785">문법</a></li>
									<li><a href="#" data-kdc="786">작문</a></li>
									<li><a href="#" data-kdc="787">독본, 해석, 회화</a></li>
									<li><a href="#" data-kdc="788">고어, 방언, 속어</a></li>
									<li><a href="#" data-kdc="789">루마니아어</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="790">기타 제어</a>
								<ul class="box3">
									<li><a href="#" data-kdc="790">기타 제어</a></li>
									<li><a href="#" data-kdc="792">인도-유럽계어</a></li>
									<li><a href="#" data-kdc="793">아프리카제어</a></li>
									<li><a href="#" data-kdc="794">북아메리카인디안어</a></li>
									<li><a href="#" data-kdc="795">남아메리카인디안어</a></li>
									<li><a href="#" data-kdc="796">오스트로네시아어</a></li>
									<li><a href="#" data-kdc="797">셈족어</a></li>
									<li><a href="#" data-kdc="798">햄족어</a></li>
									<li><a href="#" data-kdc="799">국제어(인공어) 및 기타 언어</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="800">문학</a>
						<ul class="box2">
							<li><a href="#" data-kdc="800">문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="800">문학</a></li>
									<li><a href="#" data-kdc="801">문학이론</a></li>
									<li><a href="#" data-kdc="802">문장작법, 수사학</a></li>
									<li><a href="#" data-kdc="803">辭典, 事典</a></li>
									<li><a href="#" data-kdc="804">강연집, 수필</a></li>
									<li><a href="#" data-kdc="805">연속간행물</a></li>
									<li><a href="#" data-kdc="806">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="807">지도법 및 연구법, 교육, 교육자료</a></li>
									<li><a href="#" data-kdc="808">전집, 총서</a></li>
									<li><a href="#" data-kdc="809">문학사, 평론</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="810">한국문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="810">한국문학</a></li>
									<li><a href="#" data-kdc="811">시</a></li>
									<li><a href="#" data-kdc="812">희곡</a></li>
									<li><a href="#" data-kdc="813">소설</a></li>
									<li><a href="#" data-kdc="814">수필</a></li>
									<li><a href="#" data-kdc="815">연설, 웅변</a></li>
									<li><a href="#" data-kdc="816">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="817">풍자</a></li>
									<li><a href="#" data-kdc="818">르포르타주 및 기타</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="820">중국문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="820">중국문학</a></li>
									<li><a href="#" data-kdc="821">시</a></li>
									<li><a href="#" data-kdc="822">희곡</a></li>
									<li><a href="#" data-kdc="823">소설</a></li>
									<li><a href="#" data-kdc="824">수필</a></li>
									<li><a href="#" data-kdc="825">연설, 웅변</a></li>
									<li><a href="#" data-kdc="826">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="827">풍자</a></li>
									<li><a href="#" data-kdc="828">르포르타주 및 기타</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="830">일본문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="830">일본문학</a></li>
									<li><a href="#" data-kdc="831">시</a></li>
									<li><a href="#" data-kdc="832">희곡</a></li>
									<li><a href="#" data-kdc="833">소설</a></li>
									<li><a href="#" data-kdc="834">수필</a></li>
									<li><a href="#" data-kdc="835">연설, 웅변</a></li>
									<li><a href="#" data-kdc="836">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="837">풍자</a></li>
									<li><a href="#" data-kdc="838">르포르타주 및 기타</a></li>
									<li><a href="#" data-kdc="839">기타 아시아 제문학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="840">영미문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="840">영미문학</a></li>
									<li><a href="#" data-kdc="841">시</a></li>
									<li><a href="#" data-kdc="842">희곡</a></li>
									<li><a href="#" data-kdc="843">소설</a></li>
									<li><a href="#" data-kdc="844">수필</a></li>
									<li><a href="#" data-kdc="845">연설, 웅변</a></li>
									<li><a href="#" data-kdc="846">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="847">풍자</a></li>
									<li><a href="#" data-kdc="848">르포르타주 및 기타</a></li>
									<li><a href="#" data-kdc="849">앵글로색슨문학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="850">독일문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="850">독일문학</a></li>
									<li><a href="#" data-kdc="851">시</a></li>
									<li><a href="#" data-kdc="852">희곡</a></li>
									<li><a href="#" data-kdc="853">소설</a></li>
									<li><a href="#" data-kdc="854">수필</a></li>
									<li><a href="#" data-kdc="855">연설, 웅변</a></li>
									<li><a href="#" data-kdc="856">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="857">풍자</a></li>
									<li><a href="#" data-kdc="858">르포르타주 및 기타</a></li>
									<li><a href="#" data-kdc="859">기타 게르만 문학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="860">프랑스문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="860">프랑스문학</a></li>
									<li><a href="#" data-kdc="861">시</a></li>
									<li><a href="#" data-kdc="862">희곡</a></li>
									<li><a href="#" data-kdc="863">소설</a></li>
									<li><a href="#" data-kdc="864">수필</a></li>
									<li><a href="#" data-kdc="865">연설, 웅변</a></li>
									<li><a href="#" data-kdc="866">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="867">풍자</a></li>
									<li><a href="#" data-kdc="868">르포르타주 및 기타</a></li>
									<li><a href="#" data-kdc="869">프로방스문학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="870">스페인문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="870">스페인문학</a></li>
									<li><a href="#" data-kdc="871">시</a></li>
									<li><a href="#" data-kdc="872">희곡</a></li>
									<li><a href="#" data-kdc="873">소설</a></li>
									<li><a href="#" data-kdc="874">수필</a></li>
									<li><a href="#" data-kdc="875">연설, 웅변</a></li>
									<li><a href="#" data-kdc="876">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="877">풍자</a></li>
									<li><a href="#" data-kdc="878">르포르타주 및 기타</a></li>
									<li><a href="#" data-kdc="879">포르투갈문학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="880">이탈리아문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="880">이탈리아문학</a></li>
									<li><a href="#" data-kdc="881">시</a></li>
									<li><a href="#" data-kdc="882">희곡</a></li>
									<li><a href="#" data-kdc="883">소설</a></li>
									<li><a href="#" data-kdc="884">수필</a></li>
									<li><a href="#" data-kdc="885">연설, 웅변</a></li>
									<li><a href="#" data-kdc="886">일기, 서간, 기행</a></li>
									<li><a href="#" data-kdc="887">풍자</a></li>
									<li><a href="#" data-kdc="888">르포르타주 및 기타</a></li>
									<li><a href="#" data-kdc="889">루마니아문학</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="890">기타 제문학</a>
								<ul class="box3">
									<li><a href="#" data-kdc="890">기타 제문학</a></li>
									<li><a href="#" data-kdc="892">인도-유럽계문학</a></li>
									<li><a href="#" data-kdc="893">아프리카제문학</a></li>
									<li><a href="#" data-kdc="894">북아메리카 인디안문학</a></li>
									<li><a href="#" data-kdc="895">남아메리카 인디안문학</a></li>
									<li><a href="#" data-kdc="896">오스트로네시아문학</a></li>
									<li><a href="#" data-kdc="897">셈족문학</a></li>
									<li><a href="#" data-kdc="898">햄족문학</a></li>
									<li><a href="#" data-kdc="899">기타 제문학</a></li>

								</ul>
							</li>
						</ul>
					</li>
					<li><a href="#" data-kdc="900">역사</a>
						<ul class="box2">
							<li><a href="#" data-kdc="900">역사</a>
								<ul class="box3">
									<li><a href="#" data-kdc="900">역사</a></li>
									<li><a href="#" data-kdc="901">역사철학 및 이론</a></li>
									<li><a href="#" data-kdc="902">역사보조학</a></li>
									<li><a href="#" data-kdc="903">辭典, 事典</a></li>
									<li><a href="#" data-kdc="904">강연집, 사평</a></li>
									<li><a href="#" data-kdc="905">연속간행물</a></li>
									<li><a href="#" data-kdc="906">학회, 단체, 기관, 회의</a></li>
									<li><a href="#" data-kdc="907">지도법, 연구법 및 교육, 교육자료</a></li>
									<li><a href="#" data-kdc="908">전집, 총서</a></li>
									<li><a href="#" data-kdc="909">세계사, 세계문화사</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="910">아시아(아세아)</a>
								<ul class="box3">
									<li><a href="#" data-kdc="910">아시아(아세아)</a></li>
									<li><a href="#" data-kdc="911">한국</a></li>
									<li><a href="#" data-kdc="912">중국</a></li>
									<li><a href="#" data-kdc="913">일본</a></li>
									<li><a href="#" data-kdc="914">동남아시아</a></li>
									<li><a href="#" data-kdc="915">인도)</a></li>
									<li><a href="#" data-kdc="916">중앙아시아</a></li>
									<li><a href="#" data-kdc="917">시베리아</a></li>
									<li><a href="#" data-kdc="919">아라비아반도</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="920">유럽(구라파)</a>
								<ul class="box3">
									<li><a href="#" data-kdc="920">유럽(구라파)</a></li>
									<li><a href="#" data-kdc="921">고대그리스</a></li>
									<li><a href="#" data-kdc="922">로마</a></li>
									<li><a href="#" data-kdc="923">스칸디나비아지방</a></li>
									<li><a href="#" data-kdc="924">영국</a></li>
									<li><a href="#" data-kdc="925">독일</a></li>
									<li><a href="#" data-kdc="926">프랑스</a></li>
									<li><a href="#" data-kdc="927">스페인</a></li>
									<li><a href="#" data-kdc="928">이탈리아</a></li>
									<li><a href="#" data-kdc="929">러시아</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="930">아프리카</a>
								<ul class="box3">
									<li><a href="#" data-kdc="930">아프리카</a></li>
									<li><a href="#" data-kdc="931">북아프리카</a></li>
									<li><a href="#" data-kdc="932">이집트</a></li>
									<li><a href="#" data-kdc="933">바바리제국</a></li>
									<li><a href="#" data-kdc="934">서아프리카</a></li>
									<li><a href="#" data-kdc="936">중아프리카</a></li>
									<li><a href="#" data-kdc="937">동아프리카</a></li>
									<li><a href="#" data-kdc="938">남아프리카</a></li>
									<li><a href="#" data-kdc="939">남인도양제도</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="940">북아메리카(북미)</a>
								<ul class="box3">
									<li><a href="#" data-kdc="940">북아메리카(북미)</a></li>
									<li><a href="#" data-kdc="941">캐나다</a></li>
									<li><a href="#" data-kdc="942">미국</a></li>
									<li><a href="#" data-kdc="943">멕시코</a></li>
									<li><a href="#" data-kdc="944">중앙아메리카</a></li>
									<li><a href="#" data-kdc="945">과테말라</a></li>
									<li><a href="#" data-kdc="946">온두라스</a></li>
									<li><a href="#" data-kdc="947">니카라과</a></li>
									<li><a href="#" data-kdc="948">코스타리카</a></li>
									<li><a href="#" data-kdc="949">서인도제도</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="950">남아메리카(남미)</a>
								<ul class="box3">
									<li><a href="#" data-kdc="950">남아메리카(남미)</a></li>
									<li><a href="#" data-kdc="951">콜럼비아</a></li>
									<li><a href="#" data-kdc="952">베네수엘라, 기아나</a></li>
									<li><a href="#" data-kdc="953">브라질, 우루과이</a></li>
									<li><a href="#" data-kdc="954">에콰도르</a></li>
									<li><a href="#" data-kdc="955">페루</a></li>
									<li><a href="#" data-kdc="956">볼리비아</a></li>
									<li><a href="#" data-kdc="957">파라과이</a></li>
									<li><a href="#" data-kdc="958">아르헨티나</a></li>
									<li><a href="#" data-kdc="959">칠레</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="960">오세아니아(대양주)</a>
								<ul class="box3">
									<li><a href="#" data-kdc="960">오세아니아(대양주)</a></li>
									<li><a href="#" data-kdc="962">오스트레일리아</a></li>
									<li><a href="#" data-kdc="963">뉴질랜드</a></li>
									<li><a href="#" data-kdc="964">파푸아뉴기니</a></li>
									<li><a href="#" data-kdc="965">멜라네시아</a></li>
									<li><a href="#" data-kdc="966">미크로네시아</a></li>
									<li><a href="#" data-kdc="967">폴리네시아</a></li>
									<li><a href="#" data-kdc="968">하와이제도</a></li>
									<li><a href="#" data-kdc="969">태평양제도</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="970">양극지방</a>
								<ul class="box3">
									<li><a href="#" data-kdc="970">양극지방</a></li>
									<li><a href="#" data-kdc="971">북극지방</a></li>
									<li><a href="#" data-kdc="973">그린란드</a></li>
									<li><a href="#" data-kdc="979">남극지방</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="980">지리</a>
								<ul class="box3">
									<li><a href="#" data-kdc="980">지리</a></li>
									<li><a href="#" data-kdc="981">아시아지리</a></li>
									<li><a href="#" data-kdc="982">유럽지리</a></li>
									<li><a href="#" data-kdc="983">아프리카지리</a></li>
									<li><a href="#" data-kdc="984">북아메리카지리</a></li>
									<li><a href="#" data-kdc="985">남아메리카지리</a></li>
									<li><a href="#" data-kdc="986">오세아니아지리</a></li>
									<li><a href="#" data-kdc="987">양극지리</a></li>
									<li><a href="#" data-kdc="988">해양</a></li>
									<li><a href="#" data-kdc="989">지도 및 지도책</a></li>
								</ul>
							</li>
							<li><a href="#" data-kdc="990">전기</a>
								<ul class="box3">
									<li><a href="#" data-kdc="990">전기</a></li>
									<li><a href="#" data-kdc="991">아시아</a></li>
									<li><a href="#" data-kdc="992">유럽</a></li>
									<li><a href="#" data-kdc="993">아프리카</a></li>
									<li><a href="#" data-kdc="994">북아메리카</a></li>
									<li><a href="#" data-kdc="995">남아메리카</a></li>
									<li><a href="#" data-kdc="996">오세아니아</a></li>
									<li><a href="#" data-kdc="997">양극</a></li>
									<li><a href="#" data-kdc="998">주제별전기</a></li>
									<li><a href="#" data-kdc="999">계보, 족보</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<ul class="nonSelect">
					<li><i class="fa fa-mouse-pointer" aria-hidden="true"></i>
						상위 분류를 선택해주세요
					</li>
				</ul>
			</div>
		</div>

		<c:set var="showSmain" value="${librarySearch.search_text ne null and librarySearch.search_text ne ''}"></c:set>
		<c:if test="${fn:length(result.data) < 1 and showSmain}">
		<p style="text-align: center;">
			<b>찾으시는 자료가 없습니다. </b>
		</p>
		</c:if>
		<c:set var="hasSearchText" value="${(totalSearch.search_text ne null and totalSearch.search_text ne '') or totalSearch.total_search_type eq 'DETAIL' or totalSearch.total_search_type eq 'SUBJECT'}"></c:set>
		<div class="smain" <c:if test="${!hasSearchText}">style="display:none;"</c:if> >
			<div class="box">
				<h3 id="bookScroll">도서자료&nbsp;<span style="font-size: 14px;font-weight: normal;">[검색결과 ${result.totalCnt}건]</span></h3>
				<div id="search-results" class="search-results" style="border-top:0px">
					<c:forEach items="${result.data}" var="i">
						<div class="row">
							<div class="thumb">
								<c:choose>
									<c:when test="${i.img eq '' or fn:contains(i.img, 'noimg')}">
										<a href="#"  title="${i.title} 새창열림" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail noImg">
											<img src="/resources/common/img/noImg.gif" alt="noImage"/>
										</a>
									</c:when>
									<c:otherwise>
										<a href="#" title="${i.title} 새창열림" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail">
											<img src="${i.img}" alt="${i.title}"/>
										</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="box">
								<div class="item">
									<div class="bif">
										<a href="#" title="새창열림" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail">
											<c:choose>
												<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
													${fn:replace(i.title, totalSearch.search_text, replaceStr)}
												</c:when>
												<c:otherwise>
													<c:set var="searchKeyword" value="${i.title}"/>
													<c:if test="${totalSearch.searchKeyword1 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword2 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword3 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword4 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
													</c:if>
													${searchKeyword}
												</c:otherwise>
											</c:choose>
										</a>
										<p>
											<c:choose>
												<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
													${fn:replace(i.author, totalSearch.search_text, replaceStr)}
												</c:when>
												<c:otherwise>
													<c:set var="searchKeyword" value="${i.author}"/>
													<c:if test="${totalSearch.searchKeyword1 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword2 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword3 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword4 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
													</c:if>
													${searchKeyword}
												</c:otherwise>
											</c:choose>

										</p>
										<p>
											<c:choose>
												<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
													${fn:replace(i.publisher, totalSearch.search_text, replaceStr)}, ${i.year}
												</c:when>
												<c:otherwise>
													<c:set var="searchKeyword" value="${i.publisher}"/>
													<c:if test="${totalSearch.searchKeyword1 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword2 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword3 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
													</c:if>
													<c:if test="${totalSearch.searchKeyword4 ne '' }">
														<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
													</c:if>
													${searchKeyword}, ${i.year}
												</c:otherwise>
											</c:choose>
										</p>
										<p>${i.libName}</p>
										<div class="stat">
											<a href="#" class="showSlide" vLoca="${i.libCode}" vCtrl="${i.rec_key}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a>
											<span>[${i.callno}]</span>
										</div>
									</div>
									<div class="bci" style="display: none;">
										<!-- ajax_area -->
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<c:if test="${result.totalCnt > 3 }">
				<div style="text-align: center">
					<a href="" class="btn more-btn" title="도서자료 더보기" keyValue="BOOK"> + 도서자료 더보기</a>
				</div>
				</c:if>
				<br/>
				<h3 id="noticeScroll">공지사항&nbsp;<span style="font-size: 14px;font-weight: normal;">[검색결과 ${noticeCount}건]</span></h3>
				<div>
					<table>
					<caption>공지사항 검색 결과</caption>
						<thead>
							<tr>
								<th class="important">제목</th>
								<th class="important mmm2">작성자</th>
								<th class="mmm1">작성일</th>
								<th class="mmm1">조회수</th>
								<th class="mmm1">파일</th>
							</tr>
						</thead>
						<tbody class="notice-results">
							<c:choose>
								<c:when test="${fn:length(noticeList) > 0}">
									<c:forEach items="${noticeList}" var="j">
										<tr>
											<td class="category important td2">
												<span class="ca ${j.imsi_v_19}">${j.imsi_v_20}</span>
											</td>
											<td class="important left">
												<a target="blank" title="새창열림" href="/${j.imsi_v_19}/board/view.do?menu_idx=${j.imsi_n_2}&board_idx=${j.board_idx}&manage_idx=${j.manage_idx}" gbelib="true" >
													<span>
														<c:choose>
															<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
																${fn:replace(j.title, totalSearch.search_text, replaceStr)}
															</c:when>
															<c:otherwise>
																<c:set var="searchKeyword" value="${j.title}"/>
																<c:if test="${totalSearch.searchKeyword1 ne '' }">
																	<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
																</c:if>
																<c:if test="${totalSearch.searchKeyword2 ne '' }">
																	<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
																</c:if>
																<c:if test="${totalSearch.searchKeyword3 ne '' }">
																	<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
																</c:if>
																<c:if test="${totalSearch.searchKeyword4 ne '' }">
																	<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
																</c:if>
																${searchKeyword}
															</c:otherwise>
														</c:choose>

													</span>

													<c:if test="${j.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
													<c:if test="${j.comment_count > 0}">
													<span class="comment"><em>댓글</em> <i>${j.comment_count}</i></span>
													</c:if>
												</a>
											</td>
											<td class="num mmm1"><fmt:formatDate value="${j.add_date}" pattern="yyyy.MM.dd" /></td>
											<td class="num mmm1">${j.view_count}</td>
											<td class="file mmm1">
												<c:if test="${j.file_count > 0}">
													<i class="fa fa-floppy-o"></i>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">데이터가 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<c:if test="${noticeCount > 5}">
				<br/>
				<div style="text-align: center">
					<a href="" class="btn more-btn" title="공지사항 더보기" keyValue="NOTICE"> + 공지사항 더보기</a>
				</div>
				</c:if>
				<br/>

				<div class="blind">
				<h3>자주하는 질문</h3>
				<div class="faqArea">
					<ul  class="faq">
						<c:forEach var="j" varStatus="status" items="${faqList}">
						<li class="article hide">
							<div class="q blue">
								<a class="trigger" href="#"><span>Q.</span> ${fn:replace(j.title, totalSearch.search_text, replaceStr)}</a>
							</div>
							<div class="a">
								<span class="tit">A.</span>
								<div class="aContent">${j.content}</div>
							</div>
						</li>
						</c:forEach>
						<c:if test="${fn:length(faqList) < 1}">
						<li class="article">
							<div class="q">
								<a class="trigger" href="#">데이터가 존재하지 않습니다.</a>
							</div>
						</li>
						</c:if>
					</ul>
				</div>
				<div style="text-align: center">
					<a href="/gbelib/board/index.do?menu_idx=130&manage_idx=522&board_idx=0&rowCount=10&viewPage=1&search_type=title&search_text=${totalSearch.search_text}" title="더보기" class="btn"> + 더보기</a>
				</div>
				</div>

				<br/>
				<h3 id="teachScroll">독서/문화 강좌&nbsp;<span style="font-size: 14px;font-weight: normal;">[검색결과 ${teachCount}건]</span></h3>
				<div class="op_wrap">
					<div class="smain teach-results">
						<c:choose>
							<c:when test="${fn:length(teachList) > 0}">
								<c:forEach items="${teachList}" var="k">
									<div class="item">
										<div class="op_title category">
											<span class="ca ${k.context_path}">${k.homepage_alias}</span><span class="ca ty2">${k.group_name} ${k.category_name}</span>
											<a href="" title="새창열림" class="name detail-btn" keyValue="${k.homepage_id}" keyValue1="${k.group_idx}" keyValue2="${k.category_idx}" keyValue3="${k.teach_idx}" keyValue4="${k.large_category_idx}">
												<c:choose>
													<c:when test="${totalSearch.total_search_type eq 'TOTAL' }">
														${fn:replace(k.teach_name, totalSearch.search_text, replaceStr)}
													</c:when>
													<c:otherwise>
														<c:set var="searchKeyword" value="${k.teach_name}"/>
														<c:if test="${totalSearch.searchKeyword1 ne '' }">
															<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword1, replaceStr1)}"/>
														</c:if>
														<c:if test="${totalSearch.searchKeyword2 ne '' }">
															<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword2, replaceStr2)}"/>
														</c:if>
														<c:if test="${totalSearch.searchKeyword3 ne '' }">
															<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword3, replaceStr3)}"/>
														</c:if>
														<c:if test="${totalSearch.searchKeyword4 ne '' }">
															<c:set var="searchKeyword" value="${fn:replace(searchKeyword, totalSearch.searchKeyword4, replaceStr4)}"/>
														</c:if>
														${searchKeyword}
													</c:otherwise>
												</c:choose>
											</a>
										</div>
										<div class="box">
											<div class="box2">
												<ul class="con2">
													<li class="first"><div><label>접수기간 </label> : ${k.start_join_date} ${k.start_join_time} ~ ${k.end_join_date} ${k.end_join_time}</div></li>
													<li><div><label>장소</label> : ${k.teach_stage}</div></li>
													<li><div><label>강좌일</label> : ${k.start_date} <c:if test="${k.start_date ne k.end_date}">~ ${k.end_date}</c:if> (
																					<c:forEach var="j" varStatus="status_j" items="${k.teach_day_arr}">
																						<c:choose>
																							<c:when test="${j eq '1'}">일</c:when>
																							<c:when test="${j eq '2'}">월</c:when>
																							<c:when test="${j eq '3'}">화</c:when>
																							<c:when test="${j eq '4'}">수</c:when>
																							<c:when test="${j eq '5'}">목</c:when>
																							<c:when test="${j eq '6'}">금</c:when>
																							<c:when test="${j eq '7'}">토</c:when>
																						</c:choose>
																						<c:if test="${!status_j.last}">
																							,
																						</c:if>
																					</c:forEach>
																				) ${k.start_time} ~ ${k.end_time}
													</div></li>
													<li><div><label>강사명</label> : ${k.teacher_name}</div></li>
													<li><div>
										        		<label>강의계획서</label> :
											         	<span class="important td1">
											         		<c:if test="${k.real_file_name ne null and k.real_file_name ne '' }">
											         			<a style="color:#00f" href="download/${k.homepage_id}/${k.group_idx}/${k.category_idx}/${k.teach_idx}.do"><i class="fa fa-floppy-o"></i> ${k.plan_file_name}</a>
											         		</c:if>
										         		</span>
											        </div></li>

													<%-- <li><div><label>강좌설명</label> : ${k.teach_desc}</div></li> --%>
													<li><div class="status">
														<label>모집인원</label> :
														<span><strong>온라인</strong> ${k.teach_limit_count}명 </span>
														<c:if test="${k.teach_offline_count > 0}"><span>, <strong>오프라인</strong> ${k.teach_offline_count}명</span></c:if>
														<c:if test="${k.teach_backup_count > 0}"><span>, (<strong>대기자</strong> ${k.teach_backup_count}명 )</span></c:if>
													</div></li>
													<li><div class="status">
														<label>접수현황</label> :
														<span>
															온라인 :
															<span ${k.teach_join_count > 0 and (k.teach_join_count eq k.teach_limit_count)? 'style="color:red;"' : 'style="color:orange"'}>${k.teach_join_count}</span> / ${k.teach_limit_count}
														</span>
														<c:if test="${k.teach_offline_count > 0}">
															<span>
																오프라인 :
																<span ${k.teach_off_join_count > 0 and (k.teach_off_join_count eq k.teach_offline_count)? 'style="color:red;"' : 'style="color:orange"'}>${k.teach_off_join_count}</span> / ${k.teach_offline_count}
															</span>
														</c:if>
														<c:if test="${k.teach_backup_count > 0}">
															<span>
																(
																대기자 :
																<span ${k.teach_backup_join_count > 0 and (k.teach_backup_join_count eq k.teach_backup_count)? 'style="color:red;"' : 'style="color:orange"'}>${k.teach_backup_join_count}</span> / ${k.teach_backup_count}
																)
															</span>
														</c:if>
													</div></li>
													<li><div><label>모집대상</label> : ${k.teach_target}</div></li>
												</ul>
											</div>
										</div>
										<div class="stat">
											<c:choose>
												<c:when test="${member.login and (member.loginType eq 'HOMEPAGE') and (k.member_key eq member.seq_no)}">
													<a class="btn btn3 teachBook-btn" keyValue1="${k.homepage_id}" keyValue2="${k.group_idx}" keyValue3="${k.category_idx}" keyValue4="${k.teach_idx}" title="출석부" >출석부</a>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${k.teach_status eq '0'}">
															<a href="" class="btn btn1 add" keyValue1="${k.homepage_id}" keyValue2="${k.group_idx}" keyValue3="${k.category_idx}" keyValue4="${k.teach_idx}" keyValue5="${k.large_category_idx}" apply_status="1"  title="수강신청" >
															<i class="fa fa-pencil-square-o"></i><span>수강신청 </span></a>
														</c:when>
														<c:when test="${k.teach_status eq '1'}">
															<a href="" class="btn btn1 add" keyValue1="${k.homepage_id}" keyValue2="${k.group_idx}" keyValue3="${k.category_idx}" keyValue4="${k.teach_idx}" keyValue5="${k.large_category_idx}" apply_status="2"  title="대기자신청" >
															<i class="fa fa-pencil-square-o"></i><span>대기자신청</span></a>
														</c:when>
														<c:when test="${k.teach_status eq '2'}">
															<a href="javascript:void(0);" class="btn btn2" style="cursor: default;" title="신청완료" >
															<i class="fa fa-circle-o"></i><span>신청완료</span></a>
														</c:when>
														<c:when test="${k.teach_status eq '3'}">
															<a href="javascript:void(0);" class="btn btn3" style="cursor: default;" title="대기자" >
															<i class="fa fa-sign-in"></i><span>대기자</span></a>
														</c:when>
														<c:when test="${i.teach_status eq '3'}">
															<a href="/${k.homepage_id}/module/teach/applyList.do?menu_idx=${k.menu_idx}" class="btn btn2" title="대기자 신청완료">
															<i class="fa fa-circle-o"></i><span>대기자 신청완료</span></a>
														</c:when>
														<c:when test="${k.teach_status eq '4'}">
															<a href="javascript:void(0);" class="btn" style="cursor: default;" title="접수마감" >
															<span>접수마감</span></a>
														</c:when>
														<c:when test="${k.teach_status eq '5'}">
															<a href="javascript:void(0);" class="btn" style="cursor: default;" title="정원마감" >
															<i class="fa fa-user"></i><span>정원마감</span></a>
														</c:when>
														<c:when test="${k.teach_status eq '6'}">
															<a href="javascript:void(0);" class="btn btn4" style="cursor: default;" title="신청대기" >
															<i class="fa fa-clock-o"></i><span>신청대기</span></a>
														</c:when>
														<%-- <c:when test="${k.teach_status eq '7' }">
															<a href="javascript:void(0);" class="btn btn3" style="cursor: default;">
															<i class="fa fa-times-circle"></i><span>신청불가(취소)</span></a>
														</c:when> --%>
														<c:when test="${k.teach_status eq '9'}">
															<a href="javascript:void(0);" class="btn" style="cursor: default;" title="수강종료" >
															<span>수강종료</span></a>
														</c:when>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="nodata">
									<i class="fa fa-frown-o"></i>
									<p>데이터가 존재하지 않습니다.</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<c:if test="${teachCount > 5}">
				<div style="text-align: center">
					<a href="" class="btn more-btn" title="강좌 더보기" keyValue="TEACH"> + 강좌 더보기</a>
				</div>
				</c:if>
			</div>
		</div>
	</div>
</form:form>
