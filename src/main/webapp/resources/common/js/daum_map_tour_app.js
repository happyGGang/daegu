/** 
 * @File Name :  
 * @Description : 다음(DAUM) 지도 API를 이용한 문화관광용 처리용 
 * @Modification Information 
 * <pre> 
 * 수정일     | 수정자 | 수정내용 
 * 2015.12.29 | 박태공 | 최초 등록
 * 2018.07.05 : 박태고 : map_app객채를 다른 이름들로도 사용가능 하도록 생성자 작성.
 * 2018.07.30 : 박태공 : options에 click이벤트 property추가
 * 2018.08.01 : 박태공 : 지도 marker에 따른 bounds를 처리 할수 있도록 옵션 추가.
 * </pre> 
 * @author 
 * @since 2015.12.29
 * 
 * @Copyright (C) IACTS.CO.KR All rights reserved.
 * 
 *  
 *  <script>
 *  tour_map_app.init('map', options); 		//지도만 출력.
 *  tour_map_app.makeContent(map_datas);	//조도상에 표기항 레이어 처리 추가.
 *  </script>
 *  
 */
function map_app(){
	var _this = {
		options 	: {	
			level : 3, 
			use_init_marker : false,
			bounds : new daum.maps.LatLngBounds(), 		//지도 영역 maker에 따라 재설 정 처리용
			use_marker_click : true,					//마커 클릭이벤트 추가.						
			iw_template : function(data) {				// 단순 인포윈도우용 data값을 받아서 처리하는 콜백
				return '<div>' + data.address + '</div>';
			},
		    clusterer : function() { 
		    	return new daum.maps.MarkerClusterer({			//겹쳐지는 마커에 대한 클러스터 처리 사용여부
			    	map: _this.map, 		// 마커들을 클러스터로 관리하고 표시할 지도 객체 
			    	averageCenter: true, 	// 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			    	minLevel: 4 			// 클러스터 할 최소 지도 레벨 
			    });
		    }
		},
		datas		: [],
		infowins    : []
		
	};
	
	_this._overlay = new Array();
	
	/** 마커클릭이벤트 추가 */
	_this.marker_click = function ( marker, data ) {
		return ;
	};
	
	// 초기화함수, options에는 지도 옵션과, 기타 사용하는 옵션.
	// datas.위치자료.
	_this.init = function (id, options, datas) {
		// 옵션 확장
		$.extend(_this.options, options);
		//맵컨테이너 생성
		_this.container = id;
		
		// 기존 지도자료가 없을 경우 지도생성 있을경우 센터 처리.
		if ( !_this.options.map ) {
			//맵생성
			_this.map = new daum.maps.Map(document.getElementById(id), {
				level 	: _this.options.level,
				center 	: new daum.maps.LatLng(_this.options.x, _this.options.y)
			});
		} else {
			_this.map = map;
			_this.setCenter(_this.options.x, _this.options.y);
		}
		
		if ( _this.options.use_init_marker ){
			 var myMarker = new daum.maps.Marker({
			        map: _this.map, // 마커를 표시할 지도
			        position: new daum.maps.LatLng(_this.options.x, _this.options.y), // 마커를 표시할 위치
			        image : new daum.maps.MarkerImage(
			        		"/_res/portal/img/lib1tour3/ic100mapmarker1here1.png"
			        		, new daum.maps.Size(41, 44)),
			        zIndex  : 9999 
			 });
			 myMarker.setMap(_this.map);
		}

		//컨트롤 추가.
		_this.map.addControl(new daum.maps.MapTypeControl(), daum.maps.ControlPosition.TOPRIGHT);
		_this.map.addControl(new daum.maps.ZoomControl(), daum.maps.ControlPosition.RIGHT);
		
		if ( _this.options.clusterer ) {
			if ( typeof _this.options.clusterer == "function" ) {
				_this.options.clusterer = _this.options.clusterer();
				if ( !_this.options.clusterer._clusters ) {
					alert('map_app객체의 options.clusterer 옵션은 daum.maps.MarkerClusterer 객체를 반환하는 함수를 사용하여야 합니다.');
				}
			} else {
				alert('map_app객체의 options.clusterer 옵션은 daum.maps.MarkerClusterer 객체를 반환하는 함수 또는 oelean false값만 가능 합니다 ');
			}
		}
		
		
		//자료가 함께왔을 경우 팝업 컨턴츠 설정.
		if ( datas ) {
			_this.makeContent(datas);
		} else {
			_this.datas=[];
		}
		
	};
	
	/** 화면 리셋 */
	_this.resetMap = function(){
		_this.init(_this.container, _this.options);
	};
	/** 화면에 출력할 마커,창 설정 */
	_this.makeContent = function(map_datas){
		// 기존자료에 합쳐서 처리 합니다.
		_this.datas = _this.datas.concat(map_datas);
		
		for(var i=(_this.datas.length - map_datas.length); i < _this.datas.length; i++) {
			// POINT값이 존재하지 않을경우 address를 통해서 구하고 설정함 
			// 값을 구하지 못할 경우 undifinded 설정됨.
			_this.datas[i].point = _this.get_point(_this.datas[i].point, _this.datas[i].address);
			
			
			//포인트가 설정된 것들만 허용합니다.
			if ( _this.datas[i].point) {
			    var marker = new daum.maps.Marker({
			        map: _this.map, // 마커를 표시할 지도
			        position: new daum.maps.LatLng(_this.datas[i].point.x, _this.datas[i].point.y), // 마커를 표시할 위치
			        image : new daum.maps.MarkerImage(
			        		//"/tour/img/lib1cp2/list_ic_num" + (Number(i)+1) + ".png"
			        		"/resources/common/img/map/num0"+ ( i > 9 ? '' : '0' ) + (i+1) + ".png"
			        		, new daum.maps.Size(50, 40))
							//"https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"
							//, new daum.maps.Size(24,35))
			    });
			    
			    marker.setMap(_this.map);
			    
			    // 지도 범위재지정
			    if (  _this.options.bounds ) {
			    	_this.options.bounds.extend(marker.getPosition());
			    }
			    // 겹치는 마커용 클러스터러
			    if (  _this.options.clusterer ) {
			    	_this.options.clusterer.addMarker(marker);
			    }
			    //인포윈도우 템플릿이 있을 경우 처리
			    if ( _this.options.iw_template ) {
					var infowindow = new daum.maps.InfoWindow({
					    position : marker.getPosition(), 
					    //removable : true,
					    content :   _this.options.iw_template(_this.datas[i])
					});
					infowindow.open(_this.map, marker);
			    }
			  
			    //click 가 설정되어 있을 경우만 처리.
			    if ( _this.options.use_marker_click ){
			    	daum.maps.event.addListener(marker, 'click', (function(marker, data){
			    		return function(){
			    			_this.marker_click(marker, data);
			    		}
			    	})(marker, _this.datas[i]));
			    }
			}
		} //end for
		
		if ( _this.options.bounds ){
			_this.map.setBounds(_this.options.bounds);
		}
		
		
	};
	
	/** 화면에 처리할 창 관련 */
	_this.customLayoutTemplate = function(data){
		var infoStr = '<div class="map1layer1" >';
		infoStr += '<strong class="h1"><a href="'+ data.link +'" class="a1">' + data.title + '</a></strong>';
		infoStr += '<a href="#?close" onclick=\"jQuery(\'.map1layer1\').hide(); return false;" class="b1 close bsContain">닫기</a>';
		if ( data.image ) {
			infoStr += '<span class="f1"><span class="f1p1"><img src="' + (data.image.src ? data.image.src : '/tour/img/lib1cp2/noimage2.jpg') + '" width="100" height="80" alt="' + data.image.alt + '" /></span></span>';
		}
		infoStr += '<span class="wrap1texts">';
		infoStr += '<a class="a2">';
		if ( data.address != '' ){
			infoStr += '<i class="ic1 bsContain">주소</i>';
			infoStr += '<span class="t1">' + data.address + '</span></a>';
		}
		if ( data.tel != '' ){
			infoStr += '<div class="a3">';
			infoStr += '<i class="ic1 bsContain">전화</i>';
			infoStr += '<span class="t1">' + data.tel + '</span>';
			infoStr += '</div>'
		}
		infoStr += '</span></div>';
		return infoStr;
	};
	
	/** 센터로 이동 */
	_this.setCenter = function(x, y, address){
		var point = _this.get_point({x:x, y:y},address);
		if ( point ) {
			_this.map.setCenter(new daum.maps.LatLng(point.x, point.y));	
		} else {
			alert('지도에 표시할 수 없는 자료 입니다.');
		}
		
	};

	/** 현재 로케이션 설정 처리 */
	_this.setLocation = function(callback){
		if(!confirm('현재 정보를 사용하고자 합니다. 동의하십니까?')){
			return false;
		}else{
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
			        
					var lat = position.coords.latitude, // 위도
			            lon = position.coords.longitude; // 경도
			        
					_this.setCenter(lat, lon);
			            
					var imageNowSrc = "/tour/img/lib1cp2/ic4map1marker1now.png"; 
					var imageNowSize = new daum.maps.Size(41, 44); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerNowImage = new daum.maps.MarkerImage(imageNowSrc, imageNowSize); 
				    
				    var markerNow = new daum.maps.Marker({
				        map: _this.map, // 마커를 표시할 지도
				        position: new daum.maps.LatLng(lat, lon), // 마커를 표시할 위치
				        image : markerNowImage // 마커 이미지
				    });
					
				    
				    var geocoder = new daum.maps.services.Geocoder();
					
				    // 좌표로 법정동 상세 주소 정보를 요청합니다
				    geocoder.coord2detailaddr(_this.map.getCenter(), function(status, result) {
				    	if (status === daum.maps.services.Status.OK) {
				    		// 경우에 따라서 지번/도로명 주소를 못가오는 경향이 있네요.
				    		var detailAddr = !!result[0].roadAddress.name ? result[0].roadAddress.name: '';
				    		if ( callback ) {
				    			callback(detailAddr);
				    		}
				            //$("#nowLocationAddr").val(detailAddr);
				        }
				    });
			     });
			}else{
				alert("현재위치를 사용할 수 없습니다.");
				return false;
			}
		}
	};
	/** 
	 * 포인트와 주소를 받아서 포인트가 있을 경우 포인트를 그대로 넘겨주고 없을 경우 조소를 이용하여 포인트를 넘겨줍니다.
	 */
	_this.get_point = function(point,address){
		if ( point.x != '' && point.y != '') {
			return point;
		} else if ( address != '' ){
			//주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			// 주소로 좌표를 검색합니다
			return geocoder.addr2coord(address, function(status, result) {
			    // 정상적으로 검색이 완료됐으면 
			     if (status === daum.maps.services.Status.OK) {
			        return {x:result.addr[0].lat, y:result.addr[0].lng};
			     }
			});
		}
	};
	
	_this.drawRadius = function(len){
		var drawingFlag = false; // 원이 그려지고 있는 상태를 가지고 있을 변수입니다
		var centerPosition = new daum.maps.LatLng(_this.options.x, _this.options.y); // 원의 중심좌표 입니다
		var drawingCircle; // 그려지고 있는 원을 표시할 원 객체입니다
		var drawingOverlay; // 그려지고 있는 원의 반경을 표시할 커스텀오버레이 입니다
		var drawingDot; // 그려지고 있는 원의 중심점을 표시할 커스텀오버레이 입니다
		var circles = []; // 클릭으로 그려진 원과 반경 정보를 표시하는 선과 커스텀오버레이를 가지고 있을 배열입니다
		
	 	// 그려지고 있는 원을 표시할 원 객체를 생성합니다
	    if (!drawingCircle) {                    
	        drawingCircle = new daum.maps.Circle({ 
	            strokeWeight: 1, // 선의 두께입니다
	            strokeColor: '#00a0e9', // 선의 색깔입니다
	            strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	            strokeStyle: 'solid', // 선의 스타일입니다
	            fillColor: '#00a0e9', // 채우기 색깔입니다
	            fillOpacity: 0.2 // 채우기 불투명도입니다 
	        });     
	    }
	 	
	 	// 3km로 설정?
	    var length = len ? len : 3000;
	    
	 	// 그려지고 있는 원의 중심좌표와 반지름입니다
	    var circleOptions = { 
	        center : centerPosition, 
	    	radius: length,                 
	    };
	    
	    // 그려지고 있는 원의 옵션을 설정합니다
	    drawingCircle.setOptions(circleOptions); 
	    
	 	// 그려지고 있는 원을 지도에 표시합니다
	    drawingCircle.setMap(_this.map); 
	}
	
	return _this;
};
var tour_map_app = new map_app();

/**
 * 주변 숙박시설 처리용으로 사용되었습니다.
 * 
 */
var tour_around_app = (function(){
	var cpage;
	var _this = {
	};
	/** ui안에 넣을 내용 li 생성용 */
	function getLiContent(data){
		// UI안에 등록할 내용 처리
		li_content = '<li class="li1 m1"><div class="wrap1">';
		li_content += '	<span class="f1"><span class="f1p1"><a href="' + data.link + '">';
		if ( data.image.src != '' ) {
			li_content += '	<img src="'+ data.image.src +'" width="120" height="90" alt="'+ data.image.alt  +'" />';
		} else {
			li_content += '	<img src="/tour/img/lib1cp2/noimage2.jpg" width="120" height="90" alt="이미지가 없습니다.">';
		}
		li_content += ' </a></span></span>';
		li_content += '	<span class="wrap1texts">';
		li_content += '		<a href="' + data.link + '" class="a1">';
		li_content += '			<em class="ic1 bsContain">' + data.index + '</em>';
		li_content += '			<strong class="t1">' +  data.title + '</strong>';
		li_content += '		</a>';
		li_content += '		<a href="#?" class="a2" title="주소복사">';
		li_content += '			<i class="ic1 bsContain">주소</i>';
		li_content += '			<span class="t1">' + (data.address != '' ? data.address : ' - ' ) +'</span>';
		li_content += '		</a>';
		li_content += '		<a href="tel:000-000-0000" class="a3">';
		li_content += '			<i class="ic1 bsContain">전화</i>';
		li_content += '			<span class="t1">' + (data.tel != '' ? data.tel : ' - ')  + '</span>';
		li_content += '		</a>';
		li_content += '	</span>';
		li_content += '	<a href="'+ data.link +'" class="b1 detail"><i class="ic1 bsContain"></i><span class="t1 blind">상세보기</span></a>';
		li_content += '</div></li>';
		return li_content;
	}
	
	/** 이벤트 설정 용 */
	_this.init = function (tour_map_app, target_options){
		_this.tour_map_app = tour_map_app;
		/** 주변자료 모다 */
		var target_uis = $.extend(true, {}, {
			tour : {	'name'	: '주변관광지',
				'more' 	: $("#tour_more"),
				'ajax'	: '/ajax/tour/tourinfo/around.do',
				'ul'	: $("#tab_around_tour_ul"),
				'tab'	: $("#tab_around_tour"),
				'params': {},
				'init'	: true
			},
			lodging : {	'name'	: '주변숙박지',
				'more' 	: $("#lodging_more"),
				'ajax'	: '/ajax/tour/lodging/around.do',
				'ul'	: $("#tab_around_lodging_ul"),
				'tab'	: $("#tab_around_lodging"),
				'params': {},
				'init'	: false
			},
			restaurant : {	'name'	: '주변음식점',
				'more' 	: $("#restaurant_more"),
				'ajax'	: '/ajax/tour/restaurant/around.do',
				'ul'	: $("#tab_around_restaurant_ul"),
				'tab'	: $("#tab_around_restaurant"),
				'params': {},
				'init'	: false
			},
			goods : {	'name'	: '주변특산물',
				'more' 	: $("#goods_more"),
				'ajax'	: '/ajax/tour/tourinfo/around.do',
				'ul'	: $("#tab_around_goods_ul"),
				'tab'	: $("#tab_around_goods"),
				'params': {category:'S0300'},
				'init'	: false
			}
		}, target_options);
		
		console.log(target_uis);
		
		
		$.each(target_uis, function(index, element){
			// 주변 더보기 선택 시 실행.
			element.more.on("click", function(e){
				e.preventDefault();
			    $.ajax({
					url : element.ajax,
			        data : $.extend({ mapX:tour_map_app.options.x ,mapY:tour_map_app.options.y ,cpage:cpage++ }, element.params),
			        dataType: "json",     
			        success: function(result){
			        	if ( result.total == 0) {
			        		element.ul.append('<li><div class="center">관련 자료가 없습니다.</div></li>');
			        	}  else {
			        		//동기라미 생성
							tour_map_app.drawRadius();	
			        	}
			        	
			        	if ( result.hide_button ) {
			        		element.more.parent().parent().hide();
			        	}
			        	
			        	
			        	if ( result.datas.length > 0 ) {
				        	// 지도 그리기.
				        	tour_map_app.makeContent(result.datas);
				        	// 항목 추가하기.
				        	for(var i=0; i < result.datas.length; i++) {
				        		element.ul.append(getLiContent(result.datas[i]));
				        	}
			        	}
			        },
					error : function(xhr, ajaxOptions, thrownError) {
						alert("error:"+xhr.responseText);
					}
			   });  
			});
			/** 주변 보기 */
			element.tab.on("click", function(e){
				//카운터 초기화
				cpage=1;
				//지도 리셋
				tour_map_app.resetMap();
				// UL내의 항목 초기화
				element.ul.empty();
				// 더보기 클릭
				element.more.click();
				// 더보기 혹시 감춰진거 보이기
				element.more.parent().parent().show();
			});
			// init;
			if ( element.init){
				element.tab.trigger("click");
			}
		});
	} 
	return _this;
})();