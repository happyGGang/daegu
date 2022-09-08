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
	.hopeBook_box{position:relative;background:url('/resources/common/img/hopeBook_img.png')no-repeat;padding:90px 0 60px 515px;min-height:300px;}
	.hopeBook_box p.txt1{font-family:'s-core_dream6_bold';color:#000;font-size:28px;margin-bottom:15px;}
	.hopeBook_box p.txt1 span{color:#0085d9;}
	.hopeBook_box p.txt2{font-family:'s-core_dream4_regular';color:#000;font-size:16px;margin-bottom:15px;}
	.hopeBook_box .move{background:#00a0d9;width:300px;text-align:center;padding:15px 0;border-radius:50px;}
	.hopeBook_box .move a{font-family:'s-core_dream5_medium';color:#fff;font-size:16px;}

	@media all and (max-width:780px){
		.hopeBook_box{position:relative;width:80%;background-size:100%;margin:0 auto;text-align:center;padding:60% 0 0 0;}
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

<div class="hopeBook_box">
	<p class="txt1"><span>희망도서 바로대출</span> 서비스란?</p>
	<p class="txt2">내가 신청한 희망도서를 <br />협약된 지역서점에서 바로 대출하는 서비스 입니다.</p>
	<div class="move">
		<c:choose>
			<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">

				<c:choose>
				<c:when test="${ sessionScope.member.member_class ne '0' }">
					<a href="#none" onclick="alert('정회원만 사용가능한 서비스 입니다.')" class="ebook_links newWin"><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><span class="ico arr"></span><i class="fa fa-external-link"></i></a>
				</c:when>
				<c:otherwise>
					<a href="#" id="btn_ebook" title="새창열림" class="ebook_links newWin hopeBook" target="_blank"><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><span class="ico arr"></span><i class="fa fa-external-link"></i></a>
				</c:otherwise>
				</c:choose>

			</c:when>
			<c:otherwise>
				<a href="#none" onclick="alert('로그인후 이용바랍니다.');location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=${param.menu_idx}&before_url=/${homepage.context_path}/html/hopeBook.do?menu_idx=119';" class="ebook_links" /><span style="margin-right:5px;">희망도서바로대출 바로가기 &gt;</span><span class="ico arr"></span><i class="fa fa-external-link"></i></a> 
			</c:otherwise>
		</c:choose>
	</div>
</div>