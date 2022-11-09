<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<script type="text/javascript">
	$(function() {
		$(document).on('click', 'ul#festiv_tab li  a', function(e){
			e.preventDefault();
			$('#viewPage').attr('value', '1');
			var month = $(this).attr('keyValue');
			if (month ) {

			}
			$('#search_month').val(month);
			var url = 'index.do';
			var formData = serializeCustom($('#board'));
			doGetLoad(url, formData);
		});
	});

</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<input type="hidden" id ="homepage_id" value ="${homepage.homepage_id}"/>
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<form:hidden path="search_month"/>
<div class="wrapper-bbs">
	<jsp:include page="/WEB-INF/views/app/board/common/index/infodesk.jsp" flush="false" />
	<div class="table-wrap">

		<ul class="festiv_tab" id="festiv_tab">
			<li><a href="#" class="${empty board.search_month or board.search_month eq 'ALL' ?'on':''}" keyValue="ALL">전체</a></li>
			<li><a href="#" keyValue="JAN" class="${board.search_month eq 'JAN' ?'on':''}">1월</a></li>
			<li><a href="#" keyValue="FED" class="${board.search_month eq 'FED' ?'on':''}">2월</a></li>
			<li><a href="#" keyValue="MAR" class="${board.search_month eq 'MAR' ?'on':''}">3월</a></li>
			<li><a href="#" keyValue="APR" class="${board.search_month eq 'APR' ?'on':''}">4월</a></li>
			<li><a href="#" keyValue="MAY" class="${board.search_month eq 'MAY' ?'on':''}">5월</a></li>
			<li><a href="#" keyValue="JUN" class="${board.search_month eq 'JUN' ?'on':''}">6월</a></li>
			<li><a href="#" keyValue="JUL" class="${board.search_month eq 'JUL' ?'on':''}">7월</a></li>
			<li><a href="#" keyValue="AUG" class="${board.search_month eq 'AUG' ?'on':''}">8월</a></li>
			<li><a href="#" keyValue="SEP" class="${board.search_month eq 'SEP' ?'on':''}">9월</a></li>
			<li><a href="#" keyValue="OCT" class="${board.search_month eq 'OCT' ?'on':''}">10월</a></li>
			<li><a href="#" keyValue="NOV" class="${board.search_month eq 'NOV' ?'on':''}">11월</a></li>
			<li><a href="#" keyValue="DEC" class="${board.search_month eq 'DEC' ?'on':''}">12월</a></li>
		</ul>
		<div class="festiv_box">
			<c:forEach var="i" varStatus="status" items="${boardList}">
					<c:set var="boardIdx" value="${i.parent_idx > 0 ? i.parent_idx : i.board_idx}"></c:set>

					<div class="box">
						<div class="img">
							<c:choose>
								<c:when test="${i.preview_img ne null}">
									<c:choose>
										<c:when test="${fn:contains(i.preview_img, 'http')}">
											<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
												<img src="${i.preview_img}" alt="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
											</a>
										</c:when>
										<c:otherwise>
											<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}">
												<img class="previewImg" src="/data/board/${i.manage_idx}/${i.board_idx}/${i.preview_img}" alt="${i.title}" onError="this.src='/resources/common/img/noimg-gall.png'"/>
											</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}"></a>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="txt">
							<h4><a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${boardIdx}&viewPage=${board.viewPage}">${i.title}</a></h4>
							<ul>
								<li>
                                    <c:set var = "months" value = "${fn:replace(i.imsi_v_1, 'JAN', '1')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'FED', '2')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'MAR', '3')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'APR', '4')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'MAY', '5')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'JUN', '6')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'JUL', '7')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'AUG', '8')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'SEP', '9')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'OCT', '10')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'NOV', '11')}" />
                                    <c:set var = "months" value = "${fn:replace(months, 'DEC', '12')}" />
									<span>축제기간</span>${months}월 중
								</li>
								<li><span>주소</span>${i.imsi_v_2}</li>
								<li><span>전화번호</span>${i.imsi_v_3}</li>
								<li><span>홈페이지</span><a href="${i.imsi_v_4}" target="_blank">${i.imsi_v_4}</a></li>
							</ul>

							<c:set value="${fn:replace(i.content, crlf, '<br/>')}" var="content"></c:set>
							${i.content}

						</div>
					</div>
			</c:forEach>
		</div>

		<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
		<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>