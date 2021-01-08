<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>

<!-- 도서정보목록 -->


<!-- <h2>이용자 맞춤형 <span style="font-weight:300">추천도서</span></h2> -->
<div class="user_pick_info">
	<img src="/resources/homepage/dgportal/img/user_pick_icon.png">
	<h2>이용자 맞춤형 도서추천이란?</h2>
	<p class="txt_box01">DIP(대구디지털산업진흥원 빅데이터활용센터)에서 대구광역시 공공도서관의 도서정보, 대출이력, 회원정보 등을 수집해 빅데이터 분석 후 나와 선호도가 유사한 이용자들 중 내가 아직 읽지 않은 도서를 추천해주는 서비스입니다. </p>
	<p class="txt_box02">도서추천은 <u>2019년 1월 ~ 2020년 7월까지 10권이상</u> 대구광역시립 공공도서관 대출이력의 데이터를 기반으로 수집됩니다.</p>
</div>
<div class="kdcBookList2">
	<ul class="bookListz">
		<c:if test="${fn:length(userPickBookList) < 1}">
		<div class="data_none">
		<p>대출이력이 없는 이용자분들께는 향후 개선을 통해 더 나은 서비스를<br />제공할 수 있도록 할 예정이오니 이용자분들의 양해 부탁드립니다.</p>
		</div>
		</c:if>

		<c:forEach items="${userPickBookList}" var="i">
			<li>
				<div class="thumb">
					<a href="/${homepage.context_path}/intro/search/indexAll.do?menu_idx=${searchMenuIdx}&booktype=BOOKANDNONBOOK&title=${i.TITLE}#search_result" class="cover">
						<span class="img">

							<img src="${empty i.THUMBNAIL ? '/resources/common/img/noImg2.png' : i.THUMBNAIL}" alt="${i.bookname}" >
						</span>
					</a>
				</div>
				<span class="tit">${i.TITLE}</span>
				<span class="author">${i.AUTHOR}</span>
			</li>
		</c:forEach>
	</ul>
</div>