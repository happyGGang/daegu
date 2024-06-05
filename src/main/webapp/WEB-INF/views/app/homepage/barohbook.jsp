<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
/* jsDiv */
body.no_scroll { overflow: hidden;}

div.jsDiv,
article.jsDiv{ display: none; position: fixed; left: 0;top: 0; width: 100%; height: 100%; z-index:999990; background: rgba(0, 0, 0, 0.5); }
div.jsDiv.on,
article.jsDiv.on { display: block; }


.jsDiv_container { width: 90%; height: 85%; padding: 0; margin: 4.5% auto 0 auto; background: #f9f9f9; position: relative;border: solid 1px rgba(0,0,0,0.7); border-radius:6px; overflow: hidden; overflow-y: auto; box-shadow: 0 3px 5px rgba(0,0,0,.2)}
.jsDiv_container .h4 { text-align: center; font-size: 18px; padding: 15px 0; border-bottom: solid 1px #ddd; background: #666;  color: #fff }
.jsDiv_container .input { background: #fff }
/* 
#map_wrap .jsDiv_container { height: 80% }
#map_wrap .jsDivClose { display: block; width: 30px;height: 30px; padding: 0; border: none; position: absolute; }
*/

.jsDivClose{ background: url(../images/btn_navClose.png) no-repeat center center; display: block; width: 28px; height: 28px; padding: 0; position: absolute; right:5%; top:2.5%; border: #ddd 1px solid; border-radius:4px; text-indent: -9999px;overflow: hidden; opacity:.6 }
.jsDivClose { display: block; width: 30px;height: 30px; padding: 0; border: none; position: absolute; right:5%; top:2.5%; text-indent: -9999px;overflow: hidden; opacity:.6 }
.jsDivClose:hover,
.jsDivClose:focus { opacity: 1 }

.btn_area a.btn.jsDivClose { position: static; }

article.jsDiv .btn_area { text-align: center; border-top:solid 1px #ebebeb; padding: 10px 0 0 0; height: 44px; background: #fff;  }
article.jsDiv .btn_area .btn {float: none;}

.h3_jsDiv { background: #00a2c5; color: #fff; padding:20px 0; text-align: center; font-size: 18px;; border-radius:6px 6px 0 0 }

.jsDiv .btn_area_C { padding:20px 0; background: #fff; border-top:solid 1px #ededed; border-radius:0 0 6px 6px}
</style>

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

<style>
	.hopeBook_box{position:relative;padding:2% 0;text-align:center;}
	.hopeBook_box p.txt1{font-family:'s-core_dream6_bold';color:#000;font-size:28px;margin-bottom:15px;}
	.hopeBook_box p.txt1 span{color:#0085d9;}
	.hopeBook_box p.txt2{font-family:'s-core_dream4_regular';color:#000;font-size:16px;margin-bottom:15px;}
	.hopeBook_box .move{background:#00a0d9;width:300px;margin:0 auto;text-align:center;padding:15px 0;border-radius:50px;}
	.hopeBook_box .move a{font-family:'s-core_dream5_medium';color:#fff;font-size:16px;}

	@media all and (max-width:780px){
		.hopeBook_box{position:relative;width:80%;margin:0 auto;text-align:center;padding:60% 0 0 0;}
		.hopeBook_box p.txt1{font-size:22px;}
		.hopeBook_box p.txt2{font-size:14px;}
		.hopeBook_box .move{margin:0 auto;}
		.hopeBook_box .move a{font-size:14px;}
	}

	@media all and (max-width:425px){
		.hopeBook_box p.txt1{font-size:22px;}
		.hopeBook_box p.txt2{font-size:14px;}
		.hopeBook_box .move a{font-size:14px;}
	}
</style>


<script>
$(document).ready(function () {
	$('.hopeBook').attr('href','https://las.daegu.go.kr/baro/homepage/baroloanssologin.do?userid=${member.member_id}&token=<%=token%>&key=<%=keyStr%>');
});
</script>

<style>
.h-book-box{position:relative;width:100%;background:url('/data/menuResources/h32/99/1661160692638.png')no-repeat top right;background-size:40%;}
.h-book-box h2{font-size:38px;font-family:'s-core_dream6_bold';color:#222222;letter-spacing:-0.5px;}
.h-book-box h2 span{color:#33acf1;}

.step_box ol li{background:url("/resources/common/img/bu_arrow.png") no-repeat 8px 80px;}
.step_box ol li .box{color:#555;}
.step_box ol li .box img{width:20%;}
.step_box ol li .box p{margin-top:10px;}

.dpt-list-type04 ul li{width:23.5%;display:inline-block;padding-left:0;border:1px solid #ddd;margin-right:8px;padding:20px 0;}
.dpt-list-type04 ul li .num{position:relative;margin:0 auto;}
.dpt-list-type04 ul li .num:after{display:none;}
.dpt-list-type04 ul li .txt{text-align:center;}

.pro_seat{position:relative;margin-top:10px;}
.pro_seat .box_area{padding: 50px 70px;background:#f0f0f0;}
.pro_seat ul li.long a{letter-spacing:-2px;font-size:14px;}
.box_area .tit_area{width:100%;text-align:center;}
.box_area .tit_area .btxt{font-size:1.5rem;color:#000;font-weight:800;}
.box_area .tit_area .btxt span{}
.box_area .tit_area .stxt{margin-top:10px;font-size: 1rem;color:#555;}
.box_area ul{display:inline-block;margin: 0 0 0 -10px;}
.box_area ul li {display: block;float:left;width:49%;margin:10px 2% 0 0;background:#fff;transition:all 0.3s ease;border-radius: 2px;}
.box_area ul li:nth-child(2n) {margin-right:0;}
.box_area ul li a{display:block;padding-left:30px;height:50px;line-height:50px;vertical-align:middle;font-size:15px;color:#444;letter-spacing:-1.25px;transition:all 0.2s ease;}
.box_area.blue ul li:hover{/*background:url(/resources/homepage/lib/img/o_seat_blue.jpg) no-repeat 0 0;*/ background-color:#2237a2;}
.box_area.blue ul li:hover a{padding-left:50px;color:#fff;}
.box_area .seat1{float:none;margin-top:30px;}
.box_area .seat2{float:none; }
.box_area .tit_st{position:relative;text-align:left;font-size:1rem;font-weight:800;padding-top:20px;padding-left: 25px;}
.box_area .tit_st:after{position: absolute;left: 8px;top: 1.8rem;width: 0.25rem;height: 0.5rem;background-color: #3077AB;content: '';-webkit-transform: skewX(-38.5deg);transform: skewX(-38.5deg);}

 .pcBr{display:block;}


@media (max-width:930px){
	.h-book-box{background-size:45%;}
}

@media (max-width:768px){
	.h-book-box{background:none;}
	.h-book-box h2{font-size:33px;line-height:130%;}

	.step_box ol li{background:none;}
	.step_box ol li .box img{display:none;}
	.step_box ol li .box p{margin-top:0;}

	/******  ******/
	.pro_seat{margin-top:0;}
	.pro_seat .box_area{padding:25px 25px 0 25px;}
	.box_area ul{margin: 10px 0 30px -10px;}
	.box_area ul li{width:100%;margin:2% 0 0 1%;}
	.box_area.blue ul li:hover{background-size:100% 100%;}

	/*각컬러*/
	.box_area.blue ul li:nth-child(1):hover{background-size:100% 100%;}
	.box_area.blue ul li:nth-child(2):hover{background-size:100% 100%;}
	.box_area.blue ul li:nth-child(3):hover{background-size:100% 100%;}
	.box_area .tit_area .btxt{line-height:35px;font-size:1.2rem;font-weight:800;}
	.box_area .tit_area .stxt{font-size:0.9rem;}


	.dpt-list-type04 ul {/* border-top: 1px solid #555555; *//* border-bottom:1px solid #c3c3c3; *//* padding: 0 20px 25px 5px; */}
	.dpt-list-type04 ul li {position:relative;min-height: 35px;margin:6px 0 7px;padding:0;padding-left: 65px;padding-top:3px;width:100%;border:none;}
	.dpt-list-type04 ul li .num {position:absolute;left:0;top: 3px;display:block;border-radius:50%;width:36px;height:36px;color:#fff;font-size: .938em;font-weight: 500;letter-spacing:0;text-align:center;line-height:36px;vertical-align:middle;}
	.dpt-list-type04 ul li .num:after {content:"";position:absolute;right: -20px;top:50%;display:block;background-color:rgba(41, 59, 76, .2);width:11px;height:2px;}
	.dpt-list-type04 ul li:nth-child(3n) .num {background-color: #4373b9;}
	.dpt-list-type04 ul li:nth-child(3n+1) .num {background-color: #ca0464;}
	.dpt-list-type04 ul li:nth-child(3n+2) .num {background-color: #014898;}
	.dpt-list-type04 ul li .tit {padding:4px 0 6px;color:#222;font-weight:500;font-size:1.188em;line-height:1.3;}
	.dpt-list-type04 ul li .txt {/* margin-left:2px; */padding-top: 7px;/* padding-bottom:7px; */line-height: 1.7;text-align: left;}
	.dpt-list-type04 ul li .txt2 {/* margin-left:2px; */padding-top: 3px;/* padding-bottom:7px; */line-height: 1.7;text-align: left;}

	.box_area ul li a {font-size:14px;}

	.pcBr{display:none;}
}

@media (max-width:600px){
	.box_area ul li a {font-size:13px;}
}

@media (max-width:425px){
	/******  ******/
	.pro_seat{margin-top:0;}
	.pro_seat .box_area{padding:25px 25px 0 25px;}

	.box_area .seat1{margin-top:15px;}

	.box_area ul li a {font-size:12px;}
}

@media (max-width:375px){
	/******  ******/
	.pro_seat .box_area{padding:25px 25px 0 25px;}
	.pro_seat .icon1{margin-left:-80px;}

	.box_area .seat1{margin-top:10px;}
}

</style>

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