<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function() {
	var $form = $('#board');
	$('.sc_tab li a').on('click', function() {
		var url = 'index.do';
		$('#viewPage').attr('value', '1');
		var category1 = $(this).attr('codeid');
		$('#category1').attr('value', $(this).attr('codeid'));
		if (category1 == '0030') {
// 			$('#menu_idx').val('6');//real
			$('#menu_idx').val('10');//local
// 			$('#menu_idx').val('1');
		} else if (category1 == '0010') {
// 			$('#menu_idx').val('4');//real
			$('#menu_idx').val('11');//local
		} else if (category1 == '0020') {
// 			$('#menu_idx').val('5');//real
			$('#menu_idx').val('12');//local
		} else if (category1 == '0040') {
// 			$('#menu_idx').val('7');//real
			$('#menu_idx').val('13');//local
		} else if (category1 == '0050') {
// 			$('#menu_idx').val('8');//real
			$('#menu_idx').val('14');//local
		} else if (category1 == '0000') {
// 			$('#menu_idx').val('6');//real
			$('#menu_idx').val('2');//local
		} else {
			$('#menu_idx').val('15');
		}
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});

	<c:set var="totalCnt" value="0"></c:set>
	<c:if test="${board.category1 ne '0000'}">
	<c:forEach var="i" items="${requestCount}" varStatus="status">
	<c:if test="${not empty i.REQUEST_STATE}">
	$('a.requestA[codeid="'+${i.REQUEST_STATE}+'"] b').html('<br/>(${i.CNT})');
	<c:set var="totalCnt" value="${totalCnt + i.CNT}"></c:set>
	</c:if>
	</c:forEach>
	</c:if>
	$('a.requestA[codeid=""]').append('<br/>(${totalCnt})');
	
	$('#header > div.Gnb > div.g-menu a:contains(menu_idx=${param.menu_idx})').each(function (i) {
		$(this).parent().addClass('active');
	});
});

$(document).ready(function() {
	var $form = $('#board');
	$('.f_r a').on('click', function() {
		var url = 'index.do';
		$('#viewPage').attr('value', '1');
		$('#request_state').attr('value', $(this).attr('codeid'));
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
	
	$('input#noticeStartDate').datepicker({
		maxDate: $('input#noticeEndDate').val(), 
		onClose: function(selectedDate){
			$('input#noticeEndDate').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#noticeEndDate').datepicker({
		minDate: $('input#noticeStartDate').val(), 
		onClose: function(selectedDate){
			$('input#noticeStartDate').datepicker('option', 'maxDate', selectedDate);
		}
	});
});
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<form:hidden path="category1"/>
<form:hidden path="request_state"/>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<c:if test="${!member.admin}">
<hidden id="category2" value="${sessionScope.member.homepage_id}"/>
</c:if>
		<div class="sc_tab" style="">
			<ul>
				<li class="first"><a href="#" codeid="" style="${empty board.category1 ? 'background-color:#4c4c4c;color:#fff':''}">전체</a></li>
				<c:forEach var="i" items="${category1List}" varStatus="status">
				<li class="${status.index eq 3?'fourth':''}"><a href="#" codeid="${i.code_id}" style="${i.code_id eq board.category1?'background-color:#4c4c4c;color:#fff':''}">${i.code_name}</a></li>
				</c:forEach>
			</ul>
		</div>

		<div class="sc_tabCon">
			<!-- search S -->
			<div class="search_m" style="text-align: right;">
					<fieldset>
						<form:select path="category2" cssStyle="width:220px" cssClass="selectmenu-search" >
							<form:option value="">도서관 전체보기</form:option>
							<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
						</form:select>
						<c:if test="${!member.admin}">
						<b style="color:#fff">${member.member_name}</b>
						</c:if>

						<!-- <select class="selectmenu" style="width:200px;background:#eee;border:0;border-radius:0;font-size:12px">
							<option selected="selected">도서관검색(도서관명or도메인)</option>
							<option>도서관명</option>
							<option>도메인</option>
						</select>
						<input type="text" class="text" placeholder="검색어를 입력하세요"/>
						<button><span>SEARCH</span></button> -->
					</fieldset>
			</div>
			<!-- search E -->
			<div class="wrapper-bbs">
				<form:select path="sortField" cssStyle="width:80px" cssClass="selectmenu" >
					<form:option value="add_date">요청일자</form:option>
					<c:if test="${board.category1 ne '0040'}">
					<form:option value="category2">처리현황순</form:option>
					</c:if>
				</form:select>
				<form:select path="sortType" cssStyle="width:80px" cssClass="selectmenu" >
					<form:option value="ASC">오름차순</form:option>
					<form:option value="DESC">내림차순</form:option>
				</form:select>
				<c:if test="${board.category1 ne '0040'}">
				<div class="f_r">
					<a href="#" style="width: 60px;" codeid="" class="btn btn03 requestA"><c:if test="${empty board.request_state}"><i class="fa fa-play" aria-hidden="true"></i></c:if>전체</a>
					<c:forEach var="i" items="${request_state_list}" varStatus="status">
					<a href="#" style="width: 60px;" codeid="${i.code_id}" class="btn btn0${i.code_id} requestA"><c:if test="${(i.code_id eq board.request_state)}"><i class="fa fa-play" aria-hidden="true"></i></c:if>${i.code_name}<b><br/>(0)</b></a>
					</c:forEach>
				</div>
				</c:if>
			</div>
			<span class="bbs-result">
				<em>TOTAL : <fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></em>
				<em>PAGE : <fmt:formatNumber value="${paging.viewPage}" pattern="#,###"/>/<fmt:formatNumber value="${paging.totalPageCount}" pattern="#,###"/></em>
			</span><br />
			<!-- 일반 목록형 여기부터 -->
			<table class="bbs center">
				<thead>
					<tr>
						<c:if test="${board.delete_yn eq 'Y'}">
						<th><input type="checkbox" id="checkAll"> </th>
						</c:if>
						<th class="mmm1" style="width:4%">번호</th>
						<c:if test="${board.category1 ne '0000'}">
						<th style="width:20%">사이트명</th>
						</c:if>
						<c:if test="${empty board.category1}">
						<th style="width:7%">구분</th>
						</c:if>

						<th>제목</th>
						<th class="mmm1" style="width:10%">작성자</th>
						<th style="width:10%">작성일</th>
						<th class="mmm1" style="width:5%">파일</th>
						<c:if test="${board.category1 ne '0000' and board.category1 ne '0040'}">
						<th style="width:10%">처리현황</th>
						</c:if>
						<c:if test="${board.category1 eq '0000'}">
						<th style="width:50px;">조회수</th>
						</c:if>
						<c:if test="${board.category1 eq '0040'}">
						<th style="width:50px;">다운로드수</th>
						</c:if>
					</tr>
				</thead>
				<tbody id="board_tbody">
					<c:forEach var="i" varStatus="status" items="${boardList}">
					<tr${i.group_depth > 0?' class="reply"':''}>
						<c:if test="${board.delete_yn eq 'Y'}">
						<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
						</c:if>
						<td class="mmm1 num red_" style="letter-spacing:-1px">${paging.listRowNum - status.index}</td>
						<c:if test="${board.category1 ne '0000'}">
						<td class="left" style="letter-spacing:-1.5px">${i.category2_name}</td>
						</c:if>
						<c:if test="${empty board.category1}">
						<td class="left" style="letter-spacing:-1.5px">${i.category1_name}</td>
						</c:if>
						<td class="important left">
							<a href="" keyValue="${i.board_idx}">
							<c:if test="${i.group_depth > 0}">
								<i class="fa fa-reply"></i>
							</c:if>
								<span>
									${i.title}
								</span>${i.secret_yn eq 'Y'?'<i class="fa fa-lock"></i>':''}
								<c:if test="${i.date_gap <= boardManage.new_date_count}"><em class="new">새글</em></c:if>
								<c:if test="${i.comment_count > 0}">
								<span class="comment"><em>댓글</em> <i>${i.comment_count}</i></span>
								</c:if>
							</a>
						</td>
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y'}">
						<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${i.user_name}"/>
						</c:otherwise>
						</c:choose>
						<td class="mmm1" style="letter-spacing:-1px">${i.secret_yn ne 'Y'? user_name:'비공개'}</td>
						<td class="num"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd" /></td>
						<td class="file mmm1">${i.file_count > 0?'<i class="fa fa-floppy-o"></i>':''}</td>
						<c:if test="${board.category1 ne '0000' and board.category1 ne '0040'}">
						<td class="file"><span class="btn btn0${i.request_state}">${i.request_state_str}</span></td>
						</c:if>
						<c:if test="${board.category1 eq '0000'}">
						<td style="width:50px;">${i.view_count}</td>
						</c:if>
						<c:if test="${board.category1 eq '0040'}">
						<th style="width:50px;">${i.file_download_count}</th>
						</c:if>
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
			<!-- 일반 목록형 여기까지 -->
				<div class="button bbs-btn right" style="clear: both;">
				<c:choose>
					<c:when test="${authMBA}">
						<c:choose>
							<c:when test="${board.delete_yn eq 'Y'}">
								<a href="" class="btn btn2" id="board_normal_btn" style="width:93px"></i><span>일반 게시물 보기</span></a>
								<a href="" class="btn btn1" id="board_recovery_btn" style="width:65px"></i><span>게시물 복구</span></a>
								<a href="" class="btn btn5" id="board_delete_btn" style="width:53px"></i><span>완전 삭제</span></a>
							</c:when>
							<c:otherwise>
								<a href="" class="btn btn4" id="board_deleteRecovery_btn" style="width:93px"><span>삭제 게시물 보기</span></a>
								<a href="" class="btn btn1 write" id="board_edit_btn" style="width:55px"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${board.category1 eq '0000'}">
							<c:if test="${member.admin}">
								<c:if test="${authC}">
									<a href="" class="btn btn1 write" id="board_edit_btn" style="width:55px"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
								</c:if>
							</c:if>
						</c:if>
						<c:if test="${board.category1 ne '0000'}">
							<c:if test="${authC}">
								<a href="" class="btn btn1 write" id="board_edit_btn" style="width:55px"><i class="fa fa-pencil"></i><span>글쓰기</span></a>
							</c:if>
						</c:if>
					</c:otherwise>
				</c:choose>

<%-- 				<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false"> --%>
<%-- 					<jsp:param name="formId" value="#board"/> --%>
<%-- 				</jsp:include> --%>

				<form:hidden path="viewPage"/>
				<div id="board_paging" class="dataTables_paginate">
				<c:if test="${paging.firstPageNum > 0}">
					<a href="" class="paginate_button previous" keyValue="${paging.firstPageNum}">처음</a>
				</c:if>
				<c:if test="${paging.prevPageNum > 0}">
					<a href="" class="paginate_button previous" keyValue="${paging.prevPageNum}">이전</a>
				</c:if>	
					<span>
				<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
				<c:choose>
				<c:when test="${i eq paging.viewPage}">
					<a href="" class="paginate_button current" keyValue="${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<a href="" class="paginate_button" keyValue="${i}">${i}</a>
				</c:otherwise>
				</c:choose>
				</c:forEach>
				<c:if test="${paging.nextPageNum > 0}">
					<a href="" class="paginate_button next" keyValue="${paging.nextPageNum}">다음</a>
				</c:if>
				<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
					<a href="" class="paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a>
				</c:if>
					</span>
				</div>
				
				<div class="search txt-center mmm2" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
					<fieldset>
						<label class="blind" for="search_type">검색조건</label>
						<c:if test="${board.homepage_id eq 'c0'}">
						기간 : <form:input path="searchStartDate" id="noticeStartDate" class="text ui-calendar" title="시작기간,입력예시 2017-01-01" /> ~ <form:input id="noticeEndDate" path="searchEndDate" class="text ui-calendar" title="종료기간, 입력예시 2017-12-31"/>
						</c:if>
						<form:select path="search_type" cssClass="selectmenu" cssStyle="width:100px;">
							<form:option value="title+content">제목+내용</form:option>
							<form:option value="title">제목</form:option>
							<form:option value="content">내용</form:option>
							<form:option value="user_name">글작성자</form:option>
						</form:select>
						<form:input path="search_text" id="search_text_board" cssClass="text" accesskey="s" title="검색어" alt="검색어"  placeholder="검색어를 입력하세요" cssStyle="ime-mode:active;" />
						<label for="search_text_board" class="blind">검색어</label>
						<a href="" class="btn btn1" id="board_btn_search"><i class="fa fa-search"></i><span>검색</span></a>
					</fieldset>
				</div>
				
				<script type="text/javascript">
				$(document).ready(function() {
					$('div#board_paging a').on('click', function(e) {
						$('#viewPage').attr('value', $(this).attr('keyValue'));
						var param = serializeCustom($('form#board'));
						doGetLoad('index.do', param);
						e.preventDefault();
					});
					
					$('a#board_btn_search').on('click', function(e) {
						e.preventDefault();
						$('#viewPage').attr('value', '1');
						var param = serializeCustom($('form#board'));
						doGetLoad('index.do', param);
					});
					
					$('input#search_text_board').keyup(function(e) {
						e.preventDefault();
						if(e.keyCode == 13) {
							$('#viewPage').attr('value', '1');
							var param = serializeCustom($('form#board'));
							doGetLoad('index.do', param);
						}
					});
				});
				</script>

			<%-- <div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
				<form>
					<fieldset>
						<label><i class="fa fa-search"></i><span>SEARCH</span></label>
						<select class="selectmenu" style="width:100px">
							<option selected="selected">사이트이름</option>
							<option>제목</option>
							<option>내용</option>
						</select>
						<input type="text" class="text"/>
						<button><span>검색</span></button>
					</fieldset>
				</form>
			</div>

			<div class="dataTables_paginate">
				<a class="paginate_button first disabled"><i class="fa fa-angle-double-left"></i><span class="blind">처음</span></a>
				<a class="paginate_button previous"><i class="fa fa-angle-left"></i><span class="blind">이전</span></a>
				<span>
					<a class="paginate_button current">1</a>
					<a class="paginate_button">2</a>
				</span>
				<a class="paginate_button next"><i class="fa fa-angle-right"></i><span class="blind">다음</span></a>
				<a class="paginate_button end"><i class="fa fa-angle-double-right"></i><span class="blind">마지막</span></a>
			</div> --%>
			<br />
			<br />

			<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
			${boardManage.bottom_html}
			</c:if>


		</div>
</form:form>
