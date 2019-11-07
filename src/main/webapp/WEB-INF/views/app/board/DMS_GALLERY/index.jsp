<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>
<script type="text/javascript">
$(document).ready(function() {
	var $form = $('#board');
	
	<%-- 등록 --%>
	$('a#board_otherBoardEdit_btn').on('click', function(e) {
		e.preventDefault();
		
		var url = 'otherBoardEdit.do';
		var formData = serializeCustom($form);
		doGetLoad(url, formData);
	});
});

	$(function() {
		$(window).resize(function() {
			$('.bbs_gallery img').height($('.bbs_gallery img').width() * 0.6);
		}).trigger('resize');
		
		$('img.previewImg').error(function() {
			var src=  $(this).attr('src');
			$(this).attr('src', src.replace('/thumb', ''));	
			$(this).unbind("error").attr("src", src.replace('/thumb', ''));
		});
		
		var $form = $('#board');
		$('.category1_list a').on('click', function() {
			var url = 'index.do';
			$('#viewPage').attr('value', '1');
			$('#category1').attr('value', $(this).attr('codeid'));
			var formData = serializeCustom($form);
			doGetLoad(url, formData);
		});
		
		$('.category2_list a').on('click', function() {
			var url = 'index.do';
			$('#viewPage').attr('value', '1');
			$('#category2').attr('value', $(this).attr('codeid'));
			var formData = serializeCustom($form);
			doGetLoad(url, formData);
		});
		
		$('.category3_list a').on('click', function() {
			var url = 'index.do';
			$('#viewPage').attr('value', '1');
			$('#category3').attr('value', $(this).attr('codeid'));
			var formData = serializeCustom($form);
			doGetLoad(url, formData);
		});
		
	});
</script>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.top_html) > 0}">
${boardManage.top_html}
</c:if>
<jsp:include page="/WEB-INF/views/app/board/common/index/script.jsp" flush="false" />
<form:form modelAttribute="board" action="index.do" method="get" onsubmit="return false;">
<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
<div class="wrapper-bbs">
	<div class="infodesk">
		<c:if test="${fn:length(category1List) > 0}">
	<!-- 	게시판 분류1 :  -->
		<label for="category1"></label>
		<form:select path="category1" cssStyle="width:160px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category1List}"/>
		</form:select>
		</c:if>
		<c:if test="${fn:length(category2List) > 0}">
	<!-- 	게시판 분류2 : -->
		<label for="category2"></label> 
		<form:select path="category2" cssStyle="width:160px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category2List}"/>
		</form:select>
		</c:if>
		<c:if test="${fn:length(category2List) > 0}">
	<!-- 	게시판 분류3 : -->
		<label for="category3"></label> 
		<form:select path="category3" cssStyle="width:160px;" cssClass="selectmenu" >
			<form:option value="">== 전체 ==</form:option>
			<form:options itemLabel="code_name" itemValue="code_id" items="${category3List}"/>
		</form:select>
		</c:if>
		<span class="bbs-result">총 게시물 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/> </b>건</span>
		<div class="button btn-group inline">
			<label for="rowCount" />
			<form:select path="rowCount" cssClass="selectmenu" cssStyle="width:110px;">
			<c:if test="${boardManage.board_type eq 'GALLERY' or boardManage.board_type eq 'BOOK'}">
			<c:forEach var="i" begin="8" end="16" step="4">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</c:if>
			<c:if test="${boardManage.board_type ne 'GALLERY'}">
			<c:forEach var="i" begin="10" end="50" step="10">
				<form:option value="${i}">${i}개씩 보기</form:option>
			</c:forEach>
			</c:if>
			</form:select>
		</div>
	</div>
	<div class="table-wrap">
		<ul class="bbs_gallery" id="board_tbody">
			<c:forEach var="i" varStatus="status" items="${boardList}">
			<li>
				<c:if test="${board.delete_yn eq 'Y'}">
				<td><form:checkbox path="boardIdxArray" value="${i.board_idx}"/></td>
				</c:if>
				<div class="thumb">
					<c:choose>
					<c:when test="${i.preview_img ne null}">
						<c:choose>
							<c:when test="${fn:contains(i.preview_img, 'http')}">
						<a href="" keyValue="${i.board_idx}">
							<img src="${i.preview_img}" alt="${i.title}"/>
						</a>
							</c:when>
							<c:otherwise>
						<a href="" keyValue="${i.board_idx}">
							<img class="previewImg" src="/data/board/${i.manage_idx}/${i.board_idx}/thumb/${i.preview_img}" alt="${i.title}"/>
						</a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="" keyValue="${i.board_idx}"><img src="/resources/common/img/noimg-gall.png" alt="${i.title}"></a>
					</c:otherwise>
					</c:choose>
				</div>
				<div class="info">
					<a href="" keyValue="${i.board_idx}">${i.title}</a>
					<div class="meta">
						<c:choose>
						<c:when test="${boardManage.anonymize_yn eq 'Y'}">
						<c:set var="user_name" value="${fn:substring(i.user_name, -1, 1)}**"/>
						</c:when>
						<c:otherwise>
						<c:set var="user_name" value="${i.user_name}"/>
						</c:otherwise>
						</c:choose>
						${i.secret_yn ne 'Y'? user_name:'비공개'}
						<span class="txt-bar"></span>
						<abbr class="published"><fmt:formatDate value="${i.add_date}" pattern="yyyy.MM.dd"/></abbr>
						<span class="txt-bar"></span>
						<abbr class="published"><fmt:formatNumber value="${i.view_count}" pattern="#,###"/> </abbr>
						
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>

	<jsp:include page="/WEB-INF/views/app/board/common/index/button.jsp" flush="false" />
	<div style="margin-top:5px">
<!-- 		<a href="" class="btn btn1 write" id="board_otherBoardEdit_btn"><i class="fa fa-pencil"></i><span>PMS등록하기</span></a> -->
	</div>
	<jsp:include page="/WEB-INF/views/app/board/common/index/paging.jsp" flush="false">
		<jsp:param name="formId" value="#board"/>
	</jsp:include>
</div>
</form:form>
<c:if test="${boardManage.add_html_use_yn eq 'Y' and fn:length(boardManage.bottom_html) > 0}">
${boardManage.bottom_html}
</c:if>