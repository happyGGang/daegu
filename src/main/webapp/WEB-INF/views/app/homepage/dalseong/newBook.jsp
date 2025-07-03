<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page import="java.util.Random" %>
<%
Random rnd = new Random();
int[] listNums = new int[10];
int maxIndex = 10; // Default to 10, will adjust based on newBookList size
for (int i = 0; i < maxIndex; i++) {
int num;
boolean unique;
do {
unique = true;
num = rnd.nextInt(maxIndex);
for (int j = 0; j < i; j++) {
if (listNums[j] == num) {
unique = false;
break;
}
}
} while (!unique);
listNums[i] = num;
}
%>
<c:set var="listNums" value="<%=listNums%>"/>
<c:choose>
	<c:when test="${fn:length(newBookList) > 0}">
		<img class="book-slide-prev" src="/resources/homepage/${homepage.context_path}/img/book/arrow-left.svg" alt="">
		<div class="book-slide">
			<c:set var="loopCount" value="${fn:length(newBookList) > 10 ? 10 : fn:length(newBookList)}"/>
			<c:forEach var="i" begin="0" end="${loopCount - 1}">
				<div class="book-slide-item">
					<a href="/${homepage.context_path}intro/search/detail.do?menu_idx=14&isbn=${newBookList[listNums[i]].ST_CODE}regNo=${fn:escapeXml(newBookList[listNums[i]].REG_NO)}&manageCode=${fn:escapeXml(newBookList[listNums[i]].MANAGE_CODE)}&booktype=BO">
						<c:choose>
							<c:when test="${(empty newBookList[listNums[i]].aladin or empty newBookList[listNums[i]].aladin.cover) and empty newBookList[listNums[i]].imageUrl}">
								<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
							</c:when>
							<c:otherwise>
								<img src="${newBookList[listNums[i]].imageUrl}" alt="${newBookList[listNums[i]].TITLE_INFO} 상세보기" onerror="this.onerror=null; this.src='/resources/homepage/${homepage.context_path}/img/common/dummy.png'"/>
							</c:otherwise>
						</c:choose>
					</a>
					<div class="title">${newBookList[listNums[i]].TITLE_INFO}</div>
				</div>
			</c:forEach>
		</div>
		<img class="book-slide-next" src="/resources/homepage/${homepage.context_path}/img/book/arrow-right.svg" alt="">
	</c:when>
	<c:otherwise>
		<div class="book-nodata">등록된 신착도서가 없습니다.</div>
	</c:otherwise>
</c:choose>

