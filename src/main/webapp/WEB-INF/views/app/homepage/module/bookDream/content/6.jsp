<%@ page language="java" pageEncoding="utf-8"%>

<h2>신청내역</h2>
<form method="get" action="">
	<ul class="con02 lpad01 lbook">
		<li>
			<span>도서관 :</span>
			<input type="checkbox" name="sch_src[]" id="andong" value="andong" /><label for="andong">안동</label>
			<input type="checkbox" name="sch_src[]" id="yongsang" value="yongsang" /><label for="yongsang">용상</label>
			<input type="checkbox" name="sch_src[]" id="pungsan" value="pungsan" /><label for="pungsan">풍산</label>
		<li>
			<span>상태  :</span>
			<input type="checkbox" value="0" id="r2521_0" name="sch_state[]" checked="checked" /><label for="r2521_0">대기</label>
			<input type="checkbox" value="10" id="r2521_10" name="sch_state[]" /><label for="r2521_10">신청</label> <input type="checkbox" value="13" id="r2521_13" name="sch_state[]" /><label for="r2521_13">재고있음</label>
			<input type="checkbox" value="15" id="r2521_15" name="sch_state[]" /><label for="r2521_15">주문중</label> <input type="checkbox" value="17" id="r2521_17" name="sch_state[]" /><label for="r2521_17">입고완료</label>
			<input type="checkbox" value="20" id="r2521_20" name="sch_state[]" /><label for="r2521_20">구매확정</label> <input type="checkbox" value="30" id="r2521_30" name="sch_state[]" /><label for="r2521_30">반납</label>
			<input type="checkbox" value="40" id="r2521_40" name="sch_state[]" /><label for="r2521_40">환불</label> <input type="checkbox" value="50" id="r2521_50" name="sch_state[]" /><label for="r2521_50">정산완료</label>
			<input type="checkbox" value="-10" id="r2521_-10" name="sch_state[]" /><label for="r2521_-10">회원취소</label> <input type="checkbox" value="-20" id="r2521_-20" name="sch_state[]" /><label for="r2521_-20">개인소장</label>
			<input type="checkbox" value="-90" id="r2521_-90" name="sch_state[]" /><label for="r2521_-90">관리취소</label>
		</li>
		<li><span>기간 :</span>
			<select name="sch_date">
				<option value="created" selected="selected">신청일자</option>
				<option value="payed">구매일자</option>
				<option value="return">반환일자</option>
				<option value="refund">환불일자</option>
				<option value="calc">정산일자</option>
			</select>
			<input type="text" class="text" name="sch_sta" value="2017-01-24" size="10" /> ~
			<input type="text" class="text" name="sch_end" value="2017-02-24" size="10" /> /
			<span>검색어 :</span>
			<select name="sch_field">
				<option value="title">도서명</option>
				<option value="author">저자</option>
				<option value="name" selected="selected">신청자</option>
				<option value="hp">전화번호</option>
			</select>
			<input type="text" class="text" name="sch_string" value="" />
			<button class="btn btn1 btn-small btn-inverse" type="submit">
				<span>검색</span>
			</button>
		</li>
	</ul>
</form>

<br/>

<h3>신청내역</h3>
<table class="tstyle lbook" summary="서점명, 대표자, 전화번호, 등록일, 관리에 대해 서점관리 부분을 안내하는 표입니다.">
	<caption class="blind">서점관리</caption>
	<colgroup>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
		<col/>
	</colgroup>
	<thead>
		<tr>
			<th>No</th>
			<th>이미지</th>
			<th class="left">
				<p class="stay">상태 (서점명)</p>
				신청도서 (<a
				href="/book/admin/request/list.php?odby=title&odsc=desc&page=1">도서명</a>
				/ <a
				href="/book/admin/request/list.php?odby=author&odsc=desc&page=1">저자</a>
				/ <a
				href="/book/admin/request/list.php?odby=publisher&odsc=desc&page=1">출판사</a>
				/ <a
				href="/book/admin/request/list.php?odby=pubdate&odsc=desc&page=1">출판일시</a>
				/ <a href="/book/admin/request/list.php?odby=price&odsc=desc&page=1">가격</a>)
			</th>
			<th><a
				href="/book/admin/request/list.php?odby=name&odsc=desc&page=1">신청자</a></th>
			<th>구매<br/>(<a
				href="/book/admin/request/list.php?odby=pay_type&odsc=desc&page=1">방법</a>
				/ <a href="/book/admin/request/list.php?odby=pay&odsc=desc&page=1">구매가</a>)
			</th>
			<th>일자<br/>(<a
				href="/book/admin/request/list.php?odby=created&odsc=asc&page=1">신청▼</a>
				/ <a href="/book/admin/request/list.php?odby=payed&odsc=desc&page=1">구매</a>)
			</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>121</td>
			<td><img src="http://bookthumb.phinf.naver.net/cover/105/276/10527693.jpg?type=m1&udate=20160511" /></td>
			<td class="left fb">
				<p class="stay">반납 (느낌표) [안동]</p>
				영화가 너의 고민을 들어 줄 거야 (십대가 알고 싶은 세상의 모든 것
				시리즈,직업,진학,공부 친구,가족,그리고 세상.고민하는 십대를 위한 영화 힐링 에세이)<br /> 저자 : 이다혜 /
				가격 : 12000<br /> 출판사 : 가나출판사 / 출판일 : 20160425<br /> ISBN :
				8957367802 9788957367803
			</td>
			<td>
				이경숙<br/>
				010-5207-6162<br/>
				lks000209@hanmail.net
			</td>
			<td>
				현금<br/>
				13,800
			</td>
			<td class="nowrap">
				<p>2017-02-11</p>
				<p>구매:2017-02-11</p>
				<p>반납:2017-02-24</p>
			</td>
			<td><a class="btn btn-small" href="/book/admin/request/form.php?exec=m&no=1415">수정</a></td>
		</tr>
	</tbody>
</table>

<br/>

<h2>신청내역 수정</h2>
<form method="post" action="/book/admin/request/process.php?exec=ma&no=1415">
	<table class="tstyle lbook" summary="서점명, 대표자, 아이디, 비밀번호, 전화번호를 수정할 수 있는 서점관리 표입니다.">
		<caption class="blind">서점관리 수정</caption>
		<colgroup>
			<col style="width:110px" />
			<col />
			<col style="width:400px" />
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>내용</th>
				<th>변경이력</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>상태</td>
				<td class="left">
					<select name="state">
						<option value="0">대기</option>
						<option value="10">신청</option>
						<option value="13">재고있음</option>
						<option value="15">주문중</option>
						<option value="17">입고완료</option>
						<option value="20">구매확정</option>
						<option value="30" selected="selected">반납</option>
						<option value="40">환불</option>
						<option value="50">정산완료</option>
						<option value="-10">회원취소</option>
						<option value="-20">개인소장</option>
						<option value="-90">관리취소</option>
					</select>
				</td>
				<td rowspan="8" style="text-align:left;" valign="top">
					<table>
						<thead>
							<tr>
								<th>일자</th>
								<th>행동</th>
								<th>상태</th>
								<th>아이피</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>2017-02-13 08:45:18</td>
								<td>등록</td>
								<td>-100</td>
								<td>10.41.75.61</td>
							</tr>
							<tr>
								<td>2017-02-13 08:45:18</td>
								<td>수정</td>
								<td>신청</td>
								<td>10.41.75.61</td>
							</tr>
							<tr>
								<td>2017-02-13 08:45:33</td>
								<td>수정</td>
								<td>회원취소</td>
								<td>10.41.75.61</td>
							</tr>
							<tr>
								<td>2017-02-24 11:57:15</td>
								<td>수정</td>
								<td>반납</td>
								<td>10.41.75.42</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>신청도서</td>
				<td class="left">영화가 너의 고민을 들어 줄 거야 (십대가 알고 싶은 세상의 모든 것 시리즈,직업,진학,공부 친구,가족,그리고 세상.고민하는 십대를 위한 영화 힐링 에세이)</td>
			</tr>
			<tr>
				<td>저자</td>
				<td class="left"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td class="left">12000</td>
			</tr>
			<tr>
				<td>도서관</td>
				<td class="left">안동 도서관</td>
			</tr>
			<tr>
				<td>서점</td>
				<td class="left">느낌표</td>
			</tr>
			<tr>
				<td>신청일자</td>
				<td class="left">2017-02-13 08:45:18</td>
			</tr>
			<tr>
				<td>구매일자</td>
				<td class="left">0</td>
			</tr>
			<tr>
				<td>반납일자</td>
				<td class="left">
					2017-02-24 11:57:15					(마감 : 지정안됨)
				</td>
			</tr>
			<tr>
				<td>신청자</td>
				<td class="left">강미정</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td class="left"><input class="text" type="text" name="hp" value="010-5180-8257" /></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td class="left"><input class="text" type="text" name="email" value="1" /></td>
			</tr>
			<tr>
				<td>집전화</td>
				<td class="left">1</td>
			</tr>
			<tr>
				<td>주소</td>
				<td class="left">
					[]<br />
					 1				</td>
			</tr>
		</tbody>
	
	</table>

	<div class="btn_menu center">
		<button type="submit" class="btn btn1 btn-primary btn-large btnWrite"><span>저장</span></button>
		<a class="btn btn-large" href="/book/admin/request/list.php">목록</a>
	</div>

</form>