<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="dpt-intro-type02">
  <div class="role-head">
    <div class="ImgBox"> <img src="/resources/homepage/dgportal/img/sv_top_img06.jpg" alt="" org_width="620" org_height="280" isinit="true" class="vis-img"> </div>
    <div class="role-head-tit">
      <div class="txtBox">
        <h3 class="ptit">대구전자도서관</h3>
        <span class="ptitEng">대구시민의 스마트한<br>
        독서생활이 시작되는 곳</span>
		    <p class="center"><a href="javascript:void(0);" class="btn_link03 newWin mg10t" id="e_lib_go" title="대구전자도서관 홈페이지 바로가기(새창열림)" target="_blank"><span>대구전자도서관 바로가기</span><span class="ico ico_link"></span><i class="fa fa-external-link"></i></a></p>
		</div>
    </div>
  </div>
  <div class="role-body center">
    <p class="tit">대구지역 공공도서관 회원이면 누구나 이용할 수 있는 대구전자도서관입니다.</p>
    <p>현재 이용가능 콘텐츠는 전자책, 오디오북, 국내학회지 원문DB, 음악라이브러리입니다.</p>

  </div>
  <h3 class="contTit_line">회원가입 및 절차</h3>
  <ul class="con">
    <li>지역 공공도서관 도서회원로 가입하기
      <ul>
        <li>대구전자도서관에서 별도 회원가입 불가</li>
      </ul>
    </li>
    <li>공공도서관 홈페이지에서 회원 인증 후 개인정보 수집 및 이용 동의하기
      <ul>
        <li>최초 방문 시 인증 한번으로 재 로그인부터는 자동 접속</li>
      </ul>
    </li>
    <li>대구전자도서관 홈페이지에서 전자책 및 오디오북 메뉴 클릭 후 이용하기
      <ul>
        <li>지역 공공도서관에 있는 전자책 및 오디오북 이용 가능</li>
      </ul>
    </li>
  </ul>
  <div class="next_list1 item4">
    <ul>
      <li>
        <div class="top_img"> <img alt="" src="/resources/homepage/dgportal/img/elib_list01.png"> </div>
        <span class="bottom_txt">공공도서관 회원인증 후<br>
        개인정보 수집 이용 동의</span> </li>
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
  <h3 class="contTit_line">대출규정</h3>
  <ul class="con">
    <li>대출권수 : 1인당 전자책 3권, 오디오북 3권<br>
    </li>
    <li>대출기간 : 8일(대출기한이 지나면 자동 반납처리) 연기 없음<br>
    </li>
    <li>예약제한 : 1인당 2권<br>
    </li>
  </ul>
  <h3 class="contTit_line">모바일도서관 앱 이용 방법</h3>
  <h4 class="contSTit_line">대구전자도서관 앱 내려받기 </h4>
  <ul class="con">
    <li>아이폰 : 앱스토어 &quot;대구전자도서관&quot; 검색 후 내려받기<br>
    </li>
    <li>안드로이드 : Play스토어 &quot;대구전자도서관&quot; 검색 후 내려받기</li>
  </ul>
  <h4 class="contSTit_line">지역 도서관 중 회원가입 도서관 선택 후 회원 인증하기</h4>
  <ul class="con">
    <li>회원 가입 도서관 선택 후 회원 인증하기(미리 PC 화면애서 대구전자도서관 회원 인증 필요)</li>
  </ul>
  <h4 class="contSTit_line">내 손안에서 다양한 도서관 서비스 이용하기 </h4>
  <ul class="con">
    <li>전자책 및 오디오북 이용하기<br>
    </li>
    <li>도서관 안내, 예약 희망 도서 신청<br>
    </li>
    <li>대출현황 대출이력 조회 서비스<br>
    </li>
    <li>도서관 소장도서의 통합검색<br>
    </li>
    <li>모바일회원증으로 도서 대출 (도서회원증 없이도 대출 가능)</li>
  </ul>
</div>
</div>

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



