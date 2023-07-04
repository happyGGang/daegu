<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.kyobo_img2 li div{border:1px solid #ddd;text-align:center;padding:30px 0;margin:10px 0;}
	.kyobo_img2 li div img{border:1px solid #e5e5e5;}

	h5{font-size:17px;margin-top:25px;font-weight:600;color:#ca0464;}
</style>


<div class="kyobo_bgbox bgbox">
	<div class="lf-txt">
		<p>
			<span class="tt">제한없는 전자책서비스</span><br>
			<span class="btit">구독형 전자책</span>
		</p>
		<br>

		<form name="frm_bukers_ebook" id="frm_bukers_ebook" method="post" action="https://www.bookers.life/front/home/loginSso.do" accept-charset="UTF-8" target="_blank">
		<input type="hidden" name="requestCode" value ="0000000354" >
		<input type="hidden" name="requestId" value ="${sessionScope.member.member_id}">
		<input type="hidden" name="requestName" value ="${sessionScope.member.member_name}">
			<ul class="btns_wrap_tac" style="margin:10px auto 10px;">
				<li>		
					<c:choose>
						<c:when test="${empty sessionScope.member.user_no or sessionScope.member.user_no eq '' or sessionScope.member.user_no eq 'null'}">
							<a href="#" class="btn_link04" title="구독형 전자책 바로가기(새창열림)" onclick="alert('정회원만 이용가능합니다.');"> <span>부커스 구독형 전자책 바로가기</span> <span class="ico ico_link"></span></a>
						</c:when>
						<c:otherwise>
							<a href="#" class="btn_link04" title="구독형 전자책 바로가기(새창열림)" onclick="dwBukersfrmsubmit();"> <span>부커스 구독형 전자책 바로가기</span> <span class="ico ico_link"></span></a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</form>

	</div>
</div>

<h3 class="contTit_line">구독형 전자책이란?</h3>
<ul class="con">
	<li>한도서당 이용자 수 제한이 없어 원하는 도서를 기다림없이 바로 이용할 수 있는 서비스</li>
</ul>

<h3 class="contTit_line">이용안내</h3>
<ul class="con">
	<li><strong>이용대상 :</strong> 대구통합도서관 정회원</li>
	<li><strong>대출정책</strong>
		<ul class="con2">
			<li>대출권수 : 월 1인 14권</li>
			<li>대출기간 : 15일(대출일포함)</li>
			<li>반납방법 : 자동반납(수동반납 불가)</li>
			<!-- <li>PC에서 이용 시 실행프로그램 다운로드(최초1회) 후 읽기 가능</li> -->
		</ul>
	</li>
</ul>

<h3 class="contTit_line">이용방법</h3>
<h4>PC 이용방법</h4>
<ul class="con kyobo_img">
	<li style="margin-top:0;">
		대구전자도서관 홈페이지 접속 후 대구통합도서관 아이디로 로그인<br />※ 회원가입, 로그인에 대한 문의는 공공도서관 담당자에게 문의<br />
		<img src="/data/menuResources/h30/101/1675244094592.jpg">
	</li>
	<li>
		구독형 전자책 아이콘 선택 후 구독형 전자책 바로가기를 클릭<br />
		<img src="/data/menuResources/h30/101/1675244099320.jpg">
	</li>
</ul>
<ul class="con kyobo_img2">
	<li style="margin-top:0;">
		<b>1. WEB</b><br />· 원하는 도서 선택 후 대출하기
		<div><img src="/data/menuResources/h30/101/1674610675013.jpg"></div>
	</li>
	<li>
		<b>2. 상세페이지</b><br />· 미리보기 : 전체도서의 5%내외 미리보기 가능<br />· 내서재에 추가 : 원하는 도서를 내서재에 담는 기능<br />· 바로 읽기 : 별도의 설치 없이 바로 읽기 가능 <br />
		<b>3. 대출완료 후 내서재에 추가 또는 바로 읽기 선택하여 책읽기(대출기한이 만료되면 자동반납)</b>
		<div><img src="/data/menuResources/h30/101/1674610680357.jpg"></div>
	</li>
	<h5>PC용 어플리케이션</h5>
	<li>
		<b>1.  PC용 앱 설치</b><br />· 부커스 페이지 하단 <b style="color:#ff0000;">앱 다운로드</b> 클릭<br />· 부커스 앱 PC버전. Windows, Mac 운영체제에서 앱 형태의 서비스 지원
		<div><img src="/data/menuResources/h30/101/1674610685282.jpg"></div>
	</li>
	<li>
		<b>2. 앱 다운로드</b><br />· PC > OS(Window/Mac) 선택<br />· PC용 어플리케이션 설치 후 로그인
		<div><img src="/data/menuResources/h30/101/1674610689929.jpg"></div>
	</li>
	<li>
		<b>1.  기관선택</b><br />· <b style="color:#ff0000;">"대구전자도서관"</b> 입력 후 하단에 리스트 박스가 생성되며 클릭하면 입력됩니다.<br />
		<b>2. 아이디 / 패스워드</b><br />· 기존 <b style="color:#ff0000;">"대구전자도서관"</b> 홈페이지 계정을 입력합니다.
		<div><img src="/data/menuResources/h30/101/1674610695313.jpg"></div>
	</li>
	<li>
		원하는 도서를 더블클릭 합니다.
		<div><img src="/data/menuResources/h30/101/1674610700838.jpg"></div>
	</li>
	<li>
		미리보기가 도서의 5%내외에서 지원됩니다.<br />내 서재에 추가하거나 지금 읽기를 클릭하여 바로 읽기가 가능합니다.
		<div><img src="/data/menuResources/h30/101/1674610705957.jpg"></div>
	</li>
</ul>

<h4>모바일 앱 이용방법</h4>
<ul class="con kyobo_img2">
	<li>
		<b>1. IOS</b><br />· APP Store에서 부커스 검색 후 어플리케이션 다운로드<br />· https://apps.apple.com/kr/app/부커스-bookers/id1521764865<br />
		<b>2. Android</b><br />· Google Play에서 부커스 검색 후 어플리케이션 다운로드<br />· https://play.google.com/store/apps/details?id=com.bookers.ebook<br />
		<b>3. APK 파일 (e-book 단말기 용)</b><br />· www.bookers.life 로 접속해서 하단의 앱다운로드 클릭<br />· MOBILE > APK 다운로드
		<div><img src="/data/menuResources/h30/101/1674610710838.jpg"></div>
	</li>
	<li>
		<b>1. 기관선택</b><br />· <b style="color:#ff0000;">"대구전자도서관"</b> 입력하면 하단에 리스트 박스가 생성되며 클릭하면 입력됩니다. <br />
		<b>2. 아이디 / 패스워드</b><br />· 기존 <b style="color:#ff0000;">"대구전자도서관"</b> 홈페이지 계정을 입력합니다. <br />※ 회원가입, 로그인에 대한 문의는 공공도서관 담당자에게 문의
		<div><img src="/data/menuResources/h30/101/1674610732178.jpg"></div>
	</li>
	<li>
		원하는 도서를 선택하거나 검색합니다.
		<div><img src="/data/menuResources/h30/101/1674610737663.jpg"></div>
	</li>
	<li>
		미리보기가 전체도서의 5%내외로 제공 됩니다.<br />내 서재에 추가 또는 바로 읽기를 선택하여 책읽기(대출기한이 만료되면 자동반납)
		<div><img src="/data/menuResources/h30/101/1674610742205.jpg"></div>
	</li>
</ul>





<script type="text/javascript">
	function dwfrmsubmit() {
		$('#frm_kyobo_ebook').submit();
	}

	function dwBukersfrmsubmit() {
		$('#frm_bukers_ebook').submit();
	}
</script>



<!-- <form name="frm_kyobo_ebook" id="frm_kyobo_ebook" method="post" action="https://daegu.dkyobobook.co.kr/frontapi/mmbrLnkg.ink" accept-charset="UTF-8" target="_blank">
	<input id="user_id" name="user_id" type="hidden" value="${sessionScope.member.member_id}"/>
	<input type="hidden" name="user_type" value ="T1">
	<input type="hidden" name="user_type_name" value ="회원">
	<input id="libraryCode" name="libraryCode" type="hidden" value="24709" />
	<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
	<div class="btn_area txt-center">
	<c:choose>
		<c:when test="${empty sessionScope.member.user_no or sessionScope.member.user_no eq '' or sessionScope.member.user_no eq 'null'}">
			<c:choose>
				<c:when test="${sessionScope.member.member_id eq 'ebookadmin'}">
					<a href="#" class="btn btn2 newWin" onclick="dwfrmsubmit();"> <b>구독형 전자책</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
				</c:when>
				<c:otherwise>
					<a href="#" class="btn btn2 newWin" onclick="alert('정회원만 이용가능합니다.');"> <b>구독형 전자책</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<a href="#" class="btn btn2 newWin" onclick="dwfrmsubmit();"> <b>구독형 전자책</b> <span>바로가기</span> <i class="fa fa-external-link"></i></a>
		</c:otherwise>
	</c:choose>
	</div>
</form> -->