<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<div class="top3wrap" id="newbookbox3_seoguchild">
	<div class="book_box">
		<c:forEach items="${newBookListh77}" var="i" begin="0" end="4">
			<div class="book" onclick="">
				<div class="img_box">
					<c:choose>
						<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
							<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
						</c:when>
						<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
							<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:when>
						<c:otherwise>
							<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="con_box">
					<div class="tit">${i.TITLE_INFO}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="top3wrap" id="newbookbox3_bisan">
	<div class="book_box">
		<c:forEach items="${newBookListh61}" var="i" begin="0" end="4">
			<div class="book" onclick="">
				<div class="img_box">
					<c:choose>
						<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
							<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
						</c:when>
						<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
							<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:when>
						<c:otherwise>
							<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="con_box">
					<div class="tit">${i.TITLE_INFO}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="top3wrap" id="newbookbox3_english">
	<div class="book_box">
		<c:forEach items="${newBookListh62}" var="i" begin="0" end="4">
			<div class="book" onclick="">
				<div class="img_box">
					<c:choose>
						<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
							<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
						</c:when>
						<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
							<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:when>
						<c:otherwise>
							<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="con_box">
					<div class="tit">${i.TITLE_INFO}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="top3wrap" id="newbookbox3_biwon">
	<div class="book_box">
		<c:forEach items="${newBookListh63}" var="i" begin="0" end="4">
			<div class="book" onclick="">
				<div class="img_box">
					<c:choose>
						<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
							<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
						</c:when>
						<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
							<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:when>
						<c:otherwise>
							<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="con_box">
					<div class="tit">${i.TITLE_INFO}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="top3wrap" id="newbookbox3_wongogye">
	<div class="book_box">
		<c:forEach items="${newBookListh64}" var="i" begin="0" end="4">
			<div class="book" onclick="">
				<div class="img_box">
					<c:choose>
						<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
							<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기"/>
						</c:when>
						<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
							<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:when>
						<c:otherwise>
							<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="con_box">
					<div class="tit">${i.TITLE_INFO}</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>