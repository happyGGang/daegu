<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>

<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/view/script.jsp" flush="false" />
<form:form modelAttribute="board" method="get">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<jsp:include page="/WEB-INF/views/app/board/common/form_paging_param.jsp" flush="false" />
<form:hidden path="editMode"/>
<form:hidden path="target_manage_idx"/>
<form:hidden path="category1"/>
</form:form>
<div class="wrapper-bbs">
	<div class="bbs-view">
		<div class="bbs-view-header">
			<jsp:include page="/WEB-INF/views/app/board/common/view/moveOrCopy.jsp" flush="false" />
			<dl>
				<dt>${board.title}</dt>
				<dd class="info">
					<div class="panel-left">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y' and not authMBA}">
						<c:set var="user_name" value="${fn:substring(board.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${board.user_name}"/>
						</c:otherwise>
						</c:choose>
						<i>작성자</i><span>${user_name}<c:if test="${authMBA}">(${board.add_id})</c:if></span>
						<i>작성일</i><span><fmt:formatDate value="${board.add_date}" pattern="yyyy.MM.dd HH:mm"/></span>
						<c:if test="${board.user_ip ne null and board.user_ip ne ''}">
							<c:set value="${fn:split(board.user_ip, '.')}" var="user_ip"></c:set>
							<c:choose>
								<c:when test="${authMBA}">
						<!-- <i>IP</i><span>${board.user_ip}</span> -->
								</c:when>
								<c:otherwise>
									<c:if test="${fn:length(user_ip) == 4}">
						<!-- <i>IP</i><span>*.*.*.${user_ip[3]}</span> -->
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${board.imsi_v_1 eq 'Y'}">
							<i>행사일</i><span>${board.imsi_v_2} ~ ${board.imsi_v_3}</span>
						</c:if>
					</div>
					<div class="panel-right">
						<a href="#bbs-comment">
						<i>댓글</i><span>0</span></a>
						<i>조회수</i><span><fmt:formatNumber value="${board.view_count}" pattern="#,###"/></span>
					</div>
				</dd>
			</dl>
		</div>

		<link rel="stylesheet" href="/resources/common/css/swiper.min.css">
		<style>
		.swiper-wrap {position:relative;margin-top:30px;height: 100%;border:1px solid #ddd;padding:30px;}
		.swiper-container {width: 100%;height: 300px;margin-left: auto;margin-right: auto;}
		.swiper-slide {background-size:cover;background-position:center;background-repeat:no-repeat;}
		.swiper-sthum {background-size:cover;background-position:center;background-repeat:no-repeat;}
		.swiper-pagination-current{font-weight:600;font-size: 20px;color:#ff9900;letter-spacing: 5px;}
		.swiper-pagination-total{margin-left:5px;}
		.gallery-top {height:600px;width:100%;}
		.gallery-thumbs {height: 20%;box-sizing: border-box;padding: 15px 1px 5px 1px;}
		.gallery-thumbs .swiper-slide {height: 100%;opacity: 0.2;}
		.gallery-thumbs .swiper-slide-thumb-active {opacity: 1; border: 2px solid #ff9900;}
		
		@media all and (max-width:1024px){
			.gallery-top {height:500px;width:100%;}
		}

		</style>

		<div class='swiper-wrap'>
			<!-- Swiper -->
			<div class="swiper-container gallery-top">
				<div class="swiper-wrapper">
					<c:forEach var="i" varStatus="status" items="${imgServerFileNameList}">
						<div class="swiper-slide" style="background-image:url('/data/board/${board.manage_idx}/${board.board_idx}/${i}')"></div>
					</c:forEach>
				</div>
				<!-- Add Arrows -->
				<div class="swiper-button-next swiper-button-white"></div>
				<div class="swiper-button-prev swiper-button-white"></div>
			</div>
			<div class="swiper-container gallery-thumbs" style='height:80px;'>
				<div class="swiper-wrapper">
					<c:forEach var="i" varStatus="status" items="${imgServerFileNameList}">
						<div class="swiper-slide swiper-sthum" style="background-image:url('/data/board/${board.manage_idx}/${board.board_idx}/${i}')"></div>
					</c:forEach>
				</div>
			
			</div>
			<!-- 페이징 -->
			
			<div class="swiper-pagination" style=''></div>
			
		</div>

		<!-- Swiper JS -->
		<script src="/resources/common/js/swiper.min.js"></script>

		<!-- Initialize Swiper -->
		<script>
		var galleryThumbs = new Swiper('.gallery-thumbs', {
			spaceBetween: 10,
			slidesPerView: 10,
			//loop: true,
			freeMode: true,
			loopedSlides: 5, //looped slides should be the same
			watchSlidesVisibility: true,
			watchSlidesProgress: true,
		});
		var galleryTop = new Swiper('.gallery-top', {
			spaceBetween: 10,
			loop: true,
			loopedSlides: 5, //looped slides should be the same
			navigation: {
				nextEl: '.swiper-button-next',
				prevEl: '.swiper-button-prev',
			},
			thumbs: {
				swiper: galleryThumbs,
			},
			pagination : { // 페이징 설정
				el : '.swiper-pagination',
				type: 'fraction',
				clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
			},
		});
		</script>



		<div class="bbs-view-body">
			<c:set value="${fn:replace(board.content, crlf, '<br/>')}" var="content"></c:set>
			${content}
<!-- 			<dl class="share"> -->
<!-- 				<dt>공유하기</dt> -->
<!-- 				<dd> -->
<!-- 					<a href="" class="facebook"><i class="fa fa-facebook"></i> <span>페이스북</span></a> -->
<!-- 					<a href="" class="twitter"><i class="fa fa-twitter"></i> <span>트위터</span></a> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
		</div>

		<div class="right mg5f">
			이미지 갯수 : ${fn:length(boardFile)}
		</div>
		<div class="bbs-view-header">
			<dl>
				<jsp:include page="/WEB-INF/views/app/board/common/view/file.jsp" flush="false" />
			</dl>
		</div>
		<div class="bbs-comment" id="bbs-comment">
			
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/view/beforeNext.jsp" flush="false" />
	<jsp:include page="/WEB-INF/views/app/board/common/view/button.jsp" flush="false" />
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>