<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(function(){
	
});
</script>
<style>
	.doc-body h2{background: none;}
	#cont_wrap{padding:20px 0 60px;font-size:15px;font-weight:normal;font-family:'NotoKrR';line-height:160%;letter-spacing:-0.02em;}
	.icon_box{text-align:left;border:1px solid #dbdbdb;padding:30px;}
	.icon_box .area{display:inline-block;padding-left:250px;text-align:left;letter-spacing:-0.05em;background-position:left top;background-repeat:no-repeat;word-break:keep-all;}
	.icon_box p.bx_tit{font-weight:normal;font-family:'NotoKrM';font-size:23px;color:#222;line-height:40px;margin-top:20px;}
	.icon_box p.bx_txt{font-size:16px;color:#555;margin-top:20px;}
	.icon_box p.bx_txt.b{font-size:15px;color:#222;font-weight:normal;font-family:'NotoKrM';margin-top:15px;}
	.icon_box p.bx_txt strong{color:#222;}
	.icon_box .area.icon01{background-image:url(/resources/board/img/iconbox_icon01.gif);min-height:170px;}
	
	a.link_go{font-family:'Roboto';letter-spacing:0;font-size:16px;text-decoration:underline;color:#555;padding:5px 20px 0 10px;background:url(/resources/board/img/icon_blank.png) no-repeat 135px 7px;}
	a.link_go:hover{color:#278eda;}

	.mara{display:inline-block;width:100%;margin-top:50px;}
	.mara h3{float:left;}
	.mara p{float:left;font-weight:normal;font-family:'Roboto','NotoKrM';padding-left:20px;font-size:20px;margin-top:21px;}
	.mara p.maratxt{color:#ee005e;}
	
	h3.tit{padding-top:20px;margin-bottom:25px;background:url(/resources/board/img/h3_bar.png) no-repeat 0 0;font-weight:normal;font-family:'NotoKrM';font-size:23px;font-weight:normal;color:#222;line-height:1.2;letter-spacing:-0.05em;}
	h3.tit.h3_t{margin-top:55px;}
	h3 span.stxt{font-weight:normal;font-family:'NotoKrM';color:#555;font-size:15px;padding-left:10px;}
	table.table1{width:100%;border-collapse:collapse;border:1px solid #dbdbdb;border-top:1px solid #ee005e;}
	table.table1 th,
	table.table1 td{padding:15px 10px;font-size:15px;text-align:center;color:#222;}
	table.table1 thead th{border-left:1px solid #dbdbdb;background:#feebf2;}
	table.table1 tbody th,
	table.table1 tbody td{border:1px solid #dbdbdb;line-height:22px;}
	table.table1 tbody td{color:#555;}
	table.table1 tbody td > p strong{font-weight:font-weight:normal;font-family:'NotoKrB';}
	table.table1 tbody td > p.left2{padding-left:70px;}
	table.table1 tbody td.eng{font-family:'Roboto','NotoKrR';font-weight:400;font-size:15px;letter-spacing:0;}
	table.table1 tbody td.left{text-align:left;padding-left:20px;}
	table.table1 tbody td.right{text-align:right;}
	table.table1 tbody td dl {display:inline-block;width:100%;}
	table.table1 tbody td dl dt{font-weight:bold;font-family:'NotoKrB';float:left;}
	table.table1 tbody td dl dd{float:left;padding-left:5px;}
	table.table1 .blue{color:#278eda;}
	
	.step_all{margin-top:20px;}
	.step{position:relative;margin-top:20px;}
	.step:first-child{margin-top:0;}
	.step_bx.icon01{background:url(/resources/board/img/step_icon01.gif) no-repeat 70px center;}
	.step_bx.icon02{background:url(/resources/board/img/step_icon02.gif) no-repeat 70px center;}
	.step_bx.icon03{background:url(/resources/board/img/step_icon03.gif) no-repeat 70px center;}
	.step_bx.icon04{background:url(/resources/board/img/step_icon04.gif) no-repeat 70px center;}
	.step_bx.icon05{background:url(/resources/board/img/step_icon05.gif) no-repeat 70px center;}
	
	.step p.step_num{width:70px;height:55px;padding-top:15px;margin-top:-35px;border-radius:70px;color:#fff;position:absolute;top:50%;left:15px;text-align:center;font-family:'Roboto';font-size:14px;font-weight:500;line-height:20px;letter-spacing:0;background:#ee005e;}
	.step p.step_num span{display:block;font-size:20px;}
	.step .step_bx{border:1px solid #dbdbdb;margin-left:60px;border-radius:10px;}
	.step .step_bx .inner_bx{padding:50px 0 50px 60px;margin:10px 0 10px 190px;font-size:17px;color:#278eda;font-weight:normal;font-family:'NotoKrM';border-left:1px dashed #dbdbdb;}
	.step .step_bx .inner_bx.inner2{padding:0 0 0 39px;margin-right:3px;}
	/* .step .step_bx .inner_bx span{font-family:'Roboto','NotoKrM';font-weight:500;font-size:15px;color:#555;padding-left:10px;} */
	.step .step_bx dl:first-child{border-top:0;}
	.step .step_bx dl{display:inline-block;width:100%;border-top:1px dashed #dbdbdb;padding:20px 0;}
	.step .step_bx dl dt{float:left;padding-left:20px;}
	.step .step_bx dl dd{float:left;font-size:15px;color:#555;padding-left:25px;}
	
	ul.list{}
	ul.list li{padding-left:13px;margin-bottom:5px;font-size:15px;font-weight:normal;font-family:'NotoKrR';color:#222;line-height: 24px;background:url(/resources/board/img/bu_list.gif) no-repeat 0 7px;}
	ul.list li span.blue,
	ul.list2 li span.blue{color:#278eda;font-weight:bold;}
	ul.list li ul.list2{margin:5px 0 10px 0;}
	ul.list2 li{font-weight:normal;font-family:'NotoKrR';padding-left:10px;margin-bottom:3px;line-height:22px;font-size:14px;color:#666;background:url(/resources/board/img/bu_list02.gif) no-repeat left 8px;}
	.mt10 {margin-top:10px;}
	.mscroll_guide {display: none;}
</style>
<h2>대회안내</h2>

<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
<div id="cont_wrap">
	<div class="icon_box">
		<div class="area icon01">
			<p class="bx_tit">제 14회 달서독서마라톤대회 개체</p>
			<p class="bx_txt">
				새롭게 도약하는 희망달서를 구현하기 위하여 제12회 달서독서마라톤 대회를 개최함으로써 지역주민의 독서생활화운동 정착과 가족 독서문화 분위기 조성에 기여하고자 합니다.
			</p>
		</div>
	</div>
	<div class="mara">
		<h3 class="tit">접수기간</h3>
		<p class="maratxt">2020년 3월 3일~4월 29일</p>
	</div>
	<div class="mara">
		<h3 class="tit">대회기간</h3>
		<p class="maratxt">2020년 5월 1일~9월 30일</p>
	</div>
	<div class="mara">
		<h3 class="tit">참가자격</h3>
		<p>달서구민(초등생 이상)또는 달서구 소재 학교 재학생</p>
	</div>
	<h3 class="tit">
		대회종목
		<span class="stxt">4개종목</span>
	</h3>
	<div class="mscroll_guide">
		<span>모바일로 확인하실 경우</span>
		표를 좌우로 움직여 내용을 확인 하실 수 있습니다.
	</div>
	<div class="mscroll">
		<table class="table1" summary="대회종목을 쪽수, 대상, 1일 평균 독서량, 비고로 나타낸 표">
			<caption>달서구 독서마라톤 ${fn:length(marathonTypeList)}가지 대회종목</caption>
			<colgroup>
				<col width="10%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="*%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">종 목</th>
					<th scope="col">쪽 수</th>
					<th scope="col">대 상</th>
					<th scope="col">1일 독서량 (평균)</th>
					<th scope="col">비고</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row" class="eng">3km</th>
					<td class="eng">3,000쪽</td>
					<td>초등1~3학년</td>
					<td class="eng">23쪽</td>
					<td rowspan="4" class="left">
						<dl>
							<dt>시상 :</dt>
							<dd>12명(종목별 3명, 달서구청장상)</dd>
						</dl>
						<dl>
							<dt>시상식 :</dt>
							<dd>2020년 11월 예정</dd>
						</dl>
						<dl>
							<dt>완주자 :</dt>
							<dd>완주증서 또는 완주메달 배부<br>
								※ 대회 신청시 본인 선택, 11월 중 전달
							</dd>
						</dl>
					</td>
				</tr>
				<tr>
					<th scope="row" class="eng">5km</th>
					<td class="eng">5,000쪽</td>
					<td>초등4~6학년</td>
					<td class="eng">38쪽</td>
				</tr>
				<tr>
					<th scope="row" class="eng">7km</th>
					<td class="eng">7,000쪽</td>
					<td>중학생 이상,<br>일반인</td>
					<td class="eng">53쪽</td>
				</tr>
				<tr>
					<th scope="row">하프코스</th>
					<td class="eng">21,097쪽</td>
					<td>초등생~성인</td>
					<td class="eng">158쪽</td>
				</tr>
			</tbody>
		</table>
	</div>
	<h3 class="tit h3_t">참가신청</h3>
	<div class="step_all">
		<div class="step">
			<p class="step_num">
				STEP
				<span>01</span>
			</p>
			<div class="step_bx icon01">
				<div class="inner_bx">
					달서구립도서관 홈페이지 접속
					<a href="http://www.dalseolib.kr/" class="link_go" target="_blank">www.dalseolib.kr</a>
				</div>
			</div>
		</div>
		<div class="step">
			<p class="step_num">
				STEP
				<span>02</span>
			</p>
			<div class="step_bx icon02">
				<div class="inner_bx inner2">
					<dl>
						<dt>신규회원</dt>
						<dd>신상정보 정확하게 기재하여 회원가입</dd>
					</dl>
					<dl>
						<dt>기존회원</dt>
						<dd>기존정보 변경사항 수정</dd>
					</dl>
				</div>
			</div>
		</div>
		<div class="step">
			<p class="step_num">
				STEP
				<span>03</span>
			</p>
			<div class="step_bx icon03">
				<div class="inner_bx">달서독서마라톤 클릭</div>
			</div>
		</div>
		<div class="step">
			<p class="step_num">
				STEP
				<span>04</span>
			</p>
			<div class="step_bx icon04">
				<div class="inner_bx">참가신청</div>
			</div>
		</div>
		<div class="step">
			<p class="step_num">
				STEP
				<span>05</span>
			</p>
			<div class="step_bx icon05">
				<div class="inner_bx">
					독서마라톤 일지작성
					<span>홈페이지 상의 일지에 매일 독서분량의 감상문 기록</span>
				</div>
			</div>
		</div>
	</div>
	<h3 class="tit h3_t">세부일정</h3>
	<div class="mscroll_guide">
		<span>모바일로 확인하실 경우</span>
		표를 좌우로 움직여 내용을 확인 하실 수 있습니다.
	</div>
	<div class="mscroll">
		<table class="table1" summary="세부일정을 신청, 대회기간 특강으로 구분짓고, 일시, 내용을 나타낸 표">
			<caption>달서구 독서마라톤 세부일정</caption>
			<colgroup>
				<col width="13%">
				<col width="18%">
				<col width="*">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">구 분</th>
					<th scope="col">일 시</th>
					<th scope="col">내 용</th>
					<th scope="col">비 고</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>신청</td>
					<td>
						2020.3.3.(화)<br>~4.29.(목)
					</td>
					<td class="left">
						<strong>달서구립도서관홈페이지</strong>
						<a href="http://www.dalseolib.kr/" class="link_go" target="_blank">www.dalseolib.kr</a>
						에서
						<br>
						회원가입 후 <strong>「2020 달서독서마라톤 대회」신청</strong>
					</td>
					<td rowspan="5"></td>
				</tr>
				<tr>
					<td>대회기간</td>
					<td>
						2020.5.1.(금)<br>~9.30.(수)
					</td>
					<td class="left">
						개인 독서 이력을 「달서 독서 마라톤」홈페이지에 접속하여
						<br>
						<strong>마라톤 일지 기록 및 관리</strong>
					</td>
				</tr>
				<tr>
					<td>특강</td>
					<td>확정 시 별도 안내</td>
					<td class="left">
						<dl>
							<dt>대상 : </dt>
							<dd>지역주민누구나</dd>
						</dl>
						<dl>
							<dt>강의내용 : </dt>
							<dd>달서독서마라톤대회 마라톤 일지 심사기준, 글 쓰는 방법 안내 등</dd>
						</dl>
						<dl>
							<dt>강사 : </dt>
							<dd>홍익선(대구문인협회 부회장)</dd>
						</dl>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<h3 class="tit h3_t">
		완주자 및 수상자 발표
		<span class="stxt">2020년 11월 중 홈페이지에서 확인 가능</span>
	</h3>
	<p class="blue mb10">· 수상심사: 100점(목표달성30, 주기적습관20, 다양성20, 독후감30)</p>
	<table class="table1" summary="수상심사">
		<caption>수상심사</caption>
		<colgroup>
			<col width="8%">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th>1차<br>(70점)
				<td class="left">
					<ul class="list">
						<li>심사기준에 따라 집계된 점수로 종목별 10명을 선정</li>
						<li>목표달성(30점): 목표 달성시 만점 부여</li>
						<li>주기적 습관(20점): 대회기간 전체 19週에서미기록 週는1점씩 감점</li>
						<li>다양성(20점): 도서관 10진 분류 중 읽지 않는 분류에 대해 2점 감점
							<ul class="list2">
								<li>실격처리: 목표 미달성, 쪽수 부정기입, 완주심사에 따른 부적격자</li>
								<li>동점자 발생 시, 읽은 쪽수가 많은 순으로 선발</li>
							</ul>
						</li>
					</ul>
				</td>
			</tr>
			<tr>
				<th>2차<br>(30점)</th>
				<td class="left">
					<ul class="list">
						<li>1차 심사를 통과한 종목별 10명에 대한 감상문 심사</li>
						<li>내용의 깊이와 이해력(10점), 감상의 독창적 표현력(10점), 도서 선정의 적정성(10점)</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="left">
					<ul class="list">
						<li>필요시 해당참가자에게 증빙서류 제출 요청, 증빙되지 않는 기록은 완주기록에서 제외</li>
						<li>1·2차 심사점수를 함산하여 고득점자를 선발하되, 읽은 쪽수가 많은 순으로 수상자 선발</li>
						<li class="blue">
							<strong>전 대회 수상자는 동일 부문 수상에서 제외</strong>
						</li>
					</ul>
				</td>	
			</tr>
		</tbody>
	</table>
	<p class="mt10">
		· 세부 운영 및 문의는 달서구립성서도서관(053-667-4900) 또는 달서독서마라톤 대회 홈페이지 공지사항 및 FAQ를 참조하시기 바랍니다.
	</p>
</div>