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
%>
<c:set var="listNum1" value="<%=listNum1%>">
</c:set>
<c:set var="listNum2" value="<%=listNum2%>">
</c:set>
<c:set var="listNum3" value="<%=listNum3%>">
</c:set>
<tiles:insertAttribute name="header" />
<script type="text/javascript">
	$(function() {
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

		$('input[id*=pop]').on('click', function(e) {
			e.preventDefault();
			$(this).prop('checked', true);
			$(this).parent('div').next('a').data('day', $(this).data('day'));
			$(this).parent('div').next('a').click();
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


		$('div.sec01-3').load('calendar10.do');
		// $('div#top2box_newbook').load('newBook.do');
		// $.get('newBookSeogu.do', function(e) {
		// 	$('div#top2box_newbook').append(e)
		// });
		$('ul.bestBookUl').load('bestBook.do');

		$('#main-search-btn').on('click', function() {
			if( $('input#search_text_1').val() == '' ) {
				alert('검색어를 입력하세요.');
				$('input#search_text_1').focus();
				return false;
			}
				$('#mainSearchForm').submit();
		});

});
</script>

<div id="wrap"> 
	<c:if test="${fn:length(popupZoneTopList) > 0}">
	<div class="popup_top">
		<div class="popup">
			<div class="pop_contents">
				<div class="topPopZone">
					<homepageTag:popupZoneTop popupZoneList="${popupZoneTopList}"/>
				</div>
			</div>
			<p class="close"><input type="checkbox" name=""/> 오늘 하루 열지 않기 <a href="#" onclick="return false;"><img src="/resources/common/img/close_popup_btn.png" alt="닫기"/></a></p>
		</div>
	</div>
	</c:if>

  <!--팝업-->
  <div class="popupWrap section">
    <div id="popupLayer">
      <homepageTag:popup popupList="${popupList}" />
    </div>
  </div>
  <!--//팝업-->
  
  <tiles:insertAttribute name="top" />
  <tiles:insertAttribute name="topMenu" />
  <div id="container" class="main"> 
    
    <!--section01-->
    <div class="section01_wrap">
      <div class="section01"> 
        
        <!--sec01-1-->
        <div class="sec01-1">
          <div class="sec01-1-0"> 
            <!--모바일/태블릿 popupzone-->
            <div class="popZone">
              <div class="cont">
                <c:choose>
                  <c:when test="${fn:length(popupZoneList) > 0}">
                    <homepageTag:popupZone popupZoneList="${popupZoneList}"/>
                  </c:when>
                  <c:otherwise>
                    <ul class="popupImg">
                      <li> <img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="noimg" style="width:100%;"/> </li>
                    </ul>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
            <!--//모바일/태블릿 popupzone--> 
          </div>
          <div class="sec01-1-1"> 
            <!--search-->
            <div class="search_box">
              <div class="search_box_on"> <span>통합자료검색</span>
                <form id="mainSearchForm" action="/${homepage.context_path}/intro/search/index.do">
                  <input type="hidden" name="menu_idx" value="9">
                  <input type="hidden" name="booktype" value="BOOKANDNONBOOK">
                  <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
                  <input name="title" id="search_text_1" type="text" class="text" placeholder="검색어를 입력하세요." style="ime-mode:active;"/>
                </form>
                <a href=""><img src="/resources/homepage/seogulib/img/search_btn.jpg"></a> </div>
              <div class="search_box_off"> <span><img src="/resources/homepage/seogulib/img/search_btn.jpg"></span> </div>
            </div>
            <!--//search--> 
            <!--quick menu-->
            <div class="quickmenu">
              <ul>
                <li class="quick01" onclick="location.href='board/index.do?menu_idx=35&manage_idx=628'">
                  <h5>공지사항</h5>
                  <p>서구통합도서관의<br />
                    공지를 확인해보세요!</p>
                </li>
                <li class="quick02" onclick="location.href='intro/search/loan/history.do?menu_idx=53'">
                  <h5>대출현황조회</h5>
                  <p>나의 도서대출 이력을<br />
                    조회해보세요!</p>
                </li>
                <li class="quick03" onclick="location.href='html.do?menu_idx=31'">
                  <h5>문화강좌</h5>
                  <p>다양한 행사와<br />
                    온라인 수강신청</p>
                </li>
              </ul>
            </div>
            <!--//quick menu--> 
          </div>
          <div class="sec01-1-2"> 
            <!--PC popupzone-->
            <div class="popZone">
              <div class="cont">
                <c:choose>
                  <c:when test="${fn:length(popupZoneList) > 0}">
                    <homepageTag:popupZone popupZoneList="${popupZoneList}"/>
                  </c:when>
                  <c:otherwise>
                    <ul class="popupImg">
                      <li> <img src="/resources/homepage/${homepage.context_path}/img/popupnone.png" alt="noimg" style="width:100%;"/> </li>
                    </ul>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
            <!--//PC popupzone--> 
          </div>
        </div>
        <!--//sec01-1--> 
        
        <!--sec01-2-->
        <div class="sec01-2">
          <div class="sec01-2-1"> 
            <!--quick menu-->
            <div class="quickmenu">
              <ul>
                <li class="quick04" onclick="location.href='html.do?menu_idx=91'">
                  <h5>도서관견학신청</h5>
                  <p>올바른 도서관 이용법과<br />
                    책을 접할 수 있어요!</p>
                </li>
                <li class="quick05" onclick="location.href='html.do?menu_idx=17'">
                  <h5>이용안내</h5>
                  <p>도서관서비스<br />
				  	이렇게 이용해보세요!
				  </p>
                </li>
                <li class="quick06" onclick="location.href='html.do?menu_idx=15'">
                  <h5>희망도서신청</h5>
                  <p>원하는 도서가 없을 경우<br />
                    신청하세요!</p>
                </li>
                <li class="quick07" onclick="location.href='html.do?menu_idx=25'">
                  <h5>대구전자도서관</h5>
                  <p>대구 시민의<br />
                    스마트한 독서생활!</p>
                </li>
              </ul>
            </div>
            <!--//quick menu--> 
          </div>
          <div class="sec01-2-2"> 
            <!--naver band-->
            <div class="naver_band">
              <h5><span>네이버</span> 밴드 ON</h5>
              <ul>
                <li> <a href="https://band.us/@seoguchildlib" target="_blank"> <img src="/resources/homepage/seogulib/img/naver_band_child.png"><br/>
                  <span>서구어린이</span> </a> </li>
                <li> <a href="https://band.us/@bisanlib" target="_blank"> <img src="/resources/homepage/seogulib/img/naver_band_bisan.png"><br/>
                  <span>비산</span> </a> </li>
                <li> <a href="https://band.us/@selibrary" target="_blank"> <img src="/resources/homepage/seogulib/img/naver_band_english.png"><br/>
                  <span>영어</span> </a> </li>
                <li> <a href="https://band.us/@biwonlib" target="_blank"> <img src="/resources/homepage/seogulib/img/naver_band_biwon.png"><br/>
                  <span>비원</span> </a> </li>
                <li> <a href="https://band.us/@wongogaelibrary" target="_blank"> <img src="/resources/homepage/seogulib/img/naver_band_wongogae.png"><br/>
                  <span>원고개</span> </a> </li>
				<li> <a href="https://band.us/@newpeongri" target="_blank"> <img src="/resources/homepage/seogulib/img/naver_band_newpeongri.png"><br/>
                  <span>New평리</span> </a> </li>
              </ul>
            </div>
            <!--//naver band--> 
          </div>
        </div>
        <!--//sec01-2--> 
        
        <!--sec01-2-tab-->
        <div class="sec01-2-tab">
          <div class="sec01-2-1"> 
            <!--quick menu-->
            <div class="quickmenu">
              <ul>
                <li class="quick04" onclick="location.href='html.do?menu_idx=91'">
                  <h5>도서관견학신청</h5>
                  <p>올바른 도서관 이용법과<br />
                    책을 접할 수 있어요!</p>
                </li>
                <li class="quick05" onclick="location.href='html.do?menu_idx=17'">
                  <h5>이용안내</h5>
                  <p>도서관서비스<br />
				  	이렇게 이용해보세요!
				  </p>
                </li>
                <li class="quick06" onclick="location.href='html.do?menu_idx=15'">
                  <h5>희망도서신청</h5>
                  <p>원하는 도서가 없을 경우<br />
                    신청하세요!</p>
                </li>
              </ul>
            </div>
            <!--//quick menu--> 
          </div>
          <div class="sec01-2-2">
            <div class="quickmenu">
              <ul>
                <li class="quick07" onclick="location.href='html.do?menu_idx=25'">
                  <h5>대구전자도서관</h5>
                  <p>대구 시민의<br />
                    스마트한 독서생활!</p>
                </li>
              </ul>
            </div>
            <!--naver band-->
            <div class="naver_band">
              <h5><span>네이버</span> 밴드 ON</h5>
              <ul>
                <li> <a href="https://band.us/@seoguchildlib"> <img src="/resources/homepage/seogulib/img/naver_band_child.png"><br/>
                  <span class="m_none">서구어린이</span> <span class="pc_none">어린이</span> </a> </li>
                <li> <a href="https://band.us/@bisanlib"> <img src="/resources/homepage/seogulib/img/naver_band_bisan.png"><br/>
                  <span>비산</span> </a> </li>
                <li> <a href="https://band.us/@selibrary"> <img src="/resources/homepage/seogulib/img/naver_band_english.png"><br/>
                  <span>영어</span> </a> </li>
                <li> <a href="https://band.us/@biwonlib"> <img src="/resources/homepage/seogulib/img/naver_band_biwon.png"><br/>
                  <span>비원</span> </a> </li>
                <li> <a href="https://band.us/@wongogaelibrary"> <img src="/resources/homepage/seogulib/img/naver_band_wongogae.png"><br/>
                  <span>원고개</span> </a> </li>
				<li> <a href="https://band.us/@newpeongri"> <img src="/resources/homepage/seogulib/img/naver_band_newpeongri.png"><br/>
                  <span>New평리</span> </a> </li>
              </ul>
            </div>
            <!--//naver band--> 
          </div>
        </div>
        <!--//sec01-2--> 
        
        <!--sec01-3-->
        <div class="sec01-3">
          <div class="title"> <span> <strong>오늘의 도서관 일정</strong>을 확인하세요! </span> <a href="module/calendarManage/index.do?menu_idx=36">전체일정</a> </div>
          <div class="date"> <a href=""><img src="/resources/homepage/seogulib/img/date_prev.png"></a> <span>06-15</span> <a href=""><img src="/resources/homepage/seogulib/img/date_next.png"></a> </div>
          <div class="event">
            <div class="tit"><span>행사</span></div>
            <div><span>어린이</span></div>
            <div><span>비산</span></div>
            <div><span>영어</span></div>
            <div><span>비원</span></div>
            <div><span>원고개</span></div>
            <div><span>New평리</span></div>
          </div>
          <div class="movie">
            <div class="tit"><span>영화</span></div>
            <div><span>어린이</span></div>
            <div><span>비산</span></div>
            <div><span>영어</span></div>
            <div><span>비원</span></div>
            <div><span>원고개</span></div>
            <div><span>New평리</span></div>
          </div>
          <div class="closed">
            <div class="tit"><span>휴관</span></div>
            <div><span>어린이</span></div>
            <div><span>비산</span></div>
            <div><span>영어</span></div>
            <div><span>비원</span></div>
            <div><span>원고개</span></div>
            <div><span>New평리</span></div>
          </div>
        </div>
        <!--//sec01-3--> 
        
      </div>
    </div>
    <!--//section01--> 
    
    <script type="text/javascript">
	$(function() {

		//1차탭
		$(document).on('click', '.tab a.tab-link', function(e){
			e.preventDefault();
			$('.top2wrap').hide();
			$('.top3wrap').hide();

			var target = this.getAttribute('href').replace('#','');

			if(target == 'newswrap')
			{
				$('#top2box_notice').show();
				$('.tab2 li').removeClass('on');
				$('.tab2 li:first-child').addClass('on');
				$('#notibox1_all').show();
				$('.tab3 li').removeClass('on');
				$('.tab3 li:first-child').addClass('on');
			}
			else if(target == 'culturewrap')
			{
				$('#culturebox2_all').show();
				$('.tab3 li').removeClass('on');
				$('.tab3 li:first-child').addClass('on');
			}
			else if(target == 'bookswrap')
			{
				$('#top2box_recomandbook').show();
				$('.tab2 li').removeClass('on');
				$('.tab2 li:first-child').addClass('on');

				$('#recombox3_all').show();
				$('.tab3 li').removeClass('on');
				$('.tab3 li:first-child').addClass('on');
			}
			else if(target == 'moviewrap')
			{
				$('#moviebox4_all').show();
				$('.tab3 li').removeClass('on');
				$('.tab3 li:first-child').addClass('on');
			}

			var $box = $(this).closest('.tab');

			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.topwrap').hide();
			$('#'+target).show();
		});


		//2차탭
		$(document).on('click', '#newswrap .tab2 a.tab-link2', function(e){
			e.preventDefault();
			$('.top3wrap').hide();

			var target = this.getAttribute('href').replace('#','');

			var moreUrl = $(this).data('link');
			$('.more-notice').attr('href', moreUrl);

			if(target == 'notice')
			{
			$('#notibox1_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
			}
			else if(target == 'gallery')
			{
			$('#galbox1_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
			}

			var $box = $(this).closest('.tab2');
			$box.find('.on').removeClass('on');
			$(this).parent().parent().addClass('on');

			$('.top2wrap').hide();
			$('#top2box_'+target).show();
		});

		$(document).on('click', '#bookswrap .tab2 a.tab-link2', function(e){
			e.preventDefault();
			$('.top3wrap').hide();

			var target = this.getAttribute('href').replace('#','');

			if(target == 'recomandbook')
			{
			$('#recombox3_all').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
			}
			else if(target == 'newbook')
			{
			$('#newbookbox3_seoguchild').show();
			$('.tab3 li').removeClass('on');
			$('.tab3 li:first-child').addClass('on');
			}

			var $box = $(this).closest('.tab2');

			$box.find('.on').removeClass('on');
			$(this).parent().parent().addClass('on');

			$('.top2wrap').hide();
			$('#top2box_'+target).show();
		});

		//3차탭
		$(document).on('click', '#top2box_notice .tab3 a.tab-link3', function(e){
			e.preventDefault();

			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab3');
			var moreUrl = $(this).data('link');

			$('.more-notice').attr('href', moreUrl);
			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.top3wrap').hide();
			$('#notibox1_'+target).show();
		});

		$(document).on('click', '#top2box_gallery .tab3 a.tab-link3', function(e){
			e.preventDefault();

			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab3');
			var moreUrl = $(this).data('link');

			$('.more-notice').attr('href', moreUrl);
			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.top3wrap').hide();
			$('#galbox1_'+target).show();
		});

		$(document).on('click', '#culturewrap .tab3 a.tab-link3', function(e){
			e.preventDefault();
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab3');
			var moreUrl = $(this).data('link');

			$('.more-culture').attr('href', moreUrl);
			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.top3wrap').hide();
			$('#culturebox2_'+target).show();
		});

		$(document).on('click', '#moviewrap .tab3 a.tab-link3', function(e){
			e.preventDefault();
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab3');
			var moreUrl = $(this).data('link');

			$('.more-movie').attr('href', moreUrl);
			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.top3wrap').hide();
			$('#moviebox4_'+target).show();
		});

		$(document).on('click', '#top2box_recomandbook .tab3 a.tab-link3', function(e){
			e.preventDefault();
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab3');
			var moreUrl = $(this).data('link');

			$('.more-book').attr('href', moreUrl);
			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.top3wrap').hide();
			$('#recombox3_'+target).show();
		});

		$(document).on('click', '#top2box_newbook .tab3 a.tab-link3', function(e){
			e.preventDefault();
			var target = this.getAttribute('href').replace('#','');
			var $box = $(this).closest('.tab3');

			$box.find('.on').removeClass('on');
			$(this).parent().addClass('on');

			$('.top3wrap').hide();
			$('#newbookbox3_'+target).show();
		});
	});
	</script> 
    <!--section02-->
    <div class="section02_tab tab">
      <ul>
        <li class="on"><a href="#newswrap" class="tab-link">도서관소식</a></li>
        <li><a href="#culturewrap" class="tab-link">도서관행사</a></li>
        <li><a href="#bookswrap" class="tab-link">도서관'BOOK</a></li>
        <li><a href="#moviewrap" class="tab-link">영화상영</a></li>
      </ul>
    </div>
    <div class="section02_wrap">
      <div class="topwrap" id="newswrap" style="display:block;"> 
        <!--도서관소식 공지사항,갤러리-->
        <div class="section02">
          <div class="title"> <span>서구통합도서관 소식</span> </div>
          <div class="con sec02-1">
            <div class="sec02_tab01 tab2">
              <ul>
                <li class="on">
                  <div class="line2"><a href="#notice" class="tab-link2" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628">공지<br />
                    사항</a></div>
                </li>
                <li>
                  <div><a href="#gallery" class="tab-link2" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632">갤러리</a></div>
                </li>
              </ul>
              <div class="more_btn"> <a href="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628" class="more-notice"><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a> </div>
            </div>
            <div class="top2wrap" id="top2box_notice" style="display:block;">
              <div class="sec02_tab02 tab3">
                <ul>
                  <li class="on"><a href="#all" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628">전체</a></li>
                  <li class="bar">/</li>
                  <li><a href="#seoguchild" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0001">서구어린이</a></li>
                  <li class="bar">/</li>
                  <li><a href="#bisan" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0002">비산</a></li>
                  <li class="bar">/</li>
                  <li><a href="#english" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0003">영어</a></li>
                  <li class="bar">/</li>
                  <li><a href="#biwon" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0004">비원</a></li>
                  <li class="bar">/</li>
                  <li><a href="#wongogye" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0005">원고개</a></li>
                  <li class="bar">/</li>
                  <li><a href="#pyeongri" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0007">New평리</a></li>
                  <li class="bar">/</li>
                  <li><a href="#kidsEnglish" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628&category1=0008">어린이영어</a></li>
                </ul>
              </div>
              <div class="top3wrap" id="notibox1_all" style="display:block;">
                <div class="board_box">
                  <c:forEach items="${noticeList}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeList}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0000'}">
                            <c:set var="libcode" value="common">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="top3wrap" id="notibox1_seoguchild">
                <div class="board_box">
                  <c:forEach items="${noticeListh77}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh77}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="top3wrap" id="notibox1_bisan">
                <div class="board_box">
                  <c:forEach items="${noticeListh61}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh61}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="top3wrap" id="notibox1_english">
                <div class="board_box">
                  <c:forEach items="${noticeListh62}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh62}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="top3wrap" id="notibox1_biwon">
                <div class="board_box">
                  <c:forEach items="${noticeListh63}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh63}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="top3wrap" id="notibox1_wongogye">
                <div class="board_box">
                  <c:forEach items="${noticeListh64}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh64}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="top3wrap" id="notibox1_pyeongri">
                <div class="board_box">
                  <c:forEach items="${noticeListh96}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                    </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh96}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
			  <div class="top3wrap" id="notibox1_kidsEnglish">
                <div class="board_box">
                  <c:forEach items="${noticeListh98}" var="i" varStatus="status" begin="0" end="0">
                    <div class="board_notice01"> <a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="cate">${i.category1_name}</div>
                        <div class="tit">${i.title}<img src="/resources/homepage/seogulib/img/new_icon.png"></div>
                        <div class="date">
                          <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                        </div>
                        <div class="txt">${i.content_summary}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                  <div class="board_notice02">
                    <div>
                      <ul>
                        <c:forEach items="${noticeListh98}" var="i" varStatus="status" begin="1" end="7">
                          <c:if test="${i.category1 eq '0001'}">
                            <c:set var="libcode" value="child">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0002'}">
                            <c:set var="libcode" value="bisan">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0003'}">
                            <c:set var="libcode" value="english">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0004'}">
                            <c:set var="libcode" value="biwon">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0005'}">
                            <c:set var="libcode" value="wongogae">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0007'}">
                            <c:set var="libcode" value="pyeongri">
                            </c:set>
                          </c:if>
                          <c:if test="${i.category1 eq '0008'}">
                            <c:set var="libcode" value="kidsEnglish">
                            </c:set>
                          </c:if>
                          <li class="${libcode}">
                            <div class="cate">${i.category1_name}</div>
                            <div class="tit"><a href="/${homepage.context_path}/board/view.do?menu_idx=35&manage_idx=628&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->${i.title}</a></div>
                            <div class="date">
                              <fmt:formatDate value="${i.add_date}" pattern="yyyy-MM-dd"/>
                            </div>
                          </li>
                        </c:forEach>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="end"></div>
            <div class="top2wrap" id="top2box_gallery">
              <div class="sec02_tab02 tab3">
                <ul>
                  <li class="on"><a href="#all" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632">전체</a></li>
                  <li class="bar">/</li>
                  <li><a href="#seoguchild" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0001">서구어린이</a></li>
                  <li class="bar">/</li>
                  <li><a href="#bisan" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0002">비산</a></li>
                  <li class="bar">/</li>
                  <li><a href="#english" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0003">영어</a></li>
                  <li class="bar">/</li>
                  <li><a href="#biwon" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0004">비원</a></li>
                  <li class="bar">/</li>
                  <li><a href="#wongogye" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0005">원고개</a></li>
                  <li class="bar">/</li>
                  <li><a href="#pyeongri" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0006">New평리</a></li>
				  <li class="bar">/</li>
                  <li><a href="#kidsEnglish" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=50&manage_idx=632&category1=0008">어린이영어</a></li>
                </ul>
              </div>
              <div class="top3wrap" id="galbox1_all" style="display:block;">
                <div class="gallery_box">
                  <c:if test="${fn:length(galleryList) < 1}">
                    <div class="gallery">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${galleryList}" var="i" varStatus="status" begin="0" end="2">
                    <div class="gallery"> <a href="/${homepage.context_path}/board/view.do?menu_idx=50&manage_idx=632&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="galbox1_seoguchild">
                <div class="gallery_box">
                  <c:if test="${fn:length(galleryListh77) < 1}">
                    <div class="gallery">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${galleryListh77}" var="i" varStatus="status" begin="0" end="2">
                    <div class="gallery"> <a href="/${homepage.context_path}/board/view.do?menu_idx=50&manage_idx=632&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="galbox1_bisan">
                <div class="gallery_box">
                  <c:if test="${fn:length(galleryListh61) < 1}">
                    <div class="gallery">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${galleryListh61}" var="i" varStatus="status" begin="0" end="2">
                    <div class="gallery"> <a href="/${homepage.context_path}/board/view.do?menu_idx=50&manage_idx=632&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="galbox1_english">
                <div class="gallery_box">
                  <c:if test="${fn:length(galleryListh62) < 1}">
                    <div class="gallery">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${galleryListh62}" var="i" varStatus="status" begin="0" end="2">
                    <div class="gallery"> <a href="/${homepage.context_path}/board/view.do?menu_idx=50&manage_idx=632&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="galbox1_biwon">
                <div class="gallery_box">
                  <c:if test="${fn:length(galleryListh63) < 1}">
                    <div class="gallery">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${galleryListh63}" var="i" varStatus="status" begin="0" end="2">
                    <div class="gallery"> <a href="/${homepage.context_path}/board/view.do?menu_idx=50&manage_idx=632&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="galbox1_wongogye">
                <div class="gallery_box">
                  <c:if test="${fn:length(galleryListh64) < 1}">
                    <div class="gallery">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${galleryListh64}" var="i" varStatus="status" begin="0" end="2">
                    <div class="gallery"> <a href="/${homepage.context_path}/board/view.do?menu_idx=50&manage_idx=632&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--//도서관소식 공지사항,갤러리--> 
      </div>
      <div class="topwrap" id="culturewrap"> 
        <!--도서관행사-->
        <div class="section02">
          <div class="title"> <span>서구통합도서관 행사안내</span> </div>
          <div class="con sec02-1">
            <div class="sec02_tab01" style="margin-top:-30px;">
              <div class="more_btn top-10"> <a href="/${homepage.context_path}/module/teach/index.do?menu_idx=32" class="more-culture"><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a> </div>
            </div>
            <div class="sec02_tab02 tab3">
              <ul>
                <li class="on"><a href="#all" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32">전체</a></li>
                <li class="bar">/</li>
                <li><a href="#seoguchild" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&homepage_id=h77">서구어린이</a></li>
                <li class="bar">/</li>
                <li><a href="#bisan" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&homepage_id=h61">비산</a></li>
                <li class="bar">/</li>
                <li><a href="#english" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&homepage_id=h62">영어</a></li>
                <li class="bar">/</li>
                <li><a href="#biwon" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&homepage_id=h63">비원</a></li>
                <li class="bar">/</li>
                <li><a href="#wongogye" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&homepage_id=h64">원고개</a></li>
                <li class="bar">/</li>
                <li><a href="#pyeongri" class="tab-link3" data-link="/${homepage.context_path}/module/teach/index.do?menu_idx=32&homepage_id=h96">New평리</a></li>
              </ul>
            </div>
            <div class="top3wrap" id="culturebox2_all" style="display:block;">
              <div class="board_box">                
                <div class="board_notice03 pt50">
                  <c:if test="${fn:length(teachList) < 1}">
					<div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
                  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachList}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
                          <c:set var="libcode" value="pyeongri">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
                          <c:set var="libname" value="평리">
                          </c:set>
                        </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"> <a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 --> 
                            ${i.teach_name} </a> </div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachList}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
                      	<c:set var="libname" value="평리">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
                      	<c:set var="libcode" value="pyeongri">
                      	</c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
            <div class="top3wrap" id="culturebox2_seoguchild">
              <div class="board_box">
                <div class="board_notice03 pt50">
                  <c:if test="${fn:length(teachListh77) < 1}">
                     <div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
                  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachListh77}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                      	<c:set var="libname" value="평리">
	                        </c:set>
                      	</c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                      	<c:set var="libcode" value="pyeongri">
	                      	</c:set>
                        </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachListh77}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
            <div class="top3wrap" id="culturebox2_bisan">
              <div class="board_box">
                <div class="board_notice03 pt50">
				  <c:if test="${fn:length(teachListh61) < 1}">
					<div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
				  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachListh61}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                  		<c:set var="libname" value="평리">
	                  		</c:set>
                      	</c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                  		<c:set var="libcode" value="pyeongri">
	                  		</c:set>
                        </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachListh61}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
            <div class="top3wrap" id="culturebox2_english">
              <div class="board_box">
                <div class="board_notice03 pt50">
				  <c:if test="${fn:length(teachListh62) < 1}">
					<div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
				  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachListh62}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachListh62}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
            <div class="top3wrap" id="culturebox2_biwon">
              <div class="board_box">
                <div class="board_notice03 pt50">
				  <c:if test="${fn:length(teachListh63) < 1}">
					<div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
				  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachListh63}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachListh63}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
            <div class="top3wrap" id="culturebox2_wongogye">
              <div class="board_box">
                <div class="board_notice03 pt50">
				  <c:if test="${fn:length(teachListh64) < 1}">
					<div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
				  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachListh64}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachListh64}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libname" value="평리">
	                  	</c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
	                  	<c:set var="libcode" value="pyeongri">
	                  	</c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
            <div class="top3wrap" id="culturebox2_pyeongri">
              <div class="board_box">
                <div class="board_notice03 pt50">
                  <c:if test="${fn:length(teachListh61) < 1}">
                    <div class="empty_box"><p>등록된 행사가 없습니다.</p></div>
                  </c:if>
                  <div>
                    <ul>
                      <c:forEach items="${teachListh96}" var="i" varStatus="status" begin="0" end="7">
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libcode" value="child">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libcode" value="bisan">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libcode" value="english">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libcode" value="biwon">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libcode" value="wongogae">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h77'}">
                          <c:set var="libname" value="서구어린이">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h61'}">
                          <c:set var="libname" value="비산">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h62'}">
                          <c:set var="libname" value="영어">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h63'}">
                          <c:set var="libname" value="비원">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h64'}">
                          <c:set var="libname" value="원고개">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
                          <c:set var="libname" value="평리">
                          </c:set>
                        </c:if>
                        <c:if test="${i.homepage_id eq 'h96'}">
                          <c:set var="libcode" value="pyeongri">
                          </c:set>
                        </c:if>
                        <li class="${libcode}">
                          <div class="cate">${libname}</div>
                          <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                          <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                          <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                          <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                          <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                          <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                          <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
                <div class="board_notice03 m_none pt50" >
                  <ul>
                    <c:forEach items="${teachListh96}" var="i" varStatus="status" begin="8" end="13">
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libcode" value="child">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libcode" value="bisan">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libcode" value="english">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libcode" value="biwon">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libcode" value="wongogae">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h77'}">
                        <c:set var="libname" value="서구어린이">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h61'}">
                        <c:set var="libname" value="비산">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h62'}">
                        <c:set var="libname" value="영어">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h63'}">
                        <c:set var="libname" value="비원">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h64'}">
                        <c:set var="libname" value="원고개">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
                        <c:set var="libname" value="평리">
                        </c:set>
                      </c:if>
                      <c:if test="${i.homepage_id eq 'h96'}">
                        <c:set var="libcode" value="pyeongri">
                        </c:set>
                      </c:if>
                      <li class="${libcode}">
                        <div class="cate">${libname}</div>
                        <div class="tit"><a href="/${homepage.context_path}/module/teach/detail.do?group_idx=${i.group_idx}&teach_idx=${i.teach_idx}&menu_idx=32&category_idx=${i.category_idx}&large_category_idx=${i.large_category_idx}&homepage_id=${i.homepage_id}"><!-- 하이퍼링크 -->${i.teach_name}</a></div>
                        <c:if test="${i.teach_status eq '0'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '1'}"> <span class="flow_02">접수대기</span> </c:if>
                        <c:if test="${i.teach_status eq '2' or i.teach_status eq '10'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '3'}"> <span class="flow_01">접수중</span> </c:if>
                        <c:if test="${i.teach_status eq '9'}"> <span class="flow_03">수강종료</span> </c:if>
                        <c:if test="${i.teach_status eq '4'}"> <span class="flow_03">접수마감</span> </c:if>
                        <c:if test="${i.teach_status eq '5'}"> <span class="flow_03">정원마감</span> </c:if>
                        <c:if test="${i.teach_status eq '6'}"> <span class="flow_03">신청대기</span> </c:if>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--//도서관행사--> 
      </div>
      <div class="topwrap" id="bookswrap"> 
        <!--도서관BOOK-->
        <div class="section02">
          <div class="title"> 
			<span class="m_none">책 읽는 書구, 서구통합도서관 추천'BOOK</span> 
			<span class="pc_none">서구통합도서관 추천'BOOK</span> 
		  </div>
          <div class="con sec02-1">
            <div class="sec02_tab01" style="margin-top:-30px;"> 
              <!-- <ul>
								<li class="on"><div class="line2"><a href="#recomandbook" class="tab-link2" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623">추천<br />도서</a></div></li>
								<li><div class="line2"><a href="#newbook" class="tab-link2" data-link="/${homepage.context_path}/board/index.do?menu_idx=35&manage_idx=628">신착<br />도서</a></div></li>
							</ul> -->
              <div class="more_btn top-10"> <a href="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623" class="more-book"><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a> </div>
            </div>
            <div class="top2wrap" id="top2box_recomandbook" style="display:block;">
              <div class="sec02_tab02 tab3">
                <ul>
                  <li class="on"><a href="#all" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623">전체</a></li>
                  <li class="bar">/</li>
                  <li><a href="#seoguchild" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623&category1=0001">서구어린이</a></li>
                  <li class="bar">/</li>
                  <li><a href="#bisan" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623&category1=0002">비산</a></li>
                  <li class="bar">/</li>
                  <li><a href="#english" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623&category1=0004">영어</a></li>
                  <li class="bar">/</li>
                  <li><a href="#biwon" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623&category1=0003">비원</a></li>
                  <li class="bar">/</li>
                  <li><a href="#pyeongri" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=83&manage_idx=623&category1=0006">New평리</a></li>
                </ul>
              </div>
              <div class="top3wrap" id="recombox3_all" style="display:block;">
                <div class="book_box">
                  <c:if test="${fn:length(bookList) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookList}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title} 상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>

                </div>
              </div>
              <div class="top3wrap" id="recombox3_seoguchild">
                <div class="book_box">
                  <c:if test="${fn:length(bookListh77) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookListh77}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="recombox3_bisan">
                <div class="book_box">
                  <c:if test="${fn:length(bookListh61) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookListh61}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="recombox3_english">
                <div class="book_box">
                  <c:if test="${fn:length(bookListh63) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookListh63}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="recombox3_biwon">
                <div class="book_box">
                  <c:if test="${fn:length(bookListh62) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookListh62}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="recombox3_wongogye">
                <div class="book_box">
                  <c:if test="${fn:length(bookListh64) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookListh64}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                      </a> </div>
                  </c:forEach>
                </div>
              </div>
              <div class="top3wrap" id="recombox3_pyeongri">
                <div class="book_box">
                  <c:if test="${fn:length(bookListh96) < 1}">
                    <div class="book">등록된 데이터가 없습니다.</div>
                  </c:if>
                  <c:forEach items="${bookListh96}" var="i" varStatus="status" begin="0" end="4">
                    <div class="book"> <a href="/${homepage.context_path}/board/view.do?menu_idx=${i.imsi_n_2}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                      <div class="img_box">
                        <c:choose>
                          <c:when test="${i.preview_img ne null}">
                            <c:choose>
                              <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                              <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                            </c:choose>
                          </c:when>
                          <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="con_box">
                        <div class="tit">${i.title}</div>
                      </div>
                    </a> </div>
                  </c:forEach>
                </div>
              </div>
            </div>
            <div class="top2wrap" id="top2box_newbook">
              <div class="sec02_tab02 tab3">
                <ul>
                  <li class="on"><a href="#seoguchild" class="tab-link3">서구어린이</a></li>
                  <li class="bar">/</li>
                  <li><a href="#bisan" class="tab-link3">비산</a></li>
                  <li class="bar">/</li>
                  <li><a href="#english" class="tab-link3">영어</a></li>
                  <li class="bar">/</li>
                  <li><a href="#biwon" class="tab-link3">비원</a></li>
                  <li class="bar">/</li>
                  <li><a href="#wongogye" class="tab-link3">원고개</a></li>
                  <li class="bar">/</li>
                  <li><a href="#pyeongri" class="tab-link3">New평리</a></li>
                </ul>
              </div>
              <script>
								// $.get('newBookSeogu.do', function(e) {
								// 	$('div#top2box_newbook').append(e)
								// });
							</script> 
              <!-- newbook--> 
            </div>
          </div>
        </div>
        <!--//도서관BOOK----> 
      </div>
      <div class="topwrap" id="moviewrap"> 
        <!--영화상영-->
        <div class="section02">
          <div class="title"> <span>이달의 영화상영</span> </div>
          <div class="con sec02-1">
            <div class="sec02_tab01" style="margin-top:-30px;">
              <div class="more_btn top-10"> <a href="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627" class='more-movie'><img src="/resources/homepage/seogulib/img/con02_more_btn.png"></a> </div>
            </div>
            <div class="sec02_tab02 tab3">
              <ul>
                <li class="on"><a href="#all" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627">전체</a></li>
                <li class="bar">/</li>
                <li><a href="#seoguchild" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627&category1=0001">서구어린이</a></li>
                <li class="bar">/</li>
                <li><a href="#bisan" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627&category1=0002">비산</a></li>
                <li class="bar">/</li>
                <li><a href="#english" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627&category1=0003">영어</a></li>
                <li class="bar">/</li>
                <li><a href="#biwon" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627&category1=0004">비원</a></li>
				<li class="bar">/</li>
                <li><a href="#wongogye" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627&category1=0005">원고개</a></li>
				<li class="bar">/</li>
                <li><a href="#pyeongri" class="tab-link3" data-link="/${homepage.context_path}/board/index.do?menu_idx=34&manage_idx=627&category1=0006">New평리</a></li>
              </ul>
            </div>
            <div class="top3wrap" id="moviebox4_all" style="display:block;">
              <div class="movie_box">
                <c:forEach items="${movieList}" var="i" varStatus="status" begin="0" end="2">
                  <div class="movie"> <a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=627&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                    <div class="img_box">
                      <c:choose>
                        <c:when test="${i.preview_img ne null}">
                          <c:choose>
                            <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="con_box">
                      <div class="info">${i.category1_name}</div>
                      <div class="tit">${i.title}</div>
                      <div class="info">${i.imsi_v_12}</div>
                      <div class="info" style="margin-top:20px;line-height:170%;"> <b>일시</b>${i.imsi_v_1}-${i.imsi_v_2}<br />
                        <b>감독</b>${i.imsi_v_7}<br />
                        <b>장르</b>${i.imsi_v_9}<br />
                        <b>시간</b>${i.imsi_v_13}분 </div>
                    </div>
                    </a> </div>
                </c:forEach>
                <c:if test="${fn:length(movieList) < 1}">
				<a href="javascript:alert('상영예정 영화가 없습니다.');">
					<div class="empty_box empty_box02"><p>상영예정 영화가 없습니다.</p></div>
				</a>
				</c:if>
              </div>
            </div>
            <div class="top3wrap" id="moviebox4_seoguchild">
              <div class="movie_box">
                <c:forEach items="${movieListh77}" var="i" varStatus="status" begin="0" end="2">
                  <div class="movie"> <a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=627&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                    <div class="img_box">
                      <c:choose>
                        <c:when test="${i.preview_img ne null}">
                          <c:choose>
                            <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="con_box">
                      <div class="info">${i.category1_name}</div>
                      <div class="tit">${i.title}</div>
                      <div class="info">${i.imsi_v_12}</div>
                      <div class="info" style="margin-top:20px;line-height:170%;"> <b>일시</b>${i.imsi_v_1}-${i.imsi_v_2}<br />
                        <b>감독</b>${i.imsi_v_7}<br />
                        <b>장르</b>${i.imsi_v_9}<br />
                        <b>시간</b>${i.imsi_v_13}분 </div>
                    </div>
                    </a> </div>
                </c:forEach>
                <c:if test="${fn:length(movieListh77) < 1}">
				<div class="movie">
				<a href="javascript:alert('상영예정 영화가 없습니다.');">
					<div class="empty_box empty_box02"><p>상영예정 영화가 없습니다.</p></div>
				</a>
				</div>
				</c:if>
              </div>
            </div>
            <div class="top3wrap" id="moviebox4_bisan">
              <div class="movie_box">
                <c:forEach items="${movieListh61}" var="i" varStatus="status" begin="0" end="2">
                  <div class="movie"> <a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=627&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                    <div class="img_box">
                      <c:choose>
                        <c:when test="${i.preview_img ne null}">
                          <c:choose>
                            <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="con_box">
                      <div class="info">${i.category1_name}</div>
                      <div class="tit">${i.title}</div>
                      <div class="info">${i.imsi_v_12}</div>
                      <div class="info" style="margin-top:20px;line-height:170%;"> <b>일시</b>${i.imsi_v_1}-${i.imsi_v_2}<br />
                        <b>감독</b>${i.imsi_v_7}<br />
                        <b>장르</b>${i.imsi_v_9}<br />
                        <b>시간</b>${i.imsi_v_13}분 </div>
                    </div>
                    </a> </div>
                </c:forEach>
                <c:if test="${fn:length(movieListh61) < 1}">
				<div class="movie">
				<a href="javascript:alert('상영예정 영화가 없습니다.');">
					<div class="empty_box empty_box02"><p>상영예정 영화가 없습니다.</p></div>
				</a>
				</div>
				</c:if>
              </div>
            </div>
            <div class="top3wrap" id="moviebox4_english">
              <div class="movie_box">
                <c:forEach items="${movieListh62}" var="i" varStatus="status" begin="0" end="2">
                  <div class="movie"> <a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=627&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                    <div class="img_box">
                      <c:choose>
                        <c:when test="${i.preview_img ne null}">
                          <c:choose>
                            <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="con_box">
                      <div class="info">${i.category1_name}</div>
                      <div class="tit">${i.title}</div>
                      <div class="info">${i.imsi_v_12}</div>
                      <div class="info" style="margin-top:20px;line-height:170%;"> <b>일시</b>${i.imsi_v_1}-${i.imsi_v_2}<br />
                        <b>감독</b>${i.imsi_v_7}<br />
                        <b>장르</b>${i.imsi_v_9}<br />
                        <b>시간</b>${i.imsi_v_13}분 </div>
                    </div>
                    </a> </div>
                </c:forEach>
                <c:if test="${fn:length(movieListh62) < 1}">
				<div class="movie">
				<a href="javascript:alert('상영예정 영화가 없습니다.');">
					<div class="empty_box empty_box02"><p>상영예정 영화가 없습니다.</p></div>
				</a>
				</div>
				</c:if>
              </div>
            </div>
						<div class="top3wrap" id="moviebox4_biwon">
							<div class="movie_box">
								<c:forEach items="${movieListh63}" var="i" varStatus="status" begin="0" end="2">
									<div class="movie">
										<a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=627&board_idx=${i.board_idx}">
										<div class="img_box">
											<c:choose>
												<c:when test="${i.preview_img ne null}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'http')}">
															<img src="${i.preview_img}" alt="${i.title}" />
														</c:when>
														<c:when test="${fn:contains(i.preview_img, 'noImg2')}">
															<img src="${i.preview_img}" alt="${i.title}" />
														</c:when>
														<c:otherwise>
															<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="con_box">
											<div class="info">${i.category1_name}</div>
											<div class="tit">${i.title}</div>
											<div class="info">${i.imsi_v_12}</div>
											<div class="info" style="margin-top:20px;line-height:170%;">
												<b>일시</b>${i.imsi_v_1}-${i.imsi_v_2}<br />
												<b>감독</b>${i.imsi_v_7}<br />
												<b>장르</b>${i.imsi_v_9}<br />
												<b>시간</b>${i.imsi_v_13}분
											</div>
										</div>
										</a>
									</div>
								</c:forEach>
							</div>
						</div>
            
            <div class="top3wrap" id="moviebox4_wongogye">
              <div class="movie_box">
                <c:forEach items="${movieListh64}" var="i" varStatus="status" begin="0" end="2">
                  <div class="movie"> <a href="/${homepage.context_path}/board/view.do?menu_idx=34&manage_idx=627&board_idx=${i.board_idx}"><!-- 하이퍼링크 -->
                    <div class="img_box">
                      <c:choose>
                        <c:when test="${i.preview_img ne null}">
                          <c:choose>
                            <c:when test="${fn:contains(i.preview_img, 'http')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:when test="${fn:contains(i.preview_img, 'noImg2')}"> <img src="${i.preview_img}" alt="${i.title}" /> </c:when>
                            <c:otherwise> <img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}"/> </c:otherwise>
                          </c:choose>
                        </c:when>
                        <c:otherwise> <img src="/resources/common/img/noImg2.png" alt="${i.title}  상세보기"/> </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="con_box">
                      <div class="info">${i.category1_name}</div>
                      <div class="tit">${i.title}</div>
                      <div class="info">${i.imsi_v_12}</div>
                      <div class="info" style="margin-top:20px;line-height:170%;"> <b>일시</b>${i.imsi_v_1}-${i.imsi_v_2}<br />
                        <b>감독</b>${i.imsi_v_7}<br />
                        <b>장르</b>${i.imsi_v_9}<br />
                        <b>시간</b>${i.imsi_v_13}분 </div>
                    </div>
                    </a> </div>
                </c:forEach>
                <c:if test="${fn:length(movieListh64) < 1}">
				<div class="movie">
				<a href="javascript:alert('상영예정 영화가 없습니다.');">
					<div class="empty_box empty_box02"><p>상영예정 영화가 없습니다.</p></div>
				</a>
				</div>
				</c:if>
              </div>
            </div>
          </div>
        </div>
        <!--//영화상영--> 
      </div>
      
      <!--배너-->
      <div class="banner-wrap type1">
        <div class="banner-t4">
          <h3>배너모음</h3>
          <div class="control"> <a class="prev" href="#prev"><img src="/resources/homepage/seogulib/img/banner_prev_btn.png"><span class="blind">이전</span></a> <a class="stop active" href="#stop"><img src="/resources/homepage/seogulib/img/banner_pause_btn.png"><span class="blind">정지</span></a> <a class="play" href="#play"><img src="/resources/homepage/seogulib/img/banner_play_btn.png"><span class="blind">시작</span></a> <a class="next" href="#next"><img src="/resources/homepage/seogulib/img/banner_next_btn.png"><span class="blind">다음</span></a> <a class="more" href="/${homepage.context_path}/bannermap/index.do?menu_idx=81"><img src="/resources/homepage/seogulib/img/banner_menu_btn.png"><span class="blind">더보기</span></a> </div>
        </div>
        <div class="banner-box4">
          <homepageTag:banner bannerList="${bannerList}"/>
        </div>
      </div>
      <!--//배너--> 
    </div>
    <!--//section02--> 
    
  </div>
  <tiles:insertAttribute name="footer" />
</div>

