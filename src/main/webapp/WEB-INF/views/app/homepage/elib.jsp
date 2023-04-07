<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />

<!--두류 서부 제외 시립-->
<c:if test="${homepage.context_path eq 'dgportal' || homepage.context_path eq '228' || homepage.context_path eq '228lib' || homepage.context_path eq 'nambu' || homepage.context_path eq 'dalseong' || homepage.context_path eq 'dongbu' || homepage.context_path eq 'bukbu' || homepage.context_path eq 'suseong' || homepage.context_path eq 'jungang'}">
	<div class="dpt-intro-type02">
	  <div class="role-head">
		<div class="ImgBox">
			<img src="/resources/homepage/dgportal/img/sv_top_img06.jpg" alt="" org_width="620" org_height="280" isinit="true" class="vis-img">
		</div>
		<div class="role-head-tit">
		  <div class="txtBox">
			<h3 class="ptit">대구전자도서관</h3>
			<span class="ptitEng">대구시민의 스마트한<br>독서생활이 시작되는 곳</span>
				<p class="center">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="http://library.daegu.go.kr/elib/index.do" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank">
					</c:when>
					<c:otherwise>
						<!--a href="javascript:void(0);" onclick="alert('로그인후 이용바랍니다.'); location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=4';" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"-->
						<!-- <a href="javascript:void(0);" onclick="alert('대구전자도서관 이관 작업으로 서비스가 일시중지됩니다. 2020.3.16. 00:00 ~ 2020.3.17. 24:00'); return false;" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"> -->
						<a href="http://library.daegu.go.kr/elib/index.do" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank">
					</c:otherwise>
				</c:choose>
				<span>대구전자도서관 바로가기</span><span class="ico ico_link"></span><i class="fa fa-external-link"></i></a></p>
			</div>
		</div>
	  </div>
	  <div class="role-body center">
		<p class="tit">대구지역 공공도서관 회원이면 누구나 이용할 수 있는 대구전자도서관입니다.</p>
		<p>현재 이용가능 콘텐츠는 전자책, 오디오북, 이러닝, 국내학회지 원문DB, 음악라이브러리입니다.</p>
	  </div>
	  <h3 class="contTit_line">회원가입 및 절차</h3>
	  <ul class="con">
		<li>대구시 공립도서관 통합회원 가입(통합회원인증)
		  <ul>
			<li>신규 : 통합회원가입, 기존 지역공공도서관 회원 : 통합회원인증</li>
		  </ul>
		</li>
		<!--li>공공도서관 홈페이지에서 회원 인증 후 개인정보 수집 및 이용 동의하기
		  <ul>
			<li>최초 방문 시 인증 한번으로 재 로그인부터는 자동 접속</li>
		  </ul>
		</li-->
		<li>대구전자도서관 홈페이지에서 전자책 및 오디오북 메뉴 클릭 후 이용하기 
		  <ul>
			<li>지역 공공도서관에 있는 전자책 및 오디오북 이용 가능</li>
		  </ul>
		</li>
	  </ul>
	</div>
	<div class="next_list1 item4">
    <ul>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list01.png"> </div>
        <span class="bottom_txt">대구광역시공립도서관<br>
        회원가입</span> </li>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list02.png"> </div>
        <span class="bottom_txt">대구전자도서관에서<br>
        자료 검색</span> </li>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list03.png"> </div>
        <span class="bottom_txt">책 읽기 선택 후<br>
        리더기 설치 완료</span> </li>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list04.png"> </div>
        <span class="bottom_txt">나의도서관에서<br>
        책 읽기</span> </li>
    </ul>
  </div>
  <h3 class="contTit_line">대출규정(소장형)</h3>
  <ul class="con">
    <li>대출권수 : 전자책 3권, 오디오북 제한없음</li>
    <li>대출기간 : 8일(대출일포함)</li>
    <li>대출기간 : 대출기한 만료 시 자동반납(수동반납 가능)</li>
    <li>예약제한 : 2권<br>
    </li>
  </ul>
  <!-- <h3 class="contTit_line">모바일도서관 앱 이용 방법</h3>
  <h4 class="contSTit_line">대구전자도서관 앱 내려받기 </h4>
  <ul class="con">
    <li>아이폰 : 앱스토어 &quot;대구전자도서관&quot; 검색 후 내려받기<br>
    </li>
    <li>안드로이드 : Play스토어 &quot;대구전자도서관&quot; 검색 후 내려받기</li>
  </ul>
  <h4 class="contSTit_line">지역 도서관 중 회원가입 도서관 선택 후 회원 인증하기</h4>
  <ul class="con">
    <li>회원 가입 도서관 선택 후 회원 인증하기</li>
  </ul>
  <h4 class="contSTit_line">내 손안에서 다양한 도서관 서비스 이용하기 </h4>
  <ul class="con">
    <li>전자책 및 오디오북 이용하기<br>
    </li>
    <!--li>도서관 안내, 예약 희망 도서 신청<br>
    </li>
    <li>대출현황 대출이력 조회 서비스<br>
    </li>
    <li>도서관 소장도서의 통합검색<br>
    </li
    <li>모바일회원증으로 도서 대출 (도서회원증 없이도 대출 가능)</li>
  </ul> -->
  <h3 class="contTit_line">구독형 전자자료 서비스 이용 방법</h3>
  <h4 class="contSTit_line">접속방법</h4>
  <ul class="con">
    <li>웹(PC, 모바일, 태블릿) : 대구전자도서관 홈페이지 접속 → 로그인 → 구독형 전자책 선택 → 도서검색 후 대출</li>
    <li>모바일 앱 : 스토어에서 부커스 다운로드 → 기관선택에서 대구전자도서관 검색 → 도서관 아이디, 패스워드로 로그인 후 이용</li>
    <!-- <li>웹(PC, 모바일, 태블릿) : 대구전자도서관 홈페이지 접속 → 로그인 → 구독형 전자책 선택 → 도서검색 후 대출</li>
    <li>모바일 앱 : 스토어에서 교보문고전자도서관 다운로드 → 도서관찾기에서 대구전자도서관 검색 → 도서관 아이디, 패스워드로 로그인 후 이용</li> -->
  </ul>
  <h4 class="contSTit_line">대출권수</h4>
  <ul class="con">
    <li>14권 / 달</li>
  </ul>
  <h4 class="contSTit_line">대출기간</h4>
  <ul class="con">
    <li>15일(대출일 포함)</li>
  </ul>
  <h4 class="contSTit_line">대출반납</h4>
  <ul class="con">
    <li>대출기간 만료 시 자동 반납(수동 반납 불가능)</li>
  </ul>
</c:if>

<!--서부-->
<c:if test="${homepage.context_path eq 'seobu'}">
	<div class="dpt-intro-type02">
	  <div class="role-head">
		<div class="ImgBox">
			<img src="/resources/homepage/dgportal/img/sv_top_img06.jpg" alt="" org_width="620" org_height="280" isinit="true" class="vis-img">
		</div>
		<div class="role-head-tit">
		  <div class="txtBox">
			<h3 class="ptit">대구전자도서관</h3>
			<span class="ptitEng">대구시민의 스마트한<br>독서생활이 시작되는 곳</span>
				<p class="center">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="http://library.daegu.go.kr/elib/index.do" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank">
					</c:when>
					<c:otherwise>
						<!--a href="javascript:void(0);" onclick="alert('로그인후 이용바랍니다.'); location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=4';" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"-->
						<!-- <a href="javascript:void(0);" onclick="alert('대구전자도서관 이관 작업으로 서비스가 일시중지됩니다. 2020.3.16. 00:00 ~ 2020.3.17. 24:00'); return false;" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"> -->
						<a href="http://library.daegu.go.kr/elib/index.do" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank">
					</c:otherwise>
				</c:choose>
				<span>대구전자도서관 바로가기</span><span class="ico ico_link"></span><i class="fa fa-external-link"></i></a></p>
			</div>
		</div>
	  </div>
	  <div class="role-body center">
		<p class="tit">대구지역 공공도서관 회원이면 누구나 이용할 수 있는 대구전자도서관입니다.</p>
		<p>현재 이용가능 콘텐츠는 전자책, 오디오북, 이러닝, 국내학회지 원문DB, 음악라이브러리입니다.</p>
	  </div>
	  <h3 class="contTit_line">회원가입 및 절차</h3>
	  <ul class="con">
		<li>대구통합도서관 회원가입(통합회원인증)
		  <ul>
			<li>신규 : 통합회원가입, 기존 지역공공도서관 회원 : 통합회원인증</li>
		  </ul>
		</li>
		<!--li>공공도서관 홈페이지에서 회원 인증 후 개인정보 수집 및 이용 동의하기
		  <ul>
			<li>최초 방문 시 인증 한번으로 재 로그인부터는 자동 접속</li>
		  </ul>
		</li-->
		<li>대구전자도서관 홈페이지에서 전자책 및 오디오북 메뉴 클릭 후 이용하기 
		  <ul>
			<li>지역 공공도서관에 있는 전자책 및 오디오북 이용 가능</li>
		  </ul>
		</li>
	  </ul>
	</div>
	<div class="next_list1 item4">
    <ul>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list01.png"> </div>
        <span class="bottom_txt">대구통합도서관<br>
        회원가입</span> </li>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list02.png"> </div>
        <span class="bottom_txt">대구전자도서관에서<br>
        자료 검색</span> </li>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list03.png"> </div>
        <span class="bottom_txt">책 읽기 선택 후<br>
        리더기 설치 완료</span> </li>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list04.png"> </div>
        <span class="bottom_txt">나의도서관에서<br>
        책 읽기</span> </li>
    </ul>
  </div>
  <h3 class="contTit_line">대출규정(소장형)</h3>
  <ul class="con">
    <li>대출권수 : 전자책 3권, 오디오북 제한없음</li>
    <li>대출기간 : 8일(대출일포함)</li>
    <li>대출기간 : 대출기한 만료 시 자동반납(수동반납 가능)</li>
    <li>예약권수 : 2권<br>
    </li>
  </ul>
  <h3 class="contTit_line">구독형 전자자료 서비스 이용 방법</h3>
  <h4 class="contSTit_line">접속방법</h4>
  <ul class="con">
    <li>웹(PC, 모바일, 태블릿) : 대구전자도서관 홈페이지 접속 → 로그인 → 구독형 전자책 선택 → 도서검색 후 대출</li>
    <li>모바일 앱 : 스토어에서 부커스APP 다운로드 → 기관선택창에서 대구전자도서관 입력 후 선택 → 도서관 아이디, 패스워드로 로그인 후 이용</li>
  </ul>
  <h4 class="contSTit_line">대출권수</h4>
  <ul class="con">
    <li>14권 / 월</li>
  </ul>
  <h4 class="contSTit_line">대출기간</h4>
  <ul class="con">
    <li>15일(대출일 포함)</li>
  </ul>
  <h4 class="contSTit_line">대출반납</h4>
  <ul class="con">
    <li>대출기간 만료 시 자동 반납(수동 반납 불가능)</li>
  </ul>
</c:if>

<!--두류-->
<c:if test="${homepage.context_path eq 'duryu'}">
	<div class="dpt-intro-type02">
	  <div class="role-head">
		<div class="ImgBox">
			<img src="/resources/homepage/dgportal/img/sv_top_img06.jpg" alt="" org_width="620" org_height="280" isinit="true" class="vis-img">
		</div>
		<div class="role-head-tit">
		  <div class="txtBox">
			<h3 class="ptit">대구전자도서관</h3>
			<span class="ptitEng">대구시민의 스마트한<br>독서생활이 시작되는 곳</span>
				<p class="center">
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<a href="http://library.daegu.go.kr/elib/index.do" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank">
					</c:when>
					<c:otherwise>
						<!--a href="javascript:void(0);" onclick="alert('로그인후 이용바랍니다.'); location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=4';" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"-->
						<!-- <a href="javascript:void(0);" onclick="alert('대구전자도서관 이관 작업으로 서비스가 일시중지됩니다. 2020.3.16. 00:00 ~ 2020.3.17. 24:00'); return false;" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"> -->
						<a href="http://library.daegu.go.kr/elib/index.do" class="btn_link03 newWin mg10t" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank">
					</c:otherwise>
				</c:choose>
				<span>대구전자도서관 바로가기</span><span class="ico ico_link"></span><i class="fa fa-external-link"></i></a></p>
			</div>
		</div>
	  </div>
	  <div class="role-body center">
		<p class="tit">대구지역 공공도서관 회원이면 누구나 이용할 수 있는 대구전자도서관입니다.</p>
		<p>현재 이용가능 콘텐츠는 전자책, 오디오북, 이러닝, 국내학회지 원문DB, 음악라이브러리입니다.</p>
	  </div>
	  <h3 class="contTit_line">회원가입 및 절차</h3>
	  <ul class="con">
		<li>대구시 공립도서관 통합회원 가입(통합회원인증)
		  <ul>
			<li>신규 : 통합회원가입, 기존 지역공공도서관 회원 : 통합회원인증</li>
		  </ul>
		</li>
		<!--li>공공도서관 홈페이지에서 회원 인증 후 개인정보 수집 및 이용 동의하기
		  <ul>
			<li>최초 방문 시 인증 한번으로 재 로그인부터는 자동 접속</li>
		  </ul>
		</li-->
		<li>대구전자도서관 홈페이지에서 전자책 및 오디오북 메뉴 클릭 후 이용하기 
		  <ul>
			<li>지역 공공도서관에 있는 전자책 및 오디오북 이용 가능</li>
		  </ul>
		</li>
	  </ul>
	</div>
  <h3 class="contTit_line">구독형 전자자료 </h3>
  <ul class="con">
  	<li>서비스대상 : 전자책, 오디오북</li>
    <li>서비스종수 : 62천종
      <ul>
        <li style="background:none;">※ 예약 대기 없이 언제든 대출가능, 매달 신간 업데이트</li>
      </ul>
    </li>
    <li>대출권수 및 기간 : 1인 7권 / 15일
      <ul>
        <li style="background:none;">※ 수동 반납 불가, 대출기간 만료 시 자동 반납</li>
      </ul>
    </li>
    <li>이용방법 
      <ul>
        <li style="font-size:14px;"><b style="color:#00a459">웹 :</b> 대구전자도서관(<a href="https://library.daegu.go.kr/elib" target="_blank" style="font-size:13px;color:#0097cf;">https://library.daegu.go.kr/elib</a>) 접속 / 로그인 / 구독형 전자책(구독형 전자도서관 웹으로 연결·자동로그인) / 도서 검색·대출 후 읽기</li>
        <li style="font-size:14px;"><b style="color:#ff9600">앱 :</b> 부커스 전자도서관 앱 다운로드 / 도서관 선택(대구전자도서관) / 로그인(대구전자도서관 웹과 아이디, 비밀번호 동일) / 도서 검색·대출 후 읽기</li>
		<li style="background:none;">※ 대구공공도서관 통합회원이면 대구전자도서관 이용 가능</li>
      </ul>
    </li>
  </ul>

  <h3 class="contTit_line">소장형 전자자료</h3>
  <ul class="con">
  	<li>서비스대상 : 전자책, 오디오북, 이러닝 강좌 등</li>
    <li>서비스종수 : 전자책 21천종, 오디오북 8백종, 이러닝 235강좌 
      <ul>
        <li>전자책 보유 점수 내에서 대출(모든 도서 대출 시 예약 대기), 매분기 신간 구입 </li>
      </ul>
    </li>
    <li>대출권수 및 기간 
      <ul>
        <li>전자책 : 1인 3권 8일 <br />※ 대출기간 만료시 자동 반납, 언제든 수동 반납 가능</li>
		<li>오디오북 : 제한없음</li>
      </ul>
    </li>
    <li>이용방법
      <ul>
        <li style="font-size:14px;"><b style="color:#00a459">웹 :</b> 대구전자도서관(<a href="https://library.daegu.go.kr/elib" target="_blank" style="font-size:13px;color:#0097cf;">https://library.daegu.go.kr/elib</a>) 접속 / ID, 비밀번호로 로그인 / 도서 검색·대출 후 읽기
        <!-- <li style="font-size:14px;"><b style="color:#ff9600">앱 :</b> 대구전자도서관 앱 다운로드 / 설정 / E-BOOK 계정인증(가입도서관, 이름, 아이디) / 도서 검색·대출 후 책읽기</li> -->
      </ul>
    </li>
  </ul>

  <h4 class="contSTit_line">문의 : 대구시립중앙도서관 도서관정책과(☎231-2037, 2039)</h4>
</c:if>

<!--달성-->
<c:if test="${homepage.context_path eq 'dalseong'}">
	<ul class="btns_wrap_tac">
	  <li>
	  <a href="https://dgelib.dkyobobook.co.kr/main.ink" class="btn_link02 newWin" title="학생전자도서관 바로가기(새창열림)" target="_blank"><span>학생전자도서관 바로가기</span><span class="ico ico_link"></span><i class="fa fa-external-link"></i></a>
	  </li>
	</ul>
</c:if>

<c:choose>
	<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
		<c:choose>
			<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
			</c:when>
			<c:otherwise>
				<c:set var="libCode" value="${sessionScope.member.user_no}"/>
				<form id="goEbookTest" action="https://real.e-lib.tglnet.or.kr/elib_sso.asp" method="post" accept-charset="utf-8">
					<c:if test="${homepage.context_path eq 'jungang' or homepage.context_path eq 'dgportal'}">
						<input type="hidden"  name="lib_code" value="122004" />
					</c:if>
					<c:if test="${homepage.context_path eq 'dongbu'}">
						<input type="hidden"  name="lib_code" value="122010" />
					</c:if>
					<c:if test="${homepage.context_path eq 'seobu'}">
						<input type="hidden"  name="lib_code" value="122008" />
					</c:if>
					<c:if test="${homepage.context_path eq 'nambu'}">
						<input type="hidden"  name="lib_code" value="122009" />
					</c:if>
					<c:if test="${homepage.context_path eq 'bukbu'}">
						<input type="hidden"  name="lib_code" value="122003" />
					</c:if>
					<c:if test="${homepage.context_path eq 'duryu'}">
						<input type="hidden"  name="lib_code" value="122002" />
					</c:if>
					<c:if test="${homepage.context_path eq 'suseong'}">
						<input type="hidden"  name="lib_code" value="122007" />
					</c:if>
					<c:if test="${homepage.context_path eq 'dalseong'}">
						<input type="hidden"  name="lib_code" value="122011" />
					</c:if>
					<c:if test="${homepage.context_path eq '228'}">
						<input type="hidden"  name="lib_code" value="122001" />
					</c:if>
					<c:if test="${homepage.context_path eq '228lib'}">
						<input type="hidden"  name="lib_code" value="127058" />
					</c:if>
					
					<input type="hidden"  name="user_id" value="${sessionScope.member.member_id}" />
					<input type="hidden"  name="name" value="${sessionScope.member.member_name}" />
					<input type="hidden"  name="next" value="default" />
				</form>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<script>
	$(function() {

		$('#e_lib_go').on('click', function(){
			<c:choose>
				<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
					<c:choose>
						<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
							alert('정회원만 이용가능합니다.');
							return false;
						</c:when>
						<c:otherwise>
							$('#goEbookTest').submit();
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					alert('로그인후 이용가능합니다.'); location.href='/${homepage.context_path}/intro/login/index.do?menu_idx=4';
					return false;
				</c:otherwise>
			</c:choose>
		});

	});
</script>



