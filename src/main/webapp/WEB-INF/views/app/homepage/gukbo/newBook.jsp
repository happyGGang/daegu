<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


										<div class="swiper-location">
											<div class="swiper-prev">이전</div>
											<div class="">
												<a href="/${homepage.context_path}/board/index.do?menu_idx=115&manage_idx=174" class="more-book"><img src="/resources/homepage/${homepage.context_path}/img/book-more-btn.png" alt="문화강좌 더보기"></a>
											</div>
											<div class="swiper-next">다음</div>
										</div>

										<div class="swiper-wrapper">

											<c:if test="${fn:length(newBookList) < 1}">
											<div>등록된 데이터가 없습니다.</div>
											</c:if>
											<c:forEach var="i" items="${newBookList}">
											<div class="list">
												<a class="goDetail" href="/${homepage.context_path}/intro/search/detail.do?menu_idx=9&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BO">
													<span class="images-box">
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
													</span>
													<span class="title-box">${fn:length(i.TITLE_INFO) > 11 ? fn:substring(i.TITLE_INFO, 0, 12) : i.TITLE_INFO}<c:if test="${fn:length(i.TITLE_INFO) > 11 }">...</c:if></span>
												</a>
											</div>
											</c:forEach>

										</div>