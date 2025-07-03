<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="java.util.Random"%>
<%
Random rnd = new Random();
int listNum1 = rnd.nextInt(10);
int listNum2 = 0;
int listNum3 = 0;
do {
	listNum2 = rnd.nextInt(10);
} while (listNum1 == listNum2);
do {
	listNum3 = rnd.nextInt(10);
} while (listNum1 == listNum3 || listNum2 == listNum3);

Random rndNum = new Random();
int cuNum1 = rnd.nextInt(9);
int cuNum2 = 0;

do {
	cuNum2 = rnd.nextInt(11);
} while (cuNum1 == cuNum2);
%>
<c:set var="listNum1" value="<%=listNum1%>"></c:set>
<c:set var="listNum2" value="<%=listNum2%>"></c:set>
<c:set var="listNum3" value="<%=listNum3%>"></c:set>

<c:set var="cuNum1" value="<%=cuNum1%>"></c:set>
<c:set var="cuNum2" value="<%=cuNum2%>"></c:set>

<tiles:insertAttribute name="header" />
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.fullpage.dgportal.css"/>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jquery.mCustomScrollbar.css"/>
<style>
.content-05-box .box .cont ul li {display:none;}
/*
.content-05-box .box .cont ul li:nth-of-type(${cuNum1 + 1}) {display:inline-block;}
.content-05-box .box .cont ul li:nth-of-type(${cuNum2 + 1}) {display:inline-block;}
*/
.content-05-box .box .cont ul li:nth-of-type(1) {display:inline-block;}
.content-05-box .box .cont ul li:nth-of-type(2) {display:inline-block;}
</style>

<c:set var="getIp" value="<%=request.getRemoteAddr()%>" />
<c:if test="${getIp eq '218.48.151.16'}">
</c:if>


<script type="text/javascript" src="/resources/common/js/jquery.fullpage.js"></script>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/main-visual.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mCustomScrollbar.js"></script>
<script type="text/javascript">
	var keyword = '';
	
	$(function() {
		// 로그인 시 팝업 띄우기 위함. 메인 팝업 추천도서 잠시 주석 2021-12-02
		/*
		if (${member.login && (member.member_id eq 'infoset')}) 
		{
			var result = '';
			var nameOfCookie = "book_popup_${homepage.homepage_id}=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie) {
					if ((endOfCookie = document.cookie
							.indexOf(";", y)) == -1)
						endOfCookie = document.cookie.length;
					result = unescape(document.cookie
							.substring(y, endOfCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0)
					break;
			}

			if (result != 'no') {
				$('div#recom_wrap').show();
			}
			
			var menu_idx = '22';
			var words = [];
			var color_rand = ['#82be02', '#71aa99', '#955959' ,'#be0252', '#0077d2', '#d26d00', '#d20000', '#24b732', '#00c6cd', '#a602be'];
			var weight_rand = ['100','200','300','400', '500', '600', '700', '800', '900'];
			
			<c:forEach var="i" varStatus="status" items="${bookKeywordList}">
				var obj = new Object(); 
				obj.text = '${i.keyword_name}';
				obj.color = color_rand[Math.floor(Math.random()*color_rand.length)];
				obj.weight = weight_rand[Math.floor(Math.random()*weight_rand.length)];
// 				obj.link = 'module/bookKeyword/view.do?menu_idx=87&keyword_name=${i.keyword_name}';
				words.push(obj);
				$('#demo_word_'+status.index).css('margin','15px')
			</c:forEach>

			$('#keywords').jQCloud(words, {});
		}
		*/
		$('div.keyword-box').load('module/bookKeyword/bookKeyword.do');

		$('#reloadKeyword').on('click', function(){
			$('div.keyword-box').load('module/bookKeyword/bookKeyword.do');
		});

		$(document).on("click", "#keyword span[id^=keyword_word_]", function() {
			var selected_count= $('.select-keyword span').length;
			var text = $(this).text();
			var keywordCount = $('.select-keyword span:contains("'+text+'")').length;
			
			if (keywordCount <= 0) {
				if (selected_count >= 3) {
					alert("검색 키워드는 최대 3개까지만 선택할 수 있습니다.");
					return false;
				}	
			}
			
			if (keywordCount >= 1) {
				$(this).css('border', '');
				$(this).removeAttr('select');
				$('.select-keyword span:contains("'+text+'")' ).remove();
			} else {
				$(this).css('border', 'solid');
				$(this).attr('select', 'selected');
				$('.select-keyword').append('<span style="margin-left: 5px;">' + text + '<i class="fa fa-times" style="margin-left:3px; cursor:pointer;" id="keywordRemove"></i></span>');
			}
		});

		$('#search_keyword').on('click',function(e){
			// 초기화
			$('#keyword_name').val('');
			
			var selected_count= $('.select-keyword span').length;;
			
			if (selected_count == 0) {
				alert("키워드를 하나 이상 선택 후 검색을 진행해 주세요.");
				return false;
			}
			
			for (var i = 0; i < selected_count; i++) {
				var keyword_text = $('.select-keyword span').eq(i).text(); 
				
				var keyword_name = $('#keyword_name').val();
				if (keyword_name == null || keyword_name == '') {
					$('#keyword_name').val(keyword_text);
				} else {
					$('#keyword_name').val(keyword_name+','+keyword_text);
				}
			}
			
			doGetLoad('module/bookKeyword/view.do', "menu_idx=87&keyword_name="+$('#keyword_name').val());
		});
		
		$(document).on("click", "#keywords span[id^=keywords_word_]", function() {
			var selected_count= $('#keywords span[select=selected]').length;
			var selectAttr = $(this).attr("select");
			var text = $(this).text();
			
			if (selectAttr == null) {
				if (selected_count >= 3) {
					alert("검색 키워드는 최대 3개까지만 선택할 수 있습니다.");
					return false;
				}	
			}
			
			if (selectAttr == 'selected') {
				$(this).css('border', '');
				$(this).removeAttr('select');
			} else {
				$(this).css('border', 'solid');
				$(this).attr('select', 'selected');
			}
		});

		$(document).on('click', '#keywordRemove', function(){
			var text = $(this).parent("span").text(); 
			$(this).parent("span").remove();
			$('#keyword span[id^=keyword_word_]:contains("'+text+'")').css('border', '');
		});

		$('#homeup').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 800);
			return false;
		});

		// 팝업 관련 코드 START
		$('.close-btn').on('click', function() {
			var $this = $(this);
			var checkInput = $this.parent().find('input[data-day="'+$this.data('day')+'"]');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if($this.data('day') == 7) {
					todayDate.setDate(todayDate.getDate() + 7);
				}
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";";
			}

			$('div#' + popupId).hide();
		});
		
		$('.book-close-btn').on('click', function() {
			var $this = $(this);
			var checkInput = $this.parent().parent().find('.pop-close-set input[data-day="'+$this.data('day')+'"]');
			var popupId = checkInput.val();
			if (checkInput.prop('checked')) {
				var todayDate = new Date();
				todayDate = new Date(
						parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
				if($this.data('day') == 7) {
					todayDate.setDate(todayDate.getDate() + 7);
				}
				document.cookie = popupId + "=no"
						+ "; path=/; expires="
						+ todayDate.toGMTString() + ";";
			}

			$('div#recom_wrap').hide();
		});

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
			$(this).parent('div').next('a').data('day', $(this).data('day'));
			$(this).parent('div').next('a').click();
		});
		
		$('input[id*=book]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
			$('.book-close-btn').data('day', $(this).data('day'));
			$('.book-close-btn').click();
		});

		$('#popupLayer > div').each(function(i, v) {
			var result = '';
			var name = $(v).attr('id');
			var nameOfCookie = name + "=";
			var x = 0;
			while (x <= document.cookie.length) {
				var y = (x + nameOfCookie.length);
				if (document.cookie.substring(x, y) == nameOfCookie) {
					if ((endOfCookie = document.cookie
							.indexOf(";", y)) == -1)
						endOfCookie = document.cookie.length;
					result = unescape(document.cookie
							.substring(y, endOfCookie));
				}
				x = document.cookie.indexOf(" ", x) + 1;
				if (x == 0)
					break;
			}

			if (result != 'no') {
				if  (window.innerWidth < $(v).width() ) {
					$(v).css('width', 'auto');
				}
				$(v).show();
			}
		});
		// 팝업 관련 코드 END


		$('ul.newBookUl').load('recommendBook.do?category2=${category2List[0].code_id}');
		$('select#recommendBook1').on('change', function() {
			$('ul.newBookUl').load('recommendBook.do?category2='+$(this).val());
		});

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}

			if( $("input:checkbox[name=libraryCodes]:checked").length == 0 )
			{
				alert('도서관을 선택 하세요.');
				//$('input#search_text_1').focus();
				return false;
			}

			$('#mainSearchForm').submit();
		});

		$('#main-search-btn2').on('click', function() {
			if( $('input#search_text_2').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_2').focus();
				return false;
			}

			$('#mainSearchForm2').submit();
		})

		$(".libraryInfo input").attr('disabled',true);
		$("#lib6 input").attr('disabled',false);
		$("select#searchArea").val('6').prop("selected",true);

		/*메인지도*/
		$(".map-area li a").click(function(){
			var id = $(this).data("num");

			$(".libraryInfo").hide();
			$(".libraryInfo input").attr('disabled',true);

			if(id == '8' || id =='9')
			{
				$("#lib8").show();
				$(".map-area li").removeClass('on');
				$("#lib8").parents('li').addClass('on');
				$("#lib9").parents('li').addClass('on');
				$(".dglib08").addClass('on');
				$(".dglib09").addClass('on');
				$("#lib8 input").attr('disabled',false);
			}
			else
				{
				$("#lib" + id).show();
				$(".map-area li").removeClass('on');
				$(this).parents('li').addClass('on');
				$(".dglib0" + id).addClass('on');
				$("#lib" + id +" input").attr('disabled',false);
			}
			return false;
		});


		$("select#searchArea").change(function(){
			var id = $(this).val();
			$(".libraryInfo").hide();
			$(".libraryInfo input").attr('disabled',true);

			$("#lib" + id).show();
			$(".map-area li").removeClass('on');
			$(this).parents('li').addClass('on');
			$(".dglib0" + id).addClass('on');
			$("#lib" + id +" input").attr('disabled',false);
			return false;
		});

		$("input:checkbox[name='libraryCodes']").prop('checked', true);
		$("input.libraryCodesSa").prop('checked', false);
		$("input.libraryCodesSaCheck").prop('checked', false);

		$(".libraryCodesAll").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$("input:checkbox[name='libraryCodes']").prop('checked', true);
				$("input.libraryCodesSa").prop('checked', false);
				$("input.libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$("input:checkbox[name='libraryCodes']").prop('checked', false);
			}
		});

		$(".libraryCodesSi").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$(".libraryCodesSi").prop('checked', true);
				$(".libraryCodesSiCheck").prop('checked', true);
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$(".libraryCodesSi").prop('checked', false);
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesSiCheck").prop('checked', false);
			}
		});

		$(".libraryCodesGu").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$(".libraryCodesGu").prop('checked', true);
				$(".libraryCodesGuCheck").prop('checked', true);
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$(".libraryCodesGu").prop('checked', false);
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesGuCheck").prop('checked', false);
			}
		});

		$(".libraryCodesSm").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$(".libraryCodesSm").prop('checked', true);
				$(".libraryCodesSmCheck").prop('checked', true);
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$(".libraryCodesSm").prop('checked', false);
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesSmCheck").prop('checked', false);
			}
		});

		$(".libraryCodesSiCheck").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesSi").prop('checked', false);
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);
			}
		});

		$(".libraryCodesGuCheck").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesGu").prop('checked', false);
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);
			}
		});

		$(".libraryCodesSmCheck").click(function(){
			var chk = $(this).is(":checked");//.attr('checked');
			if(chk) 
			{
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
			else
			{
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesSmCheck").prop('checked', false);
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);
			}
		});

		//사립전체 컨트롤
		$(".libraryCodesSa").click(function(){
			var chk = $(this).is(":checked");
			if(chk) 
			{
				$(".libraryCodesSa").prop('checked', true);
				$(".libraryCodesSaCheck").prop('checked', true);

				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesSi").prop('checked', false);
				$(".libraryCodesGu").prop('checked', false);
				$(".libraryCodesSm").prop('checked', false);

				$(".libraryCodesSiCheck").prop('checked', false);
				$(".libraryCodesGuCheck").prop('checked', false);
				$(".libraryCodesSmCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/index_All.do');
			}
			else
			{
				$(".libraryCodesSa").prop('checked', false);
				$(".libraryCodesSaCheck").prop('checked', false);

				$(".libraryCodesAll").prop('checked', true);
				$(".libraryCodesSi").prop('checked', true);
				$(".libraryCodesGu").prop('checked', true);
				$(".libraryCodesSm").prop('checked', true);

				$(".libraryCodesSiCheck").prop('checked', true);
				$(".libraryCodesGuCheck").prop('checked', true);
				$(".libraryCodesSmCheck").prop('checked', true);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/indexAll.do');
			}
		});

		//사립 컨트롤
		
		$(".libraryCodesSaCheck").click(function(){
			var chk = $(this).is(":checked");
			if(chk) 
			{
				$(".libraryCodesAll").prop('checked', false);
				$(".libraryCodesSi").prop('checked', false);
				$(".libraryCodesGu").prop('checked', false);
				$(".libraryCodesSm").prop('checked', false);

				$(".libraryCodesSiCheck").prop('checked', false);
				$(".libraryCodesGuCheck").prop('checked', false);
				$(".libraryCodesSmCheck").prop('checked', false);

				$('#mainSearchForm').attr('action','/dgportal/intro/search/index_All.do');

				//$(".libraryCodesSaCheck").prop('checked', true);
			}
			else
			{
				//$(".libraryCodesSaCheck").prop('checked', false);
			}
		});
		
});
</script>






<!--추천도서 시작-->
<div id="recom_wrap" class="recom_wrap" style="display:none;">
	<input type="hidden" id="keyword_name">
	<!--닫기버튼-->
	<div class="close_btn">
		<a href="javascript:void(0)" tabindex="1" data-day="1" class="book-close-btn"><img src="/resources/common/img/recom_close_btn.png" alt="창 닫기 버튼"></a>
	</div>

	<!--상단문구-->
	<div class="recom_txt_box">
		<p><strong>${member.member_name }</strong>님에 대해 알려주세요!</p>
		<span>맞춤책 추천으로 <strong>${member.member_name}</strong>님의 독서를 도와드려요.</span>
		<span class="txt">* 중복 선택 가능(최대 3개)</span>
	</div>

	<!--키워드 박스-->
	<div class="recom_a_box">
		<div class="keyword-box">

		</div>
	</div>

	<div class="select-keyword">

	</div>

	<!--버튼-->
	<div class="btn-box">
		<ul>
<!-- 			<li class="step prev_btn"><a href="">이전단계</a></li> -->
			<!-- <li class="con"><a href="javascript:location.reload()">키워드변경</a></li>
			
			<li class="con"><a href="javascript:void(0)" id="search_keyword">검색</a></li> -->
<!-- 			<li class="step next_btn"><a href="">다음단계</a></li> -->
			
			<li class="btn1">
				<a href="javascript:void(0)" id="reloadKeyword">
					키워드 변경
					<span>마음에 드는 키워드가 없으시다면 새로운 키워드를 받아보세요</span>
				</a>
			</li>
			<li class="btn2">
				<a href="javascript:void(0)" id="search_keyword">
					맞춤책 추천
					<span>선택하신 키워드와 연관된 맞춤책을 추천해드립니다</span>
				</a>
			</li>
			<li class="btn3"><a href="javascript:void(0)" class="book-close-btn">그만끝내기<span>새로고침시 다시 이용가능합니다.</span></a></li>
		</ul>
		
	</div>
	
	<!-- 안보기 체크박스-->
	<div class="pop-close-set">
		<input name="book_popup_${homepage.homepage_id}" data-day="1" id="book_${homepage.homepage_id}" type="checkbox" value="book_popup_${homepage.homepage_id}">
		<label for="book_${homepage.homepage_id}" style="line-height: 34px;" title="오늘하루 열지않음">오늘하루 열지않음</label>&nbsp;&nbsp;&nbsp;
		<input name="book_popup_${homepage.homepage_id}_7" data-day="7" id="book_${homepage.homepage_id}_7" type="checkbox" value="book_popup_${homepage.homepage_id}">
		<label for="book_${homepage.homepage_id}_7" style="line-height: 34px;" title="7일간 보지 않기">7일간 보지 않기</label>
	</div>
	
	<div class="recom_wrap_bg">
	</div>
</div>
<!--추천도서 끝-->

<div id="wrap">
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="topMenu" />

	<div class="popupWrap main-section">
		<div id="popupLayer">
			<homepageTag:popup popupList="${popupList}" />
		</div>
	</div>

	<div id="fullpage">

		<!-- main0 -->
		<div class="section" id="main0">

			<div class="main-visual">
				<div class='wide-visual-sections'>
					<div id="top-book-loc-01" class="top-book">
						<a href="#" id="top-book-01" class="top-book-act on">
							<div class="top-book-content-01">

								<div class="content-01-box">
									<h3>01</h3>

									<div class="box">
										<div class="title">
											<span class="">도서관알리미</span>
										</div>
										<div class="cont">
											<ul>
												<c:forEach items="${noticeBoardListRandom}" var="i" varStatus="status" begin="0" end="1">
												<li>
													<a href="/${i.imsi_v_19}/board/view.do?manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&menu_idx=${i.imsi_n_2}" target="_blank">
														<div class="contTop">
															<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy"/> <b><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></b></span>
															<span class="link library${i.imsi_v_19}">${i.imsi_v_20}</span>
														</div>
														<div class="contMiddle">
															<span class="tit">${fn:substring(i.title, 0, 39)}<c:if test="${fn:length(i.title) > 39}">...</c:if></span>
														</div>

														<div class="contBottom">
															<c:if test="${i.content_summary eq '' || i.content_summary eq null || i.content_summary eq 'null'}">
															<span class="con">등록된 내용이 없습니다.</span>
															</c:if>
															<span class="con">${fn:substring(i.content_summary, 0, 100)}<c:if test="${fn:length(i.content_summary) > 100}">...</c:if></span>
														</div>
												</li>
												</c:forEach>
												<c:if test="${fn:length(noticeBoardListRandom) < 1}">
												<li>
													<a href="javascript:void(0)">
														<div class="contMiddle">
															<span class="tit">등록된 내용이 없습니다.</span>
														</div>
													</a>
												</li>
												</c:if>
											</ul>
										</div>
	
									</div>
								</div>

								<div class="center top-cont-more">
									<a href="#secondPage"><img src="/resources/homepage/${homepage.context_path}/img/top_down.png" alt=""></a>
								</div>

							</div>
						</a>
					</div>
					<div id="top-book-loc-02" class="top-book">
						<a href="#" id="top-book-02" class="top-book-act">
							<div class="top-book-content-02">

								<div class="content-02-box">
									<h3>02</h3>

									<div class="box">
										
										<div class="title">
											<span class="">통합자료검색</span>
										</div>
										<div class="top-ment">
											어떤 도서를 찾고 싶으세요?
										</div>
										<div class="bottom-ment">
											쉽고 빠르게 검색해보세요
										</div>
										
										<div class="search-box">
											<div class="main-box">
												<form id="mainSearchForm2" action="/dgportal/intro/search/indexAll.do">
												<input type="hidden" name="menu_idx" value="7">
												<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
												<input type="hidden" name="libraryCodes" class="libCheck lib_AA" value="AA"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AL" value="AL"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AG" value="AG"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AJ" value="AJ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AH" value="AH"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AB" value="AB"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AC" value="AC"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AF" value="AF"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AE" value="AE"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AD" value="AD"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AM" value="AM"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_CA" value="CA"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_CB" value="CB"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BL" value="BL"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BQ" value="BQ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BP" value="BP"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BM" value="BM"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BN" value="BN"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BT" value="BT"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BS" value="BS"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BA" value="BA"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BB" value="BB"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BC" value="BC"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FS" value="FS"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BD" value="BD"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BE" value="BE"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BF" value="BF"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BG" value="BG"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BH" value="BH"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BJ" value="BJ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BK" value="BK"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BU" value="BU"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BV" value="BV"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BW" value="BW"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BX" value="BX"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BY" value="BY"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BZ" value="BZ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_BR" value="BR"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GR" value="GR"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GS" value="GS"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HJ" value="HJ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FK" value="FK"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GT" value="GT"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FP" value="FP"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FL" value="FL"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GU" value="GU"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GV" value="GV"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GW" value="GW"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GX" value="GX"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GY" value="GY"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FM" value="FM"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HK" value="HK"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HM" value="HM"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HN" value="HN"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HP" value="HP"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HQ" value="HQ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GQ" value="GQ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FU" value="FU"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FZ" value="FZ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FH" value="FH"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FT" value="FT"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HC" value="HC"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FE" value="FE"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GL" value="GL"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GM" value="GM"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GN" value="GN"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GP" value="GP"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HB" value="HB"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HD" value="HD"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HE" value="HE"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FF" value="FF"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FQ" value="FQ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FY" value="FY"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GG" value="GG"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HA" value="HA"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HF" value="HF"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FV" value="FV"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FG" value="FG"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FA" value="FA"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FB" value="FB"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FC" value="FC"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FD" value="FD"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FX" value="FX"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GK" value="GK"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_AK" value="AK"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GA" value="GA"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GB" value="GB"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HG" value="HG"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GD" value="GD"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GF" value="GF"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GH" value="GH"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FR" value="FR"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GE" value="GE"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_GC" value="GC"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FN" value="FN"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_FJ" value="FJ"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_CC" value="CC"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HU" value="HU"/>
												<input type="hidden" name="libraryCodes" class="libCheck lib_HS" value="HS"/>
												<div class="box1">
													<div class="box2">
														<label for="search_text_2" class="blind">통합자료검색</label>
														<input name="title" id="search_text_2" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
													</div>
												</div>
												<button id="main-search-btn2">검색하기</button>
												</form>
											</div>
										</div>

									</div>
								</div>

								<div class="center top-cont-more">
									<a href="#thirdPage"><img src="/resources/homepage/${homepage.context_path}/img/top_down.png" alt=""></a>
								</div>

							</div>
						</a>
					</div>
					<div id="top-book-loc-03" class="top-book">
						<a href="#" id="top-book-03" class="top-book-act">
							<div class="top-book-content-03">

								<div class="content-03-box">
									<h3>03</h3>

									<div class="box">
										<div class="title">
											<span class="">평생교육강좌</span>
										</div>

										<div class="con">
											<ul>
												<c:forEach items="${teachList}" var="i" varStatus="status" begin='0' end='4'>
												<li>
													<a href="/${i.context_path}/module/teach/detail.do?homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=${i.menu_idx}&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}" target="_blank">
														<span class="txt">
															<span class="lib-name link teach_${i.homepage_id}">${i.homepage_name}</span>
															<span class="tit">${fn:substring(i.teach_name, 0, 21)}<c:if test="${fn:length(i.teach_name) > 21}">...</c:if></span>
															<span class="len"><b>접수</b> ${i.start_join_date} ~ ${i.end_join_date}</span>
														</span>
														<div class="end"></div>
													</a>
												</li>
												</c:forEach>
											</ul>
										</div>

									</div>
								</div>

								<div class="center top-cont-more">
									<a href="#fourthPage"><img src="/resources/homepage/${homepage.context_path}/img/top_down.png" alt=""></a>
								</div>

							</div>
						</a>
					</div>
					<div id="top-book-loc-04" class="top-book">
						<a href="#" id="top-book-04" class="top-book-act">
							<div class="top-book-content-04">

								<div class="content-04-box">
									<h3>04</h3>

									<div class="box">
										<div class="title">
											<span>도서서비스</span>
										</div>
										<div class="daegubook">
											<div class="con">
												<c:choose>
													<c:when test="${empty recommendOne}">
														<dl>
															<dt>
																<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="추천도서가 없습니다." title="추천도서가 없습니다."/>
															</dt>
															<dd>
																<p class="daegubook-cont-01">대구광역시통합도서관 <br/> 사서가 추천하는 BOOK'</p>
																<p class="daegubook-cont-02">
																	<b>등록된 추천도서가 없습니다.</b>
																</p>
																<p class="daegubook-cont-03"></p>
															</dd>
														</dl>
													</c:when>
													<c:otherwise>
														<a href="/${homepage.context_path}/board/view.do?menu_idx=67&manage_idx=299&board_idx=${recommendOne.board_idx}">
															<dl>
																<dt>
																	<c:choose>
																		<c:when test="${empty recommendOne.preview_img}">
																			<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${recommendOne.title}" title="${recommendOne.title}"/>
																		</c:when>
																		<c:when test="${fn:contains(recommendOne.preview_img, 'http')}">
																			<img src="${recommendOne.preview_img}" alt="${recommendOne.title}" title="${recommendOne.title}"/>
																		</c:when>
																		<c:when test="${fn:contains(recommendOne.preview_img, 'noImg')}">
																			<img src="/resources/homepage/dgportal/img/book_noimg.png" alt="${recommendOne.title}" title="${recommendOne.title}"/>
																		</c:when>
																		<c:otherwise>
																			<img src="/data/board/${recommendOne.manage_idx}/${recommendOne.board_idx}/${recommendOne.preview_img}" alt="${recommendOne.title}" title="${recommendOne.title}" />
																		</c:otherwise>
																	</c:choose>
																</dt>
																<dd>
																	<p class="daegubook-cont-01">  ${recommendOne.category2_name}<br/> 사서가 추천하는 BOOK'</p>
																	<p class="daegubook-cont-02">
																		<b>${recommendOne.title}</b><br/>
																			${recommendOne.imsi_v_3} / ${recommendOne.imsi_v_4} / ${recommendOne.imsi_v_2}<br/><br/>
																	</p>
																	<p>${recommendOne.imsi_v_7}</p>
																	<p class="daegubook-cont-03">${fn:substring(recommendOne.content_summary, 0, 90)}<c:if test="${fn:length(recommendOne.content_summary) > 90}">...</c:if></p>
																</dd>
															</dl>
														</a>
													</c:otherwise>
												</c:choose>

											</div>
										</div>
										<div class="end"></div>

									</div>
								</div>

								<div class="center top-cont-more">
									<a href="#fifthPage"><img src="/resources/homepage/${homepage.context_path}/img/top_down.png" alt=""></a>
								</div>
							</div>
						</a>
					</div>
					<div id="top-book-loc-05" class="top-book">
						<a href="#" id="top-book-05" class="top-book-act">
							<div class="top-book-content-05">

								<div class="content-05-box">
									<h3>05</h3>

									<div class="box">
										<div class="title">
											<span class="">큐레이션</span>
										</div>
										<div class="cont">
											<ul>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/231" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu25.png" alt="대구 이색도서관"></div>
														<p class="book-title">대구 이색도서관</p>
														<p class="book-desc">읽고, 보고, 머물고 싶은 대구의 이색 도서관</p>
														<p class="reg-date">2025-07-01</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/217" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu24.png" alt="이육사"></div>
														<p class="book-title">이육사</p>
														<p class="book-desc">독립을 노래하다</p>
														<p class="reg-date">2025-04-02</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/209" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu23.png" alt="그린대로"></div>
														<p class="book-title">그린대로</p>
														<p class="book-desc">대구 트윈세대 전용공간</p>
														<p class="reg-date">2025-01-03</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/202" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu22.png" alt="군위 어디까지 가봤니"></div>
														<p class="book-title">군위 어디까지 가봤니</p>
														<p class="book-desc">올가을엔 군위 나들이</p>
														<p class="reg-date">2024-10-02</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/193" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu21.png" alt="대구 빵지순례"></div>
														<p class="book-title">대구 빵지순례</p>
														<p class="book-desc">빵킷리스트 빵빵하게 채워보자!</p>
														<p class="reg-date">2024-07-01</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/186" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu20.png" alt="책 읽는 대구, 독서에 빠지다
"></div>
														<p class="book-title">책 읽는 대구, 독서에 빠지다</p>
														<p class="book-desc">책 읽는 도시, 대구와 함께 책의 매력에 빠져보세요</p>
														<p class="reg-date">2024-04-01</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/181" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu19.png" alt="2·28민주운동"></div>
														<p class="book-title">2·28민주운동</p>
														<p class="book-desc">대한민국 민주운동의 횃불</p>
														<p class="reg-date">2024-01-04</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/171" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu18.png" alt="국채보상운동기념도서관"></div>
														<p class="book-title">국채보상운동기념도서관</p>
														<p class="book-desc">새롭게 태어난 대구 지식인의 중심지</p>
														<p class="reg-date">2023-10-04</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/164" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu17.png" alt="대구문학관"></div>
														<p class="book-title">대구문학관</p>
														<p class="book-desc">대구 문학사가 살아 숨쉬는 곳</p>
														<p class="reg-date">2023-07-03</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/158" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu16.png" alt="지역작가"></div>
														<p class="book-title">대구 지역작가</p>
														<p class="book-desc">대구에서 활동중인 작가를 찾아서</p>
														<p class="reg-date">2023-05-10</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/132" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu15.png" alt="건축문화기행"></div>
														<p class="book-title">대구 건축문화기행</p>
														<p class="book-desc">천년대구를 거닐다</p>
														<p class="reg-date">2023-02-01</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/89" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu14.png" alt="9월은 독서의 달"></div>
														<p class="book-title">9월은 독서의 달</p>
														<p class="book-desc">가을엔 독서, 독서의 달 행사</p>
														<p class="reg-date">2022-09-16</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/88" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu13.png" alt="대구의 봄"></div>
														<p class="book-title">대구의 축제</p>
														<p class="book-desc">다시 찾아온 대구의 축제</p>
														<p class="reg-date">2022-07-01</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/87" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu12.png" alt="대구의 봄"></div>
														<p class="book-title">대구의 봄</p>
														<p class="book-desc">대구의 봄을 담은 명소</p>
														<p class="reg-date">2022-04-06</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/86" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu11.png" alt="추운 겨울, 방구석 독서"></div>
														<p class="book-title">추운 겨울, 방구석 독서</p>
														<p class="book-desc">방구석 독서로 따뜻한 겨울나기</p>
														<p class="reg-date">2022-01-17</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/85" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu10.png" alt="대구 전시관 여행"></div>
														<p class="book-title">관,관,관</p>
														<p class="book-desc">대구에서 만날 수 있는 전시관 여행</p>
														<p class="reg-date">2022-01-17</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/79" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu06.png" alt="3호선여행"></div>
														<p class="book-title">3호선여행</p>
														<p class="book-desc">3호선 타고 떠나는 대구여행</p>
														<p class="reg-date">2021-06-25</p>
													</a>
												</li>

												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/77" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu07.png" alt="대구근대문학"></div>
														<p class="book-title">대구근대문학</p>
														<p class="book-desc">대구 근대 문학의 발자취를 찾아서</p>
														<p class="reg-date">2021-06-25</p>
													</a>
												</li>

												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/80" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu08.png" alt="대구 숲,공원"></div>
														<p class="book-title">대구 숲,공원</p>
														<p class="book-desc">대구 힐링 명소</p>
														<p class="reg-date">2021-06-25</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/81" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu09.png" alt="대구벽화마을"></div>
														<p class="book-title">대구벽화마을</p>
														<p class="book-desc">벽화를 통한 골목의 재발견</p>
														<p class="reg-date">2021-06-25</p>
													</a>
												</li>
												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/72" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu01.png" alt="대구동네책방"></div>
														<p class="book-title">대구 동네책방</p>
														<p class="book-desc">책과 공간을 나누는 대구 동네책방 발견의 기쁨</p>
														<p class="reg-date">2020-12-10</p>
													</a>
												</li>

												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/75" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu02.png" alt="국채보상운동"></div>
														<p class="book-title">국채보상운동</p>
														<p class="book-desc">역사가 살아있는 대구, 국채보상운동 발자취를 따라서~</p>
														<p class="reg-date">2020-12-09</p>
													</a>
												</li>

												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/74" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu03.png" alt="대구 북카페"></div>
														<p class="book-title">대구 북카페</p>
														<p class="book-desc">이제, 독서도 우아하게</p>
														<p class="reg-date">2020-12-08</p>
													</a>
												</li>

												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/73" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu04.png" alt="대구 명소"></div>
														<p class="book-title">대구 명소</p>
														<p class="book-desc">즐기는 대구! 대구 속 명소 찾기</p>
														<p class="reg-date">2020-12-03</p>
													</a>
												</li>


												<li>
													<a href="http://www.icuration.co.kr:81/curation/w/71" target="_blank">
														<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu05.png" alt="대구지역출판사"></div>
														<p class="book-title">대구 지역출판사</p>
														<p class="book-desc">대구 지역의 출판사를 소개합니다!</p>
														<p class="reg-date">2020-12-02</p>
													</a>
												</li>

												</ul>
										</div>
									</div>
								</div>

								<div class="center top-cont-more">
									<a href="#sixthPage"><img src="/resources/homepage/${homepage.context_path}/img/top_down.png" alt=""></a>
								</div>

							</div>
						</a>
					</div>
					<div id="top-book-loc-06" class="top-book">
						<a href="#" id="top-book-06" class="top-book-act">
							<div class="top-book-content-06">

								<div class="content-06-box">
									<h3>06</h3>

									<div class="box">
										<div class="title">
											<span class="">주요서비스</span>
										</div>
										<div class="mTopIcon">
											<ul>
												<li>
													<a href="/${homepage.context_path}/board/index.do?menu_idx=18&manage_idx=287">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q7.png" alt="도서관찾기"></span>도서관찾기
													</a>
												</li>												
												<li>
													<a href="/${homepage.context_path}/html.do?menu_idx=68">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q4.png" alt="스마트도서관"></span>스마트도서관
													</a>
												</li>
												<li>
													<a href="/${homepage.context_path}/board/index.do?menu_idx=23&manage_idx=283">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q8.png" alt="작은도서관"></span>작은도서관
													</a>
												</li>
												<li>
													<a href="/elib/index.do" target="_blank">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q6.png" alt="대구전자도서관"></span>대구전자도서관
													</a>
												</li>

												<li>
													<a href="/${homepage.context_path}/html.do?menu_idx=101">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q9.png" alt="문화정보플랫폼"></span>문화정보플랫폼
													</a>
												</li>
												<li>
													<a href="https://library.daegu.go.kr/nearbylib/index.do" target="_blank">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q10.png" alt="내 집 앞 도서관"></span>내 집 앞 도서관
													</a>
												</li>
												<li>
													<a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=35">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q3.png" alt="예약현황"></span>예약현황
													</a>
												</li>
													<li>
													<a href="/${homepage.context_path}/intro/join/changeover.do?menu_idx=71">
														<span><img src="/resources/homepage/${homepage.context_path}/img/q5.png" alt="비대면인증"></span>비대면인증
													</a>
												</li>												

											</ul>
										</div>
										<div class="end"></div>

									</div>
								</div>

								<div class="center top-cont-more">
									<a href="#seventhPage"><img src="/resources/homepage/${homepage.context_path}/img/top_down.png" alt=""></a>
								</div>
							</div>
						</a>
					</div>
				</div>
			</div>
			<a href="#secondPage"><div class="main_scroll"><div class="main_scroll_wp_white">scroll down</div></div></a>

			<!--내집앞도서관-->
			<span class="nearbylib-btn">
				<a href="https://library.daegu.go.kr/nearbylib/index.do" class="btn-open" target="_blank">
					<img src="/resources/homepage/${homepage.context_path}/img/nearbylib-homepage-go-btn.png" alt="">
				</a>
			</span>
			<!--//내집앞도서관-->
		</div>
		<!-- //main0 -->

		<!-- section1 -->
		<div class="section" id="main1">
			<div class='wide-1686-sections'>

				<div class="notice-box">
					<h2 class="title">공지사항</h2>
					<div class="news con" >
						<div class="box">
							<ul>
								<!--li>
									<a href="/dgportal/board/view.do?menu_idx=22&manage_idx=282&board_idx=492616&group_idx=0&rowCount=10&viewPage=1&searchStartDate=2022-04-25&searchEndDate=2023-04-25&search_type=title%2Bcontent" class="wrap" target="_blank">
										<span class="date sangdan">2023.<br class="webList"/><b>04.25</b></span>
										<span class="link libraryTonghap"><p style="line-height:100%;font-size:12px;color:#fff;">내집앞<br/>도서관</p></span>
										<span class="tit titleyewe">내 집 앞 도서관 홍보를 위한 딱 10일간 특별한 이벤트!</span>
									</a>
								</li-->
								<li>
									<a href="/dgportal/board/view.do?menu_idx=22&manage_idx=282&board_idx=488487&group_idx=0&rowCount=10&viewPage=1&searchStartDate=2022-02-11&searchEndDate=2023-02-11&search_type=title%2Bcontent" class="wrap" target="_blank">
										<span class="date sangdan">2023.<br class="webList"/><b>02.10</b></span>
										<span class="link libraryTonghap"><p style="line-height:100%;font-size:12px;color:#fff;">내집앞<br/>도서관</p></span>
										<span class="tit titleyewe">생활 속 가까이 누리는 기쁨 '내  집  앞  도서관' 서비스  안내</span>
									</a>
								</li>
								<c:forEach items="${noticeBoardList}" var="i" varStatus="status" begin='0' end='3'>
								<li>
									<a href="/${i.imsi_v_19}/board/view.do?manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&menu_idx=${i.imsi_n_2}" class="wrap" target="_blank">
										<span class="date"><fmt:formatDate value="${i.add_date}" pattern="yyyy."/><br class="webList"/><b><fmt:formatDate value="${i.add_date}" pattern="MM.dd"/></b></span>
										<span class="link library${i.imsi_v_19}"><c:if test="${i.imsi_v_19 eq 'nearbylib'}">통합</c:if>${i.imsi_v_20}</span>
										<span class="tit title${i.imsi_v_19}">${i.title}</span>
									</a>
								</li>
								</c:forEach>
							

							</ul>
						</div>
					</div>
					<div class="more-btn">
						<a href="/${homepage.context_path}/board/index.do?menu_idx=22&manage_idx=282"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
					</div>
				</div>

				<div class="popupzone-box">
					<h2 class="title">팝업존</h2>
					<div class="popZone">
						<c:choose>
							<c:when test="${fn:length(popupZoneList) > 0}">
								<homepageTag:popupZone popupZoneList="${popupZoneList}" />
							</c:when>
							<c:otherwise>
								<ul>
									<li><a href="#"><img src="/resources/homepage/${homepage.context_path}/img/popupzone-img01.png" alt="등록된 팝업존이 없습니다." /></a></li>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>

		</div>
		<!-- //main1 -->

		<!-- main2 통합자료검색-->
		<div class="section" id="main2">
			<div class="main2_tit">
				<h2 class="title"><b>통합자료검색</b></h2>
				<p class="tit_text">대구지역 도서관의 자료를 쉽고 빠르게 검색해보세요.</p>
			</div>

			<!-- main_search -->
			<div class="search-area" id="main_search">
				<form id="mainSearchForm" action="/dgportal/intro/search/indexAll.do">
				<input type="hidden" name="menu_idx" value="7">
				<input type="hidden" name="booktype" value="BOOKANDNONBOOK">
				<fieldset>
					<legend class="blind">통합검색</legend>
					<div class="main-box">
						<div class="box1">
							<div class="box2">
								<label for="search_text_1" class="blind">통합자료검색</label>
								<input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
							</div>
						</div>
						<button id="main-search-btn">검색하기</button>
					</div>
				</fieldset>
				
				<div class="wide-1260-sections">
					<div class="map-wrap">
						<div class="main2-box left-box">

							<div class="libraryMap">
								<div class="map-area">
									<!-- <img src="/resources/homepage/${homepage.context_path}/img/map.png" alt="대구지도"> -->
									<img src="/resources/homepage/${homepage.context_path}/img/map_new.png" alt="대구지도">
									<ul>
										<li class="dglib01"><a href="#link" data-num="1"><p>동구</p></a></li>
										<li class="dglib02"><a href="#link" data-num="2"><p>서구</p></a></li>
										<li class="dglib03"><a href="#link" data-num="3"><p>남구</p></a></li>
										<li class="dglib04"><a href="#link" data-num="4"><p>북구</p></a></li>
										<li class="dglib05"><a href="#link" data-num="5"><p>수성구</p></a></li>
										<li class="dglib06 on"><a href="#link" data-num="6"><p>중구</p></a></li>
										<li class="dglib07"><a href="#link" data-num="7"><p>달서구</p></a></li>
										<li class="dglib08"><a href="#link" data-num="8"><p>달성군</p></a></li>
										<li class="dglib09"><a href="#link" data-num="9"><p>달성군</p></a></li>
										<li class="dglib010"><a href="#link" data-num="10"><p>군위군</p></a></li>
									</ul>
								</div>
							</div>

						</div>

						<div class="main2-box right-box">

							<div class="librarySearch">

								<div class="searchArea-box">
									<select id="searchArea" class="searchArea">
										<option value="1" style="color:#000;">동구</option>
										<option value="2" style="color:#000;">서구</option>
										<option value="3" style="color:#000;">남구</option>
										<option value="4" style="color:#000;">북구</option>
										<option value="5" style="color:#000;">수성구</option>
										<option value="6" style="color:#000;">중구</option>
										<option value="7" style="color:#000;">달서구</option>
										<option value="8" style="color:#000;">달성군</option>
										<option value="10" style="color:#000;">군위군</option>
									</select>
								</div>

								<div id="lib1" class="libraryInfo" style="display:none;">
									<h3 class="name">동구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/donggulocation.do?menu_idx=90" title="동구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll1" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll1">전체</label> 
										<input id="libraryCodesSi1" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi1">시립</label> 
										<input id="libraryCodesGu1" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu1">구군립</label> 
										<input id="libraryCodesSa1" class="libraryCodesSa" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSa1">사립공공·전문</label> 
										<input id="libraryCodesSm1" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm1">작은</label>
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes11" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AH"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes11">동부도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dongbu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/dongbu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes12" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes12">2ㆍ28기념학생도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/228/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/228/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes127" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="HU"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes12">대구혁신도시 복합문화센터</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/center/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/center/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes13" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="CA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes13">안심도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes14" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="CB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes14">신천도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/sincheon/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes125" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NJ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes125">한들마을도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/handle/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/handle/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes126" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes126">동일도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dongil/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dongil/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes15" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GR"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes15">신암2동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes16" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GS"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes16">신암3동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes17" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HJ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes17">신암5동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes18" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FK"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes18">신천3동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes19" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GT"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes19">효목1동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes110" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FP"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes110">효목2동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes111" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FL"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes111">도평동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes112" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GU"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes112">불로어울림작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes113" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GV"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes113">지저동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes114" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GW"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes114">동촌역사작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes115" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GX"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes115">방촌동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes116" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GY"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes116">해안동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes117" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FM"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes117">반야월역사작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<!--
										<li>
											<input id="libraryCodes118" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GZ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes118">동구청작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										-->
										<li>
											<input id="libraryCodes119" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HK"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes119">늘푸른작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<!-- 초록우산작은도서관 잠정 운영중단으로 인한 주석처리  -->
										<%-- <li>
											<input id="libraryCodes120" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HL"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes120">초록우산작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li> --%>
										<li>
											<input id="libraryCodes121" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HM"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes121">꿈날자문고작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes122" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HN"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes122">행복작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes123" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HP"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes123">율하북작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/donggusm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/donggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
									</ul>
									</div>
								</div>

								<div id="lib2" class="libraryInfo" style="display:none;">
									<h3 class="name">서구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/seogulocation.do?menu_idx=91" title="서구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll2" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll2">전체</label> 
										<input id="libraryCodesSi2" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi2">시립</label> 
										<input id="libraryCodesGu2" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu2">구군립</label> 
										<input id="libraryCodesSm2" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm2">작은</label>
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes21" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AF"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes21">서부도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seobu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/seobu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes22" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BL"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes22">서구어린이도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes23" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BQ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes23">비산도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/bisan/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes24" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BP"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes24">서구영어도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seoguenglish/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes25" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BM"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes25">비원도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/biwon/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes26" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BN"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes26">원고개도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/wongogae/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes27" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="CC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes27">New평리도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/newPyeongni/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes27" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="HT"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes27">서구어린이영어도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/kidsEnglish/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
<!-- 										<li>
											<input id="libraryCodes40" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BL"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes40">New평리도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li> -->

										<li>
											<input id="libraryCodes28" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GQ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes28">내당2,3동 드림도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes29" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FU"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes29">내당4동어린이도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes210" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FZ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes210">비산7동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes211" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FH"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes211">새마을문고대구서구지부작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes212" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FT"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes212">서구청작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes213" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes213">달성토성마을다락방작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/seogulib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
									</ul>
									</div>
								</div>

								<div id="lib3" class="libraryInfo" style="display:none;">
									<h3 class="name">남구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/namgulocation.do?menu_idx=92" title="남구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll3" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll3">전체</label> 
										<input id="libraryCodesSi3" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi3">시립</label> 
										<input id="libraryCodesGu3" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu3">구군립</label> 
										<input id="libraryCodesSm13" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm3">작은</label>
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes31" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes31">남부도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/nambu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/nambu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes32" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BT"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes32">이천어울림도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/namic/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/namic/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes33" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BS"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes33">대명어울림도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/namdm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/namdm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes34" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FE"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes34">꿈틀작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/namic/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/namic/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
									</ul>
									</div>
								</div>

								<div id="lib4" class="libraryInfo" style="display:none;">
									<h3 class="name">북구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/bukgulocation.do?menu_idx=93" title="북구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll4" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll4">전체</label> 
										<input id="libraryCodesSi4" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi4">시립</label> 
										<input id="libraryCodesGu4" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu4">구군립</label>
										<input id="libraryCodesSa4" class="libraryCodesSa" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSa4">사립공공·전문</label> 
										<input id="libraryCodesSm4" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm4">작은</label>	
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes41" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes41">북부도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/bukbu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/bukbu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes42" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes42">구수산도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes43" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes43">태전도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buktj/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/buktj/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes44" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes44">대현도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/bukdh/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukdh/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes102" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="HW"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes102">서변숲도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksb/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/buksb/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>


										<li>
											<input id="libraryCodes413" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes413">더불어숲도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/with/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/with/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes414" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes414">꿈꾸는마을도토리도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dotory/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dotory/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes415" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="ND"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes415">연암도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/yeonam/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/yeonam/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

<!--
										<li>
											<input id="libraryCodes45" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GJ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes45">태전1동 작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
-->
										<li>
											<input id="libraryCodes610" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FV"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes610">시청작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dmsl/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dmsl/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes46" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GL"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes46">산격1동 작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes47" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GM"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes47">북구영어작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes48" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GN"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes48">침산1동 작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes410" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes410">서변동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes411" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HD"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes411">노원행복도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes412" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HE"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes412">한강공원부키도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/buksm/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/bukgs/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

									</ul>
									</div>
								</div>

								<div id="lib5" class="libraryInfo" style="display:none;">
									<h3 class="name">수성구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/suseonggulocation.do?menu_idx=95" title="수성구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll5" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll5">전체</label> 
										<input id="libraryCodesSi5" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi5">시립</label> 
										<input id="libraryCodesGu5" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu5">구군립</label>
										<input id="libraryCodesSm5" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm5">작은</label>	
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes51" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AP"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes51">수성도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/suseong/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/suseong/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes52" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BD"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes52">범어도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/beomeo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/beomeo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes53" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BE"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes53">용학도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/yonghak/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/yonghak/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes54" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BF"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes54">고산도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/gosan/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/gosan/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes55" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes55">파동도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/padong/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/yonghak/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes56" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BH"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes56">무학숲도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/muhaksup/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/yonghak/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes57" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BJ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes57">책숲길도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/bookforest/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/beomeo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes58" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BK"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes58">물망이도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/mulmangi/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/beomeo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>


										<li>
											<input id="libraryCodes59" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="FG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes59">황금책문화센터도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/goldbook/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/beomeo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>


										<li>
											<input id="libraryCodes60" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="HS"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes60">수성못그림책도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/suseongLake/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href=" https://library.daegu.go.kr/yonghak/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes61" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes61">사월책문화센터도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/sawol/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/gosan/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
									</ul>
									</div>
								</div>

								<div id="lib6" class="libraryInfo">
									<h3 class="name">중구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/junggulocation.do?menu_idx=94" title="중구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll6" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll6">전체</label> 
										<input id="libraryCodesSi6" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi6">시립</label> 
										<input id="libraryCodesGu6"class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu6">구군립</label> 
										<input id="libraryCodesSm6" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm6">작은</label>	
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes61" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AD"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes61">국채보상운동기념도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/gukbo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/gukbo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes62" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AL"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes62">2ㆍ28민주운동기념회관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/228lib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/228lib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes63" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="FS"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes63">중구영어도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes64" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FF"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes64">남산4동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes65" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FQ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes65">동인 느티나무 도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes66" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FY"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes66">중구청교양정보실</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes67" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes67">대신동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes68" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes68">삼덕마루 작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes69" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HF"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes69">대봉2동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/junggu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
<!-- 										<li>
											<input id="libraryCodes610" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FV"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes610">시청작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dmsl/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dmsl/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li> -->
									</ul>
									</div>
								</div>

								<div id="lib7" class="libraryInfo" style="display:none;">
									<h3 class="name">달서구</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/dalseogulocation.do?menu_idx=96" title="달서구 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll7" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll7">전체</label> 
										<input id="libraryCodesSi7" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi7">시립</label> 
										<input id="libraryCodesGu7" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu7">구군립</label> 
										<input id="libraryCodesSa7" class="libraryCodesSa" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSa7">사립공공·전문</label> 
										<input id="libraryCodesSm7" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm7">작은</label>	
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes71" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes71">두류도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/duryu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/duryu/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes72" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BU"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes72">성서도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/seongseo/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes73" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BV"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes73">달서어린이도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/kids/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes74" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BW"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes74">도원도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes75" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BX"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes75">본리도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/bolli/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes76" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BY"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes76">달서가족문화도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/family/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes77" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BZ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes77">달서영어도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/english/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes717" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib04">전문</span>
											<label for="libraryCodes717">점자도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/daegubl/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/daegubl/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes716" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NE"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes716">새벗도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/saebut/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/saebut/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>


										<li>
											<input id="libraryCodes718" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NH"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes718">푸른초장공공도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/wasabi/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/wasabi/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes78" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes78">이곡2동공립작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes79" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes79">용산1동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes710" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes710">장기동작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes711" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FD"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes711">죽전동공립작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<!-- <li>
											<input id="libraryCodes712" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FW"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes712">달서아트센터 도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li> -->
										<li>
											<input id="libraryCodes713" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FX"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes713">행정정보문고센터</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes714" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GK"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes714">학산작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseolib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes715" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="AK"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes715">학생문화센터</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/std/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="http://www.dge.go.kr/dccs/main.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
									</ul>
									</div>
								</div>

								<div id="lib8" class="libraryInfo" style="display:none;">
									<h3 class="name">달성군</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/dalseonggunlocation.do?menu_idx=97" title="달성군 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll8" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll8">전체</label> 
										<input id="libraryCodesSi8" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi8">시립</label> 
										<input id="libraryCodesGu8" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu8">구군립</label> 
										<input id="libraryCodesSa8" class="libraryCodesSa" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSa8">사립공공·전문</label> 
										<input id="libraryCodesSm8" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm8">작은</label>	
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes81" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AJ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes81">달성도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseong/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/dalseong/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
										<li>
											<input id="libraryCodes82" name="libraryCodes" class="libraryCodesGuCheck" type="checkbox" value="BR"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">구군립</span>
											<label for="libraryCodes82">달성군립도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

										<li>
											<input id="libraryCodes814" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NK"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib04">전문</span>
											<label for="libraryCodes814">아트도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/art/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/art/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>

<!-- 										<li>
											<input id="libraryCodes815" name="libraryCodes" class="libraryCodesSaCheck" type="checkbox" value="NF"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib03">사립공공</span>
											<label for="libraryCodes815">비전도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/vision/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/vision/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li> -->

										<li>
											<input id="libraryCodes83" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GA"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes83">화원읍작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes84" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GB"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes84">논공읍작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes85" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="HG"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes85">다사읍작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes86" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GD"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes86">다사읍서재작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes87" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GF"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes87">유가읍작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes88" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GH"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes88">옥포읍작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes89" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FR"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes89">가창면참꽃작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes810" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GE"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes810">하빈면작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes811" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="GC"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes811">구지면작은도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes812" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FN"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes812">달성군청소년센터</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
										<li>
											<input id="libraryCodes813" name="libraryCodes" class="libraryCodesSmCheck" type="checkbox" value="FJ"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib02">작은</span>
											<label for="libraryCodes813">달성군청도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="/dalseonglib/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
										</li>
									</ul>
									</div>
								</div>

								<div id="lib10" class="libraryInfo" style="display:none;">
									<h3 class="name">군위군</h3>
									<a href="https://library.daegu.go.kr/dgportal/html/gunwilocation.do?menu_idx=108" title="달성군 도서관 찾아오시는길 페이지 바로 가기" class="detail-map-btn">찾아오시는길</a>
									<div class="selection01">
										<input id="libraryCodesAll10" class="libraryCodesAll" name="libraryCodes" type="checkbox" /> <label for="libraryCodesAll10">전체</label> 
										<input id="libraryCodesSi10" class="libraryCodesSi" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSi10">시립</label> 
										<input id="libraryCodesGu10" class="libraryCodesGu" name="libraryCodes" type="checkbox" /> <label for="libraryCodesGu10">구군립</label> 
										<input id="libraryCodesSa10" class="libraryCodesSa" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSa10">사립공공·전문</label> 
										<input id="libraryCodesSm10" class="libraryCodesSm" name="libraryCodes" type="checkbox" /> <label for="libraryCodesSm10">작은</label>	
									</div>
									<div class="comment">
										<img src="/resources/homepage/${homepage.context_path}/img/use-check-ment.png" alt="검색대, 홈페이지 설명">
									</div>
									<div class="selection02 mCustomScrollbar light" data-mcs-theme="minimal-dark">
									<ul>
										<li>
											<input id="libraryCodes101" name="libraryCodes" class="libraryCodesSiCheck" type="checkbox" value="AM"/>
											<input type="hidden" name="_libraryCodes" value="on"/>
											<span class="lib01">시립</span>
											<label for="libraryCodes101">삼국유사군위도서관</label>
											<span class="go-link">
												<a href="https://library.daegu.go.kr/intro/gw/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/books-icon.png" alt="검색대바로가기"></a>
												<a href="https://library.daegu.go.kr/gw/index.do" target="_blank"><img src="/resources/homepage/${homepage.context_path}/img/homepage-icon.png" alt="홈페이지바로가기"></a>
											</span>
											
										</li>
									</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				</form>
			</div>
			<!-- //Main_search -->
		</div>
		<!-- //main2 -->
		<!-- custom scrollbar plugin -->
		<script src="/resources/common/js/jquery.mCustomScrollbar.concat.min.js"></script>

		<!-- main3 평생교육강좌-->
		<div class="section" id="main3">
			<div class="main2_tit">
				<h2 class="title"><b>평생교육강좌</b></h2>
				<p class="tit_text">대구통합도서관의 다양한 강좌 프로그램을 체험해보세요.</p>
			</div>

			<div class='wide-1686-sections'>
				<div class="cont cultureList">
					<ul>
						<c:set var="imgnum" value="1"></c:set>
						<c:forEach items="${teachList}" var="i" varStatus="status" begin='0' end='7'>
						<li>
							<a href="/${i.context_path}/module/teach/detail.do?homepage_id=${i.homepage_id}&group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=${i.menu_idx}&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}" class="border bgimg00${imgnum}" target="_blank">
								<span class="status">${i.teach_status eq '6' ? '접수대기' : '접수중'}</span>
								<span class="txt">
									<p class="lib-name">${i.homepage_name}</p>
									<p class="tit">${fn:substring(i.teach_name, 0, 15)}<c:if test="${fn:length(i.teach_name) > 17}">...</c:if></p>
									<p class="len"><b>접수</b> ${i.start_join_date} ~ ${i.end_join_date}</p>
								</span>
							</a>
						</li>
							<c:if test="${imgnum eq '4'}">
								<c:set var="imgnum" value="0"></c:set>
							</c:if>
							<c:if test="${imgnum ne '4'}">
								<c:set var="imgnum" value="${imgnum + 1}"></c:set>
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(teachList) < 1}">
							<li>
								등록된 행사가 없습니다.
							</li>
						</c:if>
					</ul>
				</div>
			</div>

			<div class="more-btn">
				<a href="/libculture/module/culture/teach.do?menu_idx=1"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
			</div>
			<div class="end"></div>

		</div>
		<!-- //main3 -->

		<!-- main4 사서추천, 대구의bOOK-->
		<div class="section" id="main4">
			<div class="main4_wrap">

				<div class='wide-1686-sections'>

					<div class="recommand-box">
						<div class="main2_tit">
							<h2 class="title"><b>사서 추천 BOOK’</b></h2>
							<p class="tit_text">이 책 어떠세요?</p>
						</div>
						<div class="title">
							<p>
								<select id="recommendBook1" class="recommendSite1">
									<c:forEach items="${category2List}" var="cate2">
									<option value="${cate2.code_id}" style="color:#000;">${cate2.code_name}</option>
									</c:forEach>
								</select>
							</p>
						</div>
						<div class="book">
							<div class="box con">
								<ul class="book_photo newBookUl">
								</ul>
							</div>
						</div>
						<div class="more-btn">
							<a href="board/index.do?menu_idx=67&manage_idx=299"><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
						</div>
					</div>

					<div class="daegubook-box">
						<div class="main2_tit">
							<h2 class="title"><b>대구의 BOOK’</b></h2>
							<p class="tit_text">북모닝 대구! 올해의 한책</p>
						</div>
						<div class="daegubook">
							<div class="box con">
								<dl>
									<dt>
										<p>
											<b>당신이 옳다<br/>(정혜신의 적정심리학)</b><br/>
											정혜신 / 해냄출판사 / 2018<br/><br/>
										</p>
										<p class="ment">
											사회적 재난 현장부터 일상의 순간까지 고통
											받는 이들과 함께해온 정신과 의사 정혜신은 
											우리에게 '심리적 CPR(심폐소생술)'이 절실
											하다고 진단한다. 최근 15년 간 진료실을 벗
											어나 보통 사람들은 물론 트라우마 피해자부
											터 CEO까지 다양한 이들의 속마음을...
										</p>
									</dt>
									<dd><a href="html.do?menu_idx=8"><img src="/resources/homepage/${homepage.context_path}/img/daegu-book.png" alt="당신이 옳다" /></a></dd>
								</dl>
							</div>
						</div>

						<div class="more-btn">
							<a href="html.do?menu_idx=8"><img src="/resources/homepage/${homepage.context_path}/img/more-btn_b.png" alt="더보기" /></a>
						</div>
					</div>

				</div>

			</div>
		</div>

		<!-- main5 큐레이션-->
		<div class="section" id="main5">
			<div class="main2_tit">
				<h2 class="title"><b>큐레이션</b></h2>
				<p class="tit_text">다양한 컨텐츠를 제공해 드리는 맞춤형 서비스</p>
			</div>

			<div class='wide-1686-sections'>
				<div class="cont curationList">
					<ul>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/231" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu25.png" alt="대구 이색도서관"></div>
							<h3 class="book-title">대구 이색도서관</h3>
							<p class="book-desc">읽고, 보고, 머물고 싶은 대구의 이색 도서관</p>
							<p class="reg-date">2025-07-01</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/217" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu24.png" alt="이육사"></div>
							<h3 class="book-title">이육사</h3>
							<p class="book-desc">독립을 노래하다</p>
							<p class="reg-date">2025-04-02</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/209" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu23.png" alt="그린대로"></div>
							<h3 class="book-title">그린대로</h3>
							<p class="book-desc">대구 트윈세대 전용공간</p>
							<p class="reg-date">2025-01-03</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/202" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu22.png" alt="군위 어디까지 가봤니"></div>
							<h3 class="book-title">군위 어디까지 가봤니</h3>
							<p class="book-desc">올가을엔 군위 나들이</p>
							<p class="reg-date">2024-10-02</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/193" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu21.png" alt="대구 빵지순례"></div>
							<h3 class="book-title">대구 빵지순례</h3>
							<p class="book-desc">빵킷리스트 빵빵하게 채워보자!</p>
							<p class="reg-date">2024-07-01</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/186" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu20.png" alt="책 읽는 대구, 독서에 빠지다"></div>
							<h3 class="book-title">책 읽는 대구, 독서에 빠지다</h3>
							<p class="book-desc">책 읽는 도시, 대구와 함께 책의 매력에 빠져보세요</p>
							<p class="reg-date">2024-04-01</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/181" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu19.png" alt="2·28민주운동"></div>
							<h3 class="book-title">2·28민주운동</h3>
							<p class="book-desc">대한민국 민주운동의 횃불</p>
							<p class="reg-date">2024-01-04</p>
						</a>
					</li>
					<li>
						<a href="http://www.icuration.co.kr:81/curation/w/171" target="_blank">
							<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu18.png" alt="국채보상운동기념도서관"></div>
							<h3 class="book-title">국채보상운동기념도서관</h3>
							<p class="book-desc">새롭게 태어난 대구 지식인의 중심지</p>
							<p class="reg-date">2023-10-04</p>
						</a>
					</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/164" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu17.png" alt="대구문학관"></div>
								<h3 class="book-title">대구문학관</h3>
								<p class="book-desc">대구 문학사가 살아 숨쉬는 곳</p>
								<p class="reg-date">2023-07-03</p>
							</a>
						</li>	
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/158" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu16.png" alt="지역작가"></div>
								<h3 class="book-title">대구 지역작가</h3>
								<p class="book-desc">대구에서 활동중인 작가를 찾아서</p>
								<p class="reg-date">2023-05-10</p>
							</a>
						</li>	
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/132" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu15.png" alt="건축문화기행"></div>
								<h3 class="book-title">대구 건축문화기행</h3>
								<p class="book-desc">천년대구를 거닐다</p>
								<p class="reg-date">2023-02-01</p>
							</a>
						</li>							
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/89" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu14.png" alt="9월은 독서의 달"></div>
								<h3 class="book-title">9월은 독서의 달</h3>
								<p class="book-desc">가을엔 독서, 독서의 달 행사</p>
								<p class="reg-date">2022-09-16</p>
							</a>
						</li>							
						
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/88" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu13.png" alt="대구의 봄"></div>
								<h3 class="book-title">대구의 축제</h3>
								<p class="book-desc">다시 찾아온 대구의 축제</p>
								<p class="reg-date">2022-07-01</p>
							</a>
						</li>						
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/87" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu12.png" alt="대구의 봄"></div>
								<h3 class="book-title">대구의 봄</h3>
								<p class="book-desc">대구의 봄을 담은 명소</p>
								<p class="reg-date">2022-04-06</p>
							</a>
						</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/86" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu11.png" alt="추운 겨울, 방구석 독서"></div>
								<h3 class="book-title">추운 겨울, 방구석 독서</h3>
								<p class="book-desc">방구석 독서로 따뜻한 겨울나기</p>
								<p class="reg-date">2022-01-17</p>
							</a>
						</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/85" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu10.png" alt="대구 전시관 여행"></div>
								<h3 class="book-title">관,관,관</h3>
								<p class="book-desc">대구에서 만날 수 있는 전시관 여행</p>
								<p class="reg-date">2022-01-17</p>
							</a>
						</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/79" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu06.png" alt="3호선여행"></div>
								<h3 class="book-title">3호선여행</h3>
								<p class="book-desc">3호선 타고 떠나는 대구여행</p>
								<p class="reg-date">2021-06-25</p>
							</a>
						</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/77" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu07.png" alt="대구근대문학"></div>
								<h3 class="book-title">대구근대문학</h3>
								<p class="book-desc">대구 근대 문학의 발자취를 찾아서</p>
								<p class="reg-date">2021-06-25</p>
							</a>
						</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/80" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu08.png" alt="대구 숲,공원"></div>
								<h3 class="book-title">대구 숲,공원</h3>
								<p class="book-desc">대구 힐링 명소</p>
								<p class="reg-date">2021-06-25</p>
							</a>
						</li>
						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/81" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu09.png" alt="대구벽화마을"></div>
								<h3 class="book-title">대구벽화마을</h3>
								<p class="book-desc">벽화를 통한 골목의 재발견</p>
								<p class="reg-date">2021-06-25</p>
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/72" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu01.png" alt="대구동네책방"></div>
								<h3 class="book-title">대구 동네책방</h3>
								<p class="book-desc">책과 공간을 나누는 대구 동네책방 발견의 기쁨</p>
								<p class="reg-date">2020-12-10</p>
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/75" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu02.png" alt="국채보상운동"></div>
								<h3 class="book-title">국채보상운동</h3>
								<p class="book-desc">역사가 살아있는 대구, 국채보상운동 발자취를 따라서~</p>
								<p class="reg-date">2020-12-09</p>
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/74" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu03.png" alt="대구 북카페"></div>
								<h3 class="book-title">대구 북카페</h3>
								<p class="book-desc">이제, 독서도 우아하게</p>
								<p class="reg-date">2020-12-08</p>
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/73" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu04.png" alt="대구 명소"></div>
								<h3 class="book-title">대구 명소</h3>
								<p class="book-desc">즐기는 대구! 대구 속 명소 찾기</p>
								<p class="reg-date">2020-12-03</p>
							</a>
						</li>

						<li>
							<a href="http://www.icuration.co.kr:81/curation/w/71" target="_blank">
								<div class="thumbnail"><img src="/resources/homepage/${homepage.context_path}/img/cu05.png" alt="대구지역출판사"></div>
								<h3 class="book-title">대구 지역출판사</h3>
								<p class="book-desc">대구 지역의 출판사를 소개합니다!</p>
								<p class="reg-date">2020-12-02</p>
							</a>
						</li>

					</ul>
				</div>
			</div>
			<!--div class="more-btn">
				<a href=""><img src="/resources/homepage/${homepage.context_path}/img/more-btn.png" alt="더보기" /></a>
			</div-->
		</div>

		<!-- main6 주요서비스-->
		<div class="section" id="main6">

			<div class="main2_tit">
				<h2 class="title"><b>주요서비스</b></h2>
				<p class="tit_text">대구통합도서관은 다양한 서비스를 제공합니다.</p>
			</div>
			
			<div class="mIcon">
				<ul>
					<li>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=18&manage_idx=287">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q7.png" alt="도서관찾기"><br/>도서관찾기</span>
						</a>
					</li>									
					<li>
						<a href="/${homepage.context_path}/html.do?menu_idx=68">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q4.png" alt="스마트도서관"><br/>스마트도서관</span>
						</a>
					</li>
					<li>
						<a href="/${homepage.context_path}/board/index.do?menu_idx=23&manage_idx=283">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q8.png" alt="작은도서관"><br/>작은도서관</span>
						</a>
					</li>
					<li>
						<a href="/elib/index.do" target="_blank">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q6.png" alt="대구전자도서관"><br/>대구전자도서관</span>
						</a>
					</li>

					<li>
						<a href="/${homepage.context_path}/html.do?menu_idx=101">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q9.png" alt="문화정보플랫폼"><br/>문화정보플랫폼</span>
						</a>
					</li>
					<li>
						<a href="https://library.daegu.go.kr/nearbylib/index.do" target="_blank">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q10.png" alt="내 집 앞 도서관"><br/>내 집 앞 도서관</span>
						</a>
					</li>
					<li>
						<a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=35">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q3.png" alt="예약현황"><br/>예약현황</span>
						</a>
					</li>
					<li>
						<a href="/${homepage.context_path}/intro/join/changeover.do?menu_idx=71">
							<span><img src="/resources/homepage/${homepage.context_path}/img/q5.png" alt="비대면인증"><br/>비대면인증</span>
						</a>
					</li>				

				</ul>
			</div>
			<div class="end"></div>

			<div class="mBtn">
				<ul>
					<li>
						<a href="https://books.nl.go.kr/PU/contents/P20202000000.do" target="_blank" title="책이음 홈페이지 바로가기(새창열림)" class="b01">
							책이음
						</a>
					</li>
					<li>
						<a href="https://books.nl.go.kr/PU/contents/P10206000000.do" target="_blank" title="책바다 홈페이지 바로가기(새창열림)" class="b02">
							책바다
						</a>
					</li>
					<li>
						<a href="https://cn.nld.go.kr/index.do" target="_blank" title="책나래 홈페이지 바로가기(새창열림)" class="b03">
							책나래
						</a>
					</li>
				</ul>
			</div>
		</div>

		<!-- footer_section -->
		<div class="section fp-auto-height footer_area" id="foot_section">
			<tiles:insertAttribute name="footer" />

			<div class="home-up web-view">
				<a href="#firstPage"><img src="/resources/homepage/dgportal/img/m-top.png" alt="위로" class="homeup"></a>
			</div>

			<div class="home-up mobile-view">
				<img src="/resources/homepage/dgportal/img/m-top.png" alt="위로" id="homeup">
			</div>
		</div>
		<!-- //footer_section -->

	</div>


</div>


<script type="text/javascript">
function fullPage() {
	var myFullpage = new fullpage('#fullpage', {
		anchors: ['firstPage', 'secondPage', 'thirdPage','fourthPage','fifthPage','sixthPage','seventhPage'],
		navigation:true,
		showActiveTooltip: true,
		menu: '#menu',
		responsiveWidth: 1025,
		afterLoad: function(origin, destination, direction){
			var cur_page = destination.index+1;
			if (destination.index == 0 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(213, 213, 213, 0.3)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid rgba(213, 213, 213, 0.3)');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').addClass("background-white");
					$('.Gnb').css("border-bottom","1px solid rgba(213, 213, 213, 0.3)");
					$('.Gnb').css('background','none');
					$('.tnb').css('background','none');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				});
			}  else if( destination.index == 1 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});
			}	else if( destination.index == 2 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').addClass("background-white");
					$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
					$('.Gnb').css('background','none');
					$('.tnb').css('background','none');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				});
			}  else if( destination.index == 3 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').addClass("background-white");
					$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
					$('.Gnb').css('background','none');
					$('.tnb').css('background','none');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				});
			}  else if( destination.index == 4 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});
			}  else if( destination.index == 5 ) {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});
			}  else if( destination.index == 6 ) {
				$('#header').addClass("background-white");
				$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
				$('.Gnb').css('background','none');
				$('.tnb').css('background','none');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').addClass("background-white");
					$('.Gnb').css("border-bottom","1px solid rgba(255,255,255,0.2)");
					$('.Gnb').css('background','none');
					$('.tnb').css('background','none');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon.png');
				});
			} else {
				$('#header').removeClass("background-white");
				$('.Gnb').css('border-bottom','1px solid #e6e6e6');
				$('.Gnb').css('background','#fff');
				$('.tnb').css('background','#fff');
				$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
				$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
				$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
				$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');

				$('.Gnb, .tnb').on('mouseenter', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});

				$('.Gnb, .tnb').on('mouseleave', function(){
					$('#header').removeClass("background-white");
					$('.Gnb').css('border-bottom','1px solid #e6e6e6');
					$('.Gnb').css('background','#fff');
					$('.tnb').css('background','#fff');
					$('.tnb-login').attr('src','/resources/homepage/${homepage.context_path}/img/login_icon_b.png');
					$('.tnb-logout').attr('src','/resources/homepage/${homepage.context_path}/img/logout_icon_b.png');
					$('.tnb-join').attr('src','/resources/homepage/${homepage.context_path}/img/join_icon_b.png');
					$('.tnb-sitemap').attr('src','/resources/homepage/${homepage.context_path}/img/sitemap_icon_b.png');
				});
			}
		},
		afterResponsive: function(isResponsive){}
	});
};

fullPage();

// 모바일일 경우 fullpage 미사용
if ( $(window).width() < 1025 ) {
	if ($('#fullpage').hasClass('fp-destroyed')){
	} else {
		fullpage_api.destroy('all');
	}
} else {
	fullPage();
};

// 리사이즈 될때 모바일 화면에서 fullpage 미사용
$( window ).resize( function(e) {
	if ( $(window).width() < 1025 ) {
		if ($('#fullpage').hasClass('fp-destroyed')){
		} else {
			fullpage_api.destroy('all');
		}
	} else {
		fullPage();
	};
});
</script>