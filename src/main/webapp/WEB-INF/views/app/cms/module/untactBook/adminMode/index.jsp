<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>





<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta id="_csrf" name="_csrf" th:content=""/>
<meta id="_csrf_header" name="_csrf_header" th:content=""/>
<title>WBuilder - 더블유빌더</title>
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<![endif]-->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10"/>
<link rel="icon" type="image/x-icon" href="/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="https://www.gbelib.kr/resources/common/css/default.css"/>
<link rel="stylesheet" type="text/css" href="https://www.gbelib.kr/resources/common/css/fontawesome.min.css"/>
<link rel="stylesheet" type="text/css" href="https://www.gbelib.kr/resources/common/css/jquery-ui-1.12.0.min.css"/>
<link rel="stylesheet" type="text/css" href="https://www.gbelib.kr/resources/common/css/select2.min.css"/>
<link rel="stylesheet" type="text/css" href="https://www.gbelib.kr/resources/cms/survey/css/container.css"/>

<script type="text/javascript" src="https://www.gbelib.kr/resources/common/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://www.gbelib.kr/resources/common/js/jquery-ui-1.12.0.min.js"></script>
<script type="text/javascript" src="https://www.gbelib.kr/resources/common/js/jquery-ui-1.12.0-datepicker.min.js"></script>
<script type="text/javascript" src="https://www.gbelib.kr/resources/common/js/common.js"></script>
<script type="text/javascript" src="https://www.gbelib.kr/resources/cms/js/design.js"></script>

<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/fontawesome-ie7.min.css"/>
<![endif]-->
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="/resources/cms/css/ie-old.css"/>
<![endif]-->
</head>
<body>
	<!--해당 화면만 대구 및 경북에 사용을 위해 스타일을 별도로 빼지 않음-->
	<style>
	/*비대변관련 스타일*/
	.wrapper {overflow:hidden;}
	.wrapper.wrapper-white {padding:0;margin:0;}
	.locker-box {width:45%;float:left;box-sizing:border-box;max-height:920px;overflow-y:auto;}
	.untact-box {width:55%;float:left;box-sizing:border-box;max-height:920px;overflow-y:auto;}
	.locker-box ul {font-size:0;overflow:hidden;}
	.locker-box li {float:left;display:inline-block;background:url('/resources/cms/img/locker-bg.png') no-repeat center center;background-size:100% 100%;height:230px;line-height:230px;padding:0;margin:0;border:1px solid #fff;box-sizing:border-box;text-align:center;}
	.locker-box li p {display:block;box-sizing:border-box;padding:15% 0;margin:0;height:50%;font-size:18px;font-weight:800;color:#000;}
	.locker-box li p:first-child {font-size:25px;}
	.locker-box li.divide2 {width:50%;}
	.locker-box li.divide3 {width:33.33333333333%;}
	.locker-box li.divide4 {width:25%;}
	.locker-box li.divide5 {width:20%;}
	.untact-box tbody td {height:45px;line-height:45px;}
	a.btnuntact {border-radius:0;padding:7px 10px;}

	@media all and (max-width:1280px){
		.locker-box, .untact-box {max-height:720px;}
		.locker-box li {height:180px;line-height:180px;}
	}

	@media all and (max-width:1024px){
		.locker-box, .untact-box {max-height:600px;}
		.locker-box li {height:150px;line-height:150px;}
	}

	@media all and (max-width:768px){
		.locker-box, .untact-box {width:100%;float:none;}
	}

	@media all and (max-width:600px){
		.locker-box, .untact-box {max-height:520px;}
		.locker-box li {height:130px;line-height:130px;}
	}

	@media all and (max-width:425px){
		.locker-box, .untact-box {max-height:480px;}
		.locker-box li {height:120px;line-height:120px;}
	}

	@media all and (max-width:330px){

	}
	</style>
<div id="wrap">

	<div id="container">
		<div class="page-subtitle">
			<h3>
				비대면 신청관리(사물함사용시)
			</h3>
			<div class="location">
				홈페이지모듈관리</span>
				<em>&gt;</em>
				<strong>비대면 신청관리(사물함사용시)</strong>
			</div>
		</div>
		<div class="wrapper wrapper-white">

			<div class="cont-box">
				<div class="locker-box">
					<ul>
						<!-- 3 x n 으로 혹은 4 x n으로 갈떄 CLASS를 divide3 혹은 divide4 등으로 주면 됩니다. 즉 3xn하면 divide3, 4xn하면 divide4 -->
						<c:forEach var="i" varStatus="status" begin="1" end="${untactBookSetting.total_count}">
						<li class='divide${untactBookSetting.row_count}'>
							<p class="locknumber">${status.index}</p>
							<p class="name">
								설현
							</p>
						</li>
						</c:forEach>
					</ul>
				</div>
				
				<div class="untact-box">
					<div style="text-align:right;padding-top:10px;padding-bottom:10px;">
						<a href="#" class="btn btn1 btnuntact">비밀번호랜덤생성</a>
					</div>
					<div class="table-wrap">
						<table class="type1 center">
							<thead>
								<tr>
									<th scope="col">선택</th>
									<th scope="col">번호</th>
									<th scope="col">신청자아이디</th>
									<th scope="col">대출번호</th>
									<th scope="col">신청자명</th>
									<th scope="col">도서명</th>
									<th scope="col">사물함번호</th>
									<th scope="col">비밀번호</th>
									<th scope="col">관리</th>
								</tr>
							</thead>
							<tbody>
								
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>1</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>1</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>2</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>2</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>3</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>3</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>4</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>4</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>5</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>5</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>6</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>6</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>7</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>7</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>8</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>8</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>9</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>9</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>10</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>10</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>11</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>1</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>12</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>2</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>13</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>3</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>14</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>4</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>15</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>5</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>16</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>6</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>17</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>7</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>18</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>8</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>19</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>9</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="" id="" value="" /></td>
									<td>20</td>
									<td>user_id</td>
									<td>12312312312312</td>
									<td>설현</td>
									<td>세상을 읽는 새로운 언어 빅데이터</td>
									<td>10</td>
									<td>12**</td>
									<td>
										<a href="#" id="setBook" class="btn btn1 btnuntact">비치</a>
										<a href="#" id="loanBook" class="btn btn2 btnuntact">대출</a>
										<a href="#" class="btn btnuntact">취소</a>
										<a href="#" class="btn btn5 btnuntact">패널티부여</a>
									</td>
								</tr>

							</tbody>
						</table>
					</div>
					<div style="padding-top:10px;">
						<a href="#" class="btn btn3 btnuntact">전체선택</a> <a href="#" class="btn btn4 btnuntact">전체삭제</a> <a href="#" id="excelDownload" class="btn btn2 btnuntact">엑셀저장</a>
					</div>

					<div class="search txt-center" style="margin-top:25px;"><!-- 하단 정렬 시 margin-top 입력 -->
						<fieldset>
							<select id="search_type" name="search_type" class="selectmenu"><option value="member_id">사용자ID</option><option value="member_name">사용자명</option><option value="reason">사유</option><option value="add_id">신청자ID</option></select><input id="search_text" name="search_text" class="text" style="width:200px;" type="text" value=""/><button id="search_btn"><i class="fa fa-search"></i><span>검색</span></button>
						</fieldset>
					</div>
				</div>

				<div style='clear:both;'></div>
			</div>

		</div>

		<div id="dialog-1" class="dialog-common" title="시설물 정보"></div>
		<div id="dialog-2" class="dialog-common" title="시설물 신청 정보"></div>
		<div id="dialog-3" class="dialog-common" title="시설물 신청 현황"></div>
	</div>


	<div class="copyright">
		<div class="pull-left">
			&copy; 2016 <strong>WBuilder</strong>. All rights reserved.
		</div>
		<div class="pull-right">
			<a href="/index.do" target="_blank">대표홈페이지 바로가기</a>
		</div>
	</div>

</div>

</body>
</html>	