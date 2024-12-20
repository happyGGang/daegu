<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="/resources/homepage/${homepage.context_path}/js/section3.js"></script>

				<div class="swiper_wrapper">
					<div class="book_information_swiper">
						<div class="swiper">
							<div class="swiper-wrapper">
								<!-- TODO 사서추천도서 no data 처리 -->
								<c:if test="${fn:length(recommendBookList) < 1}">
									<div class="swiper-slide">
										<div>
											<div class="book_title">콘텐츠가 없습니다.</div>
											<div class="book_writer"></div>
											<div class="book_year">최대한 빠른 시일 내에<br> 업데이트하도록 하겠습니다.</div>
										</div>
										<img src="/resources/common/img/noImg2.png" alt="" onerror="this.src='/resources/common/img/noImg2.png';" />
									</div>
								</c:if>
								<c:forEach var="i" varStatus="status" items="${recommendBookList}">
									<div class="swiper-slide">
										<div>
											<div class="book_title">${i.title}</div>
											<div class="book_writer">${i.imsi_v_3}</div>
											<div class="book_year">${i.imsi_v_4}<span class='new_dot'>ㆍ</span><br />${i.imsi_v_2}</div>
										</div>
										<c:choose>
											<c:when test="${i.preview_img ne null}">
												<c:choose>
													<c:when test="${fn:contains(i.preview_img, 'http')}">
														<c:choose>
															<c:when test="${fn:contains(i.preview_img, 'noimg')}">
																<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
															</c:when>
															<c:otherwise>
																<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" >
											</c:otherwise>
										</c:choose>
									</div>
								</c:forEach>
							</div>
						</div>

						<div class="swiper_action_wrapper">
								<div class="swiper-button-prev"></div>
								<div class="swiper-button-next"></div>
								<c:if test="${fn:length(recommendBookList) > 4}">
									<img src="/resources/homepage/center/img/book_information_stop.svg" alt="정지버튼" class="book_autoplay" role="button" />
								</c:if>
						</div>
					</div>
					
					<div class="book_list swiper">
						<div class="swiper-wrapper">
							<!-- TODO 사서추천도서 no data 처리 -->
							<c:if test="${fn:length(recommendBookList) < 1}">
								<div></div>
							</c:if>
							<c:forEach var="i" varStatus="status" items="${recommendBookList}" begin="1">
								<div class="swiper-slide">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'noimg')}">
															<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
														</c:when>
														<c:otherwise>
															<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" >
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
							<c:forEach var="i" varStatus="status" items="${recommendBookList}" begin="0" end="0">
								<div class="swiper-slide">
									<c:choose>
										<c:when test="${i.preview_img ne null}">
											<c:choose>
												<c:when test="${fn:contains(i.preview_img, 'http')}">
													<c:choose>
														<c:when test="${fn:contains(i.preview_img, 'noimg')}">
															<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
														</c:when>
														<c:otherwise>
															<img src="${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<img src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" />
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="/resources/common/img/noimg-gall.png" alt="${i.title}" title="${i.title}" onclick="location.href='/${homepage.context_path}/board/view.do?menu_idx=15&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}'" onerror="this.src='/resources/common/img/noImg2.png';" >
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>