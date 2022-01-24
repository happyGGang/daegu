<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function() {
	$('div.search.txt-center').remove();
	$('a#board_move_btn').hide();

	var $form = $('#board');

	$('button#libSearch').on('click', function() {
		var url = 'index.do';
		$('#viewPage').attr('value', '1');
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	if ('${param.category1}' == '0001') {
		$('a.mp4on').addClass('on');
		$('div.mapBg4').addClass('on');
	} else if ('${param.category1}' == '0002') {
		$('a.mp1on').addClass('on');
		$('div.mapBg1').addClass('on');
	} else if ('${param.category1}' == '0003') {
		$('a.mp6on').addClass('on');
		$('div.mapBg6').addClass('on');
	} else if ('${param.category1}' == '0004') {
		$('a.mp5on').addClass('on');
		$('div.mapBg5').addClass('on');
	} else if ('${param.category1}' == '0005') {
		$('a.mp2on').addClass('on');
		$('div.mapBg2').addClass('on');
	} else if ('${param.category1}' == '0006') {
		$('a.mp7on').addClass('on');
		$('div.mapBg7').addClass('on');
	} else if ('${param.category1}' == '0007') {
		$('a.mp3on').addClass('on');
		$('div.mapBg3').addClass('on');
	} else if ('${param.category1}' == '0008') {
		$('a.mp8on').addClass('on');
		$('div.mapBg8').addClass('on');
	}

	$('a.libType').on('click', function(e) {
		e.preventDefault();
		$('#viewPage').attr('value', '1');
		$('select#category2').val($(this).data('key')).attr('selected', 'true');
		$('select#category2').change();
	});
});
</script>

<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>

<link rel="stylesheet" type="text/css" href="/resources/common/css/libinfo.css" />
<script type="text/javascript" src="/resources/common/js/libinfo.js"></script>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<div class="library-map-selector innerMap">
	<div class="">
		<!-- map -->
		<div class="innerLeft">
			<div class="map web-view">
				<span class="mp1"><a href="#mp1on" class="mp1on">동구</a></span>
				<div class="mapBg1"></div>
				<span class="mp2"><a href="#mp2on" class="mp2on">북구</a></span>
				<div class="mapBg2"></div>
				<span class="mp3"><a href="#mp3on" class="mp3on">수성구</a></span>
				<div class="mapBg3"></div>
				<span class="mp4"><a href="#mp4on" class="mp4on">중구</a></span>
				<div class="mapBg4"></div>
				<span class="mp5"><a href="#mp5on" class="mp5on">남구</a></span>
				<div class="mapBg5"></div>
				<span class="mp6"><a href="#mp6on" class="mp6on">서구</a></span>
				<div class="mapBg6"></div>
				<span class="mp7"><a href="#mp7on" class="mp7on">달서구</a></span>
				<div class="mapBg7"></div>
				<span class="mp8"><a href="#mp8on" class="mp8on">달성군</a></span>
				<div class="mapBg8"></div>
			</div>

			<div class="map mobile-view">
				<span class="mp1"><a href="#mp1on" class="mp1on">동구</a></span>
				<span class="mp2"><a href="#mp2on" class="mp2on">북구</a></span>
				<span class="mp3"><a href="#mp3on" class="mp3on">수성구</a></span>
				<span class="mp4"><a href="#mp4on" class="mp4on">중구</a></span>
				<span class="mp5"><a href="#mp5on" class="mp5on">남구</a></span>
				<span class="mp6"><a href="#mp6on" class="mp6on">서구</a></span>
				<span class="mp7"><a href="#mp7on" class="mp7on">달서구</a></span>
				<span class="mp8"><a href="#mp8on" class="mp8on">달성군</a></span>
			</div>
		</div>

		<!-- selector -->
		<div id="libraryList" class="innerRight">
			<div class='title'>지역별 도서관 찾기</div>
			<div class="selector">
				<div class="selection01">
					<div class="all-lib" style="display:block">
					<ul>
						<li class="lib01"><div><a href="#" class="libType" data-key="23"><span>공공도서관</span><b>${empty categoryCount['23'] ? '0' : categoryCount['23']}</b></a></div></li>
						<li class="lib02"><div><a href="#" class="libType" data-key="24"><span>전문도서관</span><b>${empty categoryCount['24'] ? '0' : categoryCount['24']}</b></a></div></li>
						<li class="lib03"><div><a href="#" class="libType" data-key="25"><span>대학도서관</span><b>${empty categoryCount['25'] ? '0' : categoryCount['25']}</b></a></div></li>
						<li class="lib04"><div><a href="#" class="libType" data-key="26"><span>작은도서관</span><b>${empty categoryCount['26'] ? '0' : categoryCount['26']}</b></a></div></li>
						<li class="lib05"><div><a href="#" class="libType" data-key="29"><span>학교도서관</span><b>${empty categoryCount['29'] ? '0' : categoryCount['29']}</b></a></div></li>
						<li class="lib06"><div><a href="#" class="libType" data-key="28"><span>기타</span><b>${empty categoryCount['28'] ? '0' : categoryCount['28']}</b></a></div></li>
					</ul>
					<c:set var="libtotal" value="0"></c:set>
					<c:forEach items="${categoryCount}" var="i">
					<c:set var="libtotal" value="${libtotal + i.value}"></c:set>
					</c:forEach>
					<p>총 <b><fmt:formatNumber value="${libtotal}" pattern="#,###"/></b>개의 도서관이 검색되었습니다.</p>
					</div>
				</div>

				<div class="selection02">
					<dl>
						<dt>지역별 <Br class="web-br"/>검색<Br/><img src="/resources/common/img/map-arr.png" alt="아이콘"></dt>
						<dd>
							<form:select path="category1" cssClass="selectmenu sel01" >
								<form:option value="">전체지역</form:option>
								<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
							</form:select>
							<form:select path="category2" cssClass="selectmenu sel02" >
								<form:option value="">유형선택</form:option>
								<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
							</form:select>
							<div>
							<input type="hidden" name="search_type" value="title"/>
							<input type="text" name="search_text" placeholder="도서관명을 입력하세요" class="sel03" />
							<button id="libSearch">검색</button>
							</div>
						</dd>
					</dl>
					<div class="end"></div>
				</div>
			</div>
		</div>
	</div>

</div>
<div class="end"></div>
<div>

	<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
	<div class="wrapper-bbs">
		<div class="table-wrap">
			<table class="bbs center" summary="일반 게시판">
				<caption>일반게시판</caption>
				<colgroup>
					<c:if test="${board.delete_yn eq 'Y'}">
					<col width="5%">
					</c:if>
					<col width="5%">
					<col width="10%">
					<col width="12%">
					<col>
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<c:if test="${board.delete_yn eq 'Y'}">
						<th><input type="checkbox" id="checkAll"> </th>
						</c:if>
						<th>번호</th>
						<th>유형</th>
						<th class="">도서관명</th>
						<th>주소</th>
						<th class="">전화번호</th>
						<th class="mmm1">사이트</th>
						<th class="mmm1">지도</th>
					</tr>
				</thead>
				<tbody id="board_tbody">
				<c:forEach var="i" varStatus="status" items="${boardList}">
					<tr>
						<c:if test="${board.delete_yn eq 'Y'}">
						<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
						</c:if>
						<td class="num">${paging.listRowNum - status.index}</td>
						<td class="important left title">${i.category2_name}</td>
						<td class="important left title">
							<a href="view.do?menu_idx=${board.menu_idx}&manage_idx=${i.manage_idx}&board_idx=${i.board_idx}&viewPage=${board.viewPage}">${i.title}</a>
						</td>
						<td class="mmm2 username">${i.imsi_v_2}</td>
						<td class="important num adddate">${i.user_phone}</td>
						<td class="num mmm1">
						<c:if test="${not empty i.imsi_v_1}">
						<a href="${i.imsi_v_1}" target="_blank">[사이트]</a>
						</c:if>
						<c:if test="${empty i.imsi_v_1}">
						-
						</c:if>
						</td>
						<td class="file mmm1"><a href="https://map.kakao.com/link/search/${i.imsi_v_2}" target="_blank">지도</a></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:if test="${fn:length(boardList) < 1}">
			<table class="bbs center">
				<tr>
					<td class="dataEmpty">등록된 게시물이 없습니다.</td>
				</tr>
			</table>
			</c:if>
		</div>

		<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />

		<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
			<jsp:param name="formId" value="#board"/>
		</jsp:include>
	</div>
	</form:form>
</div>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>