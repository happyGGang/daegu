<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=1024" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>서점 관리자페이지</title>
<link media="screen" rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/store/css/all.css"  />
<link media="screen" rel="stylesheet" type="text/css" href="/resources/homepage/bookdream/css/jquery-ui.css"  />
<script type="text/javascript" src="/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery-ui-1.12.0-datepicker.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.bxslider.js"></script>
<script type="text/javascript" src="/resources/common/js/jquery.mmenu.min.js"></script>
<script type="text/javascript" src="/resources/common/js/default.js"></script>
<script type="text/javascript" src="/resources/common/js/common.js"></script>
</head>
<body>
<script>
$(function() {
	var $form = $('form#bookDream');
	var $formEdit = $('form#bookDreamEdit');
	
	$('td#manage a').on('click', function(e) {
		e.preventDefault();
		var state = $(this).attr('state');
		var r_no = $(this).attr('keyValue');
		$('input#editMode').val('MODIFY');
		$('input#r_no').val(r_no);
		$('input#r_state').val(state);
		$('input#rh_set').val(state);
		
		if (state == '20') {
			$('input#r_pay_type').val($('select#pay_type option:selected').val());
			$('input#r_pay').val($('input#pay').val());
		}
		
		doAjaxPost($formEdit);
	});
	
	$('button.btn-inverse').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('storeHistoryList.do', serializeCustom($('#bookDream')));
	});
	
	$('input#start_date').datepicker({
		maxDate: $('input#end_date').val(), 
		onClose: function(selectedDate){
			$('input#end_date').datepicker('option', 'minDate', selectedDate);
		}
	});
	
	$('input#end_date').datepicker({
		minDate: $('input#start_date').val(), 
		onClose: function(selectedDate){
			$('input#start_date').datepicker('option', 'maxDate', selectedDate);
		}
	});
});
</script>
<form:form modelAttribute="bookDreamEdit" method="post" action="modify2.do" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="r_no"/>
<form:hidden path="r_state"/>
<form:hidden path="rh_set"/>
<form:hidden path="r_pay_type"/>
<form:hidden path="r_price"/>
</form:form>
<div id="wrapper">
	<div id="head">
		<div id="logo_user_details">
			<h1 id="logo"><a href="./">${sessionScope.bookDreamStoreAdmin.s_name}</a><span>관리자 페이지 입니다.</span></h1>
			<div id="user_details">
				<ul id="user_details_menu">
					<li><strong>${sessionScope.bookDreamStoreAdmin.s_owner}님</strong>,접속하셨습니다.</li>
					<li>
						<ul id="user_access">
							<li class="first"><a href="/ad/module/bookDream/store.do">관리자 메인</a></li>
							<li class="last"><a href="/ad/module/bookDream/storeLogoutProc.do">로그 아웃</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>

		<div id="menus_wrapper">
			<div class="main_menu">
				<ul>
					<li><a href="store.do"><span><span>신청내역</span></span></a></li>
					<li><a href="storeHistoryList.do"><span><span>거래내역</span></span></a></li>
					<li><a href="storeRequestList.do"><span><span>신청도서</span></span></a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="content">
		<div id="page">
			<div class="inner">
				<!-- SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS -->
				<h2>새 책 드림 서비스 신청내역</h2>
				<div id="request_form_list" style="_height:400px;min-height:400px;">
					<c:forEach items="${bookDreamList}" var="i" varStatus="status">
					<div class="request_box">
						<p class="image"><img src="${i.r_image}" /></p>
						<div class="pdl120">
							<h4>
								<c:choose>
									<c:when test="${i.r_src eq 'pungsan'}">[풍산]</c:when>
									<c:when test="${i.r_src eq 'yongsang'}">[용상]</c:when>
									<c:otherwise>[안동]</c:otherwise>
								</c:choose>
								${i.r_title}
							</h4>
							<ul class="con01">
								<li>
									저자 : ${i.r_author }/ 
									가격 : <fmt:formatNumber value="${i.r_price}" pattern="#,###"/> 원 /
									출판사 : ${i.r_publisher } /
									<fmt:parseDate var="pubDate" value="${i.r_pubdate}" pattern="yyyyMMdd"/>
									출판일 : <fmt:formatDate value="${pubDate}" pattern="yyyy-MM-dd"/>				
								</li>
							</ul>
							<ul class="con02">
								<c:forEach items="${i.innerList}" var="j" varStatus="statusJ">
								<li>
									${statusJ.count}. 
									<span class="state${j.r_state >= 40 ? ' top' : (j.r_state >= 10 ? ' top' : '')}">
									${j.r_state >= 40 ? '완료' : (j.r_state >= 10 ? '이용중' : '취소')}
									</span> 
									<span class="name">${fn:substring(j.r_name,0,1)}*${fn:substring(j.r_name,2,10)}</span> 
									<c:set var="hp" value="${fn:replace(j.r_hp, '-', '')}"></c:set>
									<span class="phone">${fn:substring(hp,0,3)}-****-${fn:substring(hp,7,13)}</span> 
									<span class="date">신청일 : <fmt:formatDate value="${j.r_created}" pattern="yyyy-MM-dd"/> </span>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					</c:forEach>
				</div>
					<div class="pagenation">
						<ul>
						<c:if test="${paging.firstPageNum > 0}">
							<li class='curr'><a href="" class="curr paginate_button previous" keyValue="${paging.firstPageNum}">처음</a></li>
						</c:if>
						<c:if test="${paging.prevPageNum > 0}">
							<li class='curr'><a href="" class="curr paginate_button previous" keyValue="${paging.prevPageNum}">이전</a></li>
						</c:if>	
						<c:forEach var="i" varStatus="status" begin="${paging.startPageNum}" end="${paging.endPageNum}">
						<c:choose>
						<c:when test="${i eq paging.viewPage}">	
							<li class='curr this'><a href="" class="curr this paginate_button current" keyValue="${i}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class='curr'><a href="" class="curr paginate_button" keyValue="${i}">${i}</a></li>
						</c:otherwise>
						</c:choose>
						</c:forEach>
						<c:if test="${paging.nextPageNum > 0}">
							<li class='curr'><a href="" class="curr paginate_button next" keyValue="${paging.nextPageNum}">다음</a></li>
						</c:if>
						<c:if test="${paging.totalPageCount ne paging.lastPageNum}">
							<li class='curr'><a href="" class="curr paginate_button next" keyValue="${paging.totalPageCount}">맨끝</a></li>
						</c:if>
						</ul>
					</div>
				<form:form modelAttribute="bookDream" action="requestList.do" onsubmit="return false;">
				<form:hidden path="viewPage"/>
				</form:form>	
				<script>
				$(function() {	
					$('div.pagenation a').on('click', function(e) {
						e.preventDefault();
						$('input#viewPage').val($(this).attr('keyValue'));
						doGetLoad('requestList.do', $('form#bookDream').serialize());
					});	
				});
				</script>
				<!-- EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE -->
			</div>
		</div>
	</div>
</div>
<div id="footer">
	<div id="footer_inner">
		<dl class="copy">
			<dt><strong>새 책 드림 서비스 - 서점관리자</strong> </dt>
			<dd>Copyright &copy; 2015 ANDONG LIBRARY. All rights reserved.</dd>
		</dl>
	</div>
</div>

</body>
</html>