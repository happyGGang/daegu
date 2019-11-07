<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="homepageTag" uri="/WEB-INF/config/tld/homepageTag.tld"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
</script>
<h2>새 책 드림 신청</h2>

<div id="request_form_wrap">
	<div class="request_box">
		<span class="agree_title">개인정보 필수 항목 수집 및 이용에 대한 안내</span> <span class="red fb">(필수)</span>
		<div class="agree_box">
			<h5>수집하는 개인정보의 항목</h5>
			<ul class="con01">
				<li>경상북도교육청 안동도서관은 회원가입, 원활한 이용자상담, 각종 서비스 등 기본적인 서비스 제공을 위하여 최초 회원가입 시 아래와 같은 최소한의 개인정보를 수집하고 있습니다.<br />- 필수항목 : 아이디, 비밀번호, 성명, 생년월일, 성별, 주소, 직업, 전화번호, 휴대전화번호, 이메일 주소<br />* 민감한 개인정보(인종, 사상 및 신조, 범죄 및 의료기록 등)는 수집하지 않습니다.</li>
			</ul>
			<h5>개인정보의 수집 및 이용 목적</h5>
			<ul class="con01">
				<li>가. 서비스 제공에 관한 업무 이행<br />- 홈페이지 회원에게 도서관서비스 제공</li>
				<li>나. 회원관리<br />회원제 서비스 이용에 따른 본인확인, 개인식별, 가입의사 확인, 추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달</li>
			</ul>
			<h5>개인정보의 보유 및 이용기간</h5>
			<ul class="con01">
				<li>회원의 개인정보는 회원가입일로부터 2년동안 보유 및 이용되며, 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 따라서 우리 도서관은 정보주체의 회원탈퇴 요청 시 그 회원의 개인정보를 지체 없이 파기합니다.</li>
			</ul>
			<h5>정보주체의 권리</h5>
			<ul class="con01">
				<li>가. 경상북도교육청 안동도서관 회원은 자신의 개인정보 처리와 관련하여 아래와 같은 권리를 가집니다.
					<ul class="con02">
						<li>개인정보의 처리 여부를 확인하고 개인정보에 대하여 열람(사본의 발급을 포함한다. 이하 같다)을 요구할 권리</li>
						<li>개인정보의 처리 정지, 정정·삭제 및 파기를 요구할 권리</li>
						<li>개인정보의 처리로 인하여 발생한 피해를 신속하고 공정한 절차에 따라 구제받을 권리</li>
					</ul>
				</li>
				<li>나. 권리행사의 방법 및 절차에 대해서는 홈페이지에 게시된 “개인정보처리방침”을 참조하여 주시기 바라며, 우리 도서관은 정보주체의 권리 보장을 위하여 최선을 다하겠습니다.</li>
			</ul>
			<h5>동의거부권 및 동의 거부에 따른 불이익</h5>
			<ul class="con01">
				<li>가입자는 개인정보 수집·이용에 대하여 거부할 수 있는 권리가 있습니다. 단, 이에 대한 동의를 거부할 경우에는 회원가입 및 새 책 드림 서비스의 이용이 불가능합니다.</li>
			</ul>
		</div>
		<input type="checkbox" id="agree" style="vertical-align: middle;"/><label for="agree"> 개인정보 필수항목 수집 및 이용에 동의합니다.</label><br />

		<span class="agree_title pdt20">새 책 드림 서비스 이용 약관</span> <span class="red fb">(필수)</span>
		<div class="agree_box" style="height:140px;">
			<h4>제 1 장 총칙</h4>
			<h5>제 1조 (목적)</h5>
			<p>본 약관은 경상북도교육청 안동도서관의 ‘새 책 드림 서비스’ 운영에 따른 회원 서비스 및 이용조건과 절차에 관한 사항을 규정함을 목적으로 한다.</p>

			<h5>제 2 조 (약관의 효력과 변경)</h5>
			<ul class="con01">
				<li>①본 약관의 내용은 도서관 홈페이지 회원 가입시 동의함으로써 효력이 발생한다. </li>
				<li>②회원은 개정된 약관에 대해 거부할 권리가 있으며, 개정된 약관에 동의하지 않을 경우 회원 등록을 해지할 수 있다. 단, 개정된 약관의 효력 발생일 이후에도 서비스를 계속 이용할 경우 약관의 변경사항에 동의하는 것으로 간주한다. </li>
				<li>③본 약관은 이용자를 위하여 새로운 서비스를 추가하거나, 정책상 중요 사유와 특별한 사정이 발생한 경우 사전 고지 없이 약관을 변경할 수 있다. 다만, 변경된 약관은 도서관 홈페이지에 공지하며 공지와 동시에 그 효력이 발생한다. </li>
			</ul>

			<h4>제 2 장 서비스 제공 및 이용</h4>
			<h5>제 3 조 (이용계약의 성립)</h5>
			<ul class="con01">
				<li>①이용계약은 이용자의 이용신청에 대한 도서관의 승낙과 이용자의 약관내용에 대한 동의로 성립된다.</li>
				<li>②회원에 가입하여 서비스를 이용하고자 하는 회원은 도서관에서 요청하는 소정의 개인정보(반드시 실명)를 제공해야 한다. </li>
				<li>③도서관은 다음 각 호의 경우에 대하여 이용승인을 취소할 수 있다.
					<ul class="con02">
						<li>1. 다른 사람의 명의를 사용하여 신청한 경우</li>
						<li>2. 이용 신청서(회원가입신청)의 내용을 허위로 기재한 경우</li>
						<li>3. 다른 사람의 정보를 도용하는 등의 행위를 한 경우</li>
						<li>4. 영리를 추구할 목적으로 서비스를 이용하고자 하는 경우</li>
						<li>5. 도서관 이용규칙 등 관계법령과 본 약관이 금지하는 행위를 하는 경우</li>
					</ul>
				</li>
			</ul>

			<h5>제 4 조 (서비스 이용)</h5>
			<ul class="con01">
				<li>①서비스 이용은 경상북도교육청 안동도서관 홈페이지의 운영 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 한다.</li>
				<li>② 서비스 이용에 대한 상세 내용은 다음과 같다.
					<ul class="con02">
						<li> 1.구입 대상자는 도서관 회원으로 하며, 대출정지 회원 및 연체자는 제외 한다.</li>
						<li>2.구입 가능한 도서는 ‘도서관 미소장 도서’ 이며, 소장도서의 경우 최소복본 (1권) 으로 한다. </li>
						<li> 3.단행본 구입은 최대 2복본으로 한다. </li>
						<li>4.다권본은 각 책을 단행본과 동일하게 취급 한다.</li>
						<li> 5.이용자의 구입 가능 도서는 1인 월 4권 이내이며, 1회 최대 2권으로 신청을 제한한다. (동일 도서 불가)</li>
						<li> 6.구입 제외 도서는 다음과 같다.
							<ul class="con03">
								<li>가. 출판된 지 5년이 경과된 도서</li>
								<li>나. 비도서, 정기 간행물</li>
								<li>다. 유해 매체물, 출판금지도서, 사회적으로 물의를 일으킬 소지가 있는 자료</li>
								<li>라. 개인의 학습을 위한 도서(학습지, 문제집, 수험서, 참고서, 대학교재 등) </li>
								<li>마. 오락성 및 폭력성 자료(만화, 인터넷연애소설, 무협소설, 판타지소설)</li>
								<li>바. 5만 원 이상 고가의 도서</li>
								<li>사. 전집류, 잡지, 해외주문도서</li>
								<li>아. 특정 종교나 단체의 관련 자료를 집중 신청하는 경우</li>
								<li>자. 기타 도서관자료로서 부적합하다고 판단되는 자료  </li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>

			<h4>제 3 장 의무 및 책임</h4>
			<h5>제 5 조 도서관의 의무</h5>
			<ul class="con01">
				<li>①이용자의 개인정보를 이용자의 승낙 없이 타인에게 누설, 배포하여서는 아니된다.</li>
				<li>②도서관은 서비스 이용과 관련하여 다음과 같은 의무를 갖는다.
					<ul class="con02">
						<li>1. 도서관은 이용자의 구입도서에 대해 오•훼손 등 기타 특별한 사유가 없는 한 신속히 반납처리 하여야 한다. </li>
						<li>2. 본 서비스를 이용하는 이용자의 민원처리 및 시스템 관리에 있어 그 책임을 다한다.   </li>
					</ul>
				</li>
			</ul>

			<h5>제 6 조 이용자의 의무</h5>
			<ul class="con01">
				<li>①이용승인이 성립하는 순간부터 이용자의 아이디와 비밀번호 및 회원번호에 관한 모든 관리의 책임은 회원에게 있다.</li>
				<li>②이용자는 서비스 이용과 관련하여 다음과 같은 의무를 갖는다.
					<ul class="con02">
						<li>1. 구입도서의 이용 기간은 구입 익일부터 14일 이내(연기불가)로 한다.</li>
						<li>2. 반납은 구입신청한 도서관(본관, 분관 별도 관리)으로 하며, 그 외 처에 반납하였을 경우에 발생하는 모든 책임은 이용자에게 있다. </li>
						<li>3. 환불은 반드시 구입 신청한 서점에서 하며, 이용자는 도서관 및 그 외 처에 환불을 요구 할 수 없다.</li>
						<li>4. 구매일로부터 3일 이내 ‘개인소장’ 의사를 밝혀야 한다. (홈페이지 ‘개인소장’ 클릭)<br />단, 의사 표현 없이 14일이 경과한 경우 ‘개인소장’으로 간주하며, 이후 30일간 도서를 구입할 수 없다.</li>
						<li>5. 반납도서는 반드시 오·훼손이 없어야 하며, 그로 인해 발생하는 모든 책임은 이용자에게 있다.</li>
					</ul>
				</li>
			</ul>


			<h5>부칙</h5>
			<ul class="con01">
				<li>본 약관은 2015년 4월 1일부터 시행한다.</li>
				<li>2015년 7월 17일 - 구매가능도서 18개월에서 5년이내 도서로 연장</li>
			</ul>
		</div>

		<input type="checkbox" id="agree02" style="vertical-align: middle;" /><label for="agree02"> 구입 제외 도서, 주의사항 안내를 읽고 동의합니다.</label>
	</div>

	<div class="request_box">
		<c:choose>
		<c:when test="${naverResult.rss.channel.item.getClass().simpleName == 'ArrayList'}">
			<c:set var="item" value="${naverResult.rss.channel.item[0]}"/>
		</c:when>
		<c:otherwise>
			<c:set var="item" value="${naverResult.rss.channel.item}"/>
		</c:otherwise>
		</c:choose>
		<h4>신청도서 정보</h4>
		<p class="image"><img src="${item.image}" /></p>
		<ul class="con01 pdl120">
			<li>도서명 : ${item.title}</li>
			<li>저자 : ${item.author}</li>
			<li>가격 : <fmt:formatNumber value="${item.price}" pattern="#,###"/> 원</li>
			<li>출판사 : ${item.publisher}</li>
			<fmt:parseDate var="pubDate" value="${item.pubdate}" pattern="yyyyMMdd"/>
			<li>출판일 : <fmt:formatDate value="${pubDate}" pattern="yyyy-MM-dd"/> </li>
		</ul>

		<form:form modelAttribute="bookDream" action="save.do" onsubmit="return false;">
			<form:hidden path="title" value="${item.title}"/>
			<form:hidden path="author" value="${item.author}"/>
			<form:hidden path="publisher" value="${item.publisher}"/>
			<form:hidden path="pubdate" value="${item.pubdate}"/>
			<form:hidden path="isbn" value="${item.isbn}"/>
			<form:hidden path="price" value="${item.price}"/>
			<form:hidden path="image" value="${item.image}"/>

		<div class="clear">
			<h4>서점 선택</h4>

			<div id="announce">

				<h3>반드시 아래 사항을 확인하시길 바랍니다.</h3>

			</div>
			<ul class="con01">
				<li>가장 먼저 신청도서가 해당서점에 <strong>보유 중인지 확인 후 신청</strong>하시기 바랍니다.</li>
				<li>신청하신 책을 구매하기 편한 서점을 선택 해주세요.</li>
				<li>
					<span class="title">서점</span>
					<span class="con">
						<form:select path="storeCode" items="${storeList}" itemLabel="code_name" itemValue="code_id" />
					</span>
				</li>
			</ul>
		</div>

		<div class="clear">
			<h4>신청자 정보</h4>
				<ul class="con01">
					<li><span class="title">성명</span> <span class="con">${member.USER_NAME}</span></li>
					<li><span class="title">휴대폰번호</span>
						<span class="con">
							<form:input path="mobileno" numberOnly="true" maxlength="11" value="${member.MOBILE_NO}"/>*숫자만 입력해주세요.
						</span>
					</li>
					<li>
						<span class="title">이메일</span>
						<span class="con">
							<form:input path="email" value="${member.EMAIL }"/>
						</span>
					</li>
					<li>
						<span class="title">전화</span>
						<span class="con">
							<form:input path="tellno" value="${member.TEL_NO }" size="15" numberOnly="true" />
						</span>*숫자만 입력해주세요.
					</li>
					<li>
						<span class="title">주소</span>
						<span class="con">
							<form:input path="addres" value="${member.ADDRS}" size="30"/>
						</span>
					</li>
				</ul>
<!-- 				<span>※ 등록하신 휴대폰번호로 신청 문자가 전송됩니다.</span><br /> -->
				<p class="btn_wrap"><button type="submit" class="btn btn-large btn-danger"><span>신청하기</span></button></p>
		</div>
		</form:form>
	</div>

		<div id="request_item_list"></div>

		<script>
			$(function() {
				$('#bookDream').bind('submit', function() {
					if(!$('#agree').is(':checked')) return error('개인정보 수집에 동의 하셔야합니다.');
					if(!$('#agree02').is(':checked')) return error('새책드림 서비스 이용에 동의 하셔야합니다.');
					if(!this.mobileno.value) return error('핸드폰번호를 입력해주세요', this.mobileno);
					if(!this.email.value) return error('이메일주소를 입력해주세요', this.email);
					if(!this.storeCode.value) return error('서점을 선택해주세요', this.storeCode);
					if (confirm('새 책 드림 서비스를 등록 하시겠습니까?')) {
						doAjaxPost($('form#bookDream'));
					}
					return false;
				});
			});
			function error(msg, fcs) {
				if(msg) alert(msg);
				if(fcs) fcs.focus();
				return false;
			}
		</script>
	</div>