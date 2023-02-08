<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
%>
<style>
/*변경 아이콘*/
.roombox_icon3 {background-image: url(/resources/common/img/rpoint.png);no-repeat;}
</style>


<script>
$(document).ready(function () {
	$('#btn_ebook').on('click', function(e){
		e.preventDefault();
		var win = window.open('', '');
	});
});
</script>


<p class="mat15">
<div class="roombox">
  <div class="icon_box"> <i class="icon roombox_icon3"></i>
    <div class="icon_line"> <span class="blue">독서포인트란?</span>
      <p>도서관에서 대출한 도서를 반납하면 1권당 포인트가 누적되고, 협약된 서점에서 도서를 구매할 때 현금처럼 포인트를 사용할 수 있는 서비스입니다.</p>
      <br>
      <a href="https://las.daegu.go.kr/point/homepage/pointssologin.do?userid=${member.member_id}&token=<%=token%>&key=<%=keyStr%>" title="새창열림" class="ebook_links cw-btn newWin btn"><span style="font-size:15px;">독서포인트 홈페이지 바로가기</span><span class="ico arr"></span><i class="fa fa-external-link"></i></a> </div>
  </div>
</div>
</p>

