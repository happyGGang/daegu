<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<link rel="stylesheet" type="text/css" href="/resources/common/css/kiosk/swiper.min.css"  />

<tiles:insertAttribute name="header" />

<div class="userrecommandbookdetail-wrap">
	<div class="header">
		<h1>도서정보</h1>
		<p>Book information</p>
	</div>
	<div class="contents">
		<div class="img-sec">
			<img src="${librarianPickBook.bookimgUrl}" alt="${librarianPickBook.book_name}">
		</div>
		<div class="title-sec">
			${librarianPickBook.book_name}
		</div>
		<div class="bookinfo-sec">
			<ul>
				<li><span class="">저자명</span> ${librarianPickBook.author}</li>
				<li><span class="">소장위치</span> ${detail.SHELF_LOC_NAME}</li>
				<li><span class="">출판사</span> ${detail.PUBLISHER}</li>
				<li><span class="">청구기호</span> ${detail.CALL_NO}</li>
				<li><span class="">ISBN</span> ${librarianPickBook.isbn}</li>
				<li><span class="">등록번호</span> ${detail.REG_NO}</li>
			</ul>
		</div>
		<div class="print-sec">
			<div class="print-btn">
				<a href="#" id="print-btn-toggle">국채보상운동기념도서관 소장도서 <strong>서가위치보기</strong></a>
			</div>
		</div>
		<div class="etcinfo-sec">
			집착에 가까울 만큼 자연계에 질서를 부여하려 했던 19세기 어느 과학자의 삶을 흥미롭게 좇아가는 이 책은 어느 순간 독자들을 혼돈의 한복판으로 데려가서 우리가 믿고 있던 삶의 질서에 관해 한 가지 의문을 제기한다. “물고기가 존재하지 않는다는 것은 엄연한 하나의 사실이다. 그렇다면 우리는 또 무엇을 잘못 알고 있을까?” 하고 말이다. 누군가에게는 이 질문이 살아가는 데 아무런 영향을 미치지 않을 수도 있다. 하지만 세상을..
		</div>
		<div class="backbutton-sec">
			<a href="">< 이전</a>
		</div>
	</div>
</div>

<tiles:insertAttribute name="footer" />