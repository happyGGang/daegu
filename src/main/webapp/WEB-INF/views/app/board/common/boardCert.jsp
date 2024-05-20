<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
var idCheck = false;
var pwCheck = false;
var pwCheck2 = false;
$(function() {

	$('a.certtype').on('click', function(e) {
		e.preventDefault();
		if ( $('input[name="agree_codes"][req="0001"]:checked').length == $('input[name="agree_codes"][req="0001"]').length ) {

			var parent = $(this).parent('div').find('p.success').length;
			if (parent > 0) { return false; }
			var wWidth = 360;
	 		var wHight = 120;
	 		var wX = (window.screen.width - wWidth) / 2;
	 		var wY = (window.screen.height - wHight) / 2;
			var certWindow = window.open('', "certWindow", "directories=no,toolbar=no,resizeable=yes,left="+wX+",top="+(wY-200)+",width="+wWidth+",height="+wHight);
			$('form#certForm input[name=certType]').val($(this).attr('id'));
			$('form#certForm')[0].submit();
		}
		else {
			alert('약관에 동의해 주시기 바랍니다.');
			false;
		}

	});

});
</script>

<div class="join-wrap" style="padding: 0">
<!-- 	<h4>개인정보의 수집·이용 동의</h4> -->

	<c:choose>
	<c:when test="${homepage.context_path eq 'gosan'}">
		<div class="Box" style="height:200px">
			<h5>♣ 개인정보 수집 및 이용 주체</h5>
			<br>
			<p>도서관 홈페이지 서비스 제공에 따른 개인정보 수집 및 이용 주체는 아래와 같습니다.</p>
			  <ul>
				<li>  - 회원정보 : 정보자료팀</li>
			  </ul>
			<br>
			<h5>♣ 개인정보 수집 및 이용 목적</h5>
			<br>
			<p>수집된 개인정보는 아래와 같이 정해진 목적 이외의 용도로는 사용되지 않습니다.</p>
			  <ul>
				<li>  - 게시판 이용자 정보 : 게시판 이용자의 신원확인과 신고접수 및 처리 확인 용도</li>
			  </ul>
			<br>
			<h5>♣ 수집하는 개인정보의 항목</h5>
			<br>
			<p>홈페이지 개인정보 수집 및 이용에 관한 동의 절차 완료 후 최소한의 정보만 수집합니다.</p>
			<p>홈페이지 신고센터는 필수정보를 아래와 같이 수집하고 있습니다.</p>
			  <ul>
				<li>  - 필수항목 : 이름</li>
			  </ul>
			<br>
			<h5>♣ 개인정보의 보유 및 이용 기간</h5>
			<br>
			<p>아래와 같이 동의 받은 개인정보의 보유 및 이용기간 내에서만 개인정보를 처리 및 보유합니다.</p>
			  <ul>
				<li>  - 보유기간 : 게시글 삭제 시 까지</li>
			  </ul>
			<br>
			<h5>♣ 개인정보주체는 동의를 거부할 권리가 있으며 동의 거부에 따른 불이익은 없습니다.</h5>
			<br>
		</div>

		<div class="agree_codes">
			<div class="checkbox">
				<input id="agree_codes" name="agree_codes" req="0001" type="checkbox" value="2">
				<label for="agree_codes">위 내용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>
		</div>

		<div class="notice" style="margin-top: 20px; padding: 1.5%; border: 2px solid navy; background: #f3f3f3;">
			<p>
				도서관을 이용하시면서 <span class="blue">불편한 사항, 개선할 사항, 건의할 사항</span>을 올리는 곳으로 <span class="color5">휴대폰 본인인증</span> 또는
				<span class="color5">공공아이핀</span>을 사용하여 본인 확인 후 글을 쓰시면 됩니다.

				<br>

				게시되는 글의 본문이나 첨부파일에 자신 혹은 타인의 개인정보(주민등록번호, 휴대폰번호, 은행계좌번호, 신용카드번호 등 개인이 식별할 수 있는 모든 정보)를 포함시키지 않도록 주의하시기 바랍니다.
				<span class="blue">개인정보를 포함</span>한 글이 등록되었을 경우 <span class="blue">부분 또는 전체 삭제함</span>을 알려드립니다.

				정보통신 윤리위원회의 네티즌 윤리강령 및 심의규정에 의거하여 <span class="blue">개인불만, 욕설, 비방 등의 게시물</span>은 <span class="blue">
				 사전 안내없이 삭제함</span>을 알려드립니다.
			</p>
		</div>
	</c:when>
	<c:when test="${homepage.context_path eq '228'}">
		<c:choose>
		<c:when test="${param.manage_idx eq '293'}">
			<div class="Box">
				<p>♣ 개인정보의 수집·이용 목적 : 오너(Owner)의 작은 책장 서비스 운영</p>
				<p>♣ 수집하려는 개인정보의 항목 : 업체명, 이름, 업체전화번호, 휴대전화번호, 주소</p>
				<p>♣ 개인정보의 보유 및 이용 기간 : 오너(Owner)의 작은 책장 서비스 이용 철회 시까지</p>
				<p>♣ 개인정보 수집 및 이용에 거부할 권리가 있습니다. 다만 동의를 거부하는 경우 오너(Owner)의 작은 책장 서비스 이용에 제한이 있습니다.</p>
			</div>

			<div class="agree_codes">
				<div class="checkbox">
					<input id="agree_codes" name="agree_codes" req="0001" type="checkbox" value="2">
					<label for="agree_codes">위 내용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
				</div>
			</div>

			<div class="notice" style="margin:20px 0; padding: 1.5%; border: 2px solid navy; background: #f3f3f3;">
				<p>
					오너의 책장 서비스 신청 및 대출희망 도서를 올리는 곳으로, 휴대폰 본인인증 또는 공공아이핀을 사용하여 본인 확인 후 글을 쓰시면 됩니다.<br/>
					게시되는 글의 본문이나 첨부파일에 개인정보가 포함되어 있는 경우 반드시 비밀글로 작성해주세요.
				</p>
			</div>		
		</c:when>

		<c:otherwise>
		<div class="Box" style="height:200px">
			<h5>♣ 개인정보 수집 및 이용 주체</h5>
			<br>
			<p>도서관 홈페이지 서비스 제공에 따른 개인정보 수집 및 이용 주체는 아래와 같습니다.</p>
			  <ul>
				<li>  - 회원정보 : 독서문화과</li>
			  </ul>
			<br>
			<h5>♣ 개인정보 수집 및 이용 목적</h5>
			<br>
			<p>수집된 개인정보는 아래와 같이 정해진 목적 이외의 용도로는 사용되지 않습니다.</p>
			  <ul>
				<li>  - 게시판 이용자 정보 : 게시판 이용자의 신원확인과 신고접수 및 처리 확인 용도</li>
			  </ul>
			<br>
			<h5>♣ 수집하는 개인정보의 항목</h5>
			<br>
			<p>홈페이지 개인정보 수집 및 이용에 관한 동의 절차 완료 후 최소한의 정보만 수집합니다.</p>
			<p>홈페이지 신고센터는 필수정보를 아래와 같이 수집하고 있습니다.</p>
			  <ul>
				<li>  - 필수항목 : 이름</li>
			  </ul>
			<br>
			<h5>♣ 개인정보의 보유 및 이용 기간</h5>
			<br>
			<p>아래와 같이 동의 받은 개인정보의 보유 및 이용기간 내에서만 개인정보를 처리 및 보유합니다.</p>
			  <ul>
				<li>  - 보유기간 : 게시글 삭제 시 까지</li>
			  </ul>
			<br>
			<h5>♣ 개인정보주체는 동의를 거부할 권리가 있으며 동의 거부에 따른 불이익은 없습니다.</h5>
			<br>
		</div>

		<div class="agree_codes">
			<div class="checkbox">
				<input id="agree_codes" name="agree_codes" req="0001" type="checkbox" value="2">
				<label for="agree_codes">위 내용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>
		</div>

		<div class="notice" style="margin-top: 20px; padding: 1.5%; border: 2px solid navy; background: #f3f3f3;">
			<p>
				<c:if test="${param.menu_idx ne '226'}">도서관을 이용하시면서 <span class="blue">불편한 사항, 개선할 사항, 건의할 사항</span>을 올리는 곳으로 </c:if><span class="color5">휴대폰 본인인증</span> 또는
				<span class="color5">공공아이핀</span>을 사용하여 본인 확인 후 글을 쓰시면 됩니다.

				<br>

				게시되는 글의 본문이나 첨부파일에 자신 혹은 타인의 개인정보(주민등록번호, 휴대폰번호, 은행계좌번호, 신용카드번호 등 개인이 식별할 수 있는 모든 정보)를 포함시키지 않도록 주의하시기 바랍니다.
				<span class="blue">개인정보를 포함</span>한 글이 등록되었을 경우 <span class="blue">부분 또는 전체 삭제함</span>을 알려드립니다.

				정보통신 윤리위원회의 네티즌 윤리강령 및 심의규정에 의거하여 <span class="blue">개인불만, 욕설, 비방 등의 게시물</span>은 <span class="blue">
				 사전 안내없이 삭제함</span>을 알려드립니다.
			</p>
		</div>
		</c:otherwise>
		</c:choose>

	</c:when>
	<c:when test="${homepage.context_path eq 'seobu'}">
		<c:choose>
		<c:when test="${param.manage_idx eq '1242' || param.manage_idx eq '1215'}">
		<div class="Box" style="height:200px">
			<h5>♣ 개인정보 수집 및 이용 주체</h5>
			<br>
			<p>도서관 홈페이지 서비스 제공에 따른 개인정보 수집 및 이용 주체는 아래와 같습니다.</p>
			  <ul>
				<li>  - 회원정보 : 종합자료실 </li>
			  </ul>
			<br>
			<h5>♣ 개인정보 수집 및 이용 목적</h5>
			<br>
			<p>수집된 개인정보는 아래와 같이 정해진 목적 이외의 용도로는 사용되지 않습니다.</p>
			  <ul>
				<li>  - 게시판 이용자 정보 : 게시판 이용자의 행사 참여 확인과 상품 추첨 확인 용도</li>
			  </ul>
			<br>
			<h5>♣ 수집하는 개인정보의 항목</h5>
			<br>
			<p>홈페이지 개인정보 수집 및 이용에 관한 동의 절차 완료 후 최소한의 정보만 수집합니다.</p>
			<p>홈페이지 신고센터는 필수정보를 아래와 같이 수집하고 있습니다.</p>
			  <ul>
				<li>  - 필수항목 : 이름, 연락처</li>
			  </ul>
			<br>
			<h5>♣ 개인정보의 보유 및 이용 기간</h5>
			<br>
			<p>아래와 같이 동의 받은 개인정보의 보유 및 이용기간 내에서만 개인정보를 처리 및 보유합니다.</p>
			  <ul>
				<li>  - 보유기간 : 목적 달성 시 까지</li>
			  </ul>
			<br>
			<h5>♣ 개인정보주체는 동의를 거부할 권리가 있으며 동의 거부에 따른 불이익은 없습니다.</h5>
			<br>
		</div>

		<div class="agree_codes">
			<div class="checkbox">
				<input id="agree_codes" name="agree_codes" req="0001" type="checkbox" value="2">
				<label for="agree_codes">위 내용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>
		</div>

		<div class="notice" style="margin-top: 20px; padding: 1.5%; border: 2px solid navy; background: #f3f3f3;">
			<p>
				<c:if test="${param.manage_idx eq '1242' || param.manage_idx eq '1215'}"><strong><span class="blue">도서관 행사 참여를 위한 게시물</span>을 올리는 곳으로 회원 로그인을 하거나 </c:if><span class="color5">(휴대폰 본인인증</span> 또는 <span class="color5">공공아이핀)</span>을 사용하여 본인 확인 후 글을 쓰시면 됩니다.</strong>
				<br>
				<span style="font-size:13px;">※ 게시되는 글의 본문이나 첨부파일에 자신 혹은 타인의 개인정보(주민등록번호, 휴대폰번호, 은행계좌번호, 신용카드번호 등 개인이 식별할 수 있는 모든 정보)를 포함시키지 않도록 주의하시기 바랍니다.
				<span class="blue">개인정보를 포함</span>한 글이 등록되었을 경우 <span class="blue">부분 또는 전체 삭제함</span>을 알려드립니다.

				정보통신 윤리위원회의 네티즌 윤리강령 및 심의규정에 의거하여 <span class="blue">개인불만, 욕설, 비방 등의 게시물</span>은 <span class="blue">
				 사전 안내없이 삭제함</span>을 알려드립니다.</span>
			</p>
		</div>
		<br>
		</c:when>
		<c:otherwise>
		<div class="Box" style="height:200px">
			<h5>♣ 개인정보 수집 및 이용 주체</h5>
			<br>
			<p>도서관 홈페이지 서비스 제공에 따른 개인정보 수집 및 이용 주체는 아래와 같습니다.</p>
			  <ul>
				<li>  - 회원정보 : 독서문화과</li>
			  </ul>
			<br>
			<h5>♣ 개인정보 수집 및 이용 목적</h5>
			<br>
			<p>수집된 개인정보는 아래와 같이 정해진 목적 이외의 용도로는 사용되지 않습니다.</p>
			  <ul>
				<li>  - 게시판 이용자 정보 : 게시판 이용자의 신원확인과 신고접수 및 처리 확인 용도</li>
			  </ul>
			<br>
			<h5>♣ 수집하는 개인정보의 항목</h5>
			<br>
			<p>홈페이지 개인정보 수집 및 이용에 관한 동의 절차 완료 후 최소한의 정보만 수집합니다.</p>
			<p>홈페이지 신고센터는 필수정보를 아래와 같이 수집하고 있습니다.</p>
			  <ul>
				<li>  - 필수항목 : 이름</li>
			  </ul>
			<br>
			<h5>♣ 개인정보의 보유 및 이용 기간</h5>
			<br>
			<p>아래와 같이 동의 받은 개인정보의 보유 및 이용기간 내에서만 개인정보를 처리 및 보유합니다.</p>
			  <ul>
				<li>  - 보유기간 : 게시글 삭제 시 까지</li>
			  </ul>
			<br>
			<h5>♣ 개인정보주체는 동의를 거부할 권리가 있으며 동의 거부에 따른 불이익은 없습니다.</h5>
			<br>
		</div>

		<div class="agree_codes">
			<div class="checkbox">
				<input id="agree_codes" name="agree_codes" req="0001" type="checkbox" value="2">
				<label for="agree_codes">위 내용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
			</div>
		</div>

		<div class="notice" style="margin-top: 20px; padding: 1.5%; border: 2px solid navy; background: #f3f3f3;">
			<p>
				도서관을 이용하시면서 <span class="blue">불편한 사항, 개선할 사항, 건의할 사항</span>을 올리는 곳으로 <span class="color5">휴대폰 본인인증</span> 또는
				<span class="color5">공공아이핀</span>을 사용하여 본인 확인 후 글을 쓰시면 됩니다.

				<br>

				게시되는 글의 본문이나 첨부파일에 자신 혹은 타인의 개인정보(주민등록번호, 휴대폰번호, 은행계좌번호, 신용카드번호 등 개인이 식별할 수 있는 모든 정보)를 포함시키지 않도록 주의하시기 바랍니다.
				<span class="blue">개인정보를 포함</span>한 글이 등록되었을 경우 <span class="blue">부분 또는 전체 삭제함</span>을 알려드립니다.

				정보통신 윤리위원회의 네티즌 윤리강령 및 심의규정에 의거하여 <span class="blue">개인불만, 욕설, 비방 등의 게시물</span>은 <span class="blue">
				 사전 안내없이 삭제함</span>을 알려드립니다.
			</p>
		</div>
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>

	<div class="Box" style="height:200px">
		<h5>♣ 개인정보 수집 및 이용 주체</h5>
		<br>
		<p>도서관 홈페이지 서비스 제공에 따른 개인정보 수집 및 이용 주체는 아래와 같습니다.</p>
		  <ul>
			<li>  - 회원정보 : 독서문화과</li>
		  </ul>
		<br>
		<h5>♣ 개인정보 수집 및 이용 목적</h5>
		<br>
		<p>수집된 개인정보는 아래와 같이 정해진 목적 이외의 용도로는 사용되지 않습니다.</p>
		  <ul>
			<li>  - 게시판 이용자 정보 : 게시판 이용자의 신원확인과 신고접수 및 처리 확인 용도</li>
		  </ul>
		<br>
		<h5>♣ 수집하는 개인정보의 항목</h5>
		<br>
		<p>홈페이지 개인정보 수집 및 이용에 관한 동의 절차 완료 후 최소한의 정보만 수집합니다.</p>
		<p>홈페이지 신고센터는 필수정보를 아래와 같이 수집하고 있습니다.</p>
		  <ul>
			<li>  - 필수항목 : 이름</li>
		  </ul>
		<br>
		<h5>♣ 개인정보의 보유 및 이용 기간</h5>
		<br>
		<p>아래와 같이 동의 받은 개인정보의 보유 및 이용기간 내에서만 개인정보를 처리 및 보유합니다.</p>
		  <ul>
			<li>  - 보유기간 : 게시글 삭제 시 까지</li>
		  </ul>
		<br>
		<h5>♣ 개인정보주체는 동의를 거부할 권리가 있으며 동의 거부에 따른 불이익은 없습니다.</h5>
		<br>
	</div>

	<div class="agree_codes">
		<div class="checkbox">
			<input id="agree_codes" name="agree_codes" req="0001" type="checkbox" value="2">
			<label for="agree_codes">위 내용에 동의합니다.</label><input type="hidden" name="_agree_codes" value="on"><br>
		</div>
	</div>

	<div class="notice" style="margin-top: 20px; padding: 1.5%; border: 2px solid navy; background: #f3f3f3;">
		<p>
			도서관을 이용하시면서 <span class="blue">불편한 사항, 개선할 사항, 건의할 사항</span>을 올리는 곳으로 <span class="color5">휴대폰 본인인증</span> 또는
			<span class="color5">공공아이핀</span>을 사용하여 본인 확인 후 글을 쓰시면 됩니다.

			<br>

			게시되는 글의 본문이나 첨부파일에 자신 혹은 타인의 개인정보(주민등록번호, 휴대폰번호, 은행계좌번호, 신용카드번호 등 개인이 식별할 수 있는 모든 정보)를 포함시키지 않도록 주의하시기 바랍니다.
			<span class="blue">개인정보를 포함</span>한 글이 등록되었을 경우 <span class="blue">부분 또는 전체 삭제함</span>을 알려드립니다.

			정보통신 윤리위원회의 네티즌 윤리강령 및 심의규정에 의거하여 <span class="blue">개인불만, 욕설, 비방 등의 게시물</span>은 <span class="blue">
			 사전 안내없이 삭제함</span>을 알려드립니다.
		</p>
	</div>

	</c:otherwise>
	</c:choose>


	<form:form modelAttribute="board" action="edit.do" method="get" onsubmit="return false;">
	<jsp:include page="/WEB-INF/views/app/board/common/form_param.jsp" flush="false" />
	</form:form>
	<form id="certForm" name="certForm" action="/intro/join/cert.do" method="post" target="certWindow">
		<input type="hidden" name="mode" value="board">
		<input type="hidden" name="certType">
		<input type="hidden" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
		<div class="identi_select" >
			<p class="identy_a">
				<a href="#" class="certtype" id="parentSms">
					<img src="/resources/common/img/identy1.png" alt="휴대폰 본인인증"/>
					<span>${parentNameTag}휴대폰 본인인증</span>
				</a>
			</p>
			<p class="identy_b">
				<a href="#" class="certtype" id="parentGpin">
					<img src="/resources/common/img/identy2.png" alt="I-PIN인증"/>
					<span>${parentNameTag}I-PIN(아이핀)인증</span>
				</a>
			</p>
		</div>
	<br/>
</div>
