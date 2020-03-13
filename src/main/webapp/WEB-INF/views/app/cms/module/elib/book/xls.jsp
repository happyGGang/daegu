<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	.txt {mso-number-format:'\@'}
</style>
<table>
	<thead>
		<tr>
			<th>book_idx</th>
			<th>콘텐츠 타입</th>
			<th>공급사 코드</th>
			<th>도서관 코드</th>
			<th>도서관명</th>
			<th>북코드</th>
			<th>1차 카테고리</th>
			<th>2차 카테고리</th>
			<th>콘텐츠명</th>
			<th>저자</th>
			<th>출판사</th>
			<th>ISBN13</th>
			<th>출판일</th>
			<th>등록일</th>
			<th>포맷</th>
			<th>수량</th>
			<th>이미지</th>
			<th>마크URL</th>
		</tr>
	</thead>
	<tbody>
<c:forEach var="i" varStatus="status" items="${marcUrlList}">
		<tr>
			<td>${i.book_idx}</td>
			<td>${i.type}</td>
			<td>${i.com_code}</td>
			<td class="txt">${i.library_code}</td>
			<td>${i.library_name}</td>
			<td class="txt">${i.book_code}</td>
			<td>${i.parent_name}</td>
			<td>${i.cate_name}</td>
			<td>${i.book_name}</td>
			<td>${i.author_name}</td>
			<td>${i.book_pubname}</td>
			<td class="txt">${i.isbn13}</td>
			<td>${i.book_pubdt}</td>
			<td>${i.book_regdt}</td>
			<td>${i.format}</td>
			<td>${i.max_lend}</td>
			<td>${i.book_image}</td>
			<td>
				<c:choose>
				<c:when test="${i.type eq 'EBK'}">
				https://library.daegu.go.kr/elib/module/elib/book/view.do?menu_idx=14&type=EBK&book_idx=${i.book_idx}
				</c:when>
				<c:when test="${i.type eq 'ADO'}">
				https://library.daegu.go.kr/elib/module/elib/book/view.do?menu_idx=19&type=ADO&book_idx=${i.book_idx}
				</c:when>
				<c:when test="${i.type eq 'WEB'}">
				https://library.daegu.go.kr/elib/module/elib/book/view.do?menu_idx=27&type=WEB&book_idx=${i.book_idx}
				</c:when>
				</c:choose>
			</td>
		</tr>
</c:forEach>
	</tbody>
</table>