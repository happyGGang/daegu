<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<style>
.map_bg {
	background-position: right 0 !important;
	height: 600px;
}
.info_box p {
	padding-right: 40px;
}

@media all and (min-width: 768px) and (max-width: 1023px) {
	.map_bg {height: auto;}
}

@media all and (max-width: 767px) {
	.map_bg {height: auto;}
}
</style>

<link rel="stylesheet" type="text/css" href="/resources/common/css/locationMap.css"/>

<!-- <h3 style="margin-top:0;">대구 전체 도서관 지도</h3> -->

<div class="map_wrap">
	<div id="daegu_map" class="daegu_map">
		<!-- 지도 확대, 축소 컨트롤 div 입니다
		<div class="custom_zoomcontrol radius_border"> 
		<a href="#" onclick="zoomIn()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png" alt="확대"></a>  
		<a href="#" onclick="zoomOut()"><img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png" alt="축소"></a>
		</div>
		 -->
		<div class="custom_mapcontrol"><a href="/dgportal/bukgu/bukgumap.html" target="_blank">&nbsp;</a></div>
	</div>
</div>

<!-- <div style="text-align:center;margin-top:20px;">
	<a href="https://library.daegu.go.kr/dgportal/html/junggulocation.do?menu_idx=94" class="cg-btn blue newWin" title="중구 자세히보기">
		중구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/donggulocation.do?menu_idx=90" class="cg-btn blue newWin" title="동구 자세히보기">
		동구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/seogulocation.do?menu_idx=91" class="cg-btn blue newWin" title="서구 자세히보기">
		서구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/namgulocation.do?menu_idx=92" class="cg-btn blue newWin" title="남구 자세히보기">
		남구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/bukgulocation.do?menu_idx=93" class="cg-btn blue newWin" title="북구 자세히보기">
		북구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/suseonggulocation.do?menu_idx=95" class="cg-btn blue newWin" title="수성구 자세히보기">
		수성구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/dalseogulocation.do?menu_idx=96" class="cg-btn blue newWin" title="달서구 자세히보기">
		달서구 &gt;<i class="fa fa-external-link"></i>
	</a>&nbsp;&nbsp;
	<a href="https://library.daegu.go.kr/dgportal/html/dalseonggunlocation.do?menu_idx=97" class="cg-btn blue newWin" title="달성군 자세히보기">
		달성군 &gt;<i class="fa fa-external-link"></i>
	</a>

	<p style="margin-top:15px;">* 원하시는 지역구를 클릭하시면 해당 지역구를 더 자세히 확인하실 수 있습니다.</p>
</div> -->

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=93baba79f6b6154b2068eb7550666f5f&libraries=services,clusterer"></script>
<script type="text/javascript" src="/resources/common/js/daum_map_tour_app.js"></script>
<script type="text/javascript">
/*<![CDATA[*/
var daegu_map;//overlay때문에 window에추가함.

jQuery(function($){
	var optionss = {
		level : 9,
		use_marker_click : true,
		iw_template : false
	};

	var daegu_map_data = new Array();
	
	optionss.x='35.8851259563135';
	optionss.y='128.583844263017';

	/* 중구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립중앙도서관',tel:'053-431-5505',point:{x:'35.8650932704217',y:'128.602663610319'},address:'대구광역시 중구 동덕로 115 (삼덕동2가, 진석타워) 7층 703호',no:'1' });
	daegu_map_data.push({idx:'58',title:'2·28민주운동기념회관도서관',tel:'053-257-2280',point:{x:'35.8672156072618',y:'128.595367816956'},address:'대구광역시 중구 2.28길 9 (남산동 2113-10)',no:'2' });
	daegu_map_data.push({idx:'57',title:'대구중구영어도서관', tel : '053-661-3960', point:{x:'35.8615455232041',y:'128.604392066834'}, address:'대구광역시 중구 달구벌대로440길 27',no:'3' });
	daegu_map_data.push({idx:'56',title:'남산4동작은도서관', tel : '053-661-3765', point:{x:'35.858223498446',y:'128.580572162371'}, address:'대구광역시 중구 남산로1길 42, 남산4동 행정복지센터 2층',no:'4' });
	daegu_map_data.push({idx:'55',title:'동인느티나무도서관', tel : '053-661-3325', point:{x:'35.8713151154646',y:'128.607202675691'}, address:'대구광역시 중구 동덕로 38길 47',no:'5' });
	daegu_map_data.push({idx:'54',title:'중구청교양정보실', tel : '053-661-3241', point:{x:'35.8693266953365',y:'128.606158632625'}, address:'대구광역시 중구 국채보상로139길 1, 중구청 10층',no:'6' });
	daegu_map_data.push({idx:'53',title:'대신동작은도서관', tel : '053-661-3685', point:{x:'35.8655529000034',y:'128.576339509154'}, address:'대구광역시 중구 달구벌대로389길 50, 대신동주민센터 1층',no:'7' });
	daegu_map_data.push({idx:'52',title:'삼덕마루 작은도서관', tel : '053-661-3603', point:{x:'35.8646389956382',y:'128.609046629431'}, address:'대구광역시 중구 동덕로 26길 103',no:'8' });
	daegu_map_data.push({idx:'51',title:'대봉2동작은도서관', tel : '053-661-3603', point:{x:'35.8587641205695',y:'128.599368285288'}, address:'대구광역시 중구 대봉로47길 31',no:'9' });
	daegu_map_data.push({idx:'49',title:'시청작은도서관', tel : '053-661-3603', point:{x:'35.8715842535137',y:'128.600479925029'}, address:'대구광역시 중구 공평로 83(동문동 9-2)',no:'10' });

	/* 동구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립동부도서관', tel : '053-231-2200', point:{x:'35.8901537',y:'128.6216009'}, address:'대구광역시 동구 신암북로 11길 54',no:'11' });
	daegu_map_data.push({idx:'58',title:'대구2ㆍ28기념학생도서관', tel : '053-980-2600', point:{x:'35.8905698',y:'128.6337372'}, address:'대구광역시 동구 금호강변로 360',no:'12' });
	daegu_map_data.push({idx:'57',title:'대구안심도서관', tel : '053-231-2841', point:{x:'35.864646',y:'128.7025332'}, address:'대구광역시 동구 아양로41길 56',no:'13' });
	daegu_map_data.push({idx:'56',title:'대구신천도서관', tel : '053-980-2600', point:{x:'35.871436',y:'128.617776'}, address:'대구광역시 동구 동부로6길 65',no:'14' });
	daegu_map_data.push({idx:'55',title:'신암2동작은도서관', tel : '053-662-3633', point:{x:'35.8799695',y:'128.6127068'}, address:'대구광역시 동구 신성로 56(신암2동행정복지센터 2층)',no:'15' });
	daegu_map_data.push({idx:'54',title:'신암3동작은도서관', tel : '070-7755-5631', point:{x:'35.8810491',y:'128.6188883'}, address:'대구광역시 동구 아양로8길 10-1 (동구여성문화공간 3층)',no:'16' });
	daegu_map_data.push({idx:'42',title:'신암5동작은도서관', tel : '053-662-3485', point:{x:'35.8897559',y:'128.6330629'}, address:'대구광역시 동구 아양로37길 92(신암5동주민센터 2층)',no:'17' });
	daegu_map_data.push({idx:'53',title:'신천3동작은도서관', tel : '053-662-3734', point:{x:'35.8753917',y:'128.6237458'}, address:'대구광역시 동구 장등로 90(신천3동 행정복지센터 3층)',no:'18' });
	daegu_map_data.push({idx:'52',title:'효목1동작은도서관', tel : '053-662-3775', point:{x:'35.8816142',y:'128.6449448'}, address:'대구광역시 동구 화랑로41길 46(효목1동 행정복지센터 2층)',no:'19' });
	daegu_map_data.push({idx:'51',title:'효목2동작은도서관', tel : '053-662-3794', point:{x:'35.8781522',y:'128.6412466'}, address:'대구광역시 동구 화랑로 25길 45(효목2동 행정복지센터 1층)',no:'20' });
	daegu_map_data.push({idx:'49',title:'도평동작은도서관', tel : '053-662-3810', point:{x:'35.9100034',y:'128.6500078'}, address:'대구광역시 동구 팔공로24길 171(도평동 행정복지센터 3층)',no:'21' });
	daegu_map_data.push({idx:'48',title:'불로어울림작은도서관', tel : '070-4214-0007', point:{x:'35.909725',y:'128.6415999'}, address:'대구광역시 동구 팔공로24길 5(불로전통시장 상인교육관 3층)',no:'22' });
	daegu_map_data.push({idx:'47',title:'지저동작은도서관', tel : '070-7755-5633', point:{x:'35.8934142',y:'128.6383092'}, address:'대구광역시 동구 해동로3길 80(지저동 행정복지센터 3층)',no:'23' });
	daegu_map_data.push({idx:'46',title:'동촌역사작은도서관', tel : '070-4214-6859', point:{x:'35.8903035',y:'128.6501713'}, address:'대구 동구 동촌역사로 3길 35',no:'24' });
	daegu_map_data.push({idx:'45',title:'방촌동작은도서관', tel : '070-4251-5854', point:{x:'35.8813411',y:'128.664457'}, address:'대구 동구 동촌로46길 2(방촌종합상가 2층)',no:'25' });
	daegu_map_data.push({idx:'44',title:'해안동작은도서관', tel : '070-7755-5632', point:{x:'35.8820761',y:'128.6716797'}, address:'대구광역시 동구 방촌로 29길 46 (해안동 행정복지센터 3층)',no:'26' });
	daegu_map_data.push({idx:'43',title:'반야월역사작은도서관', tel : '053-662-4110', point:{x:'35.8724796',y:'128.7254918'}, address:'대구광역시 동구 신서로 50(대구선2공원 내 철도역사 1동)',no:'27' });
	//daegu_map_data.push({idx:'39',title:'초록우산 도서관', tel : '053-964-3335', point:{x:'35.8698335',y:'128.709637'}, address:'대구광역시 동구 율하동로 26길 67(대구종합사회복지관)',no:'18' });
	daegu_map_data.push({idx:'41',title:'늘푸른작은도서관', tel : '053-983-8211', point:{x:'35.8935022',y:'128.6451719'}, address:'대구광역시 동구 입석로 5(동촌종합사회복지관)',no:'28' });
	daegu_map_data.push({idx:'38',title:'꿈날자문고작은도서관', tel : '053-247-0755', point:{x:'35.8702298',y:'128.7259751'}, address:'대구광역시 동구 안심로73길 22(롯데캐슬 레전드관리사무소)',no:'29' });
	daegu_map_data.push({idx:'37',title:'행복작은도서관', tel : '053-755-9392', point:{x:'35.8702091',y:'128.6213122'}, address:'대구광역시 동구 송라로2길17-6(제일기독종합사회복지관)',no:'30' });
	daegu_map_data.push({idx:'35',title:'율하5주민작은도서관', tel : '053-965-5955', point:{x:'35.8640922',y:'128.6920047'}, address:'대구광역시 동구 율하서로59(율하휴먼시아5단지 관리실)',no:'31' });
	daegu_map_data.push({idx:'36',title:'방촌어린이작은도서관', tel : '053-981-8276', point:{x:'35.8802839',y:'128.6638025'}, address:'대구광역시 동구 동촌로 46길 17',no:'32' });
	daegu_map_data.push({idx:'35',title:'동일도서관', tel : '053-755-6003', point:{x:'35.8764604',y:'128.6800965'}, address:'대구광역시 동구 동촌로 374-3',no:'33' });
	daegu_map_data.push({idx:'34',title:'한들마을도서관', tel : '053-985-1513', point:{x:'35.941557',y:'128.6425066'}, address:'대구광역시 동구 팔공로101길 47',no:'34' });

	/* 서구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립서부도서관', tel : '053-231-2449', point:{x:'35.8578027577781',y:'128.539097820561'}, address:'대구광역시 달서구 죽전1길 176 (구.죽전중) 2층',no:'35' });
	daegu_map_data.push({idx:'58',title:'서구어린이도서관', tel : '053-663-3701', point:{x:'35.8742787980867',y:'128.546380223162'}, address:'대구광역시 서구 문화로 123',no:'36' });
	daegu_map_data.push({idx:'57',title:'비산도서관', tel : '053-663-3721', point:{x:'35.8685788218055',y:'128.57331647507'}, address:'대구광역시 서구 달서로 14길 13',no:'37' });
	daegu_map_data.push({idx:'56',title:'서구영어도서관', tel : '053-663-3861', point:{x:'35.867878',y:'128.544274'}, address:'대구광역시 서구 평리로 35길 90-6',no:'38' });
	daegu_map_data.push({idx:'55',title:'비원도서관', tel : '053-663-3873', point:{x:'35.8860881575549',y:'128.569284590416'}, address:'대구광역시 서구 달서천로 61안길 10',no:'39' });
	daegu_map_data.push({idx:'54',title:'원고개도서관', tel : '053-663-3942', point:{x:'35.8818789923792',y:'128.570797020986'}, address:'대구광역시 서구 달서로 43길 12',no:'40' });
	daegu_map_data.push({idx:'53',title:'내당2.3동드림도서관', tel : '053-521-9100', point:{x:'35.8643313624622',y:'128.568756874411'}, address:'대구광역시 서구 달서로5길 31-1(내당2·3동)',no:'41' });
	daegu_map_data.push({idx:'52',title:'내당4동어린이도서관', tel : '053-663-4234', point:{x:'35.8590204867088',y:'128.551843118421'}, address:'대구광역시 서구 서대구로3길46 (내당4동)(2층)',no:'42' });
	daegu_map_data.push({idx:'51',title:'비산7동작은도서관', tel : '053-663-3649', point:{x:'35.8858973495298',y:'128.553897616805'}, address:'대구광역시 서구 서대구로63안길 30-22(비산동)',no:'43' });
	daegu_map_data.push({idx:'49',title:'<span style="font-size:85%;">새마을문고대구서구지부작은도서관</span>', tel : '053-663-3865', point:{x:'35.867994',y:'128.544266'}, address:'대구광역시 서구 평리로35길 90-6(영어도서관 2층)',no:'44' });
	daegu_map_data.push({idx:'48',title:'서구청작은도서관', tel : '053-663-3637', point:{x:'35.8723219470535',y:'128.559289496989'}, address:'대구광역시 서구 국채보상로 257(평리동)',no:'45' });
	daegu_map_data.push({idx:'47',title:'<span style="font-size:95%;">달성토성마을다락방작은도서관</span>', tel : '053-663-3645', point:{x:'35.8733150060675',y:'128.575372901347'}, address:'대구광역시 서구 국채보상로83길 21(비산2.3동)',no:'46' });

	/* 남구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립남부도서관', tel : '053-231-2300', point:{x:'35.8320561611199',y:'128.58075142379'}, address:'대구광역시 남구 앞산순환로 512',no:'47' });
	daegu_map_data.push({idx:'58',title:'이천어울림도서관', tel : '053-664-3571', point:{x:'35.8523906311032',y:'128.598813734157'}, address:'대구광역시 남구 이천로 124',no:'48' });
	daegu_map_data.push({idx:'57',title:'대명어울림도서관', tel : '053-664-3555', point:{x:'35.841571576524',y:'128.573782930777'}, address:'대구광역시 남구 두류공원로 38-1',no:'49' });
	daegu_map_data.push({idx:'56',title:'꿈틀작은도서관', tel : '053-621-8667', point:{x:'35.8479361251304',y:'128.572326741767'}, address:'대구광역시 남구 성명공원길18(대명동, 2층)',no:'50' });
	
	/* 북구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립북부도서관', tel:'053-231-2600', point:{x:'35.8851259563135',y:'128.583844263017'}, address:'대구광역시 북구 옥산로 75 (침산동)',no:'51' });
	daegu_map_data.push({idx:'58',title:'구수산도서관', tel:'053-320-5150', point:{x:'35.9387440917381',y:'128.55240517489'}, address:'대구광역시 북구 대천로 21 (읍내동)',no:'52' });
	daegu_map_data.push({idx:'57',title:'태전도서관', tel:'053-320-5180', point:{x:'35.9285577192463',y:'128.54620122749'}, address:'대구광역시 북구 영송로 36-16(태전동)',no:'53' });
	daegu_map_data.push({idx:'56',title:'대현도서관', tel:'053-320-5170', point:{x:'35.8818931927918',y:'128.607389999937'}, address:'대구광역시 북구 대현남로 43(대현동)',no:'54' });
	daegu_map_data.push({idx:'55',title:'산격1동작은도서관', tel:'053-320-5193', point:{x:'35.9005135472476',y:'128.597103166871'}, address:'대구광역시 북구 연암로 36길 6(산격1동), 산격1동주민센터 3층',no:'55' });
	daegu_map_data.push({idx:'54',title:'북구영어작은도서관', tel:'053-320-5190', point:{x:'35.8818550927522',y:'128.583514539572'}, address:'대구광역시 북구 고성로 31길 21(고성동 3가), 고성동행정복지센터 1층',no:'56' });
	daegu_map_data.push({idx:'53',title:'침산1동작은도서관', tel:'053-320-5191', point:{x:'35.8903255867369',y:'128.581357220285'}, address:'대구광역시 북구 침산남로13길 16(침산동), 침산1동주민센터 2층',no:'57' });
	daegu_map_data.push({idx:'52',title:'노원동작은도서관', tel:'053-320-5192', point:{x:'35.8907173461525',y:'128.566665595388'}, address:'대구광역시 북구 팔달로27길 42-3(노원동 3가), 팔달시장내 고객쉼터 2층',no:'58' });
	daegu_map_data.push({idx:'51',title:'서변동작은도서관', tel:'053-320-5194', point:{x:'35.9279987494581',y:'128.597948326757'}, address:'대구광역시 북구 호국로57길 6, 유니버시아드레포츠센터 1층',no:'59' });
	daegu_map_data.push({idx:'49',title:'노원행복도서관', tel:'053-320-5198', point:{x:'35.8969492969157',y:'128.575761642876'}, address:'대구광역시 북구 노원로 134',no:'60' });
	daegu_map_data.push({idx:'48',title:'한강공원부키도서관', tel:'053-320-5199', point:{x:'35.898698373371',y:'128.51362596382'}, address:'대구광역시 북구 사수동 811',no:'61' });
	daegu_map_data.push({idx:'47',title:'꿈꾸는마을도서관도토리', tel:'053-327-0645', point:{x:'35.9315271',y:'128.5564402'}, address:'대구광역시 북구 구암로 146',no:'62' });
	daegu_map_data.push({idx:'46',title:'더불어숲도서관', tel:'053-326-0937', point:{x:'35.944734',y:'128.5698923'}, address:'대구광역시 북구 학남로17길 2 ',no:'63' });
	daegu_map_data.push({idx:'45',title:'연암공공도서관', tel:'053-956-4422', point:{x:'35.8995862',y:'128.6055034'}, address:'대구광역시 북구 동북로26길 25-1',no:'64' });

	/* 수성구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립수성도서관', tel : '053-231-2551', point:{x:'35.8721329094016',y:'128.63906132752'}, address:'대구광역시 수성구 만촌로 151',no:'65' });
	daegu_map_data.push({idx:'58',title:'범어도서관', tel : '053-668-1600', point:{x:'35.8593751012399',y:'128.630676348493'}, address:'대구광역시 수성구 달구벌대로 2451',no:'66' });
	daegu_map_data.push({idx:'57',title:'용학도서관', tel : '053-668-1700', point:{x:'35.8211298167339',y:'128.644705546516'}, address:'대구광역시 수성구 지범로41길 16',no:'67' });
	daegu_map_data.push({idx:'56',title:'고산도서관', tel : '053-668-1900', point:{x:'35.8379053106723',y:'128.710632720214'}, address:'대구광역시 수성구 달구벌대로650길 6(신매동)',no:'68' });
	daegu_map_data.push({idx:'55',title:'파동도서관', tel : '053-668-1801', point:{x:'35.8104539258976',y:'128.618146184099'}, address:'대구광역시 수성구 파동로3길 62 파동평생학습센터 1층',no:'69' });
	daegu_map_data.push({idx:'54',title:'무학숲도서관', tel : '053-668-1821', point:{x:'35.8352614435461',y:'128.630574771678'}, address:'대구광역시 수성구 청수로40길 73-10(지산동)',no:'70' });
	daegu_map_data.push({idx:'53',title:'책숲길도서관', tel : '053-668-1811', point:{x:'35.8448425307153',y:'128.612376649774'}, address:'대구광역시 수성구 수성로215(중동) 수옥빌딩 4층',no:'71' });
	daegu_map_data.push({idx:'52',title:'물망이도서관', tel : '053-666-4390', point:{x:'35.8547657653853',y:'128.619007545444'}, address:'대구광역시 수성구 명덕로 443-2(수성동3가) 수성2,3가동 행정복지센터 4층',no:'72' });
	daegu_map_data.push({idx:'51',title:'사월역작은도서관', tel : '053-792-8582', point:{x:'35.8367666856083',y:'128.715362349733'}, address:'대구광역시 수성구 달구벌대로 지하 1층 3290(신매동)',no:'73' });
	
	/* 달서구 */
	daegu_map_data.push({idx:'59',title:'대구광역시립두류도서관', tel : '053-231-2700', point:{x:'35.8526137879105',y:'128.560435130444'}, address:'대구광역시 달서구 공원순환로 8',no:'74' });
	daegu_map_data.push({idx:'58',title:'성서도서관', tel : '053-667-4900', point:{x:'35.8574115335529',y:'128.514459232431'}, address:'대구광역시 달서구 선원남로 129 (이곡동)',no:'75' });
	daegu_map_data.push({idx:'57',title:'달서어린이도서관', tel : '053-667-4860', point:{x:'35.8224803563508',y:'128.547014357069'}, address:'대구광역시 달서구 송현로 45(상인동)',no:'76' });
	daegu_map_data.push({idx:'56',title:'도원도서관', tel : '053-667-4840', point:{x:'35.8067933787751',y:'128.5390485116'}, address:'대구광역시 달서구 한실로 113(도원동)',no:'77' });
	daegu_map_data.push({idx:'55',title:'본리도서관', tel : '053-667-4930', point:{x:'35.8405592500203',y:'128.541813956432'}, address:'대구광역시 달서구 당산로 37-25(본리동)',no:'78' });
	daegu_map_data.push({idx:'54',title:'달서가족문화도서관', tel : '053-667-4970', point:{x:'35.8174869853999',y:'128.519186842697'}, address:'대구광역시 달서구 조암남로 137 (대천동)',no:'79' });
	daegu_map_data.push({idx:'53',title:'달서영어도서관', tel : '053-667-4950', point:{x:'35.831256500065',y:'128.555213095042'}, address:'대구광역시 달서구 중흥로 6길 10 (송현동)',no:'80' });
	daegu_map_data.push({idx:'52',title:'이곡2동작은도서관', tel : '053-667-4368', point:{x:'35.8557547032754',y:'128.500776149161'}, address:'대구광역시 달서구 계대동문로77 (이곡동 1191-3)',no:'81' });
	daegu_map_data.push({idx:'51',title:'용산1동작은도서관', tel : '053-667-4279', point:{x:'35.8566624983138',y:'128.531223930229'}, address:'대구광역시 달서구 용산로212-7 (용산동 934-6)',no:'82' });
	daegu_map_data.push({idx:'49',title:'장기동작은도서관', tel : '053-667-4244', point:{x:'35.8433491694642',y:'128.529974709497'}, address:'대구광역시 달서구 장기로277 (장기동 817-2)',no:'83' });
	daegu_map_data.push({idx:'48',title:'죽전동작은도서관', tel : '053-667-4214', point:{x:'35.8557951418932',y:'128.539806645735'}, address:'대구광역시 달서구 와룡로54길 28 (죽전동 204-12)',no:'84' });
	daegu_map_data.push({idx:'47',title:'달서아트센터도서관', tel : '053-584-9274', point:{x:'35.843422578812',y:'128.522826730437'}, address:'대구광역시 달서구 문화회관길160 (장기동 722-1) ',no:'85' });
	daegu_map_data.push({idx:'46',title:'행정정보문고센터', tel : '053-667-4815', point:{x:'35.8295250192427',y:'128.532293871771'}, address:'대구광역시 달서구 학산로 45 (월성동 281)',no:'86' });
	daegu_map_data.push({idx:'45',title:'학산작은도서관', tel : '053-721-8970', point:{x:'35.8332859011084',y:'128.541804663116'}, address:'대구광역시 달서구 학산로 140(본동 804-2)',no:'87' });
	daegu_map_data.push({idx:'44',title:'대구학생문화센터', tel : '053-231-1254', point:{x:'35.8530407',y:'128.5294985'}, address:'대구광역시 달서구 용산로 181 대구학생문화센터 2층',no:'88' });
	daegu_map_data.push({idx:'43',title:'점자도서관', tel : '053-256-8877', point:{x:'35.831016',y:'128.552125'}, address:'대구광역시 달서구 월배로 414 (송현동)',no:'89' });
	daegu_map_data.push({idx:'42',title:'새벗도서관', tel : '053-631-9105', point:{x:'35.8168531',y:'128.5326179'}, address:'대구광역시 달서구 월배로 170 (상인동)',no:'90' });
	daegu_map_data.push({idx:'41',title:'푸른초장공공도서관', tel : '053-582-3394', point:{x:'35.8536579',y:'128.4738303'}, address:'대구광역시 달서구 달구벌대로 973',no:'91' });

	/* 달성군 */
	daegu_map_data.push({idx:'59',title:'대구광역시립달성도서관', tel : '053-231-2150', point:{x:'35.6987734244329',y:'128.447687886093'}, address:'대구광역시 달성군 현풍면 현풍동로19길 26',no:'92' });
	daegu_map_data.push({idx:'58',title:'달성군립도서관', tel : '053-231-2150', point:{x:'35.8592968795804',y:'128.462410475657'}, address:'대구광역시 달성군 다사읍 달구벌대로174길 10-13',no:'93' });
	daegu_map_data.push({idx:'57',title:'화원읍작은도서관', tel : '053-668-3346', point:{x:'35.8042335195515',y:'128.500718751053'}, address:'대구광역시 달성군 화원읍 비슬로 2594 (군민독서실1,2층)',no:'94' });
	daegu_map_data.push({idx:'56',title:'논공읍작은도서관', tel : '053-615-9191', point:{x:'35.7301956975906',y:'128.45178080326'}, address:'대구광역시 달성군 논공읍 논공로 697-9 (종합사회복지관2층)',no:'95' });
	daegu_map_data.push({idx:'55',title:'다사읍작은도서관', tel : '053-591-3342', point:{x:'35.8648158934292',y:'128.457307362395'}, address:'대구광역시 달성군 다사읍 매곡로12길 37 (다사읍자치센터별관)',no:'96' });
	daegu_map_data.push({idx:'54',title:'다사읍서재작은도서관', tel : '053-588-6261', point:{x:'35.8722208677966',y:'128.494256685648'}, address:'대구광역시 달성군 다사읍 서재본길 25 (다사서재출장소2층)',no:'97' });
	daegu_map_data.push({idx:'52',title:'유가읍작은도서관', tel : '053-614-8048', point:{x:'35.6943341355787',y:'128.459646544423'}, address:'대구광역시 달성군 유가읍 테크노상업로 95 (유가읍사무소2층)',no:'98' });
	daegu_map_data.push({idx:'51',title:'옥포읍작은도서관', tel : '053-614-8314', point:{x:'35.7893939008833',y:'128.463403781067'}, address:'대구광역시 달성군 옥포읍 비슬로 2215 (옥포읍자치센터1층)',no:'99' });
	daegu_map_data.push({idx:'49',title:'가창면 참꽃작은도서관', tel : '053-760-7731', point:{x:'35.8023200879016',y:'128.623413571364'}, address:'대구광역시 달성군 가창면 가창로220길 8 (청소년문화의집1층)',no:'100' });
	daegu_map_data.push({idx:'48',title:'하빈면작은도서관', tel : '053-582-5610', point:{x:'35.8995133295819',y:'128.445876932419'}, address:'대구광역시 달성군 하빈면 하빈로84길 23 (하빈면민복지회관3층)',no:'101' });
	daegu_map_data.push({idx:'47',title:'구지면작은도서관', tel : '053-614-0985', point:{x:'35.6604041035004',y:'128.415118518014'}, address:'대구광역시 달성군 구지면 창리로11길 90 (구.구지면 농촌상담소)',no:'102' });
	daegu_map_data.push({idx:'46',title:'달성군청소년센터 작은도서관', tel : '053-670-1323', point:{x:'35.7238932618227',y:'128.455082141863'}, address:'대구광역시 달성군 논공읍 논공로 252 (청소년센터3층)',no:'103' });
	daegu_map_data.push({idx:'45',title:'달성군청도서관', tel : '053-668-3239', point:{x:'35.7746629175875',y:'128.43138936958'}, address:'대구광역시 달성군 논공읍 달성군청로 33 (달성군청)',no:'104' });
	daegu_map_data.push({idx:'44',title:'비전도서관', tel : '053-639-2140', point:{x:'35.8060901',y:'128.5057505'}, address:'대구광역시 달성군 화원읍 인흥길 11 (천내리)',no:'105' });
	daegu_map_data.push({idx:'43',title:'아트도서관', tel : '053-952-5252', point:{x:'35.7254625',y:'128.6551319'}, address:'대구광역시 달성군 가창면 우록길 131 (우록리)',no:'106' });

	daegu_map = new map_app();
	
	/* add overlay [ */
	daegu_map.close_overlay = function(idx)  {
		this._overlay[idx].setMap(null);
	}

	daegu_map.marker_click = function(marker, data) {
		
		var map = this.map;
		var infoStr  = '<div class="tour2map1layer1">';
		infoStr += '	<a href="#" onclick="return false;" class="wrap1 a1">';
		infoStr += '		<strong class="h1">'+ data.title +'</strong>';
		
		infoStr += '		<span class="text1"><span class="t1">주소 : '+ data.address +'<br/>연락처 : '+  data.tel +'</span></span>';
		infoStr += '	</a>';
		infoStr += '	<a href="#?" onclick="daegu_map.close_overlay('+ data.idx +');return false;" class="b1 close"><i class="ic1 bsContain">×</i><span class="blind">닫기</span></a>';
		infoStr += '</div>';
		
		this._overlay[data.idx] = new daum.maps.CustomOverlay({
			content: infoStr,
			map: map,
			position: marker.getPosition()
		});
		this._overlay[data.idx].setMap(map);
		map.setCenter(marker.getPosition());
		map.panBy(0, -100);
	} 
	/* ]add overlay */

	daegu_map.init('daegu_map', optionss, daegu_map_data);
});
/*]]>*/
</script>