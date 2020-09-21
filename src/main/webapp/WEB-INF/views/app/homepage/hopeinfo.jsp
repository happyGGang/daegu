<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {

	<%-- 야간대출예약 신청제한 --%>
	$('a#service-noreq').on('click', function(e) {
		e.preventDefault();
		alert('비대면인증 회원은 서비스 이용이 불가능 하며 전자도서관만 이용가능 합니다.');
		return;
	});

});

</script>

<div class="summaryDesc">
  <div class="innerBox">
    <div class="img txt_b02"></div>
    <div class="desc">
      <h3>희망도서신청</h3>
      <p>우리도서관에서는 희망도서신청을 실시하고 있습니다. 신청하신 자료는 구입, 정리 후 이용자에게 제공 됩니다. </p>
      <ul class="btns_wrap_tac">
        <li>
			<c:choose>
				<c:when test="${sessionScope.member.user_class_code eq '016' || sessionScope.member.user_class_code eq '017'}">
					<a href="#" id="service-noreq" class="btn_link02"><span>희망도서신청 바로가기</span><span class="ico ico_link"></span></a>
				</c:when>
				<c:otherwise>
					<a  href="/${homepage.context_path}/intro/search/hope/req.do?menu_idx=27" class="btn_link02"  title="희망도서신청 바로가기"><span>희망도서신청 바로가기</span><span class="ico ico_link"></span></a>
				</c:otherwise>
			</c:choose>

		</li>
      </ul>
    </div>
  </div>
</div>
<div class="cont_wrap">
  <ul class="icon_type_list loans">
    <li class="icon1">
      <h3 class="tit">희망도서 신청안내</h3>
      <ul class="con">
        <li><strong>신청자격</strong> : 우리 도서관 관외대출회원</li>
        <li><strong>희망도서 수합 및 구입여부 결정</strong> : 월 2회(1일, 16일경)</li>
        <li><strong>반영권수</strong> : 1인 월2권(연20권, 신청권수가 많을 경우 신청한 순서대로 구입결정)</li>
        <li><strong>대상자료</strong> : 국내서 단행본</li>
      </ul>
    </li>
    <li class="icon2">
      <h3 class="tit">희망도서 선정 제외 내용</h3>
      <ul class="con">
        <li> 국외서, 정기간행물, 전자자료, 시청각자료 </li>
        <li> 도서관 소장자료, 구입·정리 중인 자료, 품절 및 절판 된 자료 </li>
        <li> 서지사항이 불명확한 자료, 시리즈(3권 이상), 전집, 문제집, 수험서, 중고생 참고서, 워크북, 악보집 </li>
        <li> 출판된 지 3년 이상 된 자료 (단, 컴퓨터, 과학 분야는 출판된 지 2년 이상 된 자료) </li>
        <li> 판타지 소설, 로맨스 소설, 무협 소설, 인터넷 소설, 라이트노벨, 만화 </li>
        <li> 고가(50,000원 이상)의 자료 </li>
        <li> 특정 출판사 및 저자의 자료만 집중적으로 신청한 경우 </li>
        <li> 특정 종교 및 단체의 관련 자료를 집중적으로 신청한 경우 </li>
        <li> 청소년 유해도서 등 공공도서관 자료로 부적합하다고 판단되는 자료 </li>
        <li> 희귀자료, 기관발간물(비매품) 등 정상적인 유통경로로 구입이 어려운 자료 </li>
        <li> 자료의 물리적 형태(포켓사이즈형, 카드형, 병풍형, 스프링형 등)가 도서관 자료로 부적합한 경우 </li>
        <li> 신판이 출판된 구판도서 </li>
        <li> 기타 공공도서관 소장 자료로 부적합하다고 판단되는 자료 </li>
      </ul>
    </li>
    <li class="icon4">
      <h3 class="tit">희망도서 처리과정</h3>
      <ul class="con">
        <li><strong>신청중</strong> : 자료 신청중인 상태(담당자 검토 전)</li>
        <li><strong>처리중</strong> : 자료를 구입중인 상태</li>
        <li><strong>소장중</strong> : 자료실에 비치된 상태</li>
        <li><strong>취소됨</strong> : 구입에서 제외된 상태(희망도서명을 클릭하면 취소사유 확인가능)</li>
      </ul>
    </li>
    <li class="icon3">
      <h3 class="tit">신청결과</h3>
      <ul class="con">
        <li>홈페이지에서 확인 가능하며 비치 후 SMS로 안내</li>
        <li>희망도서 비치 후 해당도서 신청자에게 3일간 대출 우선권 부여<br>
          ※ 단, 연체 중인 경우는 대출이 되지 않으며, 다른 이용자가 먼저 대출 가능</li>
        <li>※ 문화센터 작은도서관 희망도서 신청은 문화센터 작은도서관(053-231-1344)으로 문의하시기 바랍니다.</li>
        <li>※ 희망도서 신청 시 휴대폰번호를 반드시 적어주세요.</li>
      </ul>
    </li>
  </ul>
</div>
