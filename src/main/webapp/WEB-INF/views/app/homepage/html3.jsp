<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%!
	public String encription()
	{
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss"); 

		String nowTime = sdf.format(new java.util.Date()); 
		String nowSec = nowTime.substring(12,14);
		String strTemp1 = nowTime.substring(2,12);
		
		int len = strTemp1.length();
		int j=0,k=1;

		String strTemp2="";
		int i9 = 620 +  Integer.parseInt(nowSec);


			for (int i=1;i<=len;i++){
			strTemp2 = strTemp1.substring(j++,k++) + strTemp2;
				if(i==1)
					strTemp2 = 310 + strTemp2;
				if(i==3)
					strTemp2 = 580 + strTemp2;		
				if(i==9)
					strTemp2 = i9 + strTemp2;	
			}
		String encription = strTemp2;
		return encription;
	}
%>

<div class="kiss_bgbox bgbox">
	<div class="lf-txt">
	  <p><span class="tt">구독 DB 서비스</span><br>
		<span class="btit">KISS 학술 DB</span></p>
		<br>
			<ul class="btns_wrap_tac">
				<li>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${empty sessionScope.member.user_no or sessionScope.member.user_no eq '' or sessionScope.member.user_no eq 'null'}">
								<a href="#not" class="btn_link06" title="KISS 바로가기(새창열림)"   onclick="alert('정회원만 이용가능합니다.');"><span>KISS 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<a href="http://kiss.kstudy.com/?c_code=<%=encription()%>&code=0008" class="btn_link06" title="KISS 바로가기(새창열림)"  target="_blank"><span>KISS 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="#not" class="btn_link06" title="KISS 바로가기(새창열림)" onclick="alert('로그인 후 이용가능합니다.'); location.href='/elib/intro/login/index.do?menu_idx=43';"><span>KISS 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>
				</li>
			</ul>
	</div>
</div>
<br>
<h3 class="contTit_line">KISS 학술 DB</h3>
<ul class="con">
	<li>내용 : 국내 전 주제 분야 1,300여개 학술기관 발행 학회지 원문 제공</li>
	<li>대표학회 : 한국정책학회, 법조협회, 한국심리학회,한국아동학회, 대한금속재료학회, 대한토목학회, 한국체육학회 , 한국보건간호학회 등</li>
</ul>