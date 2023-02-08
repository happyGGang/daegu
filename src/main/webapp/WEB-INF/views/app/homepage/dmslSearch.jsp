<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="doc-body">
  <div class="roomicon">
	<div class="inner icowrap"><span class="ico ico10"></span> <strong>산격청사 이동도서관(직원전용)</strong>
	  <p>산격청사 직원 중 시청 작은도서관 회원으로 가입한 자를 대상으로 서비스합니다.</p>
	  <p class="basic_btn">
		<c:choose>
			<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
				<c:choose>
					<c:when test="${sessionScope.member.user_class_code eq '701'}">
						<a href="/dmsl/intro/search/index.do?menu_idx=9" class="btn_go" target="_blank" title="새창열림"><span>이동도서관 검색 바로가기</span></a>
					</c:when>
					<c:otherwise>
						<a href="#not" onclick="alert('직원전용 메뉴입니다.');" class="btn_go" target="_blank" title="새창열림"><span>이동도서관 검색 바로가기</span></a>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<a href="#not" onclick="alert('직원전용 메뉴입니다.');" class="btn_go" target="_blank" title="새창열림"><span>이동도서관 검색 바로가기</span></a>
	  		</c:otherwise>
		</c:choose>
	  </p>
	</div>
  </div>
  <h3>이동도서관 이용안내</h3>
  <div class="rsv-info"></div>
  <div class="auto-scroll">
	<table class="tbl-type01" summary="이동도서관 이용안내와 도서반납함 이용안내를 나타내는 표">
	  <caption>
	  이동도서관 이용안내
	  </caption>
	  <colgroup>
	  <col width="50%">
	  <col width="50%">
	  </colgroup>
	  <thead>
		<tr>
		  <th scope="col">이동도서관 이용안내</th>
		  <th scope="col">도서반납함 이용안내</th>
		</tr>
	  </thead>
	  <tbody>
		<tr>
		  <td class="left"><ul class="con">
			  <li><strong>이용절차 :</strong> 대출신청→승인(홈페이지확인)→대출</li>
			  <li><strong>신청마감 :</strong> 오전 11시, 이후 접수분 다음 개관일 대출 </li>
			  <li><strong>신청수량 :</strong> 1회 3권 이내(1인 최대 10권 대출가능)</li>
			  <li><strong>시간/장소 :</strong> 화, 목 15:00 ~ 17:00 / 101동 문서실 </li>
			</ul></td>
		  <td class="left"><ul class="con">
			  <li><strong>설치장소 :</strong> 산격청사  101동 문서실 내</li>
			  <li><strong>개방시간 :</strong> 상시</li>
			  <li><strong>수거시간 :</strong> 화, 목 15:00 ~ 17:00
			   <ul class="con2">
				<li>수거시간 이후 반납도서는 다음 개관일 반납 처리</li>
				<li>연체가 되지 않도록 본인의 반납예정일을 감안하여 미리 넣어주세요</li>
			 </ul></li>
			</ul></td>
		</tr>
	  </tbody>
	</table>
  </div>
  <h3>유의사항</h3>
  <ul class="con">
	<li>산격청사 직원 중 시청 작은도서관 회원으로 가입한 자를 대상으로 함<br>
	  ※ 회원이 아닌 경우, 이동도서관 방문(신분증 지참)하여 회원가입 가능 / 모바일회원증 발급</li>
	<li>지정된 시간(15:00 ~ 17:00), 장소(문서실)에 직접 본인이 방문하여 대출하여야 하며, 대출 시 회원증 필히 지참<br>
	  ※ 방문 전 본인의 신청도서 승인여부를 홈페이지에서 꼭 확인해주세요~!</li>
	<li>신청 전 신청도서의 &ldquo;소장여부 반드시 확인&rdquo;(자료검색), 소장 중인 도서만 신청 가능함</li>
	<li>신청을 희망하는 도서가 대출 중인 경우, 대출예약 신청(홈페이지에서 자료검색 후 &ldquo;예약&rdquo;버튼 클릭)</li>
	<li>신청을 희망하는 도서가 도서관에 없는 경우, 구입희망도서 신청(MY LIBRARY 희망도서 신청)</li>
	<li>신청한 도서가 다른 사람과 중복되는 경우, 신청 순서대로 대출(2순위부터는 자동예약 처리)<br>
	  ※ 예약·희망도서는 자료도착 문자통보 받은 다음날부터 예약 만료일까지 &ldquo;이동도서관 운영시간 중&rdquo; 대출 가능하며,<br>
	  1회 이동도서관 신청권수(3권)에 포함되지 않습니다.</li>
	<li>도서반납은 이동도서관 이용 시 반납 또는 101동 문서실 내 설치된 도서반납함 이용(문서함 반납 불가)</li>
	<li>지정된 방법 외 도서반납 시, 분실 또는 훼손된 도서는 도서관 규정의 의하여 동일책으로 변상해야 함</li>
	<li>신청도서를 사전 통보 없이 3회 이상 수령하지 않을 경우, 다음 이동도서관 이용권한이 1회 정지됨</li>
	<li>도서연체 시 반납한 날부터 연체일수만큼 대출이 정지됨</li>
  </ul>
  <h3>이용문의</h3>
  <ul class="con">
	<li>TEL : 053-803-6061</li>
  </ul>
</div>
