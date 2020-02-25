<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:choose>
<c:when test="${param.type == 'EBK'}">
<c:set var="type_name" value="전자책이"/>
</c:when>
<c:when test="${param.type == 'ADO'}">
<c:set var="type_name" value="오디오북이"/>
</c:when>
<c:when test="${param.type == 'WEB'}">
<c:set var="type_name" value="온라인강좌가"/>
</c:when>
<c:otherwise>
<c:set var="type_name" value="전자책이"/>
</c:otherwise>
</c:choose>
<script>
$(document).ready(function() {
	$('a#by_popularity').on('click', function(e) {
		e.preventDefault();
		$('#sortField').val('lend_total');
		$('#sortType').val('DESC');
		
		var url = 'index.do';
		var formData = serializeParameter(['menu_idx', 'menu', 'type', 'sortField', 'sortType', 'parent_id', 'com_code', 'device', 'library_code']);
		doGetLoad(url, formData);
	});
	$('a#by_title').on('click', function(e) {
		e.preventDefault();
		$('#sortField').val('book_name');
		$('#sortType').val('ASC');
		
		var url = 'index.do';
		var formData = serializeParameter(['menu_idx', 'menu', 'type', 'sortField', 'sortType', 'parent_id', 'com_code', 'device', 'library_code']);
		doGetLoad(url, formData);
	});
	$('a#by_date').on('click', function(e) {
		e.preventDefault();
		$('#sortField').val('book_pubdt');
		$('#sortType').val('DESC');
		
		var url = 'index.do';
		var formData = serializeParameter(['menu_idx', 'menu', 'type', 'sortField', 'sortType', 'parent_id', 'com_code', 'device', 'library_code']);
		doGetLoad(url, formData);
	});
	
	$('a.category_link').on('click', function(e) {
		e.preventDefault();
		$('#menu').val($(this).data('menu'));
		var field1_name = $(this).data('field1_name');
		$('#' + field1_name).val($(this).data('field1_value'));
		var field2_name = $(this).data('field2_name');
		$('#' + field2_name).val($(this).data('field2_value'));
		var url = 'index.do';
		var formData = serializeParameter(['menu_idx', 'menu', 'type', field1_name, field2_name]);
		doGetLoad(url, formData);
	});
	
	$('a.book_link').on('click', function(e) {
		e.preventDefault();
		$('#book_idx').val($(this).data('book_idx'));
		$('form#bookListForm').prop('action', 'view.do');
		$('form#bookListForm').submit();
		$('form#bookListForm').prop('action', 'index.do');
	});
	
	<c:if test="${book.type != 'WEB'}">
	/*웹접근성 커스텀 셀렉트 박스*/
	function wrapNum(str, val) {
	  if (!val || str.toLowerCase().indexOf(val.toLowerCase()) === -1) {
		return str;
	  }
	  var regex = new RegExp(val, 'i');
	  return str.replace(regex, '<span class="underline">$&</span>');
	}

	var box = {
	  'single': new Combobo({
		input: '#combobox-single',
		list: '.bands .listbox',
		activeClass: 'active',
		noResultsText: '검색 결과가 없습니다.',
		optionValue: 'underline'
//		,selectionValue: function(option) {
//			  var inputVal = box.single.input.value;
//	          return wrapNum(option.getAttribute("data-value"), inputVal);
//		}
	  }).on('selection', function(e) {
		var value = e.option.getAttribute("data-value");
		$('input#library_code').val(value);
		changeLibrary();
	  })
	};
	/*********************************/
	function groupChangeHandler(newGroup) {
	  var groupLabel = newGroup.querySelector('.optgroup-label').innerText;
	  var len = Array.prototype.slice.call(
		newGroup.querySelectorAll('.option')
	  ).filter(function (opt) {
		return opt.style.display !== 'none';
	  }).length;

	  return groupLabel + ' group entered, with ' + len + ' options.';
	}

	window.box = box;

	// handle trigger clicks to toggle state of its combobox
	Array.prototype.slice.call(
	  document.querySelectorAll('.trigger')
	).forEach(function (trigger) {
	  var instName = trigger.getAttribute('data-trigger');
	  var inst = box[instName];
	  trigger.addEventListener('click', function (e) {
		e.stopPropagation();
		inst[inst.isOpen ? 'closeList' : 'openList']();
	  });
	});
	</c:if>
});

function changeLibrary() {
	var url = 'index.do';
	var formData = serializeParameter(['menu_idx', 'menu', 'type', 'sortField', 'sortType', 'parent_id', 'com_code', 'device', 'library_code']);
	doGetLoad(url, formData);
}
</script>
<c:choose>
<c:when test="${book.menu == 'CATEGORY'}">
<div class="elib_cate">
<%--	<h2>${book.parent_name}</h2> --%>
	<table class="bestbook_l_table">
		<tr>
			<c:forEach items="${categoryBestBookList}" var="i" varStatus="status">
			<td>
				<span class="num">${status.index+1}</span><span class="book"><a href="/elib/module/elib/book/view.do?menu_idx=15&menu=BEST&type=EBK&book_idx=${i.book_idx}"><img src="${i.book_image}" alt="${fn:escapeXml(i.book_name)}"/></a></span>
			</td>
			</c:forEach>
		</tr>
	</table>
	
	
	<div class="bestbook_l">
		<ul>
		</ul>
	</div>
	<h2>카테고리</h2>
	<c:if test="${isMobile and not empty subcategoryList and not empty categoryList}">
	<div class="box">
		<c:forEach items="${categoryList}" var="i" varStatus="status">
		<a href="#" class="category_link" data-menu_idx="17" data-menu="CATEGORY" data-field1_name="parent_id" data-field1_value="${i.cate_id}">${i.cate_name}<span style="color: #AAA; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span></a>
		</c:forEach>
	</div>
	<div style="margin-bottom: 10px;"></div>
	<h2><small>하위 카테고리</small></h2>
	</c:if>
	<div class="box">
		<c:choose>
		<c:when test="${not empty subcategoryList}">
		<c:forEach items="${subcategoryList}" var="i" varStatus="status">
		<a href="#" class="category_link" data-menu_idx="17" data-menu="CATEGORY" data-field1_name="parent_id" data-field1_value="${i.parent_id}" data-field2_name="cate_id" data-field2_value="${i.cate_id}">${i.cate_name}<span style="color: #AAA; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span></a>
		</c:forEach>
		</c:when>
		<c:when test="${not empty categoryList}">
		<c:forEach items="${categoryList}" var="i" varStatus="status">
		<a href="#" class="category_link" data-menu_idx="17" data-menu="CATEGORY" data-field1_name="parent_id" data-field1_value="${i.cate_id}">${i.cate_name}<span style="color: #AAA; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span></a>
		</c:forEach>
		</c:when>
		</c:choose>
	</div>
</div>
</c:when>
<c:when test="${book.menu == 'PROVIDER'}">
<div class="elib_cate">
	<br/>
<%--	<h2>${book.comp_name}</h2> --%>
	<h2>공급사</h2>
	<div class="box">
		<c:forEach items="${compList}" var="i" varStatus="status">
		<c:if test="${i.com_code ne 'ARTN'}">
		<a href="#" class="category_link" data-menu_idx="18" data-menu="PROVIDER" data-field1_name="com_code" data-field1_value="${i.com_code}">${i.comp_name}<span style="color: #AAA; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span></a>
		</c:if>
		</c:forEach>
	</div>
</div>
</c:when>
<c:when test="${book.menu == 'DEVICE'}">
<div class="elib_cate">
	<br/>
<%--	<h2>${book.comp_name}</h2> --%>
	<h2>지원 기기</h2>
	<div class="box">
		<c:forEach items="${deviceList}" var="i" varStatus="status">
		<a href="#" class="category_link" data-menu_idx="49" data-menu="DEVICE" data-field1_name="device" data-field1_value="${i.device}">${i.label}<span style="color: #AAA; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.cnt}" pattern="#,###" />)</span></a>
		</c:forEach>
	</div>
</div>
</c:when>
<c:when test="${book.menu == 'LIBRARY'}">
<div class="elib_cate">
	<br/>
<%--	<h2>${book.comp_name}</h2> --%>
	<h2>도서관</h2>
	<div class="box">
		<c:forEach items="${libraryList}" var="i" varStatus="status">
		<c:if test="${i.CNT != '0'}">
		<a href="#" class="category_link" data-menu_idx="49" data-menu="LIBRARY" data-field1_name="library_code" data-field1_value="${i.HOMEPAGE_CODE}">${i.HOMEPAGE_NAME}<span style="color: #AAA; font-weight: normal; font-size: 12px;">(<fmt:formatNumber value="${i.CNT}" pattern="#,###" />)</span></a>
		</c:if>
		</c:forEach>
	</div>
</div>
</c:when>
</c:choose>



<form:form id="bookListForm" modelAttribute="book" action="index.do" method="GET" autocomplete="off">
<form:hidden path="menu_idx"/>
<form:hidden path="menu"/>
<form:hidden path="type"/>
<form:hidden path="sortField"/>
<form:hidden path="sortType"/>
<form:hidden path="parent_id"/>
<form:hidden path="cate_id"/>
<form:hidden path="com_code"/>
<form:hidden path="book_idx"/>
<form:hidden path="device"/>
<form:hidden path="library_code"/>
<div class="elib_top">
	<!-- 전자책 총 권수, 검색 조건 시작-->
	<div class="sub001">
		<div class="lsort">
			<c:choose>
			<c:when test="${book.menu == 'CATEGORY'}">
			<span>${category.cate_name}</span> 분류에
			</c:when>
			<c:when test="${book.menu == 'PROVIDER'}">
			<span>${book.comp_name}</span> 분류에
			</c:when>
			</c:choose>
			<span><fmt:formatNumber value="${bookListCnt}" pattern="#,###" /></span> 종의 ${type_name} 있습니다.    &nbsp; <span>${book.viewPage}</span>  of <fmt:formatNumber value="${book.totalPageCount}" pattern="#,###" /> page
		</div>
		<c:if test="${book.menu == 'CATEGORY' || book.menu == 'PROVIDER' || book.menu == 'DEVICE'}">
		<div class="sort">
			<a href="#" id="by_popularity" class="btn<c:if test="${book.sortField == 'lend_total'}"> active</c:if>">인기순</a>
			<a href="#" id="by_title" class="btn<c:if test="${book.sortField == 'book_name'}"> active</c:if>">제목순</a>
			<a href="#" id="by_date" class="btn<c:if test="${book.sortField == 'book_pubdt'}"> active</c:if>">최신순</a>
		</div>
		</c:if>
		<c:if test="${book.type != 'WEB'}">
		<div class="sort" style="display:none;">
			<section class="bands">
				<div class="wrp">
					<div class="combo-wrap">
						<c:choose>
						<c:when test="${book.library_code == '9999999'}">
						<c:set var="library_code_select_value" value="경상북도교육청 통합전자도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147002'}">
						<c:set var="library_code_select_value" value="경상북도교육청 고령도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147003'}">
						<c:set var="library_code_select_value" value="경상북도교육청 구미도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147008'}">
						<c:set var="library_code_select_value" value="경상북도교육청 상주도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147009'}">
						<c:set var="library_code_select_value" value="경상북도교육청 성주도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147010'}">
						<c:set var="library_code_select_value" value="경상북도교육청 안동도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147012'}">
						<c:set var="library_code_select_value" value="경상북도교육청 영양도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147013'}">
						<c:set var="library_code_select_value" value="경상북도교육청 영일도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147014'}">
						<c:set var="library_code_select_value" value="경상북도교육청 금호도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147017'}">
						<c:set var="library_code_select_value" value="경상북도교육청 울릉도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147018'}">
						<c:set var="library_code_select_value" value="경상북도교육청 울진도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147020'}">
						<c:set var="library_code_select_value" value="경상북도교육청 점촌도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147022'}">
						<c:set var="library_code_select_value" value="경상북도교육청 청송도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147031'}">
						<c:set var="library_code_select_value" value="경상북도교육청 영덕도서관"/>
						</c:when>
						<c:when test="${book.library_code == '00147032'}">
						<c:set var="library_code_select_value" value="경상북도교육청 영주선비도서관"/>
						</c:when>
						<c:otherwise>
						<c:set var="library_code_select_value" value=""/>
						</c:otherwise>
						</c:choose>
						<input type="text" name="library_code_select" class="combobox" id="combobox-single" placeholder="도서관 전체리스트" value="${library_code_select_value}">
						<i aria-hidden="true" class="fa trigger fa-caret-down" data-trigger="single"></i>
						<div class="listbox">
							<c:choose>
							<c:when test="${book.type == 'EBK'}">
							<div class="option" data-value="">전체</div>
							<div class="option" data-value="9999999">경상북도교육청 통합전자도서관</div>
							<div class="option" data-value="00147010">경상북도교육청 안동도서관</div>
							<div class="option" data-value="00147008">경상북도교육청 상주도서관</div>
							<div class="option" data-value="00147032">경상북도교육청 영주선비도서관</div>
							<div class="option" data-value="00147013">경상북도교육청 영일도서관</div>
							<div class="option" data-value="00147014">경상북도교육청 금호도서관</div>
							<div class="option" data-value="00147020">경상북도교육청 점촌도서관</div>
							<div class="option" data-value="00147012">경상북도교육청 영양도서관</div>
							<div class="option" data-value="00147031">경상북도교육청 영덕도서관</div>
							<div class="option" data-value="00147002">경상북도교육청 고령도서관</div>
							<div class="option" data-value="00147009">경상북도교육청 성주도서관</div>
							<div class="option" data-value="00147018">경상북도교육청 울진도서관</div>
							<div class="option" data-value="00147017">경상북도교육청 울릉도서관</div>
							</c:when>
							<c:when test="${book.type == 'ADO'}">
							<div class="option" data-value="">전체</div>
							<div class="option" data-value="9999999">경상북도교육청 통합전자도서관</div>
							<div class="option" data-value="00147003">경상북도교육청 구미도서관</div>
							<div class="option" data-value="00147010">경상북도교육청 안동도서관</div>
							<div class="option" data-value="00147008">경상북도교육청 상주도서관</div>
							<div class="option" data-value="00147032">경상북도교육청 영주선비도서관</div>
							<div class="option" data-value="00147013">경상북도교육청 영일도서관</div>
							<div class="option" data-value="00147022">경상북도교육청 청송도서관</div>
							<div class="option" data-value="00147031">경상북도교육청 영덕도서관</div>
							<div class="option" data-value="00147018">경상북도교육청 울진도서관</div>
							</c:when>
							<c:otherwise>
							</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</section>
		</div>
		</c:if>
		<div style="clear:both"></div>
	</div>
</div>
<ul class="bbs_webzine elib">
	<c:forEach items="${bookList}" var="i" varStatus="status">
	<li class="elib">
		<div class="thumb">
			<a href="#" class="book_link" data-book_idx="${i.book_idx}" style="background:url(/resources/board/img/lock-bg.gif) no-repeat center center">
				<c:if test="${not empty i.book_image}">
				<img src="${i.book_image}" alt="${i.book_name}"/>
				</c:if>
				<c:if test="${empty i.book_image}">
				<img src="/resources/common/img/noImg.gif" alt="noImage"/>
				</c:if>
			</a>
        </div>
        <div class="list-body">
        	<div class="flexbox">
            	<a href="#" class="book_link" data-book_idx="${i.book_idx}">
               		<b>${fn:escapeXml(i.book_name)}</b>
               	</a>
               	<div class="info">
               		<span>${fn:escapeXml(i.book_pubname)}</span>
               		<span class="txt-bar">&nbsp;</span>
               		<span>${fn:escapeXml(i.author_name)}</span>
               		<span class="txt-bar">&nbsp;</span>
               		<span>${fn:escapeXml(i.book_pubdt)}</span>
               	</div>
               	<c:set var="body" value="${i.book_info}"/>
				<%
					try {
						String body = (String)pageContext.getAttribute("body");
						if(body != null) {
							body = body.replaceAll("<[^>]*>", " ");
						}
						pageContext.setAttribute("body", body);
					} catch (Exception e) {
						
					}
				%>
               	<c:if test="${fn:length(body) > 200}">
               	<c:set var="body" value="${fn:substring(body, 0, 200)}..."/>
               	</c:if>	
            	<span class="snipet">${fn:escapeXml(body)}</span>
			</div>
            <div class="meta">
            	<label>소속도서관:</label>
				<span>${fn:escapeXml(i.library_name)}</span>
				<span class="txt-bar">&nbsp;</span>
            	<label>공급사:</label>
				<span>${fn:escapeXml(i.comp_name)}</span>
				<c:if test="${i.type == 'EBK'}">
				<span class="txt-bar">&nbsp;</span>
				<span>대출 가능 여부: ${fn:escapeXml(i.status)}</span>
				<span class="txt-bar">&nbsp;</span>
				<span>대출 : ${fn:escapeXml(i.book_lend)}<%-- / ${fn:escapeXml(i.max_lend)}--%></span>
				<span class="txt-bar">&nbsp;</span>
				<span>예약 : ${fn:escapeXml(i.book_reserve)}</span>
				<c:if test="${i.book_reserve > 0}">
				</c:if>
				</c:if>
			</div>
		</div>
	</li>
	</c:forEach>
</ul>
<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
	<jsp:param name="formId" value="#bookListForm"/>
	<jsp:param name="pagingUrl" value="index.do"/>
</jsp:include>
</form:form>
