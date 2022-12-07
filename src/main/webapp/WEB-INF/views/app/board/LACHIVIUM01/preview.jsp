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
<div class="wrapper-bbs">
	<c:if test="${boardManager.board_add_html_yn eq 'Y'}">
	${boardManager.board_top_add_html}
	</c:if>
	<div class="exhibit_view">
		<div class="topbox clearfix">
			<div class="photobox type1"><!-- type1,2 선택 -->
				<div class="photo_list">

					<div class="photo_item">
						<div class="photo">
							<c:choose>
								<c:when test="${not empty board.preview_img}">
									<img src="/data/board/${board.manage_idx}/${board.board_idx}/thumb/${board.preview_img}" alt="${fn:escapeXml(board.title)} 이미지" />
								</c:when>
								<c:otherwise>
									<img src="/resources/common/img/noImg2.png" alt="${fn:escapeXml(board.title)} 이미지 없음" />
								</c:otherwise>
							</c:choose>
						</div>
					</div><!-- //.photo_item -->

				</div>
			</div><!-- //.photobox -->
			<div class="textbox">
				<div class="titlebox">
					<span class="title">
						<span class="title_text">${board.title}</span>

					</span>
				</div>
				<ul>
					<li class="clearfix">
						<em>장소</em>
						<span>${board.imsi_v_1}</span>
					</li>
					<li class="clearfix">
						<em>기간</em>
						<span>${board.imsi_v_2}</span>
					</li>
					<li class="clearfix">
						<em>작가</em>
						<span>${board.imsi_v_3}</span>
					</li>
					<li class="clearfix">
						<em>관람료</em>
						<span>${board.imsi_v_4}</span>
					</li>
					<li class="clearfix">
						<em>주최</em>
						<span>${board.imsi_v_5}</span>
					</li>
					<li class="clearfix">
						<em>문의전화</em>
						<span>${board.imsi_v_6}</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="contentbox">
			<div class="title">상세내용</div>
			<div class="textbox">
				${fn:replace(board.content, crlf, '<br/>')}
			</div>
		</div>
	</div>

</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>