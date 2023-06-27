<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jqcloud2.css" />
<script type="text/javascript" src="/resources/common/js/jqcloud2.js"></script>

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

	.select-personal_data{font-size:13px;}
}
</style>

<script>
$(function() {

	var menu_idx = '${bookKeyword.menu_idx}';
	var member_name = '${member.member_name}';
	
	$('#search_keyword').on('click',function(e){
		var sex = $('select#sex').val();
		var age = $('select#age').val();
		// 초기화
		$('#keyword_name').val('');
		
		var selected_count= $('.select-keyword span').length;
		
		if(member_name == ''){
			if(sex == ''){
				alert('성별을 선택 후 검색을 진행해 주세요.');
			}
			if(age == ''){
				alert('나이를 선택 후 검색을 진행해 주세요.');
			}
		}
		
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
		
		if(member_name == ''){
			var param = 'keyword_name=' + $('#keyword_name').val() + '&menu_idx=' + $('#menu_idx').val() + '&sex=' + sex + '&age=' + age;
			doGetLoad('view.do', param);
		} else {
			var param = serializeCustom($('form#bookKeyword'));
			doGetLoad('view.do', param);
		}
	});
	
	$('div.keyword-box').load('bookKeyword.do');
	
	$('#reloadKeyword').on('click', function(){
		alert('아아아아아');
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

<div class="smartrecommandbook-wrap">
	<div class="header">
		<h1>능동형 도서추천</h1>
		<p>active type Book recommendation</p>
	</div>
	<div class="contents">
		<form:form modelAttribute="bookKeyword" action="bookKeywordIndex.do" onsubmit="return false">
		<form:hidden path="keyword_name"/>
			<div class="">
				<div class="user_pick_info">
					<p class='big-txt'>회원님의 관심 키워드를 선택해보세요!</p>
					<p class='small-txt'>중복 선택 가능(3개)</p>
				</div>
				<div class="user_pick_keyword">
					<div class="keyword-box">
					</div>

					<div class="select-keyword">
					</div>
				</div>
			</div>
		
			<div class="keyword-box">
				
			</div>
		
			<div class="select-keyword">
		
			</div>
		
			<div class="user_pick_selection">
				<div class="user_pick_comment">
					성별/연령대를 알려주세요! 
				</div>
				<div class="select-personal_data">
					<span class="">
						<label>성별 </label>
						<form:select path="sex">
							<form:option value="0">남</form:option>
							<form:option value="1">여</form:option>
						</form:select>
					</span>
					<span class="">
						<label>나이 </label>
						<form:select path="age">
							<form:option value="영유아">영유아</form:option>
							<form:option value="유아">유아</form:option>
							<form:option value="초등">초등</form:option>
							<form:option value="청소년">청소년</form:option>
							<form:option value="20대 이상">20대 이상</form:option>
							<form:option value="30대 이상">30대 이상</form:option>
							<form:option value="40대 이상">40대 이상</form:option>
							<form:option value="50대 이상">50대 이상</form:option>
							<form:option value="60대 이상">60대 이상</form:option>
						</form:select>
					</span>
				</div>
			</div>
		
			<div class="btn-box">
				<span class="btn1">
					<a href="javascript:void(0)" id="reloadKeyword">키워드 변경하기</a>
				</span>
				<span class="btn2">
					<a href="javascript:void(0)" id="search_keyword">맞춤책 추천받기</a>
				</span>
			</div>
		</form:form>
	</div>
	<div class="backbutton-sec">
		<a href="javascript:void(0);" onclick="history.back();">< 이전</a>
	</div>
</div>
<tiles:insertAttribute name="footer" />