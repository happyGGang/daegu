<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/section3.js"></script>

				<div class="swiper_wrapper">
					<div class="book_information_swiper">
						<div class="swiper">
							<div class="swiper-wrapper">
								<c:if test="${fn:length(newBookList) < 1}">
									<!-- TODO null처리 -->
									<div class="swiper-slide">
										<div>
											<div class="book_title">콘텐츠가 없습니다.</div>
											<div class="book_writer"></div>
											<div class="book_year">최대한 빠른 시일 내에<br> 업데이트하도록 하겠습니다.</div>
										</div>
										<img src="/resources/common/img/noImg2.png" alt="" onerror="this.src='/resources/common/img/noImg2.png';" />
									</div>
								</c:if>
								<c:forEach var="i" varStatus="status" items="${newBookList}">
									<div class="swiper-slide">
										<div>
											<div class="book_title">${i.TITLE_INFO}</div>
											<div class="book_writer">${i.AUTHOR}</div>
											<div class="book_year">${i.PUBLISHER}<span class='new_dot'>ㆍ</span><br />${i.PUB_YEAR}</div>
										</div>
										<c:choose>
											<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
												<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
											</c:when>
											<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
												<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
											</c:when>
											<c:otherwise>
												<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
											</c:otherwise>
										</c:choose>
									</div>
								</c:forEach>
							</div>
						</div>

						<div class="swiper_action_wrapper">
							<div class="swiper-button-prev"></div>
							<div class="swiper-button-next"></div>
							<c:if test="${fn:length(newBookList) > 1}">
								<img src="/resources/homepage/center/img/book_information_stop.svg" alt="정지버튼" class="book_autoplay" role="button" />
							</c:if>
						</div>
					</div>
					<div class="book_list swiper">
						<div class="swiper-wrapper">
							<!-- TODO null처리 -->
							<c:if test="${fn:length(newBookList) < 1}">
								<div class="swiper-slide"></div>
							</c:if>
							<c:forEach var="i" varStatus="status" items="${newBookList}" begin="1">
								<div class="swiper-slide">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';" />
										</c:when>
										<c:otherwise>
											<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
							<c:forEach var="i" varStatus="status" items="${newBookList}" begin="0" end="0">
								<div class="swiper-slide">
									<c:choose>
										<c:when test="${(empty i.aladin or empty i.aladin.cover) and empty i.imageUrl}">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다.  상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
										</c:when>
										<c:when test="${not empty i.aladin or not empty i.aladin.cover}">
											<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';" />
										</c:when>
										<c:otherwise>
											<img src="${i.imageUrl}" alt="${i.TITLE_INFO} 상세보기" onclick="location.href='/${homepage.context_path}/intro/search/detail.do?menu_idx=10&isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=BOOK'" onerror="this.src='/resources/common/img/noImg2.png';"/>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>