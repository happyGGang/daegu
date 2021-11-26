<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%--
<link rel="stylesheet" type="text/css" href="/resources/common/css/jqcloud2.css"  />
<script type="text/javascript" src="/resources/common/js/jqcloud2.js"></script>
--%>
<script type="text/javascript" src="/resources/common/js/jquery.tagcanvas.js"></script>

<script>
	$(function() {
		if (!$('#myCanvas').tagcanvas({
			weightGradient: {0:'#f00', 0.33:'#ff0', 0.66:'#0f0', 1:'#00f'},
			textFont: null,
			textColour: null,
			weight: false,
			outlineoffset: 0,
			outlineThickness: 0,
			shape: 'sphere',
			reverse: true,
			depth: 0.8,
			maxSpeed: 0.01,
			padding: 5,
			minSpeed: 0.01,
			textHeight: 50,
			offsetY: 50,
			stretchX: 6,
			initial: [0.2, -0.4],
			zoom: 0.7,
			wheelZoom: false,

		}, 'tags')) {
			// something went wrong, hide the canvas container
			$('#myCanvasContainer').hide();
		}
	});
</script>

<style>
	.user_pick_info {position:relative;width:100%;margin-top:30px;padding:40px 0;background-color:#f3f4f6;text-align:center;}
	.user_pick_info img{position:absolute;top:-30px;left:46%;}
	.user_pick_info h2{font-size:30px;color:#39366a;font-weight:600;letter-spacing:0;font-family:'s-core_dream6_bold';}
	.user_pick_info p.txt_box01{font-size:16px;color:#39366a;line-height:23px;letter-spacing:0;margin:0 9%;font-family:'s-core_dream5_medium';}

	ul.con li{width:calc(100% - 20px);margin-bottom:10px;}
	ul.con li a{color:#000;font-size:18px;font-family:'s-core_dream5_medium';}
	ul.con li a span{float:right;font-size:15px;font-family:'s-core_dream4_regular';background:url('/data/menuResources/h32/87/1634785476833.png')no-repeat center right;padding-right:55px;}
	#keyword span a {font-family:'S-CoreDream-4Regular';}
	#keyword {height: 400px;}
</style>

<%--<script>
		$(function() {

		var menu_idx = '${bookKeyword.menu_idx}';
		var words = [];
		var color_rand = ['#82be02', '#71aa99', '#955959' ,'#be0252', '#0077d2', '#d26d00', '#d20000', '#24b732', '#00c6cd', '#a602be'];
		var weight_rand = ['100','200','300','400', '500', '600', '700', '800', '900'];

		<c:forEach var="i" varStatus="status" items="${bookKeywordList}">
			var obj = new Object();
			obj.text = '${i.keyword_name}';
			obj.color = color_rand[Math.floor(Math.random()*color_rand.length)];
			obj.weight = weight_rand[Math.floor(Math.random()*weight_rand.length)];
			obj.link = 'view.do?menu_idx='+menu_idx+'&keyword_name=${i.keyword_name}';
			words.push(obj);
			$('#demo_word_'+status.index).css('margin','15px')
		</c:forEach>

		$('#keyword').jQCloud(words, {});
		})
</script>--%>

<form:form modelAttribute="bookKeyword" action="index.do"  onsubmit="return false">
	<div class="user_pick_info">
		<img src="/resources/homepage/dgportal/img/user_pick_icon.png">
		<h2>${member.member_name}님의 관심 키워드를 선택해보세요!</h2>
		<p class="txt_box01">맞춤책 추천으로 <span style="font-family:'s-core_dream6_bold'">${member.member_name}</span>님의 독서를 도와드려요.</p>
	</div>
	<!-- <img src="/data/menuResources/h32/87/1634785009452.jpg" style="padding:40px 0;"> -->

	<div class="keyword-box">
		<div id="myCanvasContainer" style="width:900px;">
			<canvas width="900px" height="500" id="myCanvas">
				현재 브라우저는 HTML5를 지원하지 않습니다.
			</canvas>
			<div id="tags">
				<ul>
					<c:forEach var="i" varStatus="status" items="${bookKeywordList}">
						<li><a href="view.do?menu_idx=${bookKeyword.menu_idx}&keyword_name=${i.keyword_name}" title="4차 산업혁명">${i.keyword_name}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>

	<ul class="con">
		<li><a href="javascript:location.reload()">마음에 드는 키워드가 없으신가요? 여기를 눌러 새로운 키워드를 받아보세요.</a></li>
	</ul>
</form:form>