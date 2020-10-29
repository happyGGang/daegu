<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$(function() {
	
	$('a#apply_btn').on('click', function(e) {
		e.preventDefault();
		doGetLoad('step2.do', serializeCustom($('form#readerContest')));
	});
});
</script>

<form:form modelAttribute="readerContest" id="readerContest" action="step2.do" >
<form:hidden path="menu_idx"/>
	<div style="margin-bottom: 20px;">
		<h4>개최개요</h4>
		<ul>
			<li>참가자격 : 수성구립도서관 이용자</li>
			<li>신청기간 : 2020. 6.2.(화) ~ 10.31.(토)</li>
		</ul>
	</div>
	<div style="margin-bottom: 20px;">
		<h4>참여방법</h4>
		<ul>
			<li>「2020 수성북」1권 이상을 포함하여 서평 작성</li>
			<li>서평 1건당 300자~1,000자 이내</li>
			<li>오프라인
				<ul style="margin-left: 10px;">
					<li>· 기간 : 10.1.(목) ~ 10.31.(토)</li>
					<li>· 방법 : 독서노트 방문제출(범어·용학·고산도서관)</li>
				</ul>
			</li>
			<li>온라인
				<ul style="margin-left: 10px;">
					<li>· 기간 : 6.2.(화) ~ 10.31.(토)</li>
					<li>· 방법 : 책표지 사진, 서평 게재(@suseong_lib 게시물 참고)</li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="txt-box">
		<h5>독서노트 소개</h5>
		<p>[책자형]</p>
		<ul>
			<li>배부기간 : 2020. 6. 2.(화) ~ 소진시</li>
			<li>부처 : 수성구립도서관(범어·용학·고산)</li>
			<li>배부방법 : 독서릴레이 신청서 작성(홈페이지) → 방문수령</li>
		</ul>
		<p>[웹형]</p>
		<ul>
			<li>인스타그램(@suseong_lib) 게시물 확인 → 책표지 사진 포함 서평작성(#수성문학제#수성북#독서릴레이 태그 후 게재)</li>
		</ul>
	</div>
	<div style="margin-bottom: 20px;">
		<h4>시상</h4>
		<ul>
			<li>발표 : 2020년 11월 중 개별통보 및 홈페이지 발표</li>
			<li>시상 : 2020년 12월 예정</li>
			<li>시상내역</li>
		</ul>
		<p>※ 상품금액에 의한 재세공과금 본인 부담</p>
		<p>※ 훈격과 시상인원은 참여인원 및 심사결과에 따라 조정 가능</p>
	</div>
	<div style="margin-bottom: 20px;">
		<h4>심사방법</h4>
		<div class="txt-box">
			<ul>
				<li>표절방지프로그램 CopyKiller 사용, 표절이 판단될 경우 미인정</li>
				<li>심사위원 위촉, 심사</li>
			</ul>
		</div>
	</div>
	
	<div class="button bbs-btn center">
		<a href="#" id="apply_btn" class="btn btn1">참여신청</a>
	</div>
</form:form>
