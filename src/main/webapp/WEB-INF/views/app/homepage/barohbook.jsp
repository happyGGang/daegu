<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<%!
	private static int getRandomNumberInRange(int min, int max) {
		if (min >= max) {
			throw new IllegalArgumentException("max must be greater than min");
		}
	
		return (int)(Math.random() * ((max - min) + 1)) + min;
	}
%>
<%
	String member_id = "";
	kr.co.whalesoft.app.cms.member.Member member = (kr.co.whalesoft.app.cms.member.Member) session.getAttribute("member");
	if(member != null) {
		member_id = member.getMember_id();
	}
	
	int key = getRandomNumberInRange(1, 9999);
	String keyStr = org.apache.commons.lang.StringUtils.leftPad(String.valueOf(key), 4, "0");
	StringBuilder sb = new StringBuilder();
	
	sb.append("_cu");
	sb.append(keyStr);
	sb.append(member_id);
	sb.append("cni_");

	String token = org.apache.commons.codec.digest.DigestUtils.md5Hex(sb.toString());
	String tok = sb.toString();
%>


<script>
$(document).ready(function () {
	$('.hopeBook').attr('href','https://las.daegu.go.kr/baro/homepage/baroloanssologin.do?userid=${member.member_id}&token=<%=token%>&key=<%=keyStr%>');
});
</script>

<link rel="stylesheet" type="text/css" href="/resources/common/css/barohbook.css"/>

<div class="h-book-box">
  <h2>보고싶은 <span>책,<br />서점에서 대출</span>하다</h2>

  <h3 class="contTit_line">희망도서 바로대출은?</h3>
  <h5 class="mg10f">읽고 싶은 책이 도서관에 없는 경우<br />가까운 서점에서 새책으로 바로바로 빌려 볼 수 있는 서비스입니다.</h5>
  <br />
  <ul class="con">
    <li><b>이용대상</b>&nbsp;&nbsp;대구시민 (대구통합도서관 회원가입 필수)</li>
    <li><b>신청권수</b>&nbsp;&nbsp;1인 월 최대 2권</li>
    <li><b>대출기간</b>&nbsp;&nbsp;15일 이내 (대출일 포함)</li>
    <li><b>서비스 이용방법</li>
  </ul>
<div class="step_box">
		<ol class="no4">
		  <li>
			<div class="box">
				<img src="/data/menuResources/h32/99/1661163880626.png" title="희망도서대출서비스 이용안내 아이콘" alt="희망도서대출서비스 이용안내 아이콘">
			  <p class="num">STEP 01</p>
			  희망도서 바로대출 <br class="pcBr"><b>서비스 신청</b></div>
		  </li>
		  <li>
			<div class="box">
				<img src="/data/menuResources/h32/99/1661163886282.png" title="희망도서대출서비스 이용안내 아이콘" alt="희망도서대출서비스 이용안내 아이콘">
			  <p class="num">STEP 02</p>
			  대출 가능 승인 <br class="pcBr"><b>문자 수신</b></div>
		  </li>
		  <li>
			<div class="box">
				<img src="/data/menuResources/h32/99/1661163891102.png" title="희망도서대출서비스 이용안내 아이콘" alt="희망도서대출서비스 이용안내 아이콘">
			  <p class="num">STEP 03</p>
			  <b>서점에서</b> <br class="pcBr">희망도서 <b>대출</b></div>
		  </li>
		  <li>
			<div class="box">
				<img src="/data/menuResources/h32/99/1661163896930.png" title="희망도서대출서비스 이용안내 아이콘" alt="희망도서대출서비스 이용안내 아이콘">
			  <p class="num">STEP 04</p>
			  <b>도서관에</b> <br class="pcBr">읽은 책 <b>반납</b></div>
		  </li>
		</ol>
	  </div>	
</div>


<div class="pro_seat">
  <div class="box_area blue">
    <div class="tit_area">
      <p class="btxt">희망도서 바로대출 서비스 이용가능 도서관</p>
      <p class="stxt">도서관명을 클릭하시면 해당 도서관의 희망도서 바로대출 서비스 신청 페이지로 이동합니다.</p>
    </div>
    <div class="seat1">
      <ul>
        <li><a href="https://library.daegu.go.kr/gukbo/html/hopeBook.do?menu_idx=222" target="_blank" title="국채보상운동기념도서관 희망도서바로대출 안내 페이지 이동(새창열림)">국채보상운동기념도서관</a></li>
        <li><a href="https://library.daegu.go.kr/dongbu/html/hopeBook.do?menu_idx=191" target="_blank" title="대구광역시립동부도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립동부도서관</a></li>
		<li><a href="https://library.daegu.go.kr/donggu/html/hopeBook.do?menu_idx=182" target="_blank" title="대구동구도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구동구도서관(신천,안심)</a></li>
        <li><a href="https://library.daegu.go.kr/228/html/hopeBook.do?menu_idx=247" target="_blank" title="대구2·28기념학생도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구2·28기념학생도서관</a></li>
        <li><a href="https://library.daegu.go.kr/seobu/html/hopeBook.do?menu_idx=212" target="_blank" title="대구광역시립서부도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립서부도서관</a></li>
        <li><a href="https://library.daegu.go.kr/seogulib/html/hopeBook.do?menu_idx=145" target="_blank" title="서구통합도서관 희망도서바로대출 안내 페이지 이동(새창열림)">서구통합도서관(서구어린이,비산,서구영어,비원,원고개)</a></li>
        <li><a href="https://library.daegu.go.kr/nambu/html/hopeBook.do?menu_idx=215" target="_blank" title="대구광역시립남부도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립남부도서관</a></li>
        <li><a href="https://library.daegu.go.kr/namic/html/hopeBook.do?menu_idx=105" target="_blank" title="남구 이천어울림도서관 희망도서바로대출 안내 페이지 이동(새창열림)">남구 이천어울림도서관</a></li>
        <li><a href="https://library.daegu.go.kr/bukbu/html/hopeBook.do?menu_idx=187" target="_blank" title="대구광역시립북부도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립북부도서관</a></li>
        <li><a href="https://library.daegu.go.kr/bukgs/html/hopeBook.do?menu_idx=119" target="_blank" title="북구 구수산도서관 희망도서바로대출 안내 페이지 이동(새창열림)">북구 구수산도서관</a></li>
		<li><a href="https://library.daegu.go.kr/bukdh/html/hopeBook.do?menu_idx=110" target="_blank" title="북구 대현도서관 희망도서바로대출 안내 페이지 이동(새창열림)">북구 대현도서관</a></li>
        <li><a href="https://library.daegu.go.kr/suseong/html/hopeBook.do?menu_idx=185" target="_blank" title="대구광역시립수성도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립수성도서관</a></li>
        <li><a href="https://library.daegu.go.kr/beomeo/html/hopeBook.do?menu_idx=167" target="_blank" title="수성구 범어도서관 희망도서바로대출 안내 페이지 이동(새창열림)">수성구 범어도서관</a></li>
        <li><a href="https://library.daegu.go.kr/yonghak/html/hopeBook.do?menu_idx=174" target="_blank" title="수성구 용학도서관 희망도서바로대출 안내 페이지 이동(새창열림)">수성구 용학도서관</a></li>
        <li><a href="https://library.daegu.go.kr/gosan/html/hopeBook.do?menu_idx=130" target="_blank" title="수성구 고산도서관 희망도서바로대출 안내 페이지 이동(새창열림)">수성구 고산도서관</a></li>
        <li><a href="https://library.daegu.go.kr/duryu/html/hopeBook.do?menu_idx=182" target="_blank" title="대구광역시립두류도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립두류도서관</a></li>
        <li><a href="https://library.daegu.go.kr/dalseong/html/hopeBook.do?menu_idx=141" target="_blank" title="대구광역시립달성도서관 희망도서바로대출 안내 페이지 이동(새창열림)">대구광역시립달성도서관</a></li>
		<li><a href="https://library.daegu.go.kr/dalseolib/html/hopeBook.do?menu_idx=164" target="_blank" title="달서통합도서관 희망도서바로대출 안내 페이지 이동(새창열림)">달서통합도서관(달서영어)</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="hopeBook_box">
	<div class="move">
		<c:choose>
			<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">

				<c:choose>
					<c:when test="${ sessionScope.member.member_class ne '0' }">
						<a href="#none" onclick="alert('정회원만 사용가능한 서비스 입니다.')" class="ebook_links newWin"><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><!--<span class="ico arr"></span>--></a>
					</c:when>
					<c:otherwise>
						<a href="#" id="btn_ebook" title="새창열림" class="ebook_links newWin hopeBook" target="_blank"><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span></a>
					</c:otherwise>
				</c:choose>

			</c:when>
			<c:otherwise>
				<a href="#none" onclick="alert('로그인후 이용바랍니다.');location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${param.menu_idx}&before_url=/${homepage.context_path}/html/barohbook.do?menu_idx=${param.menu_idx}';" class="ebook_links" /><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><!--<span class="ico arr"></span>--></a> 
			</c:otherwise>
		</c:choose>
	</div>
</div>