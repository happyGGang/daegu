<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function() {

});
</script>

<c:choose>
<c:when test="${homepage.context_path eq '228lib'}">
<script type="text/javascript">
window.location.href="/228lib/index.do";
</script>
</c:when>
<c:otherwise>
<div class="dataF-wr mg15f">
	<ul class="info_list">
		<li>
			<div class="list_cell">
				<p class="icon"><img src="/resources/common/img/dw02.png" alt="" width="164"></p>
				<p class="title">대구시민인증</p>
				<ul class="dot_txt_list">
					<li>자격 확인이 필요한 행정·공공 서비스 이용 신청 시 신청인이 직접 본인 동의하에 행정안전부 행정정보공동이용 시스템을 통해 신청 자격을 확인하는 서비스입니다.<br>
					독서교육종합지원시스템(DLS)에 가입된 회원이 아닌 일반 이용자분들은 아래의 <strong>대구시민인증</strong> 버튼을 클릭하시면 추가 인증 페이지로 이동합니다.</li>
				</ul>
			</div>
		</li>
	
		<li>
			<div class="list_cell">
				<p class="icon"><img src="/resources/common/img/dw01.png" alt="" width="164"></p>
				<p class="title">대구학생인증</p>
				<ul class="dot_txt_list">
					<!-- <li>독서교육종합지원시스템(DLS)에 가입된 회원은 추가 인증을 통해 비대면 회원가입으로 전자도서관 이용이 가능합니다.<br>
					아래의 <strong>대구학생인증</strong> 버튼을 클릭하시면 추가 인증 페이지로 이동합니다.</li> -->
					<li>2024년 학생 맞춤 독서교육 지원 플랫폼인 '독서로(구 독서교육종합지원시스템)' 도입을 위한  데이터 이관이 될 예정입니다. 데이터 자료 이관 중에는 독서교육종합지원시스템(DLS포함) 서비스가 전면 중단됨에 따라 기존 운영되었던 대구학생인증(DLS) 사용이 일시 중단됨을 안내드립니다. 서비스 재게시 별도 공지를 통해 안내드리도록 하겠습니다.</li>
				</ul>
			</div>
		</li>
	</ul>
</div>

<div class="txt-box-adv2">
	<ul class="con">
		<li>신규 회원가입하여 로그인 후 인증 가능합니다. (기존 회원은 통합회원 인증 후 사용 가능)</li>
		<li><b>비대면 인증 회원은 원칙적으로 전자도서관만 이용할 수 있으며</b>, 차후 통합회원 전환하고자 할 경우 본인확인을 위한 구비서류(신분증 등)를 직접 지참하여 도서관 방문바랍니다. </li> 
	</ul>
</div>
<div class="btn-wrap" style="text-align:center;padding:20px 0">
	<a href="untactForm.do?menu_idx=${untactMenuIdx}" class="btn btn02" style="background: #f56627;border: 1px solid #f56627;color:#fff;">대구시민인증</a>
	<!--<a href="#" onclick="alert('현재 대구시민인증 라이센스 만료로 인해 일시적으로 서비스가 중단되었습니다. 이용에 불편함을 드려 죄송합니다. 곧 재게될 예정이오니 양해부탁드립니다.');" class="btn btn02" style="background: #f56627;border: 1px solid #f56627;color:#fff;">대구시민인증</a>-->
	<!-- <a href="dls.do?menu_idx=${dlsMenuIdx}" class="btn btn01" style="background: #3c6ad9;border: 1px solid #3c6ad9;color:#fff;">대구학생인증</a> -->
	<a href="#" onclick="alert('2024년 학생 맞춤 독서교육 지원 플랫폼인 독서로(구 독서교육종합지원시스템) 도입을 위한  데이터 이관에 따라 독서교육종합지원시스템(DLS포함) 서비스가 전면 중단됨에 따라 기존 운영되었던 대구학생인증(DLS) 사용이 일시 중단됨을 안내드립니다. 서비스 재게시 별도 공지를 통해 안내드리도록 하겠습니다.');" class="btn btn01" style="background: #3c6ad9;border: 1px solid #3c6ad9;color:#fff;">대구학생인증</a>
	<a href="/dgportal/index.do" class="btn btn03">메인으로</a>
</div>

</c:otherwise>
</c:choose>