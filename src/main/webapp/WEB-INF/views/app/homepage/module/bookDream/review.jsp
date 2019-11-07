<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div id="main">
	<!-- 본문 s -->
	<div class="main_left">
		<h2>새 책 드림 서비스</h2>
		<p class="guide_box">새 책 드림 Dream 서비스는 이용자가 도서관 미소장 도서를 협약 서점에서 구입해 2주간 이용하고 도서관에 반납하면 판매서점이 도서대금을 환불해주는 ‘이용자 희망도서 직접 구매 제도’입니다.</p>
		<ul class="con01">
			<li><strong>참여대상</strong>: 경상북도교육청 안동도서관(본관, 용상•풍산분관)<br>
			<span style="padding-left:52px;">안동시 관내 서점, 도서관 회원</span></li>
			<li><strong>반납안내</strong>: 도서 구입일부터 15일 내 반납<br>
			<span style="padding-left:52px; color:red;">예) 2016년 7월 1일 구입 시, 2016년 7월 15일까지 반납</span></li>
			<li><strong>구입</strong>
				<ul class="con02">
					<li>구입신청: 1인 월 4권 이내 (1회 최대 2권 신청 가능)<br>
					<span style="padding-left:52px;">※ 동일 도서 불가</span></li>
					<li>구입처: 안동시 관내 지정 서점(6개)</li>
				</ul>
			</li>
			<li><strong>반납</strong>
				<ul class="con02">
					<li>반납처: 본관 1층 문헌정보계, 용상분관, 풍산분관</li>
					<li>반납확인: 도서관 회원카드와 구입 영수증 지참(본인 및 가족)</li>
					<li>오·훼손: 오염 및 훼손된 도서는 반납대상에서 제외<br>※ 본관 및 용상분관, 풍산분관은 각각 별도로 운영되오니 구입을 신청한<br>
					<span style="padding-left:15px;">도서관으로 반납하시길 바랍니다.</span></li>
				</ul>
			</li>
			<li><strong>환불</strong>
				<ul class="con02">
					<li>환불처: 도서를 구입한 서점</li>
					<li>기타 환불에 관한 사항: 이용자와 서점에 일임</li>
				</ul>
			</li>
		</ul>
	</div>

	<div class="main_right">
		<ul class="con01">
			<li><strong>개인소장 및 연체</strong>
				<ul class="con02">
					<li>개인소장: 구입일로부터 3일 이내 ‘개인소장’ 버튼 클릭 시 개인 소장 가능</li>
					<li>연체: 구입일로부터 15일이 경과할 경우 개인소장으로 간주하며,<br>이후 30일 간 도서구입불가</li>
				</ul>
			</li>
		</ul>
		<h2 class="tmg">새 책 드림 서점 리스트</h2>
		<ul class="con01 scroll">
			<li><span class="name">세종서적</span><span class="address">경상북도 안동시 옥서1길 77</span><span class="tel">☎ 054-859-2945</span></li>
			<li><span class="name">강남서점</span><span class="address">경상북도 안동시 강남5길 26</span><span class="tel">☎ 054-843-2363</span></li>
			<li><span class="name">느낌표</span><span class="address">경상북도 안동시 길주길 101</span><span class="tel">☎ 054-822-8881</span></li>
			<li><span class="name">현대서림</span><span class="address">경상북도 안동시 경북대로 400</span><span class="tel">☎ 054-856-2400</span></li>
			<li><span class="name">교학사</span><span class="address">경상북도 안동시 문화광장길 60</span><span class="tel">☎ 054-857-7131</span></li>
			<li><span class="name">종로서적</span><span class="address">경상북도 안동시 서동문로 93</span><span class="tel">☎ 054-853-7575</span></li>
		</ul>

		<h2 class="tmg">새 책 드림 바로가기 서비스</h2>
		<a href="requestForm.do"><img src="/resources/homepage/bookdream/img/btn_request.png" alt="새 책 드림 신청하기"/></a>
		<a href="mypage.do"><img src="/resources/homepage/bookdream/img/btn_request_list.png" alt="내가 신청한 내역보기"/></a>
		<br><strong class="red">※ 신청가능한 책은 기관별 월 1인 4권까지 입니다.</strong>
	</div>
	<!-- 본문 e -->
</div>

