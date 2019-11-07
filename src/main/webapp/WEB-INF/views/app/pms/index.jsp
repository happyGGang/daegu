<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
<c:if test="${!fn:contains(asideHomepageId, 'h')}">
// 	alert('잘못된 경로로 접근하였습니다.');
// 	location.href="/cms/index.do";
	location.href="/pms/board/index.do?menu_idx=2&manage_idx=563&category1=0000";
	
</c:if>
<c:if test="${fn:contains(asideHomepageId, 'h')}">
	location.href="/pms/board/index.do?menu_idx=2&manage_idx=563&category1=0000";
</c:if>
	
</script>

		<!-- <div class="sc_tab">
			<ul>
				<li class="first"><a href="#sc_tab_1">공지사항</a></li>
				<li><a href="#sc_tab_2">프로그램</a></li>
				<li><a href="#sc_tab_3" class="active">디자인</a></li>
				<li class="fourth"><a href="#sc_tab_4">도서관프로그램</a></li>
				<li><a href="#sc_tab_5">H/W시스템</a></li>
				<li><a href="#sc_tab_6">기타 A/S</a></li>
			</ul>
		</div>
		
		<div class="sc_tabCon">
			search S
			<div class="search_m">
				<form>
					<fieldset>
						<select class="selectmenu" style="width:200px;background:#eee;border:0;border-radius:0;font-size:12px">
							<option selected="selected">도서관검색(도서관명or도메인)</option>
							<option>도서관명</option>
							<option>도메인</option>
						</select>
						<input type="text" class="text" placeholder="검색어를 입력하세요"/>
						<button><span>SEARCH</span></button>
					</fieldset>
				</form>
			</div>
			search E
			<div class="wrapper-bbs">
				<select class="selectmenu" style="width:80px">
					<option disabled="disabled"  selected="selected">날짜정렬</option>
					<option>최신순</option>
					<option>처리현황순</option>
					<option>답변등록순</option>
				</select>
				<select class="selectmenu" style="width:80px">
					<option disabled="disabled"  selected="selected">분류선택</option>
					<option>전체</option>
					<option>대기</option>
					<option>접수</option>
					<option>완료</option>
				</select>
				<div class="f_r">
					<a href="" class="btn btn01">접수</a> <a href="" class="btn btn02">처리중</a> <a href="" class="btn btn03">답변완료</a> <a href="" class="btn btn04">확인요망</a>
				</div>
			</div>
			<span class="bbs-result">
				<em>TOTAL : 989561542</em>
				<em>PAGE : 11/3126</em>
			</span><br />
			일반 목록형 여기부터
			<table class="bbs center">
				<thead>
					<tr>
						<th class="mmm1">번호</th>
						<th>사이트명</th>
						<th class="mmm1">분류</th>
						<th>제목</th>
						<th>작성일</th>
						<th>처리현황</th>
						<th class="mmm1">지역</th>
						<th class="mmm1">처리자</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="mmm1 num red_">20</td>
						<td class="left">점촌공공도서관</td>
						<td class="mmm1">[질문]</td>
						<td class="important left"><a href="/board/view.jsp"><span>수정부탁드립니다.</span></a></td>
						<td class="num">2016-08-30 11:01</td>
						<td class="file"><span class="btn btn01">접수</span></td>
						<td class="mmm1">영천</td>
						<td class="mmm1">홍길동</td>
					</tr>
					<tr>
						<td class="mmm1 num red_">19</td>
						<td class="left">삼국유사군위도서관</td>
						<td class="mmm1">[기타]</td>
						<td class="important left"><a href="/board/view.jsp"><span>게시판 추가 요청</span></a></td>
						<td class="num">2016-08-30 11:01</td>
						<td class="file"><span class="btn btn02">처리중</span ></td>
						<td class="mmm1">영천</td>
						<td class="mmm1">홍길동</td>
					</tr>
					<tr>
						<td class="mmm1 num red_">18</td>
						<td class="left">영주풍기분관</td>
						<td class="mmm1">[질문]</td>
						<td class="important left"><a href="/board/view.jsp"><span>홈페이지 웹 취약점 보완</span></a></td>
						<td class="num">2016-08-30 11:01</td>
						<td class="file"><span class="btn btn03">답변완료</span ></td>
						<td class="mmm1">영천</td>
						<td class="mmm1">홍길동</td>
					</tr>
					<tr>
						<td class="mmm1 num red_">17</td>
						<td class="left">영주풍기분관</td>
						<td class="mmm1">[질문]</td>
						<td class="important left"><a href="/board/view.jsp"><span>파일 다운로드시 경고문구 수정</span></a></td>
						<td class="num">2016-08-30 11:01</td>
						<td class="file"><span class="btn btn04">확인요망</span ></td>
						<td class="mmm1">영천</td>
						<td class="mmm1">홍길동</td>
					</tr>
				</tbody>
			</table>
				일반 목록형 여기까지
				<div class="search txt-center" style="margin-top:25px;">하단 정렬 시 margin-top 입력
				<form>
					<fieldset>
						<label><i class="fa fa-search"></i><span>SEARCH</span></label>
						<select class="selectmenu" style="width:100px">
							<option selected="selected">사이트이름</option>
							<option>제목</option>
							<option>내용</option>
						</select>
						<input type="text" class="text"/>
						<button><span>검색</span></button>
					</fieldset>
				</form>
			</div>
			
			<div class="dataTables_paginate">
				<a class="paginate_button first disabled"><i class="fa fa-angle-double-left"></i><span class="blind">처음</span></a>
				<a class="paginate_button previous"><i class="fa fa-angle-left"></i><span class="blind">이전</span></a>
				<span>
					<a class="paginate_button current">1</a>
					<a class="paginate_button">2</a>
				</span>
				<a class="paginate_button next"><i class="fa fa-angle-right"></i><span class="blind">다음</span></a>
				<a class="paginate_button end"><i class="fa fa-angle-double-right"></i><span class="blind">마지막</span></a>
			</div>
			<br />
			<br />
			
			<div class="bbs-notice">
				<p class="tit"> <span class="orange"><b>저작권신고안내</b></span></p>
				<p class="con"> 본 사이트는 대한민국 저작권법을 준수합니다. <a href=""><b>[저작권신고안내]</b></a><br />
				회원은 공공질서나 미풍양속에 위배되는 내용과 타인의 저작권을 지적재산권 및 기타 권리를 침해하는 내용물에 대하여는 등록할 수 없으며,
				만일 이와 같은 내용의 게시물로 인해 발생하는 결과에 대한 모든 책임을 회원 본인에게 있습니다.<br />
				개인정보보호법에 의거하여 <span class="orange">주민등록번호, 연락처, 주소, 직업 등의 게시나 등록을 금지</span>합니다.</p>
			</div>
	
		</div> -->