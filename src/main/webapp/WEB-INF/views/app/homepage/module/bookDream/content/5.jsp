<%@ page language="java" pageEncoding="utf-8" %>

<div id="main">
	<div class="main_left">
		<h2>로그인</h2>
		<p class="guide_box"><strong>새 책 드림 Dream 서비스를 신청하시려면 <span class="red">로그인 후 이용</span> 가능합니다.</strong></p>
		<div class="login">
			<form method="post" action="login_process.php">
				<fieldset>
				<legend>로그인</legend>
					<div class="lib_radio">
						<input type="radio" name="src" value="andong" checked="checked" id="andonglib"><label for="andonglib">경상북도립안동도서관</label>
						<input type="radio" name="src" value="pungsan"  id="pungsan"><label for="pungsan">풍산분관</label>
						<input type="radio" name="src" value="yongsang"  id="yogsang"><label for="yogsang">용상분관</label>
					</div>
					<dl>
						<dt><label for="userID">아이디</label></dt>
						<dd><input id="userID" type="text" name="userId" value=""></dd>
						<dt><label for="userPw">비밀번호</label></dt>
						<dd><input id="userPW" name="userPw" type="password" value=""></dd>
					</dl>
					<span class="login_bt_lo"><input type="submit" class="login_btn" value="로그인"></span>
				</fieldset>
			</form>
		</div>
	</div>
	<p class="guide_box" style="position:absolute; top:626px;">
	<strong>[로그인 후 관외대출회원 인증방법]</strong><br />
	i) 홈페이지 메인 - 오른쪽상단 [대출현황 대출예약] 또는 [희망도서신청하기]<br />- 관외대출회원 로그인 - 대출자번호(회원증 회원번호) 입력 <br />
	ii) 자료검색 창 - 내서재 - 대출회원인증 - 대출자번호 입력<br />
	<span class="red">※ ⅰ,ⅱ 방법 중 선택하여 인증 후에는 [로그아웃] 후,<br />[새책드림서비스 신청하기에서 재로그인] 하여 이용하시기 바랍니다! </span>
	</p>
	
	<div class="main_right">
		<h2>새 책 드림 서비스</h2>
		<p class="guide_box">새 책 드림 Dream 서비스는 이용자가 도서관 미소장 도서를 협약 서점에서 구입해 2주간 이용하고 도서관에 반납하면 판매서점이 도서대금을 환불해주는 ‘이용자 희망도서 직접 구매 제도’입니다.</p>
		<ul class="con01">
			<li><strong>참여대상</strong>: 경상북도립안동도서관(본관, 용상•풍산분관)<br />
			<span style="padding-left:52px;">안동시 관내 서점, 도서관 회원</span></li>
			<li><strong>반납안내</strong>: 도서 구입일부터 15일 내 반납<br />
			<span style="padding-left:52px;color:red;">예) 2016년 7월 1일 구입 시, 2016년 7월 15일까지 반납</span></li>
			<li><strong>구입</strong>
				<ul class="con02">
					<li>구입신청: 1인 월 4권 이내 (1회 최대 2권 신청 가능)<br />
					<span style="padding-left:52px;">※ 동일 도서 불가</span></li>
					<li>구입처: 안동시 관내 지정 서점(6개)</li>
				</ul>
			</li>
			<li><strong>반납</strong>
				<ul class="con02">
					<li>반납처: 본관 1층 문헌정보계, 용상분관, 풍산분관</li>
					<li>반납확인: 도서관 회원카드와 구입 영수증 지참(본인 및 가족)</li>
					<li>오·훼손: 오염 및 훼손된 도서는 반납대상에서 제외<br />※ 본관 및 용상분관, 풍산분관은 각각 별도로 운영되오니 구입을 신청한
					<br /><span style="padding-left:15px;">도서관으로 반납하시길 바랍니다.</span></li>
				</ul>
			</li>
			<li><strong>환불</strong>
				<ul class="con02">
					<li>환불처: 도서를 구입한 서점</li>
					<li>기타 환불에 관한 사항: 이용자와 서점에 일임</li>
				</ul>
			</li>
		</ul>
	</div>
</div>