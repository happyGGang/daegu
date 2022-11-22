<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="boardTag" uri="/WEB-INF/config/tld/boardTag.tld"%>

<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub_libculture.css"/>
<link rel="stylesheet" type="text/css" href="/resources/homepage/libculture/css/sub-form-reset.css"/>
<div class="product-detail">
  <div class="detail">
    <div class="detail__header detail_header-place">
      <div class="detail_flags">
        <span class="detail_flag">기타문화공간</span>
      </div>
      <p class="detail_title">${cultureOne.name}</p>

    </div>
    <div class="detail_group detail_group--place">
      <div class="detail__thumnail">
        <img class="detail__img" src="/assets/images/main/noimg_600_old.jpg" onError="src='http://211.224.118.223:8010/resources/homepage/libculture/img/book_noimg.png'" alt="기타문화공간"/>
      </div>
      <dl class="detail__info">
        <dt>주소</dt>
        <dd>${cultureOne.address}</dd>
        <dt>전화번호</dt>
        <dd>${cultureOne.tel}</dd>
        <dt>홈페이지</dt>
        <dd>
          <a href="${cultureOne.url}" target="_blank" title="${i.name} 관련사이트 새창 이동" class="font--green">${cultureOne.url}</a>
        </dd>
        <dt>휴관일</dt>
        <dd>${cultureOne.etc}</dd>
        <dt>시설소개</dt>
        <dd>${cultureOne.contents}</dd>
      </dl>
    </div>
  </div>
</div>

<div class="detailContent">

  <h3>상세안내</h3>

  <div class="">
    <table class="edit content-tbl">
      <tbody>
      <tr>
        <th class="content-tbl-th">행사장명</th>
        <td class="content-tbl-td">국립고궁박물관 고궁뜨락</td>
      </tr>
      <tr>
        <th class="content-tbl-th">주소</th>
        <td class="content-tbl-td">서울특별시 종로구 효자로 12 </td>
      </tr>
      <tr>
        <th class="content-tbl-th">전화번호</th>
        <td class="content-tbl-td">02-720-0486</td>
      </tr>
      <tr>
        <th class="content-tbl-th">홈페이지</th>
        <td class="content-tbl-td">https://www..go.kr</td>
      </tr>
      </tbody>
    </table>

    <!-- 지도 -->
    <div class="map map_wrap" >
      <input type="hidden" id="cul_gps_y" name="cul_gps_y" value="37.57659026675304"/>
      <input type="hidden" id="cul_gps_x" name="cul_gps_x" value="126.97497029731278"/>
      <input type="hidden" id="contentVenue" name="contentVenue" value="국립고궁박물관 고궁뜨락"/>
      <input type="hidden" id="contentAddr" name="contentAddr" value="서울특별시 종로구 효자로 12 고궁뜨락"/>
      <div id="map" class="map__inner" style="width:100%;height:400px;"></div>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=707a1b8df7e9f80807c2386e6f431d97"></script>
    <script type='text/javascript'>
      var settingMapOption = function (culGpsY, culGpsX, contentVenue, map) {
        //=================================지도 확대 축소=============================================
        //일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
        // var mapTypeControl = new daum.maps.MapTypeControl();
        //
        // // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
        // // daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
        // map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

        // // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
        // var zoomControl = new daum.maps.ZoomControl();
        // map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
        //=================================지도 확대 축소=============================================

        //=================================지도 마커=============================================
        // 마커 이미지의 이미지 주소입니다
        var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

        // 마커 이미지의 이미지 크기 입니다
        var imageSize = new daum.maps.Size(24, 35);

        // 마커 이미지를 생성합니다
        var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize);

        // 마커를 생성합니다
        var marker = new daum.maps.Marker({
          map: map, // 마커를 표시할 지도
          position: new daum.maps.LatLng(culGpsY, culGpsX), // 마커를 표시할 위치
          title : contentVenue, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
          image : markerImage // 마커 이미지
        });
        //=================================지도 마커=============================================

        //=================================광화문에서 위치 이동=============================================
        // 이동할 위도 경도 위치를 생성합니다
        var moveLatLon = new daum.maps.LatLng(culGpsY, culGpsX);

        // 지도 중심을 이동 시킵니다
        map.setCenter(moveLatLon);
        //=================================광화문에서 위치 이동=============================================
      };

      //map출력
      var settingMap = function () {
        var culGpsY = $('#cul_gps_y').val();
        var culGpsX = $('#cul_gps_x').val();
        var contentVenue = $('#contentVenue').val();
        var contentAddr = $('#contentAddr').val();

        //=================================지도 생성=============================================
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div

                mapOption = {
                  // 지도의 중심좌표
                  center: new daum.maps.LatLng(37.576073, 126.976923),
                  level: 3 // 지도의 확대 레벨
                };

        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        var map = new daum.maps.Map(mapContainer, mapOption);
        //=================================지도 생성=============================================

        if(culGpsY == '' || culGpsY == '0.0'){
          //위도, 경도가 없을 경우 주소명으로 위도, 경도 찾기
          // 주소-좌표 변환 객체를 생성합니다
          var geocoder = new daum.maps.services.Geocoder();

          geocoder.addressSearch(contentAddr, function(result, status) {
            if (status === daum.maps.services.Status.OK) {
              culGpsY = result[0].y;
              culGpsX = result[0].x;

              settingMapOption(culGpsY, culGpsX, contentVenue, map);
            }else{
              $('#map').hide();
              return false;
            }
          });
        }else{
          settingMapOption(culGpsY, culGpsX, contentVenue, map);
        }
      };

      settingMap();
    </script>
    <!-- 지도 -->

  </div>
  <!-- 위치정보 : E -->

  <div class="buttons">
    <a href="" class="btn btn1">뒤로</a>
  </div>
</div>