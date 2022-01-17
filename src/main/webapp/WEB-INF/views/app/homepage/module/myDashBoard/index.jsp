<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/common/css/myDashBoard.css">

 <script type="text/javascript">

$(document).ready(function() {
	$('ul#parent2').hide();
	$('a.bookTap').on('click', function(e) {
		e.preventDefault();
		$('div.appDataSub ul.tab li').css('border-bottom','none');
		$(this).parent('li').css('border-bottom', '2px solid #326ba0');
		$(this).parent('li').css('font-color', '#326ba0');
		$(this).parent('li').css('font-weight', 'bold');
		$('div.bookList').hide();
		$('div.bookList#'+$(this).data('divid')).show();
	});

	$('a.bookTap2').on('click', function(e) {
		e.preventDefault();
		$('div.appDataSub ul.tab li').css('border-bottom','none');
		$(this).parent('li').css('border-bottom', '2px solid #326ba0');
		$(this).parent('li').css('font-color', '#326ba0');
		$(this).parent('li').css('font-weight', 'bold');
		$('div.bookList').hide();
		$('div.bookList#'+$(this).data('divid')).show();
	});
	
	$('a.bookTap3').on('click', function(e) {
		e.preventDefault();
		$('div.appDataSub ul.tab li').css('border-bottom','none');
		$(this).parent('li').css('border-bottom', '2px solid #326ba0');
		$(this).parent('li').css('font-color', '#326ba0');
		$(this).parent('li').css('font-weight', 'bold');
		$('div.bookList').hide();
		$('div.bookList#'+$(this).data('divid')).show();
	});
	$('a#firstBook').trigger('click');
	$('div#paging').hide();
	$('a#close').hide();

	$('a#lendMore').on('click', function(e) {
		e.preventDefault();
		$('a#close').show();
		$('a#lendMore').hide();
		$('ul.parent').css('height','auto');
	});

	$('a#close').on('click', function(e) {
		e.preventDefault();
		$('a#close').hide();
		$('a#lendMore').show();
		$('ul.parent').css('height','350px');
	});

	$('a.viewNotice').on('click', function(e) {
		e.preventDefault();
		var url = 'view.do?informNo='+$(this).attr('keyValue');
		$('div#dialog > div').load(url, function() {
			noticeDialog = $('div#dialog > div').dialog({
				title:'개인공지사항',
				modal:true,
				width:700,
				position:{
					my:"center",
					at:"center",
					of:window
				},
				close: function(){
					noticeDialog.dialog("destroy");
				}
			});
		});
	});



});
</script>
<div class="myDashBoardWrap">
<div class="userInfoWrap">
<h3>이용자 정보</h3>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="userInfo">
		<ul class="info">
			<li class="subject"><span>이름</span></li>
			<li class="content-info">${sessionScope.member.member_name}</li>
			<li class="subject"><span>회원구분</span></li>
			<li class="content-info">
				<c:choose>
				<c:when test="${empty sessionScope.member.ci_value or (sessionScope.member.unAgreeFlag ne '0001' and sessionScope.member.unAgreeFlag ne '0002')}">
				미통합회원
				<a href="/${homepage.context_path}/intro/join/integration.do?menu_idx=${modifyFormMenuIdx}" title="통합회원전환">
					<span class="blue">
						통합회원전환<b class="arr"> ></b>
					</span>
				</a>
				</c:when>
				<c:otherwise>
				통합회원
				</c:otherwise>
				</c:choose>
			</li>

			<li class="subject"><span>소속도서관</span></li>
			<li class="content-info">${sessionScope.member.loca_name}</li>
			<li class="subject"><span>최근로그인</span></li>
			<li class="content-info"> <fmt:formatDate value="${sessionScope.member.last_login}" pattern="yyyy.MM.dd"/></li>

			<li class="subject"><span>전화번호</span></li>
			<li class="content-info">${sessionScope.member.cell_phone1}-${sessionScope.member.cell_phone2}-${sessionScope.member.cell_phone3}</li>
			<li class="subject"><span>이메일</span></li>
			<li class="content-info">${sessionScope.member.email}</li>
			<li class="subject"><span>최근접속IP</span></li>
			<li class="content-info">${sessionScope.member.last_login_ip}</li>

			<li class="subject"><span>주소</span></li>
			<li class="content-info">${sessionScope.member.address1}</li>
		</ul>
		<div class="recordValue">
		<ul class="recordValue1">
			<li class="circle">
				<a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=${loanMenuIdx}"  title="소속도서관 대출건수">
					<span class="title">소속도서관<br>대출건수</span>
					<p class="value">
					<span class="orange">${myDashBoard.loanCnt}</span>
                    </p>
				</a>
			</li>
			<li class="circle">
				<a href="/${homepage.context_path}/intro/search/loan/history.do?menu_idx=${loanMenuIdx}"  title="타도서관 대출건수">
					<span class="title">타도서관<br>대출건수</span>
					<p class="value">
					<span class="orange">${myDashBoard.otherLoanCnt}</span>
                    </p>
				</a>
			</li>
			<li class="circle">
				<a href="/${homepage.context_path}/module/teach/applyList.do?menu_idx=${teachMenuIdx}"  title="수강신청건수">
					<span class="title2">수강신청건수</span>
					<p class="value">
					<span class="orange">${myDashBoard.teachApplyCnt}</span>
                    </p>
				</a>
			</li>
			<li class="circle">
				<a href="/${homepage.context_path}/intro/search/loan/index.do?menu_idx=${loanMenuIdx}"  title="연체중도서">
					<span class="title2">연체중도서</span>
					<p class="value">
					<span class="orange">${myDashBoard.delayCnt}</span>
                    </p>
				</a>
			</li>
			</ul>
			<ul class="recordValue2">
			<li class="recoardWritten">
			<a href="/${homepage.context_path}/module/boardHistory/index.do?menu_idx=${boardMenuIdx}"  title="게시글">
				<span class="icon"><img class="recoard" alt="" src="/resources/common/img/dashBoard/icon1.png"></span>
				<p class="word">게시글<span class="gray"> ${myDashBoard.boardCount}건</span></p>
			</a>
			</li>
			<li class="recoardWritten">
			<a href="/${homepage.context_path}/module/boardHistory/index.do?historyType=reply&menu_idx=${boardMenuIdx}"  title="댓글">
				<span class="icon"><img class="recoard" alt="" src="/resources/common/img/dashBoard/icon2.png"></span>
				<p class="word">댓글 <span class="gray"> ${myDashBoard.replyCount}건</span></p>
			</a>
			</li>
			<li class="recoardWritten">
			<a href="/${homepage.context_path}/module/myStorage/index.do?menu_idx=${param.menu_idx}"  title="보관">
				<span class="icon"><img class="recoard" alt="" src="/resources/common/img/dashBoard/icon3.png"></span>
				<p class="word">보관 <span class="gray">${myDashBoard.myItemCount}건</span></p>
			</a>
			</li>
			<li class="recoardWritten" style="display: none;">
			<a href="#"  title="서평">
				<span class="icon"><img class="recoard" alt="" src="/resources/common/img/dashBoard/icon4.png"></span>
				<p class="word">서평 <span class="gray">5건</span></p>
			</a>
			</li>
		</ul>
		</div>
	</div>
</div>
<div class="myUtil">
	<div class="utilBtn">
		<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/modifyForm.do?menu_idx=${modifyFormMenuIdx}" class="leftBtn"  title="개인정보수정"><span class="left1">개인정보수정<b class="orange">></b></span></a>
		<a href="https://www.gbelib.kr/${homepage.context_path}/intro/join/reAgree.do?menu_idx=${modifyFormMenuIdx}" class="leftBtn2"  title="개인정보 동의 기간연장"><span class="left2">개인정보 동의 기간 연장<b class="orange">></b></span></a></a>
<!-- 		<a href="#" class="leftBtn2"  title="개인정보 동의 기간연장" id="thirdBtn"><span class="left2">개인정보 동의 기간 연장<b class="orange">></b></span></a></a> -->
		<a href="/${homepage.context_path}/module/myStorage/index.do?menu_idx=${param.menu_idx}" class="rightBtn" title="내보관함보기"><span class="right">내보관함 보기</a>
	</div>
	<div class="desc">
		<c:if test="${not empty member.not_loan_sdate or member.not_loan_edate}">
		<p><span class="red">*</span> 회원님은 도서연체반납으로 <span class="orange">${fn:substring(member.not_loan_edate, 0, 4)}년 ${fn:substring(member.not_loan_edate, 4, 6)}월 ${fn:substring(member.not_loan_edate, 6, 8)}일</span>까지 <span class="orange">대출정지중</span>입니다.</p>
		</c:if>
		<p><span class="red">*</span> 회원님의 개인정보 재동의 기간은 <span class="orange">~ ${sessionScope.member.agree_date_str}</span> 입니다.</p>
		<p><span class="red">*</span> 해당 년월일 동안 대출 이력이 없으면 개인정보가 삭제됩니다.</p>
		<p><span class="red">*</span> 회원 자격 유지기간을 연장하려면 위의 개인정보 동의 기간 연장 버튼을 클릭하세요.</p>
	</div>
</div>

<div class="notice">
	<div class="h3Subject">
	<h3>개인 공지사항</h3>
	<a href="#" class="more" title="전체보기" style="display: none;">+ 전체보기</a>
	</div>
	<div class="noticeList">
		<ul class="harf1">
			<c:forEach items="${myNoticeList}" begin="0" end="3" var="i">
			<li>
				<a href="#" class="viewNotice" keyValue="${i.INFORM_NO}">
				<span class="title">${i.INFORM_TITLE}</span>
				<span class="date">${fn:substring(i.INSERT_DATE, 0, 4)}.${fn:substring(i.INSERT_DATE, 4, 6)}.${fn:substring(i.INSERT_DATE, 6, 8)}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
		<ul class="harf2">
			<c:forEach items="${myNoticeList}" begin="4" end="7" var="i">
			<li>
				<a href="#" class="viewNotice" keyValue="${i.INFORM_NO}">
				<span class="title">${i.INFORM_TITLE}</span>
				<span class="date">${fn:substring(i.INSERT_DATE, 0, 4)}.${fn:substring(i.INSERT_DATE, 4, 6)}.${fn:substring(i.INSERT_DATE, 6, 8)}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>
<div class="lendData">
	<div class="h3Subject">
		<h3>대출중인 자료</h3>
		<a href="#" class="more" id="lendMore" title="전체보기">+ 전체보기</a><a href="#" class="more" id="close" title="접기">- 접기</a>
	</div>
	<div class="lentbooks">
		<ul class="parent">
			<c:forEach items="${myLoanList.dsMyLibraryList}" var="i" varStatus="status">
			<li class="parentLi">
				<ul class="child">
					<li>
						<span class="bookImg">
							<a href="/${homepage.context_path}/intro/search/loan/detail.do?vLoanNo=${i.LOAN_NO}&menu_idx=${loanMenuIdx}" title="${i.TITLE}">
								<c:choose>
								<c:when test="${empty i.image}">
								<img class="lendBook" alt="${i.TITLE}" src="/resources/homepage/geic/img/noimg2.png">
								</c:when>
								<c:otherwise>
								<img class="lendBook" alt="${i.TITLE}" src="${i.image}">
								</c:otherwise>
								</c:choose>
							</a>
						</span>
					</li>
					<li class="bookTitle">
						<span>
							<a href="/${homepage.context_path}/intro/search/loan/detail.do?vLoanNo=${i.LOAN_NO}&menu_idx=${loanMenuIdx}" title="${i.TITLE}">
								${fn:substring(i.TITLE, 0, 25)}
							</a>
						</span>
					</li>
					<li class="lentDate">
						<span class="dateWord">대출일</span>
						<span class="dateNum">
							<fmt:parseDate var="curDate" value="${i.LOAN_DATE}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>
						</span>
					</li>
					<li class="returnDate">
						<span class="dateWord">반납일</span>
						<span class="dateNum">
							<fmt:parseDate var="curDate" value="${i.RETURN_PLAN_DATE}" pattern="yyyyMMdd"/>
							<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>
						</span>
					</li>
					<li class="btn" style="display: none;">
						<a href="#" loanNo="${i.LOAN_NO}" class="loanReNew">
							<img class="lendIcon" alt="빌린책" src="/resources/common/img/dashBoard/lendIcon.jpg">
						</a>
					</li>
				</ul>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>

<div class="notice">
	<div class="h3Subject2">
	<h3>신청중인 자료</h3>
	</div>
	<div class="appDataSub">
		<ul class="tab">
			<li id="first"><a href="#" class="bookTap" data-divId="bookList1" id="firstBook" title="희망도서 신청">희망도서 신청</a></li>
		</ul>
	</div>
	<div class="noticeList bookList" id="bookList1">
		<ul class="harf1">
			<c:forEach items="${myHopeList.dsMyLibraryList}" begin="0" end="3" var="i">
			<li>
				<a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=${hopeMenuIdx}" title="${i.TITLE}">
					<span class="title">${i.TITLE}</span>
					<span class="date appDate">
						<c:catch var="e1">
						<fmt:parseDate value="${i.INSERT_DATE}" pattern="yyyyMMddHHmmss" var="insertDate"/>
						<fmt:formatDate value="${insertDate}" pattern="yyyy-MM-dd"/>
						</c:catch>
						<c:if test="${e1 != null}">
						<fmt:parseDate value="${i.INSERT_DATE}" pattern="yyyyMMdd" var="insertDate"/>
						<fmt:formatDate value="${insertDate}" pattern="yyyy-MM-dd"/>
						</c:if>
					</span>
					<span class="state">${i.STATUS_FLAG_DISPLAY}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
		<ul class="harf3">
			<c:forEach items="${myHopeList.dsMyLibraryList}" begin="4" end="7" var="i">
			<li>
				<a href="/${homepage.context_path}/intro/search/hope/history.do?menu_idx=${hopeMenuIdx}" title="${i.TITLE}">
					<span class="title">${i.TITLE}</span>
					<span class="date appDate">
						<c:catch var="e1">
						<fmt:parseDate value="${i.INSERT_DATE}" pattern="yyyyMMddHHmmss" var="insertDate"/>
						<fmt:formatDate value="${insertDate}" pattern="yyyy-MM-dd"/>
						</c:catch>
						<c:if test="${e1 != null}">
						<fmt:parseDate value="${i.INSERT_DATE}" pattern="yyyyMMdd" var="insertDate"/>
						<fmt:formatDate value="${insertDate}" pattern="yyyy-MM-dd"/>
						</c:if>
					</span>
					<span class="state">${i.STATUS_FLAG_DISPLAY}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>
	<div class="appDataSub appDataSub3">
		<ul class="tab">
			<li id="second"><a href="#" class="bookTap2" data-divId="bookList2" title="예약도서 신청">예약도서 신청</a></li>
		</ul>
	</div>
	<div class="noticeList bookList" id="bookList2">
		<ul class="harf1">
			<c:forEach items="${myReserveList.dsMyLibraryList}" begin="0" end="3" var="i">
			<li>
				<a href="#" title="${i.TITLE}">
				<a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=${reserveMenuIdx}" title="${i.TITLE}">
					<span class="title">${i.TITLE}</span>
					<span class="date appDate">
						<fmt:parseDate var="curDate" value="${i.RESVE_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>
					</span>
					<span class="state">${i.STATUS_NAME}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
		<ul class="harf3">
			<c:forEach items="${myReserveList.dsMyLibraryList}" begin="4" end="7" var="i">
			<li>
				<a href="/${homepage.context_path}/intro/search/resve/index.do?menu_idx=${reserveMenuIdx}" title="${i.TITLE}">
					<span class="title">${i.TITLE}</span>
					<span class="date appDate">
						<fmt:parseDate var="curDate" value="${i.RESVE_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>
					</span>
					<span class="state">${i.STATUS_NAME}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>
<div class="appDataSub appDataSub2">
		<ul class="tab">
			<li id="third"><a href="#" class="bookTap3" data-divId="bookList3" title="상호대차 신청">상호대차 신청</a></li>
		</ul>
	</div>
	<div class="noticeList bookList" id="bookList3">
		<ul class="harf1">
			<c:forEach items="${myReserveList.myOutList}" begin="0" end="3" var="i">
			<li>
				<a href="#;" title="${i.TITLE}">
					<span class="title">${i.TITLE}</span>
					<span class="date appDate">
						<fmt:parseDate var="curDate" value="${i.REQST_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>
					</span>
					<span class="state">${i.STATUS_NAME}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
		<ul class="harf3">
			<c:forEach items="${myReserveList.myOutList}" begin="4" end="7" var="i">
			<li>
				<a href="#;" title="${i.TITLE}">
					<span class="title">${i.TITLE}</span>
					<span class="date appDate">
						<fmt:parseDate var="curDate" value="${i.REQST_DATE}" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${curDate}" type="both" pattern="yyyy.MM.dd"/>
					</span>
					<span class="state">${i.STATUS_NAME}</span>
				</a>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>

<div id="dialog" title="개인공지사항" style="display: none;">
	<div>

	</div>
</div>
</div>
