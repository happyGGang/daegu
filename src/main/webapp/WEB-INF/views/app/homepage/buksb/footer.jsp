<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
  function moveToLibrary() {
    const librarySelect = document.getElementById('selectLang');
    const selectedText =
      librarySelect.options[librarySelect.selectedIndex].text;
    const selectedValue = librarySelect.value;

    if (selectedText === '도서관 바로가기') {
      alert('도서관을 선택해주세요.');
      return;
    }

    if (selectedValue) {
      window.open(selectedValue, '_blank', 'noopener,noreferrer');
    } else {
      alert('도서관을 선택해주세요.');
    }
  }
  function moveToOrgan() {
    const selectElement = document.getElementById('organ');
    const selectedText =
      selectElement.options[selectElement.selectedIndex].text;
    const selectedValue = selectElement.value;

    if (selectedText === '관련기관 바로가기') {
      alert('기관을 선택해주세요.');
      return;
    }

    if (selectedValue) {
      window.open(selectedValue, '_blank', 'noopener,noreferrer');
    } else {
      alert('기관을 선택해주세요.');
    }
  }
</script>

<script>
    $(document).ready(function () {
        $('.scroll_top').click(function (event) {
            event.preventDefault();

            if ($(window).width() < 1025) {
                $('html, body').animate({ scrollTop: 0 }, 500);
            } else {
                if (typeof fullpage_api !== 'undefined' && typeof fullpage_api.moveTo === 'function') {
                    fullpage_api.moveTo(1);
                } else {
                    console.warn('fullpage_api.moveTo 함수가 정의되지 않았습니다.');
                }
            }
        });
    });
</script>



<div class="mFooter">
	<div class="scroll_top">
		<img alt="scroll-top" src="/resources/homepage/${homepage.context_path}/img/arrow-up.png" />
	</div>
  <div class="footer_top">
    <div class="info">
      <div>
        <a href="/${homepage.context_path}/html.do?menu_idx=88"
          ><b style="color: #ffd147">개인정보처리방침</b></a
        >
      </div>
      <div>
        <a href="/${homepage.context_path}/html.do?menu_idx=90"
          >영상정보처리방침</a
        >
      </div>
      <div>
        <a href="/${homepage.context_path}/html.do?menu_idx=91"
          >도서관서비스헌장</a
        >
      </div>
    </div>
  </div>

  <div class="footer_bottom">
    <div class="footer_bottom_text_wrapper">
      <div>
        41447 대구 북구 서변로3길 54 (서변동, 무태조야동
        복합문화시설)&nbsp;&nbsp;&nbsp;<br>전화<span> 053-320-5120</span>&nbsp;&nbsp;&nbsp;팩스 <span
          >053-327-1553</span
        >
      </div>
      <div>Copyright © 대구서변숲도서관.All rights reserved.</div>
    </div>
    <div class="select_box_wrapper">
      <div class="select_box">
        <select id="selectLang" name="selectLang" onchange="changeLang()">
          <option>도서관 바로가기</option>
          <option value="http://library.daegu.go.kr/dgportal/index.do">
            대구광역시통합도서관
          </option>
          <option value="http://library.daegu.go.kr/228/index.do">
            대구2ㆍ28기념학생도서관
          </option>
          <option value="http://library.daegu.go.kr/228lib/index.do">
            대구2ㆍ28민주운동기념회관
          </option>
          <option value="http://library.daegu.go.kr/gukbo/index.do">
            국채보상운동기념도서관
          </option>
          <option value="http://library.daegu.go.kr/nambu/index.do">
            남부도서관
          </option>
          <option value="http://library.daegu.go.kr/dalseong/index.do">
            달성도서관
          </option>
          <option value="http://library.daegu.go.kr/dongbu/index.do">
            동부도서관
          </option>
          <option value="http://library.daegu.go.kr/duryu/index.do">
            두류도서관
          </option>
          <option value="http://library.daegu.go.kr/bukbu/index.do">
            북부도서관
          </option>
          <option value="http://library.daegu.go.kr/gw/index.do">
            삼국유사군위도서관
          </option>
          <option value="http://library.daegu.go.kr/seobu/index.do">
            서부도서관
          </option>
          <option value="http://library.daegu.go.kr/suseong/index.do">
            수성도서관
          </option>

          <option value="http://library.daegu.go.kr/namdm/index.do">
            남구대명어울림도서관
          </option>
          <option value="http://library.daegu.go.kr/namic/index.do">
            남구이천어울림도서관
          </option>
          <option value="http://library.daegu.go.kr/dalseolib/index.do">
            달서구통합도서관
          </option>
          <option value="http://library.daegu.go.kr/dalseonglib/index.do">
            달성군립도서관
          </option>
          <option value="http://library.daegu.go.kr/center/index.do">
            대구혁신도시복합문화센터
          </option>
          <option value="http://library.daegu.go.kr/donggu/index.do">
            동구통합도서관
          </option>
          <option value="http://library.daegu.go.kr/bukgs/index.do">
            북구구수산도서관
          </option>
          <option value="http://library.daegu.go.kr/bukdh/index.do">
            북구대현도서관
          </option>
          <option value="http://library.daegu.go.kr/buktj/index.do">
            북구태전도서관
          </option>
		  <option value="https://library.daegu.go.kr/buksb/index.do">
            북구서변숲도서관
          </option>
          <option value="http://library.daegu.go.kr/seogulib/index.do">
            서구통합도서관
          </option>
          <option value="http://library.daegu.go.kr/beomeo/index.do">
            수성구범어도서관
          </option>
          <option value="http://library.daegu.go.kr/yonghak/index.do">
            수성구용학도서관
          </option>
          <option value="http://library.daegu.go.kr/gosan/index.do">
            수성구고산도서관
          </option>
          <option value="http://library.daegu.go.kr/junggu/index.do">
            중구통합도서관
          </option>
        </select>
        <div class="move" onclick="moveToLibrary()">이동</div>
      </div>
      <div class="select_box">
        <select id="organ">
          <option>관련기관 바로가기</option>
          <c:forEach items="${recommendSiteList}" var="i">
            <option value="${i.link_target}">${i.recommend_site_name}</option>
          </c:forEach>
        </select>
        <div class="move" onclick="moveToOrgan()">이동</div>
      </div>
    </div>
  </div>
</div>
