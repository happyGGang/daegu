<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- <link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"> -->



<link rel="stylesheet" type="text/css" href="/resources/common/css/jqcloud2.css"  />
<script type="text/javascript" src="/resources/common/js/jqcloud2.js"></script>

<!-- <script type="text/javascript" src="/resources/common/js/jquery.tagcanvas.js"></script> -->

<script>
	$(function() {
// 		if (!$('#myCanvas').tagcanvas({
// 			weightGradient: {0:'#f00', 0.33:'#ff0', 0.66:'#0f0', 1:'#00f'},
// 			textFont: null,
// 			textColour: null,
// 			weight: false,
// 			outlineoffset: 0,
// 			outlineThickness: 0,
// 			shape: 'sphere',
// 			reverse: true,
// 			depth: 0.8,
// 			maxSpeed: 0.01,
// 			padding: 5,
// 			minSpeed: 0.01,
// 			textHeight: 50,
// 			offsetY: 50,
// 			stretchX: 6,
// 			initial: [0.2, -0.4],
// 			zoom: 0.7,
// 			wheelZoom: false,

// 		}, 'tags')) {
// 			// something went wrong, hide the canvas container
// 			$('#myCanvasContainer').hide();
// 		}
	});
</script>

<style>
	.user_pick_info {position:relative;width:100%;margin-top:30px;padding:40px 0 35px;background-color:#f3f4f6;text-align:center;}
	.user_pick_info img{position:absolute;top:-30px;left:46%;}
	.user_pick_info h2{font-size:30px;color:#39366a;font-weight:600;letter-spacing:0;font-family:'s-core_dream6_bold';}
	.user_pick_info p.txt_box01{font-size:16px;color:#39366a;line-height:23px;letter-spacing:0;margin:0 9%;font-family:'s-core_dream5_medium';}
	.user_pick_info p.txt_box_mini{font-size:14px;color:#39366a;opacity:0.8;font-family:'s-core_dream5_medium';margin-top:5px;}

	#keyword span {font-family:'S-CoreDream-4Regular';cursor:pointer;}
	#keyword {height: 450px;}

	.select-keyword{position:relative;width:100%;margin-bottom:40px;text-align:center;border-top:1px solid #ddd;padding-top:40px;}
	.select-keyword span{display:inline-block;font-family:'S-CoreDream-4Regular';color:#fff;font-size:18px;background:#333;width:180px;height:55px;line-height:55px;content:'#';}
	.select-keyword span::before{content:'#';}

	.btn-box{position:relative;width:100%;clear:both;}
	.btn-box ul{font-size:0;}
	.btn-box ul li{display:inline-block;width:49.5%;padding:15px 0;line-height:180%;text-align:center;border-radius:5px;}
	.btn-box ul li a{font-family:'s-core_dream5_medium';font-size:19px;letter-spacing:-0.25px;display:block;}
	.btn-box ul li a span{display:block;font-family:'S-CoreDream-4Regular';font-size:13px;letter-spacing:0;}
	.btn-box ul li.btn1{box-sizing:border-box;border:1px solid #ccc;margin-right:1%;}
	.btn-box ul li.btn1 a{color:#333;}
	.btn-box ul li.btn2{background:linear-gradient(to right, #53cce9, #7597ee)}
	.btn-box ul li.btn2 a{color:#fff;}
	
	@media only screen and (max-width:550px){
		.user_pick_info img{position:absolute;top:-30px;left:43%;}
		.user_pick_info h2{font-size:25px;}

		.select-keyword{margin-bottom:10px;}
		.select-keyword span{font-size:14px;margin-bottom:5px;width:32%;height:40px;line-height:40px;}
		
		.btn-box ul li{display:block;width:100%;line-height:160%;}
		.btn-box ul li.btn1{margin-right:0;margin-bottom:5px;}
		.btn-box ul li a{font-size:16px;}
		.btn-box ul li a span{font-size:12px;}
	}
</style>

<script>
$(function() {

	var menu_idx = '${bookKeyword.menu_idx}';
	
	$('#search_keyword').on('click',function(e){
		// 초기화
		$('#keyword_name').val('');
		
		var selected_count= $('.select-keyword span').length;
		
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
		
		var param = serializeCustom($('form#bookKeyword'));
		doGetLoad('view.do', param);
	});
	
	$('div.keyword-box').load('bookKeyword.do');
	
	$('#reloadKeyword').on('click', function(){
		$('div.keyword-box').load('bookKeyword.do');
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
	
	$(document).on('click', '#keywordRemove', function(){
		var text = $(this).parent("span").text(); 
		$(this).parent("span").remove();
		$('#keyword span[id^=keyword_word_]:contains("'+text+'")').css('border', '');
	});
	
})
</script>

<form:form modelAttribute="bookKeyword" action="index.do"  onsubmit="return false">
<form:hidden path="keyword_name"/>
<form:hidden path="menu_idx"/>
	<div class="user_pick_info">
		<img src="/resources/homepage/dgportal/img/user_pick_icon.png">
		<h2>${member.member_name}님의 관심 키워드를 선택해보세요!</h2>
		<p class="txt_box01">맞춤책 추천으로 <span style="font-family:'s-core_dream6_bold'">${member.member_name}</span>님의 독서를 도와드려요.</p>
		<p class="txt_box_mini">중복 선택 가능(최대 3개)</p>
	</div>
	<!-- <img src="/data/menuResources/h32/87/1634785009452.jpg" style="padding:40px 0;"> -->
	<!--<div class="keyword-box"> -->
	<!--<div id="myCanvasContainer" style="width:900px;"> -->
	<%-- <%--<canvas width="900px" height="500" id="myCanvas"> --%> 
	<!-- <!--현재 브라우저는 HTML5를 지원하지 않습니다. -->
	<%-- <%--</canvas> --%> 
	<!--<div id="tags"> -->
	<!--	<ul> -->
	<%--		<c:forEach var="i" varStatus="status" items="${bookKeywordList}"> --%>
	<%--			<li><a href="view.do?menu_idx=${bookKeyword.menu_idx}&keyword_name=${i.keyword_name}" title="4차 산업혁명">${i.keyword_name}</a></li> --%>
	<%--		</c:forEach> --%>
	<!--	</ul> -->
	<!--</div> -->
	<!--</div> -->
	<!--/div> -->

	<div class="keyword-box">
		
	</div>

	<div class="select-keyword">
<!-- 		<span>키워드1</span> -->
<!-- 		<span>키워드2</span> -->
<!-- 		<span>키워드3</span> -->
	</div>

	<div class="btn-box">
		<ul>
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
		</ul>
	</div>
</form:form>

<!-- <li><a href="javascript:location.reload()">마음에 드는 키워드가 없으신가요? 여기를 눌러 새로운 키워드를 받아보세요. </a> </li>
	<li class="k-btn2"><a href="javascript:void(0)"><span id="search_keyword">재검색</span></a> </li> -->