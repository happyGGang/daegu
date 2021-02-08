<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<style>
	a.bx-prev {
	    font-size: 20px;
	    position: relative;
	    width: 30px;
	    height: 40px;
	    display: block;
	    left: 400px;
	    top: -220px;
    }
    
    a.bx-next {
	    font-size: 20px;
	    position: relative;
	    width: 30px;
	    height: 40px;
	    display: block;
	    right: -550px;
	    top: -260px;
    }
    
    .largeBox {margin-top:10%; margin-bottom: 5%; text-align: center;}
    .largeBox img {width:900px; height:600px; text-align:center;}
</style>
<script>
$(function () {
	$('li.smallOne img.smallImg0').css('border', '1px solid black');
	
	$('.bx-slider-zone-example').bxSlider({
		mode: 'horizontal',
		auto:false,
		pager: false,
		maxSlides: 10,
		moveSlides: 1,
		slideMargin: 10,
		slideWidth: 100,
		slideHeight: 60
	});
	
	$('li.smallOne').on('click', function(e) {
		var preview_img = $(this).data('idx');
		$('.largeBox img').attr('src', '/data/board/${board.manage_idx}/${board.board_idx}/'+preview_img);
		
		var pagingNum = $(this).attr('keyValue');
		$('li.smallOne img').css('border', '0');
		$('li.smallOne img.smallImg' + pagingNum).css('border', '1px solid black');
		pagingNum = Number(pagingNum);
		pagingNum += 1;
		$('span#pagingNum').text(pagingNum);
		
		e.preventDefault();
	});
	
	$('a.bx-prev, a.bx-next').on('click', function() {
		$('li.smallOne').unbind();
		
		$('li.smallOne').on('click', function(e) {
			var preview_img = $(this).data('idx');
			$('.largeBox img').attr('src', '/data/board/${board.manage_idx}/${board.board_idx}/'+preview_img);
			
			var pagingNum = $(this).attr('keyValue');
			$('li.smallOne img').css('border', '0');
			$('li.smallOne img.smallImg' + pagingNum).css('border', '1px solid black');
			pagingNum = Number(pagingNum);
			pagingNum += 1;
			$('span#pagingNum').text(pagingNum);
			
			e.preventDefault();
		});
	});
});
</script>
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
		
		<div class="bx-slider-zone-box">
			<div class="largeBox">
				<img src="/data/board/${board.manage_idx}/${board.board_idx}/${imgServerFileNameList[0]}" data-idx="${imgServerFileNameList[0]}">
			</div>
			<div id="pagingBox" style="text-align:center;font-size:20px;margin-bottom:45px;">
				<span id="pagingNum">1</span> / <span>${fn:length(imgServerFileNameList)}</span>
			</div>
			<div class="smallBox">
				<ul class="bx-slider-zone-example">
					<c:forEach var="i" varStatus="status" items="${imgServerFileNameList}">
						<li class="smallOne" data-idx="${i}" keyValue="${status.index}"><img src="/data/board/${board.manage_idx}/${board.board_idx}/${i}" class="smallImg${status.index}" style="cursor:pointer"></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		
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