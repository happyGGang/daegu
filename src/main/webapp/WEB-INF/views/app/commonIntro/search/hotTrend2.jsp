<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style type="text/css">
.tabmenu_area li.tabmenu1 a, .tabmenu_area li.tabmenu2 a {
    border-bottom-width: 1px;
    margin-bottom: -1px;
}
.tabmenu_area li.active.tabmenu1 a, .tabmenu_area li.active.tabmenu2 a {
    color: #fff;
    z-index: 2;
    background: #1f5d97;
    border-color: #1a518b;
}

.tabmenu_area li.tabmenu1, .tabmenu_area li.tabmenu2 {
    zoom: 1;
    vertical-align: bottom;
}
.tabmenu_area li.tabmenu1 a, .tabmenu_area li.tabmenu2 a {
    z-index: 1;
    display: block;
    background: #fafafa;
    border: 1px solid #d2d2d2;
    border-bottom-width: 0;
    padding: 8px 20px 9px;
    font-weight: bold;
    color: #2f3743;
    margin: 0 0 0 -1px;
}
.tabline { font-size: 0; border-bottom: 1px solid #1a518b; padding-left: 1px; }
</style>

<script>
$(function() {
	
	$('a.trendSearch').on('click', function(e) {
		e.preventDefault();
		$('input#sub_search1').prop('checked', false);
		$('#librarySearch #allBookListStr').val('');
		$('#librarySearch #search_type').val('SEARCH');
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
	
	$('div.tabmenu_area li.tabmenu1 a').on('click', function(e) {
		e.preventDefault();
		$('li.tabmenu2_list').hide();
		$('li.tabmenu1_list').show();
		$('li.tabmenu2').removeClass('active');
		$('li.tabmenu1').addClass('active');
	});
	$('div.tabmenu_area li.tabmenu2 a').on('click', function(e) {
		e.preventDefault();
		$('li.tabmenu1_list').hide();
		$('li.tabmenu2_list').show();
		$('li.tabmenu1').removeClass('active');
		$('li.tabmenu2').addClass('active');
	});
});
</script>

<h4>실시간 검색어 순위</h4>
<div class="tabmenu_area" style="padding-bottom: 0;">

<style>
.tabmenu3 .new-list{position:relative;border:1px solid #e1e1e1;border-right:none;border-left:none;background: url(data:image/gif;base64,R0lGODdhBQAoAIABAOPj4////ywAAAAABQAoAAACDoyPqcvtD6OctNqbgNYFADs=) repeat-x 0 top;}
.tabmenu3 .new-list dt{position:absolute;top:0;height:46px}
.tabmenu3 .new-list dt.tab101{left:30px;}
.tabmenu3 .new-list dt.tab102{left:116px;}
.tabmenu3 .new-list dt.tab103{left:218px;}
.tabmenu3 .new-list dt.tab201{left:17px;}
.tabmenu3 .new-list dt.tab202{left:118px;}
.tabmenu3 .new-list dt.tab203{left:206px;}
.tabmenu3 .new-list.photo dt.tab03.line2 a{padding:5px 0;line-height:115%}
.tabmenu3 .new-list dt.tab04{left:300px}
.tabmenu3 .new-list dt a{display:block;width:100%;height:30px;padding:10px 0 0;letter-spacing:-1px;color:#4b4b4b;font-size:15px;font-weight:600;text-align:center;text-decoration:none}
.tabmenu3 .new-list dt a:hover,
.tabmenu3 .new-list dt a:focus,
.tabmenu3 .new-list dt a.active{background: url(data:image/gif;base64,R0lGODdhBQAoAIAAABWX5////ywAAAAABQAoAAACD4yPqcvtD6OctFoJst68AAA7) repeat-x 0 top;}
.tabmenu3 .new-list dd{display:none;width:100%;height:auto;position:relative}
.tabmenu3 .new-list dd ul{padding:15px 0 0 0;border-top:1px dotted #b8b8b8;font-size:0;line-height:0}
.tabmenu3 .new-list dd ul li{clear:both;background:url('../img/arr-new-list.gif') no-repeat 0 center;font-size:13px;
padding-left:10px;overflow:hidden;margin:0 18px;height:24px}
.tabmenu3 .new-list dd ul li span{display:inline-block;zoom:1;*display:inline;vertical-align:top}
.tabmenu3 .new-list dd ul li span.subject{width:79%;float:left;text-align:left}
.tabmenu3 .new-list dd ul li span.date{width:20.5%;float:right;white-space:nowrap;text-align:right;color:#8a8a8a;padding:4px 1px;font-size:90%}
.tabmenu3 .new-list dd ul a{display:inline-block;zoom:1;*display:inline;width:100%;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;vertical-align:top;padding:4px 0 0}
.tabmenu3 .new-list dd ul a:hover,
.tabmenu3 .new-list dd ul a:active,
.tabmenu3 .new-list dd ul a:focus{text-decoration:underline}
.tabmenu3 .new-list dd .more_btn{display:inline-block;zoom:1;*display:inline;
vertical-align:top;position:absolute;font-size:0;line-height:0;right:3%;top:-38px;
width:30px;height:30px;line-height:30px;background:#fff url('../img/new-more.gif') no-repeat center center}
</style>

<div class="tabmenu3">
	<dl class="new-list board">
		<dt class="tab101"><a href="#tabmenu" class="">주간</a></dt>
		<dd style="display: none;">
		<ul style="border-top-width:0px; padding-top:0px;">
		<c:forEach items="${hotTrendDailyList.data}" var="i" varStatus="status">
			<li style="padding-bottom: 2px;"><span>${i.IDX}</span>
			<span style="padding-left: 10px;">
				<a href="#" class="trendSearch" alt="${fn:trim(i.WORD)}" title=">${fn:trim(i.WORD)}">
					<c:choose>
					<c:when test="${fn:length(fn:trim(i.WORD)) > 10}">${fn:substring(fn:trim(i.WORD),0,10)}...</c:when>
					<c:otherwise>${fn:trim(i.WORD)}</c:otherwise>
					</c:choose>
				</a>
			</span>
		</c:forEach>
		</ul>
		</dd>
		
<%--		
		<dt class="tab102"><a href="#tabmenu" class="">시험 / 채용</a></dt>
		<dd style="display: none;">
			<!-- 탭 2 -->
			<ul style="border-top-width:0px; padding-top:0px;">
				<li>
					<span class="subject"><a href="/main/board/view.do?manage_idx=15&amp;board_idx=1051198&amp;menu_idx=83" title="2018학년도 공,사립 중등교사 임용 제1차 시험 장소 공고">2018학년도 공,사립 중등교사 임용 제1차 시험 장소 공고</a></span>
					<span class="date">2017-11-17</span>
				</li>
				<li>
					<span class="subject"><a href="/main/board/view.do?manage_idx=15&amp;board_idx=1045465&amp;menu_idx=83" title="2018학년도 대구광역시 공립 유치원,초등학교,특수학교(유치원,초등)교사 임용후보자 선정경쟁시험 시행계획 공고">2018학년도 대구광역시 공립 유치원,초등학교,특수학교(유치원,초등)교사 임용후보자 선정경쟁시험 시행계획 공고</a></span>
					<span class="date">2017-09-14</span>
				</li>
				<li>
					<span class="subject"><a href="/main/board/view.do?manage_idx=15&amp;board_idx=1043473&amp;menu_idx=83" title="2017년도 제2회 검정고시 합격자 공고">2017년도 제2회 검정고시 합격자 공고</a></span>
					<span class="date">2017-08-28</span>
				</li>
				<li>
					<span class="subject"><a href="/main/board/view.do?manage_idx=15&amp;board_idx=1042771&amp;menu_idx=83" title="2017년도 대구광역시교육청 지방공무원 신규임용시험 최종 합격자 발표 및 임용후보자 등록 공고">2017년도 대구광역시교육청 지방공무원 신규임용시험 최종 합격자 발표 및 임용후보자 등록 공고</a></span>
					<span class="date">2017-08-21</span>
				</li>
				</ul>
			<a href="/main/board/index.do?manage_idx=15&amp;menu_idx=83" class="more_btn" title="시험/채용 더보기"><span>시험/채용 더보기</span></a>
		</dd>
--%>
	</dl>
</div>



</div>
