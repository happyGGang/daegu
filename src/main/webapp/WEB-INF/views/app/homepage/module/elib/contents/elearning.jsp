<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tag" uri="/WEB-INF/config/tld/customTag.tld" %>

<div class="darakwon_bgbox bgbox">
	<div class="lf-txt">
	  <p><span class="tt">모바일 학습서비스</span><br>
		<span class="btit">다락원</span></p>
		<br>


			<ul class="btns_wrap_tac">
				<li>
				
				<c:choose>
					<c:when test="${sessionScope.member.loginType eq 'HOMEPAGE' and sessionScope.member.login}">
						<c:choose>
							<c:when test="${sessionScope.member.user_no eq '' or sessionScope.member.user_no eq null}">
								<a href="javascript:alert('정회원만 이용가능합니다.');" class="btn_link04"  title="다락원 바로가기(새창열림)"><span>다락원 바로가기</span><span class="ico ico_link"></span></a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn_link04" id="go-darakwon" title="다락원 바로가기(새창열림)"  target="_blank"><span>다락원 바로가기</span><span class="ico ico_link"></span></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="javascript:alert('로그인후 이용가능합니다.');" class="btn_link04"  title="다락원 바로가기(새창열림)"><span>다락원 바로가기</span><span class="ico ico_link"></span></a>
					</c:otherwise>
				</c:choose>

				</li>
			</ul>


	</div>
</div>
<br>
<h3 class="contTit_line">다락원 사이버 어학원</h3>
<ul class="con">
	<li>영어/중국어/일본어/기타 외국어 등 다양한 분야의 외국어 온라인 강좌 제공</li>
	<li>해당 페이지에서 원하는 강좌 수강신청 후, 나의 강의실에서 학습

			<li>영어(회화, 토익, 오픽, 텝스, 청취 등), 중국어(회화, HSK 등), 일본어(회화, JLPT 등)</li>
			<li>기타 외국어(독일어, 스페인어, 프랑스어, 러시아어, 포르투갈어, 아랍어, 베트남어, 태국어 등)</li>

	</li>
	<li>스마트폰 서비스, 레벨테스트, 온라인 모의토익 등 부가 학습 콘텐츠 제공</li>
</ul>


<c:set var='lib_code' value='${fn:substring(sessionScope.member.user_no,0,6)}' />


<script>
	function isMobile() {
		return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
	}

	$(function() {
		var action_url;

		if ( isMobile() ) 
		{
			// 모바일이면 실행될 코드 들어가는 곳
			$('#go-darakwon').on("click", function(e) {
				e.preventDefault();
				action_url = "https://m.lms.darakwon.co.kr:447/tglnet/msso.asp";
				dwfrmsubmit(action_url);
			});
		}
		else
		{
			// 모바일이면 실행될 코드 들어가는 곳
			$('#go-darakwon').on("click", function(e) {
				e.preventDefault();
				action_url = "https://lms.darakwon.co.kr/tglnet/sso.asp";
				dwfrmsubmit(action_url);
			});
			// 모바일이 아니면 실행될 코드 들어가는 곳
		}

	});

function dwfrmsubmit(url) {
	//학습자이름 인코딩 진행
	var param = document.getElementById("uname").value
	var encode = '';
	for(i=0; i<param.length; i++){
	var len  = ''+param.charCodeAt(i);
	var token = '' + len.length;
	encode  += token + param.charCodeAt(i);
	}
	//인코딩된 학습자이름 hidden필드(dw_name) 값 지정
	document.getElementById("uname_enc").value = encode; 

	//다락원에서 제공하는 도서관 연수원 sso페이지 URL(연수원URL은 개별 전달)
	document.getElementById("darakwonForm").action = url; 
	document.getElementById("darakwonForm").submit();
}

</script>

<form name="darakwonForm" id="darakwonForm" method="post" target="_blank">
<input type="hidden" id="uname_enc" name="uname_enc"> 
<input type="hidden" id="uid" name="uid" value="${sessionScope.member.member_id}"> 		
<input type="hidden" id="uname" name="uname" value="${sessionScope.member.member_name}"> 
<input type="hidden" name="_csrf" value="${CSRF_TOKEN}" />
</form>




