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
			$('input#r_pay_type').val($('select.payType_'+r_no+' option:selected').val());
			$('input#r_pay').val($('input.payed_'+r_no).val());
		}
		
		doAjaxPost($formEdit);
	});
	
	$('button.btn-inverse').on('click', function(e) {
		$('#viewPage').val(1);
		doGetLoad('store.do', serializeCustom($('#bookDream')));
	});
	
	$('div.pagenation a').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val($(this).attr('keyValue'));
		doGetLoad('store.do', $('form#bookDream').serialize());
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
	
	$('input#checkAll').on('click', function() {
		$('input[name=search_state]').prop('checked', $(this).is(':checked'));
	});
});
</script>
<form:form modelAttribute="bookDreamEdit" method="post" action="modify2.do" onsubmit="return false;">
<form:hidden path="editMode"/>
<form:hidden path="r_no"/>
<form:hidden path="r_state"/>
<form:hidden path="rh_set"/>
<form:hidden path="r_pay_type"/>
<form:hidden path="r_pay"/>
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
				<h2>신청내역</h3>

				<form:form modelAttribute="bookDream" action="store.do" onsubmit="return false;">
				<form:hidden path="viewPage"/>
				<ul class="con02 lpad01">
					<li>
						대출번호 : <form:input path="user_no" cssClass="text" size="10"/> / 
						이름 : <form:input path="r_name" size="6" cssClass="text"/> 
					</li>
					<li>상태 :
						<input type="checkbox" id="checkAll" checked="checked"><label for="checkAll">전체</label>
						<form:checkbox path="search_state" value="10" label="신청"/>
						<form:checkbox path="search_state" value="13" label="재고있음"/>
						<form:checkbox path="search_state" value="15" label="주문중"/>
						<form:checkbox path="search_state" value="17" label="입고완료"/>
						<form:checkbox path="search_state" value="20" label="구매확정"/>
						<form:checkbox path="search_state" value="30" label="반납"/>
						<form:checkbox path="search_state" value="40" label="환불"/>
					기간 : 
						<form:select path="search_date">
							<form:option value="r_created">신청일자</form:option>
							<form:option value="r_payed">구매일자</form:option>
							<form:option value="r_return">반환일자</form:option>
							<form:option value="r_refund">환불일자</form:option>
							<form:option value="r_calc">정산일자</form:option>
						</form:select>
						<form:input path="start_date" class="text ui-calendar" readonly="true"/>
						<form:input path="end_date" class="text ui-calendar" readonly="true"/>
						<button class="btn btn-small btn-inverse" type="submit"><span>검색</span></button>
						(% 성과 이름 모두를 입력해야 검색됩니다. (예: "홍길동", "홍두께") )
					</li>
				</ul>
				</form:form>
				
				<table class="tstyle" summary="">
					<caption>새 책 드림 서비스 신청내역</caption>
					<colgroup>
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
						<col width="" />
					</colgroup>
					<thead>
						<tr>
							<th>No</th>
							<th>이미지</th>
							<th>상태</th>
							<th>도서명</th>
							<th>신청자</th>
							<th>신청일자</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${bookDreamList}" var="i" varStatus="status">
						<tr>
							<td>${paging.listRowNum - status.index}</td>
							<td><img src="${i.r_image}" width="70" /></td>
							<td>
								${i.r_state_nm}<br/>
								(${sessionScope.bookDreamStoreAdmin.s_name})<br/>
								[${i.r_src_nm}] -${i.r_no}-
							</td>
							<td style="text-align:left;">
								<b>${i.r_title}</b><br/>
								저자 : ${i.r_author }/ 
								가격 : <fmt:formatNumber value="${i.r_price}" pattern="#,###"/> 원 <br/>
								출판사 : ${i.r_publisher } /
								<fmt:parseDate var="pubDate" value="${i.r_pubdate}" pattern="yyyyMMdd"/>
								출판일 : <fmt:formatDate value="${pubDate}" pattern="yyyy-MM-dd"/> / 		
								ISBN : ${fn:split(i.r_isbn,' ')[1]}
							</td>
							<td>
								${i.r_name}<br />
								${i.r_hp}
							</td>
							<td>
								<fmt:formatDate value="${i.r_created}" pattern="yyyy-MM-dd"/>
								<c:if test="${i.r_payed ne null}">
								<br/>구매:<fmt:formatDate value="${i.r_payed}" pattern="yyyy-MM-dd"/>
								</c:if>
								<c:if test="${i.r_return ne null}">
								<br/>반납:<fmt:formatDate value="${i.r_return}" pattern="yyyy-MM-dd"/>
								</c:if>
								<c:if test="${i.r_return_close ne null}">
								<br/>마감:<fmt:formatDate value="${i.r_return_close}" pattern="yyyy-MM-dd"/>	
								</c:if>
							</td>
							<td id="manage">
								<c:choose>
									<c:when test="${i.r_state == 10 }">
								<a href="#" keyValue="${i.r_no}" state="13" class="btn btnRefund"><span>재고있음</span></a>
								<a href="#" keyValue="${i.r_no}" state="15" class="btn btnRefund"><span>주문중</span></a>
									</c:when>

									<c:when test="${i.r_state == 15 }">
								<a href="#" keyValue="${i.r_no}" state="17" class="btn btnRefund"><span>입고완료</span></a>
									</c:when>
									
									<c:when test="${i.r_state == 13 or i.r_state == 17 }">
								 결제 <select id="pay_type" class="payType_${i.r_no}">
										<option value="cash">현금</option>
										<option value="card">카드</option>
									</select><br />
								구매가 <input type="text" id="pay" class="payed_${i.r_no}" value="${i.r_price}" size="7" maxlength="5" /> 원<br />
								<a href="#" keyValue="${i.r_no}" state="20" class="btn btnBuying"><span>구매확정</span></a>
									</c:when>

									<c:when test="${i.r_state == 30 }">
								<a href="#" keyValue="${i.r_no}" state="40" class="btn btnRefund"><span>환불완료</span></a>
									</c:when>
								</c:choose>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(bookDreamList) < 1 }">
						<tr>
							<td colspan="8" height="50">등록된 정보가 없습니다.</td>
						</tr>
						</c:if>
					</tbody>
				</table>
				
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