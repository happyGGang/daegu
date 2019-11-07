<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/cms/smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/resources/cms/js/malsup.jquery.form.min.js" type="text/javascript"></script>
<script>
$(function() {
	var oEditors = [];
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

	/* nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "html",
		sSkinURI: "${getContextPath}/resources/cms/smart_editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function() {
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function() {
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	}); */
	
	
	$('.dialog-common').dialog({ //모달창 기본 스크립트 선언
		autoOpen: false,
		resizable: true,
		modal: true, 
	    open: function(){
	        $('.ui-widget-overlay').addClass('custom-overlay');
	    },
	    close: function(){
	        $('.ui-widget-overlay').removeClass('custom-overlay');
	    },
		buttons: [
			{
				text: "저장",
				"class": 'btn btn1',
				click: function() {
					jQuery.ajaxSettings.traditional = true;
					var option = {
						url : 'save.do',
						type : 'POST',
						data : $('#bookDreamOne').serialize(),
						success: function(response) {
							 if(response.valid) {
								alert(response.message);
								$('#dialog-1').dialog('destroy');
								//열려있는 다이얼로그를 삭제한다.(중복방지)
				    			$('.dialog-common').remove();
				    			location.reload();
							} else {
								if ( response.message != null ) {
									alert(response.message);
								}
								else {
									for(var i =0 ; i < response.result.length ; i++) {
										alert(response.result[i].code);
										$('#'+response.result[i].field).focus();
										break;
									}	
								}
							}
				         },
				         error: function(jqXHR, textStatus, errorThrown) {
				             alert('[' + textStatus + ']관리자에게 문의하세요. : ' + errorThrown);
				         }
					};
					$('#bookDreamOne').ajaxSubmit(option);
				}
			},{
				text: "취소",
				"class": 'btn',
				click: function() {
					$('#dialog-1').dialog('destroy');
				}
			}
		]
	});
	
	$("#dialog-1").dialog({ //개별 모달창 띄울 시 선택자 선언 및 크기 값 설정
		width: 1200,
		height: 800
	});
	
	//달력
	$('.ui-calendar').each(function() {
		$(this).datepicker({
			//기본달력
		});
	});
	
	
});

function getFileData(fileData) {
	fileList = fileData;
	var html = '';
	for (var i = 0; i < fileList.length; i++) {
		alert(fileList[i].name);
	}
}	
</script>
<form:form modelAttribute="bookDreamOne" action="save.do" method="post" onsubmit="return false;">
<form:hidden path="r_no"/>
	<table class="tstyle lbook" summary="서점명, 대표자, 아이디, 비밀번호, 전화번호를 수정할 수 있는 서점관리 표입니다.">
		<caption class="blind">서점관리 수정</caption>
		<colgroup>
			<col style="width:110px" />
			<col />
			<col style="width:500px" />
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
					<form:select path="r_state">
						<form:option value="0">대기</form:option>
						<form:option value="10">신청</form:option>
						<form:option value="13">재고있음</form:option>
						<form:option value="15">주문중</form:option>
						<form:option value="17">입고완료</form:option>
						<form:option value="20">구매확정</form:option>
						<form:option value="30">반납</form:option>
						<form:option value="40">환불</form:option>
						<form:option value="50">정산완료</form:option>
						<form:option value="-10">회원취소</form:option>
						<form:option value="-20">개인소장</form:option>
						<form:option value="-90">관리취소</form:option>
					</form:select>
				</td>
				<td rowspan="14" style="text-align:left; vertical-align: auto;">
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
							<c:forEach items="${bookDreamHistory}" var="i" varStatus="status">
							<tr>
								<td><fmt:formatDate value="${i.rh_created}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>${i.rh_type eq 'insert' ? '등록':'수정' }</td>
								<td>${i.r_state_nm}</td>
								<td>${i.rh_ip}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>신청도서</td>
				<td class="left">${bookDreamOne.r_title}</td>
			</tr>
			<tr>
				<td>저자</td>
				<td class="left">${bookDreamOne.r_author}</td>
			</tr>
			<tr>
				<td>가격</td>
				<td class="left"><fmt:formatNumber value="${bookDreamOne.r_price}" pattern="#,###"/> </td>
			</tr>
			<tr>
				<td>도서관</td>
				<td class="left">
					<c:choose>
						<c:when test="${bookDreamOne.r_src eq 'andong'}">안동도서관</c:when>
						<c:when test="${bookDreamOne.r_src eq 'yongsang'}">용상분관</c:when>
						<c:when test="${bookDreamOne.r_src eq 'pungsan'}">풍산분관</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>서점</td>
				<td class="left">${bookDreamOne.storeCode}</td>
			</tr>
			<tr>
				<td>신청일자</td>
				<td class="left"><fmt:formatDate value="${bookDreamOne.r_created}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>구매일자</td>
				<td class="left"><fmt:formatDate value="${bookDreamOne.r_payed}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td>반납일자</td>
				<td class="left">
					<fmt:formatDate value="${bookDreamOne.r_return}" pattern="yyyy-MM-dd"/>
<!-- 					2017-02-24 11:57:15					(마감 : 지정안됨) -->
				</td>
			</tr>
			<tr>
				<td>신청자</td>
				<td class="left">${bookDreamOne.r_name}</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td class="left">
					<form:input path="r_hp" cssClass="text" value="${bookDreamOne.r_hp}"/>
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td class="left">
					<form:input path="r_email" cssClass="text" value="${bookDreamOne.r_email}"/>
				</td>
			</tr>
			<tr>
				<td>집전화</td>
				<td class="left">${bookDreamOne.r_tel}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td class="left">
					[${bookDreamOne.r_zip}]<br />
					 ${bookDreamOne.r_addr}				
				</td>
			</tr>
		</tbody>
	
	</table>

<!-- 	<div class="btn_menu center"> -->
<!-- 		<button type="submit" class="btn btn1 btn-primary btn-large btnWrite"><span>저장</span></button> -->
<!-- 		<a class="btn btn-large" href="/book/admin/request/list.php">목록</a> -->
<!-- 	</div> -->

</form:form>