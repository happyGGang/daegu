<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
        <div class="summaryDesc">
          <div class="innerBox">
            <div class="img txt_b02"></div>
            <div class="desc">
              <h3>DBpia 전자저널</h3>
              <p>두류도서관에서는 지역민의 활발한 학습활동과 연구활동 지원을 위하여<br />4,000여종의 저널과 학술논문 300여만편 등을 제공하는 DBpia 전자저널 서비스를 제공합니다.</p>
              <ul class="btns_wrap_tac">
                <li>
                  <a href="https://www.dbpia.co.kr/" class="btn_link02" title="DBpia 전자저널 바로가기(새창열림)"
                    target="_blank"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
                </li>
                <!-- <li>
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원(대출회원) 전용입니다.');" class="btn_link02"  title="DBpia 전자저널 바로가기(새창열림)"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<script type="text/javascript" src="https://www.dbpia.co.kr/js/dbpia_outConn.js"></script>
								<a href="javascript:dbpia_open('1856');" class="btn_link02"  title="DBpia 전자저널 바로가기(새창열림)"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="alert('로그인후 이용가능합니다.'); location.href='http://library.daegu.go.kr/duryu/intro/login/index.do?menu_idx=4&before_url=/duryu/html/dbpia.do?menu_idx=144';" class="btn_link02"  title="DBpia 전자저널 바로가기(새창열림)"><span>DBpia 전자저널 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>
			</li> -->
              </ul>
            </div>
          </div>
        </div>

        <ul class="con">
          <li><strong>관내 이용 방법</strong>
            <ul>
              <li>관내 PC에서 위의 DBpia 전자저널 바로가기 버튼을 클릭하면 자동 인증되어 원문 검색 및 열람 가능</li>
              <li>본인 스마트기기에서 도서관 와이파이를 이용하여 DBpia 전자저널에 접속하면 자동 인증되어 원문 검색 및 열람 가능</li>
            </ul>
          </li>
          <li><strong>관외 이용 방법(PC 및 스마트기기)</strong>
            <ul class="con2">
              <li>도서관 내에서 인증 후 관외에서 이용 가능
                <ul class="con3">
                  <li>① 관내 PC로 DBpia에 접속하여 본인 DBpia 계정으로 로그인</li>
                  <li>② '대구광역시립두류도서관 인증완료' 확인 (※1회 인증 시 90일간 유효)</li>
                  <li>③ 관외 PC 및 스마트기기에서 DBpia에 접속하여 로그인</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>