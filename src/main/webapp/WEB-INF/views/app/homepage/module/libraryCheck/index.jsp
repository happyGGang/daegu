<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function() {
	
	$('#add-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val();
		doGetLoad('edit.do', formData);
	});
	
	$('a.view-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=view&menu_idx='+$('#menu_idx').val() + '&library_check_idx='+$(this).attr('keyValue');
		doGetLoad('view.do', formData);
	});
	
	$('a#allChk').on('click', function(e) {
		e.preventDefault();
		if($(this).attr('keyValue') == 'N') {
			$(this).attr('keyValue', 'Y');
			$('input[name="library_check_arr"]').prop('checked', true);
		} else {
			$(this).attr('keyValue', 'N');
			$('input[name="library_check_arr"]').prop('checked', false);
		}
	});
	
	$('a#delete-chk').on('click', function(e) {
		e.preventDefault();
		if(confirm('선택한 장서점검기들을 삭제하시겠습니까?')) {
			$('#editMode').val('DELETE_ALL');
			$('form#libraryCheck').attr('action', 'save.do');
			$('form#libraryCheck').attr('method', 'POST');
			if(doAjaxPost($('form#libraryCheck'))) {
				location.reload();
			}
		}
	});
	
	$('a.request-btn').on('click', function(e) {
		e.preventDefault();
		var formData = 'editMode=ADD&menu_idx='+$('#menu_idx').val() + '&library_check_idx='+$(this).attr('keyValue') + '&library_check_number='+$(this).attr('keyValue2') + '&request_status='+$(this).attr('keyValue3');
		doGetLoad('loanEdit.do', formData);
	});
	
	$('select#loan_status').on('change', function(e) {
		e.preventDefault();
		$('#viewPage').val(1);
		doGetLoad('index.do', $('form#libraryCheck').serialize());
	});
	
});
</script>
<style>
ht.tit {padding: 0 0 12px 10px;font-size: 13px;color: #333;margin-bottom: 25px;line-height: 30px;letter-spacing: -0.05em;}
ul.rent_box{overflow: hidden;margin-bottom: 20px;padding: 20px 0;background: #ecf1f5;height: 150px;}
ul.rent_box li {float: left;width: 420px;padding-top: 12px;background: url(/resources/common/img/support_line.gif) repeat-y;text-align: center;color: #222;}
ul.rent_box li:first-child {background: none;}
ul.rent_box li dt {padding: 61px 0 5px;font-size: 15px;font-weight: bold;color: #fff;letter-spacing: -0.05em;}
ul.rent_box li dt.icon01 {background: url(/resources/common/img/support_icon01.png) no-repeat top center;}

.group-box {display:inline-block;width: 150px;text-align: center;padding: 20px;}
.content-box h4 {display: inline-block;background: none;}
div.img-box {position: relative;display:inline-block;border: 1px solid #ccc;padding: 0;}
div.img-box span.num {position: absolute;top: 30px;right: 22px;width: 18px;height: 18px;padding: 4px 4px;font-family: 'Montserrat',sans-serif;font-weight: 700;text-align: center;line-height: 17px;color: #fff;background-color: red;border-radius: 50%;}
</style>
<div>
	<h4 class="tit">장서점검기 대여 신청 안내</h4>
	<ul class="rent_box">
		<li>
			<dl>
				<dt class="icon01">최대 신청대수</dt>
				<dd><span class="eng">2</span>대</dd>
			</dl>
		</li>
		<li>
			<dl>
				<dt class="icon02">최대 대출기간</dt>
				<dd><span class="eng">1</span>주</dd>
			</dl>
		</li>
	</ul>
	<ul class="list mb40">
		<li><strong class="red">대여일은 금요일, 반납일은 목요일</strong>로 지정되어 있습니다.
			<ul class="list2">
				<li>사용 희망일이 금요일이 아닌 경우, 사용 희망일 전 주 금요일에 미리 대여 신청 하십시오.</li>
				<li>대여 신청은 대여하시려는 날짜의 2주 전부터 가능합니다.</li>
			</ul>
			<p>▶ 앞의 학교의 대여 기간에 따라 원하시는 일자에 대여 신청이 불가할 수 있습니다.</p>
			<div style="margin-left:-11px;"><img src="/resources/common/img/support_calendar.jpg" alt="일주일 대여 예시" class="mimg"></div>
		</li>
		<li>예) 20일(화)이 사용희망일일 경우
			<ul class="list2">
				<li>20일(화) 전 주 금요일인 16일이 장서점검기 대여일</li>
				<li>대여 신청은 16일의 2주 전 금요일인 2일부터 가능</li>
				<li>목요일인 22일에 반납</li>
			</ul>
		</li>
		<li>담당자 본인이 도서관에 방문하여 대출 / 직접 반납</li>
		<li>장서점검기 2가지 모델이 있으니 이용에 참고바랍니다.
			<ul class="list2">
				<li>DT-970 모델 : 1, 2, 3, 8, 9번 장서점검기</li>
				<li>북체커 모델 : 4, 5, 6, 7번 장서점검기</li>
			</ul>
		</li>
	</ul>
</div>
<form:form modelAttribute="libraryCheck" action="index.do" method="GET">
<%-- <form:hidden path="editMode"/> --%>
<form:hidden path="menu_idx"/>

	<form:select path="loan_status" cssClass="selectmenu">
		<form:option value="">상태전체</form:option>
		<form:option value="1">대출중</form:option>
		<form:option value="0">대출가능</form:option>
	</form:select>

	<div>
		<c:forEach items="${libraryCheckList}" var="i">
		<div class="group-box">
			<div class="img-box">
				<c:if test="${sessionScope.authGroup eq '1'}">
				<a href="#" class="view-btn" keyValue="${i.library_check_idx}">
				</c:if>
					<span class="num">${i.library_check_number}</span>
					<c:choose>
						<c:when test="${not empty i.server_file_name}">
						<img alt="장서점검기 이미지" src="${getContextPath}/data/libraryCheck/${i.server_file_name}">
						</c:when>
						<c:otherwise>
						<img src="/resources/common/img/noimg-gall.png" alt="no-image">
						</c:otherwise>
					</c:choose>
				</a>
			</div>
			<div class="content-box">
				<form:checkbox path="library_check_arr" value="${i.library_check_idx}"/>
				<a href="#" class="view-btn" keyValue="${i.library_check_idx}">
					<h4>장서점검기${i.library_check_number}</h4>
				</a>
				<div>
					<c:choose>
						<c:when test="${i.lender_count < 1}">
						<a href="#" class="request-btn" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="0">신청하기</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty i.loan_start_date and empty i.loan_end_date}">
								<a href="#" class="request-btn" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="1">예약하기</a>
								</c:when>
								<c:otherwise>
<%-- 								<a href="#" class="request-btn" keyValue="${i.library_check_idx}" keyValue2="${i.library_check_number}" keyValue3="1"> --%>
									<a href="javascript:void(0);">예약중<br/>${i.loan_start_date}~${i.loan_end_date}</a>
<!-- 								</a> -->
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>
		</div>
		</c:forEach>
		<c:if test="${fn:length(libraryCheckList) < 1}">
		<div align="center">
			<h3>등록된 장서점검기가 없습니다.</h3>
		</div>
		</c:if>
	</div>
	<c:if test="${sessionScope.authGroup eq '1'}">
	<a href="#" class="btn" id="allChk" keyValue="N">전체 선택/해제</a>
	<a href="#" class="btn" id="delete-chk">선택 게시글 삭제</a>
	</c:if>
	
	<jsp:include page="/WEB-INF/views/app/cms/common/paging.jsp" flush="false">
		<jsp:param name="formId" value="#libraryCheck"/>
	</jsp:include>
	
	<c:if test="${sessionScope.authGroup eq '1'}">
	<div class="infodesk">
		<div class="button">
			<a href="#" class="btn btn5 left" id="add-btn"><i class="fa fa-plus"></i><span>등록</span></a>
		</div>
	</div>
	</c:if>
</form:form>