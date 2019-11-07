<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	$('div.search-info').html("검색결과 '<b class=\"og\"><i>${librarySearch.search_text}</i></b>'에 대한 <b>${librarySearch.viewPage}</b>/${result.totalPage}페이지, 총 <b>${result.totalCnt}</b>건");
	
	$('#allBookListStr').val('${librarySearch.allBookListStr}');
	
	$('select#rowCount').on('change', function() {
		$('#do-search').click();
	});
	
	$('a.showSlide').on('click', function(e) {
		e.preventDefault();
		var bci = $(this).parents('div.bif').next('div.bci'); 
		var toggleState = $(bci).is(':hidden');
		if (toggleState) {
			$(bci).load('index_detail.do?vLoca='+$(this).attr('vLoca')+'&vCtrl='+$(this).attr('vCtrl'), function() {
				$(bci).slideToggle();	
			});
		} else {
			$(bci).slideToggle();
		}
	});
	
	$('a.goDetail').on('click', function(e) {
		e.preventDefault();
		$('input#vLoca').val($(this).attr('vLoca'));
		$('input#vCtrl').val($(this).attr('vCtrl'));
		$('input#vImg').val($(this).attr('vImg'));
		$('input#isbn').val($(this).attr('isbn'));
		$('input#tid').val($(this).attr('tid'));
		var formData = serializeParameter(['vLoca', 'vCtrl', 'vImg', 'isbn', 'tid', 'menu_idx']);
		doGetLoad('detail.do', formData);
	});
	
	$('div#search-results img').on('error', function() {
		var $this = $(this);
		$this.attr('src', '/resources/common/img/noImg.gif');
		$this.parent().addClass('noImg');
	});
	
	$('a.selectBook').on('click', function(e) {
		e.preventDefault();
		window.opener.getIlusData($(this).attr('keyValue'));
		window.close();
	});

    if ('${fn:escapeXml(param.search_type)}'=='') {
            $('select#search_type').val('L_TITLEAUTHOR');
    }
});

</script>

<form:form id="searchTableForm" modelAttribute="librarySearch" method="GET">
	<c:forEach items="${result.data}" var="i">
		<div class="row">
			<p class="admin"><input name="print_param" type="checkbox" class="checkBook" value="${i.libCode}_${i.rec_key}_${i.tid}_${i.img}"/></p>
			<div class="thumb">
					<c:choose>
						<c:when test="${i.img eq '' or fn:contains(i.img, 'noimg')}">
				<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail noImg">
					<img src="/resources/common/img/noImg.gif" alt="noImage"/>
				</a>
						</c:when>
						<c:otherwise>
				<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="goDetail">
					<img src="${i.img}" alt="${i.title}"/>
				</a>
						</c:otherwise>
					</c:choose>
			</div>
			<div class="box">
				<div class="item">
					<div class="bif">
						<c:set var="replaceStr" value="<span style='color:#ffa651'>${librarySearch.search_text}</span>"/>
						<a href="#" vLoca="${i.libCode}" vCtrl="${i.rec_key}" vImg="${i.img}" isbn="${i.isbn}" tid="${i.tid}" class="name goDetail">${fn:replace(i.title, librarySearch.search_text, replaceStr)}</a>
						<p>${fn:replace(i.author, librarySearch.search_text, replaceStr)}</p>
						<p>${fn:replace(i.publisher, librarySearch.search_text, replaceStr)}, ${i.year}</p>
						<p>${i.libName}</p>
						<p>${i.placeName}</p>
						<div class="stat">
<%-- 											<a href="#" class="showSlide" vLoca="${i.libCode}" vCtrl="${i.rec_key}"><span>이용가능여부</span><i class="fa fa-sort-down"></i></a> --%>
							<span>[${i.callno}]</span>
							<a href="#" class="selectBook" vLoca="${i.libCode}" vCtrl="${i.rec_key}"
								keyValue="${i.title}///${i.year}///${i.author}///${i.publisher}///${i.isbn}///${i.callno}///${i.img}///${i.rec_key}///${i.placeName}">
								<span>선택하기</span><i class="fa fa-sort-down"></i>
							</a>
						</div>
					</div>
					<div class="bci" style="display: none;">
						<!-- ajaxArea -->
					</div>
				</div>
			</div>
		</div>
	</c:forEach>

	<jsp:include page="/WEB-INF/views/app/cms/common/paging_search_tableforboard.jsp" flush="false" />
</form:form>
