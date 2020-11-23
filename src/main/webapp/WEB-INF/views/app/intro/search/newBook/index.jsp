<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" type="text/css" href="/resources/book/search/css/default.css"/>
<script type="text/javascript">
$(function() {

	//검색하기
	$('a#search-btn').on('click', function(e) {
		e.preventDefault();
		$('input#viewPage').val('1');
		doGetLoad('index.do', serializeCustom($('#librarySearch')));
	});

	//이미지 목록형
	$('.imgView').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('on');
		$('.listView').removeClass('on');
		$('.search-results .cont ul').removeClass();
		if($(this).hasClass('on')){
			$('.search-results .textType').css('display','none');
			$('.search-results .imageType').css('display','block');
		}
	});

	//텍스트 목록형
	$('.listView').on('click', function(e) {
		e.preventDefault();
		$(this).addClass('on');
		$('.imgView').removeClass('on');
		$('.search-results .cont ul').removeClass();
		if($(this).hasClass('on')){
			$('.search-results .imageType').css('display','none');
			$('.search-results .textType').css('display','block');
		}
	});
});
</script>
<form:form modelAttribute="librarySearch" action="index.do" method="GET" onsubmit="return false;">
	<form:hidden path="viewPage"/>

	<!-- contents-title-->
	<div id="contents-title">
		<h2>새로운 도서<span style="font-weight:300">를 찾고 싶으세요?</span></h2>
	</div>
	<!-- /contents-title-->

	<div class="search-wrap">

		<div id="search_detail">

			<table class="table_gray" summary="구분,자료형태,자료실,발행년도,본문언어,요약문언어 선택 항목에 관한 테이블입니다.">
			<caption>검색항목</caption>
			<colgroup>
			<col style="width:9%">
			<col style="width:24%">
			<col style="width:9%">
			<col style="width:24%">
			<col style="width:9%">
			<col style="width:24%">
			</colgroup>
			<tbody>
			<tr>

			<th><label for="option01">도서관명</label></th>
			<td class="search_left">
				<c:choose>
				<c:when test="${context_path eq 'bukgs'}">
				구수산 도서관
				<form:hidden path="manageCode" value="BA" />
				</c:when>
				<c:when test="${context_path eq 'bukdh'}">
				대현도서관<form:hidden path="manageCode" value="BB" />
				</c:when>
				<c:when test="${context_path eq 'buktj'}">
				태전도서관<form:hidden path="manageCode" value="BC" />
				</c:when>
				<c:when test="${context_path eq 'buks'}">
					<form:radiobutton path="manageCode" value='GP' label="노원동 작은도서관" />
					<form:radiobutton path="manageCode" value='HD' label="노원행복도서관" />
					<form:radiobutton path="manageCode" value='GM' label="북구영어작은도서관" />
					<form:radiobutton path="manageCode" value='GL' label="산격1동 작은도서관" />
					<form:radiobutton path="manageCode" value='HB' label="서변동작은도서관" />
					<form:radiobutton path="manageCode" value='GN' label="침산1동 작은도서관" />
					<form:radiobutton path="manageCode" value='GJ' label="태전1동 작은도서관" />
					<form:radiobutton path="manageCode" value='HE' label="한강공원부키도서관" />
				</c:when>
				<c:when test="${context_path eq 'jungang'}">
				중앙도서관<form:hidden path="manageCode" value="AD" />
				</c:when>
				<c:when test="${context_path eq 'dongdu'}">
				동부도서관<form:hidden path="manageCode" value="AH" />
				</c:when>
				<c:when test="${context_path eq 'seobu'}">
				서부도서관<form:hidden path="manageCode" value="AF" />
				</c:when>
				<c:when test="${context_path eq 'nambu'}">
				남부도서관<form:hidden path="manageCode" value="AG" />
				</c:when>
				<c:when test="${context_path eq 'bukbu'}">
				북부도서관<form:hidden path="manageCode" value="AC" />
				</c:when>
				<c:when test="${context_path eq 'duryu'}">
				두류도서관<form:hidden path="manageCode" value="AB" />
				</c:when>
				<c:when test="${context_path eq '228'}">
				228기념학생도서관<form:hidden path="manageCode" value="AA" />
				</c:when>
				<c:when test="${context_path eq '228lib'}">
				228민주운동<form:hidden path="manageCode" value="AL" />
				</c:when>
				<c:when test="${context_path eq 'suseong'}">
				수성도서관<form:hidden path="manageCode" value="AE" />
				</c:when>
				<c:when test="${context_path eq 'dalseong'}">
				달성도서관<form:hidden path="manageCode" value="AJ" />
				</c:when>
				<c:when test="${context_path eq 'std'}">
				대구학생문화센터<form:hidden path="manageCode" value="AK" />
				</c:when>
				<c:when test="${context_path eq 'dmsl'}">
				시청작은도서관<form:hidden path="manageCode" value="FV" />
				</c:when>
				<c:when test="${context_path eq 'bukgs'}">
				구수산도서관<form:hidden path="manageCode" value="BA" />
				</c:when>
				<c:when test="${context_path eq 'bukdh'}">
				대현도서관<form:hidden path="manageCode" value="BB" />
				</c:when>
				<c:when test="${context_path eq 'buktj'}">
				태전도서관<form:hidden path="manageCode" value="BC" />
				</c:when>
				<c:when test="${context_path eq 'buks'}">
					<form:radiobutton path="manageCode" value='GJ' label="태전1동 작은도서관" />
					<form:radiobutton path="manageCode" value='GL' label="산격1동 작은도서관" />
					<form:radiobutton path="manageCode" value='GM' label="북구영어작은도서관" />
					<form:radiobutton path="manageCode" value='GN' label="침산1동 작은도서관" />
					<form:radiobutton path="manageCode" value='GP' label="노원동 작은도서관" />
					<form:radiobutton path="manageCode" value='HB' label="서변동작은도서관" />
					<form:radiobutton path="manageCode" value='HD' label="노원행복도서관" />
					<form:radiobutton path="manageCode" value='HE' label="노원한강공원부키도서관복도서관" />
				</c:when>
				<c:when test="${context_path eq 'beomeo'}">
				범어도서관<form:hidden path="manageCode" value="BD" />
				</c:when>
				<c:when test="${context_path eq 'yonghak'}">
				용학도서관<form:hidden path="manageCode" value="BE" />
				</c:when>
				<c:when test="${context_path eq 'gosan'}">
				고산도서관<form:hidden path="manageCode" value="BF" />
				</c:when>
				<c:when test="${context_path eq 'bookforest'}">
				책숲길도서관<form:hidden path="manageCode" value="BJ" />
				</c:when>
				<c:when test="${context_path eq 'mulmangi'}">
				물망이도서관<form:hidden path="manageCode" value="BK" />
				</c:when>
				<c:when test="${context_path eq 'padong'}">
				파동도서관<form:hidden path="manageCode" value="BG" />
				</c:when>
				<c:when test="${context_path eq 'muhaksup'}">
				무학숲도서관<form:hidden path="manageCode" value="BH" />
				</c:when>
				<c:when test="${context_path eq 'sawol'}">
				사월역작은도서관<form:hidden path="manageCode" value="FG" />
				</c:when>
				<c:when test="${context_path eq 'junggu'}">
					<form:radiobutton path="manageCode" value='FS' label="대구중구영어도서관" />
					<form:radiobutton path="manageCode" value='FF' label="남산4동작은도서관" />
					<form:radiobutton path="manageCode" value='FQ' label="동인 느티나무 도서관" />
					<form:radiobutton path="manageCode" value='FY' label="중구청교양정보실" />
					<form:radiobutton path="manageCode" value='GG' label="대신동작은도서관" />
					<form:radiobutton path="manageCode" value='HA' label="삼덕마루 작은도서관" />
					<form:radiobutton path="manageCode" value='HF' label="대봉2동작은도서관" />
				</c:when>

				<c:when test="${context_path eq 'seogulib'}">
					<form:radiobutton path="manageCode" value='BL' label="서구어린이도서관" /><br/>
					<form:radiobutton path="manageCode" value='BQ' label="비산도서관" /><br/>
					<form:radiobutton path="manageCode" value='BP' label="서구영어도서관" /><br/>
					<form:radiobutton path="manageCode" value='BM' label="비원도서관" /><br/>
					<form:radiobutton path="manageCode" value='BN' label="원고개도서관" /><br/>

					<form:radiobutton path="manageCode" value='FH' label="새마을문고대구서구지부작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FT' label="서구청 작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FU' label="내당4동어린이도서관" /><br/>
					<form:radiobutton path="manageCode" value='FZ' label="비산7동 작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GQ' label="내당2,3동 드림도서관" /><br/>
					<form:radiobutton path="manageCode" value='HC' label="달성토성마을 다락방 작은도서관" />
				</c:when>
				<c:when test="${context_path eq 'bisan'}">
				비산도서관<form:hidden path="manageCode" value="BQ" />
				</c:when>
				<c:when test="${context_path eq 'seoguenglish'}">
				서구영어도서관<form:hidden path="manageCode" value="BP" />
				</c:when>
				<c:when test="${context_path eq 'biwon'}">
				서구영어도서관<form:hidden path="manageCode" value="BM" />
				</c:when>
				<c:when test="${context_path eq 'wongogae'}">
				원고개도서관<form:hidden path="manageCode" value="BN" />
				</c:when>
				<c:when test="${context_path eq 'seogumini'}">
					<form:radiobutton path="manageCode" value='FH' label="새마을문고대구서구지부작은도서관" />
					<form:radiobutton path="manageCode" value='FT' label="서구청 작은도서관" />
					<form:radiobutton path="manageCode" value='FU' label="내당4동어린이도서관" />
					<form:radiobutton path="manageCode" value='FZ' label="비산7동 작은도서관" />
					<form:radiobutton path="manageCode" value='GQ' label="내당2,3동 드림도서관" />
					<form:radiobutton path="manageCode" value='HC' label="달성토성마을 다락방 작은도서관" />
				</c:when>
				<c:when test="${context_path eq 'dalseonglib'}">
				달성군립도서관<form:hidden path="manageCode" value="BR" />
				</c:when>
				<c:when test="${context_path eq 'dalseongsmall'}">
					<form:radiobutton path="manageCode" value='FR' label="가창면 참꽃작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GA' label="화원읍작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GB' label="논공읍작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GC' label="구지면작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GD' label="다사읍서재작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GE' label="하빈면작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GF' label="유가읍작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='GH' label="옥포읍작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FJ' label="달성군청도서관" /><br/>
					<form:radiobutton path="manageCode" value='FN' label="달성군청소년센터" /><br/>
					<form:radiobutton path="manageCode" value='HG' label="다사읍작은도서관" />
				</c:when>
				<c:when test="${context_path eq 'namdm' || context_path eq 'namic'}">
					<form:radiobutton path="manageCode" value='BT' label="이천어울림도서관" /><br/>
					<form:radiobutton path="manageCode" value='BS' label="대명어울림도서관" /><br/>
					<form:radiobutton path="manageCode" value='FE' label="꿈틀작은도서관" />
				</c:when>
				<c:when test="${context_path eq 'dalseolib'}">
					<form:radiobutton path="manageCode" value='BW' label="도원도서관" /><br/>
					<form:radiobutton path="manageCode" value='BV' label="달서어린이" /><br/>
					<form:radiobutton path="manageCode" value='BU' label="성서도서관" /><br/>
					<form:radiobutton path="manageCode" value='BX' label="본리도서관" /><br/>
					<form:radiobutton path="manageCode" value='BY' label="달서가족문화도서관" /><br/>
					<form:radiobutton path="manageCode" value='BZ' label="달서영어도서관" /><br/>

					<form:radiobutton path="manageCode" value='FA' label="이곡2동공립작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FB' label="용산1동작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FC' label="장기동작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FD' label="죽전동공립작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FW' label="웃는얼굴아트센터 도서실" /><br/>
					<form:radiobutton path="manageCode" value='FX' label="행정정보문고센터" /><br/>
					<form:radiobutton path="manageCode" value='GK' label="학산작은도서관" />
				</c:when>
				<c:when test="${context_path eq 'kids'}">
					달서어린이<form:hidden path="manageCode" value="BV" />
				</c:when>
				<c:when test="${context_path eq 'seongseo'}">
					성서도서관<form:hidden path="manageCode" value="BU" />
				</c:when>
				<c:when test="${context_path eq 'bolli'}">
					본리도서관<form:hidden path="manageCode" value="BX" />
				</c:when>
				<c:when test="${context_path eq 'family'}">
					달서가족문화도서관<form:hidden path="manageCode" value="BY" />
				</c:when>
				<c:when test="${context_path eq 'english'}">
					달서영어도서관<form:hidden path="manageCode" value="BZ" />
				</c:when>
				<c:when test="${context_path eq 'dssmalllib'}">
					<form:radiobutton path="manageCode" value='FA' label="이곡2동공립작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FB' label="용산1동작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FC' label="장기동작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FD' label="죽전동공립작은도서관" /><br/>
					<form:radiobutton path="manageCode" value='FW' label="웃는얼굴아트센터 도서실" /><br/>
					<form:radiobutton path="manageCode" value='FX' label="행정정보문고센터" /><br/>
					<form:radiobutton path="manageCode" value='GK' label="학산작은도서관" />
				</c:when>
				<c:otherwise>
				<form:hidden path="manageCode" value="" />
				</c:otherwise>
				</c:choose>
			</td>

			<th><label for="option01">자료형태</label></th>
			<td class="search_left">
				<form:radiobutton path="booktype" value="0" title="도서" label=" 도서"/>
				<form:radiobutton path="booktype" value="1" title="간한강공원부키도서관물" label=" 간행물"/>
				<form:radiobutton path="booktype" value="2" title="비도서" label=" 비도서"/>
			</td>

			<th><label for="search_date03">간편검색</label></th>
			<td class="search_left">
				<form:radiobutton path="search_type" value="1" title="1주전" label=" 1주전"/>
				<form:radiobutton path="search_type" value="2" title="1주전" label=" 2주전"/>
				<form:radiobutton path="search_type" value="3" title="1주전" label=" 1달전"/>
			</td>
			</tr>
			</tbody>
			</table>
			<div class="center" style="padding:0 0 50px 0">
				<a id="search-btn" class="btnNew btn-warning btn-xs mT1">검색</a>
			</div>
		</div>


		<div class="search-wrap">

			<div class="smain">
				<div class="box">
					<div style="overflow:hidden">
						<div class="bbs-result">* 검색결과 총 : <b><fmt:formatNumber value="${paging.totalDataCount}" pattern="#,###"/></b>건</div>

						<div class="mode">
							<ul>
								<li><a href="#;" class="btn-View imgView on">이미지형 표지형 설정</a></li>
								<li><a href="#;" class="btn-View listView">목록형 표지형 설정</a></li>
							</ul>
						</div>
					</div>
					<div id="search-results" class="search-results wide">
						<!-- 이미지형 -->
						<div class="imageType">
							<!-- 결과루프 -->
							<c:choose>
								<c:when test="${fn:length(newBookList) > 0}">
									<c:forEach items="${newBookList}" var="i">
									<c:set var="detailURL" value="/intro/${context_path}/search/detail.do?isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
									<div class="row">
										<div class="thumb">
										<c:choose>
										<c:when test="${empty i.aladin or empty i.aladin.cover}">
										<a href="${detailURL}">
											<img src="/resources/common/img/noImg2.png" alt="등록된 이미지가 없습니다. ${i.VOL_TITLE} 상세보기"/>
											<span>등록된 이미지가<br/>없습니다.</span>
										</a>
										</c:when>
										<c:otherwise>
										<a href="${detailURL}">
											<img src="${i.aladin.cover}" alt="${i.TITLE_INFO} 상세보기"/>
										</a>
										</c:otherwise>
										</c:choose>

										</div>
										<div class="box">
											<div class="item">
												<div class="bif">
													<a href="${detailURL}">
													<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span></a>
													<p>
													<font style="color:#5e5e5e">저자</font> : ${i.AUTHOR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">출판정보</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">등록번호</font> : ${i.REG_NO}<br/><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span><br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">자료실</font> : ${i.SHELF_LOC_NAME}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<!-- 대출가능 여부 [START] -->
													<c:choose>
														<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
															<c:choose>
																<c:when test="${i.RESERVATION_CNT > '0'}">
																	<span style="color:#ff0000">대출불가(예약도서)</span>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																			대출불가(열람제한도서)
																		</c:when>
																		<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																			귀중자료(관내열람만가능)
																		</c:when>
																		<c:otherwise>
																			대출가능
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																	<span style="color:#ff0000">대출불가(관외대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																	<span style="color:#ff0000">대출불가(관내대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																	<span style="color:#ff0000">대출불가(타관반납중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																	<span style="color:#ff0000">대출불가(타관대출중)</span>
																</c:when>
																<c:otherwise>
																	<span style="color:#ff0000">대출불가</span>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
													<!-- 대출가능 여부 [ END ] -->
													</p>
												</div>
											</div>
										</div>
									</div>
									</c:forEach>
									<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
								</c:when>
								<c:otherwise>
									<br/>
									<c:choose>
									<c:when test="${empty librarySearch.booktype}">
									<h3> 도서관 선택 후 검색하세요. </h3>
									</c:when>
									<c:otherwise>
									<h3> 조회된 도서가 없습니다. </h3>
									</c:otherwise>
									</c:choose>
									<br/>
								</c:otherwise>
							</c:choose>
							<!-- 결과루프끝 -->
						</div>


						<!-- 텍스트형 -->
						<div class="textType" style="display:none">
							<!-- 결과루프 -->
							<c:choose>
								<c:when test="${fn:length(newBookList) > 0}">
									<c:forEach items="${newBookList}" var="i">
									<c:set var="detailURL" value="/intro/${context_path}/search/detail.do?isbn=${i.ST_CODE}&regNo=${fn:escapeXml(i.REG_NO)}&manageCode=${fn:escapeXml(i.MANAGE_CODE)}&booktype=${fn:escapeXml(librarySearch.booktype eq '0' ? 'BO' : 'SE')}"></c:set>
									<div class="row">
										<div class="box">
											<div class="item">
												<div class="bif">
													<a href="${detailURL}" class="name goDetail">
													<span style='color:#e84e0e;font-weight:600'>${i.TITLE_INFO}</span></a>
													<p>
													<font style="color:#5e5e5e">저자</font> : ${i.AUTHOR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">출판정보</font> : ${i.PUBLISHER}, ${i.PUB_YEAR}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">청구기호</font> : ${i.CALL_NO}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">등록번호</font> : ${i.REG_NO}<br/><font style="color:#5e5e5e">소장도서관</font> : <span style="color:#ff0000;font-weight:bold">${i.LIB_NAME}</span><br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<font style="color:#5e5e5e">자료실</font> : ${i.SHELF_LOC_NAME}<br class="mobileBr"/>
													<span class="webGuideLine" style="color:#dddddd">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
													<!-- 대출가능 여부 [START] -->
													<c:choose>
														<c:when test="${i.WORKING_STATUS == 'BOL112N'}">
															<c:choose>
																<c:when test="${i.RESERVATION_CNT > '0'}">
																	<span style="color:#ff0000">대출불가(예약도서)</span>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${i.USE_LIMIT_CODE eq 'CD'}">
																			대출불가(열람제한도서)
																		</c:when>
																		<c:when test="${i.USE_LIMIT_CODE eq 'IZ'}">
																			귀중자료(관내열람만가능)
																		</c:when>
																		<c:otherwise>
																			대출가능
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${i.WORKING_STATUS == 'BOL211O'}">
																	<span style="color:#ff0000">대출불가(관외대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL212O'}">
																	<span style="color:#ff0000">대출불가(관내대출중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL511O'}">
																	<span style="color:#ff0000">대출불가(타관반납중)</span>
																</c:when>
																<c:when test="${i.WORKING_STATUS == 'BOL611O'}">
																	<span style="color:#ff0000">대출불가(타관대출중)</span>
																</c:when>
																<c:otherwise>
																	<span style="color:#ff0000">대출불가</span>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
													<!-- 대출가능 여부 [ END ] -->
													</p>
												</div>
											</div>
										</div>
									</div>
									</c:forEach>
									<jsp:include page="/WEB-INF/views/app/intro/search/paging.jsp" flush="false" />
								</c:when>
								<c:otherwise>
									<br/>
									<c:choose>
									<c:when test="${empty librarySearch.booktype}">
									<h3> 도서관 선택 후 검색하세요. </h3>
									</c:when>
									<c:otherwise>
									<h3> 조회된 도서가 없습니다. </h3>
									</c:otherwise>
									</c:choose>
									<br/>
								</c:otherwise>
							</c:choose>
							<!-- 결과루프끝 -->

						</div>

					</div>
				</div>
			</div>

		</div>



	</div>
</form:form>
