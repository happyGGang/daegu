<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/jqcloud2.css"/>

<tiles:insertAttribute name="header" />

<style>
.user_pick_info {position:relative;width:100%;margin-top:30px;padding:40px 0 35px;text-align:center;}
.user_pick_info img {position:absolute;top:-30px;left:46%;}
.user_pick_info h2{font-size:30px;color:#39366a;font-weight:600;letter-spacing:0;font-family:'s-core_dream6_bold';}
.user_pick_info p.txt_box01{font-size:16px;color:#39366a;line-height:23px;letter-spacing:0;margin:0 9%;font-family:'s-core_dream5_medium';}
.user_pick_info p.txt_box_mini{font-size:14px;color:#39366a;opacity:0.8;font-family:'s-core_dream5_medium';margin-top:5px;}

#keyword span {font-family:'s-core_dream4_regular';cursor:pointer;}
#keyword {height:650px;font-size:125%;}

.select-keyword {position:relative;width:100%;text-align:center;padding-top:40px;}
.select-keyword span {display:inline-block;font-family:'s-core_dream4_regular';color:#fff;font-size:30px;background:#272a49;width:250px;height:80px;line-height:80px;content:'#';border-radius:80px;box-shadow: 5px 10px 15px rgba(0,0,0,0.3);}
.select-keyword span::before{content:'#';}

.keyword-box {box-sizing:border-box;padding:1%}
.select-keyword {padding:20px 0;height:100px;}

.user_pick_comment {font-size:40px;color:#fff;text-align:center;box-sizing:border-box;padding-bottom:25px;}
.select-personal_data span {display:inline-block;background:#fff;width:390px;height:100px;line-height:100px;border-radius:50px;    box-shadow: 25px 10px 25px rgba(0,0,0,0.1);text-align:left;}
.select-personal_data span label {display:inline-block;width:35%;font-size:30px;color:#767676;text-align:center;}
.select-personal_data span select {display:inline-block;width:60%;font-size:30px;border:0;height:100px;background:transparent;}
.select-personal_data span select:focus {outline:0;}
.btn-box {padding-top:30px;}
.btn-box span {display:inline-block;background:#113b9e;width:390px;height:100px;line-height:100px;border-radius:50px;box-shadow:25px 15px 25px rgba(0,0,0,0.1);}
.btn-box span a {display:block;color:#fff;font-size:30px;}
</style>

<script type="text/javascript" src="/resources/common/js/jqcloud2.js"></script>
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
		
		/*
		if(member_name == ''){
			if(sex == ''){
				alert('성별을 선택 후 검색을 진행해 주세요.');
			}
			if(age == ''){
				alert('나이를 선택 후 검색을 진행해 주세요.');
			}
		}
		*/

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
			var param = 'keyword_name=' + $('#keyword_name').val() + '&sex=' + sex + '&age=' + age;
			doGetLoad('bookKeywordList.do', param);
		} else {
			var param = serializeCustom($('form#bookKeyword'));
			doGetLoad('bookKeywordList.do', param);
		}
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

<div class="smartrecommandbook-wrap">
	<div class="header">
		<h1>능동형도서추천</h1>
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
		
				<div class="user_pick_selection">
					<div class="user_pick_comment">
						성별/연령대를 알려주세요! 
					</div>
					<div class="select-personal_data">
						<span class="">
							<label>성별 </label>
							<form:select path="sex">
								<form:option value="">선택하세요</form:option>
								<form:option value="0">남</form:option>
								<form:option value="1">여</form:option>
							</form:select>
						</span>
						<span class="">
							<label>나이 </label>
							<form:select path="age">
								<form:option value="">선택하세요</form:option>
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
			</div>
		</form:form>
	</div>
	<div class="backbutton-sec">
		<a href="javascript:void(0);" onclick="history.back();">< 이전</a>
	</div>
</div>


		<!-- 메뉴 -->
		<div class="bookIndexNav">
			<ul class="navbox">
				<li>
					<a href="/${homepage.context_path}/kiosk/bookKeywordIndex.do" class="smart-btn">
						<div class="outer">
							<div class="inner">
								<span class="kor-txt">능동형 도서추천</span>
								<span class="eng-txt">active type Book recommendation</span>
							</div>
						</div>						
					</a>
				</li>
				<li>
					<a href="/${homepage.context_path}/kiosk/librarianPickBookIndex.do" class="librarian-btn">
						<div class="outer">
							<div class="inner">
								<span class="kor-txt">맞춤형 도서추천</span>
								<span class="eng-txt">Customized book recommendation</span>
							</div>
						</div>
					</a>
				</li>
				<li>
					<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<a href="/${homepage.context_path}/intro/login/kioskLogout.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do">
						<div class="outer">
							<div class="inner">
								<div class="">
									<img src='/resources/common/img/kiosk/login-icon.png' alt=''/>
								</div>
								로그아웃
							</div>
						</div>
					</a>
					</c:when>
					<c:otherwise>
					<a href="/${homepage.context_path}/kiosk/login.do?before_url=/${homepage.context_path}/kiosk/bookIndex.do">
						<div class="outer">
							<div class="inner">
								<div class="">
									<img src='/resources/common/img/kiosk/login-icon.png' alt=''/>
								</div>
								로그인
							</div>
						</div>
					</a>
					</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</div>
<tiles:insertAttribute name="footer" />