<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">

	
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />

	<!-- 신규디자인 시작 -->
	<div class="exhibit_list">
		<div class="list-box">
			<ul>
				<c:forEach items="${boardList}" var="i" varStatus="status">

					<li class="list clearfix">
						<div class="photobox style02">
							<div class="inner">
							<c:choose>
								<c:when test="${not empty i.preview_img}">
									<img src="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}" alt="${fn:escapeXml(i.title)} 이미지" />
								</c:when>
								<c:otherwise>
									<img src="/resources/common/img/noImg2.png" alt="${fn:escapeXml(i.title)} 이미지" />
								</c:otherwise>
							</c:choose>
							</div>
						</div>
						<div class="textbox style02">
							<div class="titlebox">
								<span class="title">
									<span class="title_text">
										<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&viewPage=${board.viewPage}" >
											${i.title}
										</a>
									</span>
								</span>
							</div>
							<div class="summarybox">
								<span class="summrary">
									<span class="summrary_text">
										${i.imsi_v_1}
									</span>
								</span>
							</div>
							<ul>
								<li class="clearfix">
									<em>기　　간</em>
									<span>${i.imsi_v_2}(${i.imsi_v_11}) ~ ${i.imsi_v_3}(${i.imsi_v_12}) ${i.imsi_v_4} ${i.imsi_v_5}시</span>
								</li>
								<li class="clearfix">
									<em>장　　소</em>
									<span>${i.imsi_v_6}</span>
								</li>
							</ul>
							<div class="buttonbox">
								<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&viewPage=${board.viewPage}" class="btn link2 small">VIEW MORE <img src="http://211.224.118.223:8010/resources/common/img/more-arrow.jpg" alt=""></a>
							</div>
						</div>
					</li>
				</c:forEach>
				<c:if test="${fn:length(boardList) < 1}">
					<li class="list clearfix">
						<div class="photobox">
							<img src="/resources/common/img/noImg2.png" alt="등록된 전시회가 없습니다." />
						</div>
						<div class="textbox">
							<div class="titlebox">
								<span class="title">
									<span class="title_text">
										<a href="#">
											등록된 전시가 없습니다.
										</a>
									</span>
								</span>
							</div>
							<div class="buttonbox">

							</div>
						</div>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
	<!-- 신규디자인 끝 -->

	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />

	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>