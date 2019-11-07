<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<tiles:insertAttribute name="header" />
<script type="text/javascript">
	$(function() {
		$(window).resize(function() {
			$('.bbs_gallery img').height($('.bbs_gallery img').width() * 0.6);
		}).trigger('resize');
		
		$('img.previewImg').error(function() {
			var src=  $(this).attr('src');
			$(this).attr('src', src.replace('/thumb', ''));	
			$(this).unbind("error").attr("src", src.replace('/thumb', ''));
		});
		
		var $form = $('#board');
		$('.category2_list a').on('click', function() {
			var url = 'otherBoardEdit.do';
			$('#viewPage').attr('value', '1');
			var category = $(this).attr('codeid').split(':');
			$('#category1').attr('value', category[0]);
			$('#category2').attr('value', category[1]);
			var formData = serializeCustom($form);
			doGetLoad(url, formData);
		});
		
		$('.category3_list a').on('click', function() {
			var url = 'otherBoardEdit.do';
			$('#viewPage').attr('value', '1');
			$('#category3').attr('value', $(this).attr('codeid'));
			var formData = serializeCustom($form);
			doGetLoad(url, formData);
		});
		
		$('a.leftMenu').on('click', function(e) {
			e.preventDefault();
			$(this).next('ul').find('a:first').click();
		});
		
	});
</script>
<div id="wrap" class="section">
	<nav id="menu"></nav>

	<div id="header">
		<div class="logo">
			<h1><a href="">경상북도공공도서관<br /><strong>디자인센터</strong></a></h1>
			<p>든든한 미래,시민과 미래를 함께합니다.</p>
		</div>
		<div class="mmode m-menu">
			<a href="#menu"><i class="fa fa-navicon"></i><span class="blind">메뉴</span></a>
		</div>
		<div class="Gnb">
			<h2 class="blind">주메뉴</h2>
			<div class="g-menu">
				<!-- menu S -->
				<ul class="gnb-menu">
					<c:if test="${member.admin}">
					<li class="List"><a href="/dms/board/index.do?manage_idx=592&board_idx=0&menu_idx=1"><span>관리자이미지소스관리</span></a></li>
					</c:if>
					<c:forEach var="i" items="${category1List}" varStatus="status">
					<li class="List ${i.code_id eq board.category1?'active':''} category1_list"><a href="#" class="leftMenu" codeid="${i.code_id}"><span>${i.code_name}</span></a>
						<ul class="SubMenu">
						<c:forEach var="j" items="${category2List}" varStatus="status">
							<li class="${i.code_id eq board.category1 and j.code_id eq board.category2?'active':''} category2_list"><a href="#" codeid="${i.code_id}:${j.code_id}">- ${j.code_name}</a></li>
							<%-- <li class="category2_list"><a href="#" codeid="${j.code_id}">- ${j.code_name}</a></li> --%>
						</c:forEach>
						</ul>	
					</li>
					</c:forEach>
					<!-- <li class="List active"><a href=""><span>평생교육강좌</span></a>
						<ul class="SubMenu">
							<li><a href="">- A3 사이즈</a></li>
							<li><a href="">- Web 사이즈</a></li>
							<li><a href="">- 기타</a></li>
						</ul>
					</li>
					<li class="List"><a href=""><span>문화가있는날</span></a></li>
					<li class="List"><a href=""><span>세계책의날</span></a></li>
					<li class="List"><a href=""><span>도서관주간행사</span></a></li>
					<li class="List"><a href=""><span>독서교실</span></a></li>
					<li class="List"><a href=""><span>방학특강</span></a></li>
					<li class="List"><a href="sub.jsp?menu_seq="><span>기타 홍보</span></a></li> -->
				</ul>
				<!-- menu E -->
			</div>
		</div>
		<div class="call">
			<span>HELP DESK</span>
			<p>053-810-9999</p>
			<em>평일  :  09: 00 ~ 22 : 00<br />토요일 /일요일 :  09 : 00 ~ 17 :  00</em>
		</div>
		<tiles:insertAttribute name="footer" />
	</div>
	<div class="lnb_s">
		<h1>${member.member_name}</h1>
	</div>
	
	<div class="tnb_bg">&nbsp;</div>
	<div id="container">
		<div class="container">
			<div class="tnb">
				<a href="/dms/index.do">처음으로</a>
				<span class="txt-bar"></span>
				<a href="/dms/login/logout.do">로그아웃</a>
				<span class="txt-bar"></span>
				<!-- <a href="">홈페이지바로가기</a> -->
			</div>

			<div class="subpage">

				<div class="content">
					<div class="doc">
						<div class="doc-menu col4 category3_list" style="display: none;">
						<c:forEach var="i" items="${category3List}" varStatus="status">
							<a href="#" class="${status.index eq 0?'first':status.index eq 2?'third':''} ${i.code_id eq board.category3?'active':''}" codeid="${i.code_id}"><span>${i.code_name}</span></a>
						</c:forEach>
							<!-- <a href="" class="first active"><span>도서관 홍보</span></a>
							<a href=""><span>도서관 공지</span></a>
							<a href="" class="third"><span>도서관 팝업</span></a>
							<a href=""><span>도서관 배너</span></a> -->
						</div>
						<div class="doc-body" id="contentArea">
							<div class="body">
								<!-- 본문 s -->
								<tiles:insertAttribute name="body" />
								<!-- 본문 e -->
							</div>
						</div>
					</div>
				
				</div>
			</div>
		</div>
	</div>

</div>

<tiles:insertAttribute name="footer" />

</body>
</html>